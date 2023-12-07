Return-Path: <netdev+bounces-54846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5A1808879
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 13:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB5551F212EE
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 12:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E65A3D0C9;
	Thu,  7 Dec 2023 12:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="HfAPLTuD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73AD7D7F
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 04:53:54 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-54c79968ffbso1163414a12.3
        for <netdev@vger.kernel.org>; Thu, 07 Dec 2023 04:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1701953633; x=1702558433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bxJAyysAiivAbEm+2Zq8N601ckn8V7H7RhBi+XqcGhU=;
        b=HfAPLTuDrzREsMzY38SOM0s7BkN+mKB4WRkgBzGHXpy/+NTtq4jaU+O//CTYW2jTRY
         N1EFqrcOfvIfNhCvNwx4rnefxIcjsZTYTJxI3cBkVOVGV/SHjtKDoM6QeQrrUfqjmuXU
         EXLZvtbKIVIoyQbc7b/2NDT2vbvVrGK/UNaEt7nhx6IyfJ+gns18S/ItDK0n0q18rwyv
         BDExQ8MWX3F/tXtGI8/cbaA1lzgaZEgQS5R1Sqqcc6oa6MnhvuHodBeD7OWhZn138cLl
         0lEMHmQmSionQkPSpzd/RejO4FFwyHoV4UEVcMq3gEaFz+8Gr2iJtYCAgJ5KHd1SgLQD
         h4vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701953633; x=1702558433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bxJAyysAiivAbEm+2Zq8N601ckn8V7H7RhBi+XqcGhU=;
        b=B8VxBVBP4sgnNu+yGtdktpPQbLBk2XE3+gSIFQntTEomrreWVdSboVaUpuK22M+SOH
         LxMxXYySPy9pPkzeB02fIYxJR6IitagH/cySExKH3OwHSmTkN/mbW8Qw97xbvnkaJA3A
         IdWyB27XsqjtGQaA7b9IWAC4JwxL0P794aBe8WUqd6W0p5PsjQJ91Kles5r1BoxnVq4h
         cA0zaC8OHrkTIkYsyi7ykL0+hqKR067c5lU2NRLradZKZ6W7xzFpFsTKjVaz6GMTOSYc
         rBPnhCcrZqBN5RUDPgWsWVpvhgWtpFlBSQsFv2lGgQ6MdOnq9d7OYxw4I6JoWMI/Axsp
         m9Kg==
X-Gm-Message-State: AOJu0YyqBHUsVtZEr6JHaeD3KBbG5ziKX/NoVCHvs3G+5I4octka1Li1
	ZtBzzccwVFsm/i3UGlW59lerZoqk/dh16KTsGmM=
X-Google-Smtp-Source: AGHT+IHmgvmSgy3/l+XAgIeEi2FI7LV5m8AZhHM0vM2jHqW60pN0AYkUh8OJuLIIqK+iZ6dXdqAA8A==
X-Received: by 2002:a17:906:3f08:b0:a16:1cc8:45bd with SMTP id c8-20020a1709063f0800b00a161cc845bdmr1523367ejj.9.1701953632861;
        Thu, 07 Dec 2023 04:53:52 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id bl5-20020a170906c24500b00a1e27e584c7sm802415ejb.69.2023.12.07.04.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 04:53:52 -0800 (PST)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	dsahern@gmail.com,
	moche@nvidia.com
Subject: [patch iproute2] mnl_utils: sanitize incoming netlink payload size in callbacks
Date: Thu,  7 Dec 2023 13:53:51 +0100
Message-ID: <20231207125351.965767-1-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiri Pirko <jiri@nvidia.com>

Don't trust the kernel to send payload of certain size. Sanitize that by
checking the payload length in mnlu_cb_stop() and mnlu_cb_error() and
only access the payload if it is of required size.

Note that for mnlu_cb_stop(), this is happening already for example
with devlink resource. Kernel sends NLMSG_DONE with zero size payload.

Fixes: 049c58539f5d ("devlink: mnlg: Add support for extended ack")
Fixes: c934da8aaacb ("devlink: mnlg: Catch returned error value of dumpit commands")
Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 lib/mnl_utils.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib/mnl_utils.c b/lib/mnl_utils.c
index 1c78222828ff..af5aa4f9eda4 100644
--- a/lib/mnl_utils.c
+++ b/lib/mnl_utils.c
@@ -61,6 +61,8 @@ static int mnlu_cb_error(const struct nlmsghdr *nlh, void *data)
 {
 	const struct nlmsgerr *err = mnl_nlmsg_get_payload(nlh);
 
+	if (mnl_nlmsg_get_payload_len(nlh) < sizeof(*err))
+		return MNL_CB_STOP;
 	/* Netlink subsystems returns the errno value with different signess */
 	if (err->error < 0)
 		errno = -err->error;
@@ -75,8 +77,11 @@ static int mnlu_cb_error(const struct nlmsghdr *nlh, void *data)
 
 static int mnlu_cb_stop(const struct nlmsghdr *nlh, void *data)
 {
-	int len = *(int *)NLMSG_DATA(nlh);
+	int len;
 
+	if (mnl_nlmsg_get_payload_len(nlh) < sizeof(len))
+		return MNL_CB_STOP;
+	len = *(int *)mnl_nlmsg_get_payload(nlh);
 	if (len < 0) {
 		errno = -len;
 		nl_dump_ext_ack_done(nlh, sizeof(int), len);
-- 
2.41.0


