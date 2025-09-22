Return-Path: <netdev+bounces-225180-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F76B8FC00
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 11:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EECA7A99B9
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 09:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE42283CBE;
	Mon, 22 Sep 2025 09:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YhoBFVz3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D33412C544
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 09:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758533285; cv=none; b=SsCPXuXTtU8AQjTyjpAZZraEct+4Wvvf142DCEN9LX0+58RL8WX7Zbg0LWwoeuz61tKgW55UOTIOF2J9Wuky9jCgJA0aN/GOip7kJsftTr9bGI+0j6AgqRseyRGppOEDuQOZ6qxqn7qTPbpsmlA+8RA8LFvCNLGW5BAahTYv8jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758533285; c=relaxed/simple;
	bh=5fXLoftLCviEXnxgjBnGJZc6vh5gu8tfIDFcqvm02/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DiCvzXQYtCcfY1A0A7W13YLG1EB3Mo7o9ZA+lj/Muo55Lo54dHkuIbjlNApiyF9kiU6+SZiW+1OiJKPpdbNDBAW02cq8Jo4Bt8XxYDk8iBE2jCKvfRhBtYsh7/7OyCe+6dYXh2Ipu8dm7HBGAiSPoUj+Qrhn1ZbMFCvXTz4Y7qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YhoBFVz3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758533283;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=trUnn3OQJnU4gj29shzujzRd11E4+dTt5a5hS3ZVwPg=;
	b=YhoBFVz39+/p4R2qaGrg/6pSDSOoPoojCxinCaYaxi+EiCWQkC6ivjXCzyPy1Ue3O0xCN4
	RiqM/HL5sp+pshQblvq/448d9fp1fBHjRtGncdDeTuM8cB+vnmOGCDSmQ4MPWgf7zLdIdW
	Xr4MjJt+EqwiWD1+p4yMOlG2mukSqjQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-Ls5zeBeMPFCt_-hHJNkLkw-1; Mon, 22 Sep 2025 05:28:02 -0400
X-MC-Unique: Ls5zeBeMPFCt_-hHJNkLkw-1
X-Mimecast-MFC-AGG-ID: Ls5zeBeMPFCt_-hHJNkLkw_1758533281
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3ecdc9dbc5fso2585057f8f.1
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 02:28:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758533281; x=1759138081;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=trUnn3OQJnU4gj29shzujzRd11E4+dTt5a5hS3ZVwPg=;
        b=Q4lWJmGFXnhGRn4YQQgSM0ic3QBjZc+x9tkjHFt2WL6KzgN4HeebdomHD0oMdACkza
         foICJj5skizbEMV7pq/PFs7O6QoVd/0Q1D1GUt8nuZaVMVlzQEt1Rl/Vudh0REKgYnVb
         I5cM2UfckkOypoN0wrVTJyWxBPkyR8XbYhyq4RCCOGcJM4ENlkcoXOr/V8y6678/DmIN
         fonArLbSY+5lX5JuDWjNb/n99aXkB4XKTCEgj02iJG49Ofh1b9uCM7HS2kHtMpJbNE/d
         ET9H/woyj4IFXqtrfrL2JPcRJbgUjZKPnY49ShUfRa+Z2quVqXXBMnr79sp5CFjgdvUE
         NwEA==
X-Forwarded-Encrypted: i=1; AJvYcCUIqv/qZYaEAUq2aSaBHVmo+/jFnwsphey3T0fzw6k9zgr1Ic+BdAnpFHXqFOPGrVQ6vPVYZcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTK9vBxS4paYS7uwCj1jDkYKKdMrzQizvjUfwL6E8aGJDHSyiP
	PaMZ9A0JOPk3DYE7Yp/gL8zCWCoiayD0Uemk4K+Ifg+vt/EAViWdN8WkjsJQnPwfJ8yvIe4+JOl
	HEBZBdR+YcFUYDEJd6rhTGKXUwefuG3yikpnxD80f9dP4OF3OZ1V7JuzFVg==
X-Gm-Gg: ASbGncs3m0c743qMBQUo8iRAFfJt5FKB1yqLlj05nR3xwZ1OE5+7nglKJ3n3r8t5b6E
	4ArmBfo6l1tL1tTlzbVHwsqE7YgXgu29BVG16412o9XP9FHuH5me4fmEAlRFY8WGvnxpLCjV6eS
	zDQza1ob+QL5XXulBs4NCB0mtPC9INkwBUO0eLcvK+igmhFZIV6qMd3tcdXHBsTuoRu912yN5Wb
	LU/aEqMaiQ+8EEHF2P1ZmiYMJKJ1yLbPo75nzucW3de3DBep24bxCRqGOCTxIhNHu8st8otxazO
	ufDsZuC99RcqX6QjQhqrT3k+ufmrvvydLWmJoEkdcJZQ/rVNpfkhdHUQywTpnPnpW+z11h4ZOSI
	zJC1qWhUMxnPP
X-Received: by 2002:a05:6000:2209:b0:3eb:4e88:55e with SMTP id ffacd0b85a97d-3ee84afd2f2mr8883259f8f.41.1758533280886;
        Mon, 22 Sep 2025 02:28:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbtUwsRLUrgNhivT9mWNQVVeNMPa/w8zWHXg6eflGdFpHS/jANjUIDznOq404Z+xXKgqU+NA==
X-Received: by 2002:a05:6000:2209:b0:3eb:4e88:55e with SMTP id ffacd0b85a97d-3ee84afd2f2mr8883238f8f.41.1758533280490;
        Mon, 22 Sep 2025 02:28:00 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ef166e62e5sm14206892f8f.40.2025.09.22.02.27.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Sep 2025 02:28:00 -0700 (PDT)
Message-ID: <4b38257b-c968-4128-bf4f-1a677da37972@redhat.com>
Date: Mon, 22 Sep 2025 11:27:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next] udp: remove busylock and add per NUMA queues
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima
 <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20250921095802.875191-1-edumazet@google.com>
 <3fbe9533-72e9-4667-9cf4-57dd2acf375c@redhat.com>
 <CANn89i+RbuL9oknRn8uACRF-MMam=LvO6pVoR7BOUk=f5S6iVA@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CANn89i+RbuL9oknRn8uACRF-MMam=LvO6pVoR7BOUk=f5S6iVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/22/25 10:47 AM, Eric Dumazet wrote:
> On Mon, Sep 22, 2025 at 1:37 AM Paolo Abeni <pabeni@redhat.com> wrote:
>> What if the user-space process never reads the packets (or is very
>> slow)? I'm under the impression the max rcvbuf occupation will be
>> limited only by the memory accounting?!? (and not by sk_rcvbuf)
> 
> Well, as soon as sk->sk_rmem_alloc is bigger than sk_rcvbuf, all
> further incoming packets are dropped.
> 
> As you said, memory accounting is there.
> 
> This could matter if we had thousands of UDP sockets under flood at
> the same time,
> but that would require thousands of cpus and/or NIC rx queues.

Ah, I initially misread:

	rmem += atomic_read(&udp_prod_queue->rmem_alloc);

as
	rmem = atomic_read(&udp_prod_queue->rmem_alloc);

and was fooled on the overall boundary check. LGTM now, thanks!

Paolo


