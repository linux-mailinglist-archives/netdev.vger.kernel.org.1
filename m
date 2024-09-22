Return-Path: <netdev+bounces-129172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3D2397E20D
	for <lists+netdev@lfdr.de>; Sun, 22 Sep 2024 16:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 995B01F210B8
	for <lists+netdev@lfdr.de>; Sun, 22 Sep 2024 14:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2D78F6A;
	Sun, 22 Sep 2024 14:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="iDrdjDzJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E6879DE
	for <netdev@vger.kernel.org>; Sun, 22 Sep 2024 14:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727016391; cv=none; b=VFoNMKL9CVaAjOsL42c+Zw/PgMSh8TiuF6/2EFElFSmLA7ThVCwe+luwLiNuaL6oYpH5IgvD1K887vu0G2DCNvpMiwAptwYUpGFP8WL/48PfuTIAwfKzhOGxyR0pmsQ4O49Hf2b7cWB/4U+uXa6CspPC5zd5uk7eMvgp0mnSuq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727016391; c=relaxed/simple;
	bh=obEzbUOat49mFiVOMQjV10vHS3lZgl54eTMgB/iiSJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gIDFWXJqhdaL9HQmfu35cs69EzbsTte/4sCFsVruHwrml9DEhWn0sVFFreUYoQAeAtw7WZ+OtQrNfHITr5Z6U+C0P0P8up23QHBmkxYz8Nvq8rbe7osjKkq3U4P2NTuZVIf6N+j0lasLwVPUaAtGDnDB1+WCoppZp3TOQH6scyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=iDrdjDzJ; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a8a897bd4f1so514064266b.3
        for <netdev@vger.kernel.org>; Sun, 22 Sep 2024 07:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1727016387; x=1727621187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YPYlfu2VkH5W38C/INzwLlNXJPhMZKljvgdLTCWrM5w=;
        b=iDrdjDzJcQbfO1X89TUes3ZHNFc5BroJyBH1TmzGoeEHLAi/9o+WwD/5XDg7892k4b
         XyNEG0rD1yBTvFyyI7We9ku5FtnPSu/mHko3uD/ktDmdrFhVR6b48WsEgNDmk/dK2V4K
         R8kcJVXSSDhx0kGeEw5OWyYn9URFzdtSHVUa8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727016387; x=1727621187;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YPYlfu2VkH5W38C/INzwLlNXJPhMZKljvgdLTCWrM5w=;
        b=NaLTSrovkq6LuLIKJt6pYaCjaVGrz2LbLIQJmSLoEoGMrvH2bHzfuj6029BAW5goF6
         InT4H0Lb3NgSuSiNNqYk518H/DX7g/Gg/sW+qXSuIkdX1B10UHo5I7c8XJG09JzGm365
         jSI/GK9c6mI+8EVrgrf3THTmYwj6V3S8aV3u8ngULx224VmC67Ed+Z+KX3nsZZ6Q0TlQ
         YCXQsSA35tL6HPjUh0TY4nnWNn1sZ/qPCRfca97esBBjwWWcaHjcBnoMd4JpLnGeGznY
         noKyLdHpbCb7NA8KW9NYOB/IttzB1lx0rqUZngHVHvnAGQiytRxNaThAWEYRED3hlLnt
         H6PA==
X-Gm-Message-State: AOJu0YxEuI7FpPbtEVPlFpZMyxPZegFqicM645wASaqSssKZyJ/3TcWo
	+qaFyGreDdfVSKW36C5GaO3XslkY3t3HFTtT+DFy2kCqezLT0SNRhrvJ6qML1pSJMPuI+VoDsKz
	IcBE=
X-Google-Smtp-Source: AGHT+IEnxESafGHoOiwViDWLw8kf94s5jDqhkR9zYncm95W+WwSacdWjXxiC/em6F17nYRW20pzHTg==
X-Received: by 2002:a17:907:3f19:b0:a86:43c0:4270 with SMTP id a640c23a62f3a-a90d4fbc6a1mr1015534366b.13.1727016387277;
        Sun, 22 Sep 2024 07:46:27 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-79-20-102-52.retail.telecomitalia.it. [79.20.102.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9061331694sm1088425766b.210.2024.09.22.07.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 07:46:26 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	linux-amarula@amarulasolutions.com,
	Dario Binacchi <dario.binacchi@amarulasolutions.com>
Subject: [iproute2, RESEND PATCH 1/2] arpd: use designated initializers for msghdr structure
Date: Sun, 22 Sep 2024 16:46:12 +0200
Message-ID: <20240922144613.2103760-1-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes the following error:

arpd.c:442:17: error: initialization of 'int' from 'void *' makes integer from pointer without a cast [-Wint-conversion]
  442 |                 NULL,   0,

raised by Buildroot autobuilder [1].

In the case in question, the analysis of socket.h [2] containing the
msghdr structure shows that it has been modified with the addition of
padding fields, which cause the compilation error. The use of designated
initializers allows the issue to be fixed.

struct msghdr {
	void *msg_name;
	socklen_t msg_namelen;
	struct iovec *msg_iov;
#if __LONG_MAX > 0x7fffffff && __BYTE_ORDER == __BIG_ENDIAN
	int __pad1;
#endif
	int msg_iovlen;
#if __LONG_MAX > 0x7fffffff && __BYTE_ORDER == __LITTLE_ENDIAN
	int __pad1;
#endif
	void *msg_control;
#if __LONG_MAX > 0x7fffffff && __BYTE_ORDER == __BIG_ENDIAN
	int __pad2;
#endif
	socklen_t msg_controllen;
#if __LONG_MAX > 0x7fffffff && __BYTE_ORDER == __LITTLE_ENDIAN
	int __pad2;
#endif
	int msg_flags;
};

[1] http://autobuild.buildroot.org/results/e4cdfa38ae9578992f1c0ff5c4edae3cc0836e3c/
[2] iproute2/host/mips64-buildroot-linux-musl/sysroot/usr/include/sys/socket.h

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---
 misc/arpd.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/misc/arpd.c b/misc/arpd.c
index e77ef53928a2..b4935c23eebb 100644
--- a/misc/arpd.c
+++ b/misc/arpd.c
@@ -437,10 +437,10 @@ static void get_kern_msg(void)
 	struct iovec iov;
 	char   buf[8192];
 	struct msghdr msg = {
-		(void *)&nladdr, sizeof(nladdr),
-		&iov,	1,
-		NULL,	0,
-		0
+		.msg_name = &nladdr, .msg_namelen = sizeof(nladdr),
+		.msg_iov = &iov, .msg_iovlen = 1,
+		.msg_control = (void *)NULL, .msg_controllen = 0,
+		.msg_flags = 0
 	};
 
 	iov.iov_base = buf;
-- 
2.43.0


