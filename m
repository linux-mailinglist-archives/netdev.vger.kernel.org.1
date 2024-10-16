Return-Path: <netdev+bounces-136301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84EC79A141F
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 22:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA820B229C3
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 20:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67878218307;
	Wed, 16 Oct 2024 20:34:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DDD20E03C
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 20:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729110876; cv=none; b=kTd2RevjxwtGyiSNndQdO0vMWqitrCQ10diXtEcaZBZHL3MkaIJ6wXsVZV79i++RExdIMWAgysp33Y+xz28glLDUTn3N2xUJywWqMd/GGloErek94/GwAIaAfEPqJZOxww+nrbBy0LDo67m70YRyqyW+K6e0b49rxIMoBFD3YZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729110876; c=relaxed/simple;
	bh=hvKtAdMmMJwdlK6/D7XzrcA06TFwhy+PbhqXtSzunAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ByWZk31fLf8x5RWl7zJA7jA/198+l9R9KARigoqOQk2KIiXRBRNhFQ+GXRK5yGC9xHtugLLI3mD710P6Z1fPInKEEcwQ06I7xPG09OL+yDDc1xp1ehWaX4kYDdeR/X7mCcPxnpAnx/GBkDzKYW6KxaFlcJaBMY0lAafHSJunn7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2e30116efc9so178977a91.2
        for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 13:34:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729110874; x=1729715674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ou7AVRJVOE2su/I9RGHce01ov8DJaMMy2O5CuqD9wpw=;
        b=jZO/uqRJsBqGl8yqjcbOrRlSs3mBHj6muJLNh7xTq36IzOUWYrTLYVdS6FkfcTcooh
         uoEDYsqO0Ws9dhy24SykW88aec+pTqgFV31HIyg0ueOuHyXZk3xbc5roVeuyrG4mSjIJ
         lhnQeSh+9AEeVRghf+3qUj1mkXqq0fZQPipKGxllW/cPCmqX7eJYcGxP3MhrAWax3Te1
         9ra9DhS8wvAjB864RS4Ccc6tcqRZZkeL3HfvFntkeah8vq/uES54+9cU8bxIu9NxtXbk
         M/7Z0m3lMnmBFnltHhSkS9Nj74JUXQYUeNjFKedUPl/EvISFJ9fxFa2C/20vYofiUxsy
         Q5jA==
X-Gm-Message-State: AOJu0YweEa0e4oaJPVXSU+lMzLIQ/SyWkTK9Lktnt6Z+T4N4KDJQ9kj2
	M3OYHibymK9k7SAU/M7TcNthMVNL7Hnn4vlYAZvBJyfYTkVLHz10vQEgx00=
X-Google-Smtp-Source: AGHT+IHUAvcxS/gPWKaSEVoDy90oH4TqpKvtxPdxkHIjjtC0/YWZIlJxLsFdK3Ndet2rzGV5x9wGLg==
X-Received: by 2002:a17:90b:1648:b0:2e2:aef9:8f60 with SMTP id 98e67ed59e1d1-2e3ab6c62c4mr6195664a91.0.1729110874134;
        Wed, 16 Oct 2024 13:34:34 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e3e08c18cbsm243892a91.20.2024.10.16.13.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 13:34:33 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mina Almasry <almasrymina@google.com>
Subject: [PATCH net-next v4 09/12] selftests: ncdevmem: Remove hard-coded queue numbers
Date: Wed, 16 Oct 2024 13:34:19 -0700
Message-ID: <20241016203422.1071021-10-sdf@fomichev.me>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241016203422.1071021-1-sdf@fomichev.me>
References: <20241016203422.1071021-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use single last queue of the device and probe it dynamically.

Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/net/ncdevmem.c | 40 ++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
index eb026633fdcf..a7f7bf0da792 100644
--- a/tools/testing/selftests/net/ncdevmem.c
+++ b/tools/testing/selftests/net/ncdevmem.c
@@ -75,8 +75,8 @@ static char *server_ip;
 static char *client_ip;
 static char *port;
 static size_t do_validation;
-static int start_queue = 8;
-static int num_queues = 8;
+static int start_queue = -1;
+static int num_queues = 1;
 static char *ifname;
 static unsigned int ifindex;
 static unsigned int dmabuf_id;
@@ -208,6 +208,33 @@ void validate_buffer(void *line, size_t size)
 	fprintf(stdout, "Validated buffer\n");
 }
 
+static int rxq_num(int ifindex)
+{
+	struct ethtool_channels_get_req *req;
+	struct ethtool_channels_get_rsp *rsp;
+	struct ynl_error yerr;
+	struct ynl_sock *ys;
+	int num = -1;
+
+	ys = ynl_sock_create(&ynl_ethtool_family, &yerr);
+	if (!ys) {
+		fprintf(stderr, "YNL: %s\n", yerr.msg);
+		return -1;
+	}
+
+	req = ethtool_channels_get_req_alloc();
+	ethtool_channels_get_req_set_header_dev_index(req, ifindex);
+	rsp = ethtool_channels_get(ys, req);
+	if (rsp)
+		num = rsp->rx_count + rsp->combined_count;
+	ethtool_channels_get_req_free(req);
+	ethtool_channels_get_rsp_free(rsp);
+
+	ynl_sock_destroy(ys);
+
+	return num;
+}
+
 #define run_command(cmd, ...)                                           \
 	({                                                              \
 		char command[256];                                      \
@@ -702,6 +729,15 @@ int main(int argc, char *argv[])
 
 	ifindex = if_nametoindex(ifname);
 
+	if (start_queue < 0) {
+		start_queue = rxq_num(ifindex) - 1;
+
+		if (start_queue < 0)
+			error(1, 0, "couldn't detect number of queues\n");
+
+		fprintf(stderr, "using queues %d..%d\n", start_queue, start_queue + num_queues);
+	}
+
 	for (; optind < argc; optind++)
 		fprintf(stderr, "extra arguments: %s\n", argv[optind]);
 
-- 
2.47.0


