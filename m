Return-Path: <netdev+bounces-200852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2546AE71A2
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 23:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D6575A5AFE
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 21:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6839D25A326;
	Tue, 24 Jun 2025 21:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HxO+dAW8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D92718DB02
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 21:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750801145; cv=none; b=ZGn3xcN3/9cBCMUO4rjTH4qtCSvrOiU3O2f4qV1+iksdRPboInZZZ6ZWQMr7q7o9hreYtky8woSVo1OsN4WEcxra79EcKAeQgG/Wl7p/VM/SVMB/0emw/2BGnBad6tk7E55z9iXnYx3PjUJ4VJgDCw91Gr4iNemQXoYvJKviRCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750801145; c=relaxed/simple;
	bh=APecu0CD7hzQGbyaX9KHhphZWBd8jPoY4kkLanLPRu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mu9e4B892QiIbswrlIpD6TgUYUJXfwFAL3yjkICcJuKa8c6Uj9N8auMKwV9/OfvAtl1y4BXDcQ9SfxVQHpRV7gtkVbCGgG1sW0IpqN0tXI8NDvk3M0LqBSEWVLY5UpiYMYRWnEphKIswEbmAws6hFspvP0jTNNc/Mm6FIhXkbkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HxO+dAW8; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-451e2f0d9c2so1935755e9.1
        for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 14:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750801142; x=1751405942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Pn3ECzRuO0G3ipawH9Q5ttCzZ5TE15zhfVxUeJMHoo=;
        b=HxO+dAW80m3pQTy8tpZJiInCxgsp4i74ndzhxH/xr5Ut4z55EPhoH9jEI4C7cKkIX+
         elwJTCXzgLRmxwdElf0LiNanDJ8yKxXyqPzZFzQxWoIxsloWglg/pjhGR5qP8Gw52L7i
         9LhnCXYt6o/B2kseXXtSedyrun2Xis0qdYVcvqm8TDkpEnQRTD85iMYaTV3YIgibwD2X
         54SSvl914/h1GYgxFmQFRAl74za5ovd1HjEDWcHzqXZQEmjbKf2evQcyggdwBUCPt5I6
         KqnnOgQj/jKXAI3TRhaCV66SPK4RxPEPHTe2gGxFXhHMsm835WeyyhROiqlM1ORv9gt7
         +9Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750801142; x=1751405942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Pn3ECzRuO0G3ipawH9Q5ttCzZ5TE15zhfVxUeJMHoo=;
        b=INUyC0NHQnsETVRF9vHNs5yQA1uAtaWvLKdmAswNq9CohXfJasyirNKh/ALsPL+WjQ
         Vp76GMYdCbMKIBi1tnSeeek6ImwNcvdxL+ZA1/PkDxvtNsMm9L58DfYPuaPosWJK/beL
         honNOnFSimMMnfxoiwZsGHTIFCEQuzW1rT9XS28NsSsGqAFrAHIygO1WgT2ftYPSJYaA
         gG2IUP1XSvv3YrhrJKPaqlv/aAznLqWOsO8KKzNMICke5tIjXW1pN+EgpAQ874a8JXL3
         +U9bEgpTJa1qqQ8Kok/POCfqzTs6IVYQ408Gwp48QsI0kEU2C7I5HokaVXaTa0Bz4f35
         VJ9Q==
X-Forwarded-Encrypted: i=1; AJvYcCV1yh/yb6a1uZyb+H8rZRm7CBnugGrvsosSYIPtdVDByuakyE4mf/LzQocSlOS0kHIN6tAUFP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWBKZIpYDOM49c7HuJerx+bB8aWUFM0pNgf0OCGYtUX8IlC5oY
	VrIMsdlshoHDni9ChP5lO00p5GldbnKf6ImkWGpRwrXG4BsS+LtCycbb
X-Gm-Gg: ASbGncs1J990bJJbx+ZvJIo2/rgYKk+XZ9BIEDa5MnFJbvjZ9GNHmki8Pdi0kvyygXq
	CayVcRCPQRmyUmuZGX9oZeS6wEknbfMDWjBqRVLvEUidXtkhxzz6JUIVz0M2vziCRqdH0dvajg/
	kIzT1FvnNT209pq/nwJrWANrkfGwL6GRmv+WVN7aA5cpgKKBiqblky+l/CStMTAXK323OBMRdNP
	kXIbAQ2f/C9dvvQgcW82HV5qbaDlHabC5m7+9/nogQuioedLWGmt5pGgGTpuflUJiwsFqB0udnD
	82HtffpfOZu+/DndieZPbpQYzTV6L7dj1pdoZKzzY3y+2xcEKTM3rn2AbESKaau55jdq6g+ymRC
	4
X-Google-Smtp-Source: AGHT+IE3msP+w5S/4UTsy7v3uF+ovi7Bshg5nXfagh7QE7bLjwaWAJ56DZunmfAaCf1OgHtCRaSSRg==
X-Received: by 2002:a7b:cc90:0:b0:453:5c7e:a806 with SMTP id 5b1f17b1804b1-4537b74f71bmr34227985e9.8.1750801141762;
        Tue, 24 Jun 2025 14:39:01 -0700 (PDT)
Received: from localhost.localdomain ([212.50.121.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4538234c9c7sm851415e9.10.2025.06.24.14.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 14:39:01 -0700 (PDT)
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [RFC PATCH v2 1/6] net: wwan: core: remove unused port_id field
Date: Wed, 25 Jun 2025 00:37:56 +0300
Message-ID: <20250624213801.31702-2-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250624213801.31702-1-ryazanov.s.a@gmail.com>
References: <20250624213801.31702-1-ryazanov.s.a@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It was used initially for a port id allocation, then removed, and then
accidently introduced again, but it is still unused. Drop it again to
keep code clean.

Signed-off-by: Sergey Ryazanov <ryazanov.s.a@gmail.com>
---
 drivers/net/wwan/wwan_core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
index 63a47d420bc5..ade8bbffc93e 100644
--- a/drivers/net/wwan/wwan_core.c
+++ b/drivers/net/wwan/wwan_core.c
@@ -43,7 +43,6 @@ static struct dentry *wwan_debugfs_dir;
  *
  * @id: WWAN device unique ID.
  * @dev: Underlying device.
- * @port_id: Current available port ID to pick.
  * @ops: wwan device ops
  * @ops_ctxt: context to pass to ops
  * @debugfs_dir:  WWAN device debugfs dir
@@ -51,7 +50,6 @@ static struct dentry *wwan_debugfs_dir;
 struct wwan_device {
 	unsigned int id;
 	struct device dev;
-	atomic_t port_id;
 	const struct wwan_ops *ops;
 	void *ops_ctxt;
 #ifdef CONFIG_WWAN_DEBUGFS
-- 
2.49.0


