Return-Path: <netdev+bounces-237713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13AA3C4F485
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 18:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D0DC3BE651
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 17:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA0D3A1CEB;
	Tue, 11 Nov 2025 17:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9gWrBzg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05CD3A79D7
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 17:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762882640; cv=none; b=aU0JQ0A3V+y7LqLDVF7dcxEMfVlwkIx8OzdAuKr10wBBlix4J6YpTmBY6VOAni/0fD4MTX2TnQ3iSzaPR86fD+v6120PqikgKRpkWANxxLUo5OnvyHBZKgHkYBAkNwkFwT8HXuw1Phu0TZXO4CI9bWM19sTWqFIVvrk84K6Etv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762882640; c=relaxed/simple;
	bh=v4utIXrGPO0sA7nXHFb3vZKgGk5MC1ei180wMa/JNNI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mIzmbXo5DM9TsZpRaquSJ3e9CmovudrACB5vW4edLxBTt9WdJCZfr/hj5yER8NXkOMMiWJ2n61sVpwl4dgJBWeyo7Bx7L5GIkEauDjTj0KpO4EmZP3lZ594VUdW6P9cQUiGxdzi/tAIvbxeruHJWYi4zHOtzg/iIOQ7RpF04Kow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R9gWrBzg; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b593def09e3so2784400a12.2
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 09:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762882638; x=1763487438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=92lvhA1uO0aM+xNDx/dzqlukLaPSJhYkX2A5buR2l8s=;
        b=R9gWrBzgsbRuIbwXLDkn/F4rnio3vDczk9qU92fX9u/rtnME2+aPyvtki878y59vgS
         SCz6ZBJORxnFbJuy81JRztV1nl8NTrZznzidZOB2Q5xaSoEMJR2xChv1X5TEuoEIkZfW
         /nlpzZ6/2UNOyW+DbycI4vOKlgkhnowZG6W3zVmEkqxqUTjoWOreK7Pvv9j5a4oyspBv
         GLKGiPcsxp5sdADY3mYEjdZD6LmR5pG/i3INREAo4LyWyJb8pq9Til+wdCtc9sYtgWf2
         OiKKgrG1AZ6at/IgPsOYaeNNIbOvE0iRXnohJXKy0E/xEbBzPzmJf9Hb7O9KUzXtz0Dr
         Dfew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762882638; x=1763487438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=92lvhA1uO0aM+xNDx/dzqlukLaPSJhYkX2A5buR2l8s=;
        b=gdRBej2vNMMu1WPbXBSNk3f0I2nKgiHPqom2c0YqjSjg15t5B+QgvJ9FU1rgoTdlYy
         MF+hW+kGbBQWGKBLZBssSlllWxVRxPkY1FWy/EsXmABq0XUMutW0KVHeixDZDmSf69o0
         sr6Pk7huQw5X/U//EF8KdOZBGjLISpUKJTOGkv+t4VloX0c9KvPLWtH5pOEOHlLscDEF
         /Kj0I9MtVqMuzuV5jCSFjcCZUQy/wLpbsxXUta9WEOYOOhQvMOINHVFRDEj+SABQsQN4
         g0SQovzIE+LitWDIjExxr1zlvHJYCuajOmwFe6YVYvrR4gI7nSKSGNRoPPBs3ISFpvKJ
         dYMA==
X-Forwarded-Encrypted: i=1; AJvYcCWvic7SnDNCGCmvafGf2X5dvnwyP/l4o+Q3uUNCzP45fm2JWVzBqeaarW4YmBa1KnVZqRkH2bw=@vger.kernel.org
X-Gm-Message-State: AOJu0YypbPvASAF5tIUtjsuMJqEa+brtdNDf5i8ya3StCI6fWs2kiM94
	4CHZA4M7FIbbkdqAn39EI76DrXyfIQVsZIZcRFBMFuwKrLYbal8kG99B
X-Gm-Gg: ASbGncvheFm1mTK/5wQT0ZHIxngDQIAfCtpBqvpfzcRTW281IUegrClB9TEc2Y/afbi
	AgUQMls722cgg3z97kSeBcpOcm17yIXj+Vm4M7f10+1EdzdFN5lcpWuypO5UzF40nfuZlfyyn9c
	cShQW4OZ5SrEdSS/maHu9r+QeauLeamoQhoCaFBAMwHo7LTrv8wB9umqD63v685/re3HoJx9Bud
	u3qC9DDmTDdo57AbNXsWhevfYLLpm60CdZ+dh68iZIm+tAZn6HekqyDzGdj0tLWYmYp9URiyRQN
	FZLTKV3+1SNvu4awTyrAMo4Rz6mjxGoCGVF0dGqOUd7ngQ1p2Qyt3CDm8reHdSqngUkmMh6iZMZ
	Uxv3FVuBRcO3+jAzjn6aIoiUTRB8iD6P4y117duPiGrrWNEzbwSLuW/vK7g3KBA70TyuuJqCAT0
	nIQNI/fu7qmdKRsuNGf9/Aeg==
X-Google-Smtp-Source: AGHT+IH2iWBeq3D6E9p+kun3mwKnF/bmIBXmiiPCVLGSR1deRp8cx5W3pTb+DFeUYrzkmVeK4pOdrA==
X-Received: by 2002:a17:902:e78d:b0:297:ef11:b504 with SMTP id d9443c01a7336-2984ed9ed53mr1427775ad.24.1762882637468;
        Tue, 11 Nov 2025 09:37:17 -0800 (PST)
Received: from ustb520lab-MS-7E07.. ([115.25.44.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2984dbf10c9sm3162625ad.38.2025.11.11.09.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 09:37:17 -0800 (PST)
From: Jiaming Zhang <r772577952@gmail.com>
To: kuba@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kory.maincent@bootlin.com,
	kuniyu@google.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	r772577952@gmail.com,
	sdf@fomichev.me,
	syzkaller@googlegroups.com,
	vladimir.oltean@nxp.com
Subject: [PATCH v4 1/1] net: core: prevent NULL deref in generic_hwtstamp_ioctl_lower()
Date: Wed, 12 Nov 2025 01:36:52 +0800
Message-Id: <20251111173652.749159-2-r772577952@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251111173652.749159-1-r772577952@gmail.com>
References: <20251103171557.3c5123cc@kernel.org>
 <20251111173652.749159-1-r772577952@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ethtool tsconfig Netlink path can trigger a null pointer
dereference. A call chain such as:

  tsconfig_prepare_data() ->
  dev_get_hwtstamp_phylib() ->
  vlan_hwtstamp_get() ->
  generic_hwtstamp_get_lower() ->
  generic_hwtstamp_ioctl_lower()

results in generic_hwtstamp_ioctl_lower() being called with
kernel_cfg->ifr as NULL.

The generic_hwtstamp_ioctl_lower() function does not expect a
NULL ifr and dereferences it, leading to a system crash.

Fix this by adding a NULL check for kernel_cfg->ifr in
generic_hwtstamp_ioctl_lower(). If ifr is NULL, return -EINVAL.

Fixes: 6e9e2eed4f39 ("net: ethtool: Add support for tsconfig command to get/set hwtstamp config")
Closes: https://lore.kernel.org/lkml/cd6a7056-fa6d-43f8-b78a-f5e811247ba8@linux.dev/T/#mf5df538e21753e3045de98f25aa18d948be07df3

Signed-off-by: Jiaming Zhang <r772577952@gmail.com>
---
 net/core/dev_ioctl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index ad54b12d4b4c..8bb71a10dba0 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -443,6 +443,9 @@ static int generic_hwtstamp_ioctl_lower(struct net_device *dev, int cmd,
 	struct ifreq ifrr;
 	int err;
 
+	if (!kernel_cfg->ifr)
+		return -EINVAL;
+
 	strscpy_pad(ifrr.ifr_name, dev->name, IFNAMSIZ);
 	ifrr.ifr_ifru = kernel_cfg->ifr->ifr_ifru;
 
-- 
2.34.1


