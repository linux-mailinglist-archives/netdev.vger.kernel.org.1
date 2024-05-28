Return-Path: <netdev+bounces-98763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 231448D25DA
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 22:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DF751C22541
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 20:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0703B13AA54;
	Tue, 28 May 2024 20:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Gp28QtPB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B8B1BDC8
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 20:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716928295; cv=none; b=fjqwcAq0/59xNRtZLvFq7LBv5tFw7G92N0wUYltrKiInIuKTQkW6FOBdmTKhPm8lsYYXbAxaeY9AztWVLEcxFnnRdUpzrJaqAp6i0ll0aaEAosbtLrwzrAQArBCbdXVpx4xBKtiToGUxmE85qrno/c1+ORWM6Jla8veBUEUI8WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716928295; c=relaxed/simple;
	bh=oblZ/JTQxlj5nkQ5Ex2QlXb1XgfBCE8NUSpuu3Lenlo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=f3u9b3IHvu5Fb5GYwGp4zAIIQg8b4kI1GXxmPqLWyVZPLSGidQXXn7PR+41JH0nibdrNXfF58RO4k3EqyWktROx+A3mRYl1QN6EWhHimj7Cr6FxRbcSZXtPL0GcAb7J/E22LfZZvZ4oV9sCL0upGlEsf25u4pCTwNu/5iAIkG4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Gp28QtPB; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4E5DD3FE4E
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 20:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1716928290;
	bh=IC8F1IBDMNj4lM1onkGOFqfxQKQc7xGwIx33j3RwCWg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
	b=Gp28QtPBWkvfTl96Eyim7F/XDROeg8khh77xeIrIr/JJe5uYxNMu083+CUti1nkpB
	 ba6cB8jtZJMHe2dS2lGNPfv420zctA5QUYR5Co6skpmn4+QaUOIK46M5QHSGW4IYir
	 HBs3IRrhEJ5oex4xsZrnpnXGQwfJyrYxerM5I2sH0Rdvh8tWM0K8H1hz146e6S1b28
	 +TYcJzVSH2EPOgXzETmT4VVj5UAhkgNAXfVa4MZJKP+0MGYM7Yt91G6h0s1KQ3Xm0l
	 bCRKTvJ4zVmLGfxnh5R4cCulMKkVT4Et1kzD/oObp6YZIkQ3JE76xWYZUbM7D6loFh
	 J8XZMIgwsK6rw==
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-420fe1575bbso9096435e9.2
        for <netdev@vger.kernel.org>; Tue, 28 May 2024 13:31:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716928290; x=1717533090;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IC8F1IBDMNj4lM1onkGOFqfxQKQc7xGwIx33j3RwCWg=;
        b=WTjYpsrVoctmXerrVJFeq81A0T9H1mO/acbPvdCimEvDHoHSQFvxI81mgimSGPfFRz
         D+txs0h68BYjaUwrWQORXWCfKmVTrczWwIQXc+ioNOSi9o9hgHm9iPjEh8Uo7eMbsoPC
         fbis4br/MjDbVxfi28I0stuMVJdJ44JGa+r6AFvVguGNC1BeBoQmk5cge4XwlERxyrDa
         zod9dLA2Zk5hVDwbdVsFGO4Hv+lU36SyxF0pdVkpQz+ipEZMb9kC8ZRjq4+MaVKXN15z
         ZTlKoy+cqHZKM6XShtbBVQpTn6zFRnQgpsB2dqmmMb7a6mlGcwQ8SZMzcf6/XYcUMTFD
         4Ciw==
X-Forwarded-Encrypted: i=1; AJvYcCU9fAhY1OXFt330ndtuATY1vCusqN7HZEPLoxAoF801RHs7R7AVpoJpY99yXMhV7z+Lw40Lr7UI5D+tuxG5SgUxd82LkJGe
X-Gm-Message-State: AOJu0YygiH5fmLpxBqMaFthxJOFvrr00DQGi8nrHBZpGwJ9xHRGf5FcN
	AP2IGg6IW3bVdsJD0a8dGXZdahtiDpBE+cHOTDpEYOHX4BOMxsr+XUEsZXuwNJapdciSPMWqEmY
	mhHs1SyI/fZh5Dx36GZuV8KuRa4NdnYv1/CD9H483UAA4NDV56S7JKHXItLZVqXG0Jv32CelZI2
	Tuug==
X-Received: by 2002:a5d:584d:0:b0:35b:6448:a540 with SMTP id ffacd0b85a97d-35b6448aa06mr2143199f8f.50.1716928289843;
        Tue, 28 May 2024 13:31:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyKEMlOnAEOn4VkWAIqpyfXQeqsB342zb3Gbu1S19iY7Y1uwm7u8SfWwlN1fOGq0t2YwHXlQ==
X-Received: by 2002:a5d:584d:0:b0:35b:6448:a540 with SMTP id ffacd0b85a97d-35b6448aa06mr2143177f8f.50.1716928289370;
        Tue, 28 May 2024 13:31:29 -0700 (PDT)
Received: from amikhalitsyn.lan ([2001:470:6d:781:68d:934c:3a6e:3fcd])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6331034f82sm142199966b.142.2024.05.28.13.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 May 2024 13:31:28 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: edumazet@google.com
Cc: kuba@kernel.org,
	dsahern@kernel.org,
	pabeni@redhat.com,
	stgraber@stgraber.org,
	brauner@kernel.org,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Subject: [PATCH net] ipv4: correctly iterate over the target netns in inet_dump_ifaddr()
Date: Tue, 28 May 2024 22:30:30 +0200
Message-Id: <20240528203030.10839-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A recent change to inet_dump_ifaddr had the function incorrectly iterate
over net rather than tgt_net, resulting in the data coming for the
incorrect network namespace.

Fixes: cdb2f80f1c10 ("inet: use xa_array iterator to implement inet_dump_ifaddr()")
Reported-by: Stéphane Graber <stgraber@stgraber.org>
Closes: https://github.com/lxc/incus/issues/892
Bisected-by: Stéphane Graber <stgraber@stgraber.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Tested-by: Stéphane Graber <stgraber@stgraber.org>
---
 net/ipv4/devinet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index e827da128c5f..f3892ee9dfb3 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -1903,7 +1903,7 @@ static int inet_dump_ifaddr(struct sk_buff *skb, struct netlink_callback *cb)
 
 	cb->seq = inet_base_seq(tgt_net);
 
-	for_each_netdev_dump(net, dev, ctx->ifindex) {
+	for_each_netdev_dump(tgt_net, dev, ctx->ifindex) {
 		in_dev = __in_dev_get_rcu(dev);
 		if (!in_dev)
 			continue;
-- 
2.34.1


