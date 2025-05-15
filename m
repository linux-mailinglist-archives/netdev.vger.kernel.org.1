Return-Path: <netdev+bounces-190721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59940AB8708
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 14:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A95783B2653
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 12:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1B829A33B;
	Thu, 15 May 2025 12:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YiYeMcGf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A040D298CB6
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 12:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747313353; cv=none; b=PmXn97fH0hMEYCVyTSQPwO3uFdSQFCWebMzh6orb6FUE7f+AuAxXhQ05V/3Zsd1rao/nFzH0hJX+NeDVLFV4p4onHOeY+HWvRSkyon1R0frMNj63ek4LqG3tC43uaNlmjBk8W2LMWssQpG2I4f+rWg6XYfNw2uEkNW7Yjgs5UJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747313353; c=relaxed/simple;
	bh=dCbb8ywsZWcjBClreW7efNTzbOoYTzghPq2VmBHjgqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WLDQZ0kFPHL+FEByZEqWZvylaOqSQA2I5e8We535gsGFT7df5IR+sP9Nfq6vDRBxn7CABy61tU5zE8TFIY1oX+bfbbHczDwqzYtZBK/w6vCBn0Qpo7gbVIk2BKC6BKoDvKx5/C4705v+Pss+C/lKYhvgpPF+5lgo2GmuRkMJPoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YiYeMcGf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747313350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F7XavHWSM3i2z8lTnk9nHsfzQ0iU3Bzb+tsiNPqcmRY=;
	b=YiYeMcGf6oct3Ucgqwf4QsFXPkJhaDySsqW+UdgjwfN/fQ1TnTWmMSmJUOOk3O4RRQZdCq
	B75iWU89baPtITcTChliY5QymRCG3WlDP/tQAP5k/kd6YiJOg9tXTekPavD/CT6Und7GTa
	UWg2uxw+DrnIfXh8irC2utZXJbGW7EA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-dAOUad9kPwmeKk3ExlPCUw-1; Thu, 15 May 2025 08:49:08 -0400
X-MC-Unique: dAOUad9kPwmeKk3ExlPCUw-1
X-Mimecast-MFC-AGG-ID: dAOUad9kPwmeKk3ExlPCUw_1747313347
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a2046b5e75so428480f8f.1
        for <netdev@vger.kernel.org>; Thu, 15 May 2025 05:49:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747313347; x=1747918147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F7XavHWSM3i2z8lTnk9nHsfzQ0iU3Bzb+tsiNPqcmRY=;
        b=bzp28I1kMnbGfeIBpeRF1QrQsX35k0/J1RJYzY6vGRZydNIjqIGbvlgU0eYxZw+sdD
         lYIEGSezzfc5dzWCxoJBSsPSuTwKp8P/c0GUozcwvUwRS+INYs54fA4MfMlDMgLs/iSW
         gtvZ8W452HDmayndw+ibIsmeB9vcGQQtcnlUytRCgiNQb7lKq3iVXs7mtfHPRQIU8g8Z
         sclR1mDfTwNYN5l//qOtpF/TyPAZzIi+w3aVdQT0sG0lBLbZvMAHr7yL2UrtbgLkivG4
         ntVe8O+9dEgljyf/gMINJ4Ha/XjILqQxJ324YOviQfxTWuvC1WZxe2y4Y4qKfE436wOV
         M5Rw==
X-Forwarded-Encrypted: i=1; AJvYcCWXo4zr6BfJWauOha/LEZW+U2SCw/6jY8PhGqk5ZVKzz8tMWID6IFsSXcNCE54Pverfnwt02gE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBYi1lYe1XT0ScxZAryZ1mfgIaa1bsPS3vOW470wLbrFm6dDXR
	9X70ucdEMpolmZWEQY3U0BHHz/+v3WtkhU3sxWMNzACAixl2ml6bopQHaZ+y8dkpWib9M1xwXHo
	Y9yUJAosFn4g4AcRCInvUQLBX/QpHiok1K+BQ/aATVtBgSVF5TtB4SQ==
X-Gm-Gg: ASbGnctUUYsrF413eu+8HHiukvBM8QMQguYVXsoX2Pe+lonn485IskhRqkIz4FDQ3wZ
	yQNs6VQsbTpuPOfMzLtxd4vg1MMcHLh+NJyq0jaT38u14ZzfWOTLrHVTGht8tgCJbdyBYbWW6On
	h8ZMUFxaSRtft1CjPW3el0uPUngs75U24M2yzBZbvJLBZhYuUvNwxGBYdYFAwDE+OUvARzIjFgR
	V1v1A+qeRqueWJEWrMlyKEyukq3h1c52v5uesVpEZiMLSfpg+Eig8Ge2KjSNZnTrChKvtHkax+o
	+b5OwZI1kXC+H8SUpO4chXRyH2uQRFZntf1JflJUIA==
X-Received: by 2002:adf:f909:0:b0:3a3:55ee:8658 with SMTP id ffacd0b85a97d-3a355ee86cbmr1329994f8f.0.1747313347143;
        Thu, 15 May 2025 05:49:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0z8Z4IWABZZNTzRaHczvZipon+iso448bnAeHeqBaILeA/0ES4MK3K+jZgSD1fRZNH+rKXw==
X-Received: by 2002:adf:f909:0:b0:3a3:55ee:8658 with SMTP id ffacd0b85a97d-3a355ee86cbmr1329971f8f.0.1747313346769;
        Thu, 15 May 2025 05:49:06 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.29.93.152])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58f2f8csm22339420f8f.42.2025.05.15.05.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 05:49:06 -0700 (PDT)
Date: Thu, 15 May 2025 14:49:04 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	netdev@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH net-next v4 10/15] net/sched: act_mirred: Move the
 recursion counter struct netdev_xmit
Message-ID: <aCXiwEVJ8sLJLzxc@jlelli-thinkpadt14gen4.remote.csb>
References: <20250512092736.229935-1-bigeasy@linutronix.de>
 <20250512092736.229935-11-bigeasy@linutronix.de>
 <235b93a5-6989-4131-9099-c0c03bb6afc1@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <235b93a5-6989-4131-9099-c0c03bb6afc1@redhat.com>

On 15/05/25 11:55, Paolo Abeni wrote:
> CC sched maintainers.
> 
> On 5/12/25 11:27 AM, Sebastian Andrzej Siewior wrote:
> > mirred_nest_level is a per-CPU variable and relies on disabled BH for its
> > locking. Without per-CPU locking in local_bh_disable() on PREEMPT_RT
> > this data structure requires explicit locking.
> > 
> > Move mirred_nest_level to struct netdev_xmit as u8, provide wrappers.
> > 
> > Cc: Jamal Hadi Salim <jhs@mojatatu.com>
> > Cc: Cong Wang <xiyou.wangcong@gmail.com>
> > Cc: Jiri Pirko <jiri@resnulli.us>
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > ---
> >  include/linux/netdevice_xmit.h |  3 +++
> >  net/sched/act_mirred.c         | 28 +++++++++++++++++++++++++---
> >  2 files changed, 28 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/linux/netdevice_xmit.h b/include/linux/netdevice_xmit.h
> > index 38325e0702968..848735b3a7c02 100644
> > --- a/include/linux/netdevice_xmit.h
> > +++ b/include/linux/netdevice_xmit.h
> > @@ -8,6 +8,9 @@ struct netdev_xmit {
> >  #ifdef CONFIG_NET_EGRESS
> >  	u8  skip_txqueue;
> >  #endif
> > +#if IS_ENABLED(CONFIG_NET_ACT_MIRRED)
> > +	u8 sched_mirred_nest;
> > +#endif
> >  };
> 
> The above struct is embedded into task_struct in RT build. The new field
>  *should* use an existing hole. According to my weak knowledge in that
> area the task_struct binary layout is a critical, an explicit ack from
> SMEs would be nice.

Agree. Still fitting in an existing task_struct hole.

Reviewed-by: Juri Lelli <juri.lelli@redhat.com>

Best,
Juri


