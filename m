Return-Path: <netdev+bounces-219640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 669E6B42753
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 18:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 137821B24D51
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 16:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFC02ED860;
	Wed,  3 Sep 2025 16:55:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7973A2BF3E2;
	Wed,  3 Sep 2025 16:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756918512; cv=none; b=ga4RF7kkZz/izJIJsKFHLx/6vodaP6GPFErSG5ATL8GSP+z+hb1yJJojHvKqCQCnHadK6txstdbezOva/RY/Lut65a7hrGSlFPY+aOFCnC0IiZ46Xq5MZ1CvUvfRrekPXvPiMmZGiA7gAWvHZuAFyKo7rJG7/OO1K/eVE9utf6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756918512; c=relaxed/simple;
	bh=30uqmxUWwwZjA2mmV57rJmq7l79ruMZyoiTHZmBLM9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c2WsD1/SXqOz14itcRxgmPHCimuPTLLCVqz3Ckow6dHRpvHm/Zf8XNpFhDPOlHeJZcsznwIVGtmLSKIOoZx+tTxOZMYV3tSMetjqpH6PgUzgSsFwLCLjF5qGUI8nqsUNbEiKLfgk8ecW3kwla8oG+Ku3AqdLo1ArrEn1eZDeU3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b042ec947e4so15671066b.0;
        Wed, 03 Sep 2025 09:55:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756918509; x=1757523309;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QDdwyuaVc8VSTl6NQmoSrQNloKdIcjoMxK537r629qc=;
        b=Hm5VRHh8XC/qrU+6rsQP9bnekGF4VjM2ZBzidiPE1b/21Q2wOlL5EEnaGmBPm4+BaY
         7dlOhatbdvNPGZLhhgbEKfi+atfrv/Xwvlnfs3yhdlXP2z/9AraBW8KPV4Ln+MHEgSsE
         g94L7/iaGyO4hfSsN0uU6pFrXAuvAhr0iQnJN7yNK85vrz29KxBiicsr1Bmphy8A0ew1
         bfm1vD6D6jMq7z7EAZuvu2OUSKSEZRX48/ggiy+o20/NIjGGnUAIu9WLBQhNmYByMrFA
         vZc546GKAlybLQgT65m1C8bDourNVeelzzzIWngdzPzjkS/DfpiF2xxQSE8CSjuR8JV0
         Rmyg==
X-Forwarded-Encrypted: i=1; AJvYcCUUbQ07hsOtOIXGbBmZ6etRCeg9SSNy8/k53i+v5FXQHgT0Gu//BEeRPXOLJP7SJU77Fh056CIN@vger.kernel.org, AJvYcCXqMwe1EKIlgH/4VYKNfB6oP04fAAnFPWnSs4E1TFq1xq+k0FgCI1GnJN+syrqE1wqwo/DOzWIw9ndSNkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEUn3N6lu1s1o/VzhOIqSPGDPO2az8JaL2UJs5+cZQhvcVaHzr
	WkAefwkEqkCFEaXOF4t9QslWiNvU1eR6l5Y1zB6PZS+87VOzlrtBUiWO
X-Gm-Gg: ASbGncuT0jSqGVLULzYwzaxmN8fWaqfPU3zdPTi+RcL5VsYapHRh9EV0JNB1Y5nkCx4
	U7HYmttCD35nW6w0GumJNz8hVjePSBmzplSaFmW8YWeBkuAGS73JnVp1SYF/Zey0P4QI8c3Mbm3
	9QV0gI7Hs3gQiffaIf2CG8IAa4INKWncwelSGSHiq7ThJKt8qvGA19RhWfoagrYfGuWKvGN1L7w
	0vMpNXog925MjPmnyM+/PcuCZgdWOdvghnd9HsTSqE06Fxz63UMnQn2QcfitVggPgeQuD/5VusS
	KZvZyfg6vjAlStzVHF7D9YsZzjJIWcTGoND3RtAEydFTrEzmSfmnoEMIQrfkcGcBpxAcAQoy933
	kp5RNi/4pG+/hetrEuokZXhI=
X-Google-Smtp-Source: AGHT+IHj2ea6XeYQe5FG+mFIfrJNdxtnyrHgGC5qizxT1Mt2Lf2mzyFI4yV+cXlZTyes3qLz69Uv4A==
X-Received: by 2002:a17:907:9444:b0:b04:4d7b:9ad2 with SMTP id a640c23a62f3a-b044d7ba932mr805242366b.39.1756918508646;
        Wed, 03 Sep 2025 09:55:08 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:6::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0236d310casm1115557966b.44.2025.09.03.09.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 09:55:07 -0700 (PDT)
Date: Wed, 3 Sep 2025 09:55:05 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, kernel-team@meta.com, efault@gmx.de, calvin@wbinvd.org, 
	willemdebruijn.kernel@gmail.com
Subject: Re: [PATCH 7/7] netpoll: Flush skb_pool as part of netconsole cleanup
Message-ID: <sz3tq6rkykm2565stkd4qhj6k6t5wtd2nwboby47goq32hkfor@xwlmwuy7y27x>
References: <20250902-netpoll_untangle_v3-v1-0-51a03d6411be@debian.org>
 <20250902-netpoll_untangle_v3-v1-7-51a03d6411be@debian.org>
 <20250902170938.0d671102@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902170938.0d671102@kernel.org>

On Tue, Sep 02, 2025 at 05:09:38PM -0700, Jakub Kicinski wrote:
> On Tue, 02 Sep 2025 07:36:29 -0700 Breno Leitao wrote:
> > @@ -607,8 +596,6 @@ static void __netpoll_cleanup(struct netpoll *np)
> >  		call_rcu(&npinfo->rcu, rcu_cleanup_netpoll_info);
> >  	} else
> >  		RCU_INIT_POINTER(np->dev->npinfo, NULL);
> > -
> > -	skb_pool_flush(np);
> >  }
> >  
> 
> Please don't post conflicting patches to net and net-next.
> Fixes have to go in first, trees converge, and then the net-next patches
> can be posted.

Ack. I will wait until the invalid cleanup patch[1] lands in net-next
before submitting a v2 for this change.

Link: https://lore.kernel.org/all/20250901-netpoll_memleak-v1-1-34a181977dfc@debian.org/ [1]

