Return-Path: <netdev+bounces-270256-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDFbGt4Hv2nRqQMAu9opvQ
	(envelope-from <netdev+bounces-270256-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 22:04:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11F362E7452
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 22:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5837C300646D
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 21:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E362BEC55;
	Sat, 21 Mar 2026 21:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hinDmFqf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F8E175A71
	for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 21:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774127066; cv=none; b=bLLBBISi4FIlGd9cP4AhI9B9JYWK+KdfqijWyV0VMwswCZyDS61Gld/4go5l7Yxs/whZqOAK/cBBADIHP801RUuUwwJXYuMBUU98BhyRuVgZJA2TK4/1QZ/+3dl+UpoMFHgITAmzonElcmNmuX8abTyCS/lspamkoanCVrNxiaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774127066; c=relaxed/simple;
	bh=KLJN8LIKGA68RzTBxDaa5PMaS+8Fo2aUnukXYnNJjfM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hY2WMDgT4GEu0wxUH287kbRCNq38gXuwgdJ1662GuvDOg8q4e0KVvLH/I7tJ/SCAi0pX5G9FBHJrQ4F7hOVV0Mc+H2rxf/GGM3zxwtrNQy68WEcGBosqix09y2eK5GuQTWbIXDJNbpZHt4kjLUR/6f/oghhggdV8UGNxn8yA98Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hinDmFqf; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-35bb7afdc38so1840886a91.1
        for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 14:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774127064; x=1774731864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2guyfq89EXbQxrNKjhQf24KdXAnwHVTqX52e3ZeUlIE=;
        b=hinDmFqfIvtfj0K4e14/Yb2hjV+zktOGLN0Qo8yScveW6QCL1eJ3LBNsgkt7JQq5Ys
         FL4G+rGPrxhoI3Se3a6PMUmF3W7lyZLjAmfLAm4raySeflA0wJ07a8VVYSsLnX67yQ0E
         09/deOmbrUubB9olW4QGe5fWs3TncCRulueyrmwOp9nGuoT6vB1qqUojd0wFbh0BHr7+
         YRaTctHsAgjJ59ZZReycIoq11WJNkQoU24BIf/aW/+DEZcjMWDSksNOGt6IYi08JAFdq
         G2iG/0LxDbi9yPA7+NfKI3rCe8FwxPpz65pVintDuod82jYntD7CMhXvvLihQTYpOWD9
         5gaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774127064; x=1774731864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2guyfq89EXbQxrNKjhQf24KdXAnwHVTqX52e3ZeUlIE=;
        b=n9frEMP6WVrUrSGVCqy5hQzPrQ4OkuQl6fjInCFP6viumgqFufpA5y7Vb+NrfoxqMG
         Ipvyzle/JT1sfqrw178WCNOpy3Sf3JT716dFnrdxYQb/PN+BD1+hfGU895k9AEWEz29f
         gf26CMy3v4QoHSy9By+4g4pyKPNKOIrMer5+vjzPp2tVQzEaZMlBBMFKfCZnVW9IyXe8
         0uLJ735VxVmXFdq0GsDyBr0R3GVz5s3zJ+7LknFhdZU9rFEvHFqtOASuugp3ZU8ra80f
         sun9K96s9fD6ygeSfX9tICteHwboYQhO4ldSjVAnIMOCa3TBtLt2QSVrrIcn95mMq33Y
         NlBg==
X-Gm-Message-State: AOJu0YzJ2wAad01kowRedwr2TvwGJrxiYG0Fs4vcUy2A5rpdIbC67YgT
	glAqq3y9iNZKHkXA9Vs3qpvXgnMtmpMLF6gEY6tVnAV3V5U0qm81lpmoCGcEonkl
X-Gm-Gg: ATEYQzy64Qg8ddDXKXSo9wFK7UuqdS4nOs6fE/DMaV+S+whAIXf4q5j2yw+2olMrn5M
	w4IxkDfjmdv9SHLWUKb4Pa96lb6YA1r5s0ALswCy8bG5kC5xtAhEs9QoW1q6Kw/TxP2rZNAycXR
	FCu5m21FXR88r8eo0wdTZ5aEY3aVLlmKLFja5St0o0qiK/YAp/MQGZHGqnXYU1pbuTNS8txzIlW
	pGLoOHD+ZHciIC6ReE1KtwkaGqxxes4+nSdYOMAbVU0z5cAxsHt9cJbrt56/HJB1MCWKRnElS8G
	B4ukTSMjwla4G3YLdpQLToZ8j3iZwD/zpWnaSjgEgDSPlAblog5WqiGRtE/Iz6gd3jywfQ2OjCN
	+Fnyaq1UtAzVY8qGktMBQpPxVFKWiMFpbNYr6TSuFlOWSwFzBXhwayz1B3T78Jk7/WssIkIHCAf
	77E5B/j2jiYUUT2GKeMopotWw=
X-Received: by 2002:a17:90b:3c0d:b0:359:8dfd:64c8 with SMTP id 98e67ed59e1d1-35bd2cec4bfmr5867322a91.24.1774127064326;
        Sat, 21 Mar 2026 14:04:24 -0700 (PDT)
Received: from nixos ([240b:10:ff26:df00:4183:d252:5ff8:1313])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bd3eb467fsm5175770a91.3.2026.03.21.14.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 14:04:23 -0700 (PDT)
From: Yasuaki Torimaru <yasuakitorimaru@gmail.com>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Yasuaki Torimaru <yasuakitorimaru@gmail.com>
Subject: [PATCH] xfrm: clear trailing padding in build_polexpire()
Date: Sun, 22 Mar 2026 06:04:21 +0900
Message-ID: <20260321210421.2504711-1-yasuakitorimaru@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[secunet.com,gondor.apana.org.au,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-270256-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yasuakitorimaru@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 11F362E7452
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

build_expire() clears the trailing padding bytes of struct
xfrm_user_expire after setting the hard field via memset_after(),
but the analogous function build_polexpire() does not do this for
struct xfrm_user_polexpire.

The 7 bytes of padding after the __u8 hard field are left
uninitialized from the heap allocation, and are then sent to
userspace via netlink multicast to XFRMNLGRP_EXPIRE listeners,
leaking kernel heap memory contents.

Add the missing memset_after() call, matching build_expire().

Signed-off-by: Yasuaki Torimaru <yasuakitorimaru@gmail.com>
---
 net/xfrm/xfrm_user.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 403b5ecac..ee31ef482 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -3948,6 +3948,8 @@ static int build_polexpire(struct sk_buff *skb, struct xfrm_policy *xp,
 		return err;
 	}
 	upe->hard = !!hard;
+	/* clear the padding bytes */
+	memset_after(upe, 0, hard);
 
 	nlmsg_end(skb, nlh);
 	return 0;
-- 
2.50.1


