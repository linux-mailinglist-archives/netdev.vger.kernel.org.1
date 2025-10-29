Return-Path: <netdev+bounces-234098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DE8C1C792
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 18:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 39BEC4E259D
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 17:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D2DD351FD5;
	Wed, 29 Oct 2025 17:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KPrW/Hmo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634593502A8
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 17:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761759233; cv=none; b=JqoTSitgIvr+0spTz8C42EFmOTlckC3jB/qEx0RkSFQSfgh00DpIvEkeadI9xHYMj3eSc5v2ePzw9tf5KAPZI5+yQYHfzOF9frnGqW10ACwfPY+UPygAaO4/py9FNzvhQHS3kddqZg2JPVE2Tk9Xn8Xw5n0ICeVwPYafId2BeMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761759233; c=relaxed/simple;
	bh=vavoApXxGOLsFBBMmmOHK/8Fppo0ZCjjSwij3+AizTQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Urlnkrh6BasgocE1p2TT62IT0NiY79ntR2ENrbbR1Aas2emT4woaczSgIp9qz8Df5aT6TDPwYHTv/vXQ92N8M4Prr6vXU25LnTdacf+eAXCXJUjT9hvRf+o585lzmLYhl1oWvClF1wAmAvgWbF3sqxKIoMHZIZEk5LiACRbJInM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KPrW/Hmo; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b6cf3112d08so102312a12.0
        for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 10:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761759232; x=1762364032; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JicqBdKIjiN5TTDQ/6yyIiiGnR4ca4w0gZKBt7st+nc=;
        b=KPrW/Hmo5HcFEgVI/yjW+/GD2mQhxKVImHb2jwN/7o2BAwmHJmTsnK6rCeGsynmFTi
         akZzoO2z6caBXTuZf0Nob8ET34bbisVG0o9/fjV29GiRDUXxZt/YVqXlMaETu/PHpJtH
         8z0k9yANv7Msl6C5bXFluGaxEL+matI8ZhR5FgCXCSh1lotQVrR9gsO4ICislVPFxPca
         7J/guEjr8zM8dzlcW4eUCmF1ZBRRDKOTs6Ldyulrxygv7Peg4fKd/7Dr+9ECgvBD5g4I
         6HCTwxWXwKU0EM7+wZm4DO2e5YD//FwWlmkYUnKTIagEbmMk8rw3vxAU03npNnUcj0ZW
         Bphg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761759232; x=1762364032;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JicqBdKIjiN5TTDQ/6yyIiiGnR4ca4w0gZKBt7st+nc=;
        b=lGnKXLddMlKl2Hw20ZS+B28EzvGafYFDBWfAc+6X5F9bu/UzxikKOy4WkS3N4btTQW
         duypT8QmzS4AFcl/IQoGl1lqAsVtFiRiYTbJgA0Tiok7fWYY+R1fjoxopDVfaemS0l10
         4t6KjZ3octzJZDks9gP5yfxK+byQvpoluJw0Ts6Uki+I11FdbTH83z7mPOiNiteGALJi
         XORx3SIir0nr2628dtwAz3WGhoLWFyrgOCZ4jHRXRxNqI1YpmLf2/g8ZizlzGgiBnaY/
         Yz8sWBRzqzgt6wDguG0Rs1QjJ3siCAEDQLaSu1Ja1o3J+b0xzfQe2+r7uib4quFIHn5f
         zacA==
X-Forwarded-Encrypted: i=1; AJvYcCUBj2lrMW53OLT/gQTsF4Yw3zgPsPTrC1y8TkJ5ESdx1jmTTJFgPngoaKr8sBt32az/zUHa7Vc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjNtGwrVAX5hVbmAfCKV0Tu6crRsRZ9Gygups7QGevbjDSXf80
	fdfr0+/7NA6FR6forVpNLpbx0v9HFDwYfpxIokBj4UBuVjPgh69z5hChYF/qe/YFNqVdq71YQ7s
	ioIlxaQ==
X-Google-Smtp-Source: AGHT+IEPx9JHb/SWPhw8AdAccByyuw2gditclLC4oAUxsiLzrAQMRWfyP8MpHB6gFHGnDMhaJ2sAjmgWabU=
X-Received: from plbbf4.prod.google.com ([2002:a17:902:b904:b0:269:740f:8ae8])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:e751:b0:288:e2ec:edfd
 with SMTP id d9443c01a7336-294ee214172mr1201935ad.10.1761759231730; Wed, 29
 Oct 2025 10:33:51 -0700 (PDT)
Date: Wed, 29 Oct 2025 17:32:55 +0000
In-Reply-To: <20251029173344.2934622-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251029173344.2934622-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251029173344.2934622-4-kuniyu@google.com>
Subject: [PATCH v2 net-next 03/13] mpls: Unify return paths in mpls_dev_notify().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

We will protect net->mpls.platform_label by a dedicated mutex.

Then, we need to wrap functions called from mpls_dev_notify()
with the mutex.

As a prep, let's unify the return paths.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/mpls/af_mpls.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index e7be87466809..c5bbf712f8be 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -1616,22 +1616,24 @@ static int mpls_dev_notify(struct notifier_block *this, unsigned long event,
 
 	if (event == NETDEV_REGISTER) {
 		mdev = mpls_add_dev(dev);
-		if (IS_ERR(mdev))
-			return notifier_from_errno(PTR_ERR(mdev));
+		if (IS_ERR(mdev)) {
+			err = PTR_ERR(mdev);
+			goto err;
+		}
 
-		return NOTIFY_OK;
+		goto out;
 	}
 
 	mdev = mpls_dev_get(dev);
 	if (!mdev)
-		return NOTIFY_OK;
+		goto out;
 
 	switch (event) {
 
 	case NETDEV_DOWN:
 		err = mpls_ifdown(dev, event);
 		if (err)
-			return notifier_from_errno(err);
+			goto err;
 		break;
 	case NETDEV_UP:
 		flags = netif_get_flags(dev);
@@ -1647,13 +1649,14 @@ static int mpls_dev_notify(struct notifier_block *this, unsigned long event,
 		} else {
 			err = mpls_ifdown(dev, event);
 			if (err)
-				return notifier_from_errno(err);
+				goto err;
 		}
 		break;
 	case NETDEV_UNREGISTER:
 		err = mpls_ifdown(dev, event);
 		if (err)
-			return notifier_from_errno(err);
+			goto err;
+
 		mdev = mpls_dev_get(dev);
 		if (mdev) {
 			mpls_dev_sysctl_unregister(dev, mdev);
@@ -1667,11 +1670,16 @@ static int mpls_dev_notify(struct notifier_block *this, unsigned long event,
 			mpls_dev_sysctl_unregister(dev, mdev);
 			err = mpls_dev_sysctl_register(dev, mdev);
 			if (err)
-				return notifier_from_errno(err);
+				goto err;
 		}
 		break;
 	}
+
+out:
 	return NOTIFY_OK;
+
+err:
+	return notifier_from_errno(err);
 }
 
 static struct notifier_block mpls_dev_notifier = {
-- 
2.51.1.851.g4ebd6896fd-goog


