Return-Path: <netdev+bounces-236791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2C5C402C8
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 14:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E46254E9656
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 13:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E044D2FD66E;
	Fri,  7 Nov 2025 13:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GPA4gY34"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951C92D7D59
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 13:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762523107; cv=none; b=htSm0p/mMcPsJNXEjIlajMKPgN6FZKr6QfP9fwCpwnaJNJ3DyYl3+3liiip3ba7RbXf1GydocQGOmlXAobGNkGprKuSIBshzaOcwNSuCeM/MbEQk3Q1QofRPaVM3j5NZrJnK90JIFGCZpCX6a6pKf/6WGio9yR4fEGnd1nzNl0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762523107; c=relaxed/simple;
	bh=Z7b9EvNVsTIOgVW854RzAhYgYT7r8jwyeS6vvlP+sCo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Awmgrkt2f//NPIZQyjy9AhYeszl7Tq1OmIa0SLkrpYEqBMQ3yyMjQekxxKLpfduSzXP8Y7vZqOvjNQvmsh8gP+QY48XytqxcnpBsN68EZMhxviWKitfMCPTcMA0EEpCfSfWOegu6FWtZ2wofJm4tuzSoWa/k+AoFrD+7S4PXxUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GPA4gY34; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4711b95226dso7639895e9.0
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 05:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762523104; x=1763127904; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Aqlg6h5PejcfsHJcPU/gba8WV8jhIrIxPWFwCEoKBmc=;
        b=GPA4gY34GeEB9Wotmac5siDaXgRbSNF1gtenJ+AoQ9brwil7+In/L55Efd50P14w4D
         NOy/z4AxuDp3WUr7iV1W6qr3NpzVPG2m9nyMocKN53A0OtwDTAG9T9Yw6Rj2Pw4joOUG
         eacmb9+rAKIxO5SXJPT8J3x9uMWItH5Kk8A+pxhJVk9bwUYHAhCcgL9DcKp3CmTJrjik
         m5AmGk5lEiznFhJX2qst/VVGpLCAUe9SDzj2i3EQw4viQtkHBRtyFfAEK1aGMDqs/oZD
         wZBmP/egn4BHT/C4ktdSbuIXbUTAGjX0430lJVCGLlZMay7swbPXEGw9ep+Of1xo336P
         SoNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762523104; x=1763127904;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aqlg6h5PejcfsHJcPU/gba8WV8jhIrIxPWFwCEoKBmc=;
        b=RPHrcqwCKfclfpPovDxKj8ZT9yQF2kHqgXlIeaqW2X2ZVwvycD869ZSBxCgpv6bOf2
         V94RZaP2P7iT2au9qFI6+gIw3dCQzSmSQqCR6JFdkHMn7upAFaV1nTJs0oBWUFx8tdJB
         XoFoqGzkjw4gHCU7ZQF3Cs6Ri8//CmfGlMoQ8oY/OSEPLsZmauHS330Jr29sqLHqqjbr
         nh2/ITw+9WPoaievwj4KZp9+iurMugjUr1QbkZAVGdXS0GRrmeOWS4KXjV6tzwchQL/6
         ktjUmt0YUcgYL/h10+0SsdqBB+u9dwok5zUNM4YlJdIMsIoUZu10H9cAB6JYeZp78N4f
         8cBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgfrhMUrRaHjoC8mfRUJ4qAANIB4Msz7laLVWqICMQKkmJ2y9iIFW/Bp95B+kvk6cTV5a1dnM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIepjWC+gc/IF/J7bCYI0zy4EJovrEeiCwBNKVsLNgGWk8I5ip
	QB4Mv1eUvTSskP2bRqR5Ax9Kl0Ws4GO7P3lF8pBGuCQyhYr/4Kt7UH6HPG8sILucOaE=
X-Gm-Gg: ASbGncs2sWBckFdKBiLVcOscs7wqtqQXFEIWpcUSvT3XgJDyQZ2nyMjiDetb3k8sSff
	NFTh1TfiISYYpewgsxF+bod+l70U2iSEIqLXAdhJ5BZ1V3fdJPEhnzTAK6IqHhBfGzQxuGRYacw
	84PvH8I59Q093spVsRpM74Nt+RUQWZbCIGU97RZ1rpCbsK29CAjkaTHeRU+s9y9iBX47ywILTut
	y9BN/it4tmbI//afrkTKmepNqz9IZ5dDTjnUa2GyqAnTY/Uk+KbZNYKyd7f1ajey0ltYaaivPRL
	rgpd4ojz1VjB6kXRQ5xCZ2cGbgOk1mtU3C8tkqddn4J3W3NKUTq1kCew5yaycND1xL8HoZxUq6c
	QbHo15axbe2ZShEXr2+iTuItgvkGYjbET08sLClau2eBstptyqf9/++Mvyh+ftw/h7l2Zb/zUPl
	9God/kcdixL86hHK+oesOXfeZU
X-Google-Smtp-Source: AGHT+IFpZyba28WKyl422zPLm41vfwB1Tx6c+F358chDdmmWGy7/8ZYNpD09113Drv9QcArg+dOETQ==
X-Received: by 2002:a05:600c:1f0d:b0:46e:4586:57e4 with SMTP id 5b1f17b1804b1-4776bcb8963mr24023815e9.24.1762523103775;
        Fri, 07 Nov 2025 05:45:03 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe62b23csm5282046f8f.10.2025.11.07.05.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 05:45:03 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Karsten Keil <isdn@linux-pingi.de>
Subject: [PATCH] isdn: kcapi: add WQ_PERCPU to alloc_workqueue users
Date: Fri,  7 Nov 2025 14:44:52 +0100
Message-ID: <20251107134452.198378-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently if a user enqueues a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.
This lack of consistency cannot be addressed without refactoring the API.

alloc_workqueue() treats all queues as per-CPU by default, while unbound
workqueues must opt-in via WQ_UNBOUND.

This default is suboptimal: most workloads benefit from unbound queues,
allowing the scheduler to place worker threads where they’re needed and
reducing noise when CPUs are isolated.

This continues the effort to refactor workqueue APIs, which began with
the introduction of new workqueues and a new alloc_workqueue flag in:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

This change adds a new WQ_PERCPU flag to explicitly request
alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/isdn/capi/kcapi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/isdn/capi/kcapi.c b/drivers/isdn/capi/kcapi.c
index c5d13bdc239b..e8f7e52354bc 100644
--- a/drivers/isdn/capi/kcapi.c
+++ b/drivers/isdn/capi/kcapi.c
@@ -907,7 +907,7 @@ int __init kcapi_init(void)
 {
 	int err;
 
-	kcapi_wq = alloc_workqueue("kcapi", 0, 0);
+	kcapi_wq = alloc_workqueue("kcapi", WQ_PERCPU, 0);
 	if (!kcapi_wq)
 		return -ENOMEM;
 
-- 
2.51.1


