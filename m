Return-Path: <netdev+bounces-194338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A76AC8BF4
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 12:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27305189D80C
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 10:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5878223DF9;
	Fri, 30 May 2025 10:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="ZrN3PvFw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78283223324
	for <netdev@vger.kernel.org>; Fri, 30 May 2025 10:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748599990; cv=none; b=dl6JnfKI7yPZ0URyqrbXdzSGSg7J/qZWJ2iCaoLS+3gIgUuys2d/eX9VVAAYH90gJjhFR72h8HLqNUvsaXR4Adg0AGWft78Yqy1uSBrAGFW9DHbQktUhtntBmrZ9jBYqRKWt0q7DIONQXBwzfcHDf+l2+COgoKJTBMJvURuZT44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748599990; c=relaxed/simple;
	bh=Ox0MtGkzh3nh7CLtFL5qX0KHPLfrIGtHILG1V0i/ZZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pZGVA3vWWIrCV2qHpqVuYC06i05ZXKZC+5ITzw/AyvL5vQxQwwqjRhKjAPTtfO3B+NWj1UafxfjBMZJy7SOESSrX9FAhNER2GApzGAmYCAB810vgGpK4Mj7LK6tqdMsixJILQr8f2DobSaQ5bBA00pSAk7i9kki4yp/b75Nk7Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=ZrN3PvFw; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-442ea341570so12600925e9.1
        for <netdev@vger.kernel.org>; Fri, 30 May 2025 03:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1748599986; x=1749204786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XuVvTyh2APuGKpkLmwx6DA+/7wBgxkM/Jz4/PX6rhhQ=;
        b=ZrN3PvFwADKIe2gjnOGQbpqgBaIpFxCoeemNAxVBJTKcZhOXonf59c35wDDcDixvpm
         KiTbIunPifWXlh2qW6k0qh0le9oPBRL483Qhtp0KFyM3gbsk7o3kkGAuup6a7KKZCFXD
         oVuG7aT5T4mZIIrZLQ/PXJzZ0/Ha3tDi8V2JUDt4tQHlINFMhq/rGqx6KmrcTwLMAyy6
         IXXZ+ffQyLfHupKNS6dF1AYIO2OTw4nfgXdd1IXtVyS/U978naBs4ar0BE3vaBpdrkkV
         Z7+bGsZhlq5FFgHYPIYDCJpipskDKVaVQN7MbvOID2tnc+p61X2BSA+EvUjOEGSO4IzJ
         d+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748599986; x=1749204786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XuVvTyh2APuGKpkLmwx6DA+/7wBgxkM/Jz4/PX6rhhQ=;
        b=HcdPASoYCMSqejJwXOpo4jSeIlpIEJdPVZz+9gaKfx8miOsO15PLui+/3CdO4arCyD
         i9eoaLlqzgRx8D0PkNGEoE9X4kyuDKspfo8+w0zgSjduOXAe8K76G9QTnWkgf2jahSjp
         8pi/2cJxxNcnOUgwt1W/Yk/3aW0k6PAVwWxR5mVSgAz+DhvMIqLZMu6RmnWV7z/MxSHR
         39MsmrCwlW3KLJTA5Zu3+vGN5chL/08yIAW4K19rzlqjdi4T8Mh8aIDLEICvz7zJ+3/7
         Et76Jj5bV/MYOvrifn0zopQULvH5DoI49GKx5SJTLdYJ82XLjfI4K/rklWLqTnWMF/76
         R4Fw==
X-Gm-Message-State: AOJu0YzhzYiNnuTLBsS996grwpmN6stTqyEb1ZDK62T3nk3Fc9/hMiP0
	BvdscvS3ikkZZ4SydRzDA8CEXfNlavC8w+NWeU/s5vskWmaAsrb9Uw0K6+ineEEKsKZ1xAvbVvg
	VSdUcKAhLsvB5W1BB7eqsIdql/ktX56ds+0ehYc3eDGWpih0BwZs26MwCcKY/j9Tr
X-Gm-Gg: ASbGncuyZCH+zHIdpdWw+y1E/RGEVftTZALPTQom8bgQwwh3dstQB7vdpXNUHq8zdsU
	3rA3uMyEc2lk6RdwGHRtf3S+2ppt4eOjVGsRUFx9bGy3Qz5wTAkAMf73zG17R1u7Zeb+/fipk0p
	769aSc65t5sVLcNKQE3Ihw6NHMOU3t04roLgJaAWqG4wlx1xjOuveENMeq9xyCmJ5g5FN8aYmZ1
	65X9Q941jiM/Xp2l3GTqEzRLKj6j+yGie8YMTRtDOd3HvcqDZ4fdFMJu5in3etP+tKCC92JtQEC
	F2+lo9kqY/wumEClJ+Nedi9h0WAhkehPVMI1qfg+Bl8lijDYdw83Ppl0BgNqiWug4+JvC6B/Yg=
	=
X-Google-Smtp-Source: AGHT+IGmTQXg8kLGE7y8E+DBgx/+Hh7pL76UfHhJxpRtTVQTVIrhI/SVVD+J6FKUlQyIC6gqzH0Ndw==
X-Received: by 2002:a05:600c:1553:b0:442:f482:c42d with SMTP id 5b1f17b1804b1-450d884316fmr14742065e9.9.1748599986359;
        Fri, 30 May 2025 03:13:06 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:cdbd:204e:842c:3e7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe5b892sm4480956f8f.17.2025.05.30.03.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 03:13:05 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Antonio Quartulli <antonio@openvpn.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net 4/5] selftest/net/ovpn: fix TCP socket creation
Date: Fri, 30 May 2025 12:12:53 +0200
Message-ID: <20250530101254.24044-5-antonio@openvpn.net>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530101254.24044-1-antonio@openvpn.net>
References: <20250530101254.24044-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TCP sockets cannot be created with AF_UNSPEC, but
one among the supported family must be used.

Since commit 944f8b6abab6 ("selftest/net/ovpn: extend
coverage with more test cases") the default address
family for all tests was changed from AF_INET to AF_UNSPEC,
thus breaking all TCP cases.

Restore AF_INET as default address family for TCP listeners.

Fixes: 944f8b6abab6 ("selftest/net/ovpn: extend coverage with more test cases")
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 tools/testing/selftests/net/ovpn/ovpn-cli.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/net/ovpn/ovpn-cli.c b/tools/testing/selftests/net/ovpn/ovpn-cli.c
index de9c26f98b2e..9201f2905f2c 100644
--- a/tools/testing/selftests/net/ovpn/ovpn-cli.c
+++ b/tools/testing/selftests/net/ovpn/ovpn-cli.c
@@ -2166,6 +2166,7 @@ static int ovpn_parse_cmd_args(struct ovpn_ctx *ovpn, int argc, char *argv[])
 
 		ovpn->peers_file = argv[4];
 
+		ovpn->sa_family = AF_INET;
 		if (argc > 5 && !strcmp(argv[5], "ipv6"))
 			ovpn->sa_family = AF_INET6;
 		break;
-- 
2.49.0


