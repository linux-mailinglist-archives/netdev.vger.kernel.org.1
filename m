Return-Path: <netdev+bounces-70268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17ACA84E361
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 15:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D2831C26753
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 14:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B577A713;
	Thu,  8 Feb 2024 14:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WyI6ioA3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61F67994A
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 14:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707403410; cv=none; b=tHhRaVMuLGCSd0I71VcXR2Y36RVR+ol05LZVDuwFGNPP+tWARpQQk9rclzEJluoE8oVWBkw8vFF7xYHgYAZZddr/KiUMRZ6qQgRqpxLxYNnRXp8Q83N/i1kekPw8Hzn3B4jwBYr+DYhDh4UgwvHkgcOuQQfB/TlCMAbRiBmc028=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707403410; c=relaxed/simple;
	bh=OGgl8FxnD62JuKe8cermmR5pHiy9GN/hJL81bcGZ028=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uj4x6OztIpz6ayFP06Ly/qh0ivr0vMzwSJZiM8MtnnpRY+apribOnA5zPq4jEQgl1FV1ZFmEnXV7FRCIGAr/JgYUSZWtosyWCm0lms4b5tgnWY8eJ5N1mmYS2nEWoyFotiEykXDjJkznRWaN4VuPKbQ7i2TGm0pE0Dgz/GGwnac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WyI6ioA3; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b26783b4so2539447276.0
        for <netdev@vger.kernel.org>; Thu, 08 Feb 2024 06:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707403407; x=1708008207; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HHDS6pxoJCsuCNR0VS38j92N4XWSJ0vh98P3PXDAQBs=;
        b=WyI6ioA3e3XpG+ZeuRWF3rllL6lWy8B8DDbt6iYiqu27Ba556kqMQfnrdzqieh/uIJ
         AW8Rs8RQDRyXJsXGQ10h7g1qAnYWkSWLh21Q3+9TfNc58nJ9a7FkG7qxl3ubCUfZw7Lt
         sshR4C3nYGgxlruMxoBLQ5wRksJd1h05ZUERVLUcw7XdWulhxbrIUAgdf2VbcHr6EWW0
         O5IDiO8NfRdTLbVs+UxX2mPSf7pz75FALbWXjwo/8QgcBRDqrH1asjJutEhv7uNoIG/B
         tSJQGgObIKD/9fic/8B8HoQpckMkcbiFIKzY4M4EJmjYnQCyA1M1Nyf8cuRw+c6IMehe
         m12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707403407; x=1708008207;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HHDS6pxoJCsuCNR0VS38j92N4XWSJ0vh98P3PXDAQBs=;
        b=k49aQBQSXDAMhH2eIDtUZ13fUr2NlBFaV0ifFMmShzjYwJ6AkqEGsjVEMdSpTeDAoY
         L2ZZe1sT4D4MGeB3F5W8hhR23Rp0HLly9dMGQ09nVw0+AZLUL3XuKnBCEoidUyPEpudv
         AUtOQrGmzGlAlSk4yi/MATUcEy2i6Mk2jsAh3mhIbC90+OMc5/vvY4qIGpdKhDNBUOzI
         NNIDcIt0ls1GXHmYImztsqlQYHSL1IIqlk/reM9HAjws+Sjkh+LfJ6C941TNmPOUcH+y
         35JF5JwudaSmgQBHMjEim7yI7tQhlm2HfKNojS1EOffCluIPcaF/OktboTVncp7Mkoka
         CkrA==
X-Gm-Message-State: AOJu0Ywz+/fm4pAX3vh+l6Ve4E6qX4fpjwtVxh7iZCii9y3GtSrrp18s
	NH62ZBvYWV0cShfNusilYtl2rbgaCqY6y4d9hV9Kl+AaJW4IY/+uX5ccp7SNxbaBtOtMDJFGmFn
	dODLa18sLBQ==
X-Google-Smtp-Source: AGHT+IEiG16/Z8JQaucY2QHKEh/Qgu7lBeauL1STCtODLIjUEGH82dWbLXT17JDK65bedMrcKsqrAQwaFBm/PA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:118f:b0:dc6:c623:ce6f with SMTP
 id m15-20020a056902118f00b00dc6c623ce6fmr284691ybu.13.1707403407577; Thu, 08
 Feb 2024 06:43:27 -0800 (PST)
Date: Thu,  8 Feb 2024 14:43:21 +0000
In-Reply-To: <20240208144323.1248887-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240208144323.1248887-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240208144323.1248887-2-edumazet@google.com>
Subject: [PATCH net 1/3] tcp: move tp->scaling_ratio to tcp_sock_read_txrx group
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Naman Gulati <namangulati@google.com>, 
	Coco Li <lixiaoyan@google.com>, Wei Wang <weiwan@google.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

tp->scaling_ratio is a read mostly field, used in rx and tx fast paths.

Fixes: d5fed5addb2b ("tcp: reorganize tcp_sock fast path variables")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Coco Li <lixiaoyan@google.com>
Cc: Wei Wang <weiwan@google.com>
---
 Documentation/networking/net_cachelines/tcp_sock.rst | 2 +-
 include/linux/tcp.h                                  | 2 +-
 net/ipv4/tcp.c                                       | 3 ++-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/net_cachelines/tcp_sock.rst b/Documentation/networking/net_cachelines/tcp_sock.rst
index 97d7a5c8e01c02658c7f445ed92a2d1f7cc61d31..80391229147971005571f9a9a4fcdcf4e50089da 100644
--- a/Documentation/networking/net_cachelines/tcp_sock.rst
+++ b/Documentation/networking/net_cachelines/tcp_sock.rst
@@ -38,7 +38,7 @@ u32                           max_window              read_mostly         -
 u32                           mss_cache               read_mostly         read_mostly         tcp_rate_check_app_limited,tcp_current_mss,tcp_sync_mss,tcp_sndbuf_expand,tcp_tso_should_defer(tx);tcp_update_pacing_rate,tcp_clean_rtx_queue(rx)
 u32                           window_clamp            read_mostly         read_write          tcp_rcv_space_adjust,__tcp_select_window
 u32                           rcv_ssthresh            read_mostly         -                   __tcp_select_window
-u82                           scaling_ratio                                                   
+u8                            scaling_ratio           read_mostly         read_mostly         tcp_win_from_space
 struct                        tcp_rack                                                        
 u16                           advmss                  -                   read_mostly         tcp_rcv_space_adjust
 u8                            compressed_ack                                                  
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 89b290d8c8dc9f115df7a295bc8d2512698db169..168f5dca66096589e7a213ffd6742a51fe43b4a9 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -221,6 +221,7 @@ struct tcp_sock {
 	u32	lost_out;	/* Lost packets			*/
 	u32	sacked_out;	/* SACK'd packets			*/
 	u16	tcp_header_len;	/* Bytes of tcp header to send		*/
+	u8	scaling_ratio;	/* see tcp_win_from_space() */
 	u8	chrono_type : 2,	/* current chronograph type */
 		repair      : 1,
 		is_sack_reneg:1,    /* in recovery from loss with SACK reneg? */
@@ -352,7 +353,6 @@ struct tcp_sock {
 	u32	compressed_ack_rcv_nxt;
 	struct list_head tsq_node; /* anchor in tsq_tasklet.head list */
 
-	u8	scaling_ratio;	/* see tcp_win_from_space() */
 	/* Information of the most recently (s)acked skb */
 	struct tcp_rack {
 		u64 mstamp; /* (Re)sent time of the skb */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 7e2481b9eae1b791e1ec65f39efa41837a9fcbd3..c82dc42f57c65df112f79080ff407cd98d11ce68 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -4615,7 +4615,8 @@ static void __init tcp_struct_check(void)
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_txrx, prr_out);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_txrx, lost_out);
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_txrx, sacked_out);
-	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_read_txrx, 31);
+	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_txrx, scaling_ratio);
+	CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_read_txrx, 32);
 
 	/* RX read-mostly hotpath cache lines */
 	CACHELINE_ASSERT_GROUP_MEMBER(struct tcp_sock, tcp_sock_read_rx, copied_seq);
-- 
2.43.0.594.gd9cf4e227d-goog


