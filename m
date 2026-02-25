Return-Path: <netdev+bounces-260953-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCxYCzP8nmm+YAQAu9opvQ
	(envelope-from <netdev+bounces-260953-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 14:42:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B57D19844F
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 14:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5C0E31B1BDB
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 13:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F4D3C1994;
	Wed, 25 Feb 2026 13:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="GxCVFlE9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442163D1CB5
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 13:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772026480; cv=none; b=jpxyEW++edfGS4y7xrTGfxBgrjnbarMD3iJZOn4GKRhY4iM3ezCOkpRkl1niHgEmCoJqMvjbnScxU9a2wJxSa0+QZQedPhgMn1DK3Sbii6H+Whmrh9nuKWVBbKEJZaaKwcPuiVNnUxCzZIqbOCm9zLx5TfzB2c0sDbEF6FW2uzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772026480; c=relaxed/simple;
	bh=z40VzN7RJg93nuVTx3uJj/QFEihxo6bbSBkIUN0ad9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b1R7ycpOFEA/Nzp8r32gqmH3ZxCOCSVMNL6J+gHPIF9o3D7p+6KaHcMbgWBi09Oo1UwbbxHM5icGswKxDuREK7VJCC2biVIlsKM67fIoM8IIG/mfRQjL21TvzswKqAk2o1HdVmPD/e9tA1a5lePvJu0+Dxx9IYf/2gMBwAfGTso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=GxCVFlE9; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-436234ef0f0so4600305f8f.1
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 05:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1772026476; x=1772631276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wQ4paXHHNx1lbVehk+CL3CnGm7xq68IcRaSeIPyM4M4=;
        b=GxCVFlE9w7w5HUov3ZrFteu4Wm8d0T+Ec+z+g9I7ZLDLOHXLkgpuUSvrglJuAKF5Tn
         6ciXqENK4sSSw1OaEuFX0hOfXvrdVMEmIGho4THe/JrEEZPkjomdhy9++5q8jQb55uzi
         Jk/LmGl82eQZ92YbQQxKA5vRIxo86HT8cWFJPiokQQHhWMhxtMqAV/VtUJmOqdjkiCxg
         VDKVDqaRbvG2PvE7i2H5fq142F7iClzmn+B6OYqmM26AnzelbtQUE1gbfGpj+Py85FeX
         2k/+LpNV5uPoSQoGp/2hWfbiZ2zLX5csqGRZ3Uc15Ygf8IDSTUGFYC6OFj63BloAlHZR
         p2JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772026476; x=1772631276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wQ4paXHHNx1lbVehk+CL3CnGm7xq68IcRaSeIPyM4M4=;
        b=cYUzP50+u8kfqi+4O2P6XwK7Enr8jOviUHZB2n10ujHP0Vfyv4/QW8Vv+BJmLXfsy7
         NXaBkvI44roh7MRoVYhzCLRzGLoM1E2jr8jg+xklErhrJnUddo8Lym7mHUT5nwhCqAci
         u4XyTiIzHdzvo9juJTkmAqmZSOfcHrIrUY8Aukbqt29iyHZXFfY4/kapu60wq0u8QcMn
         a5uOzzA54DmZvV1mtthur+ODyIjb2e6Nivge2/AzJkhyIBIzzTfdb98aQuaZcwt4q2Au
         QMnB9sJZ2LYeOrLcQL1j0YJihZwFs4NJq0n3ACBtj88ZJY4gYhVus9bM4LZ/7U+fpIlp
         hMjg==
X-Gm-Message-State: AOJu0YwIVzQnrYI5d3zA31RXBxrxhWULEPXL1wm4FJX8vzoIm2vd3Rfl
	HZIMKzKMhXQ1E82b1SW2ol/bLp6qy2QrrgGuK6ZZo7R7ZHNrSeqpUsKSjBSEgayjdZvMfMO7LhC
	hVRLagtw=
X-Gm-Gg: ATEYQzyvXj9WGGCFeEXgjjz8eL/gDfYHTaMpxy8d6P+Upffj2PLYhq8KpTig6ynLGxP
	7met881OUo0REn48g/SrG1rOzY2jfCXQ0x1275WLtVJX4tzJcvs+FF4sWR5uO3AmGupTCQPlK58
	e9pl33K5fQRSIHx31HwBL5ZLZ4o+Mmeoq1H+qenaUgnJhXCYs8kfVa9GlaltvsSlkAT939UO2xJ
	/sT1740qYfFUyTphmFbY0M40pqKQ4pIumqZHYg4egcAr8tvY/KoC7115uYLO9uPMsmMOfqaLRnc
	qnh6zRlIXXQVEy/xP/vWM/57MvyAtRMZ+ACOMUf0TcjAHTFK4+yGHod+9Bn1pZFtvUsEX+G6ZPX
	RVPkH/m4jqC8GwU9sH6e5wmwFBFYjx3yEUL9sTYQHZjTNHBz6AtBTZkVv4sTHZjITrwU/KISLqv
	FxXQd29a2mo2FiBVwtIXSJf3hs
X-Received: by 2002:a05:6000:2403:b0:436:1590:f9e7 with SMTP id ffacd0b85a97d-4396f15cd3amr27471526f8f.12.1772026475499;
        Wed, 25 Feb 2026 05:34:35 -0800 (PST)
Received: from localhost ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43986aa2f84sm11713836f8f.7.2026.02.25.05.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 05:34:35 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	donald.hunter@gmail.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	przemyslaw.kitszel@intel.com,
	mschmidt@redhat.com,
	andrew+netdev@lunn.ch,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	chuck.lever@oracle.com,
	matttbe@kernel.org,
	cjubran@nvidia.com,
	daniel.zahka@gmail.com,
	linux-doc@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH net-next v2 09/10] documentation: networking: add shared devlink documentation
Date: Wed, 25 Feb 2026 14:34:21 +0100
Message-ID: <20260225133422.290965-10-jiri@resnulli.us>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260225133422.290965-1-jiri@resnulli.us>
References: <20260225133422.290965-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,lwn.net,linuxfoundation.org,nvidia.com,intel.com,lunn.ch,goodmis.org,efficios.com,oracle.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[resnulli.us];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260953-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[26];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.961];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,resnulli.us:mid,resnulli-us.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 9B57D19844F
X-Rspamd-Action: no action

From: Jiri Pirko <jiri@nvidia.com>

Document shared devlink instances for multiple PFs on the same chip.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
v1->v2:
- fixed number of "="'s
---
 .../networking/devlink/devlink-shared.rst     | 89 +++++++++++++++++++
 Documentation/networking/devlink/index.rst    |  1 +
 2 files changed, 90 insertions(+)
 create mode 100644 Documentation/networking/devlink/devlink-shared.rst

diff --git a/Documentation/networking/devlink/devlink-shared.rst b/Documentation/networking/devlink/devlink-shared.rst
new file mode 100644
index 000000000000..4043f6647243
--- /dev/null
+++ b/Documentation/networking/devlink/devlink-shared.rst
@@ -0,0 +1,89 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+========================
+Devlink Shared Instances
+========================
+
+Overview
+========
+
+Shared devlink instances allow multiple physical functions (PFs) on the same
+chip to share an additional devlink instance for chip-wide operations. This
+is implemented within individual drivers alongside the individual PF devlink
+instances, not replacing them.
+
+Multiple PFs may reside on the same physical chip, running a single firmware.
+Some of the resources and configurations may be shared among these PFs. The
+shared devlink instance provides an object to pin configuration knobs on.
+
+The shared devlink instance is not backed by any struct *device*.
+
+Implementation
+==============
+
+Architecture
+------------
+
+The implementation uses:
+
+* **Chip identification**: PFs are grouped by chip using a driver-specific identifier
+* **Shared instance management**: Global list of shared instances with reference counting
+
+API Functions
+-------------
+
+The following functions are provided for managing shared devlink instances:
+
+* ``devlink_shd_get()``: Get or create a shared devlink instance identified by a string ID
+* ``devlink_shd_put()``: Release a reference on a shared devlink instance
+* ``devlink_shd_get_priv()``: Get private data from shared devlink instance
+
+Initialization Flow
+-------------------
+
+1. **PF calls shared devlink init** during driver probe
+2. **Chip identification** using driver-specific method to determine device identity
+3. **Get or create shared instance** using ``devlink_shd_get()``:
+
+   * The function looks up existing instance by identifier
+   * If none exists, creates new instance:
+     - Allocates and registers devlink instance
+     - Adds to global shared instances list
+     - Increments reference count
+
+4. **Set nested devlink instance** for the PF devlink instance using
+   ``devl_nested_devlink_set()`` before registering the PF devlink instance
+
+Cleanup Flow
+------------
+
+1. **Cleanup** when PF is removed
+2. **Call** ``devlink_shd_put()`` to release reference (decrements reference count)
+3. **Shared instance is automatically destroyed** when the last PF removes (reference count reaches zero)
+
+Chip Identification
+-------------------
+
+PFs belonging to the same chip are identified using a driver-specific method.
+The driver is free to choose any identifier that is suitable for determining
+whether two PFs are part of the same device. Examples include:
+
+* **PCI VPD serial numbers**: Extract from PCI VPD
+* **Device tree properties**: Read chip identifier from device tree
+* **Other hardware-specific identifiers**: Any unique identifier that groups PFs by chip
+
+Locking
+-------
+
+A global mutex (``shd_mutex``) protects the shared instances list during registration/deregistration.
+
+Similarly to other nested devlink instance relationships, devlink lock of
+the shared instance should be always taken after the devlink lock of PF.
+
+Reference Counting
+------------------
+
+Each shared devlink instance maintains a reference count (``refcount_t refcount``).
+The reference count is incremented when ``devlink_shd_get()`` is called and decremented
+when ``devlink_shd_put()`` is called. When the reference count reaches zero, the shared
+instance is automatically destroyed.
diff --git a/Documentation/networking/devlink/index.rst b/Documentation/networking/devlink/index.rst
index 35b12a2bfeba..f7ba7dcf477d 100644
--- a/Documentation/networking/devlink/index.rst
+++ b/Documentation/networking/devlink/index.rst
@@ -68,6 +68,7 @@ general.
    devlink-resource
    devlink-selftests
    devlink-trap
+   devlink-shared
 
 Driver-specific documentation
 -----------------------------
-- 
2.51.1


