Return-Path: <netdev+bounces-73312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A649085BD7A
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 14:46:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF8E31C22EE6
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 13:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 149E16A33F;
	Tue, 20 Feb 2024 13:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWJ2m4Mp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB135B1E6
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 13:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708436767; cv=none; b=QivR26+33gfZqCIkrWcFpHESzvPvuxt4vS7Ff6ys4USmT9zqIkY91lQFxdj/f6iPWDvAgDBHUQ7mNRawrNfWd8lSnCsoWavuzIikvXqnL2mxZVvzsnkSPSkbLTu31HWdzFyqKgoMJ73q1yBv9hQhZJIhiX5EdS+M0wVQdwZcvIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708436767; c=relaxed/simple;
	bh=AqC7Ot45Eublqx3A7GH5Jd0J+jLFP1C3oZMyLv3sBmQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mji5hiL5xfenkfXDxmlxYI4Cpywb2WqCs/c4Tiw0Dz8SM23IgYZmbPxqgPWMp7zZ6j8QK6gF1CjrI9/ECtGh1gETejvMUtjgbkkCbFLfWUu4rZCLYZ+0Xj1RfVLIy4jCLV64l/ioLAJKLsmL28VSc2/7nOsfBMhVj+uVtPykmUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWJ2m4Mp; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2cd3aea2621so19208571fa.1
        for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 05:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708436763; x=1709041563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MPzy3BbidaYqsbIBdaP/2jyDi9J2f5cF7fHy1gqpCI4=;
        b=KWJ2m4Mp8H3s187GB/bmGpobby31Bu7t0RWa6cfJbrqyzPKNWzL7UD6BWwb5Yqhhp7
         jIemBuku9swcJ2ekxW2z1B2+S9VjGuqCkXxBE8uI0E9cvQpv+ZmC2wQJ8cBV1jbTmnXj
         P+655jgy6Wl7f3vh+0eigB1esymiUPcQn4qqT0yYOkwpWLVDui7MpBKFWMfQPo9sbQoE
         M74a0nDL6cHz/MERPwJDCk0XdOtdI38wRf+v/mywJYCaWvFxa4/hQ5aEfnFV1WcD9Piw
         WVp0uFyq7YoGupLpaU/wyTRQh/xdv14Yy7FqFJu5dBYDFu+OZa2A423Ut5MZ8hynjSC7
         RhpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708436763; x=1709041563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MPzy3BbidaYqsbIBdaP/2jyDi9J2f5cF7fHy1gqpCI4=;
        b=OtErsFxKT6QllpsuBr4wpKLIrX7EKVnI5M5TUbJJ6tODhwdbFbNVKB1kaiNaBjM6zc
         iprTQdNLAmqrzIJuGB7q+HyNL3vtvCJraIpE6wkfQm5SPktf/qJJunh1b4mRs8eA1/u6
         Ku20HkL7BW9fC12Adjph5Xo0ubpYd2hIUKvIui5sDrbFo6uO4+YrfzW9XKgKq10ceSX6
         PJBfvFtNiiFf80BMEX8ka4a+m0WAVT3egVxAsdjkmVAOYhMbCSSI7NvoeoSU3DxNRCsJ
         dGCujcLcEzMp9d5cP2Hvf8CF5832I7GhZ01SmDo4PBOIY20959GB4kHcIl9A6z/nO3Y/
         iwjw==
X-Gm-Message-State: AOJu0YxJhvxH1qod0pbqg8OX3ParHQXfCRq9ctOAOfHacrVwqU6QneR4
	yOs8X9eo1VdvDl4HJpdZFIoxI8Xu+Q+SWUiC6IWBVRCIWgd/W7xljPHlF6A1o+Dl+g==
X-Google-Smtp-Source: AGHT+IGcBbedINj+/3BDqLs7APnuR5iJPSdN+QV4qpxjkeoj4WM3yqIxvuWkFFQSrgbwD2ZQRTlcFg==
X-Received: by 2002:a2e:9b46:0:b0:2d2:507a:fc9c with SMTP id o6-20020a2e9b46000000b002d2507afc9cmr238883ljj.0.1708436763154;
        Tue, 20 Feb 2024 05:46:03 -0800 (PST)
Received: from localhost.localdomain ([83.217.200.104])
        by smtp.gmail.com with ESMTPSA id c10-20020a2e9d8a000000b002d0b33c1571sm1477530ljj.26.2024.02.20.05.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 05:46:02 -0800 (PST)
From: Denis Kirjanov <kirjanov@gmail.com>
X-Google-Original-From: Denis Kirjanov <dkirjanov@suse.de>
To: stephen@networkplumber.org
Cc: netdev@vger.kernel.org,
	Denis Kirjanov <dkirjanov@suse.de>
Subject: [PATCH iproute2] iptuntap: use TUNDEV macro
Date: Tue, 20 Feb 2024 08:45:44 -0500
Message-Id: <20240220134544.31119-1-dkirjanov@suse.de>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

the code already has a path to the tan/tap device

Signed-off-by: Denis Kirjanov <dkirjanov@suse.de>
---
 ip/iptuntap.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/ip/iptuntap.c b/ip/iptuntap.c
index dbb07580..b7018a6f 100644
--- a/ip/iptuntap.c
+++ b/ip/iptuntap.c
@@ -271,8 +271,7 @@ static void show_processes(const char *name)
 
 	fd_path = globbuf.gl_pathv;
 	while (*fd_path) {
-		const char *dev_net_tun = "/dev/net/tun";
-		const size_t linkbuf_len = strlen(dev_net_tun) + 2;
+		const size_t linkbuf_len = strlen(TUNDEV) + 2;
 		char linkbuf[linkbuf_len], *fdinfo;
 		int pid, fd;
 		FILE *f;
@@ -289,7 +288,7 @@ static void show_processes(const char *name)
 			goto next;
 		}
 		linkbuf[err] = '\0';
-		if (strcmp(dev_net_tun, linkbuf))
+		if (strcmp(TUNDEV, linkbuf))
 			goto next;
 
 		if (asprintf(&fdinfo, "/proc/%d/fdinfo/%d", pid, fd) < 0)
-- 
2.30.2


