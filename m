Return-Path: <netdev+bounces-248298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AEE5D06B10
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 02:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E808930365A9
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 01:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DAE1F2BAD;
	Fri,  9 Jan 2026 01:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mk4KkMYc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293621632E7
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 01:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767920953; cv=none; b=P3hcyVjZfOH2D5A1b8iU+XSCuInbZGCs/XrvWsGvPHNZHIU8KPMLtE7DQmoNgNupg5m58tVDcU6QFvTg0r4/jIKZtvcZ+EcCf6ksAAkL6y2ov9MnC7WCa3mKDgZ+U/0BLvUBsdeLa/PPhDEiOECrmIRhcE88ZuyU68yOWvDFlXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767920953; c=relaxed/simple;
	bh=Op1D4JGBOw6dW1leE2O1zi7Myotx/Tp5RPzy4tsAm/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=skcFqJYlkkTEp8UaTM/Ifo1OdnHSG1aiTrn3dunrMs7z5BX2IorESio3IolK3XSXytCJ+aHrWHkcv0udkkbc8Zsa+tymAclOL7+4UWUIDEcYRs5t9i/t2xYel2JWCgs+9c/sDP4kIxtglQ+z6q17lnf7hUKKd3Oo+AjowwDUR+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mk4KkMYc; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4308d81fdf6so1891785f8f.2
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 17:09:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767920950; x=1768525750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZRf1S/pKhh92G5gtxmiVStxeCyhZJoINvG7rPfwHfBQ=;
        b=Mk4KkMYc6uINMLuaKXHNw+gsuoKGMfrVyxJmx4kCGRX7uO2+yEyY3rgBjqap2d0BQp
         rU5L7x19G+iqm9mjt+2bi/7NoYHmQwe+jpUCvZS+Lw2ohKP0CnWqgYaUd+YiKFbVLBww
         EjefexfVhGcM6wRYwagQ8p+9GHo+7UnnUTkAihzP8SFSC3FCzMewqMnsUJecRESBvKUU
         hAiK3Q7fI4VTCffyneYfk59mZjncqO2U6Zr6Dgv1Hv/KE65Z+nvIGDpJYhuIyRvFuzIH
         8QrtqDZupyItRr0qxv/VOjsqxpiRX81vcJ/HnGzHmmtNpMqk3Yp1eH9cC8bXFDbXeQFa
         E+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767920950; x=1768525750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZRf1S/pKhh92G5gtxmiVStxeCyhZJoINvG7rPfwHfBQ=;
        b=M7dbj2EtnAalp+WW7RdNDcyJqi6qHG3ISbFMiF5A2/l5ADk2eZkZCjlQGlD93KD8hW
         DZjj77smrQukKNPlUjEzNn/uaFdlMvxf4b8lBbgQk+dNQ5bipTe+ieSax+oUhkZ1Y4CO
         aF+Voeq5S9eWcdb3XoZLDdpx4+njMtd34cgztpcv9IAuYYyYAcfQMCnNEpHwKkFXWRm2
         VqwgvVvSD3Z9KKSdkPjTfHSj6c4SFFuZJb6/acICu4v4UdnvZUc5eQe+/5RoTdaD8euM
         PbzhJs93hL9WLZXCKB/8dLCNZLaBt5VWO9XsJ4/Z9HHIgAPqu2GBN1i0Eh1QRI79GmYq
         c5+g==
X-Forwarded-Encrypted: i=1; AJvYcCWv0CWd5wFPmOBUSRKGi6eLsIGsJawXCYqFfWkmrZ5gOVy8CdKGcOzk+SyIzBviEdGNzn2FSPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPxoKgFAoIEpEL6n5NzNFCND0N+kmj91SZPeaXGInQXZ1lW7zB
	K9kcmx8Evpm2SgkLCdNayiuSZJ5C0FSCdU0QNT8ZamNTFYCqhUQclVwx
X-Gm-Gg: AY/fxX4FxsdI9PLfhC2p8HmoB+sOIGjkU3Cr0OFWAbP5WzzCf0jUd6jkzZE31lib7OM
	fXmY+VqsdEioaNtOYQbx4zgWs79KRQ7HPq0JxZsn6cNe5bpMmWtdUua96R4NLAF5IINgQAFtZcy
	qKV5MhH96PCX22pI73cGyRbnFHD6Z1E9ykVpesKuTeAxqLkl2YKwS9jO7GH5g4lw76ioIVSYQVl
	JXKDtB3oY9HXYrioS7VmihpxX8swfenUafK3PH9AI69TEOXniCRDCc+6pQUY7RDvMR/ilH1gTwN
	dih7CDF1AOoHshrR29JOeHG0vCALjHiaIfuPs11VNnrUffMSqlcebeogDIjwCY1naoCDzEMB3r7
	hxnUwqNqJttvt+NFlVcGoWrZ8dci9BDBzF50+ll5t7Ftk6Vh8fsmbx+3FewRqeWv86EZ3JdNe/x
	KEitEVHJlUCg==
X-Google-Smtp-Source: AGHT+IE221jfHoMWtPiR1bdRK+Bmhk9UZXI/X3lOz7oVpdDUb0Ux6I8od5an69R4QgV6ZJxvmTnqdA==
X-Received: by 2002:a5d:5f51:0:b0:430:ff81:295d with SMTP id ffacd0b85a97d-432c374fc38mr10771526f8f.41.1767920950433;
        Thu, 08 Jan 2026 17:09:10 -0800 (PST)
Received: from rsa-laptop ([212.50.121.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e17aasm19698214f8f.15.2026.01.08.17.09.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 17:09:09 -0800 (PST)
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [RFC PATCH v5 1/7] net: wwan: core: remove unused port_id field
Date: Fri,  9 Jan 2026 03:09:03 +0200
Message-ID: <20260109010909.4216-2-ryazanov.s.a@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109010909.4216-1-ryazanov.s.a@gmail.com>
References: <20260109010909.4216-1-ryazanov.s.a@gmail.com>
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
Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
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
2.52.0


