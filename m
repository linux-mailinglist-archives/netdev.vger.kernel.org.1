Return-Path: <netdev+bounces-99693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD69A8D5E0B
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 11:18:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD7F31C223BA
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 09:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C3E770FA;
	Fri, 31 May 2024 09:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egzXyJEO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F8674267
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 09:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717147090; cv=none; b=Ot4xP8V9V6pVbBWCEtEXVnEcwdzlfXYob5eH3nY8l14InJgSvK5LW0x6Uh+eFi4OCTlIPqOLn92w+Z1VSyLvsb3MQZ+92OjtWpm1CAfLvXBfjniC1AoJAa8Ori23n0BKycOVoGQEHpW02LAoHx9Dp8u0CYWUSklaO/cOcBsd4wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717147090; c=relaxed/simple;
	bh=eyQnC/rEPBwn0E5uHpSpwaoEXey2aSvRknwYF2ugYQs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DXB2vnw5cAHVP9ZZzY9wYsXSa/SZRympfs4P+JSJa6BFA1v7ndwRL6njTaiblT+b17e8AuptvE42hF6y7QZwcN5jVE9twVZjQvwJgt2iOihjfCnSUwzPLWu5TEjua6m/17/wXJ+iOoDg2o6m8AX3XHU/VmGe4v03xxiIebD6Gtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=egzXyJEO; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7022e0cd0aeso1713618b3a.0
        for <netdev@vger.kernel.org>; Fri, 31 May 2024 02:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717147088; x=1717751888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GFtIipB+8uh1h/WWuJkWeXFWlpOYxcgwM8qEpCuPaOw=;
        b=egzXyJEO2/jTpx7XA2POaF2jLQU2Gxnk1Yf/Mvccg5FInQngh8FDJS/IGSP9BOvjPG
         PdEV+qmIPU5oH2fUE0RmTs0XgZRp773ENJFUghDulNgY9ly3aifcHH2noasSqSgFFfg/
         jAinDHgpJfpchkJnmGHUgBfmlxaOvu4kVC3SMxDvc05Q6SUvOZi6TUPr3cJobV073hZs
         YAxXTkDXnXIGpmEPlFKemDEbQTyryWfzlKplVz6Y6q4PgzycfS+lhg+b+KVZ/YDvjlAd
         +3P1TLxl8v4qpbjvNqRUm/OrEWQ5joqgcKi3XnA59ijsiOFSoPIjjyCzSTlZBtnK9paP
         qUQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717147088; x=1717751888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GFtIipB+8uh1h/WWuJkWeXFWlpOYxcgwM8qEpCuPaOw=;
        b=T6gdhJK1kl+QiNfiQvfm+5wh4vfd0meL3UNe7EG29EpeaMHiAsz5udmopx8VFtp8Il
         W+Yy89cJGjp+hLWYf/ly1lesF8cLmxhAVJ6FDR652mhu2KFwDe+TFvS1/gLan4bidbxW
         lUyNkNgduXeEbXjLdMbMZ+rx7VQkC5SdDvxZjByMK7ovZyIWQUmPWngYzsPT0zoOhtpv
         nAq9rRivlotsMZkdZ1PxqJieBgSvW1Z3cL4O2ymtt18q0pNSPgXqTjFtjK/dbJSgx69H
         QH5XftuAm1ocsSe5uAynzoYBB9DXmoZV0RMkJsVpERCTRSynFHlr/JHDFdkoexDLZ3xM
         Wnfg==
X-Gm-Message-State: AOJu0Yya2TeI1ePBjUyLwx3orNczds//vs3PHxNB5Wn+Zr9Y7Ri6Ctfs
	6YVAJRniPaHZYAq0BkuWFaP2JSg9Hq9RSDRtw68I4F/KyQuF9kM0
X-Google-Smtp-Source: AGHT+IFBxUg00mUC2sLff/ELtuqbYhpyZ1togUMePSm+KrTfgqA4KJ/wHfhDbl6L7h//L7Hjr1srpA==
X-Received: by 2002:a05:6a20:8403:b0:1a9:6c18:7e96 with SMTP id adf61e73a8af0-1b26f1c4f38mr1384696637.19.1717147087777;
        Fri, 31 May 2024 02:18:07 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f632356c84sm11950015ad.76.2024.05.31.02.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 02:18:07 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	matttbe@kernel.org,
	martineau@kernel.org,
	geliang@kernel.org
Cc: netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net v4 2/2] mptcp: count CLOSE-WAIT sockets for MPTCP_MIB_CURRESTAB
Date: Fri, 31 May 2024 17:17:53 +0800
Message-Id: <20240531091753.75930-3-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240531091753.75930-1-kerneljasonxing@gmail.com>
References: <20240531091753.75930-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Like previous patch does in TCP, we need to adhere to RFC 1213:

  "tcpCurrEstab OBJECT-TYPE
   ...
   The number of TCP connections for which the current state
   is either ESTABLISHED or CLOSE- WAIT."

So let's consider CLOSE-WAIT sockets.

The logic of counting
When we increment the counter?
a) Only if we change the state to ESTABLISHED.

When we decrement the counter?
a) if the socket leaves ESTABLISHED and will never go into CLOSE-WAIT,
say, on the client side, changing from ESTABLISHED to FIN-WAIT-1.
b) if the socket leaves CLOSE-WAIT, say, on the server side, changing
from CLOSE-WAIT to LAST-ACK.

Fixes: d9cd27b8cd19 ("mptcp: add CurrEstab MIB counter support")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/mptcp/protocol.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7d44196ec5b6..6d59c1c4baba 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2916,9 +2916,10 @@ void mptcp_set_state(struct sock *sk, int state)
 		if (oldstate != TCP_ESTABLISHED)
 			MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_CURRESTAB);
 		break;
-
+	case TCP_CLOSE_WAIT:
+		break;
 	default:
-		if (oldstate == TCP_ESTABLISHED)
+		if (oldstate == TCP_ESTABLISHED || oldstate == TCP_CLOSE_WAIT)
 			MPTCP_DEC_STATS(sock_net(sk), MPTCP_MIB_CURRESTAB);
 	}
 
-- 
2.37.3


