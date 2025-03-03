Return-Path: <netdev+bounces-171385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75619A4CC6D
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 21:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4A1518967BA
	for <lists+netdev@lfdr.de>; Mon,  3 Mar 2025 20:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C18238D49;
	Mon,  3 Mar 2025 20:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RRFK5+IW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB5C2376EC
	for <netdev@vger.kernel.org>; Mon,  3 Mar 2025 20:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741032154; cv=none; b=RFcUjfQmDCLuU/kv91jlwcFV8E3xvBLuQcvfQ0QcuncaAGc4XiGPVZfhKCKujlnzWrO6Ue3RKQA52qA7jSbNcoiTs8tdxlBMf7IdtJSZ5BBMOt/C5mOGZSMAzNNNMPBFfgxi2Yq9T8hn4AZ2Qb7TBj4ufp32sZf6uci3QIJl+yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741032154; c=relaxed/simple;
	bh=VFQeuhQrmXgZOY+JfXBPbjeF37rWPb4GdeTObDb2Rf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QlN9hc+iMsChXO7tgyZzy2xJr3V6IuQfXMSlTq2Y/DnWVoX4Iv0Mwo0/KaH0/D51VHRCPTnn5FJcWU7E+ks8O6hVrYSz/sutpXoUTuGXsMeqcqtImXCx8800Wg+d8GZVozok6csmcKyTdgRcULimMSOg8lZOrSGTn3Brdb8b0zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RRFK5+IW; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2238d965199so35667575ad.2
        for <netdev@vger.kernel.org>; Mon, 03 Mar 2025 12:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741032152; x=1741636952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bqs6enPVx21oxb5GivnZU1DWbwEExp/3gOjrVfmP78c=;
        b=RRFK5+IWJQs3c2TMeNytKYerVfuXWNDsh/vWTzYJFLyt5xnIaTtm9JinCt1oMOMKpY
         LdvKYI+FXd2jgoq9fGh0x06Jgre6UYIS2yUiep0+mMa1+V3bkeq9CNo4qEghokE2hK2D
         N7r4Ctpe2UhwMS/kNzfVlJcqsKs1X8aOa13uo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741032152; x=1741636952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bqs6enPVx21oxb5GivnZU1DWbwEExp/3gOjrVfmP78c=;
        b=uYzkV3PwBveAbJ5eZjTggLUEpbU1NlKlpxQXZ+WO0L3fJh044NXY4e8QwufSYNoNzG
         i2I3RsojSSkdcndqPOT64+4GAzccfnYKZuCVZ+jFT2O+OOxpoAPJ5Qxob3l6YIF20pP/
         4L1LHSxCcIaAJp+YrUq4xRPUxrfkYDmy36VExlAegpuuJCk5HIw0Kvtq9/8LrLKXfPvu
         pcdbSOHJKLYC8k0+Q9m7+VUp+MTkNDW1en3vSkoCWryFEncW/gNAgUJal+lXR4IyXPTr
         17Eeul+9IPrfWiU9VzQkpClXvO4kV7XK6QY+EWIQz1uUxE82649xEbr3Z1Gb1GKOa6IP
         QmPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxrHmTkMzhF0x1vgKFTi7lEtCn0uVC9v6wXRESX9zhXDjZ2oCdxUZRIlhCLDf1K5bvWiZ3HV4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8YR0XqljJCPkrHLF8+sZv6mMzbNKiFb1RDFlFigBFh13rM7b6
	wEHdP/sg4TckDC3xBaPJfnm0D7dqPhmGMqcfhgsiNfQhgCkgaaNKC3ibcWF15A==
X-Gm-Gg: ASbGncsJNvZgz66qAzqGUPSeloaeCYuHu2r6gep02ckG+r74M/3gcWsHgSQEiTQrbYv
	TKBV7BSus6NDh6KsNOgGpX3LsWXeynm5Y7UhIE06PMgQxKnFe29CDKZokOYl8Dyp8/UbX/DmJBC
	IywfMqTB2IFrPINzlnhCBdnWvubmkVp1XfsJwqSE05ngjssCPFL+mYnprq3ClloSeEDtqZF/Q1G
	UymsRV8NY9z/d4cfmedeUluHTX/vxrh+vd0T/OM9PJH5yNPFA+xdVeVkbHhL/OYNYvuXYneGbqH
	rVri8t6jzkUf2kjBhZtafbby/5SxBSetHaogi0d8H+oFIRsIDXG3QmYh8XQD43feiWe2NTt5ZEc
	RC28mU/aL73LlEZL9qJpnG2mUWf5tjHE=
X-Google-Smtp-Source: AGHT+IHEpC0wzYC9qpTOKYzyBCFKX1RplbM8mEpi5mu7LaJ5QXKsMTUayHNtXumG2Q6HyHXT6kFqmQ==
X-Received: by 2002:a17:903:198e:b0:21f:988d:5758 with SMTP id d9443c01a7336-2236924e748mr224147945ad.35.1741032152431;
        Mon, 03 Mar 2025 12:02:32 -0800 (PST)
Received: from li-cloudtop.c.googlers.com.com (4.198.125.34.bc.googleusercontent.com. [34.125.198.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504dc4b4sm81233875ad.171.2025.03.03.12.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 12:02:31 -0800 (PST)
From: Li Li <dualli@chromium.org>
To: dualli@google.com,
	corbet@lwn.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	donald.hunter@gmail.com,
	gregkh@linuxfoundation.org,
	arve@android.com,
	tkjos@android.com,
	maco@android.com,
	joel@joelfernandes.org,
	brauner@kernel.org,
	cmllamas@google.com,
	surenb@google.com,
	omosnace@redhat.com,
	shuah@kernel.org,
	arnd@arndb.de,
	masahiroy@kernel.org,
	bagasdotme@gmail.com,
	horms@kernel.org,
	tweek@google.com,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	netdev@vger.kernel.org,
	selinux@vger.kernel.org,
	hridya@google.com
Cc: smoreland@google.com,
	ynaffit@google.com,
	kernel-team@android.com
Subject: [PATCH v16 3/3] binder: generic netlink binder_features flag
Date: Mon,  3 Mar 2025 12:02:12 -0800
Message-ID: <20250303200212.3294679-4-dualli@chromium.org>
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
In-Reply-To: <20250303200212.3294679-1-dualli@chromium.org>
References: <20250303200212.3294679-1-dualli@chromium.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Li Li <dualli@google.com>

Add a flag to binder_features to indicate that the generic netlink
feature is available.

Signed-off-by: Li Li <dualli@google.com>
---
 drivers/android/binderfs.c                                | 8 ++++++++
 .../selftests/filesystems/binderfs/binderfs_test.c        | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index 94c6446604fc..b3d21ccd81f2 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -59,6 +59,7 @@ struct binder_features {
 	bool oneway_spam_detection;
 	bool extended_error;
 	bool freeze_notification;
+	bool generic_netlink;
 };
 
 static const struct constant_table binderfs_param_stats[] = {
@@ -76,6 +77,7 @@ static struct binder_features binder_features = {
 	.oneway_spam_detection = true,
 	.extended_error = true,
 	.freeze_notification = true,
+	.generic_netlink = true,
 };
 
 static inline struct binderfs_info *BINDERFS_SB(const struct super_block *sb)
@@ -619,6 +621,12 @@ static int init_binder_features(struct super_block *sb)
 	if (IS_ERR(dentry))
 		return PTR_ERR(dentry);
 
+	dentry = binderfs_create_file(dir, "generic_netlink",
+				      &binder_features_fops,
+				      &binder_features.generic_netlink);
+	if (IS_ERR(dentry))
+		return PTR_ERR(dentry);
+
 	return 0;
 }
 
diff --git a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
index 81db85a5cc16..96e64ebf910f 100644
--- a/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
+++ b/tools/testing/selftests/filesystems/binderfs/binderfs_test.c
@@ -65,6 +65,7 @@ static int __do_binderfs_test(struct __test_metadata *_metadata)
 		"oneway_spam_detection",
 		"extended_error",
 		"freeze_notification",
+		"generic_netlink",
 	};
 
 	change_mountns(_metadata);
-- 
2.48.1.711.g2feabab25a-goog


