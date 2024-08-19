Return-Path: <netdev+bounces-119668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E689568A8
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 12:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5BF2281D66
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 10:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A0D166F25;
	Mon, 19 Aug 2024 10:36:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE0D166319;
	Mon, 19 Aug 2024 10:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724063792; cv=none; b=cQntWShp1h5hB8gmoG2phXfZosT0/x/dorno9MqIwHtO+qgRhIpFsj836D3/ahHHgTkv1hFYToXHueM5NOBIsJF0C9wpihZEi5siSyIEttcqAXuVioaeMKgm/hhbpPwIBh1c/g1Jp5DTxg6DgKgeyoBC744P36MqmXZppU1bQhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724063792; c=relaxed/simple;
	bh=a0DMxjOBbIohYb8yry8S/n6xsU6jjYj/1klmCXsujHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B0UWD5O5vJwYKSfwqe/rixLy94o/RcUY21HYX/DOZ1EzQDRIDuZi1Uv5m97IYE6bemrojznVgirKnmN45YVNKgr0f0CLdUh1yGQXYm/5gTgGy7iRaZNke3UEOAssdZj4zfRYv0Zs+bUbBaxpM36b+RmOHHMMcw1NuddA/cUX7TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5bede548f7cso2081262a12.2;
        Mon, 19 Aug 2024 03:36:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724063789; x=1724668589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/N3nLYiRl3O+3xUt0qjFdrnSkVzdT60L+daHaHWtAnQ=;
        b=J0Ijzcy9JleC7D7smKrhd2I8DcUR+2neOAoYyE10eym049Dto4ssvzOfd1yWoBgISZ
         OXRV6Y6xF1DDQMEAmAiCeHBwTiBjswOH2cGs8oQbKV4ApwF+uOaWkhQp/k+uRBNlGH/i
         gHdrCcb5OsyOtulS59s1U7OAw+MSOFnthURBOwlCsJ9pCN47z34yL3X4pRcNzjL0jk9u
         9qTQvW47QINfncBAF7UJhIhQ8FNq0OkHGjZvvAx2HHlAtB6uifLrsm0rChRIaykhjK3E
         9ryxy35KovG1vs5kuRdEf75zZSspVTeI/IHWfTHwUMe4sUY0VfYk2bSbhk40XGl5oelS
         0ytg==
X-Forwarded-Encrypted: i=1; AJvYcCVv+jVwlWZXGGC7NLJuzXBPEduonekLytziHqmi6xp7kg7PAHkkaGZo+Hxq6bukGtXVOsCk+9XEYAB7bUyrMgV6OGWKt27LF7KnVg0a
X-Gm-Message-State: AOJu0YydzVs0TXuVa2c8wWJgrReJApt06K7fkkRkYU6IOhEwInWES0LC
	FIbkwGgNXWZOR040KEfNhZaX4/Hg3/RupxuZGlmyL8Dv1U+V9jwl
X-Google-Smtp-Source: AGHT+IEiUcH5ZQHQN6dd6XzNMscnMgyFP0f80fZhVkcwbTHHWtvnQQlXPSifAn8djpq4AdNBxWxdFA==
X-Received: by 2002:a05:6402:2812:b0:5be:e668:9cbd with SMTP id 4fb4d7f45d1cf-5bee6689dd1mr3919062a12.3.1724063788896;
        Mon, 19 Aug 2024 03:36:28 -0700 (PDT)
Received: from localhost (fwdproxy-lla-010.fbsv.net. [2a03:2880:30ff:a::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bebbe7f3f6sm5433253a12.66.2024.08.19.03.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 03:36:28 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aijay Adams <aijay@meta.com>
Subject: [PATCH net-next v2 3/3] netconsole: Populate dynamic entry even if netpoll fails
Date: Mon, 19 Aug 2024 03:36:13 -0700
Message-ID: <20240819103616.2260006-4-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240819103616.2260006-1-leitao@debian.org>
References: <20240819103616.2260006-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, netconsole discards targets that fail during initialization,
causing two issues:

1) Inconsistency between target list and configfs entries
  * user pass cmdline0, cmdline1. If cmdline0 fails, then cmdline1
    becomes cmdline0 in configfs.

2) Inability to manage failed targets from userspace
  * If user pass a target that fails with netpoll (interface not loaded at
    netcons initialization time, such as interface is a module), then
    the target will not exist in the configfs, so, user cannot re-enable
    or modify it from userspace.

Failed targets are now added to the target list and configfs, but
remain disabled until manually enabled or reconfigured. This change does
not change the behaviour if CONFIG_NETCONSOLE_DYNAMIC is not set.

CC: Aijay Adams <aijay@meta.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 9b5f605fe87a..82e178b34e4b 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1260,11 +1260,18 @@ static struct netconsole_target *alloc_param_target(char *target_config,
 		goto fail;
 
 	err = netpoll_setup(&nt->np);
-	if (err)
-		goto fail;
+	if (!err) {
+		nt->enabled = true;
+	} else {
+		pr_err("Not enabling netconsole. Netpoll setup failed\n");
+		if (!IS_ENABLED(CONFIG_NETCONSOLE_DYNAMIC))
+			/* only fail if dynamic reconfiguration is set,
+			 * otherwise, keep the target in the list, but disabled.
+			 */
+			goto fail;
+	}
 
 	populate_configfs_item(nt, cmdline_count);
-	nt->enabled = true;
 
 	return nt;
 
-- 
2.43.5


