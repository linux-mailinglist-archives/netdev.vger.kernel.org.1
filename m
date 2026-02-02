Return-Path: <netdev+bounces-255995-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGuCDXv9gGk6DgMAu9opvQ
	(envelope-from <netdev+bounces-255995-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 20:39:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D2291D0933
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 20:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 06BF93008252
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 19:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84096305064;
	Mon,  2 Feb 2026 19:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M3fJQwLn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AFD3043A4
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 19:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770061176; cv=none; b=sqPbpFpN0djHXIEqV9ZriJ59n0HgAGmb3YflWOjgKv7sMwX7SJAfXh06X6OndYaDcD1YhsJijKtA8b/fbqgNDwoNk3F70g7IgfpLJDr3j5pHuxYsqJGKKaQKLU5RyIfNJB4DVAKARSMPw5DZdNZbFMJmNSUYX1lnAw4cOT8fNu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770061176; c=relaxed/simple;
	bh=xMWjIBemj+ovDo71k/lbnlBBE9tZnK7oQzi8YhPuLhs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lJ5pqoyzH7ogm2Kg8UE+vusiOGVlhA9IQYhMaGKokWkKsavTHx65W81cHhn51u/LnRwc+AAw0sir30E0zQ7VR8k4w6eoxCcv1xRCQitRvyIWR/XgCgyinhwCcxbE3/O0zwC6AXyuLigPoAILiLFT+XNyDQGV3Fm90qWGOHY07t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M3fJQwLn; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2a8c273332cso127172495ad.1
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 11:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770061175; x=1770665975; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TzUehqNS0ybAXqn2p+RtPCZdOa9cTlWsLGkT2lUzyqo=;
        b=M3fJQwLnVxbmeOIt7+3ysxWjuTEN7VpdWOq7Z5co58+/GX6D9iYs6ZDCErePJq+Bou
         ZO2Zod/dVj1WlFoJQa9EjfCJQSplg0XByAOOJXDNaLh6F2fEER/LZhepN26TMisN01ok
         P+de48ZbmJfC/nZk/JEf2kHrJwmE81goprL6Vti8SuNHTjipgxzgymF/UZM5zu5O6ruU
         yy9gp8of62vNtHxV0UV/93sgPVMZo0owcEl1RugyfDQnlsDsU5DX8CHkOJ9y8PytF2b5
         vSQR72JHjRlNZbDtoC8aXzdAzrkH8Onr97f95F14KoCw3FLUyzkZIVH+YUFYzEBY5+J2
         zXmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770061175; x=1770665975;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TzUehqNS0ybAXqn2p+RtPCZdOa9cTlWsLGkT2lUzyqo=;
        b=iNIs/gPQA2P2hQlQF9SmTI+8XfGN7ChV6wFOHCCz3hjtg74hZ4ubqXjwKJNnwVprSA
         gZfeXe4XTGT6H32mod7Zns1aufsZr81HaFl1IXJwQvA5Hy4/i3Hkl856hphCOARkxNWX
         Z/CGxjIcEDOomRachHPB7+dtMH7426w1nW6jeTKJigGMlbXpQYsDH6E2Vd3GGw7+82bI
         ggHg5+AC2+iagEwLlv77c3vLAo/PxFGSNNAAn4oLr5+vmGIA3Kz9uAyY55f/Q+6UYobq
         wtw6zjZLT9y7xti11vJXlC/ZLU/Zx+BabjZO9tmpa7/LnAOiNmG7gMsXT9mOG0A5xEgZ
         YJ2g==
X-Gm-Message-State: AOJu0YzauErcVZC7SFu8oLVA94vAoW/mVrStBCGXd39KyTw7Sw0oqRQG
	EAdwbaxvTPedfJQkvfKlcfiH45G5SSoHyLqVJ5Z8NmhgBrWxI1hUg+YBZ8iOhnU/Y2vL3X2xSK1
	LwK5ADh9vZhwSqsHMLd2scdYYLzGVU/Iur8xqdGezGReuf0Mzh7sN+kvoxyTpUPPI0wKIR7GXTL
	1aunppPJqR9vsamBYhIoU9tilTSM+4O2jvElg6y74wwmNcyAuyBJFyjQqQYoKajYE=
X-Received: from pgc3.prod.google.com ([2002:a05:6a02:2f83:b0:c66:ac3e:e707])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:1446:b0:37e:7e93:99cf with SMTP id adf61e73a8af0-392e0100349mr11565062637.37.1770061174526;
 Mon, 02 Feb 2026 11:39:34 -0800 (PST)
Date: Mon,  2 Feb 2026 19:39:23 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260202193925.3106272-1-hramamurthy@google.com>
Subject: [PATCH net 0/2] gve: Stats reporting fixes
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, ziweixiao@google.com, jordanrhee@google.com, 
	nktgrg@google.com, kuozhao@google.com, yangchun@google.com, 
	awogbemila@google.com, maolson@google.com, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	sdf@fomichev.me, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.com, Max Yuan <maxyuan@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255995-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org,vger.kernel.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hramamurthy@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: D2291D0933
X-Rspamd-Action: no action

From: Max Yuan <maxyuan@google.com>

This series addresses two issues related to statistics in the gve driver.

The first patch fixes a memory corruption issue that occurs when resizing
the stats region during queue count changes. By allocating the maximum
possible size upfront and aligning offset calculations with the NIC,
we ensure stability and accuracy across reconfigurations.

The second patch fixes the 'rx_dropped' counter by removing allocation
failures and incorporating XDP transmit and redirect errors to provide
a more accurate representation of dropped packets.

Debarghya Kundu (1):
  gve: Fix stats report corruption on queue count change

Max Yuan (1):
  gve: Correct ethtool rx_dropped calculation

 drivers/net/ethernet/google/gve/gve_ethtool.c | 77 ++++++++++++++++++++++++++--------------
 drivers/net/ethernet/google/gve/gve_main.c    |  4 +--
 2 files changed, 53 insertions(+), 28 deletions(-)

-- 
2.53.0.rc1.225.gd81095ad13-goog


