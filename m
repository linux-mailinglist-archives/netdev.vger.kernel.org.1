Return-Path: <netdev+bounces-68531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C0284718C
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 14:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B7F328A6A4
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 13:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441A41419B0;
	Fri,  2 Feb 2024 13:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dt3ltq+C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E79D1854
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 13:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706882373; cv=none; b=eohY8mZ3FUpiCKL1ND6KzRfO7YhwMi8h+cqlx+BOXW+vVp+Fvl/2uOpWZtLxUo+Nzu7RPP6FTyr8zbfjSIciA1JhWRLCi9AcbSLb9AVTlJ5DaFBgLX2Sz6s2Gwe+mIEuwLAdTbzlnq3QuWg/8G9wBn0y7mJHiXl5Pum43SJJ0YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706882373; c=relaxed/simple;
	bh=9yUub+tmhQyaYt/OP6yNREYuhAW4psGC+k6GPQHLRd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cK2KV8jE/IMWrHPgrrFujp9qb0kdLSh+Q0x5pbkEPTJsBD5iVb4raujrmfsi3wQ4XABDq2ioq+4HGbM4nkX/6DkXd2UTj4ulhWJRYBktQRnPtBNXFikgMc2AqV34LTcxqOxYwaHvbrdNCrAFWsy+nsp5251eBzvMFkAtxTiWJw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dt3ltq+C; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33adec41b55so1335226f8f.0
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 05:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706882369; x=1707487169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=evNUwN+eT+XSWL/lY0Dea6vZTvLFeK9DIXg8vnwMUJI=;
        b=Dt3ltq+CZe3PleT7vkwB2vWpxMmmoCQ2i3OIbmBX68T7/OdtdcoysybLqzm+cEthN6
         rUlGnfOes/hbOPqGWc9Uhzu4oodqL0Pt04FF20OamHJw5WFq0DJsgIEbPJiv0Y58cyp3
         +6k3u4MNcoLOg0qzG3TQ0x8hP+rvOTAoLtpoShOp6LWNtx7mq7lkovxKZva+C8Tt+yBV
         goKmxP/w0IkDg4WNjboWEpdFzQfpR0J8C7Baw6aZ5N8izDVV6wJYzTta5UHTpwg8VSJT
         pfS6qYGf4Y6JF/r5Y8rR24upXuNEzNM92ADkDGldc267G8nfVk/cwdQWhntwq6bPHvOg
         qsdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706882369; x=1707487169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=evNUwN+eT+XSWL/lY0Dea6vZTvLFeK9DIXg8vnwMUJI=;
        b=HMSDVHf0WyNex5COrwLxa+p6oCjX305OxGIaGBMtSZS+TQX/QSKpdl7qsZJEv45Gqn
         SowkxS2dBGEnCrPpeRJ1DkYfjDpjg0f1B+55PXh3j7ZwiWsjN5SwEz+LGDJk05JgBuR7
         lJZ9wMJYiK74HQDxBvkAzCQUnroSOJx7/ZyLJbkijgvWGEbGZvPybBealWD5rxJrWSN7
         7tV7T3+9Q3czrTTgJY195c6IpgY3RcrSQmGhsRvFkk1EzwOUNWEoWNyqzygHtwBeEMTk
         XS2+UiOWuWftCKquO/C5t4FxBv8u+L+gn3aPMH4XPpaZXuwEZ9+GkESotAIhUySjc6+o
         oVog==
X-Gm-Message-State: AOJu0YxQlS7z2i+KvDxS9EDd+uOjJ8l0h1675RUAf2ith7XEtvE279gZ
	8rY0WCOYM2rLRd/OLfEYTCKV4rSvBUOPK7yCun3d/67kvb1fqK5m
X-Google-Smtp-Source: AGHT+IEWEZ3c7VukqBPa77IFiu61BHr7B77konrTPgD64yJNRvnG3Iv9iOcUrtYFSKiSzim89gWBgw==
X-Received: by 2002:adf:a19b:0:b0:33a:e5e5:5124 with SMTP id u27-20020adfa19b000000b0033ae5e55124mr3764555wru.20.1706882369284;
        Fri, 02 Feb 2024 05:59:29 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU/dW7+T25W062EuRTcWpKLg2EEKvKQFg3CmDqFZJHU2dPqrcgisUMyx7RFh7lLrFxJ5gYx1sKWZW4qgQb8u7wkEXJkzhKripcTW1RM9m0Cv8JS0wo2iCVNj8F68uMHvM9HsrTfu3Cc0RZo/DXge/USrvaSywZablSdcK6GnZZvyzkAXAStzOSv2YW1XGHAuudgkzTcwkaGycx+s/vLqBu7z6hAXyUMIFblQck82W7uCztjFUs57w4RvwvnssL0uZk56azci2BldBVwbk5o024duA1LtSCoFVQ/Up6euC4FXh5wvFD1LRHniAJrclI93Lr5umhdsdVzVG1oZNMum7PVxgbJPieMrjzm
Received: from localhost.localdomain ([2001:b07:646f:4a4d:e17a:bd08:d035:d8c2])
        by smtp.gmail.com with ESMTPSA id x16-20020adff0d0000000b0033b1ab837e1sm2003952wro.71.2024.02.02.05.59.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 05:59:28 -0800 (PST)
From: Alessandro Marcolini <alessandromarcolini99@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	sdf@google.com,
	chuck.lever@oracle.com,
	lorenzo@kernel.org,
	jacob.e.keller@intel.com,
	jiri@resnulli.us
Cc: netdev@vger.kernel.org,
	Alessandro Marcolini <alessandromarcolini99@gmail.com>
Subject: [PATCH v3 net-next 2/3] doc: netlink: specs: tc: add multi-attr to tc-taprio-sched-entry
Date: Fri,  2 Feb 2024 15:00:04 +0100
Message-ID: <e14fc185dff74792aec4323249137a2d397d2ecc.1706882196.git.alessandromarcolini99@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706882196.git.alessandromarcolini99@gmail.com>
References: <cover.1706882196.git.alessandromarcolini99@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add multi-attr attribute to tc-taprio-sched-entry to specify multiple
entries.

Signed-off-by: Alessandro Marcolini <alessandromarcolini99@gmail.com>
Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
---
 Documentation/netlink/specs/tc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/netlink/specs/tc.yaml b/Documentation/netlink/specs/tc.yaml
index 4b21b00dbebe..324fa182cd14 100644
--- a/Documentation/netlink/specs/tc.yaml
+++ b/Documentation/netlink/specs/tc.yaml
@@ -3376,6 +3376,7 @@ attribute-sets:
         name: entry
         type: nest
         nested-attributes: tc-taprio-sched-entry
+        multi-attr: true
   -
     name: tc-taprio-sched-entry
     attributes:
-- 
2.43.0


