Return-Path: <netdev+bounces-101496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B77FC8FF114
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 17:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 550CB283478
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 15:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC63196C7B;
	Thu,  6 Jun 2024 15:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jYBOglC/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237611DFF5
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 15:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717688816; cv=none; b=bWH1+j7HQc7HyjRWDWJ3whMwGdPJr2QnMGAgWqAfo2tWeZ1g6teardSKWmV+5SCwPcS0JLq46JI3qXCCutf2lJN4o9POPZIJCqb+BXMqu7vKTH8fF1WRH+DlnyTVkg0RI0/D0wUxJHik81gEKTHFMQi+P2xOvhV1+bAdNtd6+gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717688816; c=relaxed/simple;
	bh=5zqeMrKdcCn24Pz6pDqO2FCIAYGEIlUc9qUbctZ2+RI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=DWx4HLnoRbV8WUtpaXTFtDWTE2jIi4FgRRMj/uJz5NlkiZfoCllJwy7/2i/hRMQnixkt5+BOxQP7SSsoFU7HF50kUie1+x7iIQATylMyqaUpTW7bqPU9b37ZQPZI4AJa5gH6kg9HHBvovXdC4jMNurBYhgqXMgJ8KGNTWXaasSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jYBOglC/; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-629638f1cb0so16253077b3.3
        for <netdev@vger.kernel.org>; Thu, 06 Jun 2024 08:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717688814; x=1718293614; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nxmDI3+vEBpOe0IOLGqBGRnkAHmKZ9+qj0SgsfXfWb4=;
        b=jYBOglC/CAsc72SjP8qfeVpCVJ8siyk40MOCtFyq2+LdvbR/C9ZDN/wEDOk/iBlFuI
         k56wTtPOfAuZvOwgtmmQ9UzPbPqQdxJgbtBbh/yp2pYJKA4GGF0qk9herUrxqQaRlRsu
         d6+kR77P5djdOfS31By87XTCiQyn+yjnE885MSiH4JBx+Rc+d7TmDhjTAyKWyQ3qxakW
         zFnR6kd9TsY4/shz4HVUzDQ/HVOMUJaiEMIe3QIoM/IQ3NWlBR1iHlNZiqQL9V5uUSIm
         lImT/3XZWraZFaruS0Yrge8BylArCzFMsa/f6WMPELfEZ58NKCdq8lWcOz5lb5yzf0iP
         2FKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717688814; x=1718293614;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nxmDI3+vEBpOe0IOLGqBGRnkAHmKZ9+qj0SgsfXfWb4=;
        b=UyFZAjKb9ZQ9Rf5LcKeC/cDBJ3CMhI7EYvwsE65Kalx2uYxECpyIVpo4hHJal+b1Y+
         keWQljovTz1sRFZaD67/4bglnx0tbCPZXTIuWBegLbTUKAbEUpsFb9o+XtW2jqRDPras
         5NIEzFvaphi63nIK8vr3591+bETmPILJ7I0iO1OntkMWbe0u+4LVyD7/9/QHU+cX9SVk
         RTaaHV3axbxVeVufssJen5k73unrC52gSLJ6WjRVWvEKaDnKwKtt+U/BkS+5yjrVIoo3
         0A5uEbxLiAIUHcIffJRglnYYYCCFodtZmpQxBl5ds9JB1243wMDQGuu7+lV0eOVYdcI4
         ootQ==
X-Gm-Message-State: AOJu0YwS70NmzXoQBiAUStaABspR8ElZWZ6K5sve68J83mAg5AiySQC/
	YmQUn1V5Nex4xCd50QnV1f7xYcidYzulc5cFODfLIPOlXDqp0Kf2/uKDO5DOOCY6LMOZBOY1Ldy
	FLlg5YfLc1Q==
X-Google-Smtp-Source: AGHT+IGpvNV8P1+kMHzVDZZ8VN+XpVz2YANEkjHvZpRk1IpZz7Hpn3XQRchA8MfAB67qMmMnsbp8Q2ar4wfv+A==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:100a:b0:df7:6b9d:21fd with SMTP
 id 3f1490d57ef6-dfacacee4acmr281937276.8.1717688814012; Thu, 06 Jun 2024
 08:46:54 -0700 (PDT)
Date: Thu,  6 Jun 2024 15:46:51 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.1.467.gbab1589fc0-goog
Message-ID: <20240606154652.360331-1-edumazet@google.com>
Subject: [PATCH net] tcp: fix race in tcp_v6_syn_recv_sock()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

tcp_v6_syn_recv_sock() calls ip6_dst_store() before
inet_sk(newsk)->pinet6 has been set up.

This means ip6_dst_store() writes over the parent (listener)
np->dst_cookie.

This is racy because multiple threads could share the same
parent and their final np->dst_cookie could be wrong.

Move ip6_dst_store() call after inet_sk(newsk)->pinet6
has been changed and after the copy of parent ipv6_pinfo.

Fixes: e994b2f0fb92 ("tcp: do not lock listener to process SYN packets")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/tcp_ipv6.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 8c577b651bfcd2f94b45e339ed4a2b47e93ff17a..729faf8bd366ad25d093a4ae931fb46ebd45b79c 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1439,7 +1439,6 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
 	 */
 
 	newsk->sk_gso_type = SKB_GSO_TCPV6;
-	ip6_dst_store(newsk, dst, NULL, NULL);
 	inet6_sk_rx_dst_set(newsk, skb);
 
 	inet_sk(newsk)->pinet6 = tcp_inet6_sk(newsk);
@@ -1450,6 +1449,8 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
 
 	memcpy(newnp, np, sizeof(struct ipv6_pinfo));
 
+	ip6_dst_store(newsk, dst, NULL, NULL);
+
 	newsk->sk_v6_daddr = ireq->ir_v6_rmt_addr;
 	newnp->saddr = ireq->ir_v6_loc_addr;
 	newsk->sk_v6_rcv_saddr = ireq->ir_v6_loc_addr;
-- 
2.45.1.467.gbab1589fc0-goog


