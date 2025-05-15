Return-Path: <netdev+bounces-190667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A67AB835F
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 11:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75EE01BC17B0
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 09:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B8A297B8C;
	Thu, 15 May 2025 09:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TnSf+BX7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA1C297B6E
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 09:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747302932; cv=none; b=EAqTD3gwOTf77cXuqoUS5LJVeP2bx83c37QOxou+sBA+PKU5cfSN8t8D4R1LHET6J260QfkVSZpxY9Q1PipvRxvMCDrqdEyxXr7xpNgCtS5NI088q79KpqCr3Josng8qQWPg15dSsyZA3DiUrskKpG77UkkY8pNMQeogFDUls8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747302932; c=relaxed/simple;
	bh=5U6gtE5DKJs+3iz70q0Fs++Wgk0JBNMWol2ZQLojvHs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uzQuq2ZTYCTTXYqrjqFTbRiFop+WIrrA3b5helDdqnJluZfbXJo3CgoalHAbjDciA+x0DvALiHAGahfWVe8xPldA76pkiTIebWFclHaDdyiGCJwZlfRyVP+InYurHyQfmR9ov1BIAwePXqPkm5ra8AuP2P8eRFPBSg6u6n0ZgV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TnSf+BX7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747302928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jiz6ndGJFjTghJ7XdcRmJq3QP9TYb8f/oaZ3mhqnyAI=;
	b=TnSf+BX7fFQsFAjfmwU6PYfLSniyR/WEhnAAxIxkMvwBvhhrvA5ZECKxMlkI/85xRObqza
	dkwwirf8bAchzX0K045EHo4uENjPzhv9iFuCxSSOLVtgYDcRbKQlfjBrT2zyiUowEwysR1
	s5REbGUZCJRaDzOntC5QJpE3RCuTtlE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-441-tmf6wDitOA-ef6zbU_dU0w-1; Thu, 15 May 2025 05:55:27 -0400
X-MC-Unique: tmf6wDitOA-ef6zbU_dU0w-1
X-Mimecast-MFC-AGG-ID: tmf6wDitOA-ef6zbU_dU0w_1747302926
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a34f19c977so359239f8f.0
        for <netdev@vger.kernel.org>; Thu, 15 May 2025 02:55:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747302925; x=1747907725;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jiz6ndGJFjTghJ7XdcRmJq3QP9TYb8f/oaZ3mhqnyAI=;
        b=MlgqXS47SfuZ18Ibw83E/c7x66Nqi3NhO8fRWYp3R307zK+NMnn0YYpXgsr/Kn5Mh1
         ZJOdtKOe8D4HPS9nEMZxvxij9qUa6ts0diCkfkg3llzhG7ApQAYHyW06IijKxG6r65Ds
         9uvzBn3pW8J9t9vGzm5crEClOQy+xSJwcKUPlYO2Q762ruipt4kgacLZ+vL6GzMaEIgj
         KpWU7OfcP9gVIhr2fpQ2RXL0SS2vLxiIYjh57ULYr+OuNWVBvu7P7mvkux4hzZbwDjvi
         FKpG/Bvke6eLtj7/L43WV24icvKUYIS/5U7D5lq+E9OY0bPmkApI3hKwYo0cJU8BiBzi
         JiHg==
X-Forwarded-Encrypted: i=1; AJvYcCWeIz+lYYGiv0wLE9pfIhij9JuJY7Gp3T+EEvUmgRa3K5JW8tH7kraMWMTFaZDbh3WRVnlwBNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiWDoOAQg+WtwCBc9isCosNgW2GtmgUo4dzNLyP9shUYw9lei3
	DGsbCrFinq4Ui+B4wW7GZopQfFqa5dIodwlEQHYtMr23bpfHOF+4X39pv92lPevgaApooxE3Bf3
	1+Y0reGj+N/vPhyF7KPF3KF9OKAanXH08lc9j9McW+kAg0FAnk+zWf7CoWScqsWK0srfL
X-Gm-Gg: ASbGnctPv+kLxBdfQMJLJ/fMLMhmk63q3hQkkQi4QlgejTd6JykZuil4brjm/i2UkWu
	aVIQaph3VEf2p/3rJyjm7xm91mHmI1YsuT+60HUmH6WR9A6T3j2h8oVeZ55B9QTagsxo11ZUh2p
	E3Ot+0NbHomPGVhrKkSAScE4tBt97E1clak1gUaTxbHmoPl2+cQHlnd+RoEngGnzK93QAqB1/09
	vzn3ui+hfQnr7HAAgbILV7rmp1gvDmpEx0Ck3TQKNJu/6pTbbte0E+pxcqUecX9/42nfhyzt7ob
	oiXfiJZJvUFc5lUrQrHUslWAziXU7zwwphv+jjTO6t6zrDZ4/NoL+NIxh5c=
X-Received: by 2002:a05:6000:2408:b0:3a0:b84f:46de with SMTP id ffacd0b85a97d-3a3512102b9mr2493131f8f.21.1747302925647;
        Thu, 15 May 2025 02:55:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHE9JwGTJdw25VAJtcZJc6HTRnmqmzlBaO2XKeTPhb95VPmN8r7Vkk/2fj/yJLLse1gPsf9Hg==
X-Received: by 2002:a05:6000:2408:b0:3a0:b84f:46de with SMTP id ffacd0b85a97d-3a3512102b9mr2493100f8f.21.1747302925244;
        Thu, 15 May 2025 02:55:25 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2440:8010:8dec:ae04:7daa:497f? ([2a0d:3344:2440:8010:8dec:ae04:7daa:497f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35225355csm1734053f8f.44.2025.05.15.02.55.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 May 2025 02:55:24 -0700 (PDT)
Message-ID: <235b93a5-6989-4131-9099-c0c03bb6afc1@redhat.com>
Date: Thu, 15 May 2025 11:55:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 10/15] net/sched: act_mirred: Move the
 recursion counter struct netdev_xmit
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 netdev@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>
References: <20250512092736.229935-1-bigeasy@linutronix.de>
 <20250512092736.229935-11-bigeasy@linutronix.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250512092736.229935-11-bigeasy@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

CC sched maintainers.

On 5/12/25 11:27 AM, Sebastian Andrzej Siewior wrote:
> mirred_nest_level is a per-CPU variable and relies on disabled BH for its
> locking. Without per-CPU locking in local_bh_disable() on PREEMPT_RT
> this data structure requires explicit locking.
> 
> Move mirred_nest_level to struct netdev_xmit as u8, provide wrappers.
> 
> Cc: Jamal Hadi Salim <jhs@mojatatu.com>
> Cc: Cong Wang <xiyou.wangcong@gmail.com>
> Cc: Jiri Pirko <jiri@resnulli.us>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  include/linux/netdevice_xmit.h |  3 +++
>  net/sched/act_mirred.c         | 28 +++++++++++++++++++++++++---
>  2 files changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/netdevice_xmit.h b/include/linux/netdevice_xmit.h
> index 38325e0702968..848735b3a7c02 100644
> --- a/include/linux/netdevice_xmit.h
> +++ b/include/linux/netdevice_xmit.h
> @@ -8,6 +8,9 @@ struct netdev_xmit {
>  #ifdef CONFIG_NET_EGRESS
>  	u8  skip_txqueue;
>  #endif
> +#if IS_ENABLED(CONFIG_NET_ACT_MIRRED)
> +	u8 sched_mirred_nest;
> +#endif
>  };

The above struct is embedded into task_struct in RT build. The new field
 *should* use an existing hole. According to my weak knowledge in that
area the task_struct binary layout is a critical, an explicit ack from
SMEs would be nice.

Thanks,

Paolo


