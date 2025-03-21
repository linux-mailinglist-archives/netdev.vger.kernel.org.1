Return-Path: <netdev+bounces-176768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8F2A6C109
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 18:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE3A73B4420
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 17:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE771DE884;
	Fri, 21 Mar 2025 17:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rvrk2R3A"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B4022D7AB
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 17:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742577307; cv=none; b=X2EqrXOKoLshenij2ILdyMBzJeklYy71nYdpXfCO4d2YJ0vs9f3H/y4drGpOXsUlHRH7g23kngp8eOV0wU+v89bGUBYHX9Wk5R7V+tEeuvwBQDLsjn/F9kZqZYGCZPF7ygLj7BkaraCH9UHQFB6/yuQ1HJChHizrojehZsDip+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742577307; c=relaxed/simple;
	bh=/Pc6ln3sJ2kspyKjYFBc1b865couGgE0dagD/dAEJGg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s7eMgnrmzNgka0ABVkkUqppR1aHVR/tMq1ZNGWJCQF1X2mbCHik6n3fmns5i7UQGJ1ep9Bxznz9pR295RY1IJaD/7kwKzv2HfLTm+KH1MjwVtIiQ0cL90DmWcXqv4tckZz2H8fCHk0VI5MQNpWbjDlpNs7rGZwVXRc+zxgLrBJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rvrk2R3A; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742577304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=34iI9dINlmG5alUqqmmlTwB9Vbf82RIIZH6tCAXcPqQ=;
	b=Rvrk2R3ABVuVo2B2IyigM0AtkZBOIhp0x8Iwg7UUM3dD4UBffAZl6TgwfC0fhayU8FW58/
	K7aDfmHUce9H9so83inbuFtRK0cGmArgnQB1J97cDVwjfheS5xxs4xoKb3kWSAix0cW6K0
	Ouvq8XVDd5R3SAncrJKxv5Pu7SOmRCE=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-Joeg1BlqORmnSYxxIcYkoQ-1; Fri, 21 Mar 2025 13:15:03 -0400
X-MC-Unique: Joeg1BlqORmnSYxxIcYkoQ-1
X-Mimecast-MFC-AGG-ID: Joeg1BlqORmnSYxxIcYkoQ_1742577302
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-301bbe9e084so6353413a91.0
        for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 10:15:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742577302; x=1743182102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=34iI9dINlmG5alUqqmmlTwB9Vbf82RIIZH6tCAXcPqQ=;
        b=lOzw5uUs4C0FCLHiBZCfcBWccBH+FpBLKB81UchpHKvzFp0VLynjvmP3Wn+8KJhgeZ
         wCJfr8iQUyw8HbLjoVmtiVcDcllb/BjoH9gwwaAZCmPYujbwVUYrfwM9aJ2N8CNf1rlx
         H28oMnFyJz8ZZGU6h4kTqdaZ68iQ0S3bUQ7FuuO6eTAuh72vCql7ZFBqHPjgREI2J2Kl
         IwFyN4ihm8uLgowYdXQ2eRZaSrjmzN25iY2AbE3T9UeDuPwZHrXfhe/gqmmq7/41Ei3c
         dtoLLcDWg9redcaI+ahP4hkrFnjOYxyJEn9si+CBfSb3gcBOFUlwdmA1f/SQ33/s7jUc
         9jZg==
X-Gm-Message-State: AOJu0YwqhoeA4Q6DzoDiepJRgQ5qFElD45p/VGFZ9x6lLhB2gHMCz9Eg
	LggAOsvASwzKkF9ynUhXpf9gglwsi3YWSjljQLo1IeuwEROwH7+kFTQOkrMGF1G6PDJbQvEXjKR
	UoV7HhjrM+XzUqeK3IHWwNWZPZuF3cWXsyqlML4pwUsOzGoRKsKQF5mtMR9rp7wSXt0TW+zw/2g
	zTMJ98fLlaAZQ4V1p80Y/UFNXUBMhW
X-Gm-Gg: ASbGncvYGL+LiWOliwrWQhmIJyKH7c6OxcPMp+l8qbS9lAwV8rQ9QOgtsoY5nTnUEEs
	+sbergD9G0leRiqCSXSZVdHEC3KAqDEbRtVpxeB4DtjaR1GIyie3dpbSgHQxJZIf5UL1aDbS7pU
	4luJ1ZyhHZAvQF0z9nHKom075PJJFR
X-Received: by 2002:a17:90b:4c0a:b0:2ee:ad18:b309 with SMTP id 98e67ed59e1d1-3030fe6e1fdmr4926138a91.3.1742577302019;
        Fri, 21 Mar 2025 10:15:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGg3SVWAv3wa5Cimyz9NjCggOs6jOlufExU13jLuWFRr+Ocyg7ZpHzQTOedv7DHDxaLe7mpmWE5V/Yo8m5Hi9U=
X-Received: by 2002:a17:90b:4c0a:b0:2ee:ad18:b309 with SMTP id
 98e67ed59e1d1-3030fe6e1fdmr4926108a91.3.1742577301535; Fri, 21 Mar 2025
 10:15:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250309144653.825351-1-bigeasy@linutronix.de> <20250309144653.825351-14-bigeasy@linutronix.de>
In-Reply-To: <20250309144653.825351-14-bigeasy@linutronix.de>
From: Davide Caratti <dcaratti@redhat.com>
Date: Fri, 21 Mar 2025 18:14:50 +0100
X-Gm-Features: AQ5f1JrsOBRY2D38k93U5tBRuv9FGKS8iQOFZBJI6uqBXasiujr5D92i-Wcqb7s
Message-ID: <CAKa-r6s69JbQX7ZuGiz37bbfQYWs+r6odhVB7Ygct8DYN=ApJQ@mail.gmail.com>
Subject: Re: [PATCH net-next 13/18] net/sched: act_mirred: Move the recursion
 counter struct netdev_xmit.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

hi,

On Sun, Mar 9, 2025 at 3:48=E2=80=AFPM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
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
> diff --git a/include/linux/netdevice_xmit.h b/include/linux/netdevice_xmi=
t.h
> index 3bbbc1a9860a3..4793ec42b1faa 100644
> --- a/include/linux/netdevice_xmit.h
> +++ b/include/linux/netdevice_xmit.h
> @@ -11,6 +11,9 @@ struct netdev_xmit {
>  #if IS_ENABLED(CONFIG_NF_DUP_NETDEV)
>         u8 nf_dup_skb_recursion;
>  #endif
> +#if IS_ENABLED(CONFIG_NET_ACT_MIRRED)
> +       u8 sched_mirred_nest;
> +#endif
>  };
>
>  #endif
> diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
> index 5b38143659249..8d8cfac6cc6af 100644
> --- a/net/sched/act_mirred.c
> +++ b/net/sched/act_mirred.c
> @@ -30,7 +30,29 @@ static LIST_HEAD(mirred_list);
>  static DEFINE_SPINLOCK(mirred_list_lock);
>
>  #define MIRRED_NEST_LIMIT    4
> -static DEFINE_PER_CPU(unsigned int, mirred_nest_level);
> +
> +#ifndef CONFIG_PREEMPT_RT
> +static u8 tcf_mirred_nest_level_inc_return(void)
> +{
> +       return __this_cpu_inc_return(softnet_data.xmit.sched_mirred_nest)=
;
> +}
> +
> +static void tcf_mirred_nest_level_dec(void)
> +{
> +       __this_cpu_dec(softnet_data.xmit.sched_mirred_nest);
> +}
> +
> +#else
> +static u8 tcf_mirred_nest_level_inc_return(void)
> +{
> +       return current->net_xmit.nf_dup_skb_recursion++;
> +}
> +
> +static void tcf_mirred_nest_level_dec(void)
> +{
> +       current->net_xmit.nf_dup_skb_recursion--;
> +}
> +#endif

sorry for reviewing this late - but shouldn't we use sched_mirred_nest
instead of nf_dup_skb_recursion in case CONFIG_PREEMPT_RT is set?

thanks,
--=20
davide


