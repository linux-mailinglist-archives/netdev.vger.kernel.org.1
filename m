Return-Path: <netdev+bounces-142035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 247B49BD236
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 17:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55CD61C210D6
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 16:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210741D1F71;
	Tue,  5 Nov 2024 16:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OFkl6J8Q"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6799417C7CE
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 16:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730823781; cv=none; b=ZPclyXcCron63ujMAfKmgHq8EVleS/6BMtKPXBQOE0fwKirUg0PNnBUwRTOXfn+FRrIv504mT4wQRsIGEJLvgVXF0d6VG2ool+tdYmdDPTQ7VP/fHXYGOhntUGV9jY7Ttl7bs9/MHPtGriHnkVTo/l93ijZJsNhWX/kKbAiyQTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730823781; c=relaxed/simple;
	bh=sU071qnW9Ah6xms9ifN5TQR/Cn89FIKDbnAVenLHXT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a+WXqDQCY2wpXjIMMc4RsACRZrj2LGhPpd7RwwPvxKPhh9ucLG0VtrzUuW0iuwOGXA+nXV1Pm4QFgju6k2OrVoyd55Otxcz8WxRZ09ZUq3pxkSOy4rQgXHaL8wzAjcePq/PYOnq5AO+VrQXh7RKqkbupWfeZRbUa3QLz+4k/gHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OFkl6J8Q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730823778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3dblTnSbQrPQjhmtB+0QzZEv45vbjiUZA8WWfGC0UVk=;
	b=OFkl6J8QRjTi8I6lH0fFOzSSVynrn2u4xYKNutZfoDSQ5/K3Ckam7XvRJQl1y1TGCM/Atn
	wg3hrm7u1n/j6TqE3HBPUazHJicdNG71gkoPQXFfeSBzT9IwdTDthK7YaXqOZqJGxZAnQx
	Owr2gi6GfxoMkf4Xt6CkK2Ap0gMtXIg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-NAIKYJk1OGm7rYfsDpyDMQ-1; Tue, 05 Nov 2024 11:22:57 -0500
X-MC-Unique: NAIKYJk1OGm7rYfsDpyDMQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4327bd6bd60so37397665e9.1
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 08:22:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730823776; x=1731428576;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3dblTnSbQrPQjhmtB+0QzZEv45vbjiUZA8WWfGC0UVk=;
        b=tGFHa6MB/1F1AfdqNRrw7IrN4BAYO+59otyeq0/4Svfz1F+WWWNfgIiTdsExeY7rus
         uSqdkqazZsHfuohQ5CXw4OXDP1p8Te1SYiMc3wL/UgRbS5lDx3cRgF3fEKosyyoMYYpo
         2V/7jN8+6w6xMixI+47f9ACR7HsFaiAmDr/dvkCOiZwzU3dFPdHikOPTM0bPcwUX5l4n
         zDuVQhEYvFO4GtQZquyNbOWiaMmiCjmA/m/iHL2A6DHUGoR6hlXmXwGRdD/NItIE8m6J
         nqURMtZ/TOdweBy84dUiYemp7wv1NIYe0fM7k3kiDhH/7MKWLZsZBiFmAdptCi4d3dhg
         rh2A==
X-Forwarded-Encrypted: i=1; AJvYcCXZ2XkRwVO5aT0zVvvXweKM+Xf9BbHheWOFwzO46BVvF3pOlvwiXAoV5/2jaso+tKLmHL2WweQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAEMM//IDwVxJxYEMRyfVYvbvO0vhenJMe/u7McV3kbeI83S7z
	2L13s6y1s4uBln1tLQ58oUVCN/1RsVvy5YCTDdm5Vx6J9gcUFKEcbIVQmPyThz0/QwnOcIKv77x
	O4vVBrYuwERPVonkLAlprcThGWDGdpwrNdAicK8ZRyvnK8A92ncjlpA==
X-Received: by 2002:a05:600c:350b:b0:42c:e0da:f15c with SMTP id 5b1f17b1804b1-4319acbb947mr288020215e9.20.1730823776147;
        Tue, 05 Nov 2024 08:22:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9ZkjQKGCdeZeL0ihoS916abF93Zh3X2B4Sgu4MXKc6Mi5b61TVn1ACE4SUp96qLsKOR9vWw==
X-Received: by 2002:a05:600c:350b:b0:42c:e0da:f15c with SMTP id 5b1f17b1804b1-4319acbb947mr288020055e9.20.1730823775813;
        Tue, 05 Nov 2024 08:22:55 -0800 (PST)
Received: from [192.168.88.24] (146-241-44-112.dyn.eolo.it. [146.241.44.112])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd91093csm230334865e9.15.2024.11.05.08.22.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 08:22:55 -0800 (PST)
Message-ID: <36a5e3a0-258e-4771-905b-227b74fbe5fe@redhat.com>
Date: Tue, 5 Nov 2024 17:22:54 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 net-next 7/8] rtnetlink: Convert RTM_NEWLINK to
 per-netns RTNL.
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
References: <20241105020514.41963-1-kuniyu@amazon.com>
 <20241105020514.41963-8-kuniyu@amazon.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241105020514.41963-8-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/5/24 03:05, Kuniyuki Iwashima wrote:
> @@ -6995,7 +7017,8 @@ static struct pernet_operations rtnetlink_net_ops = {
>  };
>  
>  static const struct rtnl_msg_handler rtnetlink_rtnl_msg_handlers[] __initconst = {
> -	{.msgtype = RTM_NEWLINK, .doit = rtnl_newlink},
> +	{.msgtype = RTM_NEWLINK, .doit = rtnl_newlink,
> +	 .flags = RTNL_FLAG_DOIT_PERNET},

The above causes a lockdep splat in many selftests:

https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/846801/12-bareudp-sh/stderr

the problem is in rtnl_newlink():

#ifdef CONFIG_MODULES
                if (!ops) {
                        __rtnl_unlock();
// we no more under the rtnlock
                        request_module("rtnl-link-%s", kind);
                        rtnl_lock();
                        ops = rtnl_link_ops_get(kind, &ops_srcu_index);
                }
#endif

Cheers,

Paolo


