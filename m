Return-Path: <netdev+bounces-172252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BA0A53EAD
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 00:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D98F116DC2B
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 23:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD22E207A3F;
	Wed,  5 Mar 2025 23:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q3lE4eoG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C315207A2A;
	Wed,  5 Mar 2025 23:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741218830; cv=none; b=L0K1Sc0veAe8tLCqWcLU5/cFaH+SNqWwTe2kAMzYG0nEq3uDG6OUEzYVVLjjYszClfQQCyqi+NsNrjySNOerlLQ25ssU87al+hiEWLmR1gwtzjI3XSdod1+Z9QZOW84YU7013VJyJ84cGqQUcANEqWQnSfiRXANORGrhmv7QNts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741218830; c=relaxed/simple;
	bh=9kNx/Y9dmyuYaa9jYYDv0MT4hUIbvIKYUHEGwb0744M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DppKr2kHMo9a2eBrP6F76FJxMcvlT3614G/Ls9ncXPF7iSdv3AV3keSxBfo6NQ/DFSXoY0BsM8wIfN4lLkr942NPkZXzBA5umUgm1UuEMysD4cUMZXSOPD5YvnxxbBbghcwSffDbStqlVAPikcNXkSmBRpUJThP+olFi/Fej/BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q3lE4eoG; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-438a39e659cso36755e9.2;
        Wed, 05 Mar 2025 15:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741218827; x=1741823627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sr8OyA99gxEcrXQuYqZWkpenxbkE9mbapOFjkmx5LG4=;
        b=Q3lE4eoGR+hXXJXlpdZ2Q+BtXLnNr26Wf9t5cIf1xd2b5pAJCDLvEUclQSvpoYsxQz
         rbZqryFyp/D3e/bczh85GLp3Rx76SYGhPKTD5N8/eF82pOqfIRl8dKoK1ACX0FXo7Kys
         ncThP0QoKImyqDPpmzeWANEWQyHnKZ6HOHhVuAj9rgk3qjg2ZrMLefXjOEPJrKPRt/f+
         FYVCFai9pUVd3cdg7M8FHsBnAN4dQlq6w/FJdu1rHLgfqeC5tO+69ch/LivdpXD70Tpk
         1lxm0eWMSotKixnJJqMioahKrQEJrehee7NRIwsKESB4g4r7i89OHIZSdOQq7/nWFkA6
         1Tjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741218827; x=1741823627;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sr8OyA99gxEcrXQuYqZWkpenxbkE9mbapOFjkmx5LG4=;
        b=mkQ4nLe/3d758f1BS9/eULToAvGEJtGA8mLVR3Er5KTBYGPHEhQ/UdfposhpDPQlFw
         J/kQzwJ+3NoI9FTYyTNYf3j6qFHf+LpfKnkk6PL6wdc1e795u+Gtit8yqOIDK014KU7z
         2sWtaoTW1pmxZ6r0boIY3bX7zhKhU5Hf6pVbCw49fycn+L//fyRFvEUyiJRDt9L3ga4n
         /1el5yPv8YtSYLE07S1PVQNdgxTk3NIvB9vjBnndFOQusdz0NMqr7qpqfyyu1Qw780Np
         YqoHglNIAGvptfvy1uU/WeyMIDRcqjGLnMkYRp/sH1/H1gFBXhBh7wH1X8mOz73LRY7F
         f7lw==
X-Forwarded-Encrypted: i=1; AJvYcCWN3f/szNLFMqTuEE8dFbnjBWX4o5wp1/8+btWORG5QNXTaCiSpBe68sYWSo6gz5ZWYbfONWRk/Ph760n0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzY8Li63zRKOtdcophRxJ4tf0q4LN46S9Wx7nNvt+tT/aj1gIff
	6VrmMxPGIkCL5HDN+rzdT6HoNPwVVchK3iZxzhQ9XcqvL+ugGsy2
X-Gm-Gg: ASbGncsU2E7Hc8RiZTFbVje5z4k4/zRgT0DcRIyJKuVzXZMNnES3YtYSLcbvNnGa+IX
	4lf/AQj5+MA1XrN4Q98SodID/7vc3PvwhBMVKX/FIhvbqtckz8fP63n1kVFXsvhctW8CepBLrIX
	GYpgpa2xwQOCBrhudOiRM7VcEvB6+gtythRL96S4S8zr1OHDyjroCdzAT8fD0w2FkrwIwx9TTwN
	y5dY3J3Qi6J92oKQ4dXzas58OLYleW69zw1CUbSTLQqd+HYpyzg55Zljrt3xQ742xOcpHVnlRuq
	qey9J+ATy96UwOu97OOiazW4+ANWYzvRHMomNqt+BYfCrA==
X-Google-Smtp-Source: AGHT+IGOCvVjVaI+2/pVJM7+aGb9FA5XuNO7nYXA3tNg7UvAjXnWkdmyPPruP4fBCgqg3QlGtZTR1g==
X-Received: by 2002:a05:600c:5119:b0:43b:c390:b773 with SMTP id 5b1f17b1804b1-43bd29b41f8mr36153235e9.24.1741218826863;
        Wed, 05 Mar 2025 15:53:46 -0800 (PST)
Received: from qasdev.Home ([2a02:c7c:6696:8300:e538:5de4:1d6b:3509])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43bd42badefsm31861715e9.18.2025.03.05.15.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 15:53:46 -0800 (PST)
From: Qasim Ijaz <qasdev00@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	atenart@kernel.org,
	jdamato@fastly.com,
	aleksander.lobakin@intel.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net-sysfs: fix NULL pointer dereference
Date: Wed,  5 Mar 2025 23:53:07 +0000
Message-Id: <20250305235307.14829-1-qasdev00@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit <79c61899b5ee> introduces a potential NULL pointer dereference 
in the sysfs_rtnl_lock() function when initialising kn:

	kn = sysfs_break_active_protection(kobj, attr);
	
The commit overlooks the fact that sysfs_break_active_protection can 
return NULL if kernfs_find_and_get() fails to find and get the kernfs_node 
with the given name. 

Later on the code calls sysfs_unbreak_active_protection(kn) 
unconditionally, which could lead to a NULL pointer dereference.

Resolve this bug by introducing a NULL check before using kn
in the sysfs_unbreak_active_protection() call.

Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>
Fixes: 79c61899b5ee ("net-sysfs: remove rtnl_trylock from device attributes")
---
 net/core/net-sysfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 8d9dc048a548..c5085588e536 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -117,7 +117,8 @@ static int sysfs_rtnl_lock(struct kobject *kobj, struct attribute *attr,
 	 * the rtnl lock.
 	 */
 unbreak:
-	sysfs_unbreak_active_protection(kn);
+	if (kn)
+		sysfs_unbreak_active_protection(kn);
 	dev_put(ndev);
 
 	return ret;
-- 
2.39.5


