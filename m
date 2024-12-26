Return-Path: <netdev+bounces-154275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C4C9FC7BF
	for <lists+netdev@lfdr.de>; Thu, 26 Dec 2024 03:59:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BD8D1621D3
	for <lists+netdev@lfdr.de>; Thu, 26 Dec 2024 02:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F7D28DD0;
	Thu, 26 Dec 2024 02:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JSBACtSc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA7417C77;
	Thu, 26 Dec 2024 02:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735181947; cv=none; b=iq9qo9SEahwIteFZb2PIZFynkuNZ5PXrauQDnXotV5i3mM9Ox5BsQ8pU4LbUUM7x9TFNVRj/UTCTzwbwgrzsC3oZH0Fx5StzfhK4pCUDqs+7M5ICv7rayLvvmJtcZ6H5ixKxCZwPEwcXltkgCX2tJd+qPxAUsnnXCg7jX9MOn9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735181947; c=relaxed/simple;
	bh=SX7fG+4ct7xmQUjmLm01ARQJbwHNjskjGmKj5a0zJi0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=iFUExuiBuSlBBDjdjExhg0bo9OZI02QQV2GGDkjkzZ7WhMk0B3UURTfDeweHZBSfHyFff0ULvDysQM9l+EkuC9++5NfClf0//4mVGwdJ9gdujNOzrI1JiRMaXq6H76GBOyfFaL4qbzScEwXj+3+ZTwUyvVyb0UvnXlI34uzc3RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JSBACtSc; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21644e6140cso72319935ad.1;
        Wed, 25 Dec 2024 18:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735181944; x=1735786744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=V5Fnrp1f1JlDdT/D5esy9KCV1pUpCmiwpWEZqSEq1K0=;
        b=JSBACtScPjY2XxbkDSYyF4FQSbUsI48PJyau6CsORL9wxPM3dlXHM56R8Xf0cB91Cs
         4CkXPe5SvB9kfsmCfqPRgVhg7/eOTOsRo/b2Y8FaONcEMT2KJrzlb6SpXqPyC/jXxDrf
         vITu2suTEBlBCSRQrbxEDwgHpXImkKY06mUWD0DGxbZTNUvKm/UQMMdsDE7hiLD/ok4g
         X1x2QOBPpqNiCI5ejGu7T46wxYOfvS6jH0qbV/EXhQRgkQVKRxhZExjZjsjXzD5RbejI
         wT7UovvlVFYTJcoQ0q5panlxUYXczi+eznc5dumGRZHkCwMyPScxl8CxX5M48HDAN+1g
         jubA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735181944; x=1735786744;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V5Fnrp1f1JlDdT/D5esy9KCV1pUpCmiwpWEZqSEq1K0=;
        b=rp+g7K6CIv5oaxxWsQPSB92GMRlH3rpEqRpAgHPN7ivIgOKLX9yUMZoa1Dwd32WxSe
         IqbZI+ikOEFC+ytAY9Lwlfpxp0rZocPK1G1ttVNiwEfxjJCQF/RztSZocIPvFAi0bZiN
         LtwxNOaQXNDvtjHjobBegJbIEAHHcxI5m/dW8MAiWx8aBtQjkY++AqxzjvMuSDR7JQcL
         7eCkMxAyRy0jGw7nlr3XUxIZcHA/6kNiMIbiFhXXOV5OcQvsGGZLYhOfpBSslWHcEiLH
         cggfKzL/CJ9bUSXMmvl/pmJQC0U5eSAhiAnn8FzhhB/y8x2FodjGqxQIYjLQ2h9Pn5k1
         wCSA==
X-Forwarded-Encrypted: i=1; AJvYcCUENt99ITP526Eboj6lJVI9PYr7VvI1b4NZXQsJI5UEoi467/rH2DX/k5vijhiYa+okDRhgGlopORAm4Ew=@vger.kernel.org, AJvYcCWLXT2ZrUVYLZApDJ3lYDgle9rq5UTy2joArzrdaDX09dIobFMkjXhs2d08/umJhI9LW6SMh/Eh@vger.kernel.org
X-Gm-Message-State: AOJu0YwqncQwsawoOUHVuX5EIuUORxG5WPEf//xJ94aDBA1loRiNF8oW
	QkVNoNXH2KvHQCP+hSaVKZf89ap9yDeWQGmDNiZdOy7vGzZ0qj8K
X-Gm-Gg: ASbGncv9Z7Wcsp3KvDc6pJCTqiyUwMJ9oNQ+DU5ndLK3IfUusETCDZIsvcltT2MWuMR
	79sRXQIGW6h3IKtFg6jS/+RhlfHjB03vjdYuEXEr8Q2BWnuAnCFp8aCMMw+G+x+x0M/JeScgETR
	Eg2dfM4TbVio9+vJBD6ICRzCh/sPJvn2sJUCwwWLhf0nIPyeG4r8BddkqoKw+W1JdOc/vN8JFcm
	908eCuIEseGz7SEBGSph3iNqzCB/igejuG+2+K8ZUg4KtRogr83AYBJYNbThPQRRb8qIF+qYA7F
	PVaFHPZWxV749UfHgcrus8nAIW66jyGs2o30
X-Google-Smtp-Source: AGHT+IH+n9nsHCIIOzxQphdVwadS6NK75QI0/XG7wNQ6rq7g50ixS3vO8soHVH9sw1PT6opM+o7TmQ==
X-Received: by 2002:a17:902:f68f:b0:215:63a0:b58c with SMTP id d9443c01a7336-219e6f25f6bmr309864695ad.46.1735181943959;
        Wed, 25 Dec 2024 18:59:03 -0800 (PST)
Received: from leo-pc.tail3f5402.ts.net (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dca0282fsm110470435ad.259.2024.12.25.18.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Dec 2024 18:59:03 -0800 (PST)
From: Leo Yang <leo.yang.sy0@gmail.com>
X-Google-Original-From: Leo Yang <Leo-Yang@quantatw.com>
To: jk@codeconstruct.com.au,
	matt@codeconstruct.com.au,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leo Yang <Leo-Yang@quantatw.com>
Subject: [PATCH net] mctp i3c: fix MCTP I3C driver multi-thread issue
Date: Thu, 26 Dec 2024 10:53:19 +0800
Message-Id: <20241226025319.1724209-1-Leo-Yang@quantatw.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We found a timeout problem with the pldm command on our system.  The
reason is that the MCTP-I3C driver has a race condition when receiving
multiple-packet messages in multi-thread, resulting in a wrong packet
order problem.

We identified this problem by adding a debug message to the
mctp_i3c_read function.

According to the MCTP spec, a multiple-packet message must be composed
in sequence, and if there is a wrong sequence, the whole message will be
discarded and wait for the next SOM.
For example, SOM → Pkt Seq #2 → Pkt Seq #1 → Pkt Seq #3 → EOM.

Therefore, we try to solve this problem by adding a mutex to the
mctp_i3c_read function.  Before the modification, when a command
requesting a multiple-packet message response is sent consecutively, an
error usually occurs within 100 loops.  After the mutex, it can go
through 40000 loops without any error, and it seems to run well.

But I'm a little worried about the performance of mutex in high load
situation (as spec seems to allow different endpoints to respond at the
same time), do you think this is a feasible solution?

Signed-off-by: Leo Yang <Leo-Yang@quantatw.com>
---
 drivers/net/mctp/mctp-i3c.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/mctp/mctp-i3c.c b/drivers/net/mctp/mctp-i3c.c
index 9adad59b8676..0d625b351ebd 100644
--- a/drivers/net/mctp/mctp-i3c.c
+++ b/drivers/net/mctp/mctp-i3c.c
@@ -125,6 +125,7 @@ static int mctp_i3c_read(struct mctp_i3c_device *mi)
 
 	xfer.data.in = skb_put(skb, mi->mrl);
 
+	mutex_lock(&mi->lock);
 	rc = i3c_device_do_priv_xfers(mi->i3c, &xfer, 1);
 	if (rc < 0)
 		goto err;
@@ -166,8 +167,10 @@ static int mctp_i3c_read(struct mctp_i3c_device *mi)
 		stats->rx_dropped++;
 	}
 
+	mutex_unlock(&mi->lock);
 	return 0;
 err:
+	mutex_unlock(&mi->lock);
 	kfree_skb(skb);
 	return rc;
 }
-- 
2.39.2


