Return-Path: <netdev+bounces-175962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40039A6812C
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 01:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6E2517DA6A
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 00:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935A014F123;
	Wed, 19 Mar 2025 00:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="O2X7mrh1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DC11AAC4
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 00:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742343342; cv=none; b=pi8TVIDgk4Qe9ymqdidmtIRzJSF9ARiq689SRcsxFodanCV3LKyv6LdRzGKkkprLBQta1keGc9We5KSVmk8bdUvbK8ZG2OUj8YjfTaBiLKvgbxnIQSZmDqEfzHc0cbaMK/SCzcYTcTVgHGSbrXpjCWYpOgGkzn2Jl2tJr8PEnaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742343342; c=relaxed/simple;
	bh=zDwqRePv1ZFUDi9FjMPQDVKfJ1n1RRe7hhmBOVzyCME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EzcWg8nyIcqtQDUlAH43sHg7WMEpNHXYSA3as7yVV+V18OLR3E9p2hd7OoQ5jRIii3rbORFJrnggcyJRzJb9gd+HlB9vG/RY+X34CJRKujUv6r1w2QHIGmASe5XAEQXNUt2C2VscbWKf8QDIgjsNTTYqRORT9AtiQ5JVus/nPHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=O2X7mrh1; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-301493f461eso4477353a91.3
        for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 17:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1742343340; x=1742948140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jx2MMZGi/yQrztop394w65c9xYaCiVDt+AK5Yt9ywsM=;
        b=O2X7mrh1SOA7jzM09va38s+YshWVT8GQiDPzSuGyIkCelFQnrJWTlm2doDiQWdX2yq
         H+AG51PPKkzns1XtggVk0pzgood1TQfa2zuL1WgZJZ5xmBV5n2f76Qq5ugD7LMkQQxPr
         sk5fvWwrAsvNzHa35dno9vSwT2qqP9dLWO2vo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742343340; x=1742948140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jx2MMZGi/yQrztop394w65c9xYaCiVDt+AK5Yt9ywsM=;
        b=pRiPK2mEUjhLJIU0OIXgHxlgCQSlyFnxjrGhH5K2HHLJ2x3jAg0x+hDZD9pKj4msRi
         rRhDvUP12GqLCVrTcTH5RKvLIpXSiBY3YmRPjTyVSCfnxD8ZWkaskK8IFQ4VVmrBTU/T
         9P3iKOKAT3EplugmbKyGxjVsIEbuGZm2tLTRK5/Vu5Gcasy3N61Uo7HH8bvkKWOguo6+
         G/715yxOAU8lACvUPV/xOVKurrdOUoXdmlc56dgJKKbl/C6+1q4m3kr04HifUXPtufan
         t90M+DMzRQpuigRL1MA7lFvObvetbBKJZ2zfoUxf45PDdytFHVxlfkOEG7RBmo57S8XQ
         ReSQ==
X-Gm-Message-State: AOJu0Yxp/AG/MfgipULUtNkz/emk8Ws04H6BIGuhiQNEFbP7QgVzw6Tq
	Di1a3TsXF1AHbZ/o4/7eInb/Foufv71ha5hPdtbwy+0NjYvv7S0gvQq1+KxrLbP/UqyVxRQIK9X
	GIw/PMXdfQfF/M/EZcGTy2UJJfa3F+jcy7x88Rp9eG64xaJ6Uj71BHIqgc09WSoaZFWM9Mt3dTL
	YC8xa932z+hOeMSC3YpQMYAp75eEsOejMyjH8=
X-Gm-Gg: ASbGnctiBc7xvTHeMVBYE8LpUyG2YuXHukwO5IOhuW8IeEAWlbPblju7Ksr3matZYje
	+8bEAzmemQdmPQBXinAYee7XvwfJa6gQ1YNKa0spEEFpNJaJtJ0z2Xl2eiNqwQv0/DJmySpCmyq
	+mUc9drL+tPH6UJ031mpkgV2i706LYZuipIgbA6DgtCeLQwqdt8OrQeU40NXIAng/VmTyrZHKOt
	67ivj6X2BrbssdHV597tT99Ty0DVFRaL7kdzjhYezHykc5CQ/0GJcI6fjGqKC8S01NmdU6sRuE0
	/+VdcHO+iwaVHmtP4sdm+lYA69FMfSEnN+Am/p9PTq0Ek9zCC4SwPRpyfc9wi5U=
X-Google-Smtp-Source: AGHT+IEnc6PYsekT6MewbYE2xz5zbksEbwPRypdKB1fVzKJg+O8NyDF3d1M1ZZ7rEg687HtSnDkx0Q==
X-Received: by 2002:a17:90b:2f44:b0:2ff:5357:1c7f with SMTP id 98e67ed59e1d1-301be204e8dmr956493a91.30.1742343339529;
        Tue, 18 Mar 2025 17:15:39 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68a4876sm101281375ad.70.2025.03.18.17.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 17:15:39 -0700 (PDT)
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
Subject: [RFC -next 02/10] splice: Add helper that passes through splice_desc
Date: Wed, 19 Mar 2025 00:15:13 +0000
Message-ID: <20250319001521.53249-3-jdamato@fastly.com>
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

Add do_splice_from_sd which takes splice_desc as an argument. This
helper is just a wrapper around splice_write but will be extended. Use
the helper from existing splice code.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 fs/splice.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 2898fa1e9e63..9575074a1296 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -941,6 +941,15 @@ static ssize_t do_splice_from(struct pipe_inode_info *pipe, struct file *out,
 	return out->f_op->splice_write(pipe, out, ppos, len, flags);
 }
 
+static ssize_t do_splice_from_sd(struct pipe_inode_info *pipe, struct file *out,
+				 struct splice_desc *sd)
+{
+	if (unlikely(!out->f_op->splice_write))
+		return warn_unsupported(out, "write");
+	return out->f_op->splice_write(pipe, out, sd->opos, sd->total_len,
+				       sd->flags);
+}
+
 /*
  * Indicate to the caller that there was a premature EOF when reading from the
  * source and the caller didn't indicate they would be sending more data after
@@ -1161,7 +1170,7 @@ static int direct_splice_actor(struct pipe_inode_info *pipe,
 	long ret;
 
 	file_start_write(file);
-	ret = do_splice_from(pipe, file, sd->opos, sd->total_len, sd->flags);
+	ret = do_splice_from_sd(pipe, file, sd);
 	file_end_write(file);
 	return ret;
 }
@@ -1171,7 +1180,7 @@ static int splice_file_range_actor(struct pipe_inode_info *pipe,
 {
 	struct file *file = sd->u.file;
 
-	return do_splice_from(pipe, file, sd->opos, sd->total_len, sd->flags);
+	return do_splice_from_sd(pipe, file, sd);
 }
 
 static void direct_file_splice_eof(struct splice_desc *sd)
-- 
2.43.0


