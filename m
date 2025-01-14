Return-Path: <netdev+bounces-158037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AFCA102D7
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 10:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C3BD7A2549
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 09:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE9C22DC43;
	Tue, 14 Jan 2025 09:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Amrqltgw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85B722DC22
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 09:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736846251; cv=none; b=HcllSiA2PFbnBCszNQlopDrIxk/WUpGB/pzqfmdpv4sct2GLqO39s2wqBWZAuhwANiBvQw0Yy61OxuiX0UtJ8FBibKwxfAiHSzDCvn3cflM1ACt6MJ/kA1sWa3xgTAqoXBzSAsxVzll79KlZ14qvCds9QILmHMWVFZxO8kP3e64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736846251; c=relaxed/simple;
	bh=wPn/TMvVVPoc19dj+nyKK0gACsFGgWwZwnhJwY9hkUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tE/pd2w9vY7bUXy7RhYnmgvrTq1Uq2ODnaf+hdzCaTTOB39W2E7hTQfZ1OH/1hKY9YBL+h67/eaJJxGnWvJOfxgTxKP+jGCLeSjrGRlv7DmHtFDF9A3r7ttTGttOg49cjThOHjziZR2ck/OoUqMbcQslCfpEc/rcClVzX3GqdYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Amrqltgw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736846248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OQraEKHsOlmEHChxrh8nJYoJKDHgJ1C4gJg1fFYP6MQ=;
	b=AmrqltgwDCZT+rZ6/IjHZcwod7nIa5jTM6wlpOgvUoOiHjXUjdg9uyhY4nlUlUcNCOnvRc
	DNIXBV0DJd/+Bpuld3eBsKSIzrsY4sSNKJU8N+C4ebyiMFT5AxsDTcp8bmIGpA+Fk08yMT
	0zW6djYNyrBhuT9hSqcip5/0tvCHtew=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-8q4IqYABMKqG1CsNBbM7gw-1; Tue, 14 Jan 2025 04:17:27 -0500
X-MC-Unique: 8q4IqYABMKqG1CsNBbM7gw-1
X-Mimecast-MFC-AGG-ID: 8q4IqYABMKqG1CsNBbM7gw
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3862b364578so2890973f8f.1
        for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 01:17:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736846246; x=1737451046;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OQraEKHsOlmEHChxrh8nJYoJKDHgJ1C4gJg1fFYP6MQ=;
        b=SgezH3xpUk/gwdEFB+uFWs3HBHxfKfXqvdQpXgatLmeGaLyb4tlnoRInRKnP2ue4VM
         i6muTewFRp1OaftQDhfxpQA68q4Z2I5Tp9rAaxmpraqMGXFTPfwUZ3D+d+uCYabbKtvM
         x+85AUAXswnNkdFK62e4gf5IhkuruNznntFxk2LEDSGHIi2YPv+dhYguMXMpzQUBdquu
         qq0Jwm8frOVpQOEfm7H6iQaLgrLuIlMdCwCyC/pXFN1Gd11aMLtoeOYiqu6J5YCrAUMj
         jZc9KO71uKWrlxHFq88rpkCRKSDIH2f0QHZi7bGBFTeYrglSGtmZUBCT7gydYDm4wmY2
         EJ3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXmsTyMfbVyhRlXYvIr08Tf3S5duhDzehwYQ6Bn1MYvJdao/0+CHBtmofeNhNoSH/q+bSJXvgY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp/phn+6Wnz6hIGKvbO/ybtwkCIc6TX2wiOwM9CFBkMkcXj9cC
	8jbsRlouKv+hO9EoB0miUXQ06uSCSeeKHGXMi37VIVpGvK8WC3UBIDRbRCxwoMn3ssDojlCUXKT
	zfKfuZHPwKbLbyhzCzw0Hu5XlMQmMjc8i/FfL86B/BKBa9oRap4YpYg==
X-Gm-Gg: ASbGncvBWpiWEItggNABW605vtf+ukepnHcNRsxyzxEZ8a0OaEZlmMZMrNkWyXoNF9G
	8lNgZ9HDfEswOdxBUjr/JCT5BO5q5+8ooIwbwB9ZaGELFMIzEWdTmGrl3QSnP9+ftpGcdnazxpG
	QIjbBcKsCF6TSwVq/OZ0sRMXAhPe4cbopDMzNShhpNzpktAsxpCCCFGwEmmt/JaTQc/m3anr7gK
	XrHeXJAVtQIeLK9Km/MqDhqZCQ2rVRujfSmpOZV8M3BfpwWOWV8h8dY/59h/4y/XUSyvoPaZZe7
	ZbWuwyWzoE8=
X-Received: by 2002:a05:6000:186e:b0:38a:8d32:272d with SMTP id ffacd0b85a97d-38a8d3229edmr17129649f8f.28.1736846246132;
        Tue, 14 Jan 2025 01:17:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIST9s4P0R6kB+/WuXh4q6E2ciXlNr7eJ4+czRM8yN0PoDsJTeNiNiz29LCD0ZNSGfsGA0ZA==
X-Received: by 2002:a05:6000:186e:b0:38a:8d32:272d with SMTP id ffacd0b85a97d-38a8d3229edmr17129625f8f.28.1736846245782;
        Tue, 14 Jan 2025 01:17:25 -0800 (PST)
Received: from [192.168.88.253] (146-241-15-169.dyn.eolo.it. [146.241.15.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e37d11csm14393582f8f.16.2025.01.14.01.17.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 01:17:25 -0800 (PST)
Message-ID: <7e2e96b2-27a6-4f1d-90da-546f7c26ed0c@redhat.com>
Date: Tue, 14 Jan 2025 10:17:24 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: sched: calls synchronize_net() only when
 needed
To: Eric Dumazet <edumazet@google.com>, Cong Wang <xiyou.wangcong@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20250109171850.2871194-1-edumazet@google.com>
 <Z4CxKV5AnfDPRfaF@pop-os.localdomain>
 <CANn89iK7PzN6C4GXfwSasszdF1PyupR9xd7wsvoRiYrm0ARwtQ@mail.gmail.com>
 <CANn89i+ioYk6_n1E5Y+vpsNR0Uxd5_foLpM9UCEQ_c05Sray7Q@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CANn89i+ioYk6_n1E5Y+vpsNR0Uxd5_foLpM9UCEQ_c05Sray7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/13/25 5:08 PM, Eric Dumazet wrote:
> On Fri, Jan 10, 2025 at 6:49 AM Eric Dumazet <edumazet@google.com> wrote:
>>
>> On Fri, Jan 10, 2025 at 6:33 AM Cong Wang <xiyou.wangcong@gmail.com> wrote:
>>>
>>> On Thu, Jan 09, 2025 at 05:18:50PM +0000, Eric Dumazet wrote:
>>>> dev_deactivate_many() role is to remove the qdiscs
>>>> of a network device.
>>>>
>>>> When/if a qdisc is dismantled, an rcu grace period
>>>> is needed to make sure all outstanding qdisc enqueue
>>>> are done before we proceed with a qdisc reset.
>>>>
>>>> Most virtual devices do not have a qdisc (if we exclude
>>>> noqueue ones).
>>>
>>> Such as? To me, most virtual devices use noqueue:
>>>
>>> $ git grep IFF_NO_QUEUE -- drivers/net/
>>> drivers/net/amt.c:      dev->priv_flags         |= IFF_NO_QUEUE;
>>> drivers/net/bareudp.c:  dev->priv_flags |= IFF_NO_QUEUE;
>>> drivers/net/bonding/bond_main.c:        bond_dev->priv_flags |= IFF_BONDING | IFF_UNICAST_FLT | IFF_NO_QUEUE;
>>> drivers/net/caif/caif_serial.c: dev->priv_flags |= IFF_NO_QUEUE;
>>> drivers/net/dummy.c:    dev->priv_flags |= IFF_LIVE_ADDR_CHANGE | IFF_NO_QUEUE;
>>> drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c:        dev->priv_flags |= IFF_NO_QUEUE;
>>> drivers/net/ethernet/netronome/nfp/nfp_net_repr.c:      netdev->priv_flags |= IFF_NO_QUEUE | IFF_DISABLE_NETPOLL;
>>> drivers/net/geneve.c:   dev->priv_flags |= IFF_LIVE_ADDR_CHANGE | IFF_NO_QUEUE;
>>> drivers/net/gtp.c:      dev->priv_flags |= IFF_NO_QUEUE;
>>> drivers/net/ipvlan/ipvlan_main.c:       dev->priv_flags |= IFF_UNICAST_FLT | IFF_NO_QUEUE;
>>> drivers/net/ipvlan/ipvtap.c:    dev->priv_flags &= ~IFF_NO_QUEUE;
>>> drivers/net/loopback.c: dev->priv_flags         |= IFF_LIVE_ADDR_CHANGE | IFF_NO_QUEUE;
>>> drivers/net/macsec.c:   dev->priv_flags |= IFF_NO_QUEUE;
>>> drivers/net/macvlan.c:  dev->priv_flags |= IFF_NO_QUEUE;
>>> drivers/net/net_failover.c:     failover_dev->priv_flags |= IFF_UNICAST_FLT | IFF_NO_QUEUE;
>>> drivers/net/netdevsim/netdev.c:                    IFF_NO_QUEUE;
>>> drivers/net/netkit.c:   dev->priv_flags |= IFF_NO_QUEUE;
>>> drivers/net/nlmon.c:    dev->priv_flags |= IFF_NO_QUEUE;
>>> drivers/net/pfcp.c:     dev->priv_flags |= IFF_NO_QUEUE;
>>> drivers/net/team/team_core.c:   dev->priv_flags |= IFF_NO_QUEUE;
>>> drivers/net/veth.c:     dev->priv_flags |= IFF_NO_QUEUE;
>>> drivers/net/vrf.c:      dev->priv_flags |= IFF_NO_QUEUE;
>>> drivers/net/vsockmon.c: dev->priv_flags |= IFF_NO_QUEUE;
>>> drivers/net/vxlan/vxlan_core.c: dev->priv_flags |= IFF_NO_QUEUE;
>>> drivers/net/wan/hdlc_fr.c:      dev->priv_flags |= IFF_NO_QUEUE;
>>> drivers/net/wireguard/device.c: dev->priv_flags |= IFF_NO_QUEUE;
>>> drivers/net/wireless/virtual/mac80211_hwsim.c:  dev->priv_flags |= IFF_NO_QUEUE;
>>>
>>>
>>> And noqueue_qdisc_ops sets ->enqueue to noop_enqueue():
>>>
>>> struct Qdisc_ops noqueue_qdisc_ops __read_mostly = {
>>>         .id             =       "noqueue",
>>>         .priv_size      =       0,
>>>         .init           =       noqueue_init,
>>>         .enqueue        =       noop_enqueue,
>>>         .dequeue        =       noop_dequeue,
>>>         .peek           =       noop_dequeue,
>>>         .owner          =       THIS_MODULE,
>>> };
>>
>> Sure, but please a look at :
>>
>> static int noqueue_init(struct Qdisc *qdisc, struct nlattr *opt,
>> struct netlink_ext_ack *extack)
>> {
>>         /* register_qdisc() assigns a default of noop_enqueue if unset,
>>         * but __dev_queue_xmit() treats noqueue only as such
>>         * if this is NULL - so clear it here. */
>>         qdisc->enqueue = NULL;
>>         return 0;
>> }
> 
> How can we proceed on this patch ?
> 
> I can remove the "(if we exclude noqueue ones)" part if this is confusing.

I personally interpret the lack of reply from Cong to your previous
message as agreement/understanding. I'll drop the blamed sentence from
the commit message when applying the patch.

BTW, in the long run I think it would be nice to remove the noqueue_init
hack - AFAICS no in-tree kernel has NULL enqueue/dequeue/peek CB, so the
related checks in register_qdisc() could possibly be dropped.

/P


