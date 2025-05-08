Return-Path: <netdev+bounces-188996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 983CBAAFCC4
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 16:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE19017AFA8
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 14:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE9A2701B4;
	Thu,  8 May 2025 14:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LhP7PDkI"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692D8252917
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 14:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746714028; cv=none; b=KZ0Gk0uHxMJH+e+xyNuYadrMlLH/qHD8eQvkVr4jLjUXPDcN3x1SILnbHKFCCFaj8DLf7qvS4R/OlvySWhPDY6Vfwq+45hFp6xudpwZu05TZgLssTxMVfOerZ6sIzlkehDPWEFsRaxWuFbw70upysh56IEwaGrq7hy3zk/7na1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746714028; c=relaxed/simple;
	bh=YvRNLSi/VrpoieogGKGsgCKAlWpBPuTAmyy56vB3yh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XuiNTtuWhYZoz/8lD4Siw/6kfUrcjzyD/TbcCcGlXHwWFprbZMfQjkjlvZVUnU4NDlMhXR4DXA4HBg/DXQtNOuzzM1OCOXOAuqpW3UI9Xl+Qd0Sz2n3iR9qWpkB5FSTk0lcqumHCH93GTsxAHZcV+N8oHx4GwHwLu8lZm4f1/HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LhP7PDkI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746714025;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p/inhQIAJVDlclzovizj1G424bvRWbJSy56O+ePhgtM=;
	b=LhP7PDkITbKs7zk5Yl9ihZxfDaBDfWHhQQP2oJifHpUGJ4UyQZ1htJWHez4Z7NbAVPq6Ht
	6q06WHh07HDoMmu7Fpjnug0CgDJQjs+x/LNzj1PM77y9wz1c91VC05oOAc4tklzlLlA2lE
	C7vyWI/uTzxSk/haG4IYoZRddIMBBQA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-TzB_0KoYNdSgvbMxt-SLOg-1; Thu, 08 May 2025 10:20:24 -0400
X-MC-Unique: TzB_0KoYNdSgvbMxt-SLOg-1
X-Mimecast-MFC-AGG-ID: TzB_0KoYNdSgvbMxt-SLOg_1746714023
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-acb5a03afdcso83540166b.3
        for <netdev@vger.kernel.org>; Thu, 08 May 2025 07:20:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746714022; x=1747318822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p/inhQIAJVDlclzovizj1G424bvRWbJSy56O+ePhgtM=;
        b=COpyb4w/ENoFXhHb+hJgM+PNb+CyrQhJ9gHVci/pwujO9rSZIEH6nyqAEsAmnd3E8G
         eqav5YmtFenqDsyYgmJVlschpXJ2pOmIKBVTg3JoKs43X/b8NyeT7TQFS3cPxvyYaQlt
         QgnSQtCfY0Kivq9ZAGQKP++a1wMNxaneq2le/H0uYfhDVWIiQIOG6WeHbtfdwbjiX3A8
         4A3rvIvRfP2fWPuan5jIOpMGbTApDi3b85v24OjdDVjRcqjSNLy3dN2Bnbt5prOCOOtw
         xd/j+Ws91ScM3Jt4vIP6/5eiJvzlN7ioHNZWFf3pexja4JV2hgkhhnpIp2msJrrv1zui
         tENQ==
X-Gm-Message-State: AOJu0YzuS97PVEFog8CFQaGEuATrvdf7cIVTmCxYzlJ0s72fsGPofr3u
	iGf2ZQhzzWTbyFRVvp7tmxhKYaIqJmqWviCfq++9AB3XP0L9MIauOUOIRtbBsFze8cvVK+sIMMm
	JxXyBYBKX5te7BRBNhx6ATLgLOu8l4HS8PAC3F8JA0/EbaLKrBPuYTmoK1E6Xi/Ef4ahB9R8Mp/
	lT670HI5o/dnW7EIeUV7i2mCmP4/hl0Hy8w/9z1g==
X-Gm-Gg: ASbGncs9jGS+eucbrRAKiY+rutB1+FGAa07/1ZEFmWX7gU8vpNhFu1PMmkn+UwJHJEL
	eYsFkGSgctgzk6YsBN14jqmW425wh7ItyXAeLuf9xycM5NS7nSaMe8IFYE9/LwdKym8TOggbBXB
	G5e0GQw+9+2iUVgZXrxuE53E252RL6ejLtYhuUkDW8kA4a4GHYa4SmOnQtKJImMopYwz0Fld9nA
	snLhPDCWX1ndqljv9q14pYEvBHEBgoS0D4lWv5/0s0wbAsZNY8+9VkWeBLVjnBT/kTM0HF1H2It
	Mb2aRT4PUEvHlA5IzRfROX+wnw==
X-Received: by 2002:a17:907:96a7:b0:ac7:b368:b193 with SMTP id a640c23a62f3a-ad1fe6f68b4mr342645266b.27.1746714022487;
        Thu, 08 May 2025 07:20:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFRTgUh6IEfYQONbpJtEOHpIxAXun5putCZzRRkLB2V22yE0BXo1RjIX+rhP121YMlrUvpBiQ==
X-Received: by 2002:a17:907:96a7:b0:ac7:b368:b193 with SMTP id a640c23a62f3a-ad1fe6f68b4mr342639966b.27.1746714021843;
        Thu, 08 May 2025 07:20:21 -0700 (PDT)
Received: from localhost.localdomain ([193.207.221.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad189540d5bsm1096012366b.176.2025.05.08.07.20.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 07:20:21 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Stefano Garzarella <sgarzare@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH net-next 1/2] vsock/test: retry send() to avoid occasional failure in sigpipe test
Date: Thu,  8 May 2025 16:20:04 +0200
Message-ID: <20250508142005.135857-2-sgarzare@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250508142005.135857-1-sgarzare@redhat.com>
References: <20250508142005.135857-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefano Garzarella <sgarzare@redhat.com>

When the other peer calls shutdown(SHUT_RD), there is a chance that
the send() call could occur before the message carrying the close
information arrives over the transport. In such cases, the send()
might still succeed. To avoid this race, let's retry the send() call
a few times, ensuring the test is more reliable.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tools/testing/vsock/vsock_test.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index d0f6d253ac72..7de870dee1cf 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -1064,11 +1064,18 @@ static void test_stream_check_sigpipe(int fd)
 
 	have_sigpipe = 0;
 
-	res = send(fd, "A", 1, 0);
-	if (res != -1) {
-		fprintf(stderr, "expected send(2) failure, got %zi\n", res);
-		exit(EXIT_FAILURE);
-	}
+	/* When the other peer calls shutdown(SHUT_RD), there is a chance that
+	 * the send() call could occur before the message carrying the close
+	 * information arrives over the transport. In such cases, the send()
+	 * might still succeed. To avoid this race, let's retry the send() call
+	 * a few times, ensuring the test is more reliable.
+	 */
+	timeout_begin(TIMEOUT);
+	do {
+		res = send(fd, "A", 1, 0);
+		timeout_check("send");
+	} while (res != -1);
+	timeout_end();
 
 	if (!have_sigpipe) {
 		fprintf(stderr, "SIGPIPE expected\n");
@@ -1077,11 +1084,12 @@ static void test_stream_check_sigpipe(int fd)
 
 	have_sigpipe = 0;
 
-	res = send(fd, "A", 1, MSG_NOSIGNAL);
-	if (res != -1) {
-		fprintf(stderr, "expected send(2) failure, got %zi\n", res);
-		exit(EXIT_FAILURE);
-	}
+	timeout_begin(TIMEOUT);
+	do {
+		res = send(fd, "A", 1, MSG_NOSIGNAL);
+		timeout_check("send");
+	} while (res != -1);
+	timeout_end();
 
 	if (have_sigpipe) {
 		fprintf(stderr, "SIGPIPE not expected\n");
-- 
2.49.0


