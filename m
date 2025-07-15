Return-Path: <netdev+bounces-207037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A7CB05660
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 11:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8E781C21C7E
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 09:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC2B2472AE;
	Tue, 15 Jul 2025 09:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y+fABt8+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E4A1917F0
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 09:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752571966; cv=none; b=lrm/0Z3Phd+ny/qHTrt/hoIFw75kpHlDTMEtvlK+ccv58jzo5zWNbZ74gtH1I3tIUszPUnKqa3eBYSmwle5chn3pVE25GkbraASVTdO0EgZcuXgRPlH95eEWpIDIHGAKW5vC0oA1LyANZIkJUFZsD5zGl9O4RIT8Tp5MfLRwFz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752571966; c=relaxed/simple;
	bh=GkZfLtxd4rzyIxcu6ULXu3eBmNRwQl2rgp8F0T3gZoA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=buA9tittodTEYgN9AJFTBQSASCG4vljdAOMetSh/LrS8x+b+6B/Pdq6ZZXA/YLFQN2KGNSHJJKF5/+UtMmOBEA9D9lP1PbTPCujhkMwoybhh+Zi9UuQG3mmzMTf3FJrq8PbevmmpdAhypuiZgsu+EOpQY5CNg6tnPnPxhflDWJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y+fABt8+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752571963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EiOEc0Gt/YR5fyG8p9UkYR7/Ay+0CPzDFBz+kX1Co/U=;
	b=Y+fABt8+hoKkMl2tSFD9jXSnsWY0oNY8rVb7GwU8O9kCtCU+IKwQh3azB0Rz8CwyyZC60J
	3U+CFPeIagH9jbLfz+tHGRjPjcmiPYZ1uFl0uPAVMXT/hImlicDTzYA0ljkIUoQlYY/+P3
	SSiRZv5nMKbQEcLdK+reqz4zELbjRCg=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-i7lBpmF7PFi9_5-wjVk4MQ-1; Tue, 15 Jul 2025 05:32:42 -0400
X-MC-Unique: i7lBpmF7PFi9_5-wjVk4MQ-1
X-Mimecast-MFC-AGG-ID: i7lBpmF7PFi9_5-wjVk4MQ_1752571961
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-747ddba7c90so4505814b3a.0
        for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 02:32:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752571961; x=1753176761;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EiOEc0Gt/YR5fyG8p9UkYR7/Ay+0CPzDFBz+kX1Co/U=;
        b=iUYbfOU55vwAOa9bJqgLUI3XpiW/8LdcX/elDltsveiC5q7IFyN3aq5rLb6dZkk9Mv
         NnSL7EQc4WCgka3SGFmOCahJ0eDMyAxr+zWSx9IZoiJ5at3O5pV3xf38SDd2Ar0bM4dG
         kIKeTAC7aNtLdKlBXkoetgEBsqAjXxjELY5iwQwgRUrq9Uncjq+izoA+XliGNAuc9umj
         PavOh+0RSCOuQQAdzpvMdl8LKjXdNYs5tuEdef/qUPBSBEJsqq7AraZI+uvga/Wwgz5s
         LYuFUiMfMFTmaMfYx/VmSYG5RQxSbNFu/bVTaCJBG0h+5qsVT09KhFqyc9GNjExdCdOu
         Ue5A==
X-Gm-Message-State: AOJu0YwWee587v/S02SPjFLsnlrfYLipAXPb9Y/QgUoZB3us8k27W5sE
	6+eyw+MOJd8HYO3IRANeSDn3PkdTrPWjUa6bFVEVfQxWzVXKZT5/wPHzhxRW/vRYO574+XK27mu
	g+4hTkvnBB5QRyNuTw6bIAeU6zr/FyrvLiDp3taNz3nPX5pscT6bB6TluW7GjecxMdKhMETQSaK
	CBTQbIpWrtUSZt18a/EMbtRmgjtSCcV/2f681RxAJuyA==
X-Gm-Gg: ASbGncvaCYUNf5Z924guAWQ8zr/XNESXxjPsp0ygO1e/WV092aUjdeepTxtxqpXXhND
	dj9O7wqq4Q6JdAm9rrdhg1ytKi9jvDYuB/i7sELm8h4uRcfWeLOKxan5wwk3l+U1a3ON3cPbjPW
	OOzF6/rI/+N2YeRTryRNjGA0jYGSO5qK9KVN7407oGIde5yKypDZc+YgiWXrlbaZbDbPk54rxPb
	45CD3QRusK2189/7uGZJfFm/1+VmF5WagaY/NcAEt9gHNMVeYt1sq6lh25qpc5bVyfCS/NVyGo8
	rPQKKluolfxyESafALEDdSN1f7dDde1S1QPCRXKyiRc=
X-Received: by 2002:a05:6a00:6ca3:b0:755:ad06:b6d1 with SMTP id d2e1a72fcca58-755ad06c6e8mr3470878b3a.20.1752571960571;
        Tue, 15 Jul 2025 02:32:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGO4PicczXhOq+ZRFEpsVg6kjjHatyMJXJf35/VmICWgRJp0kuSKWotPnb7XS8tEwAkqZzZDQ==
X-Received: by 2002:a05:6a00:6ca3:b0:755:ad06:b6d1 with SMTP id d2e1a72fcca58-755ad06c6e8mr3470831b3a.20.1752571959958;
        Tue, 15 Jul 2025 02:32:39 -0700 (PDT)
Received: from stex1.redhat.com ([5.179.142.44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f2251bsm12466177b3a.100.2025.07.15.02.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 02:32:39 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	niuxuewei.nxw@antgroup.com
Subject: [PATCH net-next] vsock/test: fix vsock_ioctl_int() check for unsupported ioctl
Date: Tue, 15 Jul 2025 11:32:33 +0200
Message-ID: <20250715093233.94108-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefano Garzarella <sgarzare@redhat.com>

`vsock_do_ioctl` returns -ENOIOCTLCMD if an ioctl support is not
implemented, like for SIOCINQ before commit f7c722659275 ("vsock: Add
support for SIOCINQ ioctl"). In net/socket.c, -ENOIOCTLCMD is re-mapped
to -ENOTTY for the user space. So, our test suite, without that commit
applied, is failing in this way:

    34 - SOCK_STREAM ioctl(SIOCINQ) functionality...ioctl(21531): Inappropriate ioctl for device

Return false in vsock_ioctl_int() to skip the test in this case as well,
instead of failing.

Fixes: 53548d6bffac ("test/vsock: Add retry mechanism to ioctl wrapper")
Cc: niuxuewei.nxw@antgroup.com
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tools/testing/vsock/util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
index 1e65c5abd85b..7b861a8e997a 100644
--- a/tools/testing/vsock/util.c
+++ b/tools/testing/vsock/util.c
@@ -116,7 +116,7 @@ bool vsock_ioctl_int(int fd, unsigned long op, int expected)
 	do {
 		ret = ioctl(fd, op, &actual);
 		if (ret < 0) {
-			if (errno == EOPNOTSUPP)
+			if (errno == EOPNOTSUPP || errno == ENOTTY)
 				break;
 
 			perror(name);
-- 
2.50.1


