Return-Path: <netdev+bounces-160990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D51C7A1C84F
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 15:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 373CA7A047A
	for <lists+netdev@lfdr.de>; Sun, 26 Jan 2025 14:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A17C153836;
	Sun, 26 Jan 2025 14:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="H2WWdMxT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D28DF71
	for <netdev@vger.kernel.org>; Sun, 26 Jan 2025 14:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737900735; cv=none; b=E0UofPTeVwYzsxEFvz095eefoVqlFuuwK3nygJX+XQAFZXkGahyEIgUKpmKe6hz5GXiS4HzHnGASc5vdeBzWyVObVL1GVxkdHxH1Fcgd2b+7OGpwCpUctwANV/x9qfQNmYsq/fAF6ej7vjiqc3quC8wDKCaOyFOT2swFLdnN5Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737900735; c=relaxed/simple;
	bh=da9YorvvFk4UIYAefIerEYb4xCuivSVbVedCiCnFYfA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OAFiR3P4Mw51w7VkJJ/D+CFkupvkiinvr4x1rg9XHtENKdgKjSKr5xMmcohF26jRXYv47auZ57+0tpRWRChI7dCjfJkYXyr4ftVmHVYisPnNKUwIHY8AWWeCiiKrTYek8IwpWnhGjaLwaUK3iHFC3UAUcIfklIqEB9jDT1o05Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=H2WWdMxT; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d414b8af7bso8030271a12.0
        for <netdev@vger.kernel.org>; Sun, 26 Jan 2025 06:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1737900732; x=1738505532; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=da9YorvvFk4UIYAefIerEYb4xCuivSVbVedCiCnFYfA=;
        b=H2WWdMxTEBWu8YzCIX7u2/9XZXqzo1mKYjwVtSD3h4/dByN4Z6N2UrMXOqxljunCje
         Pqh52tYfxCAWMjPAeGKyyGiJNWpmEwGStY9IMMTuJnR7NuVVQboZTdD+xrquWP7rs2yf
         U0j0tEdnklmUatLiNIx/OGwo1mgYooIBdN3LeeJEDJ5pD600aUBuwLsa/WRkSB9CKRdd
         No8jyYnX/TWy747D808Bo8tsxezlEsWuJ7d/6mYbg8+pQy39bsesQR6+cEVOensfdC9L
         GbVB/w1wrt+4nvBs1BkRlEtDmbfc1f2HUZaBvvbewkFR4ZQYYbsyhibrrHZN4nO4a+kX
         JMkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737900732; x=1738505532;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=da9YorvvFk4UIYAefIerEYb4xCuivSVbVedCiCnFYfA=;
        b=WeJVJP6brImkykQ13N3stfxaXkO5zIFTQoOV+sW22tslzzSFNg6AH3YMFAWf94tdrC
         Eekrg5BvZWkRwHYyNNoXB0Yk4jDODcaRXQM307Tm/xi3XPD/Ton5qW8JDlz3cnxxlnIw
         LwOZii/w1hRMS5cUpTNBFTIp9h7Lw6KWRq2Xj/Zirl3jT9sUrGfSS29bDjElnEvu+UE+
         Tc/By+tww8HWzd7x8yLvqnvoabrnt83Tkl32CejYZMYSpFmmT4uT7M14rEp18c/yUnfj
         mEzXnUL11+lIRy2dh2+E/oGZm25pYxCFCJpcpmvr9PiNsFOhjgQi4ZTJ3hwLf4GgmWUH
         ikNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUf63ktiiDn51U9R6pf6ur0x9Ns60Y/KnCHQpHplkRCuCk6FLxekY8BkNgNYWlDsKZJGEbTJZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBYqv96Fav+Unb0xWXaz2UW864PmuemrSWraqo849c3L2kyzNO
	joJFBMhKoxuvDnIXZPBUrIVwffTvAODQOcYe3ViYErsc/h6z5qrYUePHgOY7HlIYM8fRafFA/Ez
	zoy4=
X-Gm-Gg: ASbGncu1+EHaW2uaTI3NTdlKmaKFfmIRYCfAplKZPbbnQMuY8j0CWjgoEpb9mYRFuuR
	R6ViMWpqnBLEPuusLaJRHNWlZgwuG22RI03i8m0NEElkkzH4lGEp20zfxIiY9KC4tRe4abOFkwy
	9WnAGW+KKBMvcx1yTnT8pEHJADLaCMk1IoarVym0n//JgoE6SeIM+b4B1UcSgpiw6HPzAyNrDfc
	cXtqM+4HQsSukfHVrO0esZO6Kbp5DDNIfEQMqhJMxe9yUZnumsGmKGxKsGc6A8ovqHTI+CzSQ==
X-Google-Smtp-Source: AGHT+IGBKFasEkaDtZZ5CWcrV1Bxnz3k+ijYYsGxkH5Dhoqoj3FM7YBEen0VjurFTCvcD+kWOyT5Vw==
X-Received: by 2002:a05:6402:3509:b0:5d0:cfdd:2ac1 with SMTP id 4fb4d7f45d1cf-5db7d2d9958mr37213488a12.6.1737900732189;
        Sun, 26 Jan 2025 06:12:12 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:506b:2432::39b:69])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dc1863a1fasm3986231a12.37.2025.01.26.06.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jan 2025 06:12:10 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jiayuan Chen <mrpre@163.com>
Cc: bpf@vger.kernel.org,  john.fastabend@gmail.com,  netdev@vger.kernel.org,
  martin.lau@linux.dev,  ast@kernel.org,  edumazet@google.com,
  davem@davemloft.net,  dsahern@kernel.org,  kuba@kernel.org,
  pabeni@redhat.com,  linux-kernel@vger.kernel.org,  song@kernel.org,
  andrii@kernel.org,  mhal@rbox.co,  yonghong.song@linux.dev,
  daniel@iogearbox.net,  xiyou.wangcong@gmail.com,  horms@kernel.org,
  corbet@lwn.net,  eddyz87@gmail.com,  cong.wang@bytedance.com,
  shuah@kernel.org,  mykolal@fb.com,  jolsa@kernel.org,  haoluo@google.com,
  sdf@fomichev.me,  kpsingh@kernel.org,  linux-doc@vger.kernel.org,
  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf v9 4/5] selftests/bpf: fix invalid flag of recv()
In-Reply-To: <20250122100917.49845-5-mrpre@163.com> (Jiayuan Chen's message of
	"Wed, 22 Jan 2025 18:09:16 +0800")
References: <20250122100917.49845-1-mrpre@163.com>
	<20250122100917.49845-5-mrpre@163.com>
Date: Sun, 26 Jan 2025 15:12:08 +0100
Message-ID: <87frl5d5qf.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jan 22, 2025 at 06:09 PM +08, Jiayuan Chen wrote:
> SOCK_NONBLOCK flag is only effective during socket creation, not during
> recv. Use MSG_DONTWAIT instead.
>
> Signed-off-by: Jiayuan Chen <mrpre@163.com>
> ---

Acked-by: Jakub Sitnicki <jakub@cloudflare.com>

