Return-Path: <netdev+bounces-177626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C11A70C11
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 22:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F397317B464
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 21:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A282D269CE0;
	Tue, 25 Mar 2025 21:31:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B4325EFB9
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 21:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742938268; cv=none; b=LuQ4xYG/f58atHDHdkqon8dEk9UjUjsASbzzNMAXTQlJsZXfx3rlGsCd9sHC3NQP4xhIaKe89U5u9DX9SFlVGzck8PjWz8PWHbUcPhFZFg1ZojOF1Inl/yNmgCSJcUE/R4PybdK2K89EvJNNQ+Pc32YaMvMTlYdkpHIpZKqCtsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742938268; c=relaxed/simple;
	bh=n97bsKeGNxiCQENyEnu04SJHTKTffra3u3PkxcA2ORQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jLer7bpebVzuxSWmlJqzKOpFMarZnDk2vMDnRLlrgxiUsglwPzaeAvFpRiff06ViqMjhtCvoYloykZzQEADfrfhsoDA/GYoISmHDyYyF+p8gLObcGeseHqyC/kAAYqm4+gCZOz//EECdV7ltwWEzC7tHlflhyDnEnzk/mIlOMp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-301cda78d48so11696306a91.0
        for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 14:31:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742938266; x=1743543066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SR4152Dd3dI58fOWxtoFrARZtfVG4WmmakmPAvGHxzY=;
        b=wzrYYpYH9Lh+By3wnhkOCr0i1MdATP4svlLPkFKjiYNiCzqOFM1gvTj4M+Wx3tC+L3
         pJIp+//YGHYFa6M5ph7aeNi3M02vws8A5Vj095lRnGvNENRepYCIhikazvb4wDyNBGA5
         3QnNgyKld3V/y2Z/znChqXeoQOSaxAZ473Nf6l8LYetSut0eKLn0++svbVSgBMbLKjm1
         BTigX4qNHuTAyHvRC4v38xxm/EwLTpwheR+VuWmiXM3dM8daMmcxK72V5S7hBvbVi6zQ
         Onn05aQ3KqIwwJ5Fawv1km/lgCCLvST0B3OiEhis0IJYBRkTZFbPOmglBVYqkJRXRtbt
         JVUQ==
X-Gm-Message-State: AOJu0YxHTV8s+e/QOVn2XuiSG4thIs4eLSfQnS/UqkIafInkmuJW5wvx
	olw6FFrq+T02z3T2/AdLcAorJxTMTx5Wqm8qm6mVHK/X+EJgrcgCdK1IUFCE8A==
X-Gm-Gg: ASbGncuHfKnbEtPN5SNspG+y0lax5pM/1rLAbrbWwp/HP5AuWMaYkBlU1qf5RWp2hT4
	T+zjEHTyc+f8TuvhgNNTHZKhh2xMpSFyfS7N4Dk4abZU++M9pQfbLLGmMtOW4HCsk68ZEOoe+0P
	IfqbzHZuCMd9sHlQkg+3OxChGHr8Iz7PvWEo2KFqYAvO2Xb91ULDBMoUNIkZ/HoKPTjw47nOY+P
	HSNUq1jxXtOf6vTwoaepQoJ1/AGbezTDbYX/ntuZC6G84R0fONr5dqBOSrXXNiZcY58LcZoHfLS
	gvlCW+w9cRHLU2YVtL5/tz4NxuX3+M50D9Slevvlvnci
X-Google-Smtp-Source: AGHT+IEJRO8qGZLVcBLFShtZDMdmOIGOp0JTzA9EUpr3eXlJBWjPtXrpQuUF+Fx0IEiyH0aui9flxg==
X-Received: by 2002:a17:90b:314c:b0:2ee:53b3:3f1c with SMTP id 98e67ed59e1d1-3030fe59853mr28286864a91.5.1742938265969;
        Tue, 25 Mar 2025 14:31:05 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-af8a2a4747bsm9550172a12.68.2025.03.25.14.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 14:31:05 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next 6/9] docs: net: document netdev notifier expectations
Date: Tue, 25 Mar 2025 14:30:53 -0700
Message-ID: <20250325213056.332902-7-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250325213056.332902-1-sdf@fomichev.me>
References: <20250325213056.332902-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We don't have a consistent state yet, but document where we think
we are and where we wanna be.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 Documentation/networking/netdevices.rst | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/networking/netdevices.rst b/Documentation/networking/netdevices.rst
index ebb868f50ac2..89337cfec36e 100644
--- a/Documentation/networking/netdevices.rst
+++ b/Documentation/networking/netdevices.rst
@@ -343,6 +343,24 @@ there are two sets of interfaces: ``dev_xxx`` and ``netif_xxx`` (e.g.,
 acquiring the instance lock themselves, while the ``netif_xxx`` functions
 assume that the driver has already acquired the instance lock.
 
+Notifiers and netdev instance lock
+==================================
+
+For device drivers that implement shaping or queue management APIs,
+some of the notifiers (``enum netdev_cmd``) are running under the netdev
+instance lock.
+
+Currently only the following notifiers are running under the instance lock:
+* ``NETDEV_REGISTER``
+* ``NETDEV_UP``
+* ``NETDEV_UNREGISTER``
+
+There are no clear expectations for the remaining notifiers. Notifiers not on
+the list may run with or without the instance lock, potentially even invoking
+the same notifier type with and without the lock from different code paths.
+The goal is to eventually ensure that all (or most, with a few documented
+exceptions) notifiers run under the instance lock.
+
 NETDEV_INTERNAL symbol namespace
 ================================
 
-- 
2.48.1


