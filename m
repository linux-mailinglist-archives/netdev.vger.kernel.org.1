Return-Path: <netdev+bounces-224886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B62B8B3C3
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 22:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 634584E1E8A
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 20:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB732D238B;
	Fri, 19 Sep 2025 20:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qzLiFZsc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C0B2C0F8A
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 20:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758314952; cv=none; b=fdNP9XAlMzfW+ddSAjAfKU0idh9cjC3P7lxM9ElNCY0AgH2NMA//x7qs94k0wiW17gsG0v1auBefMDWPpnhzmNgTiOMTKG714jYeaaLUonTUcXsk11n9/59kJZY2USRQ4tNIeB+gJv9ICPv8JToQDRgEzxL2++jUDSSEHo3FpcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758314952; c=relaxed/simple;
	bh=GltS1MoiJRTrYkdO3FyuHxBOt9cWUmr1MM1EMzWaJUs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Qkbt/UyC30vrgczMX9zXEDIRccDc4rrASEcyWy6shiJL37o48EQ1+zo0sV5hZlCuh/2KgicVKI9YuNeI4tocSHJE4Qs4RQBkinOTYHbl2oCqUJ0DK9BB/fyhPcA2nApT7g5nITJunRC2pLoZPebK++7oBDl8d37Mz3OQV6H0fHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qzLiFZsc; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-4b7ad72bc9fso50640871cf.0
        for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 13:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758314950; x=1758919750; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7Bf2T8F5yPCyRKJZEXCko6KsgldS/LH3jIYSs1ITsf8=;
        b=qzLiFZsc8J2AffEBUhh1eP5edcyBEM+1wQz9Vzcrb4kKFQoYZvY6PD1wVLNliJ0867
         amrpAV05Fb77+XVkAzBwuintmc+x4tm8/mXL+hUk/JNmieCzBqsjN1GerTfdifas84IY
         glkbrnlE2Hg/pnLeOCw3z6xll8VJRTvN2gvMp/KOoe1XT7yX610PK6UKPTxB8gDytUZb
         xYWXA+Ncu6/s4I6WqywxBMdNycgyf/qETViHttpHykuORSeAazxJnFod9FX1o3JPVnyo
         FHzSz3XIFUDXLqTpQnzSbS4rdSocPfrlgoO/SatYio/HjC+2Ld5aT2CWUXpPSECiHzSJ
         P35w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758314950; x=1758919750;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Bf2T8F5yPCyRKJZEXCko6KsgldS/LH3jIYSs1ITsf8=;
        b=km9YfZ3Re3CpOWa4NsO+pOr4ZvF9YK0Ph2rEGAkA70ocMsZ5IZWTroJc79+GsACYGB
         OOhTlxBpOgrQvMk2Ty8V697N6Mu/WMssjiX6fVBXmY9wFPTmXGFbBnd3T7qtr4/XKLNt
         uM79ZMmI/HYdID99EXfLC4ujGuTYNGPE1A1aF3h0OHafcF0B+rixVpnkzs6dmjNtZMHD
         4lX+hT68kvVhKkvYYJx6AVfwliS7exzR55HF6TEDHjzErreeDpPczDY+fEuss33itQuZ
         VyFXzn5RAo+KVBz0CieaC3Er3d7hvFDmOtm3nt47u37coWAtHpEcbRNErm3nckNMqNCn
         Pkbg==
X-Forwarded-Encrypted: i=1; AJvYcCUdTswNlTYyZektyOOK3VZOYNQptkt2mA9x4bjeMGjkj+m+YAXY7LdJHCO/n4Bdk4S3ucvw8Mw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL0rqvkhAaiukFqLR300HgPipVbesKMKif0lxYGHEToLSLAIMc
	2zv5JbPVPW0373uAwBNJdeYv00qQVk2giJ2pQHZE/0u9frNR+R1josGrylgZQewNBWDge6yiFuF
	mqF62aJ6sareMCw==
X-Google-Smtp-Source: AGHT+IEcXG8P41Lk5kzd0Ggpo48S6ILpEhDhPz9frWGvCJcVga07NYLLFDav8PgD/K++YrIvU2ScnTq/uaFggg==
X-Received: from qtbge5.prod.google.com ([2002:a05:622a:5c85:b0:4b4:9757:ac9c])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:4a13:b0:4b3:b34:9395 with SMTP id d75a77b69052e-4c072d2d790mr56233581cf.65.1758314950377;
 Fri, 19 Sep 2025 13:49:10 -0700 (PDT)
Date: Fri, 19 Sep 2025 20:48:55 +0000
In-Reply-To: <20250919204856.2977245-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250919204856.2977245-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.470.ga7dc726c21-goog
Message-ID: <20250919204856.2977245-8-edumazet@google.com>
Subject: [PATCH v2 net-next 7/8] tcp: move mtu_info to remove two 32bit holes
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This removes 8bytes waste on 64bit builds.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/tcp.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 3f282130c863d07cddd931b85f43afaf44bc7323..20b8c6e21fef36984810541a06fcb7ba8f0c45b1 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -448,6 +448,9 @@ struct tcp_sock {
 				 * the first SYN. */
 	u32	undo_marker;	/* snd_una upon a new recovery episode. */
 	int	undo_retrans;	/* number of undoable retransmissions. */
+	u32	mtu_info; /* We received an ICMP_FRAG_NEEDED / ICMPV6_PKT_TOOBIG
+			   * while socket was owned by user.
+			   */
 	u64	bytes_retrans;	/* RFC4898 tcpEStatsPerfOctetsRetrans
 				 * Total data bytes retransmitted
 				 */
@@ -494,9 +497,6 @@ struct tcp_sock {
 		u32		  probe_seq_end;
 	} mtu_probe;
 	u32     plb_rehash;     /* PLB-triggered rehash attempts */
-	u32	mtu_info; /* We received an ICMP_FRAG_NEEDED / ICMPV6_PKT_TOOBIG
-			   * while socket was owned by user.
-			   */
 #if IS_ENABLED(CONFIG_MPTCP)
 	bool	is_mptcp;
 #endif
-- 
2.51.0.470.ga7dc726c21-goog


