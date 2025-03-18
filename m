Return-Path: <netdev+bounces-175803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DD9A6780F
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 16:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42D2D1707A2
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 15:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FDF720E339;
	Tue, 18 Mar 2025 15:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="JOImvvIX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53D720FA98
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 15:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742312209; cv=none; b=MUVJfDhP+uN2b+tqQ/5MMAtlnRyXoxt4ypdEuKZzjdpBMBKK8yIEnnk0gdL2uwSF7btwkM3sb3mWoPceof4+tlP5qF0X46R6y2ZxkVAf9OEmiZhIwfh1z0C99Hme/k3QjyrT8pZ7MvvmUEERda+yNc+Xe1Oe/+3GcKftHGuwy7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742312209; c=relaxed/simple;
	bh=PGlbXScemvaDyH4TxR4GSRe6Njs2b8zlIwIBZVQwo18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fyQHnUrzvLwSeNpAl10OQTTdNY7qmPz+xxZ/85it/7snttD5bJVP3wlc1ayTm/9oie3+FTfcfHnBSDFRNvJu4R18zhq0sbAvrWMUL9tTAoApl9k+JC9ith8OhuX78W05AlstdMBzFX6hwvBv/iOgNZhvlqDzdMWrHhyFHXy//Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=JOImvvIX; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43d0618746bso27065905e9.2
        for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 08:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1742312202; x=1742917002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u8j6HJ/LXsaiiYYsFgCSAtpRLzT4odfs6A0txp6rEV8=;
        b=JOImvvIXDgK9FsiI3B2mG8MJ9+FNuCK2NjDjYuavhyXcDY9r2A4uBJRJlyQGyQdD1r
         HpSsCxeQRkTkDEN5oXp7JcoNsmeSPOGl+nMeQCDP6TCKUzcng5e7WfbQiVhHo/yerB60
         htVEwbIUzh8/VpToHyAf37+e4EWlql+nKPDJe7yRcO5s2SINGurXBHNWRBB6HG/xLDW5
         Jv/7sHq1BYSlctj4fdS9reGnGTk9SvEx6dvFydHatm5S3KlQlt0D+eC6TFNiQW0NNlhm
         tkix/VTI6WUrBPiQL4RSBunN7Gu/QpfpCbAmpIC+VHDRDJHxFFImeAuxyC1hFydei9x4
         gnXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742312202; x=1742917002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u8j6HJ/LXsaiiYYsFgCSAtpRLzT4odfs6A0txp6rEV8=;
        b=UGbMb4lQuuQTGGwCFNIE2xuSYe6kprpCcCEgqiu2SXGj394HFcvCehuuMi3DnrOBfp
         Kft1AkkEJ9B4diTjtKMOc+srGwGRBiua2eHiZzjvTYmcYhGHbVnUW/E85PQqToiQBtrm
         8Zk0h2q7y6A1pNRoVAQVp5YX8VDnVmT+ZKFisrhn2cr9p0tOZsghawHsL2X83zke1zGd
         jw0wEwUtBaLg4ll+fcbb7/k+aAczKY3HCmLnrJYBKfoEcgE8vjUfg7o6UsbNyoUX0yMK
         MvJg/2RLW1GHojySp2Zl3g0nZglcEUwVbT9RlXpxG4v6WIzI4ShgpWlyBLjYUboPwfdx
         eMDw==
X-Gm-Message-State: AOJu0Ywnh1+73yRfKRTd0YPn+0ivGevEZI/wcgNKDgSuAQpxTkRSMzyv
	GAc3qFpb6CPpkUAI5AAQ4UqRoWVgtox+RMCuYF+yebiX+oMPpDZyjaJ0npWz8yFWsB8patj9MWQ
	c
X-Gm-Gg: ASbGncshDn6KF1a9/NBPVvXWIju3xyEPmg6IX1MCy/LUTuT29Ao0hvf90m13tCkTzeq
	XUwjOje2bqnLvaPlUKQDsURSL6xUKXb0hwL47OjcgLR8pdJ4T7s/8zC+VbUJCmB0IRB1Dhkm0qi
	rbRZyZa+r/4KWfp4x6t3Vsx5RIztIylRkS9HK+kPTcRgLf09zo/yvav0lKrQra1LPcd6cNvNXNZ
	0oTbZaJyBgpWVqINp8x+9QGG4POOR/FT85gkU6e0w8F0byw/y9FdHYHRR07xaJqk0m7qSAyTzLJ
	kovNI+A7+bJR90tknbWJH+bUaiXDx44S7DVcgw==
X-Google-Smtp-Source: AGHT+IEBGGYzQbEmEn90xv9VamN9pFtpDpHco/XFe0t/mH4e0dpEJ1hbJBX6QSfTRqr1d2r9mBtSaw==
X-Received: by 2002:a05:600c:4fc3:b0:43d:ce4:ef3f with SMTP id 5b1f17b1804b1-43d3b9a9571mr26048635e9.12.1742312201855;
        Tue, 18 Mar 2025 08:36:41 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1fdda2dbsm138634165e9.2.2025.03.18.08.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 08:36:41 -0700 (PDT)
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
Subject: [PATCH net-next 3/4] devlink: add function unique identifier to devlink dev info
Date: Tue, 18 Mar 2025 16:36:26 +0100
Message-ID: <20250318153627.95030-4-jiri@resnulli.us>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250318153627.95030-1-jiri@resnulli.us>
References: <20250318153627.95030-1-jiri@resnulli.us>
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


