Return-Path: <netdev+bounces-179034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F59A7A229
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 13:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FBE07A6054
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 11:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D602E245037;
	Thu,  3 Apr 2025 11:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bo3ce4VE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5A7248873
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 11:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743681040; cv=none; b=uOLL/tMFpvuQWYmgCBrNMvLN5/WKbbnOnejJ0POwM88BkCcDbuWGj5rMSDGAypShQJrh8UVzqnqbgGtanOYN8v5frqZjEF9tBLLKrIR/jKKlw28M1INfmO8EpGJZgwwhYZdck8Uz+8C0aQmjqHZgUVouTeR80VMUVp9/TbuzET4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743681040; c=relaxed/simple;
	bh=JNO28fWoaC+tM1jLqwaTtDbEJcdNZKd7TIPKVu78nOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JgDvQyMwlfaD0onmfMSRUshH4I6f8Ts/9OWjLzZRIGiLUbQtbAhmbUsbTywqZ658+q5Ln9NMxqAjMxEEVZoEM5moGBwG6pHIuqKYrqiO728wX2dPIX0BApt/ytP2ZQI/gLJZF9lXQjN754lNOmodSjJ1MIs9pLavau+85603SYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bo3ce4VE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743681038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Zj6XuVGPfM2793V/JcD1kmv5tyZDJv7xCPhThA49yQ=;
	b=Bo3ce4VE57If01R0F6eImRYYH8NQzUAkCk75j6IYpFH4KQL+DDBkaIZ7efMpcS4KUj6N9+
	OE+gSsZoq6EhpxR88R5qAp7/ZUdcEGvHPiP8RV7r1LDT3CK23Y2lcj1QmpIm56wKqd0844
	QZV4M/zccx7I1abL9CxUZ+cKkyzypUY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-lT8UNxRONc-AoVZgm0wd6g-1; Thu, 03 Apr 2025 07:50:37 -0400
X-MC-Unique: lT8UNxRONc-AoVZgm0wd6g-1
X-Mimecast-MFC-AGG-ID: lT8UNxRONc-AoVZgm0wd6g_1743681036
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43ea256f039so6559865e9.0
        for <netdev@vger.kernel.org>; Thu, 03 Apr 2025 04:50:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743681035; x=1744285835;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7Zj6XuVGPfM2793V/JcD1kmv5tyZDJv7xCPhThA49yQ=;
        b=ksPNbFWE2aSY/AxASYQUdnfVk+axR3g9bQjABkg1bZ3et2yokmArNY/Ncrwi1FpTU3
         7Fm7wqAEi6twve0cVokVIldGfPpR5XXU56+vukH0tvykd28cApQLcZgTF0WbxplORmCe
         grPAcvvioW8WqKecINUhCeaQwaLNveKnIFRtXZumnBHZeojoxLrcbs3jUCG6Enb3yZ9z
         Z595F3m4OWXi6+KZQeEGKdSci6daDiY7MCbOa2r7WCskNDbSzxgHYQ2gi5C3ywNXrrdd
         Ew4GnE0cQ+6iJeUw1R9uqH4Ot1r3z7O4cawx2TBLbqpMJkUGnDy+B3Wae1oGQDHoSVi6
         M+aA==
X-Forwarded-Encrypted: i=1; AJvYcCV+OQN+ESy6ae24qvQZdmiebk0pQSXc+YrPSl2OtSbKesVo3gTtA/mV35Y8OdYWDAtSvcjEOZ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBvV2R0hIxQRqjZv0HL1sBpjKnKaJLGwL5XzY1kYoE8w34FPR6
	Z8SrFL2wjUUL4y3Ap0rxBRPUeo+eiksL8VCS79BPs9HWs2A/CjxwKX87LnoEpUehwS76YxlcnwX
	SWgvmUTWDy51+sFbnd6AMzeqb+YAy/GMfuXVto8oQxEwKEGA0aZjVPQ==
X-Gm-Gg: ASbGncsFGjV7DNghihqXN83i0jqK6pBIyhz2mA7TscNhuBw4parLBzID7JSNEBXMmn8
	jemoIsnD7a/f8zcukI1lqIYMongximNBouP5Mm+la+syVaN/TzfzV4m5M0zG1ViJCBB2X/T8QpG
	Cx+uUhlehXPiPDkYxHCmd85xiHfLjJ/0sbfcXtgr02EC3oh7MpkwQHZidsNMSdAd+9fQOIoKq+7
	kdgQoDSy8j0KgAq3uA/lWBtKERbpHgcJvp09+eQgPH6wxzVbIDrkRoF4LfkUiMdrqcS8jIc7Vse
	qmBtNj3W+qe2cmlddJbpQ6q0adr0tuR7drW6Mm52nT+msQ==
X-Received: by 2002:a05:600c:b9b:b0:43c:fcbc:9680 with SMTP id 5b1f17b1804b1-43db62bdfecmr172952525e9.25.1743681035510;
        Thu, 03 Apr 2025 04:50:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHojKG7yA9MWLduc/LIVM8C18XHcC83gwQjAA4NdlpUvz16wfBun2O1hXFQ+pazdcIgaa5zEQ==
X-Received: by 2002:a05:600c:b9b:b0:43c:fcbc:9680 with SMTP id 5b1f17b1804b1-43db62bdfecmr172952385e9.25.1743681035160;
        Thu, 03 Apr 2025 04:50:35 -0700 (PDT)
Received: from [192.168.88.253] (146-241-68-231.dyn.eolo.it. [146.241.68.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec34bf193sm16244985e9.24.2025.04.03.04.50.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Apr 2025 04:50:34 -0700 (PDT)
Message-ID: <fe13ece8-67ea-48c0-a155-0cb6d2bcfc52@redhat.com>
Date: Thu, 3 Apr 2025 13:50:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] ipv6: sit: fix skb_under_panic with overflowed
 needed_headroom
To: Wang Liang <wangliang74@huawei.com>, davem@davemloft.net,
 dsahern@kernel.org, edumazet@google.com, kuba@kernel.org, horms@kernel.org,
 kuniyu@amazon.com
Cc: yuehaibing@huawei.com, zhangchangzhong@huawei.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250401021617.1571464-1-wangliang74@huawei.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250401021617.1571464-1-wangliang74@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/1/25 4:16 AM, Wang Liang wrote:
> @@ -1452,7 +1457,9 @@ static int ipip6_tunnel_init(struct net_device *dev)
>  	tunnel->dev = dev;
>  	strcpy(tunnel->parms.name, dev->name);
>  
> -	ipip6_tunnel_bind_dev(dev);
> +	err = ipip6_tunnel_bind_dev(dev);
> +	if (err)
> +		return err;
>  
>  	err = dst_cache_init(&tunnel->dst_cache, GFP_KERNEL);
>  	if (err)

I think you additionally need to propagate the error in
ipip6_tunnel_update() and handle it in ipip6_changelink() and
ipip6_tunnel_change().

Side note: possibly other virtual devices are prone to similar issue. I
suspect vxlan and gre. Could you please have a look?

Thanks,

Paolo


