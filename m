Return-Path: <netdev+bounces-219202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F2FB4072C
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 16:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DC2554506E
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 14:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CF07326D4A;
	Tue,  2 Sep 2025 14:36:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1AB324B07;
	Tue,  2 Sep 2025 14:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756823811; cv=none; b=heui629QB8gb2JFkCjlm8NwvtOOesvyVYgd+ePzCgDizqtNmxayCgMp+YlvVp22BpT/9Qzrf2obfRlA2DAoY8a346eOSXL95xBwfJXi0OuhbrrEY3Z2msrz89Vs/8jfAkzD/E2s700G7rzh9FQPWVj+k7rGv+kQ1UP6V6eyB28I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756823811; c=relaxed/simple;
	bh=vdJ3o7SQzqokdbSPEfnxGV0IOZXYQuFhEVIrfm9ulm8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qmjd5Fak3VWmmB2EJIKtpqeOShT1FtZ7MkaJLTnXmSM+XEaXbRnNljBVOFAF5cK2kBk6bbRhgplDB1O1Jw6FjssetShdOJGtT1yg8oqNooc+/9CJHZRh4pFhGZQv/tPV0UAFoJm4EB7rEafjQ3tcldRNFcUxMHFKpVhZobIpcZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b042cc39551so318435466b.0;
        Tue, 02 Sep 2025 07:36:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756823808; x=1757428608;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UiAPf+HDKdH8QBueSzvHjjUvhHwaKw+els1x3HrZ4RU=;
        b=ltrKNn373TNmcfP6U/CYqxglsElpy08VH4XRlxHNNR2hrKNavrrZstqIlGBLm6Dldn
         D+gCkwP4FzNczGtd/0iofBFXQY0ZrCExuz6f38OR1YWIYnxhoVBLfFPy7WwPi4riJFT7
         TKZxfMLGsALttTAlSfXdSn5aSY78C4RYa36zmaeamar6R0AP1FaShL2lI5vaaYGFqXk/
         ba9grEr3Zu7TDBvsc03qxwgBA/Pw05QFxdzDQTz6M2RtUvSROwJiy+4m948mkLnDn+XN
         CMtd8T5Rw0LAfqPw6bbvSFnYblXvHfFw1GtqkJwpuCCKjg3Vrw1y/CV1cAoqPQoza/St
         pB/w==
X-Forwarded-Encrypted: i=1; AJvYcCVRFtmq2vnaiwj0tZBR+VbLVpoEXjCZXWxfaI6oQLzsSYxgd4Y75LFjOM6RWIndhcccxUvp8vn14S/NPB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPU4popP4CJmBSOADoSE4fTdDrWUkshXWWbCsKIzDzLq9MFqaX
	B45RceWl2k7Y4jhCsU5g+RTRAobHK8yQAuIZBU6BQYgvbFByyc+zLS2r
X-Gm-Gg: ASbGncujYI4E4o4/ZEPtHHmxSJN0wYWGIA4VK7faU/tPYGkY8/RL8Nq+UPAncBtAceL
	b8mbhW/kfiTAOLRq7BX1rGUKQIlUTzpu3ye2/GCSxgbywM1PrZoNWRJJdqnlrX1sdHGChfUdwG4
	s6oMwuUFDEnHrubJ7qlOU7hwrX1g4yCclm/79OMbzjR5N/JPc0Emlql7JLezXdhu63PbnaHo2iC
	25Z2pgZ1/20MIHWmrXuel2C+TLxNDBUGinA6rKXaZFQnAAOQP12p9kZJjiKr+UBahKsOk4fkHya
	cXHgwWdxpfcDwKJz2GacJ1GTp3jDNj8jVf84vFI9l88jH06/uXZ0w2kMc1p9Mv6OEVl/3y+mYl3
	on36DPYxyYmc2
X-Google-Smtp-Source: AGHT+IFBbylTXgioEB03UJeR/a9ael5sSxKGno3BrjK1Q6HEnT3bGvVV8SiL8gFlPBGOoxtICYj/2A==
X-Received: by 2002:a17:906:c445:b0:b04:198c:54a9 with SMTP id a640c23a62f3a-b04198c5b14mr763047966b.61.1756823807717;
        Tue, 02 Sep 2025 07:36:47 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:1::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b042b0046ecsm523355066b.71.2025.09.02.07.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 07:36:47 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Tue, 02 Sep 2025 07:36:25 -0700
Subject: [PATCH 3/7] netpoll: Move netpoll_cleanup implementation to
 netconsole
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-netpoll_untangle_v3-v1-3-51a03d6411be@debian.org>
References: <20250902-netpoll_untangle_v3-v1-0-51a03d6411be@debian.org>
In-Reply-To: <20250902-netpoll_untangle_v3-v1-0-51a03d6411be@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, kernel-team@meta.com, efault@gmx.de, 
 calvin@wbinvd.org, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=2154; i=leitao@debian.org;
 h=from:subject:message-id; bh=vdJ3o7SQzqokdbSPEfnxGV0IOZXYQuFhEVIrfm9ulm8=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBotwD5fUdVRbJh9XQBsFtAPxXKE9nRNZAr8ehgN
 T8VUZFGtkWJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaLcA+QAKCRA1o5Of/Hh3
 bUFgD/0QFYgP3e916ToEj41ZVMjK8Hy81YOhOrzdsh/fRhQenOOgsfPXPa5TBmbSevlZZ5Qe+nW
 Ati0sKNcuAhwrfir+A2iCgNb2KzFkwhvJOWrea3SMDEmyp8Cs7AbtV65sI5AUI8+pqj0w5amDPU
 h2ic3xNiHxM0ytgibne1aasxf1Q5kKWsU6zQ51EzNZ1Xhh5pQqmuVGC9UfCRczH5ZNhBc/eQNXG
 AcGPfppgEW3PEcSO2GwMH8ff96CKwK6DV33CUlvNcUTf9e8NKCLym3Y9Jru88mo5GqRsV38/uRO
 0JUN7TEPmFDiB/SROV/97ZyIKG4DeFeQunCDFMqgoOr3OXeiDdu3VyWNmlAbaL2nFb4S58Fz4Vl
 P/iwHhTb0UpZgSc75k4ShSWpcNuMcHxuO0YhPLaCpli/3VivMJ0ldbbwlSRYsN/bTcDoKhLu3oe
 +Oj+7wdrfj6tIht+6/mEkWumOc5N1WI6EdOdHKykOOKlrKQ/8oVTqs6SEFJosJPrjpYsYsb//fW
 9c+WGN1k+20B6q+gIZDCEPDphQMVipXOekj2DOKamwFHlG/pm0Mn+5FR730HGVC+qBAl7x6ej6a
 1bJqsFr8yHb6x7TpAtXh+b2saL057ftY4+veU9MtpGzViT9oBQNl52qBNH9a1Lk51hG8k3E/nIa
 YEB2AaE2pObJCvA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Shift the definition of netpoll_cleanup() from netpoll core to the
netconsole driver, updating all relevant file references. This change
centralizes cleanup logic alongside netconsole target management,

Given netpoll_cleanup() is only called by netconsole, keep it there.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 10 ++++++++++
 include/linux/netpoll.h  |  1 -
 net/core/netpoll.c       | 10 ----------
 3 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 30731711571be..90e359b87469a 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -260,6 +260,16 @@ static struct netconsole_target *alloc_and_init(void)
 	return nt;
 }
 
+static void netpoll_cleanup(struct netpoll *np)
+{
+	rtnl_lock();
+	if (!np->dev)
+		goto out;
+	do_netpoll_cleanup(np);
+out:
+	rtnl_unlock();
+}
+
 /* Clean up every target in the cleanup_list and move the clean targets back to
  * the main target_list.
  */
diff --git a/include/linux/netpoll.h b/include/linux/netpoll.h
index 481ec474fa6b9..65bfade025f09 100644
--- a/include/linux/netpoll.h
+++ b/include/linux/netpoll.h
@@ -72,7 +72,6 @@ int netpoll_send_udp(struct netpoll *np, const char *msg, int len);
 int __netpoll_setup(struct netpoll *np, struct net_device *ndev);
 int netpoll_setup(struct netpoll *np);
 void __netpoll_free(struct netpoll *np);
-void netpoll_cleanup(struct netpoll *np);
 void do_netpoll_cleanup(struct netpoll *np);
 netdev_tx_t netpoll_send_skb(struct netpoll *np, struct sk_buff *skb);
 struct sk_buff *find_skb(struct netpoll *np, int len, int reserve);
diff --git a/net/core/netpoll.c b/net/core/netpoll.c
index b4634e91568e8..9e12a667a5f0a 100644
--- a/net/core/netpoll.c
+++ b/net/core/netpoll.c
@@ -703,13 +703,3 @@ void do_netpoll_cleanup(struct netpoll *np)
 }
 EXPORT_SYMBOL(do_netpoll_cleanup);
 
-void netpoll_cleanup(struct netpoll *np)
-{
-	rtnl_lock();
-	if (!np->dev)
-		goto out;
-	do_netpoll_cleanup(np);
-out:
-	rtnl_unlock();
-}
-EXPORT_SYMBOL(netpoll_cleanup);

-- 
2.47.3


