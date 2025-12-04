Return-Path: <netdev+bounces-243528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 906F0CA3274
	for <lists+netdev@lfdr.de>; Thu, 04 Dec 2025 11:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 257303132948
	for <lists+netdev@lfdr.de>; Thu,  4 Dec 2025 10:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB7933122B;
	Thu,  4 Dec 2025 10:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M+AMVUJw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eg/kfJ0A"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E386333420
	for <netdev@vger.kernel.org>; Thu,  4 Dec 2025 10:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764842666; cv=none; b=iWC9WIkDlvD6jK7w6ITt7eNF4J8EaS6iAO0BBE2fHANYEDw/zlpMS9L3wVnrphYTVnZqotb3IPVMa4Am36x9mCPYBLdiPchYK6c1+iTsS6Gb5N8SgyvU5qrSFMyPQ7jbWa++UaLxvuuNnuiXaQ505eaYc6b7Bpa1LA0csi0uJtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764842666; c=relaxed/simple;
	bh=NkGy5Yxav+hxu5WxRgjThmTZ5m0bK0FqnEpQGAWdXWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MH7NTXuZnjjk0+fOpji+/je4od9oR7zN4PlEGGZWWp3UHqUU7+IxjM0PlLei3JnQOwRWGRbcz6Z3aqUH6wY3+nVKEK2Btk0QLaDL0Q8fJ0FId0B9xUw9dKh07s7ZiBOR53cW0sFUut/8HN1c3Nrcsq7sZwkaV5bfmfHxlwYRINc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M+AMVUJw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Eg/kfJ0A; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764842663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jYJIwmIzAHmgYcwAHqAyW0oXzjS8vsesR3EEDMcroX8=;
	b=M+AMVUJwwnn0MKy5C5ipE7/VqA78EtA4u/Wk2e31fgDnyyNyyA6gJ+ZKX5agLHZHAUIlZJ
	n28WGpxBLdnA/Bs3egE0qz1gDJcdGhCcZr+pfN3CXQwVWSMRuz5JzErrRtYdiv5FDNS6Th
	770AMl8kZd1jnMTAMiPGCxxchS6hHik=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-FJ6qqVpmPh64mkQfGQMaAQ-1; Thu, 04 Dec 2025 05:04:22 -0500
X-MC-Unique: FJ6qqVpmPh64mkQfGQMaAQ-1
X-Mimecast-MFC-AGG-ID: FJ6qqVpmPh64mkQfGQMaAQ_1764842661
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4779ecc3cc8so3868005e9.3
        for <netdev@vger.kernel.org>; Thu, 04 Dec 2025 02:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764842661; x=1765447461; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jYJIwmIzAHmgYcwAHqAyW0oXzjS8vsesR3EEDMcroX8=;
        b=Eg/kfJ0ALXJT/PXWpmHyLdK3n13XQ4cMgMCzjWcG7f7wYXua3Wm2Y3tB5hXu+Oub1L
         xopAsZUysi2IwFWePLtNOeCQ/wRyJGo0eNAO+10emZ9i3VxKGouN6STizy3RvBKa3oHl
         C4fP3m9DPjmmGvtYzvAfNVTRzSknVOqAjsxdRCkPnzi7ook6xWGHNoUWrjQYWQDoazcY
         gVdE2vz0XZmFbakCwydGXPdrHfFB7ciLYwelZs7AV9WAhb7CqOG7Q7zFDtSHlFJ7JR1K
         6gUPsaYQ2/ruGTJQuqTRgwnryUh3nKF2PLDD/To1RuvJSWcRHaLvVUdNlm6EsbMvdkKf
         0SzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764842661; x=1765447461;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jYJIwmIzAHmgYcwAHqAyW0oXzjS8vsesR3EEDMcroX8=;
        b=hFxP5iUtDGhYLl5oW6bAqh9NY1hZgcnlc2x9qqnKBldEDViUVHm1E5gt+eXLGHmG10
         61b3o+IpYYaNJgvFQnotQsn3MNXt+PV2PMF1KxVOAtGDoStfqd6mFtYC9jQtnTi51HF2
         wv7d3Zc4GrqNHLeob2qkTOdNBmw5nYJ33uj1O2DccTNQ8hdg5DN1bJN7SOBWS8YBqa+B
         qT7quP8fM55fRAqYGxwdf3ibmn/6Ge56IMEO/y8P/TVClKMDCNfqwjvHGgusLFjWMBT5
         oDrDktfuwOf3GjByNrnIX6X2DsJERRZJaq/1L0mH5ARk4LHTsYolZaunfBrsrmVduyvQ
         DkPw==
X-Forwarded-Encrypted: i=1; AJvYcCVHxgWpCMITH+Yk1XCZLlkuVz6Iak+uhXu/q36NbnNIP1G1wd485g26uCDrpW4CFEmgF8Qgh2A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7ilycGaLosjH+wlXijBlPTPNRmB6UgdWwhG/d1QL4pPUbOhA1
	G/BDl4K0JhUhPl0F/ReJTEJ17fspO4flA1XtEJAkIvW2Bc5BFj2mY7fxh8zY3OcavasxEjl9PYy
	9P+Dyjx7mmJLEPxg9jtkd4eVPXxGRwOzGjBHVAKO2hW56Wwoy4jk/rfcl0w==
X-Gm-Gg: ASbGncuvQtAPu9jGqNEwd6g0FGUyO2wnAPdRr/9wK0OWZ3YfD0xc+Q+U10b4sZkPlG0
	Ztyg1zeFscAWtcnFi5EueECQdMLUTUqxc+5F62vseue3iIlXzbaatJ9Gdf2TcrtnDTLDfV71nUb
	Uzcf7PTVickxEJMsQPoSrhRkucDNOeyfGzQ1V9nm+I7eUnZgUE4Lg/r65JJHI5grdIVnB+A67F3
	NoNrGuKOywo/su6DVO4xLo1o6atFNu12Tlo4AArQfqgi0UVpmSYTGK2mpqhGdOd8tQ7fkJFqlny
	rkJIuVe+SYMH/GQjjD7kCITTT7NVZOuozovwAIlF4W83cct0TFG2EpY7uhsnp7xbQLk19KuMk/N
	czjU/fUIJ2DBj
X-Received: by 2002:a05:600c:3b1f:b0:477:b642:9dc1 with SMTP id 5b1f17b1804b1-4792f386f92mr20088145e9.20.1764842661074;
        Thu, 04 Dec 2025 02:04:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHtlgpbU3wPzpHckIiNG7MkxJnSSWwzko1ByQE61szhPF3nugo4abw7JPrLtUp1XhZD817+Jg==
X-Received: by 2002:a05:600c:3b1f:b0:477:b642:9dc1 with SMTP id 5b1f17b1804b1-4792f386f92mr20087785e9.20.1764842660674;
        Thu, 04 Dec 2025 02:04:20 -0800 (PST)
Received: from [192.168.88.32] ([212.105.153.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4792b12411fsm42744815e9.3.2025.12.04.02.04.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Dec 2025 02:04:20 -0800 (PST)
Message-ID: <7bea2244-dc28-4c67-b515-739b8b7d7901@redhat.com>
Date: Thu, 4 Dec 2025 11:04:18 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: netrom: fix memory leak in nr_output()
To: Wang Liang <wangliang74@huawei.com>,
 Deepanshu Kartikey <kartikey406@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org
Cc: linux-hams@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+d7abc36bbbb6d7d40b58@syzkaller.appspotmail.com
References: <20251129034232.405203-1-kartikey406@gmail.com>
 <17e41b73-3497-4ea0-b91c-4710514f7b14@huawei.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <17e41b73-3497-4ea0-b91c-4710514f7b14@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/29/25 5:01 AM, Wang Liang wrote:
> 在 2025/11/29 11:42, Deepanshu Kartikey 写道:
>> When nr_output() fragments a large packet, it calls sock_alloc_send_skb()
> 
> Hi!
> 
> Coincidentally, we both are working on this issue simultaneously.
> 
>  From the syz test requests:
> https://syzkaller.appspot.com/bug?extid=d7abc36bbbb6d7d40b58
> 
> I sended the test patch earlier, only a dozen seconds...

FTR and future similar cases, we don't have the send time information
handy. Instead we use the timestamp as available on patchwork.

In this specific case Deepanshu's patch landed first, but does not apply
cleanly, so I'll apply Wang's one.

Cheers,

Paolo


