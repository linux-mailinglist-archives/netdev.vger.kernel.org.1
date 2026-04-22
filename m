Return-Path: <netdev+bounces-280297-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIKTMmlC6GmZHwIAu9opvQ
	(envelope-from <netdev+bounces-280297-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 05:37:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C979C441CE3
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 05:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4B4E9300BC59
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 03:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0363A4F23;
	Wed, 22 Apr 2026 03:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyEUNVGT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5171C3A16B1
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 03:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776829020; cv=none; b=c11AA0/Ku6xbhgaM9I80t/unWLu5D0RK7GIjpqeSrGX+AcFE2h5OivFyHJj6H1jhb3MSO12Po9Vrlzkm/yBs0GHUYkvCnCa7oKn/RSa6ByvBMCeaBQJ4XtiWjOaeyBLT6YBJtmU29foF+UTA9ae6gnjouxvRKvArX3hkDNjpW0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776829020; c=relaxed/simple;
	bh=SqobOYcr+p6ZEe1n5wRVQPGdL4P3Hm39eN3EOFs5zkg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TL475c/bKuDR8Li1dRu9BVfiXXVUsIqTiz/c8+HkflrGgO2B8J8n6euman9JUP0n0FLBBCPHBfFykx2/IaQOO1V8wlcJxPT4MrZ1xXXsgR4btaperdOnUDi9mwkjsj/v/Ecpz0OXMnPLm4K6ofk4GqqgEUP5IDcNPha20yNv4fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fyEUNVGT; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-82f1f6103afso2299232b3a.1
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 20:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776829019; x=1777433819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=epvGnzFq8uZMGM4fcIZGE8+8PvZa4WBZ1uiBJMM4bHQ=;
        b=fyEUNVGThNvZJyvpWgt1DzI9t+/FqAk+A6duRpmN0X6oM65Bb3+ue4utn6o1TaFvsl
         ah3G1+0gGqWac0Wflqi9Q0YJMUogggMQnuzAJ/3qkjjgv2S/P5j0wBD6krb171VwNpAl
         WCH+8E3E+8QBlpX4WZqS6p7/2k0xbBhri3fWHlw9xEnlRHaClVwbactplUpUHj5/NycM
         Ec3Xd9Tnoc9+tW31CalSVwmY0JECIEjejwzQAxdzamBBcHUJLWDvS6WHdoCjUmgmcYa9
         +i05fZ/qjLl5qzOTKERHMl/yNABr4k8LKfRFEXIRT8Bl5HqUznEURR2mHTeVQRxY7Iy+
         4iVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776829019; x=1777433819;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=epvGnzFq8uZMGM4fcIZGE8+8PvZa4WBZ1uiBJMM4bHQ=;
        b=UpdT2J7BNKRx3tFYEMvarjnOTtK94QQ9zgKPdafOf2yTw6jAnTdX+TIXNjd4Jh974T
         CnFwirbjOBGQIlLkQ62SiIe1HYNvscIeRYZ6dMq+wrSSCz6D/e2BrB2TCzJWBehHYmfJ
         TJ5k7wrUj5Hg0CrB8a+WlMYHwoHZStUK6ZSVxSB+X9HJi3XHPuI8C/WdlvehjgbcBk1s
         BO84gT0r8nFmLgdAEBvfg6ddeDDp/2ZqZGhD3bpIaErbXGbXcDekNf9icogAHspOSBSB
         QKdV88OEYnQIOofVPRqoPLLzDjRxCVaWJhqduHuGTfaWD7bFx7uZ+AU1il1CnjaMFO3m
         6uhw==
X-Forwarded-Encrypted: i=1; AFNElJ8GneFV8t0jLQ7XzjiPoEYKrGJgoOMQECDpYw23aIHBxPiGMCmG8ths4NcgqnynkMnd1eUOYBE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDIG0cLIdDQliwkbWq36/DbdB5Y29IcGX8uEh45hfFvVM9m4JC
	Y6PrdNLc4QO2BGmcQKUL5scjhK+EmbzAiZaJpvotkSKIfAIsp1Txkx7k
X-Gm-Gg: AeBDietRAEyigUKrue0bQIp+GvL/bsVwsrsDxmP5iFpYfyAKfoI/Y4fe8QZPyJB98sM
	MYWXQWP/702WwZngJ++j3fHbvdYhsC3/AlMoEPY/7FUe+OmsGv2IR6o/YYvrPGOmjsnIPcOFzJd
	ZLC5GT8fBiCzB5m1p9z8YfuFlRYWH7wKvaM4njXNUjdWEcavw13cMEfv147vmIHN2Qjs4oqKrXE
	f4zovO16XX/Yg2/J57621SpgHAn7oJQejHDqG6d460JYkukfozGMAgtRMsnI1lz7EiXv15/rR2d
	zez5EWPtw/9nevC5Sum3rY/Wc0nTQs5voSUFPLtUq0nqccKd4QT//uxI0nAj2/6O9Vi/RNi3JkW
	0MYlXvWxh8hxxi/xD4LdfHVu3WwbrSI8dQ6tZWPJKETlcKwgKq4NcOOOSVmidw3ULRRLUGTqkSJ
	L0dAEPn4z6ghCjjCfT0oFqADpsB/lDjyewkZMciey9F6+bJyR1mpwdlZKqQXpn/5OZNLbttBncp
	8SxnnN+
X-Received: by 2002:a05:6a00:4b56:b0:82f:5154:d1d9 with SMTP id d2e1a72fcca58-82f8c82e20dmr19444119b3a.6.1776829018589;
        Tue, 21 Apr 2026 20:36:58 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e981c07sm18355473b3a.1.2026.04.21.20.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 20:36:57 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net v3 0/8] xsk: fix bugs around xsk skb allocation
Date: Wed, 22 Apr 2026 11:36:42 +0800
Message-Id: <20260422033650.68457-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280297-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: C979C441CE3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jason Xing <kernelxing@tencent.com>

There are rare issues around xsk_build_skb(). Some of them
were founded by Sashiko[1][2].

[1]: https://lore.kernel.org/all/20260415082654.21026-1-kerneljasonxing@gmail.com/
[2]: https://lore.kernel.org/all/20260418045644.28612-1-kerneljasonxing@gmail.com/

---
v3
Link: https://lore.kernel.org/all/20260420082805.14844-1-kerneljasonxing@gmail.com/
1. use !xs->skb as the indicator of first frag in patch 3 (Stan)
2. move init skb after it's allocated successfully, so patch 4,5,6 have
   been adjusted accordingly (Stan)
3. do not support 32-bit arch (Stan)
4. add acked-by tags (Stan)

v2
Link: https://lore.kernel.org/all/20260418045644.28612-1-kerneljasonxing@gmail.com/#t
1. add four patches spotted by sashiko to fix buggy pre-existing
behavior
2. adjust the order of 8 patches.


Jason Xing (8):
  xsk: reject sw-csum UMEM binding to IFF_TX_SKB_NO_LINEAR devices
  xsk: handle NULL dereference of the skb without frags issue
  xsk: fix use-after-free of xs->skb in xsk_build_skb() free_err path
  xsk: prevent CQ desync when freeing half-built skbs in xsk_build_skb()
  xsk: avoid skb leak in XDP_TX_METADATA case
  xsk: free the skb when hitting the upper bound MAX_SKB_FRAGS
  xsk: fix xsk_addrs slab leak on multi-buffer error path
  xsk: don't support AF_XDP on 32-bit architectures

 net/xdp/Kconfig         |  2 +-
 net/xdp/xsk.c           | 31 ++++++++++++++++++++-----------
 net/xdp/xsk_buff_pool.c |  3 +++
 3 files changed, 24 insertions(+), 12 deletions(-)

-- 
2.41.3


