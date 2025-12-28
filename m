Return-Path: <netdev+bounces-246159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E7656CE036D
	for <lists+netdev@lfdr.de>; Sun, 28 Dec 2025 01:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C931301D0C2
	for <lists+netdev@lfdr.de>; Sun, 28 Dec 2025 00:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2DF70810;
	Sun, 28 Dec 2025 00:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ft5j3A7b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB8311713
	for <netdev@vger.kernel.org>; Sun, 28 Dec 2025 00:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766881360; cv=none; b=OkFlfDDxsL2DYgtkZ1DX6fUvS/OzvTfDDm8RQX+FaY3JvEh/ZBPd6jKpOw7qwGK5KTe1IC3pDUX3pjJELYiEFgYHfxkeH7pEhGZkZFa/uY+7ertMTsP++RrcwX21rLJSQshKOU7OdHdjye8437lntuqFNu9DxEtYHtngMXgp9WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766881360; c=relaxed/simple;
	bh=jpq9wHpx7bbbe0M/sN16gJU+/hyNHN2RoIoLmwCkVWs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Q7tnxfdKy8jOEltQsdwxBrn3AcsL/uBaiFmjwEOHbF/02tKcpRjG16+hgisjplzhEM+bCvnP1imDuxcn7wVRYUaPVhlK7qBs5LM4WaW7cmLsUben9/Ew2MEnvUeoFkyfzSzY2pLB++s1g3DeLX+313VU16Eeg358EJE1LroJidE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ft5j3A7b; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a0c09bb78cso59485495ad.0
        for <netdev@vger.kernel.org>; Sat, 27 Dec 2025 16:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766881358; x=1767486158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=haWapWv1wXexP50q4CCHapERJCCyXb7DbT6L6pxNCAU=;
        b=ft5j3A7bomz6tpbFHHCwo1z1zp7qkSyye/hIi71dNVx2SRATa0bVQgyDQ64jPjsowE
         FKak+6iHuNyvjWSrXe7fPh5om84n83UN429QcdLVRrdqtrK/ZrVjcb0Xl7VhT4CkwrIZ
         KGpHmzdfGVQxdzVF2X4klDS14A4Cztlvfod28MoNZhNpkxUW98cSfhC6IUjzt2pZdmT6
         J8I93C+zS/weacqfHcP3ECFlYTcxraLUlxd6B2wh32M4rxT+jFiKKw7+9EbbmiUff1yR
         MSHDa8Re7AncYxnFeySuWAXHSv2i2WjMUkL6RbU6WATtMrT/AQk6/7tA6TIiZzqMcWYp
         IvcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766881358; x=1767486158;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=haWapWv1wXexP50q4CCHapERJCCyXb7DbT6L6pxNCAU=;
        b=SVxOGFB1CepvayEG3YDlEQAwlpznd5sccRAtaCLkd3XkGebm1GZpYq+oOE8GBpanUJ
         mBIVmzyVw9mDL5hI7qa9+urlu9i8snu9+Pudmm5PG521/Hi8Ixwk8Or28VKuZ8vSukZa
         nkYbb3JW8sKcEPXE9rhuqRp4YzICvtoEVwyRrmBh8LPoYBOnze9cA6BsQDu2nNSlIyaJ
         jTrnnkPFwN3HDADNCMsvTa8GcSAhCyWl7UIljnIlQGIM5Tb5oJN/xm7vlG0os7FwGjDe
         HjmqgH5o6HKgQtiIDD6cWYWNtx2SZBtAEYiYFvELJMpvDHrU3LkFWwnhjCIqauaDp48+
         HktA==
X-Gm-Message-State: AOJu0YwQfjMxwF+Zlt4OCzuImDybtPKRNcTpzciv1IPVZQVrJdfcoT+N
	1oL7SxScT5QNUvzJ+DIj4JuaxhQasclCIMR+XgjfshIxCJ/tZacy8ci00SOtVg==
X-Gm-Gg: AY/fxX43TRbib/72ywu9ikXi3nSQpWWxUYpOCPoN6Oi6DGU+QQKMS08u515eEBCHSm7
	z9Gfs0cPEduEQvUzIdoJ88U31tlZsaop6gi+uRCNM+5X4S0cjBHD1re4oVk14bMElsuyqz6DQX/
	zoOtOMASCx4ioigYqpoAbd+PH/7Dn0Nv7t4Y3Do16ZQQdVFTszW82BiBBNjmiTCSsXqn76vgwsL
	cCG+68yzpIqs5Xgv11KqbJ6D+5QQbhB08zbelNzbBqoaltmWIyqTXk3qBsU95AN/IFHTrzOavBT
	o/GU/nUhwTPfWDCJ78/ul0ZYwdW0AjaOVLmDJ8njeMotQRoceaikHEy7GkbgJAchDCJR2glSUf1
	n/0hq/Lu0Xz19JqC3H1lhrYaFNNzRNS98zw9qQizOtnZPfAdf9EvhYcccxuI6Iw1UaalmyxUked
	xjCQOtDlnd1nOBymeAWwag1PATxpI=
X-Google-Smtp-Source: AGHT+IEyNRCEctvv5fntKI6R4JDlZ+lmDeSwQYl7JEaS49Pj3JQEzp9fSGxOToqojbCum385ObBQaA==
X-Received: by 2002:a17:903:32c5:b0:2a0:97ea:b1bd with SMTP id d9443c01a7336-2a2ca8f6621mr348183025ad.0.1766881358144;
        Sat, 27 Dec 2025 16:22:38 -0800 (PST)
Received: from pop-os.. ([2601:647:6802:dbc0:70f5:5037:d004:a56e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d7754asm236533535ad.100.2025.12.27.16.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 16:22:37 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: hemanthmalla@gmail.com,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	bpf@vger.kernel.org,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch bpf-next v5 0/4] tcp_bpf: improve ingress redirection performance with message corking
Date: Sat, 27 Dec 2025 16:22:15 -0800
Message-Id: <20251228002219.1183459-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patchset improves skmsg ingress redirection performance by a)
sophisticated batching with kworker; b) skmsg allocation caching with
kmem cache.

As a result, our patches significantly outperforms the vanilla kernel
in terms of throughput for almost all packet sizes. The percentage
improvement in throughput ranges from 3.13% to 160.92%, with smaller
packets showing the highest improvements.

For latency, it induces slightly higher latency across most packet sizes
compared to the vanilla, which is also expected since this is a natural
side effect of batching.

Here are the detailed benchmarks:

+-------------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+
| Throughput  | 64     | 128    | 256    | 512    | 1k     | 4k     | 16k    | 32k    | 64k    | 128k   | 256k   |
+-------------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+
| Vanilla     | 0.17±0.02 | 0.36±0.01 | 0.72±0.02 | 1.37±0.05 | 2.60±0.12 | 8.24±0.44 | 22.38±2.02 | 25.49±1.28 | 43.07±1.36 | 66.87±4.14 | 73.70±7.15 |
| Patched     | 0.41±0.01 | 0.82±0.02 | 1.62±0.05 | 3.33±0.01 | 6.45±0.02 | 21.50±0.08 | 46.22±0.31 | 50.20±1.12 | 45.39±1.29 | 68.96±1.12 | 78.35±1.49 |
| Percentage  | 141.18%   | 127.78%   | 125.00%   | 143.07%   | 148.08%   | 160.92%   | 106.52%    | 97.00%     | 5.38%      | 3.13%      | 6.32%      |
+-------------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+--------+

+-------------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+
| Latency     | 64        | 128       | 256       | 512       | 1k        | 4k        | 16k       | 32k       | 63k       |
+-------------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+
| Vanilla     | 5.80±4.02 | 5.83±3.61 | 5.86±4.10 | 5.91±4.19 | 5.98±4.14 | 6.61±4.47 | 8.60±2.59 | 10.96±5.50| 15.02±6.78|
| Patched     | 6.18±3.03 | 6.23±4.38 | 6.25±4.44 | 6.13±4.35 | 6.32±4.23 | 6.94±4.61 | 8.90±5.49 | 11.12±6.10| 14.88±6.55|
| Percentage  | 6.55%     | 6.87%     | 6.66%     | 3.72%     | 5.68%     | 4.99%     | 3.49%     | 1.46%     |-0.93%     |
+-------------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+-----------+

---
v5: no change, just rebase

v4: pass false instead of 'redir_ingress' to tcp_bpf_sendmsg_redir()

v3: no change, just rebase

v2: improved commit message of patch 3/4
    changed to 'u8' for bitfields, as suggested by Jakub

Cong Wang (2):
  skmsg: rename sk_msg_alloc() to sk_msg_expand()
  skmsg: save some space in struct sk_psock

Zijian Zhang (2):
  skmsg: implement slab allocator cache for sk_msg
  tcp_bpf: improve ingress redirection performance with message corking

 include/linux/skmsg.h |  48 +++++++---
 net/core/skmsg.c      | 173 ++++++++++++++++++++++++++++++++---
 net/ipv4/tcp_bpf.c    | 204 +++++++++++++++++++++++++++++++++++++++---
 net/tls/tls_sw.c      |   6 +-
 net/xfrm/espintcp.c   |   2 +-
 5 files changed, 394 insertions(+), 39 deletions(-)

-- 
2.34.1


