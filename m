Return-Path: <netdev+bounces-239354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4516BC67285
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 04:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 34D9C4E1B20
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 03:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB972FB0A1;
	Tue, 18 Nov 2025 03:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FyKKujqN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E12230B519
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 03:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763436836; cv=none; b=oz9XIG+PTqJbS3rSoJLI1HxzDKRtSqrsv+RX5016VrbxOGzCkmk61mHDU96TLKnk4SJsNgdPz91jmFXYFmP3xUCD2NwOdYmn5FwB5CYlAHjWU64G0l6fWDNB9JK2uQiWtz5UTC0kT7roEC2VYOco/pphA3iRPBT9XgXH4hik6kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763436836; c=relaxed/simple;
	bh=geufpOCEDdFKcZ5MrqwwzZdC8+vVlLCwpno40cRwcLQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fu1xuc7xx50zCq0gEBC5/RGJ9Uk4HLoKTFU88dhArojz74FjaFYMEeIfFUeBMLb0eLxztw7Pn9Cxq42/73xD3ZSY58F9YSUhD6Bidz8P6PhdmuLhe1SvahNR5sFV0UUgxbeCadUp4+Iv07p26K8F6sTEv6t/7iSWB/EFMrdS960=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FyKKujqN; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-29558061c68so59006245ad.0
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 19:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763436834; x=1764041634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4POpDdLCAEAaguEwBjZapDEtx8R3iRforMNq6m5UEKA=;
        b=FyKKujqNMMDxGv8e22gg3zoaGD7x8YmwAFHnIB/IaWBNl85Qri1ugt6EVGCH5PlGY9
         uG+WB0WJpdesl52cZabnXcS5WH9aPoDvvHUkDU4he4qvOvuBW059yYdHzBP3Vc1+xsOF
         0saZRjA9mUYPLinG15Nf7Vu/yYbyJbTMmZQfsPdKiN17vcj8y0rfm08ZsvZmRIEUnjzF
         8ZxSO+Llgtw7S5aSssFF+PKBQEU0HDhybJd/qFa/G8LKsUGveEqLrn6LYA5S3UhD5uQw
         ZqbEa5tapoHDxIu4oDoDgz9rgXV2CzibLiH5UD6bt6RwOYaa+8Q7ZYH5L44KyszouHrP
         X9Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763436834; x=1764041634;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4POpDdLCAEAaguEwBjZapDEtx8R3iRforMNq6m5UEKA=;
        b=OzcZCb3kG4sKvccttCirosTbu/Fr9rPrOks0SthYeT2FqphHQStjX6T1hsQ3WzPiE5
         hnYJ17/fJABWug/iuvvCWiFadN6N88kfdZ5LNMWZAJWia50PXOObqNntohhZb7UQIARU
         /XBB8gjLSfcJjt2QCny0bN01ARIXg5CtkfLIwcnaHxIaJ/5JJmtutiS5QsJKPreplbhy
         FXEkiAMFaBvI1QXIfojevPSmShW4GF5xyMRAy8hKIVsBo0KcLgtTJNYNqndQt2K+w1Rr
         qtp9GNN7a8QPB52Az9hRiIRoZkVgN5vaMkWEuiyWAaT+nIZVi9VJdparSCspVYoKhj2f
         iaPg==
X-Forwarded-Encrypted: i=1; AJvYcCXpFB1B3vHk4FdMLk9d4DXjRVsd+XAlw7bGNcRm56+XFJM+ja7cpl0LSxpLzUDszXGRbfwHVkM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBDq3PzyjHezRkU8yOlp9/jDVeJgtlROF75vzB2kJwveGdsQjq
	Ky92jeZOpodlLPUqu8gbAwE6Q/KzmiBo7UL66+rUWYm9i6Sanr9cKz7K
X-Gm-Gg: ASbGncvsLYhv0o1FWNfIjbfgb3xupVrIFxYXxhVDBpADBR8MyoP2SZVsmjK3lZ2w4MS
	yZf0AOQM+NAwtQoX6BvSywa5/kj7DzrqTCAYykFse8jdDluXm52Sb4Uo4y4Ny/+HNaEtvH5Whf7
	H8GugPXiAZOZauN99EleEnV+T1nHCpFal4mMWbl9+lsbuIZQxvBeChQx7t1yggHdA4UNUYrjQQN
	Xov2PJybNt4nTYOrz6vijBCqD3/4qlARwNGdspf04ELZyJ/sgfzlt9p7vWt5QeJe7XJW4MJwRRu
	ZoAuOor99EvKxdg/62exQNq1t2mO/6DI3qfpefbw2Ol2p5yEKp8KSlrD01K8gzwc+TEzoC7V6HC
	VqOG5PkESiKxz66/ZC6W7dS3bkD2m7s8a2CTook4rIhpuhjGkY83elHe/rjOhIuDBWvLkW4g/Sn
	nBC82s5noB2A2eYwqfy5RwVox4WCP1+KzeRsKiUQ==
X-Google-Smtp-Source: AGHT+IGdPC7Cyz7EiLnEPeeedFK9rwJEg8TG2kP1KcNvBMkrm9YQB0epxVT4tlbA7xQi7ezGfVf1wA==
X-Received: by 2002:a17:902:f78d:b0:299:dc84:fd0 with SMTP id d9443c01a7336-299dc8410aemr79764285ad.17.1763436834248;
        Mon, 17 Nov 2025 19:33:54 -0800 (PST)
Received: from bass-virtual-machine.. ([1.203.169.140])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2376f6sm153724295ad.21.2025.11.17.19.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 19:33:53 -0800 (PST)
From: Gui-Dong Han <hanguidong02@gmail.com>
To: 3chas3@gmail.com,
	horms@kernel.org,
	kuba@kernel.org
Cc: linux-atm-general@lists.sourceforge.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	Gui-Dong Han <hanguidong02@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH REPOST net v2] atm/fore200e: Fix possible data race in fore200e_open()
Date: Tue, 18 Nov 2025 11:33:30 +0800
Message-Id: <20251118033330.1844136-1-hanguidong02@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Protect access to fore200e->available_cell_rate with rate_mtx lock to
prevent potential data race.

In this case, since the update depends on a prior read, a data race
could lead to a wrong fore200e.available_cell_rate value.

The field fore200e.available_cell_rate is generally protected by the lock
fore200e.rate_mtx when accessed. In all other read and write cases, this
field is consistently protected by the lock, except for this case and
during initialization.

This potential bug was detected by our experimental static analysis tool,
which analyzes locking APIs and paired functions to identify data races
and atomicity violations.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
v2:
* Added a description of the data race hazard in fore200e_open(), as
suggested by Jakub Kicinski and Simon Horman.

REPOST:
* Reposting v2 as it seems to have been overlooked.
---
 drivers/atm/fore200e.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/atm/fore200e.c b/drivers/atm/fore200e.c
index 4fea1149e003..f62e38571440 100644
--- a/drivers/atm/fore200e.c
+++ b/drivers/atm/fore200e.c
@@ -1374,7 +1374,9 @@ fore200e_open(struct atm_vcc *vcc)
 
 	vcc->dev_data = NULL;
 
+	mutex_lock(&fore200e->rate_mtx);
 	fore200e->available_cell_rate += vcc->qos.txtp.max_pcr;
+	mutex_unlock(&fore200e->rate_mtx);
 
 	kfree(fore200e_vcc);
 	return -EINVAL;
-- 
2.34.1


