Return-Path: <netdev+bounces-178343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EED1EA76A83
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 17:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77D3F7A1DFB
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 15:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97C421CC4E;
	Mon, 31 Mar 2025 15:06:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C22D21CA0F
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 15:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743433577; cv=none; b=NOaIbbaSvIr6/1hih+zcAUE8X2OztdT1UuEQuaK0VqymFrutWt24g1NKZn3I1yyzgt6AgALLvJLgfcGypYnsNu4MeEPvhsv8dEuw9ZZOFuWNBJ50c1xDUhUjHMyrJjBNoDqjd8uyBcl2oRVOzh2cByvdHqQEZFXYF9nfAmXoAdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743433577; c=relaxed/simple;
	bh=Btql8D+z61PeUR/qioHKtwL89Uw5YMz8yU1zPEYt1Xk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i1a0zCex71YWw87RpZ1lq/kALOvxM91jYH5eg4s3kPR9qPR0jty2pEgY/Rbi57R6LxwKJdWjHzY7KGRP3DNjDuCPoXRbBbbTHChrUTNx9GsQvSLQqVLCickQSwIfZu1cMHDGLoEKr0ELxPG5Ec9uvB8pdlh0Rab6ePXT3Jmzhm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2279915e06eso92829615ad.1
        for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 08:06:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743433575; x=1744038375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nGUsnZ7P/Gy4hwM2m6cRQua0QteAzaougsYbfzZVkYM=;
        b=HZZd37Zk5q2gqyIZUKlRB61xjTw/dQWF/ilslFwI/YJF3jaiv6xIV8lmKrv4OPuA7t
         UfoRnvDsgWhYMNim0KyV6n03l7nGteqBmjqdDJQ1vGPmcyyX88iPuCFUgPW9UFjQmyto
         2Q28Vc6fAE6tFN8QPhs43/irIqqHE24gVqdQtEBZi4LtyuPdWECqTLA58chKvTNZKY1D
         gKAWmHvkeuXj8teod/v/pj8RnA/x93H0XPP8whQpVZUmEGouanBoMIkMQPAz1aC6uxWC
         8H5TRrbXAAzYwpWDBIeMU2BxnFflG+bYc3/Jmt2OoCDTl5QCOfzKoc3b/ENKPmmus5rb
         UU6Q==
X-Gm-Message-State: AOJu0YyD+ZdgDr4QM8tCso3t8dOJZ+92otTcjISq6Pb+Ags4WXfbPZ4k
	aQn5rouPC1dVZ4DutVRs1oNKn8QYSCtKAUPRCU9L7PhXdtKBOFnxTtCm
X-Gm-Gg: ASbGnct9Qt2IlEjSXkXLWRLb0KIW5GgYBKPM8QJtAaWTNwl0ItU4W4XBmwHwbZTBfl4
	3u3y5iK6N14yfbCKGuVmsS0phh73RsdNUjoMqNuRgPJ05HRpCXb9x+aESUv2kaUTYa/GsKYHyFq
	QiOppR7xOk+lZBfysyxzk350Gw3Bfqr14gigruHY/j8ultqfz8zONzde2VWjxb3ulYfJor4GAY7
	VTrCDYzULsZA2HSjCp+KU4lTop/9ao9S2ayGPvBF/Wj3dEMvWdtzGqE+789SRqo6N/5d+OAzUzM
	53GQx+H2VTM7+3gcxPUvhWQVKRgEPYHWNs6SgIu2cm4J
X-Google-Smtp-Source: AGHT+IHQ2bgIM7pPDRSzLksxKkHNI5uFFb5Bcwj4aEaoxGGQHMhlr0acq2eRMrWxQao5QHNOAS9sVA==
X-Received: by 2002:a17:902:d48a:b0:224:1ec0:8a1d with SMTP id d9443c01a7336-2292f9736aemr130542395ad.30.1743433575383;
        Mon, 31 Mar 2025 08:06:15 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2291eee5011sm70568485ad.103.2025.03.31.08.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 08:06:15 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net v4 07/11] docs: net: document netdev notifier expectations
Date: Mon, 31 Mar 2025 08:05:59 -0700
Message-ID: <20250331150603.1906635-8-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250331150603.1906635-1-sdf@fomichev.me>
References: <20250331150603.1906635-1-sdf@fomichev.me>
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
 Documentation/networking/netdevices.rst | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/networking/netdevices.rst b/Documentation/networking/netdevices.rst
index ebb868f50ac2..381243c002c1 100644
--- a/Documentation/networking/netdevices.rst
+++ b/Documentation/networking/netdevices.rst
@@ -343,6 +343,28 @@ there are two sets of interfaces: ``dev_xxx`` and ``netif_xxx`` (e.g.,
 acquiring the instance lock themselves, while the ``netif_xxx`` functions
 assume that the driver has already acquired the instance lock.
 
+Notifiers and netdev instance lock
+==================================
+
+For device drivers that implement shaping or queue management APIs,
+some of the notifiers (``enum netdev_cmd``) are running under the netdev
+instance lock.
+
+For devices with locked ops, currently only the following notifiers are
+running under the lock:
+* ``NETDEV_REGISTER``
+* ``NETDEV_UP``
+
+The following notifiers are running without the lock (so the ops-locked
+devices need to manually grab the lock if needed):
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


