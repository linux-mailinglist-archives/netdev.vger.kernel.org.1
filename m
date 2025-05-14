Return-Path: <netdev+bounces-190471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C15C9AB6E07
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 16:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 736724C5435
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 14:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B4F1B3952;
	Wed, 14 May 2025 14:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RYyw0zLT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426DE1A9B24
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 14:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747232395; cv=none; b=Qtg/NBEdIe4IGEt8lDYjlND/aNwWPO8JJXGFJEinuwfVt+hMrBQfOwt6Pe4+iuX+PyxFY1Bl1dVFQdd/zkgfmwRvXWrTTjKAlL7S3gD+jzEriUgGPy9t3LNwnHOVZ0Oy0WMunJPTTR+dz8qXr4Atu/NaoKe3TyU32uHSOv6cpq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747232395; c=relaxed/simple;
	bh=CcrER2Exd8xwndgBuv285nkTGJ5VgH5wjXS9fED1jP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uuTu9WiOOWehonAw6t6MoQdoFLrFQ9QEKm+PvGX92b9RJkP3To3NVGVqv1ADES7Zdi0A8wduSFiCqrcm432yovi7pX1umQY4qx8MZ6sZoWWBzG6ccHWgC5UU5xmThbYe55lrJswmTmV1DPXiZ67ZZSeOBHvNVcV6b9YyF+AzTmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RYyw0zLT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747232393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cDm7nJrRE59Z0WBLF69Q9FPldj2cPZK9AVpQiRbnwXM=;
	b=RYyw0zLTTXMa3MIt4QSkbClbSJVL0wk056cVnI7RCmZu1drSWAw1L0PgSdxf1BEa0dAFYm
	ff39Fg4Cr3+W+yUNGDnu5ccKzzu0CeoCMqK3Cxbo3ZXBSAnsTk61NFp2hNgxKS73Grmvfa
	PYFYt2bXK9mR98G0DWl9Dc7HmnUsEfg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-Kd4UkBkhNlWBncp3F_X-RA-1; Wed, 14 May 2025 10:19:52 -0400
X-MC-Unique: Kd4UkBkhNlWBncp3F_X-RA-1
X-Mimecast-MFC-AGG-ID: Kd4UkBkhNlWBncp3F_X-RA_1747232391
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a0bcaf5f45so2325332f8f.1
        for <netdev@vger.kernel.org>; Wed, 14 May 2025 07:19:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747232390; x=1747837190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cDm7nJrRE59Z0WBLF69Q9FPldj2cPZK9AVpQiRbnwXM=;
        b=OZnpMLV1OsUBYftIwKKMk0xjXDPDf26vrSft2gYr8dTrDDu5RYSxU7wOazDAWv4rfQ
         fkxp/wBqHMefPMJmr4kgwqVk6DHO5dqkq65W/Yoi2SmZJNezWcBBA3HAPAIvIuGUopfT
         oFqVPZrWuvhfMK7GLkd69OTFlQ8qj4qgIeOqLA7R0imWKllyQbAOB1zQUy8zzuTvBZDh
         6kEFWN3A1mci3CqRyUVgX5btMCHD2tsPAoYUk/ZWXgGDLMP4SExLvmc2rwGQwbhDD9Fd
         vT5AKdIpChrVdlZ8xI6h3pBbS7xSJ/mPUYRRnB+b8LQy/FrX0DO9xtgsu5ajcwpH99jY
         p4QQ==
X-Gm-Message-State: AOJu0Yzl5ZEOXeNSUmgWlm2IpFEez4tUsAKXj5qPoUnwbEl+WXyleraM
	S2lq5zqgkerq747z3mkLNod/i096ECzhw7AJhP9r3hSXxsvjpavxPzf2xQR5DlHqhkO4PApu7f0
	5wkYU2ZMWjJJkJKrNkQb9JhLk1vUp3yOZyTOTNA42yJqBBX5QmAHrsj++3Q/gsZIh9v3ImDCell
	9Whj+6rVRRXL7hLWGyuOzvserVsCXCU96uo+IGjQ==
X-Gm-Gg: ASbGncuBydPiCIQYYBuwWKgJYZzOacL77ySHElHFn0rkt+vcIXSMgHr9e67N7iwIhvU
	tMsAk1r3J5mA7MwK5wz8WQ1fu7TbpB0sOgQyMNuCuSG3CuWQI5zxQc+7SwI8oCCCqdQVhu/yZEw
	tR4iCEwIjByx60DXPDQr9HSfKRNUrSAzZwnTJSKli5ySw84GvX2LdB82TP90mV8BUGy5VpWX0oh
	JwVOv+pF5uDZbOD0pgcC8DdY2/wO8Z+P/SB1ZpGZgH5JC9gF7uCv+xiVfBwU0q2QOZe8fQVarim
	wOOH2e46ALQcOGW/Dg==
X-Received: by 2002:a05:6000:144e:b0:3a1:fcd4:eada with SMTP id ffacd0b85a97d-3a34969acb4mr3222059f8f.4.1747232390370;
        Wed, 14 May 2025 07:19:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG75RsnzyRLR1LhB+z1tdqBl/h6dNHdHAx2k1Nlw/1mOd/47oPLqRJ7tYPfYXaURS4y1kTd7A==
X-Received: by 2002:a05:6000:144e:b0:3a1:fcd4:eada with SMTP id ffacd0b85a97d-3a34969acb4mr3222017f8f.4.1747232389836;
        Wed, 14 May 2025 07:19:49 -0700 (PDT)
Received: from stex1.redhat.com ([193.207.203.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a4cc2esm20351768f8f.90.2025.05.14.07.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 07:19:48 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: virtualization@lists.linux.dev,
	Stefano Garzarella <sgarzare@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 3/3] vsock/test: check also expected errno on sigpipe test
Date: Wed, 14 May 2025 16:19:27 +0200
Message-ID: <20250514141927.159456-4-sgarzare@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250514141927.159456-1-sgarzare@redhat.com>
References: <20250514141927.159456-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefano Garzarella <sgarzare@redhat.com>

In the sigpipe test, we expect send() to fail, but we do not check if
send() fails with the errno we expect (EPIPE).

Add this check and repeat the send() in case of EINTR as we do in other
tests.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v2:
- fixed loop exit condition [Paolo]
  note: the code changed a bit from v1, but this time I checked it
  better!
---
 tools/testing/vsock/vsock_test.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index 68f425af00cc..082c5dd6e8f5 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -1075,7 +1075,7 @@ static void test_stream_check_sigpipe(int fd)
 	timeout_begin(TIMEOUT);
 	while(1) {
 		res = send(fd, "A", 1, 0);
-		if (res == -1)
+		if (res == -1 && errno != EINTR)
 			break;
 
 		/* Sleep a little before trying again to avoid flooding the
@@ -1087,6 +1087,10 @@ static void test_stream_check_sigpipe(int fd)
 	}
 	timeout_end();
 
+	if (errno != EPIPE) {
+		fprintf(stderr, "unexpected send(2) errno %d\n", errno);
+		exit(EXIT_FAILURE);
+	}
 	if (!have_sigpipe) {
 		fprintf(stderr, "SIGPIPE expected\n");
 		exit(EXIT_FAILURE);
@@ -1097,7 +1101,7 @@ static void test_stream_check_sigpipe(int fd)
 	timeout_begin(TIMEOUT);
 	while(1) {
 		res = send(fd, "A", 1, MSG_NOSIGNAL);
-		if (res == -1)
+		if (res == -1 && errno != EINTR)
 			break;
 
 		timeout_usleep(SEND_SLEEP_USEC);
@@ -1105,6 +1109,10 @@ static void test_stream_check_sigpipe(int fd)
 	}
 	timeout_end();
 
+	if (errno != EPIPE) {
+		fprintf(stderr, "unexpected send(2) errno %d\n", errno);
+		exit(EXIT_FAILURE);
+	}
 	if (have_sigpipe) {
 		fprintf(stderr, "SIGPIPE not expected\n");
 		exit(EXIT_FAILURE);
-- 
2.49.0


