Return-Path: <netdev+bounces-259016-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4AFhOrpWlGnxCwIAu9opvQ
	(envelope-from <netdev+bounces-259016-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 12:53:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C61014BA08
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 12:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C67EC302B80C
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 11:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB3B335571;
	Tue, 17 Feb 2026 11:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HC6Ah31V";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="U7SRGoSs"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8347933508F
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 11:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771329178; cv=none; b=I1Sz4pp2hTulJCDsyeqg4i0OqLWLyop/IdKVowALeE0iQKiDVA7zQFNouyImzs4r1P/PJ178yMYO8GCAuhrwbwdfXN6eI2QfEbJ1tWVfcs3kSKrK39/LtQJrm3kh2SUY98XSuh21R7b0p6bAwQlIglPNaEMp3iqTetuvGQRnLF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771329178; c=relaxed/simple;
	bh=ER8QX+29neCE9t2GHfNO2d85s/NYfHvQ5IK6I4DYo+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GxMMKDp9LdhLhB7YJwjaQWE+S3P6TkUzFpBoXF0IQq2w8ZXXLaiHZAzv1YTGt7IBw5RFDznhKAU8kqk4KLsqU2f8urhuBT51Q2z+EflTGjl/LNG2znQh1VXZHR2QVq+48nHddhJ7H/WOx6rLfPkaxvKwkpeaOCP5Zi1uoqlBG7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HC6Ah31V; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=U7SRGoSs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771329176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZeZjW0ch267D5Cb5shXKk8QktbPL84wmInr+pQHHSrA=;
	b=HC6Ah31VUgCKE5K7nOMly7w5LkQ5XQAKlFQJ3dTWSEoyeOYYMfOTplt/S+kRTzW2eVX8nB
	ytVi4IV8/x5B0FEmJMp11NlZzAIcMYqpYKdB8GXL5aH51VeaLQczlq/yWzDLt4rb//pNul
	mar0jbmoLpdTi5+H0X4pDVK87pLWV20=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-SQLhNGdOPJe1Vw9VOkXdbA-1; Tue, 17 Feb 2026 06:52:55 -0500
X-MC-Unique: SQLhNGdOPJe1Vw9VOkXdbA-1
X-Mimecast-MFC-AGG-ID: SQLhNGdOPJe1Vw9VOkXdbA_1771329174
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-437812b8bb0so2622935f8f.3
        for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 03:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771329174; x=1771933974; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZeZjW0ch267D5Cb5shXKk8QktbPL84wmInr+pQHHSrA=;
        b=U7SRGoSsxLrra//FR0GMZsDOq8w5oql5ozFwezZmPvA0Vg0Nt3ImG9+J+vxoQjzgN/
         Dv9iZIJsPtSPTwV3h9tcnVZT9pHTvEk+em/ZFFoFMXSGSpI+k4N1VE131MXH6S+yOCAt
         IxBluMqmu0xRMVAQGemkZBZa7VBNHnZo5wzubM4b5ZUHpa2yjSXfwJRcxFMKfLYu/ahL
         qCro208bLaFc+tKnI3CFw78D/h9BPPxVTSCf7yKI9x3vjn3hQxH78OA15KTDGGBJ7SIX
         des4qgTKQ+SBZEFISMTEVZdNB3zYBLOMtuxL2/cFGrccJkMcdbgkl+EBgR5jMv4PMggL
         77rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771329174; x=1771933974;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZeZjW0ch267D5Cb5shXKk8QktbPL84wmInr+pQHHSrA=;
        b=uyAumNEnoNmAHsfor3CM0n05Ol3xmCidr4YU/FdVCznmxnn4Otq+DbedyjTGLceKMn
         eoqcq4GJNXx5eu7Q7zKqN1fZ6tON960bzGgoiWJDpq20PnCBMgZspTYunDu/EErxndGx
         RdBOFXTlRQ32jKVQTDNtxCT4uV6OkY2FdrKD4dtPzTmRhUSE8WQCJNW3UkKeaT7NelGP
         1jhyv0ccuaf3NyINYSBGp5JNmNYQDtXVHuk43NhPnqTqxQrq+1T9xN78R5qEnuSDttf8
         v0P4mjEPYumDnnkcoxkXIB1T5ZqOgb38RlU2KTKi0rbhyUXOYYhkDXnIYvhaSsD8T0tU
         PhaA==
X-Forwarded-Encrypted: i=1; AJvYcCU60BgWByptnH861T0uGUYdYv6QV+GBD81b8Sh1TYAMKmZeQsdYp/i+tq6khbF2TqfFLhEBEXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUx/FXmq4rPgZJU3mz2mlL2kbQ8ewSy14eOpAns9tFG3grgjr0
	hxSydpcn4iKntbXf4iHkrlJE/WQQ2sqZ6xIcx7ITRAgRhUf09KpoZdlf/C0YJOovvPiPXtUL1wV
	2KYNvDrlR4s6HumwBBEyfWKTd8/KMIF1kwPqz4s/8YCugnUWVvN2w2au5ZQ==
X-Gm-Gg: AZuq6aIWyFdzbkAw2b9+gCp+Ge7A+1p/GV/77/wX3gmQIhgR/YAfHDj+V4qmQnMLswh
	fk/pW3PQL9RX7SbW99IM950K4gXXPOC7FAhwsY1oLlJJyKEpbI8l3LM2+d+y+iGlMpnz+4vWyB+
	tGBuaw4tWhmBqC1Zj8bMuYXnmBdsHiE3wTJgdKJZMfXbcbJ37X0hkxWOlDY98sp3CfOeJDMVEBW
	S0CoewIyGfPO/U02c+Tg9Sg48QAGE0BeKx9TF4Y/DGDMMq0YZEhjq1V2rPr/hEcrNneMNT63UIl
	EhQyn3GwYTWYh5UaaRrkwNQ8lqR+PiLbtjoXpHi4JarCO+Q8K0+nuwz0AbIW4+XJd/R4dIEOT5P
	mn2WYpSrQNjj+HkNzCLKR60mpCg==
X-Received: by 2002:a05:6000:2585:b0:436:3475:473e with SMTP id ffacd0b85a97d-4379791ad09mr24193736f8f.51.1771329173983;
        Tue, 17 Feb 2026 03:52:53 -0800 (PST)
X-Received: by 2002:a05:6000:2585:b0:436:3475:473e with SMTP id ffacd0b85a97d-4379791ad09mr24193704f8f.51.1771329173517;
        Tue, 17 Feb 2026 03:52:53 -0800 (PST)
Received: from [192.168.88.32] ([169.155.232.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796ad015bsm35047046f8f.38.2026.02.17.03.52.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 03:52:52 -0800 (PST)
Message-ID: <404e29e1-a5b8-4d43-bde6-7409a8b00b57@redhat.com>
Date: Tue, 17 Feb 2026 12:52:51 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1] kcm: fix zero-frag skb in frag_list on partial
 sendmsg error
To: Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@shopee.com>,
 syzbot+52624bdfbf2746d37d70@syzkaller.appspotmail.com,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Michal Luczaj <mhal@rbox.co>, Sven Stegemann <sven@stegemann.de>,
 Christian Brauner <brauner@kernel.org>, Tom Herbert <tom@herbertland.com>,
 linux-kernel@vger.kernel.org
References: <20260213061232.338244-1-jiayuan.chen@linux.dev>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260213061232.338244-1-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259016-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev,52624bdfbf2746d37d70];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7C61014BA08
X-Rspamd-Action: no action

On 2/13/26 7:12 AM, Jiayuan Chen wrote:
> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> 
> Syzkaller reported a warning in kcm_write_msgs() when processing a
> message with a zero-fragment skb in the frag_list.
> 
> When kcm_sendmsg() fills MAX_SKB_FRAGS fragments in the current skb,
> it allocates a new skb (tskb) and links it into the frag_list before
> copying data. If the copy subsequently fails (e.g. -EFAULT from
> user memory), tskb remains in the frag_list with zero fragments:
> 
>   head skb (msg being assembled, NOT yet in sk_write_queue)
>   +-----------+
>   | frags[17] |  (MAX_SKB_FRAGS, all filled with data)
>   | frag_list-+--> tskb
>   +-----------+    +----------+
>                    | frags[0] |  (empty! copy failed before filling)
>                    +----------+
> 
> For SOCK_SEQPACKET with partial data already copied, the error path
> saves this message via partial_message for later completion. A
> subsequent zero-length write(fd, NULL, 0) implies MSG_EOR, which
> queues the message to sk_write_queue.

AI review noted that the above statement is dubious. Specifically,
looking it looks like that write(fd, NULL, 0) implies EOR for SOCK_DGRAM
packets:

	int eor = (sock->type == SOCK_DGRAM) ?
		  !(msg->msg_flags & MSG_MORE) : !!(msg->msg_flags & MSG_EOR);

I guess the changelog needs some clarification.

Thanks,

Paolo


