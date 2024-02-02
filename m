Return-Path: <netdev+bounces-68711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2375F847A44
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 21:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C655C1F21738
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 20:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08AF680609;
	Fri,  2 Feb 2024 20:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UE+7cVU+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9FA80625
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 20:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706904673; cv=none; b=WmOC1l40bBXLakFqjEBgsy8fgnQqX7fGRgKvIlatlg5yd7HYP1Kwj2s1TsntAbJxjKHwDQfc/pIUiCZSnhc+IaX6bWMmZ8wtpmAWP7kCDW6mJ/GSEBmL/EDw8ekX1godxiGGt/JQfzFSSdJAG0vUQo2GM13duWL5MTyNP+hhZGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706904673; c=relaxed/simple;
	bh=xfQBiC4CWpm9bgkyniqziqG9a2DoX6f9x3u91xx2qrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LlNU005R5CdMOBPx5ZpnTh0QAbkpy+YCpCtENzJlWK92RK9Wz/TG6K8Tl9e/AQ98Zi0LXdujr41Grd+hPbvSaEfKBAth+12ZD0+Eof2Mq+LCnOQSt9AWkxj0cOJaXGbxGapmqR6LU21+bfuA+3AugQkDMxR/WOxCdvq5zPP8LhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UE+7cVU+; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3be3daeff38so1364502b6e.2
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 12:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706904671; x=1707509471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A01EutfqCXvSkXVj18gRDXk4Kr8NN6OnFlcPAZicJZA=;
        b=UE+7cVU+NnzX9sXrJvZ2kUBWUmOQ1l6B7vcASqqwWp2v4l8lbNlVrCpqm2qJ0ZtZbe
         wVk2O4mZ9Gv6ELqYGgCEMi8yVJMaW8Xkvy0GRRB6jb2iqj2QZpVX5WjuprsO1jTWoDtw
         q7n/7JEeygHFkQY9mTQxOz8jGnuL51UY9m3cklzJxJrcy72JoSgP0hqKlq4RQVob+yk6
         AOi7UgDRjyHymGN1ol7hT68sDgkDJylPrcHeMhSbZxS2fI9fO5JgZ0i34two25PlqVJN
         qcYmpgA3X6lRCMQZxNZga9iksLLeuQLg0UG9NRVl6M14gA1p8ukvyzTwnJYNGGhdsNzc
         izHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706904671; x=1707509471;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A01EutfqCXvSkXVj18gRDXk4Kr8NN6OnFlcPAZicJZA=;
        b=dPrnu/3/XkliIVRtmQgNsCU1Ww4EYogyHOsvXFpQcfDo8CN39P4hdqvw/RsRTD3ysg
         vceGv52+w4jzfUUX3hi9GTfmxyxXgIvdHmbBHIY97kMCFs6rcmTRhX+7w7ZiYbCWD40L
         j41Tx/XWUYcofDOcUQkktufT+K6lmez0jnDMPyBW6cZPQuTUxkwNb64hjDXWO6CjGzP4
         P2R00sslv4zu5tfyxSJUlAhGwnxzT8PBCS+YJsW3XPxoIZ9TQBcp6tYTSPkR22mWCp33
         XAsSdCvmLrZiiuGu/sIRisp0AKpGpJjxbx+whl/QvX6O5fNyiNTZ/QZiI4JBceZJzIc7
         ai6A==
X-Gm-Message-State: AOJu0YwNVog5QOmaU9gRcSMoKLvi4r1w3kXv4SsC2NM06cVClCv65RTS
	Yt9sxc9aVhNVP4YjEGEVOUtfLT81esq7orYTmH6W26qQ6M2C57c2mpQVgdL/+j8=
X-Google-Smtp-Source: AGHT+IG1+On8i7zoEGPCckotY+tAt6RkBjsq98Nv9GxqxDeiCjqp9QIIfS8SLR7+AhYQuAlI2tPdkw==
X-Received: by 2002:a05:6808:1823:b0:3bf:c393:ed50 with SMTP id bh35-20020a056808182300b003bfc393ed50mr2216377oib.56.1706904671132;
        Fri, 02 Feb 2024 12:11:11 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXHzf5Q7iF+hiQG7Uy/aEb2AK9X77gyPiHTLt9XUpvs9L6T+2VI762h2eHHjSt2U+IOI9cekQJtmeN20vlVrX8YVTndsJz4NzHkEYZkvuPvHH95i3h0nx2P8cVUBmVhludMCp4fCf2BDDtjwQSAxIbDLORJTAXVeRPGEiCB67E7a5JY9GtlFfY+R7JXE5uiENFMHjxDOKuMZd3VB6Oe/zgIvg==
Received: from wsfd-netdev15.ntdv.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id i4-20020ae9ee04000000b00783f77b968fsm934780qkg.109.2024.02.02.12.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 12:11:10 -0800 (PST)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	tipc-discussion@lists.sourceforge.net
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jon Maloy <jmaloy@redhat.com>
Subject: [PATCH net-next] tipc: rename the module name diag to tipc_diag
Date: Fri,  2 Feb 2024 15:11:09 -0500
Message-Id: <d909edeef072da1810bd5869fdbbfe84411efdb2.1706904669.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is not appropriate for TIPC to use "diag" as its diag module name
while the other protocols are using "$(protoname)_diag" like tcp_diag,
udp_diag and sctp_diag etc.

So this patch is to rename diag.ko to tipc_diag.ko in tipc's Makefile.

Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 net/tipc/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/tipc/Makefile b/net/tipc/Makefile
index ee49a9f1dd4f..18e1636aa036 100644
--- a/net/tipc/Makefile
+++ b/net/tipc/Makefile
@@ -18,5 +18,5 @@ tipc-$(CONFIG_TIPC_MEDIA_IB)	+= ib_media.o
 tipc-$(CONFIG_SYSCTL)		+= sysctl.o
 tipc-$(CONFIG_TIPC_CRYPTO)	+= crypto.o
 
-
-obj-$(CONFIG_TIPC_DIAG)	+= diag.o
+obj-$(CONFIG_TIPC_DIAG)	+= tipc_diag.o
+tipc_diag-y	+= diag.o
-- 
2.39.1


