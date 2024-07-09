Return-Path: <netdev+bounces-110105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7584892B007
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 08:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 204B21F2299A
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 06:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A77712F37F;
	Tue,  9 Jul 2024 06:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uHImyF0G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA61E12D1FC
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 06:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720506221; cv=none; b=uUBkMt8idbRClyw+jV/Zfhh869GpddpZNFrYCWxIk8Xz/RuxqkVRkySuxr/px6JP4DQ52DwEBynjA74yaonjumyfzIVwjRy5eH/KjZnLGDg0cyeWCnWN0ocsgfV/Jg3jEZJBcMKU3p0dEoZNK+v3Yoeujxf72IDQ7/CKWBsRPxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720506221; c=relaxed/simple;
	bh=VmaOxrMDoxpJeQU1U5hafB/Lf4mftJY8KRF5RJ2sdGg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Te1XuYHF+sy2KFzFoExE0NSEzjFeKzsmnLmZvq5uk/MPbJo06fwLnsUDVIreFyOgEqGrwj/6zaQwr7KWxlD6wfuLYSNsz7Vk3HPHpZI/v6YICOb6Uaz5Xd9ydCn5UEgelCx9bhsQzKCMKNRjapUUJ770e4WvmEXH4cOUwJfUPiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yumike.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uHImyF0G; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yumike.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dfab38b7f6bso7499832276.0
        for <netdev@vger.kernel.org>; Mon, 08 Jul 2024 23:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720506219; x=1721111019; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XYup63ShssTSYOcnVn9rka8+8qfRXpQa81RERIvxbCs=;
        b=uHImyF0GARqD9vnwqGA9s7uGcfDNxJoufT1Y+ZxFBKNFhZEDene7O90X0sMNKk4gg1
         MWWDPDEBQqxOdSh0gSqre2uZzmKh2wFLaxx1ldCJhO8ofr9EMGgnQFGhMlqJJe9T88QW
         TmoeoffrlGQ8ff1OiKcjte5esRRmdxyv+1HiJIIdxBMk/EtgrGIH8C4XCF0ESkG5d7uC
         bZglxBRmWC/3724/FbH4wO2S29wuyXIJQJ2xj4DNjm2yzGkMxXOCbwDOP/SeUOosc1qf
         M/SZILxwjJzdsBRQrscjmup9TvKLm+4VKMtnxleUUCdhKYe1OvvXLKPpf7cp1Rrv65Qp
         3BhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720506219; x=1721111019;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XYup63ShssTSYOcnVn9rka8+8qfRXpQa81RERIvxbCs=;
        b=nCZ3rqsPWnfumznMBh7z6r8Bm+6KMXU0fZ1+0kW2m7HXXoQNzRDOVh+GzyPzvBMd4Y
         5h3pkpOpT5vraO09OuWaARVaiO5ql/dr5T5gkd4l7/jepY65mteWCqKLksaJDlRVuQz5
         pNeaDk2f/DvcouF2BtHXyNTL+qd0OpkorbZ2rst3HK5d0qpZMhsn+qbx1YFql9sTie8n
         bui4AX7A3Obevsx6WZUTjWCkO6/5A/Djnluu2u8I4+DSRrGyBYvCyxOISyUeL0VydZVh
         ZcGZjoPArVC/tq94T3d7UVGTSKQOJ7Mni0J4KqhBLn7zu+5dyAQZeUjl+5e1YNVMtxvw
         D0tg==
X-Gm-Message-State: AOJu0YyVfH+UbwUkA7LixcTEMLjhF3Y3yDibORW8tMIintmLp65sSgHz
	lZ+7zgz/Pvwi/5Rh6gC+caYMu1N2fWj8ilJ+gcfR8AbAVAqgze4nedPFE2MYEuXVfw7/ksRTerW
	w2efHmqxBCqDYx7T779IdOH9qboR6uTtXZS7uP1EBKJV/SMYQF41ZmqlTXAn6mlAXdGLHnFwTiQ
	rt2jqBE7GoG5uiTRIUs7EdWSPApL3onsG/
X-Google-Smtp-Source: AGHT+IFUI+DUmECIiEP6CXZ0En4MC8rKFUHOQCwm/gu4ExfrM3dMGvAJRb2eJgkcDt3G+fSpdMJPriMg5I0=
X-Received: from yumike.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:d2d])
 (user=yumike job=sendgmr) by 2002:a05:6902:18cd:b0:e03:3f26:b758 with SMTP id
 3f1490d57ef6-e041b0594d9mr163281276.4.1720506218701; Mon, 08 Jul 2024
 23:23:38 -0700 (PDT)
Date: Tue,  9 Jul 2024 14:23:24 +0800
In-Reply-To: <20240709062326.939083-1-yumike@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240709062326.939083-1-yumike@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240709062326.939083-3-yumike@google.com>
Subject: [PATCH ipsec v2 2/4] xfrm: Allow UDP encapsulation in crypto offload
 control path
From: Mike Yu <yumike@google.com>
To: netdev@vger.kernel.org, steffen.klassert@secunet.com
Cc: yumike@google.com, stanleyjhu@google.com, martinwu@google.com, 
	chiachangwang@google.com
Content-Type: text/plain; charset="UTF-8"

Unblock this limitation so that SAs with encapsulation specified
can be passed to HW drivers. HW drivers can still reject the SA
in their implementation of xdo_dev_state_add if the encapsulation
is not supported.

Test: Verified on Android device
Signed-off-by: Mike Yu <yumike@google.com>
---
 net/xfrm/xfrm_device.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index 2455a76a1cff..9a44d363ba62 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -261,9 +261,9 @@ int xfrm_dev_state_add(struct net *net, struct xfrm_state *x,
 
 	is_packet_offload = xuo->flags & XFRM_OFFLOAD_PACKET;
 
-	/* We don't yet support UDP encapsulation and TFC padding. */
-	if ((!is_packet_offload && x->encap) || x->tfcpad) {
-		NL_SET_ERR_MSG(extack, "Encapsulation and TFC padding can't be offloaded");
+	/* We don't yet support TFC padding. */
+	if (x->tfcpad) {
+		NL_SET_ERR_MSG(extack, "TFC padding can't be offloaded");
 		return -EINVAL;
 	}
 
-- 
2.45.2.803.g4e1b14247a-goog


