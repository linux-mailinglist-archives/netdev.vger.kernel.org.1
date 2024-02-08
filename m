Return-Path: <netdev+bounces-70269-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5476584E362
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 15:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D59FB25BD0
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 14:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906187AE79;
	Thu,  8 Feb 2024 14:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jIhTtxSj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F8178B75
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 14:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707403411; cv=none; b=OpRMnLfFq97DrqV4FrzH57ay5LjinOQN+pEcROKxJZNfXwbduCap3I9R2+JxAJZXKRykfMPnEIMomWlsvfA4GIl6gBzZ3cM/3NeXo/6gDMAtKcq7JQHuSkHdPv0rHzT9AzK/PnwbJQzpoN23D3IIMlAUtdpMpAJ7VoBnRzs2wV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707403411; c=relaxed/simple;
	bh=cBzQObKHRJd2O6mFtwmyqAPVjlOpyeLUjCcghq9+Tqs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f81LdfzvgerdxPaGR64p6RWJMrMOt0ZYCn8WY5yQyqca/1T6DsaUNH6o+Nnv14F9KAU8CdfVwjzoBuUD9pQHtWyatYmftT8ft+4VyRNF0hiqj7pWe8U8mFHLiSHLRZc0Uo+SGUohOv5kCvxFfZC6BBQgrjIEBCWJ+yWmf2XHqm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jIhTtxSj; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc7441509bdso836689276.3
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 06:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707403409; x=1708008209; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WwAtmkTQYyb87BH2rZ47sWY1M+kxgrxgLhIeIr+5+hY=;
        b=jIhTtxSjHBbLW5QzpHwkVOotfE9h6O6Hl67jJw0/r3/0kpFm7NujdG2G2dCmDz8iIh
         Mo0fTWj2JbViIuy3DM46A+AVPv8BRSLx8vI4fRQERp9fRw3tZy1s8rzQGiEtUBfWmiMG
         mGrJULBYsIzpvg2kxqGiTWKBlPOBE8VpLOnDZDdKF8fuNG92Og8JD8PBuNaFAiM0FaAO
         aTYts1Bx2D7rVH/L5du5eR1d2dLQ6jmEOXf5mJ2t6j4kkBtDVSZ7c3xpD4N3m88LzhUj
         KpCCh8xETL2U8mo1w4TLpZ5mtduCJd/x7URbuLx2nd/gXR/dY7sOeslkOwjH7NiFo7JT
         fGuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707403409; x=1708008209;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WwAtmkTQYyb87BH2rZ47sWY1M+kxgrxgLhIeIr+5+hY=;
        b=sUYB1/ucwWT6CUT2UChOHyKjfjwK38GiFPpcCz8S8p3nOzwmC3Z9KVinBxRjEiKYwP
         iflePz1CWWL/JoThxH5ICccgSq5OIXZ5yNpTcoluTfZaFn+VhKRwvjgGUSR+yl676C70
         5Y7C0+YrYaTiNISYVqPwp6zc+7aAfAt7VbkLOVvH/8VVZXpq1rc2LMEwV7Sn2hbB2Zkp
         vdqw2zQQXIadaFM3PzMERujXT78VMIDmjQZjZh/Rb3P4lmLy9IPHuveFMKaSLmvxD2Rq
         sgiLhMQs8q3zCriZIu5xsL3woO/ES7HOw0k86ZCyABAjn6y/3VKMTXoPO/msayjIpD0F
         B9sg==
X-Gm-Message-State: AOJu0YyBgTRjpE6q1l9oOPLYbJCiL8hNIvBa4qwlWp1Q1xL+KjEOUQQH
	8sj1g2ynHyMDh53nXBW4ghUEWECe5VYUmw/FzUWpkZiUTgN5PsZvPucwjAFcjucgSu3x94kYx7J
	AzcB+uoST0Q==
X-Google-Smtp-Source: AGHT+IEfefvg3yQPVrjaS9lFM5KFBQxfL4nW+SxmHmIU5I4ou2qZo4nR2ku90sNI2yHQE863aehgn3OtEsGUYw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:138e:b0:dc2:3426:c9ee with SMTP
 id x14-20020a056902138e00b00dc23426c9eemr340570ybu.11.1707403409007; Thu, 08
 Feb 2024 06:43:29 -0800 (PST)
Date: Thu,  8 Feb 2024 14:43:22 +0000
In-Reply-To: <20240208144323.1248887-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240208144323.1248887-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240208144323.1248887-3-edumazet@google.com>
Subject: [PATCH net 2/3] tcp: move tp->tcp_usec_ts to tcp_sock_read_txrx group
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Naman Gulati <namangulati@google.com>, 
	Coco Li <lixiaoyan@google.com>, Wei Wang <weiwan@google.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

tp->tcp_usec_ts is a read mostly field, used in rx and tx fast paths.

Fixes: d5fed5addb2b ("tcp: reorganize tcp_sock fast path variables")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Coco Li <lixiaoyan@google.com>
Cc: Wei Wang <weiwan@google.com>
---
 Documentation/networking/net_cachelines/tcp_sock.rst | 2 +-
 include/linux/tcp.h                                  | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/net_cachelines/tcp_sock.rst b/Documentation/networking/net_cachelines/tcp_sock.rst
index 80391229147971005571f9a9a4fcdcf4e50089da..1c154cbd18487e385c8ae7a1e39d3b5f5ab086a2 100644
--- a/Documentation/networking/net_cachelines/tcp_sock.rst
+++ b/Documentation/networking/net_cachelines/tcp_sock.rst
@@ -44,7 +44,7 @@ u16                           advmss                  -                   read_m
 u8                            compressed_ack                                                  
 u8:2                          dup_ack_counter                                                 
 u8:1                          tlp_retrans                                                     
-u8:1                          tcp_usec_ts                                                     
+u8:1                          tcp_usec_ts             read_mostly         read_mostly
 u32                           chrono_start            read_write          -                   tcp_chrono_start/stop(tcp_write_xmit,tcp_cwnd_validate,tcp_send_syn_data)
 u32[3]                        chrono_stat             read_write          -                   tcp_chrono_start/stop(tcp_write_xmit,tcp_cwnd_validate,tcp_send_syn_data)
 u8:2                          chrono_type             read_write          -                   tcp_chrono_start/stop(tcp_write_xmit,tcp_cwnd_validate,tcp_send_syn_data)
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 168f5dca66096589e7a213ffd6742a51fe43b4a9..a1c47a6d69b0efd7e62765fbd873c848da22aaec 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -224,6 +224,7 @@ struct tcp_sock {
 	u8	scaling_ratio;	/* see tcp_win_from_space() */
 	u8	chrono_type : 2,	/* current chronograph type */
 		repair      : 1,
+		tcp_usec_ts : 1, /* TSval values in usec */
 		is_sack_reneg:1,    /* in recovery from loss with SACK reneg? */
 		is_cwnd_limited:1;/* forward progress limited by snd_cwnd? */
 	__cacheline_group_end(tcp_sock_read_txrx);
@@ -368,8 +369,7 @@ struct tcp_sock {
 	u8	compressed_ack;
 	u8	dup_ack_counter:2,
 		tlp_retrans:1,	/* TLP is a retransmission */
-		tcp_usec_ts:1, /* TSval values in usec */
-		unused:4;
+		unused:5;
 	u8	thin_lto    : 1,/* Use linear timeouts for thin streams */
 		recvmsg_inq : 1,/* Indicate # of bytes in queue upon recvmsg */
 		fastopen_connect:1, /* FASTOPEN_CONNECT sockopt */
-- 
2.43.0.594.gd9cf4e227d-goog


