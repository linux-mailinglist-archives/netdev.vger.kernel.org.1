Return-Path: <netdev+bounces-103810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A206909992
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 20:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E1FC1C20E34
	for <lists+netdev@lfdr.de>; Sat, 15 Jun 2024 18:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEA34AEDF;
	Sat, 15 Jun 2024 18:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XjQuQf7g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE514502B9
	for <netdev@vger.kernel.org>; Sat, 15 Jun 2024 18:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718476046; cv=none; b=PTP+/mMXj8TVr3kPPZPy3tltRqOTOazaXLztPS1C6KGspbGhEzlwNXTPwdAqyHdpbBLlCyvCqTbF4GqVkmFmc1gZNQ/koHIU0vx0EBCm8nOCBRIiVZnmUyJPDlSUNuV+ePh26jGrNaZOrFsEuLdPgXisycgmBbczzMPcoGer7OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718476046; c=relaxed/simple;
	bh=Zhf/A/6caAk8WHka7zqblAnl1FpszDM4r5kHQSoM/dU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sNDAuCbNG1uxHeNVr/UuK5gZgHvWp0OIdb3Kf9HO+GApRW5y7o7Y+uSdfH2SffzVwtI4uv7+jfFlEa+ktR0rHf/qKrJpgjw5tA7VU5H5eag54s2Vhrn23tvK9A39nHr2cRzAHTf2oy2NhA+ZI2RKxwSDqE4td2otvyfQd3OSijc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XjQuQf7g; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3cabac56b38so1844252b6e.3
        for <netdev@vger.kernel.org>; Sat, 15 Jun 2024 11:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718476043; x=1719080843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wKcZGwq50WFmVbjPM4JlJIEJRh6da34D8reTQcRBMyA=;
        b=XjQuQf7g59hbduuat20SfrG+gGZ+IsLEe0FpPgaiUxWkAjWffvQZfgPrrNeaeAvFO0
         xtBOwtBKb5Iv89hNIO1exb7ks1mzHFk+OIPzEPGG1u8+uhRaFxlQncGKr0xxXvs1chgZ
         5L62Ce2NAyaOwdXqZZ7CSsrStUvy+ANd9ErWEuFf9YK8kEloCxG+ox0flyGhiGd0okq0
         1GjNd1tZgnb/HEsHt6cGHlDvd2M1fKn8tOblb6Rx6MUpGobzVROlYSGfSvS7ShWVxKB5
         ADbEX027LQFiUeX4nOmKXYYl020W323K9Dhct34fjgquPtRQXXiQfAs7dWATHazx6T47
         KgLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718476043; x=1719080843;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wKcZGwq50WFmVbjPM4JlJIEJRh6da34D8reTQcRBMyA=;
        b=baMIlvkEiQgEuJFhOQyOWIRVhiY5q1R5n71Anu4x+JYY7MRDnHXtt4fSnpMHtRG5zl
         9l7Xv8txhVNe3o+AS5GlLPcl44uWGEzp0rDKNCeX6+tTd5hIVdFt2k8flZbpkQ3Og3Ri
         rK55v4otixPZB8e0dxgusSRtjS9PDn3zEibrddQcNOeeSRsaoRLGhCbmJZl0TAl+qroC
         WreJ90nUMDEGoGvKCJTTFMw7pR2F0g6At5qacvlqLhVNqhLDFxqoUt64PyYfgFsQTMsZ
         vqSAG0bcQT7VEcd2GW9EmCAX3aORbEZ3fbJlL+zMci1aonU1Cbl4bGSFtnsg3YeQYPu+
         P2Wg==
X-Gm-Message-State: AOJu0YyIo8WFA0Z2YxdRqNrPFF8HytgadKzQN9QfAZQtqzlnk6Qrf003
	fUfkkPs4pUV0FmPzuZgcBYrcbBBY/GaByizj1XH56yASrfTbOvUWMvj+FBXb
X-Google-Smtp-Source: AGHT+IEVNkvdP0S30R6n3pvQNu1p/ah3iAwF3rd+tIY2cWSoU/FkyFqUFz723Ch2+2lNEKbPK5TeXw==
X-Received: by 2002:a05:6808:1513:b0:3d2:1a92:8f4a with SMTP id 5614622812f47-3d24e8f2e1cmr6187294b6e.23.1718476041812;
        Sat, 15 Jun 2024 11:27:21 -0700 (PDT)
Received: from wsfd-netdev15.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-443529f36f5sm9054241cf.62.2024.06.15.11.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jun 2024 11:27:21 -0700 (PDT)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	tipc-discussion@lists.sourceforge.net
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jon Maloy <jmaloy@redhat.com>,
	Ying Xue <ying.xue@windriver.com>,
	Tung Nguyen <tung.q.nguyen@dektech.com.au>,
	Tuong Lien <tuong.t.lien@dektech.com.au>
Subject: [PATCH net] tipc: force a dst refcount before doing decryption
Date: Sat, 15 Jun 2024 14:27:20 -0400
Message-ID: <fbe3195fad6997a4eec62d9bf076b2ad03ac336b.1718476040.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As it says in commit 3bc07321ccc2 ("xfrm: Force a dst refcount before
entering the xfrm type handlers"):

"Crypto requests might return asynchronous. In this case we leave the
 rcu protected region, so force a refcount on the skb's destination
 entry before we enter the xfrm type input/output handlers."

On TIPC decryption path it has the same problem, and skb_dst_force()
should be called before doing decryption to avoid a possible crash.

Shuang reported this issue when this warning is triggered:

  [] WARNING: include/net/dst.h:337 tipc_sk_rcv+0x1055/0x1ea0 [tipc]
  [] Kdump: loaded Tainted: G W --------- - - 4.18.0-496.el8.x86_64+debug
  [] Workqueue: crypto cryptd_queue_worker
  [] RIP: 0010:tipc_sk_rcv+0x1055/0x1ea0 [tipc]
  [] Call Trace:
  [] tipc_sk_mcast_rcv+0x548/0xea0 [tipc]
  [] tipc_rcv+0xcf5/0x1060 [tipc]
  [] tipc_aead_decrypt_done+0x215/0x2e0 [tipc]
  [] cryptd_aead_crypt+0xdb/0x190
  [] cryptd_queue_worker+0xed/0x190
  [] process_one_work+0x93d/0x17e0

Fixes: fc1b6d6de220 ("tipc: introduce TIPC encryption & authentication")
Reported-by: Shuang Li <shuali@redhat.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 net/tipc/node.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/tipc/node.c b/net/tipc/node.c
index c1e890a82434..500320e5ca47 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -2105,6 +2105,7 @@ void tipc_rcv(struct net *net, struct sk_buff *skb, struct tipc_bearer *b)
 	} else {
 		n = tipc_node_find_by_id(net, ehdr->id);
 	}
+	skb_dst_force(skb);
 	tipc_crypto_rcv(net, (n) ? n->crypto_rx : NULL, &skb, b);
 	if (!skb)
 		return;
-- 
2.43.0


