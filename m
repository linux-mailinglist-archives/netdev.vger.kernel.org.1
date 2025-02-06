Return-Path: <netdev+bounces-163544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4E3A2AA8C
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 15:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A68E1168997
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 14:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538491C6FF9;
	Thu,  6 Feb 2025 14:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJJBn73S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B491EA7C6
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 14:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738850417; cv=none; b=diru7cSjL41wrNZUKkvObuvOq75P0G03hRrPAf76aN+0xhnjnGN8oPinSu81aQMTGg05gEgSCh2owN9LqPp58vlNS+Dp9MSqYHI3yZ/tb2OIY34SKWZf1CGy80PpAhX6B2RdDWCAJ/3FMTPzX7FEr+Tk0KYsjGcW8ShdLZe1DWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738850417; c=relaxed/simple;
	bh=gAxWg2UWifQ+J6EkdYoUSqScq5LdOTjGP65gBBk+lYk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d8gLywsYTdoGk9JdWPU5mwdFi+2U3EYrMvdqjXb5xQyDpFDRQn6I+blc6HTXk1m5e6wW/oWa0nbseRf15iCE3qCT9HHaP2Kn4mYhj36ieF6B5oKirHXf5E8NTm3z5VC4J/N4YACX+4M6T+QhL5aa4u9T5ju5PtbDtQk+6prqIZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HJJBn73S; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3eb8bdcac2eso217793b6e.0
        for <netdev@vger.kernel.org>; Thu, 06 Feb 2025 06:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738850414; x=1739455214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I4w0+tZZ/6tjdHWcFaodnjfcbvDy/U7bI66jPRKovo0=;
        b=HJJBn73S1oHy2YQnfIBU5Wch5tDC/PhOVN3UgM/ARHZpknXyLlZky0JCFZL9N9hNUG
         bNrOgmmz30+PCmq0v6rHTsTXfx3L+DBl4Qg9pOhwNq02CzgyHSQtJJujU6qCZYskAhOf
         PGXhf7ao7Osg/71wDF0MU4jj42q+kijHjyhIz6tN34XF8bKdWlZtXD0bKGQHbotlH0aG
         fwcu+1cGnC2ODchdVfooXsGiFY0ai/VFJbOyb6Id9drB8Ttwd+Rg0OiUCD2qx/Zzwq6D
         tBXVIGrhtVD8b0NoBJIk5zj0mIRPj+t7M7fxWTX8DpfVtgeKZ5fbPeuTicvwOMlVkz3T
         gBRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738850414; x=1739455214;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I4w0+tZZ/6tjdHWcFaodnjfcbvDy/U7bI66jPRKovo0=;
        b=gYgbRxhb3EuXRrqc1n0h5REAIpR7L7Z1JHt9v46qOMs76v4kBBaOJ6mDJ3ZolABbHd
         6/SmAxhoQ6qd2eofGRDgPtuK4FTMvidXBKd0HK4ZFJwuN1aak06cuFTxrlDz1YvmfN7d
         1c4nhrxNYyB4lZvI5SDjX35pldEGJvQuMKuqd/RYDu0UXIxm83dXv5612V24MdBJ+ZG6
         xfz1xil44kBgc+aFvCe7iJDrNh8p1iKds4XuXVfmImNCkeg3trLqbVp3xRl50U7kwDnl
         rR+EHISL3BQX7gyJ4YsssTBktwrmoSyOltaHVecWz/4ayjp931iM0Wv8OYacGWbLyKkX
         cq2g==
X-Gm-Message-State: AOJu0YyhuU6m5GlGQCF+5/bB1byg0v69AIG+B8MWc5kCWyF9YlhP6Xjn
	nqwvpyFx3neAOJWuAP34Rnxx5M7eSi3Jh+hSrwZyMB1vDrGA7e5TJ6tdH40=
X-Gm-Gg: ASbGncuzDucLO5/caHHK+M+aCM4GqxCRtFwtaRRWCpClWdbpp77nRYRvzkD4/nrWvdm
	yQYlYg/8lm13z8naaERdM4zkZDnAg9zRnE6SYbXkh2ScU/Ov+AZLUAzhblvZb9FL3TGlbZvZ8QX
	coqgJYApFlc8y/9C4ItUwPag125oPoo5cpJNRajU2rlonMJ65ZR9tBaiwN9XC56lfamqDAK2GxU
	+lH0I9WtVLzFTI3q/bV8giRFQ/Dg6dSyqKjUnhuVxP9Z7ugUf+OSuI+c+ffw/H2qxt09PfqhyNy
	yaWmTisfqfJsAMk=
X-Google-Smtp-Source: AGHT+IEq59hXVWRso7radTvNDDnWDabptYUgRcCTQoG3L8zBVZD5f8o9r7uZ45mAuN0D3gHnHW8wWg==
X-Received: by 2002:a05:6808:2205:b0:3eb:5160:f859 with SMTP id 5614622812f47-3f37c10a7fbmr4486914b6e.9.1738850413694;
        Thu, 06 Feb 2025 06:00:13 -0800 (PST)
Received: from t-dallas.. ([2001:19f0:6401:18f2:5400:4ff:fe20:62f])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3f389efeb49sm208150b6e.29.2025.02.06.06.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 06:00:13 -0800 (PST)
From: Ted Chen <znscnchen@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch
Cc: netdev@vger.kernel.org,
	Ted Chen <znscnchen@gmail.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@idosch.org>
Subject: [PATCH net-next v2] vxlan: Remove unnecessary comments for vxlan_rcv() and vxlan_err_lookup()
Date: Thu,  6 Feb 2025 22:00:02 +0800
Message-Id: <20250206140002.116178-1-znscnchen@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the two unnecessary comments around vxlan_rcv() and
vxlan_err_lookup(), which indicate that the callers are from
net/ipv{4,6}/udp.c. These callers are trivial to find. Additionally, the
comment for vxlan_rcv() missed that the caller could also be from
net/ipv6/udp.c.

Suggested-by: Nikolay Aleksandrov <razor@blackwall.org>
Suggested-by: Ido Schimmel <idosch@idosch.org>
Signed-off-by: Ted Chen <znscnchen@gmail.com>
---
v2: removed the comments for vxlan_rcv() and vxlan_err_lookup().
    (Nikolay, Ido)
v1: https://lore.kernel.org/all/20250205114448.113966-1-znscnchen@gmail.com
---
 drivers/net/vxlan/vxlan_core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index ece5415f9013..44eba7aa831a 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1670,7 +1670,6 @@ static bool vxlan_ecn_decapsulate(struct vxlan_sock *vs, void *oiph,
 	return err <= 1;
 }
 
-/* Callback from net/ipv4/udp.c to receive packets */
 static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 {
 	struct vxlan_vni_node *vninode = NULL;
@@ -1840,7 +1839,6 @@ static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
 	return 0;
 }
 
-/* Callback from net/ipv{4,6}/udp.c to check that we have a VNI for errors */
 static int vxlan_err_lookup(struct sock *sk, struct sk_buff *skb)
 {
 	struct vxlan_dev *vxlan;
-- 
2.39.2


