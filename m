Return-Path: <netdev+bounces-118422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0506F95188D
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 12:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 384861C20D6F
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 10:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66671AD9DD;
	Wed, 14 Aug 2024 10:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kg31RwLP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3709A1AD9CF
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 10:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723630844; cv=none; b=W/5BgTUPjO6/5ae6jSOb9nDU8bRU7Wxir8Q9e7XmqMf2rwpR7O5sO5ka+7yfYdGzQT0Kdd+b/A4f9NvwWkmlDg6myA6wkfew0Td2dTO9z5tglQ1YaQeWbmhPLCUWL3TIlS+ulYE/2ZG/kQhx8mvvZmBOKD194flRu1SCxPOapYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723630844; c=relaxed/simple;
	bh=OesaZVG85sa5tJ2CWd0ZRjKD4AAHsYi37iOiX+FHu/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FOF7Dix5WHCI6ZpEHGD+6FggZu1QDS2G6zGfDQJtlnoMUiwPiAQWNW9WL311+B2BaqZ9ySxN7HLMVg7klunDszuJAaiVyoZV1GGW4KB4tdSH6fFll2MZtIK8iTOZVW5fAN+TMegrIR03atHYAnoqtysG1mxjNix2s9cqKwRmf6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kg31RwLP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723630842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ArvT52QZCzAIBxygYJAvMZW0y/eajEvYt8KDonFX9zk=;
	b=Kg31RwLPujNgmUi26E8Dm5jL9ubn+RiKe5LH5k06QgRT/x6v2sDdj6O32lvi7RhKBTAQx1
	ggvQsAFZmsLjEAZOWBZHAfv5Cah/VHe5b/it0nUXTCokUkYbYXiEy19FXffBp+4S3+Z3GP
	thGlVovp/gAPwDItXd4u59L3o1NHDLA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-686-NAK-kLw1PwaF_XCsF52-GQ-1; Wed, 14 Aug 2024 06:20:38 -0400
X-MC-Unique: NAK-kLw1PwaF_XCsF52-GQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42809bbece7so997035e9.0
        for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 03:20:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723630837; x=1724235637;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ArvT52QZCzAIBxygYJAvMZW0y/eajEvYt8KDonFX9zk=;
        b=utyBtjmUZMKyZKWveR0cvC42uzDSNx4PgULjLBmNMDQBE4fOnhBFos4zNvnOQiEgcl
         BbNeZgSXNARF4UdbRV7/B6rJYgJNWMSwuWzDFbz3N2G5wj996KEGCvRumO5oQY2ESJPg
         lZmNOoCzhaw2EnaythxBk+6xLomrUB1f52Zemr9fX7sO1mamqlWfZTEUhs+5XIqEH2GP
         g9FNUW8ZvdVCZGTJRow8/5bZGp2N46L1waw3QLr0ll0/r1q0VtCrSViQRLm4VnOnE8x5
         voOchqWIYj48ELyWd6ebIYP0teTcm/ifMNbE1T1a8ByPul4RoFDSVkMKb45vDTwPaIN2
         bITA==
X-Forwarded-Encrypted: i=1; AJvYcCVypy4U5BFYCSYhhjXZHA/P5wepeTkZJzyHTa43I9VWbS9T4Et2yszY2KhRwjB422VTyArF+nzINzs3LTqH9nr+SUTmBR+2
X-Gm-Message-State: AOJu0Yy+zgV8E/xa3agXLKBoyco3c+BePC9J9Mdi17eU9uE43YhCiyip
	FvlR0+D6jlaiZbGxCi/b/rjOvmtlgIS1Ep0fDkYQ96Sumcdmy3nUGAMAGy6PudpB3t0L8CKGnTO
	Jpb2h8OMp19DVmfX24WJBXXIoyAxBZ0uYF8bJxP+BVpxFn8BeBMGAIJJv8zHgX7Vv
X-Received: by 2002:a05:6000:1a8d:b0:36d:1d66:554f with SMTP id ffacd0b85a97d-371777b426cmr1041945f8f.3.1723630837331;
        Wed, 14 Aug 2024 03:20:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWUqTtYdG3Z83woA9aA35QcrGb+K5syL0svoCJ4GlfCHLPwm9xo1NeGshX8quWbWdeBH9ywQ==
X-Received: by 2002:a05:6000:1a8d:b0:36d:1d66:554f with SMTP id ffacd0b85a97d-371777b426cmr1041911f8f.3.1723630836299;
        Wed, 14 Aug 2024 03:20:36 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1711:4010:5731:dfd4:b2ed:d824? ([2a0d:3344:1711:4010:5731:dfd4:b2ed:d824])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4c36bea4sm12524894f8f.13.2024.08.14.03.20.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2024 03:20:35 -0700 (PDT)
Message-ID: <696bc883-68f5-48f0-bf7e-258b4dc05bcc@redhat.com>
Date: Wed, 14 Aug 2024 12:20:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] selftests: udpgro: no need to load xdp for gro
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Ignat Korchagin <ignat@cloudflare.com>, linux-kselftest@vger.kernel.org,
 bpf@vger.kernel.org, Yi Chen <yiche@redhat.com>
References: <20240814075758.163065-1-liuhangbin@gmail.com>
 <20240814075758.163065-3-liuhangbin@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240814075758.163065-3-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/14/24 09:57, Hangbin Liu wrote:
> After commit d7db7775ea2e ("net: veth: do not manipulate GRO when using
> XDP"), there is no need to load XDP program to enable GRO. On the other
> hand, the current test is failed due to loading the XDP program. e.g.
> 
>   # selftests: net: udpgro.sh
>   # ipv4
>   #  no GRO                                  ok
>   #  no GRO chk cmsg                         ok
>   #  GRO                                     ./udpgso_bench_rx: recv: bad packet len, got 1472, expected 14720
>   #
>   # failed
> 
>   [...]
> 
>   #  bad GRO lookup                          ok
>   #  multiple GRO socks                      ./udpgso_bench_rx: recv: bad packet len, got 1452, expected 14520
>   #
>   # ./udpgso_bench_rx: recv: bad packet len, got 1452, expected 14520
>   #
>   # failed
>   ok 1 selftests: net: udpgro.sh
> 
> After fix, all the test passed.
> 
>   # ./udpgro.sh
>   ipv4
>    no GRO                                  ok
>    [...]
>    multiple GRO socks                      ok
> 
> Fixes: d7db7775ea2e ("net: veth: do not manipulate GRO when using XDP")
> Reported-by: Yi Chen <yiche@redhat.com>
> Closes: https://issues.redhat.com/browse/RHEL-53858
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

LGTM,

Acked-by: Paolo Abeni <pabeni@redhat.com>


