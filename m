Return-Path: <netdev+bounces-205372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CB6AFE605
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 12:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBF5A1C419D1
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 10:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD2528C87E;
	Wed,  9 Jul 2025 10:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vm4MKNHp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE7125A328
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 10:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752057687; cv=none; b=ODPFcwOoM0zGqx0GnZDrXC/pZD6OtVLAb+5Z1NRqG40yqr/2GvvIHz/nME00RVX8XZx9oAPK/VGidnaXRKVOWHA71i09ZE7ok0lYs29bB/vZkmATtWtTGAH/OWUYF3Vq8ETNIHnWYz+dVc69JO6WakG7258W+ZETK2wkUVLcsb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752057687; c=relaxed/simple;
	bh=OCY+mClOeK7sM0Ol0HfXlFD8zhKNW2ZermGu9yYRbOk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=clOQdTovNjMiTo8pYtzrjW+b+mTpmZgR0WgKvhw+jXNHMxegnpq6MYrc0pqY2d3ee6OIpmzlA+kq17kaEPyOgeXkkTocdehEFxVhD3ZA/jGOyHZkcbi4qPlX2KIOsr7/pfEHVnRJGVLb/+vexacRnyWZWWy6DLsfYAxR/P+x4v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vm4MKNHp; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-553d52cb80dso798790e87.1
        for <netdev@vger.kernel.org>; Wed, 09 Jul 2025 03:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752057683; x=1752662483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jXOXZf5Gh2EJLgHqRNDMSChjUo6sp6JqqE5u4Jpt24E=;
        b=Vm4MKNHpmGN3IBzo4v5HZDHTC6tG4fdHohEs1bOgZ6IbQBB1pJa0++Fbffw3i/zH9k
         Dz90zWJSg5/ivnKDBc6FgZafMLbe3Pci+esma29KMnWDKV2mmWwFnp2f5OjeuzLZjcCq
         fL5um2qKv4Lw6I4Gs4Jr5WZPRuVs6Se39ZjEx1Ut6T6V8zz3d6U0q35y/Dc7ZuGxYxdV
         D8dJ5iKbMbX0LUvvTKwLPGW0MkcDOA7LV6x1gsCwgu9vN1DdqKraFQrycoRKsY5r9AUT
         dsZG8Mg9+Gm4//AC2uHpdl7M5TegUGdylUvyUSmhzxU/fp97OEKergJjNQiCJ1zA6GGt
         RRpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752057683; x=1752662483;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jXOXZf5Gh2EJLgHqRNDMSChjUo6sp6JqqE5u4Jpt24E=;
        b=f/LhWQPdaaKlpji6/BkLwmHm1DgLn2118/LC17Ncj3PErRz3J/hcI3AuCJQQwqIJvs
         oyCYyR786dTb0iKjtRnDR6JDcsVks/2zeM5mK9V5hWYp+L619AzjoDjs0u2wgfps+enJ
         cr7MAK3O2GhN9am49zOtUYuuk/qVLlcAx2R67/v665m7ggKAfSdSl/W5Cvi9jPI5WDOC
         D7TvBlRNPazswC9j7gTMGSTeyAAJR0lru9NmPj8RLIy93DwMiAMbgPXrAL/73tnN4791
         UcTWzLPcaBkKRu4TRTCMTkNHWXXFA4oBUyWsqRTE0/RLlT6tiTak54MHJ5tJHWnhA2cc
         Vxqw==
X-Gm-Message-State: AOJu0Yy6zcvLSdfcvwPGPFoPgqdzBXKjROXmTds0Xnq8oNkr84guqnYR
	Oia7ChPXiOYvMlL2dBOTHS5rnZKKxZyGladVn5YtZa2uSYFqkS9EF9ao
X-Gm-Gg: ASbGncsqRIpzStAc+ZjkidtQsjr556Cc/7edK9dhRBARZKHR5w6Q9ASY2MMmaPZ9Ndb
	InQmW4bT2hmTzVR8DGth3oDEVtH+ffxv3bdSlX8pA2Z4gEB1+ZFSZcn3dWCnwqbG49ID6nZh7gn
	jtj+3ntjOIZnv2tALoBKHrdZmDayAVwLPsQYeanfSQvs2L4GttG5OEzALonlsskDoZCcIPXCZ0D
	DVFh1mYsiC97QsJZZP6UGC0HcZ0Pub33YlX5ZxXEUWah7le0/rMsghZdXIG7IHEvneB1igI5irq
	6fMUDRian77VW2Ei1ZCOXyic6a0IRAIhKo6Ap/Trc+FGyZOuN+l0xyaHQY8YyP5DgKiq4xlv9G0
	PcXiLMbis6zbxPYGNaT+VwZQCF5KgzOPoQSqiavd7tPREBXQ=
X-Google-Smtp-Source: AGHT+IGGGyHHqaBocgr7VNSt3LLW+9SNd1kLjq6UZ4uuH2SVbC+S6+ctihLPeP6hi9Xe7FFyELEpog==
X-Received: by 2002:a05:6512:108e:b0:553:268e:5011 with SMTP id 2adb3069b0e04-557f8a6850bmr2011211e87.26.1752057683355;
        Wed, 09 Jul 2025 03:41:23 -0700 (PDT)
Received: from lnb0tqzjk.rasu.local (109-252-120-31.nat.spd-mgts.ru. [109.252.120.31])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-556383d906asm1947898e87.81.2025.07.09.03.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 03:41:22 -0700 (PDT)
From: Anton Moryakov <ant.v.moryakov@gmail.com>
To: mkubecek@suse.cz
Cc: netdev@vger.kernel.org,
	Anton Moryakov <ant.v.moryakov@gmail.com>
Subject: [PATCH] ethtool: fix potential NULL pointer dereference in find_option
Date: Wed,  9 Jul 2025 13:41:20 +0300
Message-Id: <20250709104120.74112-1-ant.v.moryakov@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Static analyzer reported a possible NULL pointer dereference:

- In main(), 'argp' is dereferenced and passed to find_option()
	without checking if *argp is NULL.
	
- The function find_option() does not validate its input argument,
	which may lead to undefined behavior when using strncmp() or strcspn()
	with a NULL pointer.

This patch adds proper NULL check in find_option() to prevent invalid memory access.
Additionally, it improves robustness by making sure that the input argument
is valid before passing it to find_option().

Found by Svace static analysis tool.

Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>
---
 ethtool.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/ethtool.c b/ethtool.c
index 0513a1a..4250add 100644
--- a/ethtool.c
+++ b/ethtool.c
@@ -6395,6 +6395,9 @@ static int show_usage(struct cmd_context *ctx __maybe_unused)
 
 static int find_option(char *arg)
 {
+	if(!arg)
+		return -1;
+		
 	const char *opt;
 	size_t len;
 	int k;
-- 
2.39.2


