Return-Path: <netdev+bounces-162628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62236A276D7
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 17:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD0493A31B9
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 16:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D51215189;
	Tue,  4 Feb 2025 16:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="deu3HNSi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B671214A67
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 16:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738685424; cv=none; b=ngFqFa9gDjtzXOEvZjZOFQxLd33DZbs+KF2zEck2sALpIF5nDEXI9NV20MBroT3bBihM+haBnt7Keq1boZJm7ehyGo+Ayna1iChCLaF3JlEOFrL+pcBcv6fB2AmnbEK6EBvinM9MkMFZ0E5ARMIt0Y6uE3ual5efSMnQAbx32NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738685424; c=relaxed/simple;
	bh=PuNXP/CZkSVs0c0d7Il4xGuZ0IDnOjmbV7yk/GstWYU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s2Y10Vym+vDRrGhkev2Zzr3pYIBT8ym/P0KBJG0concbRmDp5IujToHgGhddV/HOsgnL92X7zc4AOgFjSRforEqZo7HD4xzh6PdrJ42R107r/PtBJhO4Q607wrqT4J5fH1aeKwzU75JtsZQXRqK1uFf+iPJ7fykz+R4r72uO94k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=deu3HNSi; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-5188b485988so1955177e0c.3
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 08:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738685421; x=1739290221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F2qYZ5BnA1vfuM6n+iWPC3TNe7psLfxfdFPYEHyiP4o=;
        b=deu3HNSi/8jtCyZG8cudR+LxCyi94/rNBB6NwUHcczQpOY1jIL+fq279eI/UsNqpZV
         WQKlkQOikoWPPjakfrosxW6Bn58k+LCEJzHsrmILThkuavKi3OWDa1WxoapMPMVsI4Vb
         fZ8VFIT/EjDW6M0Rms1oScU4xTNfMONAo4jTQeQb79kWxgZOT4MDguXp+HBufOs2MSAr
         XriXSEnXYPjUI/jAzTIzMU7wyEqGwukmwRfkTuRAJjPiZUq51R9762je6w7cDDDPxdnM
         E/1XzWEoEMy7lyjSr3c7+Y7QfOyNodgbQyWssnzuELPRizar6YokN8ihF0OPrelD4b6+
         IqUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738685421; x=1739290221;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F2qYZ5BnA1vfuM6n+iWPC3TNe7psLfxfdFPYEHyiP4o=;
        b=f+hmTDmpejX1PqpYN0NknGqzRXg33cm2YY0NJpiMJwtG4AYjY518o9sDajddTUIxZs
         KZ4qT26iDLdjcBIyTXvvbfIoZZdumhX/JxmPjhZ0Nu5NB0PA/NoLKdQMRZhSc+J0M8HB
         9bPNSkzgOdQ7ZNezUd9kqHCBCMeXegqZb9CYQRzPmg0oN/Tk6fU4Uooq4+lmlreuWSAe
         k8b7Y07Fu/FZn+EFQSZkzuMtichmnqBOSC7+Zb18CzuLwRG1YArCh9sczYLJVg+F8D6b
         1Fc8/rsN0kYhugPKWEYLtBplfQvwS7bf3Q94fr/1gRHxXSWaocTAO0VwsC1XRKozKhtb
         53Eg==
X-Gm-Message-State: AOJu0YzP1vlcWDsTUTJFYK2OZNn2m+PYNbJLFAFtAjM5XI8cl+02hPV0
	oCF7DYd9AbB8KtbrRQIJufGy/gmhXqk7G3X+EDKDrB/P1EmN9wbkzDo4fg==
X-Gm-Gg: ASbGncu86Qgdr4oTh2xV0M/m9+G/6APAgIF5WlhpFn1I+82WVwF8kA72ArK5ZSPmLg0
	+1kqI8sDE7xEsaJGRdc3QqKPo1nC0ljc6y/oP/Nlv3WBEjvL6MzcCO9zVLR15kj/lAGtC0cwKsf
	mO2eSdmFaVFJEa/NWChJ801lulY+fnHL140CiWlIVBXiCLQ483XWNyOpb0Y6zl+Ro2fi3bp2qYo
	JlEE8ewM8JGUjAlZ5bi7epueLnUKPzYnMT+VlOWwXG7PRBCOVZm+ZtRg95jV+8vq/P9z8c9nhJh
	m2vlgMuvuM0eAGPPBWtKKdJJUmsl04W7rmiCtBaupRPhwu2lO4LS0AJTYfTodKsA9fkjWMQnRrg
	tQcB97YNSnA==
X-Google-Smtp-Source: AGHT+IF9DxH/YLwRtgAiPS+fTO/qSMy3Mg708lsHQBA+HLDvVYTYaMbonrtiwK6LIvXCxvjsbMJ4Sg==
X-Received: by 2002:a05:6122:4281:b0:51c:c663:a337 with SMTP id 71dfb90a1353d-51e9e28a525mr19051934e0c.0.1738685421025;
        Tue, 04 Feb 2025 08:10:21 -0800 (PST)
Received: from willemb.c.googlers.com.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-51eb1bed875sm1532909e0c.4.2025.02.04.08.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 08:10:19 -0800 (PST)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	jasowang@redhat.com,
	Willem de Bruijn <willemb@google.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Stas Sergeev <stsp2@yandex.ru>
Subject: [PATCH net v2] tun: revert fix group permission check
Date: Tue,  4 Feb 2025 11:10:06 -0500
Message-ID: <20250204161015.739430-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

This reverts commit 3ca459eaba1bf96a8c7878de84fa8872259a01e3.

The blamed commit caused a regression when neither tun->owner nor
tun->group is set. This is intended to be allowed, but now requires
CAP_NET_ADMIN.

Discussion in the referenced thread pointed out that the original
issue that prompted this patch can be resolved in userspace.

The relaxed access control may also make a device accessible when it
previously wasn't, while existing users may depend on it to not be.

This is a clean pure git revert, except for fixing the indentation on
the gid_valid line that checkpatch correctly flagged.

Fixes: 3ca459eaba1b ("tun: fix group permission check")
Link: https://lore.kernel.org/netdev/CAFqZXNtkCBT4f+PwyVRmQGoT3p1eVa01fCG_aNtpt6dakXncUg@mail.gmail.com/
Signed-off-by: Willem de Bruijn <willemb@google.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Stas Sergeev <stsp2@yandex.ru>
---
 drivers/net/tun.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 28624cca91f8..acf96f262488 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -574,18 +574,14 @@ static u16 tun_select_queue(struct net_device *dev, struct sk_buff *skb,
 	return ret;
 }
 
-static inline bool tun_capable(struct tun_struct *tun)
+static inline bool tun_not_capable(struct tun_struct *tun)
 {
 	const struct cred *cred = current_cred();
 	struct net *net = dev_net(tun->dev);
 
-	if (ns_capable(net->user_ns, CAP_NET_ADMIN))
-		return 1;
-	if (uid_valid(tun->owner) && uid_eq(cred->euid, tun->owner))
-		return 1;
-	if (gid_valid(tun->group) && in_egroup_p(tun->group))
-		return 1;
-	return 0;
+	return ((uid_valid(tun->owner) && !uid_eq(cred->euid, tun->owner)) ||
+		(gid_valid(tun->group) && !in_egroup_p(tun->group))) &&
+		!ns_capable(net->user_ns, CAP_NET_ADMIN);
 }
 
 static void tun_set_real_num_queues(struct tun_struct *tun)
@@ -2782,7 +2778,7 @@ static int tun_set_iff(struct net *net, struct file *file, struct ifreq *ifr)
 		    !!(tun->flags & IFF_MULTI_QUEUE))
 			return -EINVAL;
 
-		if (!tun_capable(tun))
+		if (tun_not_capable(tun))
 			return -EPERM;
 		err = security_tun_dev_open(tun->security);
 		if (err < 0)
-- 
2.48.1.362.g079036d154-goog


