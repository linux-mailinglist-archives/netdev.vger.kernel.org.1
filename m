Return-Path: <netdev+bounces-242033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22690C8BBB4
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 20:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3BEC3BB911
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 19:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2FC343D60;
	Wed, 26 Nov 2025 19:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nbTQiVfO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857A53431EA
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 19:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764186784; cv=none; b=u42i8lEay47eKenZOn/IgCrCUl0PGfIUTcEVzrnnJnHCU1L4lZ4zU1nwv/KpGrBePS8cVusNuPjlfYWt+kksjc3mC1sH2habbF68haHZ5UtznqiF8Acl9Y/rWhjLNpA34lqH009vCuigCP7m/3ZcGh2REwp7WR2KUg2i2yrlFaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764186784; c=relaxed/simple;
	bh=GN1KTseUoZt1EJY8jO1TcwpoKGYx8enhO4YsvSD9Cig=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kkEYS1G2a+4K3CsQYSpuNYndB7aVk2LqZu5lsxx+H4nfupgkiEn5vaLYTP3DgxXPRubCes0QznsBsnPdV0c6D6sA1QTUcRegJPaa0CWpFMo7SkRARnbCS+oelalM7yC+g1F1yY3BtRvk4RJFzjnRKExI2i/z+J0OBvEgSG1jy28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nbTQiVfO; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-29558061c68so2105105ad.0
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 11:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764186781; x=1764791581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O0kbfjqzJuO8B68doTUDhyPOoKMp5lApsYatEA7vKt4=;
        b=nbTQiVfODxu8pWwomVGc8a8JA11/oYuD2KgJvx9ZBVu/ZZB2IALlw+jmISi7XR/RKw
         SejueWRJAz72aTLxM6gFN01O/3T7d80phI7gQLDm0PoVHC+GBafcBsMfHsvogDlHuNGz
         eVgV4BaS6r/fFqaASV9OKsfIzXQcusI7iu3xN57zxisXlG04qxoLq/paLzG015ASSx7D
         rCA6IWP0UN0W9bqnCH/YPHJeGTuAKkxpb78EwAzVHZaqzVCqGlQrHlKHu0/IVFz7U3ck
         mYXF1Pn+sGySFRCzo3+HMFzj7hpeyX7xrFJbYVYhRRMl108r5EhsIeQOTBM+O4V9VTqL
         Jb6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764186781; x=1764791581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O0kbfjqzJuO8B68doTUDhyPOoKMp5lApsYatEA7vKt4=;
        b=ureBjerGYKLwH/7VMhlL1Y9RSt0zWzxjAbyomvQQAAo/TveBunGnw/6PZwe8CrigTK
         gGZ1LlPpLawLJ5YtCRhyHNt0i1mg5IkkNKLIBic0iulxoSTJ1zm1iooV0wheG83Hewmn
         yTyty6hWTA8+satjljoCdI3aHoYU7i47vIMLQAJmnJNdtId+GQ6xzEo4NC+lo1eWh8B3
         eZvu3wa9p5GNNxnETyGFOsBsuNTNe1K8uLkvtUx51eVug93OZTnfJlyW37x9QjmFztjv
         Z+fAO9c7cCGHVRkqYKQB3dmF7B/aj+vSK//yeu9t6CzVGge5JAzRPc0RdQlNTSY9oNbt
         WpTg==
X-Gm-Message-State: AOJu0YzKHaWgbnIQRTMxY/o1HHUGYNNBV5PtRSqUnM7JNf8AAtvwJdUj
	HzZbd9+lQoOG2T/+S7u+nUy49Yjj4gmhuFUhDBSlVAEKVG74TuGhhj01VixQ5aAj
X-Gm-Gg: ASbGncsFUmqAvCpo0mAMrXTjyBKSPbkX1/UlrRBt9NWssFnICFaCDr77yITUW+1Tgsj
	Oz1ewweQ6ufMufntGNAP6sP90awtOKxrE68aL14vTrEGMUWwLZExNzQqIUt0booMkf5pno9bYS6
	hy0eqsr6N8Zq/hnKoF00v23NFaLiljqqBiI7EpFLRXjjwSLsjpfAI83RSAwPB4DH7Vxlq02qhWe
	X0MM2KQglmrL5uRtQ10JCy0VLQDj50p+2siLW/nnN1BzBWhdFM9wY1icgA2yYwldtpJpIN3sTBv
	79IthfIr3EBjaJEPTAeFYdCqqy6YwcK8VdZkbAcF5w+5Zo4OIoGeid068/ZyX57kTcmQGo6SWMx
	ZmrHSM0uQxeHQvwUm6fj8We1wEznq7cdJ3MQm+r9uFHZc7WNjuPsfXmOrEVHAxrOM+I5VOxncql
	8SUV3HdqNy+EKRkg/sH9fnpg==
X-Google-Smtp-Source: AGHT+IFByspHHXycYSC5oQaR1C44P5K4XavyiTE/6x6Z6ChjSZcC1Qvv14WkPLYb5AGkh4g4qgyYgA==
X-Received: by 2002:a05:7022:e994:b0:11b:ade6:45bd with SMTP id a92af1059eb24-11c9d708d4amr13999184c88.8.1764186781321;
        Wed, 26 Nov 2025 11:53:01 -0800 (PST)
Received: from pop-os.scu.edu ([129.210.115.107])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93db4a23sm101508235c88.2.2025.11.26.11.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 11:53:00 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	kuba@kernel.org,
	Cong Wang <cwang@multikernel.io>
Subject: [Patch net v5 4/9] net_sched: Prevent using netem duplication in non-initial user namespace
Date: Wed, 26 Nov 2025 11:52:39 -0800
Message-Id: <20251126195244.88124-5-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251126195244.88124-1-xiyou.wangcong@gmail.com>
References: <20251126195244.88124-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cong Wang <cwang@multikernel.io>

The netem qdisc has a known security issue with packet duplication
that makes it unsafe to use in unprivileged contexts. While netem
typically requires CAP_NET_ADMIN to load, users with "root" privileges
inside a user namespace also have CAP_NET_ADMIN within that namespace,
allowing them to potentially exploit this feature.

To address this, we need to restrict the netem duplication to only the
initial user namespace.

Fixes: 0afb51e72855 ("[PKT_SCHED]: netem: reinsert for duplication")
Signed-off-by: Cong Wang <cwang@multikernel.io>
---
 net/sched/sch_netem.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 191f64bd68ff..f87b862c769a 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -991,6 +991,12 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 	int ret;
 
 	qopt = nla_data(opt);
+
+	if (dev_net(qdisc_dev(sch))->user_ns != &init_user_ns && qopt->duplicate) {
+		NL_SET_ERR_MSG(extack, "Duplication is not allowed in unprivileged namespaces");
+		return -EINVAL;
+	}
+
 	ret = parse_attr(tb, TCA_NETEM_MAX, opt, netem_policy, sizeof(*qopt));
 	if (ret < 0)
 		return ret;
-- 
2.34.1


