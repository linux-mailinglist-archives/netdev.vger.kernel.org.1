Return-Path: <netdev+bounces-241057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 41AD4C7E474
	for <lists+netdev@lfdr.de>; Sun, 23 Nov 2025 17:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4AEBB341F7C
	for <lists+netdev@lfdr.de>; Sun, 23 Nov 2025 16:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAC92D73A4;
	Sun, 23 Nov 2025 16:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="xeZ+iMws"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88242D3EDF
	for <netdev@vger.kernel.org>; Sun, 23 Nov 2025 16:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763916832; cv=none; b=UpPZ6bbMpfhXH0kcd55kpBAjqtKIduhkjDKLsORQ48PuwchCYHJr1bfGBqwz/DJwME/rEKlCmuVSpjI9D/aqady3SwTRxmoGKrj3iLV+GN0gV6aCKW9pgz9IAWOa16rhxS0RREn7ENrJkYss/a7mTQ0wgcNGenW0HnzqEbcXdyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763916832; c=relaxed/simple;
	bh=neD7dgumvRF9kVbu/4WODb9GAhIDN6MQhA5kDnAqiSI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eITkBow6qJoLhzGzZnb46AKL4umChtBTKTmUrOCm/57e64q8zJxKzIzfhAZyvgKHzW7+H/nq0PD9GXkm1/jgHkns8k+oa2VjHc+dU1k6VOannNECewtBmezB4JLvFLKNDOucfxqY+Jymn0BH0N4xf8So3c7pS5N6N/XZaR0pO24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=xeZ+iMws; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7bf0ad0cb87so3318124b3a.2
        for <netdev@vger.kernel.org>; Sun, 23 Nov 2025 08:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763916828; x=1764521628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LCt/negTGbHqF7yISi68ytgNU7T74jvg47vhklH6gV0=;
        b=xeZ+iMwssAvmetG2aZj9jQ0DXzwwTHLMfIavmuy5z/41AE5XWELsvxTcJkbpcaUcub
         4TYkcyfolfsyZSXBsu+D7gsndeeQ/gJkO32xPtBZMd2AwFe/HevbRTma1QjFaWyRD5uE
         9zWI0sTdpg51PwbVefx2cVSkBlJmydak/xLgk9RT/Nj5EvS4VtOVUBHzLkwctvDdMh2K
         B2fXPripZ2GNMWpzLGq7uqmLZe7+lXokPh2h8leaAiyIYORq3aJufLJ3CZTO8W4gPeoD
         Xj2K8RgggMTQCk7Z/NvlU6KPl/yZfD/DSQkw5x0l8SVgt3ky9l8I/uM4bAaSfID2JWcr
         7Lyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763916828; x=1764521628;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LCt/negTGbHqF7yISi68ytgNU7T74jvg47vhklH6gV0=;
        b=wSI+Jq0JJub6KZJalo55msOEVajC3UJE2nJli8WT/nGdapXkmrc0Tsjhft3Cmlynlj
         eMhoYpt7kuAEAeATC4MNosvSz6Ew7/JlnmYos+MyIPvd/U1RgyB3E4cBWXRmM3XIcheN
         WAZzohyT/lqOIrojjIwqxPhhEywQ7TOZWDJY205VNt421SzFSoV/ZR5I5guUfdli2Htn
         J6NR9IpBLcVDjmowqb4wS/K1MzGvuXW4QkDjZT24AFNeWdPP0qyLv6RtDcYxznL69Fii
         vl0037DntuEBBqRcG+nxwrUQ+07s8GbNxpwjKskNjLGBeS86T6g6Noj21fkxyX7lc36/
         rGtw==
X-Gm-Message-State: AOJu0YxzS5pnGWKAA0dI+XF1lQVZk0LYLHktIuHsj4HjxBY7p13C/JCc
	LJ0fzRonhjlRhYTj5lH4ZY/Z4RiAYdMJMNgsC1giPKmivXBKy581esjeYJmhtSZYgCmuI/DEISa
	Tnoz+
X-Gm-Gg: ASbGncvahF1PMnhdhr+UYsqm51Iojd20eAugldW99WyOr0kbUleJ3FE8+qBCoEK8qNt
	0jcY9x5EXyJqlHtEIgBFT0q3EZ9I2JKJNPwKU9hXzqSmXCxaFRvNLQty/orx3BVkFLTg1nCSXH1
	hEEJ3XMV4oOby8JZsKoWnPoezPPGQeVsI092QldFul+6ys5q5qeqEykw52kU/037xzWuUTfygok
	xrohaTB2dCmagqkKGAZwPUTWJhCFDolQXiYrLGvbhGRgOTUoy+xh1rZCb/IG/p03PokQQJK9BAS
	UGhnU/+iPg7m4RVh7UUu/Hb/CUJRQcMJ41hpv/WtF1aFVjRIPquCINl6q0gsf6O+kIrO3G8g3fj
	admbKwnq6PNcPEqhyFBjEWL1NTZf6eFne37Be6LlmhemckxfH0BsqvMPccUfJCNFQyA9uKtK5Y1
	E5HBx+sSPfzkz16qj+vws0bUd+y8ckxddt23fbixyFmO8Tv0ZEdQ==
X-Google-Smtp-Source: AGHT+IGzYoPqolxhP1F7erV5oLNcm99GyWB8Vr9CwZa8p7kKYrLEfSOqHGrgEKtbmDNSuUoJdx613w==
X-Received: by 2002:a05:6a00:4615:b0:7b9:9232:2124 with SMTP id d2e1a72fcca58-7c58c3a6a5dmr10352336b3a.14.1763916827984;
        Sun, 23 Nov 2025 08:53:47 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3ecf7d70asm11905887b3a.13.2025.11.23.08.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 08:53:47 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Zhengyi Fu <i@fuzy.me>
Subject: [PATCH iproute2] tuntap: add missing brackets to json output
Date: Sun, 23 Nov 2025 08:53:06 -0800
Message-ID: <20251123165345.7131-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The set of processes attached to tuntap are displayed
as JSON array, but was missing the inner brackets to
allow for multiple processes.

Fixes: 689bef5dc97a ("tuntap: support JSON output")
Reported-by: Zhengyi Fu <i@fuzy.me>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 ip/iptuntap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/ip/iptuntap.c b/ip/iptuntap.c
index b7018a6f..6718ec6c 100644
--- a/ip/iptuntap.c
+++ b/ip/iptuntap.c
@@ -314,6 +314,7 @@ static void show_processes(const char *name)
 				   !strcmp(name, value)) {
 				SPRINT_BUF(pname);
 
+				open_json_object(NULL);
 				if (get_task_name(pid, pname, sizeof(pname)))
 					print_string(PRINT_ANY, "name",
 						     "%s", "<NULL>");
@@ -322,6 +323,7 @@ static void show_processes(const char *name)
 						     "%s", pname);
 
 				print_uint(PRINT_ANY, "pid", "(%d)", pid);
+				close_json_object();
 			}
 
 			free(key);
-- 
2.51.0


