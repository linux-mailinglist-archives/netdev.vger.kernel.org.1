Return-Path: <netdev+bounces-283736-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eOHCBkdQ+GmQsQIAu9opvQ
	(envelope-from <netdev+bounces-283736-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 09:52:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BFD74B9A93
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 09:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 14F663004276
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 07:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA3F30FC1D;
	Mon,  4 May 2026 07:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ic7VGKcz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204282E040D
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 07:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777881156; cv=none; b=tuGeEQMtJOlEhao3RyzoIAk5/OO8vdgMcrxdjGXxLkzwcNWmwrHH7AAi+wBvpJMhYAh4cTWARgVYOl8pUYVwACu+pCVCidonKk2Ls9+yNigVRCxsavTDvNJ8b0+QY7XxMj4LRqeerqD3pssFyF6AYLuBdkmy8LoYvuJsbu+7fg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777881156; c=relaxed/simple;
	bh=grBs00BfR7Dgf7lDiyN5qgf6vPiH1ATGim4nShDBzQ0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Up7hhsRytcQnzM49nPyF9eXknU6GCJFolvd+HZNSkDDfdaKi+q3iivil+JdQnIAM0OCUjXANa4ZKEa9H220Vy9Aw9zgHojkugf88P4hHj/D4yAh36tkf+6ZtvmFC7tui4qpfZGTYabi9fFVpMsrphTn25GvCcNc9/EuX2SNH1kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ic7VGKcz; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-b630b4d8d52so1638110a12.3
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 00:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777881154; x=1778485954; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LFTHSBhHCs776VEULE7S1mvel/jKgBzCStXoNW54Izk=;
        b=ic7VGKczrIqcuNLPtCx68pTMEgR4yjD5v/A9NZ1Ye8cCNC3X3y2pM14cMki3NXRb7M
         sCROtTghtPJWp/0tGb66EdR0j9k/I+v1vHpphqPtucMYBf35099yZp4I3S5P9k6CDnW2
         c8rasKbDB8vbbxAzCENeB9YtdVM9fQaq9wYFx3lZ/NMlyZ5eqJXFcyztuQvc8RbOpKBF
         AvOO50Loq+aY+8/pN5jxxXbILLRCiEii21GKb8IKaywZuG0uufiHPFMzdHQgW/8pQyk9
         UwEVj3BErWOlcb1g6Wlu+28ftpK75tP5zTZqgPY+AjiVpY7lQ197UCEt1lcvdND6Qu/o
         UfAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777881154; x=1778485954;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LFTHSBhHCs776VEULE7S1mvel/jKgBzCStXoNW54Izk=;
        b=OjoLI/M0Z8G2dCyu9KUCjNrO5NAdwnDSTPe8BnaTY4ohUj25EGVq66c/KFTU+waQo8
         canaHAW6ZYUoVHBv0ouUGTnn2VUDz0bhVWM/hFAS1VmX9xYBiuXUGYJKshn0X0cHlL4R
         c7KHhp2HsotMeL5rs/6XVncfj2qZa4o0vRkWUleu0Ud1/knTxuO81G5M+9LbLPentDO0
         j21JvZ7bRtkPZAjyUDEWREjWncOqNZnA+NcgUdyfmYOJqWuGeOOkDnFKrprvFu48Iksy
         2pg/fiNWKHMLvLssfWHhvA7joTlpi51uTaC9TB4ZpPNRFCUixSDeXxSB+9a9S+rRJ0Mm
         gDiQ==
X-Forwarded-Encrypted: i=1; AFNElJ9l/i+RqLkwwi7gabRjccLzbRWoBor3MY8aw+rcaGtojTgjvLsLP4rKIVXMmVeHozhS6Lbu3XY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCT7uXLvE9J9zM3Z6Owx+AIKJntcvptmedObkcbc3p270Aaql8
	RmR0Zpw2vyFBpWZR6X8iEW9NS46MignVARn4InPXW8HklOdPyltvzI0KR46/BJOhPrsjYo5AZZh
	wnWMW1Q==
X-Received: from pgbbe4.prod.google.com ([2002:a65:6e44:0:b0:c82:26d4:bb49])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6d8a:b0:3a2:e59a:7a46
 with SMTP id adf61e73a8af0-3a7f1ad06f8mr8848982637.24.1777881154263; Mon, 04
 May 2026 00:52:34 -0700 (PDT)
Date: Mon,  4 May 2026 07:52:19 +0000
In-Reply-To: <20260504072325.23474-1-eulgyukim@snu.ac.kr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260504072325.23474-1-eulgyukim@snu.ac.kr>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260504075232.3861715-1-kuniyu@google.com>
Subject: Re: [BUG] KASAN: slab-use-after-free in __sk_msg_recvmsg
From: Kuniyuki Iwashima <kuniyu@google.com>
To: eulgyukim@snu.ac.kr
Cc: bpf@vger.kernel.org, byoungyoung@snu.ac.kr, davem@davemloft.net, 
	edumazet@google.com, horms@kernel.org, jakub@cloudflare.com, 
	jjy600901@snu.ac.kr, john.fastabend@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 7BFD74B9A93
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,snu.ac.kr,davemloft.net,google.com,kernel.org,cloudflare.com,gmail.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-283736-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13]

From: Eulgyu Kim <eulgyukim@snu.ac.kr>
Date: Mon,  4 May 2026 16:23:25 +0900
> Hello,
> 
> We encountered a "KASAN: slab-use-after-free in __sk_msg_recvmsg"
> on kernel version v7.1.0-rc1.
> 
> As this issue was identified via fuzzing and we have limited background,
> we find it challenging to identify the exact root cause or propose a correct fix.
> Therefore, please consider the following analysis as a best-effort guess,
> which may still be incomplete or incorrect.
> 
> The issue is that sk_psock_peek_msg() only protects the list lookup; after it
> drops ingress_lock, the returned sk_msg can be concurrently consumed and freed
> by another recvmsg caller.
> 
> Following is the harmful sequence:
> 
> 1. Thread A calls recvmmsg() on the socket and reaches __sk_msg_recvmsg()
> through udp_bpf_recvmsg() -> sk_msg_recvmsg() -> __sk_msg_recvmsg().
> 
> 2. __sk_msg_recvmsg() calls sk_psock_peek_msg() and obtains msg_rx, the
> first struct sk_msg on psock->ingress_msg. The ingress_lock is dropped
> immediately after the peek.
> 
> 3. Thread A copies data to userspace and still holds local pointers to
> msg_rx and sge = sk_msg_elem(msg_rx, i), but has not yet updated
> sge->offset/sge->length or dequeued the message.
> 
> 4. Thread B concurrently calls recvmmsg() on the same socket.
> 
> 5. Because udp_bpf_recvmsg() does not hold a per-socket receive lock,

This reminds me that I forgot to respin this series.
https://lore.kernel.org/bpf/20260221233234.3814768-1-kuniyu@google.com/

I'll rebase and respin it.

