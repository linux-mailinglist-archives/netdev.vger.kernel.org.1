Return-Path: <netdev+bounces-45058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D38767DABFA
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 11:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 465BDB20D8A
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 10:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184C06104;
	Sun, 29 Oct 2023 10:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="ReP8Qjzf"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C06B20EB
	for <netdev@vger.kernel.org>; Sun, 29 Oct 2023 10:26:33 +0000 (UTC)
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B63FC1
	for <netdev@vger.kernel.org>; Sun, 29 Oct 2023 03:26:31 -0700 (PDT)
X-KPN-MessageId: 989e70bd-7645-11ee-a148-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 989e70bd-7645-11ee-a148-005056abad63;
	Sun, 29 Oct 2023 11:26:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kpnmail.nl; s=kpnmail01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=Ene+KD+OLY/eF4wbQbbYp0cyIG+loB+quOJN3C+dwK0=;
	b=ReP8Qjzfn8smapjWLmHSUwoVIiUHPMozQsPleN76sKHNRhl8sh7vMDoSk7XUhYM1d+wBay3i7fuVr
	 tsHeCx2KhKI6Iw6l7AQGoY8JuqgneeRceRjwSJ84NVLNugDmi9TJ9+6ru5UbcckV58YTCCq0OXPkOr
	 vg1L/bPQrjdPoZ4k=
X-KPN-MID: 33|X/UREv6pLOSLpGAsa0QuE8Fcd1E8Ysarx47/xy9e4CJgoOXSQqm9dCFJ4NYInd4
 RIpnIVfB+w76NZmW8DXTsam3xb3Ep3PBudCj+1MxB3/M=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|nR+/AQAecFAhplUamEwsfUN0OYR6GaeGXTxfCiiYSWLFF+Kx4choAQ98qAG9wR4
 lSyTT1jV7pou92gtU311sBA==
X-Originating-IP: 213.10.186.43
Received: from Antony2201.local (213-10-186-43.fixed.kpn.net [213.10.186.43])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 9dd10230-7645-11ee-a7ab-005056ab7447;
	Sun, 29 Oct 2023 11:26:28 +0100 (CET)
Date: Sun, 29 Oct 2023 11:26:26 +0100
From: Antony Antony <antony@phenome.org>
To: Michael Richardson <mcr@sandelman.ca>
Cc: antony.antony@secunet.com, Herbert Xu <herbert@gondor.apana.org.au>,
	netdev@vger.kernel.org, devel@linux-ipsec.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [devel-ipsec] [PATCH v2 ipsec-next 2/2] xfrm: fix source address
 in icmp error generation from IPsec gateway
Message-ID: <ZT4zUnhvbW2VZlRm@Antony2201.local>
References: <e9b8e0f951662162cc761ee5473be7a3f54183a7.1639872656.git.antony.antony@secunet.com>
 <300c36a0644b63228cee8d0a74be0e1e81d0fe98.1698394516.git.antony.antony@secunet.com>
 <16810.1698413407@localhost>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16810.1698413407@localhost>

On Fri, Oct 27, 2023 at 09:30:07AM -0400, Michael Richardson via Devel wrote:
> 
> Antony Antony via Devel <devel@linux-ipsec.org> wrote:
>     > When enabling support for xfrm lookup using reverse ICMP payload,
>     > We have identified an issue where the source address of the IPv4 e.g
>     > "Destination Host Unreachable" message is incorrect. The IPv6 appear
>     > to do the right thing.
> 
> One thing that operators of routers with a multitude of interfaces want to do
> is send all ICMP messages from a specific IP address.  Often the public
> address, that has the sane reverse DNS name.

While it makes sense for routers with multiple interfaces, receiving ICMP 
errors from private addresses can be confusing. However, wouldn't this also 
make it more challenging to adhere to BCP 32 and BCP 38? Routing with 
multiple interfaces is tricky on Linux, especially when it comes to 
compliance with these BCPs.

> AFAIK, this is not an option on Linux, but Cisco/Juniper/etc. devices usually
> can do this.  I can't recall how today. (I was actually looking that up this week)

I wonder if a netfilter rule would be a solution for you, something like:

"ip protocol icmp type <error codes> snat to x.x.x.x"

I would love see a simple option instead of a SNAT hack. May be a routing 
rule that will choose sourse address for ICMP error code.

> This can conflict however, with the need to get the result back into the
> tunnel.  I don't have a good answer, except that we probably need a fair bit

Forwarding that ICMP packet, which is not covered by your forward IPsec 
policy, would be fixed with the second patch in this series. In that case 
lookup would using the orginal packet as describe in RFC 4301, Section 6.

-antony

