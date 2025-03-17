Return-Path: <netdev+bounces-175399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1A5A65ADA
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 18:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C60F3A3F81
	for <lists+netdev@lfdr.de>; Mon, 17 Mar 2025 17:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42871A23B5;
	Mon, 17 Mar 2025 17:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yif+GOWk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B2DA48
	for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 17:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742232599; cv=none; b=HJ2i33AG72wZQ4cX2/9Sw6joF06YOmaEnge5CzHIQwmni9ztqbMMtWYcGGGK5u4stl4H+ItOTajb/ps0v2zW1R2ckdhmkQPL4Z8j8Ko3a44f+zscUS/3FaXSajPppQrIR+gYyNQbZAEufh79PIi56gFCBleDkmvI9kaV1Vyxo3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742232599; c=relaxed/simple;
	bh=HR5k8BiL7B2OPxerAEdBBqmo9n0+6ON8MsRWRTCDshU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dTE8l4Mvnx9ZQVr+2mEOlcaeiqy5jXo0MyZLQPP52jDjnXJl/268B/3XIQ1V+LDvOcBv3yyREem3vti3UzYyvr5HhObhiJZmmtU/lH5JCWrh4r7oDYSwubpQX8rSKUqPSOHbYn2ZOehzBzAAcFkUzprknYCEKAm9AsA5Z2gB1Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yif+GOWk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742232596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jLiAoQcg8KzfhuMFjYbt4oXsOhzaJWAzjx8x5W0S0QU=;
	b=Yif+GOWkahVVwF/n0W4tjoaOpoSBaxtwqwvh1OM/DLv4o2aI6PlhrFLr2KXsIwfTyd0rzL
	h4vQ5s8MIOC+o3wh3bflt4tcTnZiX8Y8mPwEn9L1yoWxAKv2wiwt4RX75vXG+3U9thacfE
	4pkZ5FrHrh9qKrLLw8E7h4H/V9aywmk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-xPnOgDEqNBa0n6h4zQRzPQ-1; Mon, 17 Mar 2025 13:29:55 -0400
X-MC-Unique: xPnOgDEqNBa0n6h4zQRzPQ-1
X-Mimecast-MFC-AGG-ID: xPnOgDEqNBa0n6h4zQRzPQ_1742232594
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3978ef9a284so1136486f8f.3
        for <netdev@vger.kernel.org>; Mon, 17 Mar 2025 10:29:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742232594; x=1742837394;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jLiAoQcg8KzfhuMFjYbt4oXsOhzaJWAzjx8x5W0S0QU=;
        b=SuzVZ0PsBzu6gt0CBdCAWh2eKACDOAShED/Kc7Rf+enZKm/vCVuUXBebicgu5/DBPG
         S6x+JJmUaOplwRQeJyfuNH3ttXc/xMJVVZUDzreOOD05OQOn6Gs+pram10eyui3MBoxm
         tVVaM7dXbDXb5zHYyvt2NcFRIa2FostNwgej4EI3J0FzMGzLNgQ3vKwGHTwOkbkZSaw4
         6kgVmzpqy6DQIKPhy66wEIGUSpWmLmxx1LS7ywPnsz66j8nnB+IjIij3TD1VOAWwJf3M
         YugY6UvacG/+0EhGdKEEazJxPm86DoOvjLiERVMl7FW/jmx4iGnr+woCpqBXP3KlkXO/
         lneg==
X-Forwarded-Encrypted: i=1; AJvYcCXuYA3c9dFTe9qxVxf3ZNpSBX0Y618ujfqjN04cOvLIl1c69Pw3oW1llNE2uakwMu0WXHFVhzg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOeYyGuTWSlsf9+LSpydx+jjSzLPrqA7Pvm6HRl+OLYcEatwA/
	mtYFQ29W6QFD8SOEio39592gETJuQe0xW7/PRlk3RLO+OSivpaKSVDiqgazFIyG+J0/FXmompxB
	mJGwD0fiO8EMGIfabVTDFS57uHVQEIc0J7VHVElcD91xKVifFeBkozg==
X-Gm-Gg: ASbGncuuWSyMizf8fI/CbjSjglAzsiPS/adjzcYi2hZpb1U1uFwODBrB/8s+PlZI04E
	JIFSAjYwf780v1f50YO8CvHMjNqc/SynTyhOjOc9n7XtHH4Q33WC52Z4ftuxbiUUb3C970Ee7u0
	fzcdjuW3+f186RRGoBFtB43sxoqpPGrnt5cv6rldeJiWwxrQVJcGMior9ycLWfNTEFzqZhjweiD
	zY7LQVIarMaVPUQOZZeHMYOUuIcP1sp3B68S/ytDsqMX+AH42jbFjLVI+XwIXgy2LDCgI3hjKtq
	AjPDLfaS0KmwY0AUjdFMxpocRSBzz/lKNM/Dd73UoPg9Zw==
X-Received: by 2002:a5d:5f93:0:b0:38f:355b:13e9 with SMTP id ffacd0b85a97d-3971d42ae27mr16648600f8f.15.1742232594174;
        Mon, 17 Mar 2025 10:29:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkszNmgMJv2EU7OnN6gBdg2W+Pp+zusqYC+Tkof3RN2Cf33xU23BRZDTBqd0JusGhCLQWrCQ==
X-Received: by 2002:a5d:5f93:0:b0:38f:355b:13e9 with SMTP id ffacd0b85a97d-3971d42ae27mr16648574f8f.15.1742232593799;
        Mon, 17 Mar 2025 10:29:53 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb318acfsm15911566f8f.70.2025.03.17.10.29.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 10:29:53 -0700 (PDT)
Message-ID: <99214ac9-cff7-4a5c-b439-ed9ec2c6877c@redhat.com>
Date: Mon, 17 Mar 2025 18:29:51 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 06/18] netfilter: nf_dup{4, 6}: Move duplication
 check to task_struct.
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Pablo Neira Ayuso <pablo@netfilter.org>,
 Jozsef Kadlecsik <kadlec@netfilter.org>, Ingo Molnar <mingo@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, netdev@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
References: <20250309144653.825351-1-bigeasy@linutronix.de>
 <20250309144653.825351-7-bigeasy@linutronix.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250309144653.825351-7-bigeasy@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 3/9/25 3:46 PM, Sebastian Andrzej Siewior wrote:
> nf_skb_duplicated is a per-CPU variable and relies on disabled BH for its
> locking. Without per-CPU locking in local_bh_disable() on PREEMPT_RT
> this data structure requires explicit locking.
> 
> Due to the recursion involved, the simplest change is to make it a
> per-task variable.
> 
> Move the per-CPU variable nf_skb_duplicated to task_struct and name it
> in_nf_duplicate. Add it to the existing bitfield so it doesn't use
> additional memory.
> 
> Cc: Pablo Neira Ayuso <pablo@netfilter.org>
> Cc: Jozsef Kadlecsik <kadlec@netfilter.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

I'm not a super-fan of adding more flags to 'struct task', but in this
specific case I agree is the better option, as otherwise we should
acquire the local lock for a relatively large scope - the whole packet
processing by nft, right?

Still this needs some explicit ack from the relevant maintainers.
@Peter, @Juri, @Valentin: could you please have a look?

Thanks!

Paolo


