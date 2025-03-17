Return-Path: <netdev+bounces-175206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8963DA645B0
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 09:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 886833A4A37
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 08:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9B22206BF;
	Mon, 17 Mar 2025 08:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EfAwxosm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FF321D3FE
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 08:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742200498; cv=none; b=fDNaL+5m2cVSNX43iwS9+lLcIX2iItvWEVWW8JtBlG9WSKvZneCHsiiI4HIGLwCrQZ9ARhv0mZ3dJ+SQCH9+KGQWQAqLuUJQCJAoN+Y2vBNrwZyt4ze7bj4KVwoT4WZXh6gl7RZMB1JVJ3ULkRnBNQyhYUW8MwXnGzxXnj0j01s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742200498; c=relaxed/simple;
	bh=c2n1Fx835UhBJSllbwffn7zGDt95tdAKPpRn0ntoO54=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=M9YLpttB7bvjMB+FRUp+GNLs8tK+stvyMcrySOgEZ2zkXwXi5t8yUiUUqTQJPEhhqTbL4rupWwlvnB8Z827cS+qms7jSGY6jAASadCR6p8wuw5BhnCmOhWH7cBnkmt0D55C8jDqEDxV+aQ0H9dte+zY6qAaF8CR4+Pzc4mEEoE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EfAwxosm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742200495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K8fFsxESP3H629nCG6gkvjmwLt+3pqm+G1ABejpl59E=;
	b=EfAwxosmi2kuQHPFTccyZ/hzPapseqk7aATs16x3QEEFIoDFVzkopbMjLm3bqQlxTGx0rx
	XvvkLWSgCCephjVsZKdAqRCKI83X45+gw9iMlo7Ik4+wUHig4AJYFl8h8b7t3i0xtSvvGq
	pK+uf6fjwLimgrKzYJm68G+5cYv55Pg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-FKeTF6AbNqmLpfxnhU7NQA-1; Mon, 17 Mar 2025 04:34:53 -0400
X-MC-Unique: FKeTF6AbNqmLpfxnhU7NQA-1
X-Mimecast-MFC-AGG-ID: FKeTF6AbNqmLpfxnhU7NQA_1742200492
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-39141ffa913so2458909f8f.2
        for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 01:34:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742200492; x=1742805292;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K8fFsxESP3H629nCG6gkvjmwLt+3pqm+G1ABejpl59E=;
        b=mIAtl4Mn9EU7bTFThgIxsf6qm9w4Ox/ou9v5Xl5s/1LRWbtFY2GniPZlkHC0J/6yiB
         30qVvgt8K+kbx+6ONhNXIEhPuVdth1hLZSWAHNRQ8ug8/fjwnmclxI4+uVCa1fwYKAA5
         73jUpS69HkznrbZHng1d31Hkq6wIlYu1T4/U70um9dH+gV70KRJkiRaljBl8YUAii7ph
         dQMToMGZCcc1kbIVwNuSGPIVwir+h4DXeT47YT7Z/0J/KANkHu0YvDv3Ty63YBy4Qh0T
         uAtN6kcbnVaapPfDMwU/PUycKYNX4QVyzIeh7FYJ0v8ioVTJewI7YOd5p9e8tbgSk5qI
         sZjg==
X-Forwarded-Encrypted: i=1; AJvYcCV3uUW+ckNrFsVDqDMBIWMK/PnyAuQPH/BO78Df0XZH1HycyxpVp+QBXUebmzLbQJJwL9xg/Bo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlZK6pqKFIOE1RfUBGmhZBZz8Xo/UwF7lt6383MH+oFhiF5FgR
	wt1IvY3Ky2LDOWchZ/K+1PBhq1iwz1mWxbiSv8oIt4SyetDq30IiiNZQ284tTY1aNhzE49XOe2a
	BupFLJDXNs6Upqb9d0H9LjBrY3ZxmjfhYnWJXDdxlhu8V1NQLS1LeCQ==
X-Gm-Gg: ASbGncu0LYAxtga0YKQaPYUWPH6PHUU5ByS2swSpj8pOtpd3YO8hpR6d4wo0HLO31em
	jBowQ0lLOmQCDn+uMbkx82KmH8pvdeXbawi3d3NwaHjy//S2tvcLH5paIfNVMZfHnEoWYLKpisQ
	t8zZaSwSDLoOBcrQc8iWQsEV3Y/aamPRmV0a9Wbb6SqnB40TeyJ4e1K2hEqu0qSmL6idv25grdT
	vU41JQms6ETqpSLvnk0VOBn4UFHOkw2wpksSBQ53ZiesDJkrybNwQPUSI3+ykfJBX9ozq28jFBX
	cgcGS/vi7RxAskO4H6SL+bqgJiFuprZHAy655yzQzAo3ig==
X-Received: by 2002:a5d:6c6c:0:b0:38d:e6b6:508b with SMTP id ffacd0b85a97d-3971d23508dmr10794768f8f.9.1742200492283;
        Mon, 17 Mar 2025 01:34:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGV3AlBDqXOJvZL9/HUdYQCvelee3VTZFcDu+UlzkczKdH898voG07Nf0T2P5NkPsevzif4lw==
X-Received: by 2002:a5d:6c6c:0:b0:38d:e6b6:508b with SMTP id ffacd0b85a97d-3971d23508dmr10794744f8f.9.1742200491924;
        Mon, 17 Mar 2025 01:34:51 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d200fae4asm98193875e9.27.2025.03.17.01.34.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 01:34:51 -0700 (PDT)
Message-ID: <5b9d622e-7404-490a-a13c-1181d196d7c6@redhat.com>
Date: Mon, 17 Mar 2025 09:34:49 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 06/10] tap: Introduce virtio-net hash feature
To: Akihiko Odaki <akihiko.odaki@daynix.com>, Jonathan Corbet
 <corbet@lwn.net>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kselftest@vger.kernel.org,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>,
 Stephen Hemminger <stephen@networkplumber.org>, gur.stavi@huawei.com,
 Lei Yang <leiyang@redhat.com>, Simon Horman <horms@kernel.org>
References: <20250313-rss-v10-0-3185d73a9af0@daynix.com>
 <20250313-rss-v10-6-3185d73a9af0@daynix.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250313-rss-v10-6-3185d73a9af0@daynix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/13/25 8:01 AM, Akihiko Odaki wrote:
> @@ -998,6 +1044,16 @@ static long tap_ioctl(struct file *file, unsigned int cmd,
>  		rtnl_unlock();
>  		return ret;
>  
> +	case TUNGETVNETHASHCAP:
> +		return tun_vnet_ioctl_gethashcap(argp);
> +
> +	case TUNSETVNETHASH:
> +		rtnl_lock();
> +		tap = rtnl_dereference(q->tap);
> +		ret = tap ? tun_vnet_ioctl_sethash(&tap->vnet_hash, argp) : -EBADFD;


Not really a review, but apparently this is causing intermittent memory
leak in self tests:

xx__-> echo scan > /sys/kernel/debug/kmemleak && cat
/sys/kernel/debug/kmemleak
unreferenced object 0xffff88800c6ec248 (size 8):
  comm "tap", pid 21124, jiffies 4299141559
  hex dump (first 8 bytes):
    00 00 00 00 00 00 00 00                          ........
  backtrace (crc 0):
    __kmalloc_cache_noprof+0x2df/0x390
    tun_vnet_ioctl_sethash+0xbf/0x3a0
    tap_ioctl+0x6f2/0xc10
    __x64_sys_ioctl+0x11f/0x180
    do_syscall_64+0xc1/0x1d0
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

Could you please have a look?

Thanks!

Paolo


