Return-Path: <netdev+bounces-180195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 230C7A80448
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 14:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 665974667C8
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 11:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A03726983B;
	Tue,  8 Apr 2025 11:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XtNwu0kl"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF792269885
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 11:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744113456; cv=none; b=YXEipjsmPrQLehgHVx+ccqbGWciL198q7nlztq4gvoWzw7eXouTN5v+DeMddeNL4x6uKg5MbPxw53Ri7WnlOpjJVCKUQufFlcuFoXcowImsWQKJSyqoHv27tBvY4HXzPxyHlvRzpcT/+pfbakCden0w+aZNabN8OVfTYjukUgZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744113456; c=relaxed/simple;
	bh=QvLcxX6yWCKbIIyEBBiQhqEM3Z9K4VTDnwN+pMqwPsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pxPNaeogaLWXJTq1lUXHd9UwNSmJBni+d3IzJJWcXsGSSBwLYFfbQAGJ+OfWtCokK2XxipSk5ZWhdr7LRRTJ7mr48b78vPNX4d2ADEk35bn7nAhIqMoFyIEbYkc9NHpIuVTMla2sMUfTMCV2hYQG7mcKfrwLzGC9xqN9o/kc1rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XtNwu0kl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744113453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wBvpiZeAl58ooIRNvYADzEYhfHJSYfAIRoqxnjfSxT8=;
	b=XtNwu0klU5/gOE0WuKvAiCKHa+cHFpHmO5VrJDgl0kgwidkYHD/NpAiHj7c4wrTBODV1VD
	v1cd2Iww6RQEszb0f2JdvKpjEMYXFfmvkN2p4ew8wqFbPDCY62lvZyURjv5WgQrdiYezVq
	pBMI9/Ru36uwIbhrb2/cCvMwFTSoySs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-A0gcGfeqN3CrcsLOcbeVIA-1; Tue, 08 Apr 2025 07:57:32 -0400
X-MC-Unique: A0gcGfeqN3CrcsLOcbeVIA-1
X-Mimecast-MFC-AGG-ID: A0gcGfeqN3CrcsLOcbeVIA_1744113451
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3912d9848a7so3182762f8f.0
        for <netdev@vger.kernel.org>; Tue, 08 Apr 2025 04:57:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744113451; x=1744718251;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wBvpiZeAl58ooIRNvYADzEYhfHJSYfAIRoqxnjfSxT8=;
        b=bwSQyQM37ZTJiW99wBLpfqxnwJT5egP4/ws9GFrdgwOgtaahgqhULJAxJzyfWVWf+M
         gw/s5dCgZiDwe90LFoSzNpjUIB5x+Lo56EJ4CjYRRZsOXB/5jfJxTLaz+axFOI0oZI5S
         NwXzoLeZAKyvXwCbf8USXxD+QSMOBxVl9lROgbFy8UMMkWhbrOm+30yCozoNGS0xpG1w
         +OuNCwUeaBOH4J7KBHdwh4GHckhNKHJYiHe5Jx2hYtR4KyDEJcUAYFM7T6ZF+4OhnEIv
         bCaEhxp+hEX0fZ5cRp2XeUQcCPmMLZD12tGdAbRCAA1Mmv6c+RT9h7XoP+yVrkJI3r0S
         TBPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtTa7V1YZ8wkpi5NnXL6klIbedOv6MH8S5XyuNl3Fzg4HJjhwR75f1q9yhBAth/NpRFVvPdvo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkVPVVxOBk98QYiubzNak5K0xFG84Z9MvCthRsuWtO2hFoX4B6
	WZ4tM2nhY3HJzZyXfNIFwTAYaDleFCPFbJxMpdDAnjg8Jr/woDU5DhkSB6JE5LfMI62b+Un2eyT
	hngPW6AsBBEGEU1UQpoixwI3gfRyZ5wbUg40k2UZiYBPhDDJ7wUC9IQ==
X-Gm-Gg: ASbGncvsD4xUJI2eR26y3JsH657sQkrY4GILn3ZLa79duMNaD9EgHx4Afe/ezV8w/Yo
	lzcbMr5Z9cYgitJU8lQ67dNGKVaZBsnqwqkZG8Mx993fGI6b9kMT8cNvDK5JWJZjF4qqlEm+blp
	quybCiKDoNHx91bKBM6DYLgnhBshKDvBwc22zmtqMLRdfUul1Iv2lkFnMhQMx4ydWe3bIfOYCT6
	kSloaFeoHys3+OU2yBViIpDixSN263IlH5ETrTGRsjncJcfJco6FTP0EX4FgRviGqFBcT/5zzVj
	8HygpF70bHkkrApISyJfcMpEUgOZeKphuQmlRKTT5d0=
X-Received: by 2002:a05:6000:2cc:b0:391:952:c74a with SMTP id ffacd0b85a97d-39d820aca79mr2682902f8f.8.1744113451212;
        Tue, 08 Apr 2025 04:57:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBGwI8+I+ikQqr9EBAiBMmMVZ65FGBOy3vL+rQixNlh1yzT6KQhdff9n0JVUKlOIIIf1LfaQ==
X-Received: by 2002:a05:6000:2cc:b0:391:952:c74a with SMTP id ffacd0b85a97d-39d820aca79mr2682882f8f.8.1744113450827;
        Tue, 08 Apr 2025 04:57:30 -0700 (PDT)
Received: from [192.168.88.253] (146-241-84-24.dyn.eolo.it. [146.241.84.24])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c3020d938sm14864864f8f.65.2025.04.08.04.57.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 04:57:30 -0700 (PDT)
Message-ID: <126fa7e1-dbe0-48ff-9cb5-31c1d4dea964@redhat.com>
Date: Tue, 8 Apr 2025 13:57:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] tc: Ensure we have enough buffer space when sending
 filter netlink notifications
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>
Cc: Ilya Maximets <i.maximets@redhat.com>,
 Frode Nordahl <frode.nordahl@canonical.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
References: <20250407105542.16601-1-toke@redhat.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250407105542.16601-1-toke@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/7/25 12:55 PM, Toke Høiland-Jørgensen wrote:
> To trigger this, run the following commands:
> 
>  # ip link add type veth
>  # tc qdisc replace dev veth0 root handle 1: fq_codel
>  # tc -echo filter add dev veth0 parent 1: u32 match u32 0 0 $(for i in $(seq 32); do echo action pedit munge ip dport set 22; done)
> 
> Before this fix, tc just returns:
> 
> Not a filter(cmd 2)
> 
> After the fix, we get the correct echo:
> 
> added filter dev veth0 parent 1: protocol all pref 49152 u32 chain 0 fh 800::800 order 2048 key ht 800 bkt 0 terminal flowid not_in_hw
>   match 00000000/00000000 at 0
> 	action order 1:  pedit action pass keys 1
>  	index 1 ref 1 bind 1
> 	key #0  at 20: val 00000016 mask ffff0000
> [repeated 32 times]

I think it would be great if you could follow-up capturing the above in
a self-test.

Thanks!

Paolo


