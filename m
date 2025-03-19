Return-Path: <netdev+bounces-175967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3098A68148
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 01:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D6287A4717
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 00:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1A51B3927;
	Wed, 19 Mar 2025 00:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="LdwLkSF8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF6D1B87F0
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 00:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742343351; cv=none; b=X370MUDkO448I7ITnDYNUVzORIavMeBBvkmIbd5DZ1AXtf3OgkEWQvVqASZBBzPhHGamFj328OWo3lSqgJn8HG1OV5xD1K3MQLCX/9kKwXaQh6DI0lvI1COUiMppDz143iluFZTlo2UX22xAUieGsQteWuay/9vHb6qtwhkrbQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742343351; c=relaxed/simple;
	bh=vqb5bSp3KtgrIHH2C10i+ZCVORS25O8aQdSoxaGrdX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OJfNirY/FHhVmc/JE+JFHn6EDGmDq5qu/yGUtiKVxnnOlQh/CGjHROqcnGfyvQwt772dpmM6qKMAUbEyJMZ66K5t1RbAn4mN4vDRCxfN+2j6qvEzh80OahWUk/OiaJLmBCYyBzOd0nphjfoxC2VATaBDUuW5Wo4Wm02nC2sa3tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=LdwLkSF8; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22548a28d0cso18570745ad.3
        for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 17:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1742343348; x=1742948148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2XqGZqCGsxMqM6QeHlFNqgLyn7L0jWSrp5tLsnvgx2I=;
        b=LdwLkSF8TBzC36dt6CntOhHl+LeUMOlyXozok9/QMwsLzJCbZQtUiV5ZsMTPkYtqcJ
         4vcWfNjrYyGyxoOe5/0cRUNiClXg+CCpU+5N+tyoxTI6DfO2pupR5WhY5mA3NEiF58ul
         8MrOhgdbfV7a7Eii7fwAIIFWtUdit226D4msI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742343348; x=1742948148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2XqGZqCGsxMqM6QeHlFNqgLyn7L0jWSrp5tLsnvgx2I=;
        b=r1Hd1BKNM/IqOPBuFWb4GDLyAYFz/DWHKt59Io+yEv0Y3BdI/ueokG6u1N4M/kM3rR
         fASFnX3i0Ry2d8XXasOziA+q7FNEFPsc6PHa6lI3CehT483ox5RbnWnOQv0dWA90ql+s
         CN1YOyiZ2lC4gVMWro1/qnueu4wuIqWH/BPww/wD+cWg3b/sVJ0Ne6MbWuQQEO1kccgl
         mgR4JiML5YdZ469xt2xhrHOr8h6piawdDnmSFRqgJCReRF5idYk/Nxf4TtFQPSs8d6L4
         YOxlfCfZsHwDSADvIHu4Rq3j61UJllfUrbmzqa8kI7nPQ6K6cYXyziEqHjD4oKML5XpY
         tINQ==
X-Gm-Message-State: AOJu0YzZxd0oNPelgpdHS2VJqljUvaY2yY0k9dQnB8rz6eXdUGz/y0Bz
	CfNy2oq6N4rJOlFoReYtTOGvkmjl9aQy+Rq0Xm1XFK0EhP0dVOrAkp/6zKyzv66Wol0DU16RevS
	WU5ABS6Sx+3HcNsjbPp9ROQIduNBKq7ARoTRdLvrNBNbCJecwXgYQZ/z1+H/5WLB8qVi8lV1WRl
	HjmH53dpX7pf+0lCF1cQ9EjjbQTmBh5SBzixU=
X-Gm-Gg: ASbGncsBMTNgDMIj2IoVINTaXSujPeBb8ONbto7bcwH29LAh0Y4Bht6wUL2cLbgidF2
	5JDgua2XKcnFxc11Yvgena6XXwM18Rn2Lu0ogLxpK8mCefhGMBuH8YHppC3bSgBXP1+Rtfb+UIw
	2MfulueeCTBSvuf/Y5NdWFkZs8Px54IAtC4m6ALCIXeAZFKX4P4O14xpEevu3mkPkaRGnRKlJGN
	EvwEvhJaFVKwWPZQqk0YwI9+7ap4uNZMO+znuZxmJ6uznuvns7yDFh2QBPyJJwKb5n88OUORKni
	p3rHdJcpZmCacICW1nwkyoqKCDsGLBeRT0Gson15hSuw6Z03Ahxg
X-Google-Smtp-Source: AGHT+IEmJYpbp+6vVhqsiGvsZq35cbhyVslRXzs04bm/SNmdXK2RzQx72NbvXgQ96Ga+Vw4Kk+NJMQ==
X-Received: by 2002:a17:903:22cd:b0:223:58ea:6fdf with SMTP id d9443c01a7336-22649a3c6a7mr8745335ad.28.1742343348190;
        Tue, 18 Mar 2025 17:15:48 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a4876sm101281375ad.70.2025.03.18.17.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 17:15:47 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	asml.silence@gmail.com,
	linux-fsdevel@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-api@vger.kernel.org,
	linux-arch@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	kuba@kernel.org,
	shuah@kernel.org,
	sdf@fomichev.me,
	mingo@redhat.com,
	arnd@arndb.de,
	brauner@kernel.org,
	akpm@linux-foundation.org,
	tglx@linutronix.de,
	jolsa@kernel.org,
	linux-kselftest@vger.kernel.org,
	Joe Damato <jdamato@fastly.com>
Subject: [RFC -next 07/10] fs: Add sendfile2 which accepts a flags argument
Date: Wed, 19 Mar 2025 00:15:18 +0000
Message-ID: <20250319001521.53249-8-jdamato@fastly.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319001521.53249-1-jdamato@fastly.com>
References: <20250319001521.53249-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add sendfile2 which is similar to sendfile64, but takes a flags
argument.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 fs/read_write.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/read_write.c b/fs/read_write.c
index 03d2a93c3d1b..057e5f37645d 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1424,6 +1424,23 @@ SYSCALL_DEFINE4(sendfile64, int, out_fd, int, in_fd, loff_t __user *, offset, si
 	return do_sendfile(out_fd, in_fd, NULL, count, 0, 0);
 }
 
+SYSCALL_DEFINE5(sendfile2, int, out_fd, int, in_fd, loff_t __user *, offset, size_t, count, int, flags)
+{
+	loff_t pos;
+	ssize_t ret;
+
+	if (offset) {
+		if (unlikely(copy_from_user(&pos, offset, sizeof(loff_t))))
+			return -EFAULT;
+		ret = do_sendfile(out_fd, in_fd, &pos, count, 0, flags);
+		if (unlikely(put_user(pos, offset)))
+			return -EFAULT;
+		return ret;
+	}
+
+	return do_sendfile(out_fd, in_fd, NULL, count, 0, flags);
+}
+
 #ifdef CONFIG_COMPAT
 COMPAT_SYSCALL_DEFINE4(sendfile, int, out_fd, int, in_fd,
 		compat_off_t __user *, offset, compat_size_t, count)
-- 
2.43.0


