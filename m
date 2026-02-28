Return-Path: <netdev+bounces-262205-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FRlL49Mo2nW/AQAu9opvQ
	(envelope-from <netdev+bounces-262205-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 21:14:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2D71C8112
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 21:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3D6D830CEE7B
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 20:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A659623ABA9;
	Sat, 28 Feb 2026 19:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xn6DVk+D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA2D299943
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 19:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772307918; cv=none; b=eWjD2ydKWmbgNVjqo2FcIUwUqWPtaPvUuo4xydaXTm32XagJdyp0I3/XG3MG+rsNzw9BxvQnGdNm4bS7II0QPob6f9zit5Gd3txGqL2BjGn3vCi9SgbOYJnXikQLwmkulWFe52etY+BnXzPf9PXP+Pwk7MbdTBK/Lbrp4qucQ2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772307918; c=relaxed/simple;
	bh=wShkixN3RrZ9m0jhY+mFt79u+Y0ZNz4eQXdILnL245w=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=odwf6iDlr2fc4UKE4ZLprVjq+YxhnEw7qJxUjcZ/2Om1SrE27zwYlK8i52CzFM9hcO69Kfo2Ly5bteTovpMkvCyiU2HRs6pYhh7VWbQChIo6q9IoDh7+xuZ1bQu1uM9QDVZqAaFnqcN277ocR/5ENowavl13qfa3k1zbcfe6CoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xn6DVk+D; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-79854193a54so29812397b3.3
        for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 11:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772307916; x=1772912716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NMgswTwoYmJQYEHmD/5vFQ/QuDvyjcVszylXcsWK9LQ=;
        b=Xn6DVk+DrilwCPhd/yZ5h6FHyFC83nZnmxxehvO9cNebyKKOMraGCjMhFczDM46J1b
         +aThxuuBtpGgDhtuidh02Z6nD99h7dqhRkoKfqYzB4BZ9SMcRMbK0dlNiEzb+Halzcfl
         VgSjLVZW6xMe31MgdevW+j7+MfZ50+0x3a08ebJc4UH26Z0rSZEWcYUuEGy8J22ntbfm
         87cm15NfWX9jgYY3rzGXb/mn9lK3/cMUGEEUp/H8ZMtxG5YEzAc/yJi1IjivOUIDhuwm
         U8VeL1Lkdc0tCHBUQ2Mj5J28IXhNUk2tHq8X0iv3URPmMtaZI/uO3Fts2E6YjzAZONqk
         7LgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772307916; x=1772912716;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NMgswTwoYmJQYEHmD/5vFQ/QuDvyjcVszylXcsWK9LQ=;
        b=UIybJC074PlefozmfOYVoH6hrMIWik8LVShQgqQzDBjfNVgkMSrqBwdQzROhZKsemx
         Ta7mO4cex1a0ErUgSrP3JYieBYTeDq71+tGmBM9vXztxWKwj7h6uVJgvlYEwvSxhkIeA
         GoEzzRdrv4FdPgmPtscfLPnA+ZSP6+7A+kOakFRYF4cFTkRqYZX81FM7dOx8J/kW1K5a
         rCmn5/Rvcu9ictHxg5lxPSU0aaKHsj63AYr7ZqaPQN02e+quZ8ooaWdSgioEtYCc974g
         2HBWC7aBC4yMwCpdqhE39M+mwfEYDQWDZSmJQWaSOcuh9i5PtqF+ZmUayPZ8RTUx68Vq
         LekA==
X-Forwarded-Encrypted: i=1; AJvYcCXDDQ3AcRQWHTUvvLGcVO9ADWiyc9leiaG2GqIIvrKJf4Th1U9FUdD9DWYlyzvwVVQJvmBDZPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcGL/2q7Q+LhddiHy7LadQuUWuFVWBWNC69Xe8rNcLIl/6tt1h
	2+d0d9BM+4hlrbH+n7bOrxgRQtgGtF7KhLHpjEIv2LRSXNGHYB0qjWv1
X-Gm-Gg: ATEYQzztiCn8bTsW21a+be+Kr/AoqxiLc1/wswaspOI+RRkQzyiAArvRKdK0e9jrNJp
	cKaBmTcBfJRhUPRDSd7rt+6rAdJi98fxzIcWAsmYB8ajwFhQ20GVkV+y5lohde8azXMrnzB/4wC
	6j0yKwhVS65QaZNdTwEv7/FWfj2eZkOQpgBWVjuCjz5LB/3LgLCO9EHhPfvBHbx8trqVSY0dHRr
	jk9kr75vk8rLzFqF8HNeilrK9pk8ivtxOoMJWzGJDHvq6mjFOnoZCSKcs1/zjjz71I1xLspY9vc
	IV4t3nAqt1nGEJU6pT8z/qKCSeCPHANVXHn5w4rm2iujwEAFAjnzACII3cCQR4mNMxtriB9A+Me
	Wi7mXr2diD+0ErieuGjij/1RC7X36EEuVs1Cz9OsCMBiWfkkRD59AwAgk4zeF7sgcBdQdLjBhGm
	4kc22/TkVfrxm8F6eHZMCs+HSiS+E3j7/ckrS/5W1fEqhDWAX92pbG6D9PjBMZve7w55FZElk=
X-Received: by 2002:a05:690c:45c7:b0:796:6df5:485a with SMTP id 00721157ae682-7988557fadfmr67402677b3.39.1772307915941;
        Sat, 28 Feb 2026 11:45:15 -0800 (PST)
Received: from gmail.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-79876c862e5sm33917687b3.44.2026.02.28.11.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 11:45:14 -0800 (PST)
Date: Sat, 28 Feb 2026 14:45:14 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>
Message-ID: <willemdebruijn.kernel.c2907dab717@gmail.com>
In-Reply-To: <20260227151120.1346573-1-edumazet@google.com>
References: <20260227151120.1346573-1-edumazet@google.com>
Subject: Re: [PATCH net-next] net: remove addr_len argument of recvmsg()
 handlers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-262205-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9F2D71C8112
X-Rspamd-Action: no action

Eric Dumazet wrote:
> Use msg->msg_namelen as a place holder instead of a
> temporary variable, notably in inet[6]_recvmsg().
> 
> This removes stack canaries and allows tail-calls.
> 
> $ scripts/bloat-o-meter -t vmlinux.old vmlinux
> add/remove: 0/0 grow/shrink: 2/19 up/down: 26/-532 (-506)
> Function                                     old     new   delta
> rawv6_recvmsg                                744     767     +23
> vsock_dgram_recvmsg                           55      58      +3
> vsock_connectible_recvmsg                     50      47      -3
> unix_stream_recvmsg                          161     158      -3
> unix_seqpacket_recvmsg                        62      59      -3
> unix_dgram_recvmsg                            42      39      -3
> tcp_recvmsg                                  546     543      -3
> mptcp_recvmsg                               1568    1565      -3
> ping_recvmsg                                 806     800      -6
> tcp_bpf_recvmsg_parser                       983     974      -9
> ip_recv_error                                588     576     -12
> ipv6_recv_rxpmtu                             442     428     -14
> udp_recvmsg                                 1243    1224     -19
> ipv6_recv_error                             1046    1024     -22
> udpv6_recvmsg                               1487    1461     -26
> raw_recvmsg                                  465     437     -28
> udp_bpf_recvmsg                             1027     984     -43
> sock_common_recvmsg                          103      27     -76
> inet_recvmsg                                 257     175     -82
> inet6_recvmsg                                257     175     -82
> tcp_bpf_recvmsg                              663     568     -95
> Total: Before=25143834, After=25143328, chg -0.00%
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

