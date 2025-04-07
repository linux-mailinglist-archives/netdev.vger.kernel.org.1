Return-Path: <netdev+bounces-179561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B0AA7D9B5
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 11:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57DA5168DBA
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 09:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCB51B3955;
	Mon,  7 Apr 2025 09:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ta9ZLSoZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2201A5BA3
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 09:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744018414; cv=none; b=dGY89f2C9VsvGPT6mDnJqJxg0Q5b8bO9wUgY5Za6f3GgouSi2r1t8Ad95KpbTuCiTHkInSSW/8VoLVgf8hLh8LxOfVmnsFmgujZuR1CIiqX9Qw5UdheQzXxUl2J5XfTroKltu7V7hyvgZQ+SFf/pNehQz3O30VKe9Hfi1RxGN+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744018414; c=relaxed/simple;
	bh=tgT1LrnqYgrS5eql63LRpugnK0ui0G5PIUMiBaqknD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jCygnjaF+hsYrxKMlHMtuRHORZX/+otmUfGKGTs0uuOlSVJ9APDI+yQuxyGxEQ0Tc13Cp0MaU+p76sAFGLQREuPQRImq01o8UvIrCbuePXhbD0zNHda9qaPm7YKRZndsgsMTB1dzDUXTfUDtQj3ACZJmMIKvpqhfGm6sdbCngsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ta9ZLSoZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744018411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=441tE+Tmh6SSSq0pafdr9Ks6zWoEBrFm9sf0mm65S3w=;
	b=Ta9ZLSoZvh/bA7BqEwIfbL4WTtN7v/b8qbak++RQ7pttYBt/HucTmxCD0Vgw7X3OZp6ZuZ
	iGxt1DrKgoWVhCfecuHr70wkaQXk+Fv4J59r2zVlgDdxm/S2aGEvKAKgZpa321QpX6qQJT
	vRFO+uScFzUyfReSQPZJzj0tszsINvg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-I2jYEv_EN6Cbn-cr4hl_sg-1; Mon, 07 Apr 2025 05:33:30 -0400
X-MC-Unique: I2jYEv_EN6Cbn-cr4hl_sg-1
X-Mimecast-MFC-AGG-ID: I2jYEv_EN6Cbn-cr4hl_sg_1744018409
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-399744f742bso1171084f8f.1
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 02:33:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744018409; x=1744623209;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=441tE+Tmh6SSSq0pafdr9Ks6zWoEBrFm9sf0mm65S3w=;
        b=jvQ5tVkNjE4MUPIvxEtVb6+wUUQagF+g0B06JnaeAQyXQj36gBbWnXtJfQ7u6P5Rvo
         /AC93S3xCZVAuEELP5MbDLuotHvXqNb8Aa0vxASh7KVnriOkDaxUCrA/pZNtMZXUe996
         tdEUKIBvU5mGRGURaV0d+l478ChmA/HICGh78NzPhm5Mnt7ZVX6ho4WI+4BLvGFYVp5c
         Nzs6sszq/txjxRnNKW7UVioJmQkge0gvg4G8uqDh1HL1++OS+jxWQXGgH+zSq/i0t+06
         ynXRKx6/Y79bsmW5gP32yHL9nyLQ6ookE3z4jBCh+jCC/MQRqK4Y1V2eEdgc3jkqBG24
         OymQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoKeNMlw3ly6sFCZhI5EqThxI2uaD9nLceGBEnAy5l3qDEryZRWmUyJz46A7WmSJYSNZ9gljU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrGgcwkKZ+ClGDFaShnvH9W1pplx4G8RgD0gI/FT0IgGpAyLBm
	8OOo2gwhUvN+JZBOL3LJVsRcJ5Ot5b6SqBA5k49uSUY0YGPskE4aGHXCA3NtMRBTTcoKtBiXeEf
	FAoA93YjooLdHgecLSiYYGYDNk11eALF4Clk0IatIrIk4/lmlAmIu5A==
X-Gm-Gg: ASbGncs0fzt/37vFFFK/byW+sDT4J4vlxpH3KEwqdMHI1DLIOCuYt8rser3f4fSip8f
	iBf+k9IdC6h6H81TbFqwDxrI718EEp+Z676wCg398mkQ+8NnSXHYl3XhfO+wnsojbrg1fp8MWv2
	Uw/hV3QuXUKbY6JV74B+l3UXa6BJLb25NiqZ/gZjN8kNSH35EzvfR42bQNG8536qBcWJ1XuL6mo
	xTTdEJSgUSP8o3Cja5ZfUREe5AI+dBzNOcNmW9QrNp61R/8FuvOzM7fVhcOQytcFsnOOSS++Z0s
	bltAnVXHdHZXIJTTC2Fj6DPk2FgMYwebynnjm63k0pyHz1s=
X-Received: by 2002:a5d:6d8a:0:b0:39a:cc34:2f9b with SMTP id ffacd0b85a97d-39d6fc291b3mr6246163f8f.16.1744018409030;
        Mon, 07 Apr 2025 02:33:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBolTQSF/57rvjzSXqBYXmJPqcsNVa8ShQLgffhCmYqYrNC02OtDRXnbbO61LGvPp6q95GEg==
X-Received: by 2002:a5d:6d8a:0:b0:39a:cc34:2f9b with SMTP id ffacd0b85a97d-39d6fc291b3mr6246139f8f.16.1744018408664;
        Mon, 07 Apr 2025 02:33:28 -0700 (PDT)
Received: from jlelli-thinkpadt14gen4.remote.csb ([151.37.215.184])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c30226cf6sm11371971f8f.87.2025.04.07.02.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 02:33:28 -0700 (PDT)
Date: Mon, 7 Apr 2025 11:33:22 +0200
From: Juri Lelli <juri.lelli@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Valentin Schneider <vschneid@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Ingo Molnar <mingo@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	netdev@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH net-next 06/18] netfilter: nf_dup{4, 6}: Move duplication
 check to task_struct.
Message-ID: <Z_Ob4niUHgSjS5x1@jlelli-thinkpadt14gen4.remote.csb>
References: <20250309144653.825351-1-bigeasy@linutronix.de>
 <20250309144653.825351-7-bigeasy@linutronix.de>
 <99214ac9-cff7-4a5c-b439-ed9ec2c6877c@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99214ac9-cff7-4a5c-b439-ed9ec2c6877c@redhat.com>

Hi Paolo,

On 17/03/25 18:29, Paolo Abeni wrote:
> Hi,
> 
> On 3/9/25 3:46 PM, Sebastian Andrzej Siewior wrote:
> > nf_skb_duplicated is a per-CPU variable and relies on disabled BH for its
> > locking. Without per-CPU locking in local_bh_disable() on PREEMPT_RT
> > this data structure requires explicit locking.
> > 
> > Due to the recursion involved, the simplest change is to make it a
> > per-task variable.
> > 
> > Move the per-CPU variable nf_skb_duplicated to task_struct and name it
> > in_nf_duplicate. Add it to the existing bitfield so it doesn't use
> > additional memory.
> > 
> > Cc: Pablo Neira Ayuso <pablo@netfilter.org>
> > Cc: Jozsef Kadlecsik <kadlec@netfilter.org>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Juri Lelli <juri.lelli@redhat.com>
> > Cc: Vincent Guittot <vincent.guittot@linaro.org>
> > Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Ben Segall <bsegall@google.com>
> > Cc: Mel Gorman <mgorman@suse.de>
> > Cc: Valentin Schneider <vschneid@redhat.com>
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> I'm not a super-fan of adding more flags to 'struct task', but in this
> specific case I agree is the better option, as otherwise we should
> acquire the local lock for a relatively large scope - the whole packet
> processing by nft, right?
> 
> Still this needs some explicit ack from the relevant maintainers.
> @Peter, @Juri, @Valentin: could you please have a look?

The additional flag fills a hole, so, FWIW, I don't see particular
problems with it.

Best,
Juri


