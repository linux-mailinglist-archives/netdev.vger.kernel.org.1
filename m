Return-Path: <netdev+bounces-222670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 069B3B55553
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 19:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD73C5C59A3
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 17:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 599B132252C;
	Fri, 12 Sep 2025 17:06:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B859630DED0
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 17:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757696775; cv=none; b=E87DzHAuLL6mDdWLhZWTKSzClO0dxx14aal2wrjFZPsqSFgYsejNXdgDGtQ84fDvrfR7vZlsaKCfxfrUr+p2/S/gH03LKjjdG3e0bZkyFBp6KKr2c1Q/IGRxENflI4sYXbQku+0htoe/eAtr3QtKYLRhX/gwZEEEYH7Y3Tv2rJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757696775; c=relaxed/simple;
	bh=z7ODM4yeGOyCrC47UrkJKlQNImokfG0fkhm+U4ThvNw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nulqfX6DOqHGBKniE+x3pLiEHeDRblN6OedpAKjQbKpLEQonbSAyFHBPx28K7NabQ68+jUErTN4oOk0kYpLEgvNTjiU8qpj9RnLTHLuCQdn9xcOQgLCYMju/gzE1OTRseFXbE8myKupeUQGuLqGxfmv+ap8sQ4Aq3V8Qm3Cdu3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7725de6b57dso2813943b3a.0
        for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 10:06:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757696773; x=1758301573;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xdln6TPyaoot6c1arftNTKI7b3e4E+Fw50+XLxdpB00=;
        b=WSNDI5bRO+5HtBsIVTOAtHa+/9mEZ12XezSMD8jQailexL73F93TNJHkoUKtliEHds
         wL+MoyBuE95AkzzXrlBR5WrC9KUVNvgxgtFflfQKiiCSVL+ZMvyhCjhlyGf0HDQiF/jp
         NKv1l3qTDA4SjVBQKKkpK7MlGzVyvImVDMJbXoMq7a3Q/ynanjmyVZTZrakfUP4MyDa5
         uYbIFuhsyYtLjEEd34DDPlzJmJkr8+TsQNrI/Bw4mcT8563ASnS+gyqOJxRFSkwWHpM1
         7Fh2QBP1g+pZid53ZtToU7H8mfQnTGo6G9uBEdNITscM0+EKtNvB4dsVgfwx839hdXkc
         7QOQ==
X-Gm-Message-State: AOJu0YwwKk6PqZq47REVA1ksOMNDemUQ/pswUFXoPiTWKSIg0meSFdpO
	gcz5hiFb26tCs5B+PpcCVEEafWW6M4HH4E7Kc4CVoMzC7Gjy+vVtUAW8RgQK
X-Gm-Gg: ASbGncvnMHt0ANUGWQTyJvYwoyC1isThpKim7SZnP87lxUswDHEk5K3gt8YX8QDMwyj
	yBYEVKzAcAO15O7f1PHu1MiNe/jRrorZy+1ZuQxxvVIcN+xL72DeZPv5gtUrTOjQCjkdJLKzbFA
	Jv1HZkprsb/ReANWbhZGCUyiODd/q+rtHMHpHN12NXbYoKG2LF8z6DjkEco8Bo3F+HZHFegLtl5
	T7nF8jTN2QTMxTa+3eTPrytvCfFvtKAmylcE1pQQY7D4v+oYmSpQAFeVRGWh37vDMDVrLyKVy08
	aEPWc2Q5+wqVMdZa3IHT08SFDME/THp0zi8AnyHsT3DeA/HoZbPZgmzLkibYns/yF00Txwcic+5
	BBPfW36EHMX+T3hUxM1OrXzxSEMyZbqqvAqevyRQPxtfD0l+QG+wFTmZj4Smj4sezNAIDEsjtOK
	n+AWBRjdV2rfsj5OsexaFmQGXzE37RaFnsSanvAYofppZ1FmXriXI3zpT5YN4tM9sCBXKxQ6YKx
	L7o
X-Google-Smtp-Source: AGHT+IGOdtov7MDgtAPJBxTWxT0eZs+wkblLgU6EWiyMAEUP1MXy6U8WZVCMX7DmcSMX0j7bBG/d6w==
X-Received: by 2002:a05:6a20:734a:b0:246:7032:2c1d with SMTP id adf61e73a8af0-2602a79259dmr4527604637.23.1757696772766;
        Fri, 12 Sep 2025 10:06:12 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b54a387cc21sm5204677a12.28.2025.09.12.10.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 10:06:12 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	shuah@kernel.org,
	sdf@fomichev.me,
	almasrymina@google.com,
	joe@dama.to,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] selftests: ncdevmem: remove sleep on rx
Date: Fri, 12 Sep 2025 10:06:11 -0700
Message-ID: <20250912170611.676110-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RX devmem sometimes fails on NIPA:

https://netdev-3.bots.linux.dev/vmksft-fbnic-qemu-dbg/results/294402/7-devmem-py/

Both RSS and flow steering are properly installed, but the wait_port_listen
fails. Try to remove sleep(1) to see if the cause of the failure is
spending too much time during RX setup. I don't see a good reason to
have sleep in the first place. If there needs to be a delay between
installing the rules and receiving the traffic, let's add it to the
callers (devmem.py) instead.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 tools/testing/selftests/drivers/net/hw/ncdevmem.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/ncdevmem.c b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
index c0a22938bed2..3288ed04ce08 100644
--- a/tools/testing/selftests/drivers/net/hw/ncdevmem.c
+++ b/tools/testing/selftests/drivers/net/hw/ncdevmem.c
@@ -872,8 +872,6 @@ static int do_server(struct memory_buffer *mem)
 		goto err_reset_rss;
 	}
 
-	sleep(1);
-
 	if (bind_rx_queue(ifindex, mem->fd, create_queues(), num_queues, &ys)) {
 		pr_err("Failed to bind");
 		goto err_reset_flow_steering;
-- 
2.51.0


