Return-Path: <netdev+bounces-284200-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qFIWHC12+WmT8wIAu9opvQ
	(envelope-from <netdev+bounces-284200-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 06:46:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3964C6913
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 06:46:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 577C130093AF
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 04:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEC33B27DC;
	Tue,  5 May 2026 04:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="YzV3P21e"
X-Original-To: netdev@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B572C392C28;
	Tue,  5 May 2026 04:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777956388; cv=none; b=tg7YPe1zQ4jywmV1i3JT3ScghgD9xb7Xfj82t7Gv1E7hmYGqNdGUSgEiuccyzbhEMb2UEbzGWtvfQOms9Ejm9ADIWn8jREU7FnM0TQa8tk8eYk0BskPsV5oxUT02d5jfwSmz70S4o4i0ZQO3/g0V67JbSPP7fR5iLHwYSVb5VP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777956388; c=relaxed/simple;
	bh=Q4JxA29skf0GIQSLZ8ul5/f8J9TVzHjReQZqn3sXZTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jwOREHMi0hYlOQdAxaUOxyE2a4zHwu5YUQGNfCQIE7r62CXUnTMQXzjDFlvbwuRUFfxM28QArtpKgfUmzeKPNbamYGRk1ZNTPY3wbzJbi9e9mF3IvesYqZ5L5qCC1G9rI+ju2r1BalIuQJbFQn5kBr61gtNOyk3EbhA0Kx0S6WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=YzV3P21e; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Received: by dvalin.narfation.org (Postfix) id B2E581FF78;
	Tue, 05 May 2026 04:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1777956384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lq6R9rd8X8jTXmZ6W1O/me6//zs6LOkcxvOUChwvpvw=;
	b=YzV3P21eoDduZjvYFi0AM/ra7GXV2nL0o9zDwbJ3Kf5/T7DyxoTghKEAsmG6i/YBr0okZA
	Mez7utpOKU+kOVcERyy6N506CIzLvD5n4euF8FkHFy78T1arp0V++P3Xcu3sOxkqDb+1R7
	2ayjrGbRh+CBLVXFdagVe2eh3/uH0m8=
From: Sven Eckelmann <sven@narfation.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Marek Lindner <marek.lindner@mailbox.org>,
 Simon Wunderlich <sw@simonwunderlich.de>,
 Antonio Quartulli <antonio@mandelbit.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Ao Zhou <n05ec@lzu.edu.cn>,
 Haoze Xie <royenheart@gmail.com>, Jiexun Wang <wangjiexun2025@gmail.com>,
 Juefei Pu <tomapufckgml@gmail.com>, Luxing Yin <tr0jan@lzu.edu.cn>,
 Ruide Cao <caoruide123@gmail.com>, Xin Liu <bird@lzu.edu.cn>,
 Yifan Wu <yifanwucs@gmail.com>, Yuan Tan <yuantan098@gmail.com>,
 stable@kernel.org
Subject: Re: [PATCH batadv 0/8] batman-adv: follow up fixes
Date: Tue, 05 May 2026 06:46:11 +0200
Message-ID: <5990011.DvuYhMxLoT@sven-l14>
In-Reply-To: <20260504171051.2b3e47ef@kernel.org>
References:
 <20260503-fixes-followup-v1-0-4313278918d3@narfation.org>
 <20260504171051.2b3e47ef@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6264035.lOV4Wx5bFT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Rspamd-Queue-Id: 7F3964C6913
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[narfation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[narfation.org:s=20121];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284200-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FREEMAIL_CC(0.00)[mailbox.org,simonwunderlich.de,mandelbit.com,davemloft.net,google.com,redhat.com,kernel.org,lists.open-mesh.org,vger.kernel.org,lzu.edu.cn,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sven@narfation.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[narfation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,narfation.org:dkim]

--nextPart6264035.lOV4Wx5bFT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
To: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH batadv 0/8] batman-adv: follow up fixes
Date: Tue, 05 May 2026 06:46:11 +0200
Message-ID: <5990011.DvuYhMxLoT@sven-l14>
In-Reply-To: <20260504171051.2b3e47ef@kernel.org>
MIME-Version: 1.0

On Tuesday, 5 May 2026 02:10:51 CEST Jakub Kicinski wrote:
> On Sun, 03 May 2026 14:22:33 +0200 Sven Eckelmann wrote:
> > While reviewing the fixes submitted to batman-adv in the recent weeks,
> > further problems in similar or adjecent code was identified. This was either
> > noticed in the manual review or reported by sashiko.dev.
> 
> Are you CCing netdev to get this reviewed by Sashiko?
> Please don't..
> We delegate code to sub-sub-systems to lower the patch volume :(
> 

Because of `b4 prep --auto-to-cc`. Will now manually remove you.

Regards,
	Sven

--nextPart6264035.lOV4Wx5bFT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCafl2FAAKCRBND3cr0xT1
y7meAP46UTEv5pX9jnioel/mvqL1JOLHs7Mw9LA1N0MojSw4rAD+ImjhYl7DEAgI
5WdexqiK2V/tFuzPyqNBbcYevZJK7wc=
=U/YX
-----END PGP SIGNATURE-----

--nextPart6264035.lOV4Wx5bFT--




