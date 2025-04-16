Return-Path: <netdev+bounces-183693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A42A918FB
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 12:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27E63460B0A
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 10:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA1E22C322;
	Thu, 17 Apr 2025 10:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="VAHNcqlS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BDE22D4C3
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 10:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744884863; cv=none; b=b6DsDIF1/+2xXtUhhVsx3oybfSbUrg6TPveNCiNiJ1fkqbam6CiU6Vw9aK7p6DSJO/UQYjHkgWIMcHWmcMx04fOEi6h+kTTHfu3ozo4wtmAJQ5gZAYgmMXirlCZZ2YV9jMUdIDrGPJCynJEEhE1RAUq3e8/MVSvvtqmOyNpEL8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744884863; c=relaxed/simple;
	bh=25f8SIJju/5ivilnPjUhfmqcpVjfTVqI74xcOmF1hQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r5XCsf2eZhiYtMi9Eb+UYw4hyBj4TOisz6lNLOrg2+NgsFlH7Z31xUzuT6Uvyvhxkp7Krc3nD3DbtZCyU0OT4MnCjUNJqk0m9B525pH0f3b3Of0d2973XXYxnJtHWtcrRhMSvx8VdMP/IU/fKZpcPhKKhS54CjXF0W+bNCWzn2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=VAHNcqlS; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43cfa7e7f54so3899005e9.1
        for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 03:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1744884859; x=1745489659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FztzwBNl0ZFpHfxwLXmfn6WleVneBnBReFpn/yDBVsA=;
        b=VAHNcqlSr0D9pXwJxGBhm4f5/u+1laZQ5+TJjdCQr3hucp0Ptd7JSKBFuKI34YmbPq
         zHRgWeWpdiZmj8lphOM/isOzDvECMb+ItUIzNJQHGRuLJx1/6z1LIoTBSlynfWryKm8g
         LO1tOECnjTPOKAFkvNCD2JnQ3zg22GKvwPoJoyiN741i862CJ2Wdj4ViFh/oejanylcl
         m8CVw0uTTCiHPmQIprmJpCzDPyNR6NSeGmWgmAADaqn5XvcpzqycJM4CvFDvP0LJok1m
         ltJ5lPFYuemaSF4cgRM0F+vxWe0GCursw+HizuVGpppMwN2PgpNY+ZerqQ/ISNK378UK
         w+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744884859; x=1745489659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FztzwBNl0ZFpHfxwLXmfn6WleVneBnBReFpn/yDBVsA=;
        b=HmYxDhHtwjK+qHvbuuHJIz/iiGrkkpOY8tKMSI9RCSftOMCsNzgWhO8cTgPhRWChUc
         Q/9cZsVzPAXfc0uk4enny3GE7PDwo9rUIKl4l6/7OjqrfhVLgFdda/r6Wz/NOLGCr6Ck
         HPn95FRcYZ1J1ivaOXXuF3o4kX026lQdrdsvsj0weqI9irlXCG+ts8FcQhHzYtTbtGp7
         nUczEZY4rBnR1x5IXoR7jt0CCH5mdJCBW+ApQMGGHsZODKyLYrxtRbnyldHXybP8JC7H
         XKlVYoTRqTp3ClYI5UB/JABKPWx1je7ay5I/3bQZQo58thVRHhcDECFFES5sLsf29mxK
         ZX/g==
X-Gm-Message-State: AOJu0YwGOrQQkEl1Si9CgWU0ckexDpMv3So/07hfO/N+kv7TeSHzASw3
	loSzvx8/fote8WiKd7DVFDRMjpaTSkedRU5vWycvB5WPLvMoZ+5a/hSdFZ9jn6PpbhxH5AG9KmA
	Z
X-Gm-Gg: ASbGncswhCtpVvpxoGREuS7qt8/1UObOOWDRogIBqNny4yWV4+M6rCA6XW+K/qb7jnj
	2ehF5YJD0gUD40R5Jfzb6DGHc1FaNOUrq2hjxWKx1d/WSIAXWwRF1R5zv7TcExDejcs7akwVD7J
	+9zy+hGI/cwSCFA4cyRqvbFjnNHj5bqYHbLQ1ERY8pXkvGCT6afQ3nLa2KBXF+ZUnQnc0mQV4WH
	DCbIUXil+BwosnjrGqNaNH0kwE8efQUN4hNEGF7P1mDx7S/57+jVlK86BxPWkcjGHiJml+uQwsd
	+Sb3vsqBB6CypnqrLmexDlVQiYF8ioEX2g==
X-Google-Smtp-Source: AGHT+IHL+m8ta+aas00bRsxmilCNCmsvQcQDfnOJB0XvA4U3pkqP88fMxTcKUxqe18jKF4rTAKjx2w==
X-Received: by 2002:a05:600c:6a19:b0:43d:5264:3cf0 with SMTP id 5b1f17b1804b1-4406351b347mr16613845e9.11.1744884858806;
        Thu, 17 Apr 2025 03:14:18 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4404352a5f0sm52455795e9.1.2025.04.17.03.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 03:14:18 -0700 (PDT)
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
	parav@nvidia.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: [PATCH net-next v3 2/3] devlink: add function unique identifier to devlink dev info
Date: Wed, 16 Apr 2025 23:41:32 +0200
Message-ID: <20250416214133.10582-3-jiri@resnulli.us>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250416214133.10582-1-jiri@resnulli.us>
References: <20250416214133.10582-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

A physical device may consists of several PCI physical functions.
Each of this PCI function's "serial_number" is same because they are
part of single board. From this serial number, PCI function cannot be
uniquely referenced in a system.

Expanding this in slightly more complex system of multi-host
"board.serial_number" is not even now unique across two hosts.

Further expanding this for DPU based board, a DPU board has PCI
functions on the external host as well as DPU internal host.
Such DPU side PCI physical functions also have the same "serial_number".

There is a need to identify each PCI function uniquely in a factory.
We are presently missing this function unique identifier.

Hence, introduce a function unique identifier, which is uniquely
identifies a function across one or multiple hosts, also has unique
identifier with/without DPU based NICs.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
v2->v3:
- extended patch description
- extended documentation
---
 Documentation/netlink/specs/devlink.yaml      |  4 ++++
 .../networking/devlink/devlink-info.rst       | 20 +++++++++++++++++++
 include/net/devlink.h                         |  2 ++
 include/uapi/linux/devlink.h                  |  2 ++
 net/devlink/dev.c                             |  9 +++++++++
 5 files changed, 37 insertions(+)

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
index dd6adc4d0559..d0d4e17df148 100644
--- a/Documentation/networking/devlink/devlink-info.rst
+++ b/Documentation/networking/devlink/devlink-info.rst
@@ -50,6 +50,26 @@ versions is generally discouraged - here, and via any other Linux API.
        This is usually the serial number of the board, often available in
        PCI *Vital Product Data*.
 
+   * - ``function.uid``
+     - Function uniqueue identifier.
+
+       A physical device may consists of several PCI physical functions.
+       Each of this PCI function's ``serial_number`` is same because they are
+       part of single board. From this serial number, PCI function cannot be
+       uniquely referenced in a system.
+
+       Expanding this in slightly more complex system of multi-host
+       ``board.serial_number`` is not even now unique across two hosts.
+
+       Further expanding this for DPU based board, a DPU board has PCI
+       functions on the external host as well as DPU internal host.
+       Such DPU side PCI physical functions also have the same
+       ``serial_number``.
+
+       The function unique identifier uniquely identifies a function
+       across one or multiple hosts, also has unique identifier
+       with/without DPU based NICs.
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
index 02602704bdea..581a8ad7a568 100644
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
2.49.0


