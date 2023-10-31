Return-Path: <netdev+bounces-45403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7397DCB34
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 11:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22FA6B20DAD
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 10:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812AF12E64;
	Tue, 31 Oct 2023 10:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9BF2105
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 10:55:37 +0000 (UTC)
X-Greylist: delayed 562 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 31 Oct 2023 03:55:35 PDT
Received: from relay.sandelman.ca (relay.cooperix.net [IPv6:2a01:7e00:e000:2bb::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF20A1
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 03:55:35 -0700 (PDT)
Received: from dyas.sandelman.ca (unknown [5.148.108.163])
	by relay.sandelman.ca (Postfix) with ESMTPS id 2317120B51;
	Tue, 31 Oct 2023 10:46:11 +0000 (UTC)
Received: by dyas.sandelman.ca (Postfix, from userid 1000)
	id 589BCA1482; Tue, 31 Oct 2023 03:59:57 -0400 (EDT)
Received: from dyas (localhost [127.0.0.1])
	by dyas.sandelman.ca (Postfix) with ESMTP id 565CEA1467;
	Tue, 31 Oct 2023 03:59:57 -0400 (EDT)
From: Michael Richardson <mcr@sandelman.ca>
To: Antony Antony <antony@phenome.org>
cc: antony.antony@secunet.com, Herbert Xu <herbert@gondor.apana.org.au>,
    netdev@vger.kernel.org, devel@linux-ipsec.org,
    Jakub Kicinski <kuba@kernel.org>,
    "David S. Miller" <davem@davemloft.net>
Subject: Re: [devel-ipsec] [PATCH v2 ipsec-next 2/2] xfrm: fix source address in icmp error generation from IPsec gateway
In-reply-to: <ZT4zUnhvbW2VZlRm@Antony2201.local>
References: <e9b8e0f951662162cc761ee5473be7a3f54183a7.1639872656.git.antony.antony@secunet.com> <300c36a0644b63228cee8d0a74be0e1e81d0fe98.1698394516.git.antony.antony@secunet.com> <16810.1698413407@localhost> <ZT4zUnhvbW2VZlRm@Antony2201.local>
Comments: In-reply-to Antony Antony <antony@phenome.org>
   message dated "Sun, 29 Oct 2023 11:26:26 +0100."
X-Mailer: MH-E 8.6+git; nmh 1.7+dev; GNU Emacs 26.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Tue, 31 Oct 2023 03:59:57 -0400
Message-ID: <3211020.1698739197@dyas>

--=-=-=
Content-Type: text/plain


Antony Antony <antony@phenome.org> wrote:
    > On Fri, Oct 27, 2023 at 09:30:07AM -0400, Michael Richardson via Devel
    > wrote:
    >>
    >> Antony Antony via Devel <devel@linux-ipsec.org> wrote: > When enabling
    >> support for xfrm lookup using reverse ICMP payload, > We have
    >> identified an issue where the source address of the IPv4 e.g >
    >> "Destination Host Unreachable" message is incorrect. The IPv6 appear >
    >> to do the right thing.
    >>
    >> One thing that operators of routers with a multitude of interfaces
    >> want to do is send all ICMP messages from a specific IP address.
    >> Often the public address, that has the sane reverse DNS name.

    > While it makes sense for routers with multiple interfaces, receiving
    > ICMP errors from private addresses can be confusing. However, wouldn't
    > this also make it more challenging to adhere to BCP 32 and BCP 38?
    > Routing with multiple interfaces is tricky on Linux, especially when it
    > comes to compliance with these BCPs.

Yes, that's why sending from a public, topically significant source address
is really important.  Yet, many links are numbered in 1918 because..

    > I wonder if a netfilter rule would be a solution for you, something
    > like:

    > I would love see a simple option instead of a SNAT hack. May be a
    > routing rule that will choose sourse address for ICMP error code.

yeah, I really don't want to do SNAT stuff.
I'd like to have a flag on each interface that says to use the "global" ICMP
source or use the heuristic we have now.  And then we need a way to set that
source address.  Most routing platforms put a /32 address (and /128) on lo
(or a dummy) as the device's reachable address, and then spread that through
OSPF.







--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEEow/1qDVgAbWL2zxYcAKuwszYgEMFAmVAs/0ACgkQcAKuwszY
gENa2wv/aY1nMGVyYMwwjHqVMgwTTqYbr+qQ8+jjQOsJ1h5cW3gNsL0rN5gsJhbk
jPujWpO+hbkfM+h9THGKFdkXoNv/v5qZLI3hb2IrqLgtAohS5paH9/d4QVi0pVzy
AekvhDe7fce6ilxq6rVxwBpN/9DeGBvkssyFMPJFzfb41h461wCZ58PUURqwbwzS
2oXw4GdWGH7rRrIkM5nI+zsnIeWpkxCBkF4otPLlQUnA3UYhFeaPKlh4LElmuWou
YsR70pKg0v4CltGRx7wqawKS0zTs61WE5b7n4SKvTK/e7X1wkBE0KxCbdS8xRRYx
3rO5N7Kh82bvbITZpR/o4staseN6ux4vhkqOqpsDB8d/NxIAo1ncJO/IKV6bQ8hV
fV5NVrzx4dMlk+fK2He61vTxwjuwbAGGjF1Y4aIcqAwtuRBSET4WqGTqAwEmFv6X
vKnzvQmKMml7h17XoyLDs32iPHWi4q7tfAE/+Q50dN+Kuh1wARK+RGPHO+c67gvV
2Hq8dWFa
=iYXI
-----END PGP SIGNATURE-----
--=-=-=--

