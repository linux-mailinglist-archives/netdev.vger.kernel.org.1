Return-Path: <netdev+bounces-233406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B31C12C61
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 04:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 73934351E9A
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 03:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDA2281358;
	Tue, 28 Oct 2025 03:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wWstsx7Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE9727FD4B
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 03:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761622713; cv=none; b=aX6MrMjxQ/EoIwDauLpjCvrIeEWRgBDMq0ofZYNgxTftlP37DTkx5a2Gyx6wqKgi1jwHjFFeK9sr68tU6Vahw/pvTkhRuoVWPK1KBeFBkZi1h2I9IqUxQhjyBGZMhynryZxsgKGNL0GvNVI2KaVcZjouYZsflahrciZdLeN8qac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761622713; c=relaxed/simple;
	bh=yrkJ4XuM/Q4gdAebdcwOjYSYMiS8u3LXGWsakKSsKwQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Io4KkYCVk1m/Ed69RfZbsSRouvJA/RWWBsaWh6nQHq+RFP00lP315zLig3dUEGvYvDBYhZwXkIFrvfVR0NyCoYLgLNIf9Pwi3ws0dx+P2XnYg7mc9suhShjquQNAiv7b8sKqiaEZ3vbYogG3mIPjYyEEtfkKqeVlVoPGZ81fe4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wWstsx7Q; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-28973df6a90so40017255ad.2
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 20:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761622711; x=1762227511; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rjrdvr+I4PmIuzZ41AH+LJNfW4XodEwfjRyzW1+y+Dc=;
        b=wWstsx7QWPuWKe3r6Mn7gHZoCfbBWyNuSuWxj6kgz4hteU23S4HQXJw59BukDB+PIM
         qTIVEvfNxEqLTqP3D6pBGVcUa1V0g6suDPOp3/oVRmMvMUqtp+/9vnhFywMmBeTtFQxk
         ZZFas5ujOgKeenafQJ5t+ThkUWl7A15Ig03h8YgLU1VI6OWQfPFwRuz/TNKJcBszQqh4
         x8HCKBuDHebe4urw1LiamyiLsiWXx5UL8Zuuqs4iJr1RoxCMgKFPVTy9YQMUt2s4E3pg
         p/EcAr0mxmGJRm5Lc7jiyBPQ0QR9+jpAKce58LYPt+aTueBincajXfbOZlk4sH55AhCT
         aU8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761622711; x=1762227511;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rjrdvr+I4PmIuzZ41AH+LJNfW4XodEwfjRyzW1+y+Dc=;
        b=JDAF0sLZb1BZK53tyJh+5sK56VwH4drAV0/j+SWATNz0/5ZEURjVQjcGCFTS69bang
         cSRJiQF19bVkkjOudoYBjF87k0oS/r7o8BF07nSFGX872TdRbLT2oNZ4KcoKPRrAYxTU
         9fnD9C6bpIX7qQoJs6SP/CN0VJMtOMY72cQt5OjgQYotrZo8c2pwrdxOpkR7nmQSyblO
         0JhJ/TTg5zyFEr2JAqqxINCZVnKa9u++j/mKZrD1BrOtTHu25JbLDWZZzwhWgJtv2wzt
         JWlOdxV+2PRmkG8ZI1XIjQQ03d7n0XMZxD7d+OPxTnHdZE5MOLm3mKulWM8IasR7q9sr
         uYXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVp7HSGpZcZYNmrMC5FWiO6H1JUc5XzVh3f7HQMvLOsd/M+Fr9Pz32rbYeiFCBudI+ltJmhI24=@vger.kernel.org
X-Gm-Message-State: AOJu0YygbygRR+OPcM/oBf4Hnj0Jb6/96wcl23AnVdR0x7RmSnp5+V5m
	KI7TGv70ASBHGnmzNUi+52AQYxN09g9mU/cIJX3Ps6n9wvU/ZJwgR8hLACSqAb3NzjBuln5nevG
	vC8SI1A==
X-Google-Smtp-Source: AGHT+IF84kqYKj5VQ2ptoDlKstzG9N5M1y9zT6/x/vnykzIBdOrQEatPKutj0xHgmETa9cQOjldpvMSZU1U=
X-Received: from plgy2.prod.google.com ([2002:a17:903:22c2:b0:267:dbc3:f98d])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:cec2:b0:290:ac36:2ece
 with SMTP id d9443c01a7336-294cb3c8f9amr29209195ad.18.1761622711017; Mon, 27
 Oct 2025 20:38:31 -0700 (PDT)
Date: Tue, 28 Oct 2025 03:36:58 +0000
In-Reply-To: <20251028033812.2043964-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251028033812.2043964-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.1.838.g19442a804e-goog
Message-ID: <20251028033812.2043964-4-kuniyu@google.com>
Subject: [PATCH v1 net-next 03/13] mpls: Unify return paths in mpls_dev_notify().
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
2.51.1.838.g19442a804e-goog


