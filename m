Return-Path: <netdev+bounces-212624-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D50DB217B0
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 23:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 145982A5B02
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 21:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE952E3B15;
	Mon, 11 Aug 2025 21:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V31B6ztW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448FE2E3AEE
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 21:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754949280; cv=none; b=Ly8zz4pzyhbS4Ymu9LAexwEjKHeY64HU/VFyXEFbL51Vt+XDO4gPDA5vDKHmkYbIgex2TwRyu0W67In/5K+PUlb5gIoJASehJYfykSGidvHWlzKe4MUUe/JzKgC6M7JkcWaO572x+EkXfE3YSSqwGVkoaUXe/yKLDIK5POgkjtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754949280; c=relaxed/simple;
	bh=ygDheg7g5g0AcarOc3zGOGNMtcy5SIVYjF8tZKIxbkw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Wbhri0FXeOCddt3SiLGYh8RMwjCXe57AG9Gz3B3UXz5iNX6Ft3Bysah5W+NVY0JHWn+zicizjiBScIEDnmImj9+WCHOpcEXsebYR1768+YAmcwQ4AXmso/xOZAn4MzqoNOjZB6hm6W9XupQwpjd6DFVw+z+QCKST/VrOqNbVzBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V31B6ztW; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b46ed24bc6bso613537a12.1
        for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 14:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754949278; x=1755554078; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XunXCymLCADNa9NtEcZBRMZjgy5A+zQV6SgeyvILB+I=;
        b=V31B6ztWj/HTS32QvMuu7VmDCzbupfIsyMhrf+xQ7oOisYkqQ8u9oePd66N4fpP+CP
         hlOD31DTM+GIJ1li6jwr0pnGJv3ItbA2bz2hlYQ4FsK5jdpmAwY+NfHMpSIYvmwLJApL
         v5vc3oFZjvUEcc9Nf0x3Er53HYSPaeKE8XYVo+VnhAQmchVfIN1wp6Bfu/opQtSDLiFg
         rWx5faURmqxxi6ezsppX9ABKn0RspqOgwU9wnjxI5UyPIv94v1fkaWKO4tcmZ0KtkyGH
         +Z+av6MuFHwxQb7wXOlMNasjpnNGlpU+55I1J71KYHKK26A2IXaXawWau+MHnd1jOJLI
         XWlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754949278; x=1755554078;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XunXCymLCADNa9NtEcZBRMZjgy5A+zQV6SgeyvILB+I=;
        b=GpB296q2cI9nv0Epe10iruQpORY/wADRVxIsQjMo0nLZgtLo9I9cw9PsWGMgHNdXfn
         7ro/3mwd1wlsFB9/fh4QDkk0EIe6bM65VADpJwBGab8VyjA+NqgFmAlaQw29gk8iztlF
         6gtKV0tSCETYOZYwwG6ivCXlzJJEqk+v8kMVYTZGWcpUxjZDQXAyTPmvIpy0mClcGVsK
         fzXbookmHt4dvFUJ+1ip277+yGUlSGsUs/wAzW1ErsPeq0D+B+69cyd7FpTLR/sf1eme
         A/Cg/55wyeS3fDGbiA+aKxLcYgFd+HzL4/CU5RJeTdtWQt1nXI06BJOBKCcvcH3/3lxl
         cOSw==
X-Forwarded-Encrypted: i=1; AJvYcCWiJY5dci8e9932Fq8jBjnYc6U0mp4GwBuO561nNibDA7l9KQygtKxHPyh2MVtB4ePBRFb8VBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOkfeSqMXoWYOtmI9M439monmwGq68tm+gg8Cy+g/+OlSOA8zK
	DX8+ByYNiaaw3oS71mPj3Un1fUfQo7Z4nMSmAv5G2OWKdci7ZLLXTr/MxQZx7ZwPY1mn/lnl2iy
	O+BoCpQ==
X-Google-Smtp-Source: AGHT+IHKlNVld5e/fXfG5O99DLZZ0tI5vwix6lhHqPOj54uI1fWEBx4QKy2sVV4w3iAZVM3KxJsC4E0Undk=
X-Received: from pjuw14.prod.google.com ([2002:a17:90a:d60e:b0:31f:d4f:b20d])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4a91:b0:31e:d4e3:4015
 with SMTP id 98e67ed59e1d1-32183a03962mr19759664a91.8.1754949278392; Mon, 11
 Aug 2025 14:54:38 -0700 (PDT)
Date: Mon, 11 Aug 2025 21:53:05 +0000
In-Reply-To: <20250811215432.3379570-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250811215432.3379570-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc0.155.g4a0f42376b-goog
Message-ID: <20250811215432.3379570-3-kuniyu@google.com>
Subject: [PATCH v1 net-next 2/4] selftest: af_unix: Silence
 -Wflex-array-member-not-at-end warning for scm_inq.c.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

scm_inq.c has no problem in functionality, but when compiled with
-Wflex-array-member-not-at-end, it shows this warning:

scm_inq.c:15:24: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
   15 |         struct cmsghdr cmsghdr;
      |                        ^~~~~~~

Let's silence it.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 tools/testing/selftests/net/af_unix/scm_inq.c | 26 +++++++++----------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/net/af_unix/scm_inq.c b/tools/testing/selftests/net/af_unix/scm_inq.c
index 9d22561e7b8f..fc467714387e 100644
--- a/tools/testing/selftests/net/af_unix/scm_inq.c
+++ b/tools/testing/selftests/net/af_unix/scm_inq.c
@@ -11,11 +11,6 @@
 #define NR_CHUNKS	100
 #define MSG_LEN		256
 
-struct scm_inq {
-	struct cmsghdr cmsghdr;
-	int inq;
-};
-
 FIXTURE(scm_inq)
 {
 	int fd[2];
@@ -70,35 +65,38 @@ static void send_chunks(struct __test_metadata *_metadata,
 static void recv_chunks(struct __test_metadata *_metadata,
 			FIXTURE_DATA(scm_inq) *self)
 {
+	char cmsg_buf[CMSG_SPACE(sizeof(int))];
 	struct msghdr msg = {};
 	struct iovec iov = {};
-	struct scm_inq cmsg;
+	struct cmsghdr *cmsg;
 	char buf[MSG_LEN];
 	int i, ret;
 	int inq;
 
 	msg.msg_iov = &iov;
 	msg.msg_iovlen = 1;
-	msg.msg_control = &cmsg;
-	msg.msg_controllen = CMSG_SPACE(sizeof(cmsg.inq));
+	msg.msg_control = cmsg_buf;
+	msg.msg_controllen = sizeof(cmsg_buf);
 
 	iov.iov_base = buf;
 	iov.iov_len = sizeof(buf);
 
 	for (i = 0; i < NR_CHUNKS; i++) {
 		memset(buf, 0, sizeof(buf));
-		memset(&cmsg, 0, sizeof(cmsg));
+		memset(cmsg_buf, 0, sizeof(cmsg_buf));
 
 		ret = recvmsg(self->fd[1], &msg, 0);
 		ASSERT_EQ(MSG_LEN, ret);
-		ASSERT_NE(NULL, CMSG_FIRSTHDR(&msg));
-		ASSERT_EQ(CMSG_LEN(sizeof(cmsg.inq)), cmsg.cmsghdr.cmsg_len);
-		ASSERT_EQ(SOL_SOCKET, cmsg.cmsghdr.cmsg_level);
-		ASSERT_EQ(SCM_INQ, cmsg.cmsghdr.cmsg_type);
+
+		cmsg = CMSG_FIRSTHDR(&msg);
+		ASSERT_NE(NULL, cmsg);
+		ASSERT_EQ(CMSG_LEN(sizeof(int)), cmsg->cmsg_len);
+		ASSERT_EQ(SOL_SOCKET, cmsg->cmsg_level);
+		ASSERT_EQ(SCM_INQ, cmsg->cmsg_type);
 
 		ret = ioctl(self->fd[1], SIOCINQ, &inq);
 		ASSERT_EQ(0, ret);
-		ASSERT_EQ(cmsg.inq, inq);
+		ASSERT_EQ(*(int *)CMSG_DATA(cmsg), inq);
 	}
 }
 
-- 
2.51.0.rc0.155.g4a0f42376b-goog


