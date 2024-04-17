Return-Path: <netdev+bounces-88816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E6A8A8983
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 18:59:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5B9C1C23807
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 16:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6BC171670;
	Wed, 17 Apr 2024 16:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sTmJsoAq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96B7171667
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 16:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713373082; cv=none; b=FaS9aKYLBBPvgTFLIXiid/DoxPmjUEQ47KCO34KA8BrA3R1lAuKvyaCmfd7JwAcuXIZHcOAIF2GssA+momiT9WBY0PYEX9bW5CAPiDZRw9ddm4lLsPJg1Nd9nOoblinvEgdxV+t7wZLyiAiKQTmiWhLgJuuVLbITJdDRYxsjIhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713373082; c=relaxed/simple;
	bh=DrlNDSy3+s1STa9+cKOwIzy5XOiKyi3sfi5Nz7PQ98s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Lm6Ra02paHApo68BxYUT9pgfZS4TRL0Cw853qPKYR+rvLGoaW31AeNVK7s4xtueJH+d0Mz2SgUUbymvBM+BzRKTHqrKQKr5AXQzxyidsDeprIn9HApMnSwfXXIjb5I4ZZqj7y4xuj/CWPoWAu9dvrsgNHYdIFVEg8KYVmi7CRf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sTmJsoAq; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b269686aso8248335276.1
        for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 09:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713373080; x=1713977880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=39SES1xI7t7XpswHO/i5Yy26SxvrbXiOwaJYlGSFJHo=;
        b=sTmJsoAqUsOCr1co0Tk8N9vW1iKp1SywVezjCP3dh2vk7JLj6M6VVIGeTrJ/4bkLEZ
         Ix6z+XrqFgSAIxq4iOf07QLUJ7Ov8SMIH2Og4wVnva9ZaRmignT2VJKp/ZbsQebelCSy
         8d4WJ1mMD9BlH2YWjcyYxxJZWo8lm2uKrcC+ur+kIIIH6Ig1Sxp4MIOSY9oBl4Q95ZMg
         5dC6tI/2uqZCZK5aumQo/SFJDwjK284+gPRqj2CpkfYFiYMbsDBfyAvQ2T0AdNBISSS1
         GUy0uZ+NRsZq4wjzN3AC9QMMfBom9I+03GT1ctf5Uuq42MKOQwKiH+Ggouk63dyIuCxT
         8eQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713373080; x=1713977880;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=39SES1xI7t7XpswHO/i5Yy26SxvrbXiOwaJYlGSFJHo=;
        b=YjSNQPmeImYyOzArOmmgdT/xRkgA/gfhJhGEBYmFNqH7Ges4fsJWmK/yyciAlXt/g7
         YXu6cprIrqNJuLUob/xA7UfuOVFlSao1Fr5QbH+gQPaQGq2j3TDHu9oqjKATTd5N07FL
         9AkZ4e94LFm8B/M/1AYGQNm+SI8OOoWa69lLseWssLbassDpDRJw8Jp3Trc77GXhwk5Y
         2bzoan1+rc6uBWOWZlYj79QU6qcpJjnoK19s06o/RZr0Xj0jw2HLzPmUHrWA8RYlbSTh
         7dJM3CWDntHJVEe3fBwZN5koQVV+5n2HeLIiJTNdUolh7Twqjk5eWQedWkQEcSqpGNiE
         jAEg==
X-Gm-Message-State: AOJu0Yx+XQcPgCB2T7TrAB8z5avd8lNPG4pe75zuadNOxLCMgp9drBE4
	AqvHGyUMFXCRl8hkbbEXnBK8BTzdHJx1B9RpwWRrdo6XmB1lz9fXi4nbSzw3V73+Si4fxyMTutH
	hHbQ+uiOxIQ==
X-Google-Smtp-Source: AGHT+IHzl2YEfeLQ1dJ6yvhTKl8t5nQ9FBNDRFAg1i9UMp40Ehn2ti/eBrKJDtOrU4K3C83yw34gAnB2CETSEg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:ac4c:0:b0:dcd:c091:e86 with SMTP id
 r12-20020a25ac4c000000b00dcdc0910e86mr1190935ybd.13.1713373079814; Wed, 17
 Apr 2024 09:57:59 -0700 (PDT)
Date: Wed, 17 Apr 2024 16:57:55 +0000
In-Reply-To: <20240417165756.2531620-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240417165756.2531620-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240417165756.2531620-2-edumazet@google.com>
Subject: [PATCH net-next 1/2] tcp: conditionally call ip_icmp_error() from tcp_v4_err()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, 
	Dragos Tatulea <dtatulea@nvidia.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, 
	"=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>, Willem de Bruijn <willemb@google.com>, Shachar Kagan <skagan@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Blamed commit claimed in its changelog that the new functionality
was guarded by IP_RECVERR/IPV6_RECVERR :

    Note that applications need to set IP_RECVERR/IPV6_RECVERR option to
    enable this feature, and that the error message is only queued
    while in SYN_SNT state.

This was true only for IPv6, because ipv6_icmp_error() has
the following check:

if (!inet6_test_bit(RECVERR6, sk))
    return;

Other callers check IP_RECVERR by themselves, it is unclear
if we could factorize these checks in ip_icmp_error()

For stable backports, I chose to add the missing check in tcp_v4_err()

We think this missing check was the root cause for commit
0a8de364ff7a ("tcp: no longer abort SYN_SENT when receiving
some ICMP") breakage, leading to a revert.

Many thanks to Dragos Tatulea for conducting the investigations.

As Jakub said :

    The suspicion is that SSH sees the ICMP report on the socket error queu=
e
    and tries to connect() again, but due to the patch the socket isn't
    disconnected, so it gets EALREADY, and throws its hands up...

    The error bubbles up to Vagrant which also becomes unhappy.

    Can we skip the call to ip_icmp_error() for non-fatal ICMP errors?

Fixes: 45af29ca761c ("tcp: allow traceroute -Mtcp for unpriv users")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Tested-by: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Maciej =C5=BBenczykowski <maze@google.com>
Cc: Willem de Bruijn <willemb@google.com>
Cc: Neal Cardwell <ncardwell@google.com>
Cc: Shachar Kagan <skagan@nvidia.com>
---
 net/ipv4/tcp_ipv4.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 88c83ac4212957f19efad0f967952d2502bdbc7f..a717db99972d977a64178d7ed11=
09325d64a6d51 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -602,7 +602,8 @@ int tcp_v4_err(struct sk_buff *skb, u32 info)
 		if (fastopen && !fastopen->sk)
 			break;
=20
-		ip_icmp_error(sk, skb, err, th->dest, info, (u8 *)th);
+		if (inet_test_bit(RECVERR, sk))
+			ip_icmp_error(sk, skb, err, th->dest, info, (u8 *)th);
=20
 		if (!sock_owned_by_user(sk)) {
 			WRITE_ONCE(sk->sk_err, err);
--=20
2.44.0.683.g7961c838ac-goog


