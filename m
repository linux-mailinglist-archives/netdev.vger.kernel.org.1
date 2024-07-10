Return-Path: <netdev+bounces-110547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C55E392D08F
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 13:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6B41B2B203
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 11:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A2C19048E;
	Wed, 10 Jul 2024 11:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WWfb+WrB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9620190483
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 11:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720610238; cv=none; b=mRamH88oEpGwvk/i9taQwMZjgGgW78vMgwXWDL05pD4pqIEyPn/PrbuAKpgzg8+ptwIhu3JREBvRVfd+XnLi89WtCwcTjHIckJyfeb7WcH6HJwM8jlcbluTB6jBRrJAn56GGJ2hZtQo7R6fpD9L8X9eX/Apb25Vz15TZVmt2ubM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720610238; c=relaxed/simple;
	bh=VmaOxrMDoxpJeQU1U5hafB/Lf4mftJY8KRF5RJ2sdGg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YvldDp2cjqIfs7IsiGZ+jTpDczcZ301bbPjicleBDPiZyrmFRUcE/VFyEEpcqMT2NhviZrgjpwesoe7z3kN5MXecyRb5vl1+CxTIvPrcXUgnDm4lsS+LTezeuRTswJvqOVr5TDN4miHB8qs28WryfKhKGuzK6mxFxhMW2Nbvx/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yumike.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WWfb+WrB; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yumike.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e037c3d20a6so11072833276.0
        for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 04:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720610235; x=1721215035; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XYup63ShssTSYOcnVn9rka8+8qfRXpQa81RERIvxbCs=;
        b=WWfb+WrBX308gCpkpSnRSMfPRXBN2AxYvO2qTmeQ/2AkLE3WWeU8e+137u+bi03c3+
         OuNvB4qnSbj661oGJdJ81bBpKUIc2V03UIqmDlrAgIMgG/f4dMVVXfzSz6QWW6WRMxvu
         NwN56HSDyaOo9BP7/d+RCyFC6fkFpSXVmRwTzYEKIgEGEKCM8CuRykiXJdG7eUaFQJ36
         HDP1XU+ElYSbniKn8A4xQzXTLr/C6iYLxD6qdQN6HlPIjcuFOZIpcANQ4TxqyUdfA1w9
         f2NVhv9VYEgkcEZpXEzFj7rqo0oXBE02YxIa7z7nvzEgmKzWhvc44co9LufkAfHB9PHx
         bRUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720610235; x=1721215035;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XYup63ShssTSYOcnVn9rka8+8qfRXpQa81RERIvxbCs=;
        b=u+Rj0KAlYlEQEKPhtTBbkIW8wYtYFH7/m/F9EhC88t1KVRKIo580rPC6J2WZkYAebF
         uSbYElM6brownHGs4rbqumetI5BybtF/Ym9Q1qLdfTpRB/6wKyKVi++EV56cPunE/HUL
         Cb1IsMDKiSC5JLpLEbfRIOiav2ebADVxG4yl5P2eehne1ztAB9DFq3r6dRG1HbTStjzk
         rMI9POKO4kj1foL28vB4QX8iA3pmZd8CGoD0jQhmCvQwF0Z5suyp1jX/S3LVNfKTShDG
         GJ9OdokKulBp2Sp/pkSJnMx2UFyl+fqFVrqj2XX1jkIHvxKxLHEq8SIrW2aGml7bK5Ky
         rhTw==
X-Gm-Message-State: AOJu0YzoT5oPwaSoCLTyqPsvEAcM1L4u9Qs3k5EKtsgE0HK2ezxYqlUE
	6O3LMezVjtokKSqNnLat/Iyfha9z+97nZovE8gHycFt3++yYvu3ivebSsTHBc/g/ncVKgAMYMdR
	+It6fycYk1kL697MS/AjAJOTLwNATCW29F0dIho/EekCjcOepkQRCdT/uD8wdzjHOt7KcE+e5dR
	QdXaHMDfd7uJLjz6z6LCDOsIEuukuaQpUw
X-Google-Smtp-Source: AGHT+IG608nfPJgI9gdXcUJYidhTGNnb4U8rgMPp8r3UE4c3lu6YZdX0XmFi4aXN9c1TvxdiOhx86JjaV7Y=
X-Received: from yumike.c.googlers.com ([fda3:e722:ac3:cc00:3:22c1:c0a8:d2d])
 (user=yumike job=sendgmr) by 2002:a05:6902:100d:b0:dfa:b47e:b99f with SMTP id
 3f1490d57ef6-e041b0314afmr11517276.2.1720610235111; Wed, 10 Jul 2024 04:17:15
 -0700 (PDT)
Date: Wed, 10 Jul 2024 19:16:52 +0800
In-Reply-To: <20240710111654.4085575-1-yumike@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240710111654.4085575-1-yumike@google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240710111654.4085575-3-yumike@google.com>
Subject: [PATCH ipsec v3 2/4] xfrm: Allow UDP encapsulation in crypto offload
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


