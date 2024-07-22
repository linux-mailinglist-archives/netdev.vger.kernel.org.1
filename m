Return-Path: <netdev+bounces-112355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D70F93878F
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 04:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2658E1F2128B
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 02:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BEE6D53F;
	Mon, 22 Jul 2024 02:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandelman.ca header.i=@sandelman.ca header.b="V1lgt3jw"
X-Original-To: netdev@vger.kernel.org
Received: from relay.sandelman.ca (relay.cooperix.net [176.58.120.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA2F748F
	for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 02:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.58.120.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721616284; cv=none; b=mxdSE/vEMo4RqQgKtkm3oq1FYh5Wt2LMwmS/RAYGO1bE4U8DhKQcl872EJQsAJKx7DtpjimMGqfHL75rYn40gjZbvjxXdpj/suPeU21PJHueBs+ggNNh2jncv49ruYwisYi+0h8znfwKQ2OM1kkfQF32s1rv9gov9JOhT+s/dgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721616284; c=relaxed/simple;
	bh=I/nwBnIoCcA1Iw3GATduwc2FvnBNNLRBBnZsWM8vX8w=;
	h=From:To:cc:Subject:In-reply-to:References:MIME-Version:
	 Content-Type:Date:Message-ID; b=auJI1XK0GHw0an077+4iMM9vUwL9rs52nLOevBpfMti4lqAl8bQ3dirP7gNayho1+rKAx6aj9jSTU1C9Ue7voYj0zES5LYbWzoJaJcZWSi6JxgfvghVtmr5Jicl8IrCunWzngxQwFRq4Efdxgt+TRcM4Do30HczCDGMv8hm38Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandelman.ca; spf=pass smtp.mailfrom=sandelman.ca; dkim=pass (2048-bit key) header.d=sandelman.ca header.i=@sandelman.ca header.b=V1lgt3jw; arc=none smtp.client-ip=176.58.120.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandelman.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandelman.ca
Authentication-Results: relay.sandelman.ca;
	dkim=pass (2048-bit key; secure) header.d=sandelman.ca header.i=@sandelman.ca header.a=rsa-sha256 header.s=dyas header.b=V1lgt3jw;
	dkim-atps=neutral
Received: from dyas.sandelman.ca (unknown [IPv6:2001:67c:370:128:dde6:75b0:1cee:9a2d])
	by relay.sandelman.ca (Postfix) with ESMTPS id 882E91F4A3;
	Mon, 22 Jul 2024 02:37:11 +0000 (UTC)
Received: by dyas.sandelman.ca (Postfix, from userid 1000)
	id B0771A1D27; Sun, 21 Jul 2024 19:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=sandelman.ca; s=dyas;
	t=1721615874; bh=I/nwBnIoCcA1Iw3GATduwc2FvnBNNLRBBnZsWM8vX8w=;
	h=From:To:cc:Subject:In-reply-to:References:Date:From;
	b=V1lgt3jwfB5sm7wbusYkEnkfiOQ/inDo643QG0l/EAryLPxAKQrXOH45XY+rngiQa
	 Y9X4E8SNHCY3ANgG6tt9d/tFVK1gjVrrPbIvm9Qg9nsIWn0UhTuFvVBAlzl+VkVf+t
	 HeN33i/YfOlmBbw063WaOOiEI0dpieBjONQbhCbXdHcGq/tfLWuCpa70T9mBZSsgbz
	 5ISgMWPp52wY7q5ybD1izj5XY8dCFcCBivLhnZeK+f0B6btNxVQYQH2hyjJXDZ9nBn
	 nk6ZjOGB79z6i6LIDYKg9/lzLM+03xWEz/RDuSM3Y0J8Cp6iDpBSGoYgyeWESo+hAn
	 7gvJHRC5RAzYA==
Received: from dyas (localhost [127.0.0.1])
	by dyas.sandelman.ca (Postfix) with ESMTP id AE462A0115;
	Sun, 21 Jul 2024 19:37:54 -0700 (PDT)
From: Michael Richardson <mcr@sandelman.ca>
To: Christian Hopps <chopps@chopps.org>
cc: netdev@vger.kernel.org, chopps@labn.net, devel@linux-ipsec.org
Subject: Re: [devel-ipsec] xfrm/ipsec/iptfs and some new sysctls
In-reply-to: <m2bk2rx2lb.fsf@dhcp-8377.meeting.ietf.org>
References: <m2bk2rx2lb.fsf@dhcp-8377.meeting.ietf.org>
Comments: In-reply-to Christian Hopps via Devel <devel@linux-ipsec.org>
   message dated "Sat, 20 Jul 2024 12:27:38 -0700."
X-Mailer: MH-E 8.6+git; nmh 1.7+dev; GNU Emacs 26.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="==-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Sun, 21 Jul 2024 19:37:54 -0700
Message-ID: <593029.1721615874@dyas>

--==-=-=
Content-Type: multipart/mixed; boundary="=-=-="

--=-=-=
Content-Type: text/plain


I think that:
xfrm_iptfs_reorder_window
and
xfrm_iptfs_drop_time
are parameters about receiving.

While
xfrm_iptfs_init_delay
and
xfrm_iptfs_max_qsize

are parameters about sender stuff.. I think the names should include that
indication.   "xfrm_iptfs_sender_init_delay" maybe.
1M byte default for max_qsize feels big, it's 1000 x 1K packets.
I realize that isn't a lot at 10Gb/s+.   I dunno.

How do you plan to get feedback on whether the defaults are working?


--=-=-=
Content-Type: text/plain
Content-Disposition: inline
Content-Description: Signature

--
]               Never tell me the odds!                 | ipv6 mesh networks [
]   Michael Richardson, Sandelman Software Works        | network architect  [
]     mcr@sandelman.ca  http://www.sandelman.ca/        |   ruby on rails    [



--=-=-=--

--==-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEERK+9HEcJHTJ9UqTMlUzhVv38QpAFAmadxgIACgkQlUzhVv38
QpDLUwf/WPnqoHUNyRMl4vhkyQD3cvk0KBCS8fBl1eZE0SIwFL5OSVOAj9Gnh2Ib
qWhb04U1HTBtBUGM2W4/YDhUuuXDOnkPxT28AXof82fhGQAv4x+jOqwUIalKpx0a
34fdhLX3PKMTwKGDSmzx9hY9/fpvDoCAqLX2Me9gQOAQXJDvEi4ltVfgQtUmglb1
J0Af0MLUv/EPIPslAmlRvRpiKqOCLVcbACmxYntlk5vHpe+qyzvCjFtbMqW1+tr0
tlvbQOjBn7P01yh/1XMStZMW9SRrcnd7mel+TREKBDICvUNYhvueWfn/kENa7qSE
9KA+GrQ3YHjYFti1AFxjcyGAXd2B3w==
=iF/o
-----END PGP SIGNATURE-----
--==-=-=--

