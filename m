Return-Path: <netdev+bounces-190251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02258AB5D82
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 22:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AF221B45116
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 20:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2ABF2BF98E;
	Tue, 13 May 2025 20:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImqrZLn1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C393E28CF42
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 20:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747166510; cv=none; b=GnduriY3o2JKdmX1jDpzGehaYYQaj3TB4ZdHE2RNvHHxc+0C30ZNNr3gqniU55ws/hHW1pvA0HOdezeUOpxHOsZ5gbUaxKj8KPfQz1rwAbklvUzgRsr4sD+GdPigKPS8dWjithSq/fhr0+3x5gFl5uZrQUJGRj32FO5ZXkiHOgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747166510; c=relaxed/simple;
	bh=PX+OIOKpV49nys5m9EOd/p9Gw7RlB/F8s5UE+EIleKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UsjWvl65098D5Azl4fkNz+QARqHVwAmiFahAhYhv2IVeQQgs2aOYaiRVSJ3Y3C9DW5zVEbfqvlwJrHXoSYxZ3U2ZyrrQqTxrHDsUG2nfXyxkVwXRZ21FydL4MiWumXRZs85B6X7NUfgsTlMHscYcxi20axl6PyKDFQjQsPLtRhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ImqrZLn1; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-54e8e5d2cf0so6435529e87.2
        for <netdev@vger.kernel.org>; Tue, 13 May 2025 13:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747166506; x=1747771306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k9Yig+kNyVRJJ8BQZWn/VuTrEaP0iQwoIB+QLI82CoY=;
        b=ImqrZLn1sXI1NaDAwxrXWNgu5fpPWglbs8kguYw5w8c2osmtrt2laB7AsE8pK8/xDf
         JBSYKlFbU1zYCXqe4TH3kbnVIICz+kUuhYwbciXWfY9UZwnq1JVIrbkZDl540zdzZ0s3
         Il4BfXJ8D5DALtHZkJQsxJkPYaR3yWNAkbtqcTvNIqADBV4KF/H0fU7xLlNJDJsphw6t
         dDt6s2Ok9P2IhWEu4quGIs4vsy77RVLf/AnAIHRnGVTp+iCNDTU879esf9WE3GlzZxDp
         PsoeRKhlVxyNRZY39k0ZChXlaoBA1FhMMiULSTv7yDHGwwnH7bdI0aQhzBEv7vo50OtH
         ozaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747166506; x=1747771306;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k9Yig+kNyVRJJ8BQZWn/VuTrEaP0iQwoIB+QLI82CoY=;
        b=B7AKkPeMXUns7W0Um8Ss2k+HWRlJTzwqC5WLi7Pt1ihodcnzC6gMe55lfgVrQ4wU7b
         V873PvYkjleZ0nPZcjBAPT/m0QtznFb262FAnutoH2pLmxaaA3N85la9GFG19MYPFDhL
         YvRsSDb1j0Kar8Dyt81COzmoGHkaYcI4zUUck1rNT2S+soPu0JW9c/QWMfImZUzp1RbE
         lz5WcZlo+TwImXacKM8AA4syw4GiloURnwI1owFTCrc8JYFOdvDVgf/ktg552mzP0jpA
         YADEsplJL+X+d7luMkIbj8AyAKxFgKuAS+bv6cGheHADFAHIdOWNefJ9sfUtV641KER8
         PD8A==
X-Gm-Message-State: AOJu0YyIRTB/h1ddqpkQz8Bm7iuwG3W2JVh1DsS3bqxOrWKgH3giyTEn
	RZ+uf4lwH1xM8OvVuufHmI9PY28yGT1pA9cQ+ZN6wI8V2f88ksrvMTEJpYmb
X-Gm-Gg: ASbGncsaVgl8f/L5oPbOaphh0lJNd9o3JnMwQliuSKtmQ43ut8zZVYtRe+KWUtxOfKt
	k97/3m5JuLn7K0sBcb4moKsB2F4AHcTvq50SCpkGOThaFEUcmcdtW5RtTlBfiuSXwshy9vGJA5p
	KnPVQxBKA57IQxXaE/JtI8zQNm7WsB5wxOj0tn+9lOYDKm74Ea5fbGhTTBhetFC+dHlHsVYcFNH
	h0sPff7TzCcvlv+wHcpPXXCfK3ynyy+7/zM/E8fc17bMiXmhJChh6TBlDD9cxY+QKR41cJM29Ys
	h72OVoNUnyn7yv4Sh37MBS4MSheDoDbxbsywRoX+Bf+vKAyY1J4LP3rp3yhiue83MhdY0mIRQgM
	Cosn0ejnFBhtm43h6jXYxYRCHQ7rDqUYIWG07eozKeBMF
X-Google-Smtp-Source: AGHT+IFLGP9H7iFV+bj+jHWnDq2iJNpSN/nrwRzRVEtzLP88yXNm+7536ikcL7yjLAmOK/Rv/6VgIA==
X-Received: by 2002:a05:6512:1111:b0:54e:86f3:5e65 with SMTP id 2adb3069b0e04-550d5fe945dmr253267e87.56.1747166506191;
        Tue, 13 May 2025 13:01:46 -0700 (PDT)
Received: from localhost.localdomain (static.25.185.216.95.clients.your-server.de. [95.216.185.25])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54fc645cecasm1994988e87.62.2025.05.13.13.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 13:01:45 -0700 (PDT)
From: Anton Moryakov <ant.v.moryakov@gmail.com>
To: netdev@vger.kernel.org
Cc: Anton Moryakov <ant.v.moryakov@gmail.com>
Subject: [PATCH] netlink: add NULL check for get_string() in features.c
Date: Tue, 13 May 2025 23:01:28 +0300
Message-ID: <20250513200128.522-1-ant.v.moryakov@gmail.com>
X-Mailer: git-send-email 2.48.1.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Report of the static analyzer:
Return value of a function 'get_string' is dereferenced at features.c:279
without checking for NULL, but it is usually checked for this function (6/7).

Correct explained:
Added NULL check for get_string() return value before passing to strcmp()
to prevent potential NULL pointer dereference. This matches the behavior
in other similar code paths where get_string() is used.

Triggers found by static analyzer Svace.

Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>

---
 netlink/features.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/netlink/features.c b/netlink/features.c
index 5711ff4..1a8c2f5 100644
--- a/netlink/features.c
+++ b/netlink/features.c
@@ -275,9 +275,11 @@ static int find_feature(const char *name,
 	const unsigned int count = get_count(feature_names);
 	unsigned int i;
 
-	for (i = 0; i < count; i++)
-		if (!strcmp(name, get_string(feature_names, i)))
+	for (i = 0; i < count; i++) {
+		const char *str = get_string(feature_names, i);
+		if (str && !strcmp(name, str))
 			return i;
+	}
 
 	return -1;
 }
-- 
2.30.2


