Return-Path: <netdev+bounces-128849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1BC97BF47
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 18:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08CA21C21E12
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 16:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D730F1C9EDB;
	Wed, 18 Sep 2024 16:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="VMX2zjog"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f98.google.com (mail-lf1-f98.google.com [209.85.167.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893001C9EBC
	for <netdev@vger.kernel.org>; Wed, 18 Sep 2024 16:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726678238; cv=none; b=BsCFfsSZ4dOn8c2PtwEh33WuO9Ylc3zkOkppZLC5rY0oYXPqYj3rjikzUOqt3bjt/rXrObGFv19oxwuBRN2LiUKF6JnlCWOWtteszxcEB0PVw1Y87kjS4kuxBO1NWGT+OUPQ+KGJiP/55T65fT2yU2bGDzmBqZmja3288X3Rkfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726678238; c=relaxed/simple;
	bh=3ozqSfAnoj4FHw18aQadVEGdtdrrEVsLUmVsfjhp5/U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I96GdDOOGJ0/2NuUfukrIi9/4Yfv4l2YvElvSufOQs9twwXzmhOMp5prbKCS/kAnCozN1ozsuMaq66MUoUnQO+Clc4huaVsc/uZ2fNN0KycNtbQQn4wxV+FnmkVR69YBC2EkehjkGvAuoZGnZI1d0TiHPhYATtx2ri+rRtGrWeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=VMX2zjog; arc=none smtp.client-ip=209.85.167.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-lf1-f98.google.com with SMTP id 2adb3069b0e04-53658e2d828so487900e87.2
        for <netdev@vger.kernel.org>; Wed, 18 Sep 2024 09:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1726678234; x=1727283034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3c5Ef2xZW/gig86LVOPt5sRCYIeMqu/+S2wxcLkhcs8=;
        b=VMX2zjoggAmLHLlP+nv9x1AmG0za1mntKXMINRx0ZWj5dIGzWvndlGOefsGzYXhq7Y
         kKtZVUamh3LzFnhmsi8daKZjkE749fgGZmBNYa2ASvMyzv8whE+1Njo5GKvr5hOOEXAe
         jKaxtRiF4/t1j8DasTSe1qYz6tDjsmx5FKpoU4Lvsr3EW1r54ZLb87MexSuqABHQG6+t
         5LhV48J5sjON6dsU6k9RAhrs7WvkwyXeEyq6q+IVRqTZM9gSNeoyI5tT1B4I4lPWEsOX
         L7v55tuooLhw4FOLGL/rvK7g4+JOBXs1QHxweupvMzjXTHPyocU8WkzupXoDn6lZsJx2
         cYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726678234; x=1727283034;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3c5Ef2xZW/gig86LVOPt5sRCYIeMqu/+S2wxcLkhcs8=;
        b=TaV9WGz3YnMNuCfUI6E8nxtq2Iru/jY9TSuJAwdFCya9dPabGAecKZ9azL9TcSD5kT
         JjJMf7JswJCH4ekKYrxM6YvbxqSZNP/l3g8hl8ESLJGSt3Aq4eHdGck1B8sVF4znKy9W
         AZCkU5BmE6eTbyxvVXIq0iD1Smvz34fH75ioA2kLScDQYDpZCDRQjEWmpg2s2rCUylee
         QGFnyI5YiIfkzwFD+CQf/oLnHwVwoeL9PWbF/jqvC+YzJa65PyF9WmemPhTSQALj7tj9
         4OlmWeqzv1Q8l7zcmYBxSZcjuLW55BORqXiuOTJYI/Fkn4zPTDZ6urdlo9wSf+bZy5p9
         4OpQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/Zsc2lYhCth+4hEd/nhvNpRv7rC3yUP+TZkkKLgMR2jtYCjnlleh0kz4oPxFxV3Mw328iUZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwToxipaIWdU/gtmpexUYfSID5iqU+VXn4apvU+lYb3eDg8CL87
	wC+zhtUTgP3nrbb7yuHX7mLJ1+vadVAVSBPHILwDzZnapiDgpCMQgQLcDKJ+uH8UwfQrsmgpizg
	47AwTfwcz83U/BifiM7x9vBX1sYHim9LA
X-Google-Smtp-Source: AGHT+IGEt4nE6CADzs9JzWR9pWtJfJtV6j1vPQn4CucvnJBrhUvxrLLDQeie+DaRuuQ6q97q9PsqPbvzbGGu
X-Received: by 2002:a05:6512:224f:b0:52f:e5:3765 with SMTP id 2adb3069b0e04-53678fec44fmr3576522e87.6.1726678234230;
        Wed, 18 Sep 2024 09:50:34 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id 2adb3069b0e04-536870a45f2sm180741e87.131.2024.09.18.09.50.32;
        Wed, 18 Sep 2024 09:50:34 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id 85FC1140B7;
	Wed, 18 Sep 2024 18:50:32 +0200 (CEST)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1sqxsu-00GQRs-9Y; Wed, 18 Sep 2024 18:50:32 +0200
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: David Ahern <dsahern@gmail.com>,
	netdev@vger.kernel.org,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Alexandre Ferrieux <alexandre.ferrieux@orange.com>
Subject: [PATCH iproute2 v2] iplink: fix fd leak when playing with netns
Date: Wed, 18 Sep 2024 18:49:41 +0200
Message-ID: <20240918165030.3914855-1-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.43.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The command 'ip link set foo netns mynetns' opens a file descriptor to fill
the netlink attribute IFLA_NET_NS_FD. This file descriptor is never closed.
When batch mode is used, the number of file descriptor may grow greatly and
reach the maximum file descriptor number that can be opened.

This fd can be closed only after the netlink answer. Moreover, a second
fd could be opened because some (struct link_util)->parse_opt() handlers
call iplink_parse().

Let's add a helper to manage these fds:
 - open_fds_add() stores a fd, up to 5 (arbitrary choice, it seems enough);
 - open_fds_close() closes all stored fds.

Fixes: 0dc34c7713bb ("iproute2: Add processless network namespace support")
Reported-by: Alexandre Ferrieux <alexandre.ferrieux@orange.com>
Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
---

v1 -> v2:
 - use a global variable to store fds

 include/utils.h |  3 +++
 ip/iplink.c     |  6 +++++-
 lib/utils.c     | 23 +++++++++++++++++++++++
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/include/utils.h b/include/utils.h
index a2a98b9bf17d..f044b3401320 100644
--- a/include/utils.h
+++ b/include/utils.h
@@ -395,4 +395,7 @@ const char *proto_n2a(unsigned short id, char *buf, int len,
 
 FILE *generic_proc_open(const char *env, const char *name);
 
+int open_fds_add(int fd);
+void open_fds_close(void);
+
 #endif /* __UTILS_H__ */
diff --git a/ip/iplink.c b/ip/iplink.c
index 3bc75d243719..0dd83ff44846 100644
--- a/ip/iplink.c
+++ b/ip/iplink.c
@@ -622,9 +622,11 @@ int iplink_parse(int argc, char **argv, struct iplink_req *req, char **type)
 			if (netns != -1)
 				duparg("netns", *argv);
 			netns = netns_get_fd(*argv);
-			if (netns >= 0)
+			if (netns >= 0) {
+				open_fds_add(netns);
 				addattr_l(&req->n, sizeof(*req), IFLA_NET_NS_FD,
 					  &netns, 4);
+			}
 			else if (get_integer(&netns, *argv, 0) == 0)
 				addattr_l(&req->n, sizeof(*req),
 					  IFLA_NET_NS_PID, &netns, 4);
@@ -1088,6 +1090,8 @@ static int iplink_modify(int cmd, unsigned int flags, int argc, char **argv)
 	else
 		ret = rtnl_talk(&rth, &req.n, NULL);
 
+	open_fds_close();
+
 	if (ret)
 		return -2;
 
diff --git a/lib/utils.c b/lib/utils.c
index deb7654a0b01..98c06ab6a652 100644
--- a/lib/utils.c
+++ b/lib/utils.c
@@ -40,6 +40,9 @@ int timestamp_short;
 int pretty;
 const char *_SL_ = "\n";
 
+static int open_fds[5];
+static int open_fds_cnt;
+
 static int af_byte_len(int af);
 static void print_time(char *buf, int len, __u32 time);
 static void print_time64(char *buf, int len, __s64 time);
@@ -2017,3 +2020,23 @@ FILE *generic_proc_open(const char *env, const char *name)
 
 	return fopen(p, "r");
 }
+
+int open_fds_add(int fd)
+{
+	if (open_fds_cnt >= ARRAY_SIZE(open_fds))
+		return -1;
+
+	open_fds[open_fds_cnt++] = fd;
+	return 0;
+}
+
+
+void open_fds_close(void)
+{
+	int i;
+
+	for (i = 0; i < open_fds_cnt; i++)
+		close(open_fds[i]);
+
+	open_fds_cnt = 0;
+}
-- 
2.43.1


