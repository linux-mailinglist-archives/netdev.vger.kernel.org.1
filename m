Return-Path: <netdev+bounces-233497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 504F4C14765
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 12:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 65B5A4FB807
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 11:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF81330DED8;
	Tue, 28 Oct 2025 11:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PofIAvSJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2398030E825
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 11:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761652057; cv=none; b=pkQr9tVRb3Vm3NF4KX0KVA9qZhI9xy/att7ZckfGM4LO7CfPn38bWzeAIOZkAJ5rxA0VHdPYn5yapxcRKD54cQmXW5lsti+TeDhQv3Svt5NY2ftv/07x4Zn4827McHGx8tFBOMOl4rPbGSpuPATYYZKlbCsb/VOiVmKOfxKW56E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761652057; c=relaxed/simple;
	bh=hTHSTmvO2gcuI9bvffQRykt0y1SGaZooIAbSqmRKxWY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=HQRfdmlgliUB8h0Ehrt1XyMQUmqM4nk/NaWJiAPk4XXddJLdnNRIFyeL6oGXAKKC80VbuM6PXsfS38THCdV1pz+AVKT4+rpA4HWc0KUjjl5E5oIvTRtHFRbBkLZXhrG/yZ8d4S4u+Zj0NmWzPAIlGlQISHF1AAyhhvYt78aiUIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PofIAvSJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761652054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ej5v2AhyT2+gsUph5VSZWo0mYhFvGVyUF+E1rpDGkYk=;
	b=PofIAvSJgeR/fy7VL/h8jfUtzIsDey3J9Pofm3VFwPCwnK3FLeJWaKYSeqEM0zwT5N9I72
	bnRkYOyEaELrHNrbksq5KUaTpZSN0vxM3uJOEZVkJL7fhZ91XiUVkPUeuUFcgvFDDwd9qc
	Dmd0y8j1+b00cZ/zzc1Re93EbfqxkfM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-ZaWkt9XWMAat4mygsgvU3Q-1; Tue, 28 Oct 2025 07:47:32 -0400
X-MC-Unique: ZaWkt9XWMAat4mygsgvU3Q-1
X-Mimecast-MFC-AGG-ID: ZaWkt9XWMAat4mygsgvU3Q_1761652050
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-427013eb71dso5467091f8f.2
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 04:47:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761652050; x=1762256850;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ej5v2AhyT2+gsUph5VSZWo0mYhFvGVyUF+E1rpDGkYk=;
        b=bgHDQVxBCtsf8Q/PCBhtFA2lXOpDpFYGSJNzaswdZPVQQQKsZptkwVgY4ltFaFggBc
         fAX9rPHoCXN1LTFZYPI8OgoKayzjWgy7x/G2ixXmt7dTutIiS1OdJX3pcjIK2YXeEn8y
         qh2YSTUBlB3hunMSe5YWmEhVZ8WKbie4SiFLFeFO8ogZ3Kw/4N2rV/ycJx66SPRDqDg6
         cEnRd//T1bb162xRdu+yElqXIND2MIdjBCMpm7qJ4UCLvx4+Fzn/v3k1jmIRDn0kxMq/
         BtiblV7ovqWQ1SUiSVsUa5AGiAoN+lwwJ4DlKZSNKZvkhjYG5eA9OQ8Cv4E6jSnfvJwZ
         +r3A==
X-Forwarded-Encrypted: i=1; AJvYcCVZYROuY4Bdh7Dx7ZvSOmBOTfAW69MDbyDMj4zoCMZYh3puFtQOvDF+7madbvGUynw32aBYozU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEPFetHXs07peNPFrMc8d+EK5+dSYFxpbPVkTWABgQvjjsl0qb
	cPUdNC5NaF7pGn1YrrvX+gpmUb+9RqFIXT8/jdTya/kpqy0dw3+1tQqVzod4JdVH0Bzpp9UcVdT
	kV42d8jqafdgDiPkxwi68QFO9GaqkH0nwP4b4qA+bb2m5I73pJWIWNJM/tg==
X-Gm-Gg: ASbGncvnX6p+34aQcL2XTYLtbUBnq6/nRgDkbPpA34ypF0M7A7k9tu2oAuztfZPdN2q
	usVVfFAau4LqwPnfdEFlrfoZ/PJc+et3NzTEeTJSwPaeZo4XWBmRplVa5kkq5zch3gcluvwBiBM
	gp+RrwTyuBN+qUgwA82hPMPnVX0YlVxNmh9VP4B392LQet5g+RQZpW1gcesk4lT2u8Jkeo/d5h0
	BJw70hXzxNXzkxcqOy+Mp3Da2HP1f8C7HnPJNJWOoMY8BcX7QKwdTpVPXP/dp+vfRwrdMcavOks
	LbnGdJA8ifGcPMPiZxQrgZnPy8RroJYCfmz0YZmKErrIv4txg2v6BCNyL4ewny5WwnyxkUnVdoj
	Nl7xEAGQh/go7kKKDch5EdBxqfzITZef9OuXIzeLR0o1B8Ps=
X-Received: by 2002:a05:600c:b90:b0:477:58:7cfe with SMTP id 5b1f17b1804b1-47717e04c2bmr26366985e9.18.1761652049822;
        Tue, 28 Oct 2025 04:47:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYsmPrnr2n5dOG2TMddpHesTATKrRY3s7taqm1slxtVNIFUzWMD6kXpI/krQ6+LdMW9yh+6A==
X-Received: by 2002:a05:600c:b90:b0:477:58:7cfe with SMTP id 5b1f17b1804b1-47717e04c2bmr26366375e9.18.1761652049184;
        Tue, 28 Oct 2025 04:47:29 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd47793fsm194874245e9.3.2025.10.28.04.47.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 04:47:28 -0700 (PDT)
Message-ID: <7dfda5bb-665c-4068-acd4-795972da63e8@redhat.com>
Date: Tue, 28 Oct 2025 12:47:26 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3 1/3] net,mptcp: fix proto fallback detection with
 BPF sockmap
From: Paolo Abeni <pabeni@redhat.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>, mptcp@lists.linux.dev
Cc: stable@vger.kernel.org, Jakub Sitnicki <jakub@cloudflare.com>,
 John Fastabend <john.fastabend@gmail.com>, Eric Dumazet
 <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Willem de Bruijn <willemb@google.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Matthieu Baerts <matttbe@kernel.org>,
 Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20251023125450.105859-1-jiayuan.chen@linux.dev>
 <20251023125450.105859-2-jiayuan.chen@linux.dev>
 <c10939d2-437e-47fb-81e9-05723442c935@redhat.com>
Content-Language: en-US
In-Reply-To: <c10939d2-437e-47fb-81e9-05723442c935@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/28/25 12:30 PM, Paolo Abeni wrote:
> On 10/23/25 2:54 PM, Jiayuan Chen wrote:
>> When the server has MPTCP enabled but receives a non-MP-capable request
>> from a client, it calls mptcp_fallback_tcp_ops().
>>
>> Since non-MPTCP connections are allowed to use sockmap, which replaces
>> sk->sk_prot, using sk->sk_prot to determine the IP version in
>> mptcp_fallback_tcp_ops() becomes unreliable. This can lead to assigning
>> incorrect ops to sk->sk_socket->ops.
> 
> I don't see how sockmap could modify the to-be-accepted socket sk_prot
> before mptcp_fallback_tcp_ops(), as such call happens before the fd is
> installed, and AFAICS sockmap can only fetch sockets via fds.
> 
> Is this patch needed?

Matttbe explained off-list the details of how that could happen. I think
the commit message here must be more verbose to explain clearly the
whys, even to those non proficient in sockmap like me.

Thanks,

Paolo


