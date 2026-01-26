Return-Path: <netdev+bounces-253361-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCSqB2sjd2mZcgEAu9opvQ
	(envelope-from <netdev+bounces-253361-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 09:18:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DF785670
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 09:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 92D0F300DA78
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 08:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9BB29E0F8;
	Mon, 26 Jan 2026 08:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q0ofuWgv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="RuI0pI7Y"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0852765F8
	for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 08:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769415509; cv=none; b=fJEIoJMdYxp1d/qw5bm13/Yvl5OajVnwtP6YM/KwqF0OMjsdC/yHP4U9Qfv6azEZnaQ5AcZnpNtwPsuQaZuMwhJ2ns4uwfv1oe2/0CLrNIE67IR2ZWkB9/V+K+IeXTfBcw8OJc5ZGF7GNpTZ0QApRT0paGrz7w4247XoGGlSYAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769415509; c=relaxed/simple;
	bh=DKafQET6VHvgKdQ2xS5R2djl5aeMeZJYXkq+Ux/fFSA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I/Pi3qFxjlRHWqWAhBRlVke56IjwgfjCuyq3bg/M/IkJjjRXmWxjtUn/R4KCF1gb52pDYSLAwXVCDIA2c9CIh6qpnTx5kP5fLpIKCeZ7XKbUApBgAGZAYxE81slNi0H08tBoL+izxqVcEHy/kCt6qvmg4QfPesMIa571gGTJxO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q0ofuWgv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=RuI0pI7Y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769415507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=65n+X3UOPS9Pw2GVgi+j91Mtiyejj+FB56DpILdmAjA=;
	b=Q0ofuWgv6bHKlFh5puTFYp2upd0KXvREtWcZQfyKS7zy6vuqR26sEb0sGDTT/05iKeK84s
	ehiqUnUDVaOTT/VW1YsbH6McpSRzhX1vlFVh2lh0u90itQwpXB/pbrnLCz+EfKwZwuPtpF
	abpERBpQWJWr/Xei72VASBF+7E0rIDU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-9vXdFnwAMmCVLyh5wZLX5Q-1; Mon, 26 Jan 2026 03:18:25 -0500
X-MC-Unique: 9vXdFnwAMmCVLyh5wZLX5Q-1
X-Mimecast-MFC-AGG-ID: 9vXdFnwAMmCVLyh5wZLX5Q_1769415504
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-42fdbba545fso3916426f8f.0
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 00:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769415504; x=1770020304; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=65n+X3UOPS9Pw2GVgi+j91Mtiyejj+FB56DpILdmAjA=;
        b=RuI0pI7YoSDlQgnWVIztY8i7xHUQEhd6G53WpQWB+ZK3txlqnTGRHjIanDqGW4wYbQ
         rbsyTJN6UwrdvHGEryfLrS0+KjIzXj6PGtZeju/h+6q3tOLs5FOHLDyxtA6TIVZU9T9j
         jf6j+k993CVwrjjHm7uxViekAf56mlcCQM6+qdVUzvzAwuqgu1CS/2CxPgxZPjrQ1wkf
         gxqDYLddyqfflTgkoj2+8sRDR7/43XXOIU1ZGvmBosDlmVO6rhl13oeBHf12PWoq2NWb
         qQ+A29+NMJFTIi96NHR83b2T7117Ne1SEVT/OOsjfinYOzOVyEHpu9O/M5XWYbEkjF8U
         I+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769415504; x=1770020304;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=65n+X3UOPS9Pw2GVgi+j91Mtiyejj+FB56DpILdmAjA=;
        b=nIy/L48JuWUsPNVL3DAypf3ViVIzE7qn8qY5p5QNRzrDs6braElAsH6nK2XSkVYUY1
         jBpHA9Csxdk+bOkKkdGXT6l8OzO+5l2x9DquM05//0n9m+FI0ZkppCbPk8xdsEVmXVom
         wwcAZu1HDHhHjlwREPEXDLALdebOeMT6k3d0xqsNJyENIiBk1QkVRGH1TmUxaVbMj0AM
         O7G2TXQmpUV4cm6SbJQd2UlFAFn7UqWRzn2Kwfc9seEKG1HYOwJ7hCkMlRfjfgH5yui7
         cJyzb/u6Gmmt8ZWgEmGcz6pTfxhIA0mOqhpJiUqpYgXlsVWmtHh6cn+ViGYZZA8Ap+pd
         hfOw==
X-Forwarded-Encrypted: i=1; AJvYcCV5E/sbitmF0cfPtP6CjjkSeYUtnYBx7YoB4YUwg63FBg3tRFyy8PPI9Usj0EStohIeyvhNUbY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1xqWLhyBNWg8mNqAE9H+w0sCPyGddqAWsdqdrgVcSeB4d5hzv
	eJU2yhnTWLkQ85ZgZhHJ6KUtPjxfPxcLLK+Y8J0UfoPcXEDEFJpbMFombinjITpoUsqK6zDW0+W
	/NH78iHeLYwGFOGUBGMhRYDWYymwvGAEYoww19gNr2m8tE8a8XNReDEZ6/A==
X-Gm-Gg: AZuq6aKzaswCrbUZbErarzGBtISTKSa9oWkSCdI/grGs70uKEB5mQarI1F2p+ul8553
	AOV/+uFdKJ/+QWaYBtCRtKpIhARqEozwYiJZf/yv/cLmLGOlCMOo7lGAGvcT5WJW9VdCF5+EylE
	67Wqu9O2Jxto+Im4J0SUzXzobY8njOwFsUq49ZLRhV31O9NglUEKLu6li++eUjnDLP4oVXj/NSh
	p8Uz2w34/c5NQj2JRtJCXIgsvx2lo1H0ZGG79hmAQ5eIt7LAMbjp1WUWy2R/tSGD9lJqGHNZPHT
	ve8brN01X4YmMeqG9pZRwkY0T5lA5Pavmj0/dMMRme5op/L5jvmnvrAraR8fEgMOKOsO26Q3cXo
	cumMaKKEcHZo=
X-Received: by 2002:a05:600c:8012:b0:480:4a90:1afd with SMTP id 5b1f17b1804b1-4805cc9fe07mr61971075e9.0.1769415503856;
        Mon, 26 Jan 2026 00:18:23 -0800 (PST)
X-Received: by 2002:a05:600c:8012:b0:480:4a90:1afd with SMTP id 5b1f17b1804b1-4805cc9fe07mr61970735e9.0.1769415503372;
        Mon, 26 Jan 2026 00:18:23 -0800 (PST)
Received: from [192.168.88.32] ([150.228.25.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c02f71sm28665069f8f.6.2026.01.26.00.18.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jan 2026 00:18:22 -0800 (PST)
Message-ID: <ebb3a731-a3ec-444e-8efe-aa13cb76adad@redhat.com>
Date: Mon, 26 Jan 2026 09:18:18 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] tcp: move sk_forced_mem_schedule() to tcp.c
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, Neal Cardwell <ncardwell@google.com>
References: <20260123111605.4089200-1-edumazet@google.com>
 <CADVnQyktV_z9=SoT7yhkT6mBQKRjaJgpwLhR2SdWGQS3iKD3Tw@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CADVnQyktV_z9=SoT7yhkT6mBQKRjaJgpwLhR2SdWGQS3iKD3Tw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-253361-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 74DF785670
X-Rspamd-Action: no action

Hi Eric,

On Fri, Jan 23, 2026 at 6:16 AM Eric Dumazet <edumazet@google.com> wrote:
> TCP fast path can (auto)inline this helper, instead
 of (auto)inling it from tcp_send_fin().
>
>> No change of overall code size, but tcp_sendmsg() is faster.
>
> $ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
> add/remove: 0/0 grow/shrink: 1/1 up/down: 141/-140 (1)
> Function                                     old     new   delta
> tcp_stream_alloc_skb                         216     357    +141
> tcp_send_fin                                 688     548    -140
> Total: Before=22236729, After=22236730, chg +0.00%
>
> BTW, we might change tcp_send_fin() to use tcp_stream_alloc_skb().
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

I've a question out of sheer curiosity: are you using some specific tool
to look for inline opportunity, or "just" careful code and/or objdump
analysis?

Thanks,

Paolo


