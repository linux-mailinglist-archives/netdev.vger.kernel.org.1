Return-Path: <netdev+bounces-122271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68F0196096A
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 13:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98A381C224EE
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 11:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 807151A255A;
	Tue, 27 Aug 2024 11:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="E/IxwCK5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8530A1A08DB
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 11:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724759893; cv=none; b=ivJemhoRY8EbIFenXkVZUCtLest+S8c8nIKWOpvxKbrc0fCExaGfQvZdkpTBCSmiPK3qIUEsiaRNGKr8sgfu7gfblNpZWOiG34oralLVMk6i1jq7L4obTW31FTLOndy62wPl0Xh4GhVJsmtcLnt9x914NLPU5G0mHwSIyHrJ+vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724759893; c=relaxed/simple;
	bh=wHZZAO48QwUQl4C8SVybwIdiXinI08bZfDXRheCDFV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QFvmu+/l5Jpc/3JauyNvE805oDpzsMJlxNzxkmJXkqQcc/t3NkS8lPejX27A3BRtJumrC1H4bgxuZFNatoDnyHaTWC5JqjZtMLeEhXaKY9Zty0Apc9ZMXlBXFqBB+xELTet3m7OYPwBDeqagkHPSzvEG/rdP6BE+LfCDWc9DR+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=E/IxwCK5; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a8684c31c60so650550666b.3
        for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 04:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1724759890; x=1725364690; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5LGzp93ZA83NjtN3z8hI3U3FaWLAnlChbexxx3SCTeo=;
        b=E/IxwCK5tGITTXX5fkAp+97zRS/RE88d4ihaS3MWJ/s6uQHhqm/xFBwW/vH8ZawulN
         dBxqGmnUPlqATmETgNIg2CTNPXgX2ECbZrTifZkOjoUzpjm/3ZYa7wBw3GD8uHnqcLgn
         OAF36N+2wNnZ/IuU2B+qvoxgGTuQViV8aAzK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724759890; x=1725364690;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5LGzp93ZA83NjtN3z8hI3U3FaWLAnlChbexxx3SCTeo=;
        b=QVBs578rb05L8Jine62x5FuJLH2I3ThxkxbIF1syP1iwgMMlkV773cKeqoUZpvwYrR
         /07wGves5Zy6zhuEUHuY5g+cnhjxzYAfImthOmnFL3GuX+UoZK2Hd+wCQhUApTAKktl8
         /CMu0G8ZNUyxP0T+spvXLxoGHO2VuXsJ1FVqszsI4og2oNT35mvUNvfkJRLOwPY9Drlx
         jXYwB9ss5UqthmvhIvgbDqnCcF7ySUEYgBcgU1/AZs/w/vsi7WfFQ1XXo0fLJP25FC3Q
         macduUpslV5sRmcbbQAk4fVdlpP5591yJpXL4yE4SiMCpDvzP1BXsHvD4VP9HAfJrL8Z
         W4nQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkgzddlMzYCkkbCgrLExFruqIFB2vJv+u8W3agtuPF5p+XmQFn7sunZ1u6/QApaXtcl9UBO8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMgwS8+zojj2rBGEBZDS42lPTtuQsxZEpYRcjZnCBEnQiLSHTe
	l2DEVIq+roYipQxlQhzNZaZUAicUg3IqporMOBpQ86el74pF8CyKkf00yrk10dU=
X-Google-Smtp-Source: AGHT+IH1hidEnxJBolSBN0R9OWOXseXOTDNTkk5eu9DVdpdiwKvN1ig2IBsGyBT5XLr2kD8VnPlpUg==
X-Received: by 2002:a17:907:3ea2:b0:a86:8a18:1da0 with SMTP id a640c23a62f3a-a86a5188f59mr827440766b.5.1724759889394;
        Tue, 27 Aug 2024 04:58:09 -0700 (PDT)
Received: from LQ3V64L9R2 ([80.208.222.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e594a5e4sm100522866b.202.2024.08.27.04.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 04:58:09 -0700 (PDT)
Date: Tue, 27 Aug 2024 12:58:07 +0100
From: Joe Damato <jdamato@fastly.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	Mina Almasry <almasrymina@google.com>,
	Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net] net: busy-poll: use ktime_get_ns() instead of
 local_clock()
Message-ID: <Zs2_TzLC1najJ2Ip@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	Mina Almasry <almasrymina@google.com>,
	Willem de Bruijn <willemb@google.com>
References: <20240827114916.223377-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827114916.223377-1-edumazet@google.com>

On Tue, Aug 27, 2024 at 11:49:16AM +0000, Eric Dumazet wrote:
> Typically, busy-polling durations are below 100 usec.
> 
> When/if the busy-poller thread migrates to another cpu,
> local_clock() can be off by +/-2msec or more for small
> values of HZ, depending on the platform.
> 
> Use ktimer_get_ns() to ensure deterministic behavior,
> which is the whole point of busy-polling.
> 
> Fixes: 060212928670 ("net: add low latency socket poll")
> Fixes: 9a3c71aa8024 ("net: convert low latency sockets to sched_clock()")
> Fixes: 37089834528b ("sched, net: Fixup busy_loop_us_clock()")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Mina Almasry <almasrymina@google.com>
> Cc: Willem de Bruijn <willemb@google.com>
> Cc: Joe Damato <jdamato@fastly.com>
> ---
>  include/net/busy_poll.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/net/busy_poll.h b/include/net/busy_poll.h
> index 9b09acac538eed8dbaa2576bf2af926ecd98eb44..522f1da8b747ac73578d8fd93301d31835a6dae0 100644
> --- a/include/net/busy_poll.h
> +++ b/include/net/busy_poll.h
> @@ -68,7 +68,7 @@ static inline bool sk_can_busy_loop(struct sock *sk)
>  static inline unsigned long busy_loop_current_time(void)
>  {
>  #ifdef CONFIG_NET_RX_BUSY_POLL
> -	return (unsigned long)(local_clock() >> 10);
> +	return (unsigned long)(ktime_get_ns() >> 10);
>  #else
>  	return 0;
>  #endif
> -- 
> 2.46.0.295.g3b9ea8a38a-goog

Makes sense to me, thanks.

Reviewed-by: Joe Damato <jdamato@fastly.com>

