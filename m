Return-Path: <netdev+bounces-176429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A85FA6A3B8
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 11:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E77784607BA
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 10:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2559E224888;
	Thu, 20 Mar 2025 10:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="gQiV/y56"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0C3222580
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 10:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742466715; cv=none; b=C22zBJlM+xG9CkAEtm9tTHOqducvz4a0+JpIEtyye8wF6VUGhsqAlKbE3VAtl70/HerG1jMudomDwb6H+YIcY73Dpzhw9WDnkf4T2a9t3hxpfGCPsR5Zcgp0kllb+bMPTMh1TLPqvzxbLQwH21jFVV5PScYVt27WTgCJeX22bLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742466715; c=relaxed/simple;
	bh=PGlbXScemvaDyH4TxR4GSRe6Njs2b8zlIwIBZVQwo18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DERItAuEY7npiLmew7vn1gamObd+jwphQF+cYV+d9OiLAJ+/yDa3CoSJFY9EBt7UyYyXVvEXAGRwDVD9nYUZJ4Dtfv13UlwKU29ujvzF7EMKyV+AIDUoWyqJ7OZQC1d6T4DX4CJHNUvEl3uJ6ZfQVR84blOtMiD3qf8bHXPhpLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=gQiV/y56; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cfb6e9031so5653015e9.0
        for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 03:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1742466712; x=1743071512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u8j6HJ/LXsaiiYYsFgCSAtpRLzT4odfs6A0txp6rEV8=;
        b=gQiV/y56x6h8pOJfr/PZLdRlC+er9YD3/hu10L4KhguWvpwMHirfsVcdRliDM+I+hG
         LQTPbQ/R5XIKP1EykwfzkccYbCKKaVvo/XPtVcf0RvxDWlWQE2faPCLf++Hw4rtLiTPt
         +s427bH47TsxcPEbE+7wZe18rATDzig33frdPmSOXyBeXrA93FW5jYlmYL3fblKC12E/
         aKOyYCklxinN7k6tqMi7eEzDMYanFrvErINx3c9amSH9W3O0CG4FiVbar/KcoqC4zXu0
         OZojCLW6usJoW/cRP6cPoMYsa5eZB0kmjdFo+7rD9BkA25eScpG/3Zra3TJD7cfXjwDr
         05QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742466712; x=1743071512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u8j6HJ/LXsaiiYYsFgCSAtpRLzT4odfs6A0txp6rEV8=;
        b=kmqMiSM34AaQpgm9MMNN8XwCycxW3NkLiQZ+uKpv5rE4JWHMOdHsKXbkcRoz1GsO5m
         p0mDql82eRLHRn1pueoP70/ru6+xYCRsBye2k2IDyx3jkioifb3qBKTJQphi7zIDDszU
         DjH5lj+RrkX7/IjjngZ2Rj4PnEBALEMuxfZ3l9qQu/qkcrjLPUC6az8ilSHb1c8twSDz
         GECkQ1/BN3H3UhbkVbeYZ9TwlryJ61UX+1rjcewUpjkT9FFqbwzUEkwewFL/Q0SKplPL
         /RInTubv+hLRQWq9RgmZXaXKJ4JumNMXDWSH6/x51w9OZDSlB/7n7ArywD/vdTzrs9at
         Lvcg==
X-Gm-Message-State: AOJu0YwjvYCQq1jjbNOU40zcdbKN+cqdexqK1XcAQI0UyPNmBM478Pyg
	0qE4MOEBv/z3AoCehyMQ+Zv2w5Dna5JYjxr4U4e9Ac1vFMORkR/psxHXh0r90TFy1VwKge94BwN
	X
X-Gm-Gg: ASbGncudGQWU9knvpoSLBxPoVxn7+m2pcqZRSR6DXbTjHWGG9WyR+RRYarqHAfZZUJr
	NwpMgpJP31u2+gvhaeSjMi0uwdUq6bfiEA8TOzHuAznl/ktbrkvWEehmSlyG1EwuVxu4u2elT+m
	vyMFmYXEghfA6vZEaqUAX1cDyQhPuzbtTq+3KaQzXjrk8WnBSxVL8+CHNf4e6I3Rk2/+H1aah1e
	pNCD8GGnQ3pwja1uhYBYkbyhIxC/zZp4BA99r/ZVR7syU2jwboa98gJ3dplgU8XFfZJpUxheN7L
	hfOjZAdgPHo/IeWuipBHJz4snsEXE9D93/HfUg==
X-Google-Smtp-Source: AGHT+IHbO9kWmKhlqULTvr15OdzXjzIOmpibMXW/gZ3PABwoRdfm5OKUIrPs+pmV23VHI2NMjljfMA==
X-Received: by 2002:a05:600c:1e89:b0:43d:762:e0c4 with SMTP id 5b1f17b1804b1-43d4389954fmr47884335e9.27.1742466711439;
        Thu, 20 Mar 2025 03:31:51 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f4542dsm44087255e9.15.2025.03.20.03.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 03:31:51 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	leon@kernel.org,
	tariqt@nvidia.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	parav@nvidia.com
Subject: [PATCH net-next v2 3/4] devlink: add function unique identifier to devlink dev info
Date: Thu, 20 Mar 2025 09:59:46 +0100
Message-ID: <20250320085947.103419-4-jiri@resnulli.us>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250320085947.103419-1-jiri@resnulli.us>
References: <20250320085947.103419-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Presently, for multi-PF NIC each PF reports the same serial_number and
board.serial_number.

To universally identify a function, add function unique identifier (uid)
to be obtained from the driver as a string of arbitrary length.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
---
 Documentation/netlink/specs/devlink.yaml          | 4 ++++
 Documentation/networking/devlink/devlink-info.rst | 5 +++++
 include/net/devlink.h                             | 2 ++
 include/uapi/linux/devlink.h                      | 2 ++
 net/devlink/dev.c                                 | 9 +++++++++
 5 files changed, 22 insertions(+)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index bd9726269b4f..5d39eb68aefb 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -820,6 +820,9 @@ attribute-sets:
       -
         name: region-direct
         type: flag
+      -
+        name: info-function-uid
+        type: string
 
   -
     name: dl-dev-stats
@@ -1869,6 +1872,7 @@ operations:
             - info-version-running
             - info-version-stored
             - info-board-serial-number
+            - info-function-uid
       dump:
         reply: *info-get-reply
 
diff --git a/Documentation/networking/devlink/devlink-info.rst b/Documentation/networking/devlink/devlink-info.rst
index 23073bc219d8..04afceee0c03 100644
--- a/Documentation/networking/devlink/devlink-info.rst
+++ b/Documentation/networking/devlink/devlink-info.rst
@@ -50,6 +50,11 @@ versions is generally discouraged - here, and via any other Linux API.
        This is usually the serial number of the board, often available in
        PCI *Vital Product Data*.
 
+   * - ``function.uid``
+     - Function uniqueue identifier.
+
+       Vendor defined uniqueue identifier of a function.
+
    * - ``fixed``
      - Group for hardware identifiers, and versions of components
        which are not field-updatable.
diff --git a/include/net/devlink.h b/include/net/devlink.h
index b8783126c1ed..a0b84efd4740 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -1846,6 +1846,8 @@ int devlink_info_serial_number_put(struct devlink_info_req *req,
 				   const char *sn);
 int devlink_info_board_serial_number_put(struct devlink_info_req *req,
 					 const char *bsn);
+int devlink_info_function_uid_put(struct devlink_info_req *req,
+				  const char *fuid);
 
 enum devlink_info_version_type {
 	DEVLINK_INFO_VERSION_TYPE_NONE,
diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index 9401aa343673..816339790409 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -614,6 +614,8 @@ enum devlink_attr {
 
 	DEVLINK_ATTR_REGION_DIRECT,		/* flag */
 
+	DEVLINK_ATTR_INFO_FUNCTION_UID,		/* string */
+
 	/* Add new attributes above here, update the spec in
 	 * Documentation/netlink/specs/devlink.yaml and re-generate
 	 * net/devlink/netlink_gen.c.
diff --git a/net/devlink/dev.c b/net/devlink/dev.c
index d6e3db300acb..6c442549722c 100644
--- a/net/devlink/dev.c
+++ b/net/devlink/dev.c
@@ -763,6 +763,15 @@ int devlink_info_board_serial_number_put(struct devlink_info_req *req,
 }
 EXPORT_SYMBOL_GPL(devlink_info_board_serial_number_put);
 
+int devlink_info_function_uid_put(struct devlink_info_req *req,
+				  const char *fuid)
+{
+	if (!req->msg)
+		return 0;
+	return nla_put_string(req->msg, DEVLINK_ATTR_INFO_FUNCTION_UID, fuid);
+}
+EXPORT_SYMBOL_GPL(devlink_info_function_uid_put);
+
 static int devlink_info_version_put(struct devlink_info_req *req, int attr,
 				    const char *version_name,
 				    const char *version_value,
-- 
2.48.1


