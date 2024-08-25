Return-Path: <netdev+bounces-121742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A0A95E4E5
	for <lists+netdev@lfdr.de>; Sun, 25 Aug 2024 21:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF008B21A76
	for <lists+netdev@lfdr.de>; Sun, 25 Aug 2024 19:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DEF574402;
	Sun, 25 Aug 2024 19:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mque7aK6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4BB28366
	for <netdev@vger.kernel.org>; Sun, 25 Aug 2024 19:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724613419; cv=none; b=r2ymzmiJMvxdSDo1GvJ5j0ilI0rJOLyGOhXZo0Ra1vxbEB9QRW0X9VKt3zT9HNVpdsznkbPUMUjDSRm1xQ7DCD6IPLrlpU0PwNexrT8wkc4Hnvfg4WxGIkx86JXRnj+n/Bf0MPgORPTR1BPkC3l6AtOB8LROIwCIUb+58v/XutM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724613419; c=relaxed/simple;
	bh=uwPuhXoefH2+pq4/CkRntnp02TPoeVaDrCIZDoIVIzg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SQnmD64g9nMVqdHLYU4Kaj9IROalKYGD/ij9C4g8pl/dWWB9FVJtYAJNsscahfTYHaFEorUIyTdyLSIPvCVQWUR1EWzOz9czrYmo7l2xpsnHSzTrCfwPvEamgKvdkn7eplzQU0DvDzdRT64vf5IXROyrsne3cmou+5mIaU/FmZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mque7aK6; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-656d8b346d2so2107615a12.2
        for <netdev@vger.kernel.org>; Sun, 25 Aug 2024 12:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724613414; x=1725218214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wL7I6ed5DCRZqcgsbGew85++14QRjL9Ex+C+AiIXqwE=;
        b=mque7aK6ihMcASRmms547nwpeS5K3O0HAujuoX9xUf7UPFJ5kwKVWbVetXcEK6yJW+
         2OEWcT7fojPGLV/zS328i357MpJT5Ct1cFAsQlcHgYvSuCZfwyZ90HOXaUOWCYpOdPC3
         vgAf6sT4vd85NHhmGR3Yig53R1xcQgbwKHHXA6tz+uSxc1kjZL5zZTkiefLrxKiq3NZU
         V0ev2LTRZ+v0oat1fuUf1Cfh6UPDTCOSHKt0W2VxT3vH+HFBlbmNhxiSYXFfO+QZcloc
         gkwtZi36AUrRN88B5vqqhqH5xrkxhCna3+HytpBOFFDd3XBRtPX7WuHBNHkK0NPJs4P4
         em1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724613414; x=1725218214;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wL7I6ed5DCRZqcgsbGew85++14QRjL9Ex+C+AiIXqwE=;
        b=kJwTTbaKg66r/eg+8SKTcKEz7NQrOiswDpY68UECeZ8YS3wPWkLVdQ19K9vf6tRSI7
         ViW/6YnrW6Xb7Vj+hvHjGLNZn6HasrcEuotpAQ4vZ36sLKapt9A1G3w1I38CmNNU2+JU
         SFqZEz2E4qW1qWLiaUSBUgNhasNqplPPbZYSd3r7stifueWBjw2gdXI0dpXFHy9IKpgp
         QijZS1vTRqjS/XWsxUvPqWKXmTCnyyu5f/iAZoBtUvh/iKjXapR0v0NmfJBXgj+L0Hf0
         JwokSemxKg70AI2+SSHo/mYdawMWQE+RoDI5zRLcI5KfIfl4dVXnGu3a5Eg45jtAn8Zc
         0MiQ==
X-Gm-Message-State: AOJu0YztZRboeWH2H1Lo/1y29kgtU1vdBphbJ9Cl8ahpo0K6c9ICC7Tv
	VIbLIfq8Lp0z0VWrHvQfOpbnZT6fSCQBrLYc2jiHsMmqTjmK+ySJXeEI56Hg
X-Google-Smtp-Source: AGHT+IFdfqgKkOzkOH4yc0ptCiC027/clSaWkYfv6VzXLkpdrRWxI8bqtWWZnRgUqnT9KPcOHZTQKQ==
X-Received: by 2002:a05:6a21:6711:b0:1c3:b1e2:f826 with SMTP id adf61e73a8af0-1cc8b591742mr7452703637.35.1724613414323;
        Sun, 25 Aug 2024 12:16:54 -0700 (PDT)
Received: from pop-os.hsd1.ca.comcast.net ([2601:647:6881:9060:514:94b9:b1c0:7a45])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143e524a34sm4901489b3a.85.2024.08.25.12.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 12:16:53 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: Cong Wang <cong.wang@bytedance.com>,
	Andreas Schultz <aschultz@tpip.net>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Harald Welte <laforge@gnumonks.org>
Subject: [Patch net] gtp: fix a potential NULL pointer dereference
Date: Sun, 25 Aug 2024 12:16:38 -0700
Message-Id: <20240825191638.146748-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cong Wang <cong.wang@bytedance.com>

When sockfd_lookup() fails, gtp_encap_enable_socket() returns a
NULL pointer, but its callers only check for error pointers thus miss
the NULL pointer case.

Fix it by returning an error pointer with the error code carried from
sockfd_lookup().

(I found this bug during code inspection.)

Fixes: 1e3a3abd8b28 ("gtp: make GTP sockets in gtp_newlink optional")
Cc: Andreas Schultz <aschultz@tpip.net>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Harald Welte <laforge@gnumonks.org>
Signed-off-by: Cong Wang <cong.wang@bytedance.com>
---
 drivers/net/gtp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 0696faf60013..2e94d10348cc 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -1653,7 +1653,7 @@ static struct sock *gtp_encap_enable_socket(int fd, int type,
 	sock = sockfd_lookup(fd, &err);
 	if (!sock) {
 		pr_debug("gtp socket fd=%d not found\n", fd);
-		return NULL;
+		return ERR_PTR(err);
 	}
 
 	sk = sock->sk;
-- 
2.34.1


