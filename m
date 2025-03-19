Return-Path: <netdev+bounces-175966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D915A68145
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 01:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08F5D1891CBD
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 00:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A9E1B87E2;
	Wed, 19 Mar 2025 00:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="YMPzI8dC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D006C1ADC68
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 00:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742343349; cv=none; b=d50JdJK+qFMTUomc4WpxpIQTuZ2mC8GKtYEjSePWXeVw84IbtmB9yIq5tiKQ7h7zUilaA8jx2klyOzfn336RKbGoArWImVzE7e8VFAdIeAn663Z1vnOgZl00DoenhJuo75QRkSAwhxe0NoLfNoSdtR33P/KtiMYETbg0Lnpc5n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742343349; c=relaxed/simple;
	bh=5PCOzmacR5yYFup3o8g8dQwSPaboFM0aGB+HiTMI2DM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ltFGVxbIWloGTy6U2RXtu8OqQLOTWZFdf8YNVVRNWgUkc7mgf1WrVpvMBBrmulzO6zGBq2SAViDeh0+JXaWzkohc7LesqCG1NhZR3pGisJKd1B4eMmMTjpNlCVur0Q4Dk/w+fzY8cDSXwYTBnew3xtheEQON5usrx5WDBAgdGHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=YMPzI8dC; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-224341bbc1dso119939575ad.3
        for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 17:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1742343346; x=1742948146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+Q0E5apPluO3qX6mmuEZ2SRhcKnzs7kllQ/gSC8Vl0=;
        b=YMPzI8dCZhmG0Jgrf9/z4ds0YcgMu4ROkPE9Wwm8zEbNQbTxIZakULjVeXB/WrXl+f
         m9Xf2ZWsM5ytUURf3JCxWr8GSMeMG9JXni/Zod7xJ40W92K1dPyhWLXmUAmwmAjY5WoO
         rG7RgM+Qm5FLNMSZ3wgnazMpZRemKFcKlKPuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742343346; x=1742948146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A+Q0E5apPluO3qX6mmuEZ2SRhcKnzs7kllQ/gSC8Vl0=;
        b=V92yGeo//U8XMvBMxeYPdnWJ8RAEKIfp6D3MlJBW0mQ/d0/gqpbe18JfIEzBsOZWNQ
         ZjVyEYy72eZ42dH8pgrVdB2NdWHRtnmBW97RH/OqcuJhMoBpRUl4RJvtAIZ7U5JPFXag
         01aZ0vV78yJUqwKOIIbdY66+xkNJF09xDcdMjlpdNAi/X/+NoPow9l0jiZSXbgDwqze5
         UTZLbiJQEsG2mhwQH/ZR38vV1m1Ls73rYa4Mg4boeNHc8B3G5iOhF1QvJDo58L4TxXxp
         Z+S46aD7LOTsWcWSHHNZG1SKpyfvK6ugFGEIMgmlWqq2/bTmglQYhNb59gGWRNpyRCn+
         xQ5w==
X-Gm-Message-State: AOJu0YzcwA0KP2f9eMqJ4v72ILP0Yfg2vGinsAcIw0a6KFR45GGnCj/A
	wpJs+k80WnQgI6PNs4mmEPA4/UgFJjAlmM9e0doy4n9QnZadU3jMVkk9KPbFq3XanRlkJ159kjO
	EUIbWp6dTHHJAxWOLzlUpUrOTIA61QjKk4kcJdFyr8Nfec8FCgtf6YwpEJOtp7MoTX8MlVVxmkh
	Dg+6VXOVy/NHQgW87h8VRmTcj+vrn9k51DxRM=
X-Gm-Gg: ASbGncsOC0/LsYGQrMaj0m1Mr+p7NfKDvpPeHZofYysRYI2mHcCmpcTpocU9upS5HLY
	6b6wj0kTPtcel+i2gEVH0yzjAXGlr7a+Aodv5yUmvt/XXgCjw38c7lvHSWtfi2ZUMPXvxVcaol+
	hRlYS2FSC3P/F+Py7W9VG7yYia5XljC3Ehicc6zHEl/aEywOFQnPVvGO+LKbxQmOUyL5NfBJdD9
	nYLSzDIpSOrrVbZkuWUzS11jY59flrH8McBdstEltXw1cJ6t1YuMFhSJQIgBESaDjhroJ9DJY+s
	0V1VE9CSObQp0zTouJYtuVdgmygW/jDY4qXBLdevlSLoV7puCwcWw+iVQLcB1CA=
X-Google-Smtp-Source: AGHT+IEOR8SkYAUNB17u62ljjwaf2hFD6D0NrcmHhlERldyKjuA2Rr70AEoQme8oc1Ybx9thwa9WTg==
X-Received: by 2002:a17:902:f646:b0:210:fce4:11ec with SMTP id d9443c01a7336-226497ffb08mr9977165ad.1.1742343346457;
        Tue, 18 Mar 2025 17:15:46 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a4876sm101281375ad.70.2025.03.18.17.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 17:15:46 -0700 (PDT)
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
Subject: [RFC -next 06/10] fs: Extend do_sendfile to take a flags argument
Date: Wed, 19 Mar 2025 00:15:17 +0000
Message-ID: <20250319001521.53249-7-jdamato@fastly.com>
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

Extend the internal do_sendfile to take a flags argument, which will be
used in future commits to signal that userland wants zerocopy
notifications.

This commit does not change anything about sendfile or sendfile64.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 fs/read_write.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index a6133241dfb8..03d2a93c3d1b 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1293,7 +1293,7 @@ COMPAT_SYSCALL_DEFINE6(pwritev2, compat_ulong_t, fd,
 #endif /* CONFIG_COMPAT */
 
 static ssize_t do_sendfile(int out_fd, int in_fd, loff_t *ppos,
-			   size_t count, loff_t max)
+			   size_t count, loff_t max, int flags)
 {
 	struct inode *in_inode, *out_inode;
 	struct pipe_inode_info *opipe;
@@ -1398,13 +1398,13 @@ SYSCALL_DEFINE4(sendfile, int, out_fd, int, in_fd, off_t __user *, offset, size_
 		if (unlikely(get_user(off, offset)))
 			return -EFAULT;
 		pos = off;
-		ret = do_sendfile(out_fd, in_fd, &pos, count, MAX_NON_LFS);
+		ret = do_sendfile(out_fd, in_fd, &pos, count, MAX_NON_LFS, 0);
 		if (unlikely(put_user(pos, offset)))
 			return -EFAULT;
 		return ret;
 	}
 
-	return do_sendfile(out_fd, in_fd, NULL, count, 0);
+	return do_sendfile(out_fd, in_fd, NULL, count, 0, 0);
 }
 
 SYSCALL_DEFINE4(sendfile64, int, out_fd, int, in_fd, loff_t __user *, offset, size_t, count)
@@ -1415,13 +1415,13 @@ SYSCALL_DEFINE4(sendfile64, int, out_fd, int, in_fd, loff_t __user *, offset, si
 	if (offset) {
 		if (unlikely(copy_from_user(&pos, offset, sizeof(loff_t))))
 			return -EFAULT;
-		ret = do_sendfile(out_fd, in_fd, &pos, count, 0);
+		ret = do_sendfile(out_fd, in_fd, &pos, count, 0, 0);
 		if (unlikely(put_user(pos, offset)))
 			return -EFAULT;
 		return ret;
 	}
 
-	return do_sendfile(out_fd, in_fd, NULL, count, 0);
+	return do_sendfile(out_fd, in_fd, NULL, count, 0, 0);
 }
 
 #ifdef CONFIG_COMPAT
@@ -1436,13 +1436,13 @@ COMPAT_SYSCALL_DEFINE4(sendfile, int, out_fd, int, in_fd,
 		if (unlikely(get_user(off, offset)))
 			return -EFAULT;
 		pos = off;
-		ret = do_sendfile(out_fd, in_fd, &pos, count, MAX_NON_LFS);
+		ret = do_sendfile(out_fd, in_fd, &pos, count, MAX_NON_LFS, 0);
 		if (unlikely(put_user(pos, offset)))
 			return -EFAULT;
 		return ret;
 	}
 
-	return do_sendfile(out_fd, in_fd, NULL, count, 0);
+	return do_sendfile(out_fd, in_fd, NULL, count, 0, 0);
 }
 
 COMPAT_SYSCALL_DEFINE4(sendfile64, int, out_fd, int, in_fd,
@@ -1454,13 +1454,13 @@ COMPAT_SYSCALL_DEFINE4(sendfile64, int, out_fd, int, in_fd,
 	if (offset) {
 		if (unlikely(copy_from_user(&pos, offset, sizeof(loff_t))))
 			return -EFAULT;
-		ret = do_sendfile(out_fd, in_fd, &pos, count, 0);
+		ret = do_sendfile(out_fd, in_fd, &pos, count, 0, 0);
 		if (unlikely(put_user(pos, offset)))
 			return -EFAULT;
 		return ret;
 	}
 
-	return do_sendfile(out_fd, in_fd, NULL, count, 0);
+	return do_sendfile(out_fd, in_fd, NULL, count, 0, 0);
 }
 #endif
 
-- 
2.43.0


