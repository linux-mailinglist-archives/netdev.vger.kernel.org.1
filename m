Return-Path: <netdev+bounces-275601-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADyzH2q602lDlAcAu9opvQ
	(envelope-from <netdev+bounces-275601-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 15:51:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE41B3A3B4A
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 15:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B0B783017FA3
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 13:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 189C7224B15;
	Mon,  6 Apr 2026 13:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="OxGEO5ni"
X-Original-To: netdev@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AC3175A9E
	for <netdev@vger.kernel.org>; Mon,  6 Apr 2026 13:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775483452; cv=none; b=VSoqTcRdxw+i59GSHZUhTnpexnPhcgfPN94d+QNqSE3Bfw+ycogq37Q7ThjlPY8E9Q+YcYKr9pKPrRElWjeZ0lhKTGfzzJSQiy+dT6iGSoKBYkLw7uDVvqmT8uznYFsRRCnmFYPltUKFZkZ8BBhyRwqvr0gz/Ye7l2AgLQ1BRnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775483452; c=relaxed/simple;
	bh=TuqfqOrCiWPshspPG/BpZpHeaCg3nPNb0BD+QrR5kWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QWGkOCednebQO6xXKwyjw8tWV7dsbO9s277ERJoQRy6Z/QAGitknpEg0uMM/bdWSnMFlJWR0oWZSb7gi5474+Hil0xzYqd/nZdoUB4O9cFt02gMzSpwWE6G4XbbklgrOE35Z85M5K2y3CplUU3R5wrEIQ9W3xA1aL1LQ/qUKMZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=OxGEO5ni; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Received: by dvalin.narfation.org (Postfix) id E18A320EDE;
	Mon, 06 Apr 2026 13:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1775483441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iRR+ID16DnxnNiho6gkKFAiloy6TB7CgO30hWezRnb4=;
	b=OxGEO5niePgkHVCRAJkUYE1s3aLeyd6sDJCpSYwEP6xEN0J+6q1kOOe1R4odwdTaQweuW1
	KTTrThG0GAYffUV4Drr7PlnAuPDgdfehpWPv7hCGs5uZ7pe5Yoq8/KsZ2v5Du/7jq/tr+v
	wqLWjZTH9VDOMzrUADyS96pJnIsBbL4=
From: Sven Eckelmann <sven@narfation.org>
To: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org,
 Ao Zhou <n05ec@lzu.edu.cn>
Cc: Marek Lindner <marek.lindner@mailbox.org>,
 Simon Wunderlich <sw@simonwunderlich.de>,
 Antonio Quartulli <antonio@mandelbit.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Yifan Wu <yifanwucs@gmail.com>, Juefei Pu <tomapufckgml@gmail.com>,
 Yuan Tan <yuantan098@gmail.com>, Xin Liu <bird@lzu.edu.cn>,
 Ao Zhou <n05ec@lzu.edu.cn>, Haoze Xie <royenheart@gmail.com>
Subject:
 Re: [PATCH net 1/1] batman-adv: hold claim backbone gateways by reference
Date: Mon, 06 Apr 2026 15:50:37 +0200
Message-ID: <6721686.DvuYhMxLoT@sven-desktop>
In-Reply-To:
 <4a58d2daef70ac17bb9be1f244a182439d5c4d63.1775301426.git.royenheart@gmail.com>
References:
 <cover.1775301426.git.royenheart@gmail.com>
 <4a58d2daef70ac17bb9be1f244a182439d5c4d63.1775301426.git.royenheart@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6995330.lOV4Wx5bFT";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[narfation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[narfation.org:s=20121];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275601-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[mailbox.org,simonwunderlich.de,mandelbit.com,davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,gmail.com,lzu.edu.cn];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sven@narfation.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[narfation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lzu.edu.cn:email,open-mesh.org:url]
X-Rspamd-Queue-Id: EE41B3A3B4A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--nextPart6995330.lOV4Wx5bFT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Mon, 06 Apr 2026 15:50:37 +0200
Message-ID: <6721686.DvuYhMxLoT@sven-desktop>
MIME-Version: 1.0

On Monday, 6 April 2026 15:17:28 CEST Ao Zhou wrote:
> From: Haoze Xie <royenheart@gmail.com>
> 
> batadv_bla_add_claim() can replace claim->backbone_gw and drop the old
> gateway's last reference while readers still follow the pointer.
> 
> The netlink claim dump path dereferences claim->backbone_gw->orig and
> takes claim->backbone_gw->crc_lock without pinning the underlying
> backbone gateway. batadv_bla_check_claim() still has the same naked
> pointer access pattern.
> 
> Reuse batadv_bla_claim_get_backbone_gw() in both readers so they operate
> on a stable gateway reference until the read-side work is complete.
> This keeps the dump and claim-check paths aligned with the lifetime
> rules introduced for the other BLA claim readers.
> 
> Fixes: 23721387c409 ("batman-adv: add basic bridge loop avoidance code")
> Fixes: 04f3f5bf1883 ("batman-adv: add B.A.T.M.A.N. Dump BLA claims via netlink")
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Co-developed-by: Yuan Tan <yuantan098@gmail.com>
> Signed-off-by: Yuan Tan <yuantan098@gmail.com>
> Suggested-by: Xin Liu <bird@lzu.edu.cn>
> Signed-off-by: Haoze Xie <royenheart@gmail.com>
> Signed-off-by: Ao Zhou <n05ec@lzu.edu.cn>
> ---
>  net/batman-adv/bridge_loop_avoidance.c | 27 +++++++++++++++++---------
>  1 file changed, 18 insertions(+), 9 deletions(-)

Applied, thanks!

[1/1] batman-adv: hold claim backbone gateways by reference
      https://git.open-mesh.org/linux-merge.git/commit/?h=batadv/net&id=82d8701b2c930d0e96b0dbc9115a218d791cb0d2

Best regards,
---
Sven
--nextPart6995330.lOV4Wx5bFT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCadO6LQAKCRBND3cr0xT1
y26iAQCjQv+PeIhpfRpwFpDi1Zektlh+3ZpKeTsIhBbRNXUa2QD/fvkRpCmUVrPR
ILSBN6mBEL93oFdBwIh3VqNG9kzmPQ4=
=GnOB
-----END PGP SIGNATURE-----

--nextPart6995330.lOV4Wx5bFT--




