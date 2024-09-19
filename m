Return-Path: <netdev+bounces-128904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E6697C645
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 10:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 966AE1F26D3D
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 08:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352FC1991B8;
	Thu, 19 Sep 2024 08:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X48BFeQf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824801991B1
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 08:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726735918; cv=none; b=REIWm6YgdX0x2G1Df9+4thEVwFV65xrV/HzHfrEFG6FYf7hSrbZYWganjkv1ftRreIboTXErWvV4pa6blzL4TuWU7ikVhgemKHEk30iBisEdkxHlifMPOb3soBmWL8iiQU4YqdQrEV/aPOCvH2uQ/CFsJLPOMRcM7oOXK7z6QUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726735918; c=relaxed/simple;
	bh=ac44HsuMIlHv6sXDiEGfaSFoRkPBfY3p1K0W8klzEis=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GURpFtpUaheE1n4GJs21qQf793GVrs223pJzcGN5liaIdW6nTTTrAy80gP7NqOBwd0cXH2CTp7l0xUPO8RuTIwj5Mr/6MEJ1fkXxy+SkhZn4p/oEpmuUZ398/DxC+YK1dEEWzxukqv8zrBaUl5kIv4O0rHGxsL+/xEMAMh+FEVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X48BFeQf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726735915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0mGbTc92iDLbuR64u0hcpPUr0Vs7L0L/GoG+HX39BQ0=;
	b=X48BFeQfdzMylQgwmS+vbqKGDrlMT4Ka8pQqQ6xB7CATpW1QPDRjRZ9vUCFHHHut0eSiVR
	MQWsHl0y7Ie20ZBPT7lR6XlpCRWbZ+WY/Lz+WR0M67vHS1E5cxjilymONUCI/UpPT6LXLv
	Kh08kbBq1sp4Qj92eWSaolfry2Brnpc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-X4mXq79RNR-siemhIpeFjA-1; Thu, 19 Sep 2024 04:51:54 -0400
X-MC-Unique: X4mXq79RNR-siemhIpeFjA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-374c54e188dso829139f8f.1
        for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 01:51:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726735913; x=1727340713;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0mGbTc92iDLbuR64u0hcpPUr0Vs7L0L/GoG+HX39BQ0=;
        b=R5CeRWW1lGraiuofiyI9uH71JGmdm5nSaW8vRpLpS5p2mdYae6uEST1gsVrHiMGWg2
         FQeH5vVpEYOgUbFGRf7evq1WOTMwp2po5yRB8BAH/QCQg3p+ICZixEcB/Gkuy2D9fVrX
         S9zcv51fS1Uxd4RBi9OyWUumGx0E7cwD2UtlAGWD3X2Le2Zj8a8pqzRD7Wci7z0+FrtX
         ZrkJGvlBE1gWdHGe+m0H/BABSdv7gmD41MGGlc0FqXxrCDEqqDcuPREw89OYdtLiYOFz
         1FpZLlBT+dPy59X7SpKPc/rZ9i5subFGWNu/NekwwcAiYNTCy31b93v2n2pLT/AXrgtt
         uH7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUsUZEDgDJl5CcrIaQYZ035DdRBr20xbm1AYhmtWN1jCA/uKvEQRMV5J3DmibHe5wwjTjoq5wI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoZN0/1A+f5ADrlHkhuO/WBqQ8RRWFWssQXtcAcbM/Qs6Ov0ul
	O6KZa+YgwAQpPm2jtfyMIGeyHzR3yJDJC92KBpv429Lx61Az2wn8DkIhxmat+8muTufFuXe5+bc
	bBAnZhU0vUhXvyom9gx2MrLG7V6XBgYyE8XoXZlqQVAX/4lhPZfSMaw==
X-Received: by 2002:a05:6000:1fa3:b0:374:c7cd:8818 with SMTP id ffacd0b85a97d-379a86030f4mr1563156f8f.22.1726735912803;
        Thu, 19 Sep 2024 01:51:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHI85oI+5O1Om0cQoxzqcY76JOI0fNOGA3ZII/PFCYk/Jr9j5EdGPS4arHddtcl3zYCc7SICQ==
X-Received: by 2002:a05:6000:1fa3:b0:374:c7cd:8818 with SMTP id ffacd0b85a97d-379a86030f4mr1563138f8f.22.1726735912311;
        Thu, 19 Sep 2024 01:51:52 -0700 (PDT)
Received: from [192.168.88.100] (146-241-67-136.dyn.eolo.it. [146.241.67.136])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e75426d14sm16097745e9.19.2024.09.19.01.51.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 01:51:51 -0700 (PDT)
Message-ID: <1940b2ab-2678-45cf-bac8-9e8858a7b2ee@redhat.com>
Date: Thu, 19 Sep 2024 10:51:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: sockmap: avoid race between
 sock_map_destroy() and sk_psock_put()
To: Dmitry Antipov <dmantipov@yandex.ru>,
 John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, lvc-project@linuxtesting.org,
 syzbot+f363afac6b0ace576f45@syzkaller.appspotmail.com
References: <20240910114354.14283-1-dmantipov@yandex.ru>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240910114354.14283-1-dmantipov@yandex.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/10/24 13:43, Dmitry Antipov wrote:
> Syzbot has triggered the following race condition:
> 
> On CPU0, 'sk_psock_drop()' (most likely scheduled from 'sock_map_unref()'
> called by 'sock_map_update_common()') is running at [1]:
> 
> void sk_psock_drop(struct sock *sk, struct sk_psock *psock)
> {
>          write_lock_bh(&sk->sk_callback_lock);
>          sk_psock_restore_proto(sk, psock);                              [1]
>          rcu_assign_sk_user_data(sk, NULL);                              [2]
>          ...
> }
> 
> If 'sock_map_destroy()' is scheduled on CPU1 at the same time, psock is
> always NULL at [3]. But, since [1] may be is in progress during [4], the
> value of 'saved_destroy' at this point is undefined:
> 
> void sock_map_destroy(struct sock *sk)
> {
>          void (*saved_destroy)(struct sock *sk);
>          struct sk_psock *psock;
> 
>          rcu_read_lock();
>          psock = sk_psock_get(sk);                                       [3]
>          if (unlikely(!psock)) {
>                  rcu_read_unlock();
>                  saved_destroy = READ_ONCE(sk->sk_prot)->destroy;        [4]
>          } else {
>                  saved_destroy = psock->saved_destroy;                   [5]
>                  sock_map_remove_links(sk, psock);
>                  rcu_read_unlock();
>                  sk_psock_stop(psock);
>                  sk_psock_put(sk, psock);
>          }
>          if (WARN_ON_ONCE(saved_destroy == sock_map_destroy))
>                  return;
>          if (saved_destroy)
>                  saved_destroy(sk);
> }
> 
> Fix this issue in 3 steps:
> 
> 1. Prefer 'sk_psock()' over 'sk_psock_get()' at [3]. Since zero
>     refcount is ignored, 'psock' is non-NULL until [2] is completed.
> 
> 2. Add read lock around [5], to make sure that [1] is not in progress
>     when the former is executed.
> 
> 3. Since 'sk_psock()' does not adjust reference counting, drop
>     'sk_psock_put()' and redundant 'sk_psock_stop()' (which is
>     executed by 'sk_psock_drop()' anyway).
> 
> Fixes: 5b4a79ba65a1 ("bpf, sockmap: Don't let sock_map_{close,destroy,unhash} call itself")
> Reported-by: syzbot+f363afac6b0ace576f45@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=f363afac6b0ace576f45
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>

I think there is still Cong question pending: why this could not/ should 
not be addressed instead in the RDS code.

Thanks,

Paolo


