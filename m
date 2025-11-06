Return-Path: <netdev+bounces-236258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FE5C3A6ED
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 12:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 052E74F64A5
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 10:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31302EC579;
	Thu,  6 Nov 2025 10:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MkloPY/3";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="grDVQcA4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D9E2D7D2F
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 10:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762426638; cv=none; b=cjdEPyUFpK11yGo8VhWHCDZtx5BTK2Plq2pUWIM2073fXFTY/c2sKAK1ldGhIJZyUWW93JiJlamT/ZMFssnvY/evraD1GKznRQjv9tbwKRR74XunAU3nhbeSQrIpTrIf15TmolsDl+9x1nI6HdCNHjyLn4MAtdgOSRDkJX5sano=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762426638; c=relaxed/simple;
	bh=9invMdERfhYKNnXg74LQAFbXckBFXN636tVMG/vPhmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FfndqzDGr9uPMs6ti455WpGDgGQ1dTLyUbzG9zmKhFpB+Tr9jNrScb/aAyYhxHoEw5q6kf7NiKGGcgdwxnXPQ0toKBtWcaORZldDV9dGPU9zLMXHRp9aHWLS/yh/PS8O0LOr2dpw5sE99ZTF4Y04CLybGxXsm9LVMjA9pLy+eWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MkloPY/3; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=grDVQcA4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762426635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kDAN1HMJoQQtQ55I20Dw66H+vj6obQIAmVodeSEuemo=;
	b=MkloPY/3L2ImETBZoWplxezT28qNMdj7b/GIXkMeqeOfm5c0wItChKDfBqsPSYFMCjMxD2
	AZkaZ++w/WVVw24k615SU+jRP7ZRVkDAJM7lSX9rS+MLV32eXTkIBpY6tQUj8uBE8yC2Pc
	pw+oiFRIcEL9CDBPEM6dYrpVf+wKerM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-_Qkxc4aKPoSOlgg5iekVKw-1; Thu, 06 Nov 2025 05:57:14 -0500
X-MC-Unique: _Qkxc4aKPoSOlgg5iekVKw-1
X-Mimecast-MFC-AGG-ID: _Qkxc4aKPoSOlgg5iekVKw_1762426633
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-429c5c8ae3bso885844f8f.0
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 02:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762426632; x=1763031432; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kDAN1HMJoQQtQ55I20Dw66H+vj6obQIAmVodeSEuemo=;
        b=grDVQcA4IIFdE0So8kwToiBQbNlLPgaIdDPiSxX+C/FuB++X/USEZOPz538ddu4iNT
         Mx3ebMoFz2lRn7MwLwXTUuMCHAt5XM7Ytnqr/Zu4kHRU9+4cgSpAIyXWXl3CVkXog45d
         BwKJucxcUPFMcjsl3o2eliFK4MjWROxAhSQRlQjV58OvFAHMwk8VA41EDUKctDdLYj++
         uhODnFr1vzcRSSG0GwusM9vO250X/D4dXLaPhVLjkEHw6A80FmaeqPQcPOT/2xGkFxuc
         QiCGAWA7ljTZNUhxTHi1t2+CMf/DRs/ayYeucX0R4dZqTenDsfpLK4E+G3+/pT8NnFMq
         0GqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762426632; x=1763031432;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kDAN1HMJoQQtQ55I20Dw66H+vj6obQIAmVodeSEuemo=;
        b=gJqPFmf2MvSr322jcFQTUsSal2qdwjRnw0B55A1751xTeuvgOh+xxkoh0uZ99XB5Z9
         N3yXUcTzcAGR2aH2eAYf3Be7H6Q4bJTIpQV2mZBTq8hA6yhJl4anDZsEnSvKxrzycCUu
         iRUF2JJjnN+7Qh7vIMD0BHjxmEvT5rA2gLYDeLXWUssjgzEquwHMFGhEJGPAtGTSq3YG
         iW1whPSkqF8og1fqQhz7yR35l4ZNhRks21kRyG2kuOmWfGc1TaEhr6AKJkyTbtzBOJrU
         +wHRjJYek+Bw8OJANPgCISiPaWPMBvuRW+zdrh6l1cIHuzuLgjgBMz5RifNBXw60qYfK
         EvDA==
X-Forwarded-Encrypted: i=1; AJvYcCVF4SYFvDJ8BDYYpyrYswZqwNNSLIjFCodDShfviK0V4R9vGAhl0OrO+qRQDlPPZFp77VHMkvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhoAEKqUhKxj3xtPocgsk6+alWWKWmpKPOFzieOSk92oRtyHAw
	1WUDo6VvxmfUkdg5be0L3+m0ohVgTHM3ytQ9OeFWle5VgRZVRliRu+koivUBoMdT4EKuHn5gtPi
	e/OTDnh9il1eDKXF/DgBlsj0W+elEofCN0otKOudSQFaqxu5f5HWlkh6Q3A==
X-Gm-Gg: ASbGncuV4+21NXc14VlQG+Gi+PQinN0h0lIZb7GF91FX+9iL0q718OFgVLuR7FE5eiv
	UqfJ9qb16RcnduShJO5Xxt0kfziE3UMTUr9w9xflDUcZ5xqFYeW50wgnR6s6RxMpIQDIflUcnVb
	8xTan/mHiIQNwy/0L81uVdpzDdZSgW5C0hA2Zeh0rIa/ZVkd+gemqAPwXkCbIz9ONwdDnIiAn9F
	rG12fR2iS/odeMWCPvnWuWD1A7+jEWr5/1IYi0ntYnsn8zBciprzme2ymhpEOLMK59Kw+usYlvW
	a26FFYqRVM8HOGfLw6RbU2rXVgSxKjjs2L6TqwGgxCiWq51Tf+6msgSy8dOCktNkjaLyly77ztL
	hoA==
X-Received: by 2002:a05:6000:2811:b0:429:edfa:309e with SMTP id ffacd0b85a97d-429edfa32admr1087640f8f.20.1762426632511;
        Thu, 06 Nov 2025 02:57:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGuo4Zz37FAjgeqMkvLjK2yjkrDZq4CtR/TEtSlcvQWi/2zCplPBisLlN9/n2avyBib7PRi5Q==
X-Received: by 2002:a05:6000:2811:b0:429:edfa:309e with SMTP id ffacd0b85a97d-429edfa32admr1087626f8f.20.1762426632119;
        Thu, 06 Nov 2025 02:57:12 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429eb49baf4sm4127409f8f.33.2025.11.06.02.57.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 02:57:11 -0800 (PST)
Message-ID: <2f38933e-f24e-4a14-a906-0d06bc194a21@redhat.com>
Date: Thu, 6 Nov 2025 11:57:09 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 01/14] tcp: try to avoid safer when ACKs are
 thinned
To: chia-yu.chang@nokia-bell-labs.com, edumazet@google.com, parav@nvidia.com,
 linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org,
 dsahern@kernel.org, kuniyu@google.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com,
 kuba@kernel.org, stephen@networkplumber.org, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, andrew+netdev@lunn.ch,
 donald.hunter@gmail.com, ast@fiberby.net, liuhangbin@gmail.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, ij@kernel.org,
 ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com,
 g.white@cablelabs.com, ingemar.s.johansson@ericsson.com,
 mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at,
 Jason_Livingood@comcast.com, vidhi_goel@apple.com
References: <20251030143435.13003-1-chia-yu.chang@nokia-bell-labs.com>
 <20251030143435.13003-2-chia-yu.chang@nokia-bell-labs.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251030143435.13003-2-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/30/25 3:34 PM, chia-yu.chang@nokia-bell-labs.com wrote:
> From: Ilpo Järvinen <ij@kernel.org>
> 
> Add newly acked pkts EWMA. When ACK thinning occurs, select
> between safer and unsafe cep delta in AccECN processing based
> on it. If the packets ACKed per ACK tends to be large, don't
> conservatively assume ACE field overflow.
> 
> This patch uses the existing 2-byte holes in the rx group for new
> u16 variables withtout creating more holes. Below are the pahole
> outcomes before and after this patch:
> 
> [BEFORE THIS PATCH]
> struct tcp_sock {
>     [...]
>     u32                        delivered_ecn_bytes[3]; /*  2744    12 */
>     /* XXX 4 bytes hole, try to pack */
> 
>     [...]
>     __cacheline_group_end__tcp_sock_write_rx[0];       /*  2816     0 */
> 
>     [...]
>     /* size: 3264, cachelines: 51, members: 177 */
> }
> 
> [AFTER THIS PATCH]
> struct tcp_sock {
>     [...]
>     u32                        delivered_ecn_bytes[3]; /*  2744    12 */
>     u16                        pkts_acked_ewma;        /*  2756     2 */
>     /* XXX 2 bytes hole, try to pack */
> 
>     [...]
>     __cacheline_group_end__tcp_sock_write_rx[0];       /*  2816     0 */
> 
>     [...]
>     /* size: 3264, cachelines: 51, members: 178 */
> }
> 
> Signed-off-by: Ilpo Järvinen <ij@kernel.org>
> Co-developed-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

Acked-by: Paolo Abeni <pabeni@redhat.com>


