Return-Path: <netdev+bounces-168429-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD11A3F046
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 10:30:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B52783AB0A1
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 09:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5831204096;
	Fri, 21 Feb 2025 09:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="f9H1DHwQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C9A201116
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 09:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740130175; cv=none; b=kXA1uWTc7/E2GYmRENxbxyn7gtykoaWb0rD43+9RkQXLBlAewYpdjhXgPeRUx7n6uGoJO0NwlcO07bkRnsw4YLQRuuFbQV6EaTMRgwbMmQz1K7BZNawXH55iusm+lE1TfQrYL+7qw0x3GuibHkjsHPu68X/apKEFqn02COuSsi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740130175; c=relaxed/simple;
	bh=rv3oez+71+oE1jjLuhlEtcmtglCbNXUL0/wXSH2bxoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nZ7tT6on/lA8C/bhkNKFrBA123uyzkRDYrrz7y7GGfdVXJcMqmmCtZSHrgnHQfncK2Tdd8ZTvn42jgqltUQ1IYQRl3xam5oPBd/u6pLwmkpuNiUXXnB8OR/H0Hyf0qgfow5hjYNzlM9PLribEnMRXZLviSOnp5lkPPRjcFn/FkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=f9H1DHwQ; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e0516e7a77so2909099a12.1
        for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 01:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740130172; x=1740734972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=POgYQbsQnV1gDH1m75YPrZ0f2GeXkcWQuhdwzcAfweU=;
        b=f9H1DHwQKbcRzazc0vlNzUDhwNCT9562b8tBFK2ViGxGKaqjI/34umNe5FJHOyeLGu
         WOtqVQHkFLYgJQwMsnEFck7B7QESi56FHiAu/ilRmwAqy6hkTGJzEiVJQ7Sztl1DfR1x
         +KvtYuSYhqVXHXdxMjCGqWM0faQIhthv4l08ZhDyyNnfzB0Mmxqs80f+6yBNflLMbkE7
         R+wn05UjgclztDU4p1mUFwt+LotOeio6A58RRUotsp80uliH+amnk+FAPsyzDZ8XAIs0
         S0jL5VOcO2WNMNp5aNJOSnkuaI8tGgJfY8NruZJgkT1myrLQ3DMutUl0mNp3oKXjkPzf
         3y0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740130172; x=1740734972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=POgYQbsQnV1gDH1m75YPrZ0f2GeXkcWQuhdwzcAfweU=;
        b=HoU+R9LPFOrp8pmDNNRkUFuPyniBA9h3F0cWniChHF65/xPFsfkjNujiGMxKxNlCUx
         QMby4cS8rm61v59SAQA+L4SgaWSnQtuWnQzaV5ZczO77zIQMgBe2jeBKR14uhnelXfGf
         6lZ7fiUIpjszm39QeSH+3DU93niNf64rDOOBdIn8RMa8udrirY+Ak3k02GTU0NZwA67r
         WVpt+l/hRDMqj/6pYfrEFRTnBFoXMVyIeu8vImy+VboQFax8vPYOGLv+OQt0vXBbDsqg
         SGZe1E/7uuOov8O/0zr6zDOX6KsCgltut4agCpC4TMeBWWN8TbxtE5Fkqq5zLsuIyOuL
         7iDA==
X-Gm-Message-State: AOJu0YzzQnggfQ4o4HJT9YmlrAtdvaC0dN7X20G8CkUUN77GM1eOrBCU
	c7e0Q4OMZXzlbdqHen6W6wz5K5ru1z+rAWegx1HnsGCMNcGbLkYi0zDSBXI3bPKt4+AHRAq4szL
	MGpM=
X-Gm-Gg: ASbGnctGEarYq7z5uzXzen2IyfnWw1RskIHQtqThEr2PSePpDo5QCH+DryrwiTPRZWh
	SonVTgn86do2qJ6HRuDvdI8MsUqR3gjFt4ccIYnAQ6v3uXiPMWQQQlDUC8JbjI3FCizVo+sdSgC
	Jv2wqnzj8mUugvq/RliKpLyOcDBaBtsMMfjjnbDkq1aVJzie9DTeZxTyKZ3AP2xkVKJWlpCbSVO
	MqEIimecESCA2Os9LPp/tUy3gef/NDoIbN5ygJmBS5eDJmLPX4PlAkUE2x5i4wOozuQxQzY0vMD
	ZrdS7nURCS7mMAXp0Sb2T8Ko/FNP
X-Google-Smtp-Source: AGHT+IG/sasHu7/EmFM0vbCaudoNp8ZAs42at9FdIers+z/8Qoe1bdQnLguamBeOMlGvpsAanUcwRQ==
X-Received: by 2002:a05:6402:2691:b0:5dc:d10a:1be8 with SMTP id 4fb4d7f45d1cf-5e0b710b4c1mr2007685a12.19.1740130171891;
        Fri, 21 Feb 2025 01:29:31 -0800 (PST)
Received: from blackdock.suse.cz ([193.86.92.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1b5415sm13272161a12.4.2025.02.21.01.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 01:29:31 -0800 (PST)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: netdev@vger.kernel.org
Cc: mkoutny@suse.com,
	mkubecek@suse.cz,
	Davide Benini <davide.benini@suse.com>,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 1/2] ss: Tone down cgroup path resolution
Date: Fri, 21 Feb 2025 10:29:26 +0100
Message-ID: <20250221092927.701552-2-mkoutny@suse.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250221092927.701552-1-mkoutny@suse.com>
References: <20250221092927.701552-1-mkoutny@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Sockets and cgroups have different lifetimes (e.g. fd passing between
cgroups) so obtaining a cgroup id to a removed cgroup dir is not an
error. Furthermore, the message is printed for each such a socket (which
is redundant each such socket's cgroup is shown as 'unreachable').
Improve user experience by silencing these specific errors.

Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 lib/fs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/fs.c b/lib/fs.c
index 622f28b3..6fe1d6db 100644
--- a/lib/fs.c
+++ b/lib/fs.c
@@ -223,7 +223,8 @@ char *get_cgroup2_path(__u64 id, bool full)
 
 	fd = open_by_handle_at(mnt_fd, fhp, 0);
 	if (fd < 0) {
-		fprintf(stderr, "Failed to open cgroup2 by ID\n");
+		if (errno != ESTALE)
+			fprintf(stderr, "Failed to open cgroup2 by ID\n");
 		goto out;
 	}
 
-- 
2.48.1


