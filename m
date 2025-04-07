Return-Path: <netdev+bounces-179610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42354A7DD20
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 14:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B5883AD6E7
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 12:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C21723BD16;
	Mon,  7 Apr 2025 12:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="xRNtHMCf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E46622B8A8
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 12:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744027517; cv=none; b=M2pCq+gxfCLa83qZ/+xHuU0Zfc6N3bTGfOxIPGOrcWgg+F/5hSaBw1smsnvGtmS8kOQSIfXZNBXTu1HUnkiIUhng4Gd7rBiJ1pf9szmh2GGJtDZZuQpNVf+sbteIhHn9BvWlf43ypDv6enBP1zP8OKLGbq44jyKoCzc22Lm02P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744027517; c=relaxed/simple;
	bh=deic43YF7Kqbw8Cci++bMKU/sSHEFj4fgBR5u0HoqSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jwFPrwGP9sJERy4SYLOGyhYGdqIFQUy1gH+cyZ+9Ewve3RxAJs159pyuT2BUhgQfiP88LfMJZz2k6cT1Rb75vce82Rb9tBFm66AIOKfSa6xHFCGk8xm1r3pMGAmn7VgzNx+w+k83HJ9J6pzNERjSXnS5kiVdeZpygweQlTuWcKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=xRNtHMCf; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43d0359b1fcso26738745e9.0
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 05:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1744027513; x=1744632313; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=deic43YF7Kqbw8Cci++bMKU/sSHEFj4fgBR5u0HoqSQ=;
        b=xRNtHMCfWYUMZKOMPmH7Lsp759a9R5Kwqhy2W1JLzIjTY4jvgg2L3EO5nndeL+F/CC
         uJM9xsf9PZ/mJ1i6M/m5m1VV2KojgK2HE45MffKrSBP9UGw9A0naS+W++SiwiXxip2Ye
         +iv3W1a2U/HCGPDSRLvadoGpCLU4EUJ4qUkGitIbWjOwiFctDygRPteljC8XwYNf045r
         qnfR8D8rccBNpCU8eNHra/qjw8RltGeZ/twLDjbxLl6acmQ+FdIw07iqzo6jx4qJYEGa
         sftWaMP7ZTsUodTDtxYdalH4zMzEQidsqEUUZ3DJN9RNE0U58V19nlO6BtUbewmJBT15
         0+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744027513; x=1744632313;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=deic43YF7Kqbw8Cci++bMKU/sSHEFj4fgBR5u0HoqSQ=;
        b=aZpZx4laJq2unmuRV9o3DdlIr1pDKz2vMEyOJdUwIQ8WdCPvUuXwEwzQBIFUFCh42j
         yGysqK7MUwLR9b0+dCfasMN3jnucC1/MSR8BDXC2a17RJBhoesKznhTJn2cIDRnw1s4H
         l+FLh1tvyXKd1/lbKCZdtmexbWE5t4DHi+Ylrvo1JNqwPw2c97cBHHdDqU7qODrEvZPI
         DaCF1f1OhvnF0UIqzfLTvS1T9T1eHTldm58afpqzlTRXRukSa7vAYpNwN1BvsWZdi9p6
         2aP3Xqql1iXThp4di0qVGihbWMfhLBjqoeGlSnKVOOJ04wYOKfc6ecCTkK3zcVwtKpZX
         8d4Q==
X-Forwarded-Encrypted: i=1; AJvYcCUWngiFr7GRD45CdPCNcvWI6GZerXJqKga+YjylV/ee76n1+kOCDEyTTbkKfpiaBWnH/dzWrtU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK6+PydY8vKISUQayri8HnyPC42PruTUe3eVGV+58qI6EBApwF
	4XM4cTPFLpBfsTNdECZDkDLckkIKXHIWPthyPxXY8k9BRjxTnIFmgiH4CinRDDI=
X-Gm-Gg: ASbGncskoYTWQ+8/9K6riiicW+vi9TwVrYJinbHsmN2YoXhxt1W4JFHzM486n8d5ykZ
	fZA1oJtvHHX5CUiw6Atl9S3LMIfYuiUQ4wLkpwm4uebQSgddXVI9VIF5eZoe2ZXR8ZCK6DJFWxc
	KmfG5DpthDRNUcizhFx5yr54sz0OMQgcPG73Bw9adunVlPMOU02x4vgPBXD8prUCuN/Aqml3oGR
	j+L0kNo79afkL/ZuISxhKYr9aqdpcLVUOknzpB5UeyIN/xxpQfp70kFYvf67cIiYz2AxtlWu+Rl
	jcgk163C0vQ/1bHp1rsJXaWgbbFQ6cKSTv7j7Llcm//owIQrVEEKa6i1admNwJk=
X-Google-Smtp-Source: AGHT+IGt4XtnKO7xapraqrpTN968TcI1uaFnsz3vEBFT1IEFylU7VytQzNGLAnxvjQoPd2qeIrKMLQ==
X-Received: by 2002:a7b:c398:0:b0:43d:5264:3cf0 with SMTP id 5b1f17b1804b1-43ebef8f615mr132743525e9.11.1744027512745;
        Mon, 07 Apr 2025 05:05:12 -0700 (PDT)
Received: from jiri-mlt ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec364cb9asm127293105e9.31.2025.04.07.05.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 05:05:12 -0700 (PDT)
Date: Mon, 7 Apr 2025 14:05:04 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Ilya Maximets <i.maximets@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org
Subject: Re: [RFC PATCH net] tc: Return an error if filters try to attach too
 many actions
Message-ID: <lbwm7wpxlrvjv7rsrjz3ztuuq57lxutlsptskyyt7rg7axqdsj@cfbkhkwmp2ys>
References: <20250407112923.20029-1-toke@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407112923.20029-1-toke@redhat.com>

Mon, Apr 07, 2025 at 01:29:23PM +0200, toke@redhat.com wrote:
>While developing the fix for the buffer sizing issue in [0], I noticed
>that the kernel will happily accept a long list of actions for a filter,
>and then just silently truncate that list down to a maximum of 32
>actions.
>
>That seems less than ideal, so this patch changes the action parsing to
>return an error message and refuse to create the filter in this case.
>This results in an error like:
>
> # ip link add type veth
> # tc qdisc replace dev veth0 root handle 1: fq_codel
> # tc -echo filter add dev veth0 parent 1: u32 match u32 0 0 $(for i in $(seq 33); do echo action pedit munge ip dport set 22; done)
>Error: Only 32 actions supported per filter.
>We have an error talking to the kernel
>
>Instead of just creating a filter with 32 actions and dropping the last
>one.
>
>Sending as an RFC as this is obviously a change in UAPI. But seeing as
>creating more than 32 filters has never actually *worked*, it could be
>argued that the change is not likely to break any existing workflows.
>But, well, OTOH: https://xkcd.com/1172/
>
>So what do people think? Worth the risk for saner behaviour?

I vote "yes".

