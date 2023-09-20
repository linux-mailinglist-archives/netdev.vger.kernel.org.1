Return-Path: <netdev+bounces-35282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7A37A899B
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 18:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 361D2281F92
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 16:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994F93E467;
	Wed, 20 Sep 2023 16:36:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E0C79EE
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 16:36:31 +0000 (UTC)
X-Greylist: delayed 445 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 20 Sep 2023 09:36:28 PDT
Received: from dehost.average.org (dehost.average.org [88.198.2.197])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647EAD6
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 09:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=average.org; s=mail;
	t=1695227341; bh=TTABL0Uj5TilnSI5TNH6cqmG0gtzVaQbjvzZ2deZBiA=;
	h=Date:To:From:Subject:Cc:From;
	b=rRXq8jh6WxWE74/IPF8W6jTauTTdzP6DV0zJwFi3NYHpL1SCvIDb9XDvtOZfan4fr
	 02Yt0/ygA9VbH7C5wb6AyQfOMOEjPmOILdPr9AuJ0+eqnNSOAK8lEaiRcU+imQF4+f
	 b20mX2eY+08PaHmFSFDsX6ZqJJ9XR6HeJ0WQirGk=
Received: from [10.16.126.80] (unknown [212.227.34.98])
	by dehost.average.org (Postfix) with ESMTPSA id A941C41D5B72;
	Wed, 20 Sep 2023 18:29:01 +0200 (CEST)
Message-ID: <8c7e44d2-e78f-4f8d-9016-2a4b8429e14d@average.org>
Date: Wed, 20 Sep 2023 18:28:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: netdev@vger.kernel.org, Florian Westphal <fw@strlen.de>
Content-Language: en-GB, ru-RU
From: Eugene Crosser <crosser@average.org>
Subject: conntrack: TCP CLOSE and TIME_WAIT are not counted towards per-zone
 limit, and can overflow global table
Autocrypt: addr=crosser@average.org; keydata=
 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
 910NT4BM9Q==
Cc: Yi-Hung Wei <yihung.wei@gmail.com>,
 Martin Bene <martin.bene@icomedias.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------MX9uTMXWgCMmFpVb1y07z0XD"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------MX9uTMXWgCMmFpVb1y07z0XD
Content-Type: multipart/mixed; boundary="------------hCVhCFD7F2LP7jYwUd1QIDch";
 protected-headers="v1"
From: Eugene Crosser <crosser@average.org>
To: netdev@vger.kernel.org, Florian Westphal <fw@strlen.de>
Cc: Yi-Hung Wei <yihung.wei@gmail.com>,
 Martin Bene <martin.bene@icomedias.com>
Message-ID: <8c7e44d2-e78f-4f8d-9016-2a4b8429e14d@average.org>
Subject: conntrack: TCP CLOSE and TIME_WAIT are not counted towards per-zone
 limit, and can overflow global table

--------------hCVhCFD7F2LP7jYwUd1QIDch
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello,

we are running a virtualization platform, and assign different conntrack
zones, with per-zone limits, to different users. The goal is to prevent
situation when one user exhaust the whole conntrack table on the host,
e.g. if the user is under some DDoS scenario.

We noticed that under some flooding scenarios, the number of entries in
the zone assigned to the user goes way above the per-zone limit, and
reaches the global host limit. In our test, almost all of those entries
were in "CLOSE" state.

It looks like this function in net/filter/nf_conncount.c:71

static inline bool already_closed(const struct nf_conn *conn)
{
	if (nf_ct_protonum(conn) =3D=3D IPPROTO_TCP)
		return conn->proto.tcp.state =3D=3D TCP_CONNTRACK_TIME_WAIT ||
		       conn->proto.tcp.state =3D=3D TCP_CONNTRACK_CLOSE;
	else
		return false;
}

is used to explicitly exclude such entries from counting.

As I understand, this creates a situation when an attacker can inflict a
DoS situation on the host, by opening _and immediately closing_ a large
number of TCP connections. That is to say, per-zone limits, as currently
implemented, _do not_ allow to prevent overflow of the host-wide
conntrack table.

What was the reason to exclude such entries from counting?
Should this exception be removed, and _all_ entries in the zone counted
towards the limit?

Thanks

Eugene

--------------hCVhCFD7F2LP7jYwUd1QIDch--

--------------MX9uTMXWgCMmFpVb1y07z0XD
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEnAziRJw3ydIzIkaHfKQHw5GdRYwFAmULHcgACgkQfKQHw5Gd
RYymOggAhVtf9AgGm/RNzjzaoJqDgZ95amN6Qwu4+1idHE8lKX0FzFFXddCLk1ew
v9E5wKmYeSb453jspY9ty+yVazRcze8ZHisOADDMjgzzoy22pfMXzQ2WpgZqq7N4
dNDM49TAAyLtDZaKn6eS3HFNL6qzEr2LIR2KAWaFuT6zBSh3tqSHd4gcYny3Jv9s
owL259n1yMgPBSFO4RjXnb/8SW5QVfRHwU71aDNvtyPHdv/k4pUSIGCtNFQw6Dv1
Beyd1W88WGjEDExEnLVeNxJvLXomqDrcSv7824S8sRVd8pEC4dm3X1d5ShjKNCCS
8tlG6+t8zra7cx1G/ZM3sXuZZ15L/g==
=TZIY
-----END PGP SIGNATURE-----

--------------MX9uTMXWgCMmFpVb1y07z0XD--

