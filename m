Return-Path: <netdev+bounces-130489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C795398AAF0
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 19:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A59F28A94F
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 17:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9D91990CD;
	Mon, 30 Sep 2024 17:18:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A4B198E96
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 17:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727716683; cv=none; b=p/yi3adgyyYJFY9z7X7a7Sj02L41iBnXqd3hJpGPcUOdIzzhuAFGpg/LwdWQHxU1lelHtzG6k3Sy95Q0AGV+h0t1wJjgPYXdnQXvcS80rTO9doojnfxpOFlWQuk4ZlQtLfF14xUuhuSt1R7iyn+yecGfb7pp1ZFvCKcBxBSCzQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727716683; c=relaxed/simple;
	bh=4sbRdjR7/fPoTU7/ByUzVIGdiIM8T5b0ZhCD8YLtBZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aT+B51WFzR1VIMDWMJiAQtpyR6veisa5fAg+DEbFK9PMVm/pzzeoD6QqPUlBb2WWLE3h6IXatOXh/NrLOyNLRDqVXerjHC2oVGLwT3dacWLTMcIVupm46RaoHkDhGcCy6G/yS+mn3kfQsmRkmz3xOcOcNFS5gVN7N6aK5xsvzGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20ba733b6faso3080825ad.0
        for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 10:18:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727716681; x=1728321481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OJEvaAS+5sv+Pr8rJakjDZsrflUEMuJ3AR1NhZU2/OI=;
        b=b4Fllt7h6604M9+YlnuY+lhwOU3UJEiqQl5qweG5dekjKTJZ6hvi9tXrgl3bcD4mKk
         htXZF3YDtmO7ogJ6adzXFcOcVUJHU9AZcq05CbumULOhzE8SdBgExLya3VPH179pHEF/
         /JEZ7ukp7+h2sAQSAbtfwRtXLvDhJCtn6OZosST2Q303W0LUaG5Pw377bAs5dlex03QD
         20RpKYGN3pzvkav3sG0sIb5eIv1puHvOXKEE2O5UQfG5xwwtZ9dkAVI297mB3CyK5IxR
         hkOxrwS2IZPlhwWwqwiA4WKOQ0kjh/vNkD9OPmjOYIXctL2/3lbp09Ra6SMAJ7qBacP9
         dufA==
X-Gm-Message-State: AOJu0YyK6q6qLzNsFw48+gdt4y9CUJYfg8IwbRiMa+8zNrkBZkX9hty2
	q4YY9FCFWHhLwzG7ACo+Y/JSo67F4BQAikX1RMm+t0q5e4x8LVOOugw2
X-Google-Smtp-Source: AGHT+IHPad8KbIMqE4cxZVp/TchbvlzTBytiLlT3lH/3yGoiPFRX9wqxgwg1GqWhJGLyTDNpwROpow==
X-Received: by 2002:a17:902:d488:b0:20b:6e74:b720 with SMTP id d9443c01a7336-20b6e74b8e3mr93801405ad.59.1727716681120;
        Mon, 30 Sep 2024 10:18:01 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37e516d3sm56588055ad.242.2024.09.30.10.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 10:18:00 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mina Almasry <almasrymina@google.com>
Subject: [PATCH net-next v2 04/12] selftests: ncdevmem: Make client_ip optional
Date: Mon, 30 Sep 2024 10:17:45 -0700
Message-ID: <20240930171753.2572922-5-sdf@fomichev.me>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240930171753.2572922-1-sdf@fomichev.me>
References: <20240930171753.2572922-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support 3-tuple filtering by making client_ip optional. When -c is
not passed, don't specify src-ip/src-port in the filter.

Cc: Mina Almasry <almasrymina@google.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/net/ncdevmem.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
index 7b56b13708d4..699692fdfd7d 100644
--- a/tools/testing/selftests/net/ncdevmem.c
+++ b/tools/testing/selftests/net/ncdevmem.c
@@ -62,7 +62,7 @@
  */
 
 static char *server_ip = "192.168.1.4";
-static char *client_ip = "192.168.1.2";
+static char *client_ip;
 static char *port = "5201";
 static size_t do_validation;
 static int start_queue = 8;
@@ -253,8 +253,14 @@ static int configure_channels(unsigned int rx, unsigned int tx)
 
 static int configure_flow_steering(void)
 {
-	return run_command("sudo ethtool -N %s flow-type tcp4 src-ip %s dst-ip %s src-port %s dst-port %s queue %d >&2",
-			   ifname, client_ip, server_ip, port, port, start_queue);
+	return run_command("sudo ethtool -N %s flow-type tcp4 %s %s dst-ip %s %s %s dst-port %s queue %d >&2",
+			   ifname,
+			   client_ip ? "src-ip" : "",
+			   client_ip ?: "",
+			   server_ip,
+			   client_ip ? "src-port" : "",
+			   client_ip ? port : "",
+			   port, start_queue);
 }
 
 static int bind_rx_queue(unsigned int ifindex, unsigned int dmabuf_fd,
-- 
2.46.0


