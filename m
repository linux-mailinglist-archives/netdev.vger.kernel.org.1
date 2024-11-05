Return-Path: <netdev+bounces-142063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 895F19BD3D5
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 18:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D919283FFC
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 17:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70121E3788;
	Tue,  5 Nov 2024 17:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="byBUU10G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F8384D02
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 17:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730829457; cv=none; b=FofCAO3nm83JgF6UIjUFDe7v31pRvVKNRgh5b5A9lifYyH80WLQN+rQ9SYihIIip+FuXvMa7aLVo+MBJTxFsywS5qQo/pFnBn2cz+Z2v3Eys58UjlyGK9n30mxFzSB/JrY1Qn+C/h3qlnk9aR5Mt8z9ACPdubKFcz6HtVJz22H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730829457; c=relaxed/simple;
	bh=AiOXyZlCFo09MoY4bmYJNlKAIJZcYQUDWFeLuSmA6bA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O3R6laK4o5AzjfoeJ1InNU+agDlHbCREWhk/7M2vNY5tCJWNpml6XjEcEk//z4K/FuMva4vLq2ZbX14dqqZN6WFywe/ZdJ+XZ01nbZv8dOBFAcThfmHUvKxhHGLr3OAQHKcglKBNIF1yODLl8Je1i1GEXNKGO3kMFhogE8tDDfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=byBUU10G; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20cbcd71012so66580045ad.3
        for <netdev@vger.kernel.org>; Tue, 05 Nov 2024 09:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730829455; x=1731434255; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7a6aAXA9XPuBWb0DIySqP641SbdXE6PcUxBtLPMqpNU=;
        b=byBUU10G/cqBiTkHzxnxAK50+FbN2Ez7s9U3SbhtonHYO/tsWMkD3VKESgiS4TCH3h
         i0fFh76lZiPrRL05c58vOykJuUxxGDJ4gSFYF3nWWKgFzzjcPJS3yAMVJtzHgxdoriFt
         dJ5R6WAXNrM+2nnobnqfjtjwrkaFIoGBB1dk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730829455; x=1731434255;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7a6aAXA9XPuBWb0DIySqP641SbdXE6PcUxBtLPMqpNU=;
        b=Jnl206tVMzC3V+dvRMkWa93ALvmWE1OIv/2BHa3TDYwjTQbNFYPIuFnHAgnQKq9vjS
         OzkNuuh7xS3EVY5Gxc633WI4KhA0ESmenHyfZDQIrwEf3mWJrfENnQxF9TS4+66cB7Yp
         kYiC5O5+rlfwJagDC89ivcT8jYewz3qFi+cYqzaFHHTIjDtYOaQEP6oHiwvftIWseFtv
         7zbV1PHlTP4Kg8Bsd3l+BVIMPRnS+Ua37sa0p7MBxPTXPG0PKfOpEjY5qCIHAESw46qW
         N5bl+9XgqBimH3g5k9IDTkpfr680VAIDOqJ5IagpXVzwvB4gmzCawGrtzefarEO6SQLc
         +0Rg==
X-Forwarded-Encrypted: i=1; AJvYcCWXCslF6mk0+9TU51jblPw+uSppI3ggbieex243b/QMQ+qNeoPFp7O8hJ2hyqxbyld4Fuj4dH4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+voxoeVJ0TuyiB2e/c67pRvzO9aSkkXc0+x61d4lY1uktTW12
	nUN/pPQQH4UmHhLqL2kLrIpKq6vv+I8rZDAAlgL5OIfkEGonDo0U8eizdU/VxU0=
X-Google-Smtp-Source: AGHT+IF/jY+AqeOBDLS78e7kdvnuO1KvFxGELOKyAWGA8/f+B53pJqGdV9x1i1gH+wZDcecXCW8JMg==
X-Received: by 2002:a17:902:f545:b0:20b:6a57:bf25 with SMTP id d9443c01a7336-2111aee8a84mr242334625ad.20.1730829455642;
        Tue, 05 Nov 2024 09:57:35 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e93db18128sm10050771a91.36.2024.11.05.09.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 09:57:35 -0800 (PST)
Date: Tue, 5 Nov 2024 09:57:33 -0800
From: Joe Damato <jdamato@fastly.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 3/7] net: add debug check in
 skb_reset_inner_network_header()
Message-ID: <ZypcjNG4z-gQ5-xw@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
References: <20241105174403.850330-1-edumazet@google.com>
 <20241105174403.850330-4-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105174403.850330-4-edumazet@google.com>

On Tue, Nov 05, 2024 at 05:43:59PM +0000, Eric Dumazet wrote:
> Make sure (skb->data - skb->head) can fit in skb->inner_network_header
> 
> This needs CONFIG_DEBUG_NET=y.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/linux/skbuff.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Joe Damato <jdamato@fastly.com>

