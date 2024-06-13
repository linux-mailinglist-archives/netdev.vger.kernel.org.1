Return-Path: <netdev+bounces-103048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3718906146
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 03:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED4C5B2200E
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 01:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6445A2BB04;
	Thu, 13 Jun 2024 01:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y93bPNfS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D029B2A1D1
	for <netdev@vger.kernel.org>; Thu, 13 Jun 2024 01:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718243276; cv=none; b=SWx8IJTOB9QUX4VYS+vjZFEmMetmG1Q1Xi+adWxSRK6TGD4xrJMrJ37DbNhhjhc4kTanKQm0q9qHuxVbuhuB3jOTGo+Ros1HzbOU+PxqyV+LgFokipJPWNI/yn4QSey/nuWK8oZFtCC3fSvuogijw2TctLDv4ijE5v9jRD194IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718243276; c=relaxed/simple;
	bh=gfQtaaj0HZXo7hMlFPf/fqEeASqbj9LDKgF87U6g+OU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Inm2V4XeIrRGsgOgNO62EnyyJApJZr/0Sw296D/eIW123GtEOZ7YA5gaUpkyTR0429i26gzQ0HmF4wKnXggkq7qYZao3jZD+XtOwwuQ6JDTxy6eR27jQPzZiUPp3UUjTvZ2N/cBjrelodxz9uiuGUJuDxc+9L19ZlCe+1VIpnVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ziweixiao.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y93bPNfS; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ziweixiao.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dfe9ef3a637so783234276.3
        for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 18:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718243274; x=1718848074; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9vumCWMKtNGhqpjBYPo4gphn32wvxgC3E6VCZk/kLxc=;
        b=y93bPNfS8UACeH3dZfdaYtmH8/mDjRuZnlDE6iopVriD9lF0ZXPMqg6k+J1XID9kV0
         VKu8UU4fCiTXBtTOlmNg5tKSoT7JistnPfYUUsebbbhaSjglfgJtocnfiFC8a8y+2Bfr
         axZMgENgBkfw99GsD0rMJX8bckUnyOHZBSzxW3+S3Bo5fc97X2EbGlGKljp7h+Bq1CqE
         IwtRXSZPWYW1wEPi4nOXqfVUZ+W7cMq9bF2eSiVyDdMB/+Q9L8ppoVKb1QyXXJAzfcRZ
         KZSx9+R7jiHhkJT9uNe1Bi7jHYtpoTkVtgvqFZzrmygPqhAdnypffNOjEaR3tZLorxhX
         9sZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718243274; x=1718848074;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9vumCWMKtNGhqpjBYPo4gphn32wvxgC3E6VCZk/kLxc=;
        b=MKkDQ4RprFzbsqW6GPNfxgh1Tqim+MKsBAwdDj0VPR8seY82gTOxnQjUWNfI2bM7Lj
         KAsohHq/6HmdoTRU6deFh0ruoXvBaIYigc8mctM+A/8XWokyMp3TVkmXj2EH3Jdbhigc
         0W2Ho14MK01EWK7goMGaw2dwAv2xDisM5m8EKy9qJFXzdIHwxHLZgg9qjYe7sjF5T17u
         tqXqDoQspHX5TWY8v/BYyeymlS39CJOtHkHARBrcbD0EUkCX6+fY9V/e09lPYxuUTxX4
         pXKgO3ecxZudAEgo6QejSDH2hjO0ddVlGbVzn8KDhEGcPlvuRFbw8/XEmejkKLHEWRju
         jyXQ==
X-Gm-Message-State: AOJu0YzFUuySM8ESeGoqHHuCg/q4N180uADs5bhCOGtcbJFUzgsjnCOW
	uEHjKCxfJmTJm6yyGx1GFWUV6QGiaKrOPVTmAQi933l5YXoFRqkFeKvzfALRzsI4NHn083ZI2r5
	QtxF/kFzWtMkFUNx6gnVSiOgn0ncZvFWLwQowq5WDlnAUj4b9eiX5BVcZJIJXp8TFUYE1vknowh
	0dqkfPwpNPOs3Z4mv6zex/5GQfK4rEiHyKV1kx5QdxTdLgYNkI
X-Google-Smtp-Source: AGHT+IFvEpeulKMnslBayi/qNovxpeMCLNZenp9tdPIPtmsoPk60eHw+DWo7dlqz4FmcD5zH55ADo4JWesNC+Ac=
X-Received: from ziwei-gti.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:9b0])
 (user=ziweixiao job=sendgmr) by 2002:a05:6902:1001:b0:dfa:dec3:7480 with SMTP
 id 3f1490d57ef6-dfe69005926mr304509276.12.1718243273400; Wed, 12 Jun 2024
 18:47:53 -0700 (PDT)
Date: Thu, 13 Jun 2024 01:47:40 +0000
In-Reply-To: <20240613014744.1370943-1-ziweixiao@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240613014744.1370943-1-ziweixiao@google.com>
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240613014744.1370943-2-ziweixiao@google.com>
Subject: [PATCH net-next v2 1/5] gve: Add adminq mutex lock
From: Ziwei Xiao <ziweixiao@google.com>
To: netdev@vger.kernel.org
Cc: jeroendb@google.com, pkaligineedi@google.com, shailend@google.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, hramamurthy@google.com, ziweixiao@google.com, 
	rushilg@google.com, horms@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

We were depending on the rtnl_lock to make sure there is only one adminq
command running at a time. But some commands may take too long to hold
the rtnl_lock, such as the upcoming flow steering operations. For such
situations, it can temporarily drop the rtnl_lock, and replace it for
these operations with a new adminq lock, which can ensure the adminq
command execution to be thread-safe.

Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 drivers/net/ethernet/google/gve/gve.h        |  1 +
 drivers/net/ethernet/google/gve/gve_adminq.c | 22 +++++++++++---------
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index ae1e21c9b0a5..ca7fce17f2c0 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -724,6 +724,7 @@ struct gve_priv {
 	union gve_adminq_command *adminq;
 	dma_addr_t adminq_bus_addr;
 	struct dma_pool *adminq_pool;
+	struct mutex adminq_lock; /* Protects adminq command execution */
 	u32 adminq_mask; /* masks prod_cnt to adminq size */
 	u32 adminq_prod_cnt; /* free-running count of AQ cmds executed */
 	u32 adminq_cmd_fail; /* free-running count of AQ cmds failed */
diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
index 8ca0def176ef..2e0c1eb87b11 100644
--- a/drivers/net/ethernet/google/gve/gve_adminq.c
+++ b/drivers/net/ethernet/google/gve/gve_adminq.c
@@ -284,6 +284,7 @@ int gve_adminq_alloc(struct device *dev, struct gve_priv *priv)
 			    &priv->reg_bar0->adminq_base_address_lo);
 		iowrite32be(GVE_DRIVER_STATUS_RUN_MASK, &priv->reg_bar0->driver_status);
 	}
+	mutex_init(&priv->adminq_lock);
 	gve_set_admin_queue_ok(priv);
 	return 0;
 }
@@ -511,28 +512,29 @@ static int gve_adminq_issue_cmd(struct gve_priv *priv,
 	return 0;
 }
 
-/* This function is not threadsafe - the caller is responsible for any
- * necessary locks.
- * The caller is also responsible for making sure there are no commands
- * waiting to be executed.
- */
 static int gve_adminq_execute_cmd(struct gve_priv *priv,
 				  union gve_adminq_command *cmd_orig)
 {
 	u32 tail, head;
 	int err;
 
+	mutex_lock(&priv->adminq_lock);
 	tail = ioread32be(&priv->reg_bar0->adminq_event_counter);
 	head = priv->adminq_prod_cnt;
-	if (tail != head)
-		// This is not a valid path
-		return -EINVAL;
+	if (tail != head) {
+		err = -EINVAL;
+		goto out;
+	}
 
 	err = gve_adminq_issue_cmd(priv, cmd_orig);
 	if (err)
-		return err;
+		goto out;
 
-	return gve_adminq_kick_and_wait(priv);
+	err = gve_adminq_kick_and_wait(priv);
+
+out:
+	mutex_unlock(&priv->adminq_lock);
+	return err;
 }
 
 /* The device specifies that the management vector can either be the first irq
-- 
2.45.2.627.g7a2c4fd464-goog


