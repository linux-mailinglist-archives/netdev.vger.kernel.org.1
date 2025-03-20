Return-Path: <netdev+bounces-176613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64946A6B19A
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 00:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDAE4884453
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 23:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C45A22A818;
	Thu, 20 Mar 2025 23:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9dwpLZv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E11D22A4E5
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 23:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742513153; cv=none; b=QkyqHAA78qiV/qAB6EbpPXW1NueYY/9wTlnqo9TIGlsvQRCd2JoOLtq5Q1h5ii6XnNlVZV744n41LOent4abLsmHGF63+RnRgDPtGkjX8dMq6gXCzLvrwrH6q9jzubHD1TunkoT7P6TO2kTH3fug0gmI9TW97z5xwSTm+KrVTmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742513153; c=relaxed/simple;
	bh=6xAT4FZ8Ia/GP5RFqG5qSyy+IR7iqZyT79R9PR8fpLY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uM0fsVkeIcR5wYbJaqkyzwziPz1rl2aS6EsDANyAFJmZkiGvv0ck4ddGLufz3NEDyLD6jQJl/3Fe87u1gG2WMuL2ZISVkZ8W4wPXbA9mWlVgL1pG/LtDj4ms3E/t3KrOE2+NWgjNhmogVtgrbwcc36zzEim2lckYlosluYKW27E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e9dwpLZv; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-225477548e1so25693315ad.0
        for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 16:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742513148; x=1743117948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=COCG/9OD/BcO1OKsCfXyutvS4gXhQL9GdK8U1ubq8lQ=;
        b=e9dwpLZvgKEe8UzPJpF8SfW6qBWKCLNfQUzTgMnlAZCydkxy4qrNy/A50dzgXO0BVF
         O7d1Xe/4U594kB0T9JkYhVWHxM4XoDI5npiYdOWMvveH69vA8fmUbgmVFM8QywgqyBis
         UnKhxcloO/6uI66FNVwia/EjQU+PLahsR5KmrKzaaADynPZjbYHc9Y1u8vZfvakqsRpN
         UUAyVdgNJQz0SDnLOi/kASl89DELhnuEa4LBuxi8wsnvgPgJd4HoQ0IymSIUJT4t1qhf
         f0InNC4WKD5es44P0h5eiCwOkuuCPtetuAPm2r0H+dSkFm8GzwBoy81CpvgSrVefDiSX
         rDww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742513148; x=1743117948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=COCG/9OD/BcO1OKsCfXyutvS4gXhQL9GdK8U1ubq8lQ=;
        b=wXMZhnODaTjEIvXToD0YIGrqQnGC3WhLPrmD+UOlhuDeVLPeRx2Br9+wCNt2P/uF6s
         zpVJ1ddqoGXGOYTae5xOH1jQBWqv1cjMVrrY/kUZmIbXLuplapeX0gomZRnaD7aJKW7y
         RPcs+HJTHfpKg1Gh0hGe3bgel8lgtLiWdKnUj2LdNl8LDDnaF1Gd/SrTb+i6s69dUEJS
         0+FEFUNxdIxHjP6hjjWsqhVSavPtnBnmHah434LjzvTZlIkObc/uWOuUYoU/J08QYjyl
         mGL+7TdfWIWnA6ZF+mjx+l9MPz5pQnr57AnjQVtbR2z9rnmwojsfE3zEvH+Mp/W+i2KQ
         W03g==
X-Gm-Message-State: AOJu0YwvWhSae0VoZ/kzXwwE8iMmqQZ8dI8a5BA23Xv/Hebw8TAzzj1e
	StnEf+sqrX4Ik69ksrqP9xhmKwF/c/cSqThnfyUEWbfDWd7FVlqhPNGsog==
X-Gm-Gg: ASbGncsdvRCCFNmzFUypqOC64NXOHlUgfLjGbkVFgsHHQtvC620r5O14y1usGuCmKu1
	ObbjkNlNOlaN2jHV7IS1mERgP73gnwBR5iqZrfVoLSpiocKzvhAg/vpQZYNkCHp8/zNAPcz0qrS
	rgPR+ylsYHQo6bRVecd2Ka6cTqSFzpOXCZiKa4EkZ+lc1aKrt3QF9rqL0W8klqy5n3+xYqAFmZR
	crJYEkUbFVoOw5tVZo2JvhvLClxkaos+wAJMufyYY1HGfEVExP5b/dzdUJx4aD2Zpnu8so32yUH
	jf44PBxOmivQBHc2xXO2zB9EJwIgJWISN4IvK7Wz1PMdV517nOQ+UWo=
X-Google-Smtp-Source: AGHT+IGM+oMl4mpfria+dnEEXmH6anHDUzgFlX0MxPbBuUSbJ8wwy9dwDt5WxMgHXo0MNBW4FtZvaw==
X-Received: by 2002:a05:6a00:1812:b0:736:6151:c6ca with SMTP id d2e1a72fcca58-7390598df4emr1836090b3a.4.1742513148129;
        Thu, 20 Mar 2025 16:25:48 -0700 (PDT)
Received: from pop-os.scu.edu ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7390611ccf8sm416306b3a.120.2025.03.20.16.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 16:25:47 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	edumazet@google.com,
	gerrard.tai@starlabs.sg,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch net 01/12] sch_htb: make htb_qlen_notify() idempotent
Date: Thu, 20 Mar 2025 16:25:28 -0700
Message-Id: <20250320232539.486091-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250320232211.485785-1-xiyou.wangcong@gmail.com>
References: <20250320232211.485785-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

htb_qlen_notify() always deactivates the HTB class and in fact could
trigger a warning if it is already deactivated. Therefore, it is not
idempotent and not friendly to its callers, like fq_codel_dequeue().

Let's make it idempotent to ease qdisc_tree_reduce_backlog() callers'
life.

Reported-by: Gerrard Tai <gerrard.tai@starlabs.sg>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 net/sched/sch_htb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
index c31bc5489bdd..4b9a639b642e 100644
--- a/net/sched/sch_htb.c
+++ b/net/sched/sch_htb.c
@@ -1485,6 +1485,8 @@ static void htb_qlen_notify(struct Qdisc *sch, unsigned long arg)
 {
 	struct htb_class *cl = (struct htb_class *)arg;
 
+	if (!cl->prio_activity)
+		return;
 	htb_deactivate(qdisc_priv(sch), cl);
 }
 
-- 
2.34.1


