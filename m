Return-Path: <netdev+bounces-229097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFB4BD825C
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 10:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A072E4E6013
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 08:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5642130F551;
	Tue, 14 Oct 2025 08:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hi9Yr3C+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4B830F80A
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 08:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760430179; cv=none; b=F9tbZTKfoKTko/9xeJFB7mzkEZrV5phqUtsJMdL/cpst1L2HCnjHxzcSGBGf0fwCT8Msw8VY6H7MEC/xecnI4Iw1kY1W/51mKtod8/bqHX3tsoOAOdMzzIL7NY4Zh23A+7LtfxG3epfQzZl1CaPqgmlRWD5Jo6mO8t+ymzz7fps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760430179; c=relaxed/simple;
	bh=4EKrzlp6QvWX+dE/li647TgviB8zrWPvo7iEZzKJKdI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uvuxK9wU7oZ2cy/m+RZG3RCNnTlWrtMFxpC30QPhuFyKGnCg1NG2Zm7RzxgRq+7UUTxrwgzYoOAABfFB4vpjapBbw1c42PiNjx2AfnF+7TkeWFclanxZkWE96QyxY5rvkqFts42jEkiI1BHFtxhTQys4fLqbUT2DWmHDDyCH9/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hi9Yr3C+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760430176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P52xe9Rb8u/mLQLB0OIgkV9Czqpb0KvmrW9i8oh84hs=;
	b=Hi9Yr3C+pQNLJ9QCoeU9myjwEu0UQK2HbX35m8ATRhSiBAeZHl6maNO3vbLXgyvEE6sDF6
	GfS/MUt/qCX95nuhbBPckjL8NlozmUvQSYANz7kwdOAu+rY16MTfiVs6+V7Ih/3ZCm3SAu
	AG8WvaCGTPP0Qr8huIG7c2KS7QDIXDA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-ckcKUNG1NBq9PUtnvIeO0g-1; Tue, 14 Oct 2025 04:22:55 -0400
X-MC-Unique: ckcKUNG1NBq9PUtnvIeO0g-1
X-Mimecast-MFC-AGG-ID: ckcKUNG1NBq9PUtnvIeO0g_1760430174
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-426c4d733c4so2415737f8f.3
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 01:22:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760430174; x=1761034974;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P52xe9Rb8u/mLQLB0OIgkV9Czqpb0KvmrW9i8oh84hs=;
        b=Rdo9gDmuG3Rm7nu+aPIuIRYvJRibF5yFTyuC2Ro73DsxuG537pNf3TewyA9SSvePOR
         M/WNiZBza0Cb+NwoWsVx9qDVj8cnROM+H7ih8uua0g3taNW5z1V59IInoVUOsY1/uNiN
         +hrAXwIzzLtLCBg/95sUSfk+2TCTepFuy32Lr+DzFLcmk84mZAupBc+X5iOg9WWj656F
         SfdS0nUB0S2jdUkREL51rasvTGc+frJ+ImFv6sPi+n5NvImBuHeG1z7+3AP1tSI6ePWk
         chT53b+clmzXCXxyVGUUvOUjXeSnP7urp44LtGArc6moedcFvsy39IyGVybrV3uLZ5Sv
         pDYA==
X-Forwarded-Encrypted: i=1; AJvYcCXb5QcamwEtUesXhGhqclBlwvrle/yJydUQZgaFKqQRJA1Qqiakv0/JPNtm8D9mRoaAdITTcig=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUdWux2ESYZ5guu0CNWvLBx750Fo5w6B77eSTocZI/xP7mbcy8
	4GB/0Hyd2Idk1AJoChmq6/KbvfJccD/DSI1H0jkUwffxPQP93FUFFqluBVIjZNpmpVe1zJbu+KM
	pQr65ZWzoLiKmjMxrUhiP7aXkMa6ziwjCHrqdHbfk95Mqd/YfVyU7wffI9g==
X-Gm-Gg: ASbGncs+xIXgHMQ7lMSantAmCR/Nch0cOyX++y/In1jHj1mhGC2gxfaQi3x4H54Ao9m
	vOkM0aQd7OmullwiEH1hsjiV8RJkZr4knNDxLzaFBqw/9V4I+UYB6hARmwbD8j7zzUvm3qSnekq
	glQ+4hQSR1Ud2WBJxc2mghPdz5cCMcJXOu7svY41wFSztT/N4tU2gXjYzEsQXvEH9Y5fQ3j7aIp
	s4uTOf/MtR7apiNJgSwmateHt5xciK4BK5mk531YmFrZcCx3ZW0lOplti1Ai23/WPqn14yA9Wip
	l2aXEMaNs4A0hhQPchXOzZF7LfuKSbqtt+E2cAIeG40oOb3fVypYDuFYhYUPJePFng6iyvi/Jco
	tYu+WrvMxTvl1
X-Received: by 2002:a05:6000:659:10b0:426:d82f:889e with SMTP id ffacd0b85a97d-426d82f88cbmr5929636f8f.14.1760430173737;
        Tue, 14 Oct 2025 01:22:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZs37BApR0jtUa3R8djhpdlOGxhuGVzgIqD259uiDvu/KLL4zck+hCeKxlaoJMt/6nu6nrgA==
X-Received: by 2002:a05:6000:659:10b0:426:d82f:889e with SMTP id ffacd0b85a97d-426d82f88cbmr5929626f8f.14.1760430173364;
        Tue, 14 Oct 2025 01:22:53 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb497aea6sm228458425e9.4.2025.10.14.01.22.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Oct 2025 01:22:52 -0700 (PDT)
Message-ID: <3b20bfde-1a99-4018-a8d9-bb7323b33285@redhat.com>
Date: Tue, 14 Oct 2025 10:22:51 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] tcp: better handle TCP_TX_DELAY on established
 flows
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>,
 Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima
 <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20251013145926.833198-1-edumazet@google.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251013145926.833198-1-edumazet@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/13/25 4:59 PM, Eric Dumazet wrote:
> Some applications uses TCP_TX_DELAY socket option after TCP flow
> is established.
> 
> Some metrics need to be updated, otherwise TCP might take time to
> adapt to the new (emulated) RTT.
> 
> This patch adjusts tp->srtt_us, tp->rtt_min, icsk_rto
> and sk->sk_pacing_rate.
> 
> This is best effort, and for instance icsk_rto is reset
> without taking backoff into account.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

The CI is consistently reporting pktdrill failures on top of this patch:

# selftests: net/packetdrill: tcp_user_timeout_user-timeout-probe.pkt
# TAP version 13
# 1..2
# tcp_user_timeout_user-timeout-probe.pkt:35: error in Python code
# Traceback (most recent call last):
#   File "/tmp/code_T7S7S4", line 202, in <module>
#     assert tcpi_probes == 6, tcpi_probes; \
# AssertionError: 0
# tcp_user_timeout_user-timeout-probe.pkt: error executing code:
'python3' returned non-zero status 1

To be accurate, the patches batch under tests also includes:

https://patchwork.kernel.org/project/netdevbpf/list/?series=1010780

but the latter looks even more unlikely to cause the reported issues?!?

Tentatively setting this patch to changes request, to for CI's sake.

/P


