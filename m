Return-Path: <netdev+bounces-297831-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Nl9uM9/EKWoedAMAu9opvQ
	(envelope-from <netdev+bounces-297831-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 22:11:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C94CF66CB3B
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 22:11:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=UdbvUv5s;
	dkim=pass header.d=redhat.com header.s=google header.b=QkACF3Ky;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297831-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-297831-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 08B0C3001CDB
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 20:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3733E314E;
	Wed, 10 Jun 2026 20:11:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C721337DABE
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 20:10:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781122263; cv=none; b=LruXKu8AEgEIbHne1e/x5140Ps653ZG+PzUiI7OlTrlpsavZICJp20/h+nTHJXreg2a1HODyJqCWoT7ZuKfYXQ2ZwHuWOjlOvm5CV+/pGFbirQ6gtJfyoscChET+rVPJdpR5rQlkqtkHA+xCeUnOiWt9sZ2wSAP0Km+PRoFwvR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781122263; c=relaxed/simple;
	bh=g4RKJtX9XYeTrI+KiEMM5mprUDcxVsFdYk/GU3uHjBk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QzZA+0LxW+Z+6wlYFMxEgbuGSxRZanqPH1LCNgYFT3CVIyvfBdwwRGPQ4uzrRMu3Mktl2htwmNWpClP6PM22TilVcNAMxqy8cimePZPSvvuZBcGMFcmvBkvgQOCy+vOT7tt/3xKRp4OcrrSBJ75EZfujWVHJwYfKB+tnU2b0leA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UdbvUv5s; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QkACF3Ky; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781122254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/g30yy8CMr3x848UQxbESXFBbV3w2mdx/10RodQlp3A=;
	b=UdbvUv5sOuAEExC5XFEAp+R4SC29NKLgCKVlFfVAO8/KKbwHvjnEOHgd32q2GnUesOTpM8
	wNENkXKHJTsvFEkrMQeMF+vK3tWtwjzSMji0sJJh3B+2ZXjJy9OHaaIBNGCiKNckq/Av2Q
	ab0FjwTUxaZwPK2L+2gJ5LY/hoU1ZNc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-4JPyFEBsOJKpTlNaikUqjQ-1; Wed, 10 Jun 2026 16:10:53 -0400
X-MC-Unique: 4JPyFEBsOJKpTlNaikUqjQ-1
X-Mimecast-MFC-AGG-ID: 4JPyFEBsOJKpTlNaikUqjQ_1781122252
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-45efa7755faso2807672f8f.1
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 13:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781122252; x=1781727052; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/g30yy8CMr3x848UQxbESXFBbV3w2mdx/10RodQlp3A=;
        b=QkACF3Kyvnb1zyypnd5ZxszE6mgfa4H0ifa071S3q6U53nFUm931EPGmLlS0JZwEtY
         McIWdz0YYfB5Jzh6IjcdRMfkUtnqm458QrxeXhXW4wkbYL8sdoFY+SWuOL2kYfANj+m5
         ALZWmz0HIQ0nign6jg1K0umV5G1LtqtHMlrl+Guk72tJ9H/l1ESvAa3TBHXXcxWxoR2x
         cJU7uQTZSncMmwQQuCx7euOO1ZVmohIGLxa3yDvm+RePzTi2szkz6na2oYtqvfQTWyOu
         JevMvjA9DYGjo4vEK1YLYtp3T0xhnENH40f23w9btixBJXZrl+z/esKISIYJDgD3IgSR
         ePzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781122252; x=1781727052;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/g30yy8CMr3x848UQxbESXFBbV3w2mdx/10RodQlp3A=;
        b=OfPAwWuyYerCHO7g781vtQuVjISQlHww9ajsRQxquIqLx/bS+q/UTTfpeF/tzMwUbJ
         kJlPpG28fr0JAHAiCSG00++p4HjAvzcKp8kcF9LNuyfg1DEv8h5BQNG5F46zRWHuPfRb
         BC+3lfwZhNIuu7JaFMFfRzV4WEtosyD7rLmYGABHAak1Gzfin3bXo4RmYKfJ6CAlm2tZ
         12SA9kKzZNKr6Bc1FE2MIkbw4hrrPCYOMQG6R85se/DsGJRJ/gJ8K0b9eOL4Xhb2NH19
         9tbyy+2X1wM5bIisVNZue/gxQfYs4QTB11fXRuWu8UV33yFBECjaHX4KQXsuWS/ljz8/
         AIuw==
X-Forwarded-Encrypted: i=1; AFNElJ8XQXyWPnM30pbz10KgJfRYUdNPMEm8TP6Z3xac3UTWm3AhzIWWzcsXHMP52sOk65D3jsx191A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZouRkaG5zI1sZxsNIxA/vQtAhNUPFenL57hTasISUXEVZK8yb
	qql94e18BYKz7CIfUBZgf4NJELPRC1aEUFTCzJqjV0hwiIasJZg3OuFjEqAOtGyiq8X0Lc8exxi
	/imuKGNOwk91xQy/j/fh5XmWvqXzSdtKi6Z36i5HsUI0hCOtnbPGra9SI/w==
X-Gm-Gg: Acq92OFTJibHMpmtE9Ed6fDwCsKsFfuRCrNRCx8LgmIenr0hj+9RO4PqR9yr53lyTpQ
	Ed9mW+wzpFFL9fl0Vk67JQ1Sl87PTrxFzWeGnAQqwiBc4DWAzd7ex4jlx51BZULla8bm6Q+UTRX
	dQj2AcVPeNThd9Xml0iyQPbmtv9tJZ41uM4hPYzaARGbdbIkTshfzd/6uwDGaxLlfiCBPKb6l5U
	q52Ybg0XvA6+tKS/nn0FO5+wyfwoyOyYCok+YVfCStIIZz7ZumcrxidcpAg1Fo5n9lYbWyGGcLX
	hA3fP/y12URoECN5/wxbqi/760puRJefYtsNAlFcB0uxQvOMSk3VT7j/SezZu+0aKAZ0Ts749GA
	0T+JSyEBA/xvLZKmY3iYov6WH7DNi2P57pdoqx+eilXyCkMURdpt2OsdK9Dw6kr5+QA==
X-Received: by 2002:a5d:480a:0:b0:45e:f5b6:7bf9 with SMTP id ffacd0b85a97d-46030627a04mr27765830f8f.31.1781122251993;
        Wed, 10 Jun 2026 13:10:51 -0700 (PDT)
X-Received: by 2002:a5d:480a:0:b0:45e:f5b6:7bf9 with SMTP id ffacd0b85a97d-46030627a04mr27765813f8f.31.1781122251632;
        Wed, 10 Jun 2026 13:10:51 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f345209sm79926955f8f.17.2026.06.10.13.10.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 13:10:50 -0700 (PDT)
Message-ID: <f926259d-4612-44d2-9711-4a408e41e7f6@redhat.com>
Date: Wed, 10 Jun 2026 22:10:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/10] tcp: support non-GSO jumbograms
To: Mariusz Klimek <maklimek97@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, dsahern@kernel.org,
 idosch@nvidia.com, ncardwell@google.com, shuah@kernel.org,
 kuniyu@google.com, alice@isovalent.com, Jakub Kicinski <kuba@kernel.org>
References: <20260608130755.5626-1-maklimek97@gmail.com>
 <CANn89iLjG0krEoEE__3KUrcK+ZO+USZRC_2qZV5hAsxRpkTmhw@mail.gmail.com>
 <715cf429-9f2b-4898-84b4-15dfba4a9a8e@gmail.com>
 <20260609152704.2512ce9d@kernel.org>
 <85eaf82a-28bf-4d3d-958d-1225a7ae9608@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <85eaf82a-28bf-4d3d-958d-1225a7ae9608@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-297831-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:maklimek97@gmail.com,m:edumazet@google.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:dsahern@kernel.org,m:idosch@nvidia.com,m:ncardwell@google.com,m:shuah@kernel.org,m:kuniyu@google.com,m:alice@isovalent.com,m:kuba@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C94CF66CB3B

On 6/10/26 4:16 PM, Mariusz Klimek wrote:
> On 6/10/26 00:27, Jakub Kicinski wrote:
>> On Tue, 9 Jun 2026 19:01:02 +0200 Mariusz Klimek wrote:
>>> I understand your concerns and they're reasonable. I would still like to
>>> proceed with this series, though. What can I do for you to consider this
>>> series? Would it help to submit a few less-significant patches first before
>>> resubmitting this patch series? Should I resubmit it as an RFC?
>>
>> AI tools changed how much we value code, but they did not change much
>> about how one joins a community.
> 
> OK, I'll start with smaller patches to establish myself more
> in the community. I am still interested in eventually getting this
> series through as it can speed up workloads relevant to our company.
> Do you think this patch could potentially be considered down the line?

If you are strongly motivated to do progresses in this area, one thing
you could look at is the root cause of the performance difference
between the veth jumbogram and the same size veth big tcp test: I'm
quite surprised some delta is visible there.

Possibly perf can outline some bottle-neck in the big tcp path that
could be ironed-out.

Also it could be interesting if some devices could do H/W GRO based big TCP.

/P


