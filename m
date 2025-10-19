Return-Path: <netdev+bounces-230753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B40BBEEB50
	for <lists+netdev@lfdr.de>; Sun, 19 Oct 2025 20:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91191189702E
	for <lists+netdev@lfdr.de>; Sun, 19 Oct 2025 18:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F188A221545;
	Sun, 19 Oct 2025 18:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmZqZqar"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3B525A328
	for <netdev@vger.kernel.org>; Sun, 19 Oct 2025 18:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760898581; cv=none; b=r4DhQdCNA4JJiwswoUvrKVjR1z2rJgGw44bG+t8N0GDqJEM7+qMp3gPcYxGQgzVqJhu0MJ5PVBm3JdCIPLr8eJOR4ULc9mI6LkZ/7y+2lbi/V4NXfc17yUvrenfIxEvb/X3bVDFdY9ZzkEoQktbG9M8y+pJkIENs4bWdqM9siXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760898581; c=relaxed/simple;
	bh=59XmYm+EO88Dl2kDsRxEUIhQrtftD0EGVhi/zb8n6VI=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=Guq0tE78sOXI3uqEVMl0QCmqge10d+nH8XyJ/WFdxj0Y5snT+or9Vx/FY/qUrA2JPIBRHSIL6ZcbjNy3rA5pMztjVQHVPWHwdbfQFTGEvUSv2YP5ZAJlt82qVs+4lsWPisQxJBdBz4aN92B/k7MIZ3WMM4/uvSSCrmcFu5tHowk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WmZqZqar; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-781010ff051so2724989b3a.0
        for <netdev@vger.kernel.org>; Sun, 19 Oct 2025 11:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760898580; x=1761503380; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bAz1Xrjkzd6ULry6VIZLlce2IMxVc3+Yynj8Z/hkgEw=;
        b=WmZqZqar0t6luIx91JGUNnkSgkvwipbQucbAezyDMWymetCi2EdGZPx+wb828rzm1g
         O4M7mmfvJ7WV5CBKPUgYo1kldw7q4rR0ANr0Z8drNncc2UgziY6MsvZbspEG/8Wtok5L
         SgwBTet+VdLrx07bTsfzoxwgnWPSKdcE0v9nuEeD9hhi4OK6so0fUcoNpGQIuPDBsCep
         f9zub6gR4RdMpSlNFfgOAxDgcVFmlbVBwqcX2TsYEg1Ut9JPdBwhsh217eFSJNR1TCUu
         U0AA+wp1vq0oEtM2fHZP41bpwGZkHUaQLqsVZplLIJ7AlOY8VHhsz8vyF9y3xrz3QqKl
         2wEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760898580; x=1761503380;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bAz1Xrjkzd6ULry6VIZLlce2IMxVc3+Yynj8Z/hkgEw=;
        b=Zcqj1gyQ9YuyMldyoas8KVWsR3RDIeVQn5u45Np+JThOom8vzNnYNBJPc1wz9DF/kC
         2bbtbfUFX/o2LDmSDSwiY5lqa0i0aN+FXOrKPAYPqETnW6JNtYqMVOSWLnU2tyj8EUPb
         hM4TbjkA9OCia3/kYXyypFN28n5dl5Q0vkIgcKHP4XBlWh4fHA1BP1YtV4iEN2rrBUQ1
         yheuc4NRav5FZqHQ6Q2BbfUYilPfp+Zg++yY/zELYKePkukj1RMFXOUJYPjvlwrvxTy9
         Wp/AsZgTs2d+IBp+ZPzZ+5ls1T4YweQMoQQHRL7hq24DenJ1VXNK3wdV12qjpb6G06/N
         S+RQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcK0k9DX5ZNtCpEq3Xq4uIlDhytPSkOsuioDemP3DZYycoVALuzHV0fMqxP5jxAL1T5vlFys8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMFg1USDMYyqCe+G4rDLWLO7HH0ZoVGjSmg/3KDEVh2KBZ5Mjc
	BLsnX8bYLazRBM5dqq1UmVkasL49nCO6J86n8GOl8FySQ4Dag+mPKe/o
X-Gm-Gg: ASbGncu4Kxk2bMS6sH7uBdiqmSm5nbcDtx8YiRLV77XF01o11CnW1H8Ro0xZnTI/Gke
	3G1Q980yGxkxWFA86TOo5yP4BG87SnYvK1jL6C+nBrSn3UooOwkwO8ULIxemK1YXYGp6SrhK5bb
	zYgN7Upi5+8+Ld1aeo2Z5CrGd6nad4K3URSzHUmN7F78nCbJpv3pABAy26O0m807bN07zQSdkeB
	aM93ZXhJPv2a9E8aqtFtorDZRdHfGAB+H22W883FBMe+YmulbRtNW1iZ9FVh7sMlQ0ZRTTIgRr6
	VAChEmQJBuUgYmlnU3NnAKjAuEw1O18xKvxJ6iI0nUCJNYtp/FqEMu81uumm+rJCnrteyHjl5n8
	0Kinz00aqHt71x5tYGoGGeO3A6CR6hVLMi//r7QUgl8XeoKHmjwrJqiZ4tWBHnbELWP0yX6VTUK
	b4DdiaLA==
X-Google-Smtp-Source: AGHT+IHYBsBIyQhofVEIUqLK4ufZTXWodxz/p8RD+UfHYw+jNsprvNHmxEIT7mMHJPaXaI2v/Og3Pw==
X-Received: by 2002:a05:6a00:3cce:b0:781:be:277e with SMTP id d2e1a72fcca58-7a220a584c6mr12962221b3a.4.1760898579683;
        Sun, 19 Oct 2025 11:29:39 -0700 (PDT)
Received: from [192.168.1.13] ([110.226.181.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff15985sm6218413b3a.5.2025.10.19.11.29.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Oct 2025 11:29:39 -0700 (PDT)
Message-ID: <1b4aeb68-bf9a-40a1-ab86-a52ef91eb3a4@gmail.com>
Date: Sun, 19 Oct 2025 23:59:34 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com
Cc: davem@davemloft.net, edumazet@google.com, herbert@gondor.apana.org.au,
 horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, steffen.klassert@secunet.com,
 syzkaller-bugs@googlegroups.com
References: <68f1d9d6.050a0220.91a22.0419.GAE@google.com>
Subject: Re: [syzbot] [net?] kernel BUG in set_ipsecrequest
Content-Language: en-US
From: shaurya <ssranevjti@gmail.com>
In-Reply-To: <68f1d9d6.050a0220.91a22.0419.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

#syz test: 
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master


 From 123c5ac9ba261681b58a6217409c94722fde4249 Mon Sep 17 00:00:00 2001
From: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
Date: Sun, 19 Oct 2025 23:18:30 +0530
Subject: [PATCH] net: key: Validate address family in set_ipsecrequest()

syzbot reported a kernel BUG in set_ipsecrequest() due to an
skb_over_panic when processing XFRM_MSG_MIGRATE messages.

The root cause is that set_ipsecrequest() does not validate the
address family parameter before using it to calculate buffer sizes.
When an unsupported family value (such as 0) is passed,
pfkey_sockaddr_len() returns 0, leading to incorrect size calculations.

In pfkey_send_migrate(), the buffer size is calculated based on
pfkey_sockaddr_pair_size(), which uses pfkey_sockaddr_len(). When
family=0, this returns 0, so only sizeof(struct sadb_x_ipsecrequest)
(16 bytes) is allocated per entry. However, set_ipsecrequest() is
called multiple times in a loop (once for old_family, once for
new_family, for each migration bundle), repeatedly calling skb_put_zero()
with 16 bytes each time.

This causes the tail pointer to exceed the end pointer of the skb,
triggering skb_over_panic:
   tail: 0x188 (392 bytes)
   end:  0x180 (384 bytes)

Fix this by validating that pfkey_sockaddr_len() returns a non-zero
value before proceeding with buffer operations. This ensures proper
size calculations and prevents buffer overflow. Checking socklen
instead of just family==0 provides comprehensive validation for all
unsupported address families.

Reported-by: syzbot+be97dd4da14ae88b6ba4@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=be97dd4da14ae88b6ba4
Fixes: 08de61beab8a ("[PFKEYV2]: Extension for dynamic update of 
endpoint address(es)")

Signed-off-by: Shaurya Rane <ssrane_b23@ee.vjti.ac.in>
---
  net/key/af_key.c | 4 ++++
  1 file changed, 4 insertions(+)

diff --git a/net/key/af_key.c b/net/key/af_key.c
index 2ebde0352245..713344c594d4 100644
--- a/net/key/af_key.c
+++ b/net/key/af_key.c
@@ -3526,6 +3526,10 @@ static int set_ipsecrequest(struct sk_buff *skb,
      int socklen = pfkey_sockaddr_len(family);
      int size_req;

+    /* Reject invalid/unsupported address families */
+    if (!socklen)
+        return -EINVAL;
+
      size_req = sizeof(struct sadb_x_ipsecrequest) +
             pfkey_sockaddr_pair_size(family);

-- 
2.34.1



