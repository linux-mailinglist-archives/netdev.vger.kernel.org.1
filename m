Return-Path: <netdev+bounces-240996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 510D6C7D2EB
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 15:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 22B7F4E21EC
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 14:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E8F1E834E;
	Sat, 22 Nov 2025 14:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMAvc320"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A833F9C0
	for <netdev@vger.kernel.org>; Sat, 22 Nov 2025 14:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763822975; cv=none; b=UPNJA1WBlNTxNRtjNvkih69TKLZ0Tgxs2//ggIi7RQc9uL9UGsaAgTk4pvIf/gciGfxreADkDdsh7WfOT1I7IWMlhaS/N7Wsl1bcsqupGDw+pRWTvARAvNwi0VJIBaBioJGSt2CjzjalhtBd4BgT2CBzlJD6ZLB/O3JGnDy/Wn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763822975; c=relaxed/simple;
	bh=QPHsFaEGdsHZP3oOjgcmB4o7/cQm6i9haQ+GHIzrDuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t7e8DC4wzO6qHxkFqPU2qx2FL4Qa/oXSbBiGesqeMjBEmmEhA2EgY3aaHU4Gp9F5p3Z0FalFIU1H5anfOj8wHHScdEAxTRQ7EyOLT47DZbV1OatrEFj3buDc2EOZdVVeK0ON1s3XIaW65XT7lxCjrLLjKqPA+4x2AdpNd1kfkUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EMAvc320; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3437af8444cso3151632a91.2
        for <netdev@vger.kernel.org>; Sat, 22 Nov 2025 06:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763822973; x=1764427773; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=58Per5Q1gJAZcYO3oiuYP4SdqAFuNQCINA72VmEADHI=;
        b=EMAvc320z5wwSVnTbds2fyUt5rZO1sCsYYJz0o/IUK9mIn40q/XeMecHfpiJnAElce
         XKHcB+Gg0TCY4y62jsbNeywyZU8EK7AUvy+9ZjVtnmK2TjGv28Jywltc51jX7G081/8H
         6Uuo6D9kJHQHXWZMfOme4rtWZsVky1JmggSg1rlM3guo/KpD/eCk+TTbqyg+voL0K2Nt
         f3CJA35unN1W2BvkRV84IOqiLnGzIuW+Zbye46NWwDqFILjTXIJAr5u3lbZfPolLzMmN
         2izia4sKZkd15sJEqu8rIYpvt4uXfayGA8jRNttB1MkwILjV/qIsXoINfqxCYmqVAjpf
         7n4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763822973; x=1764427773;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=58Per5Q1gJAZcYO3oiuYP4SdqAFuNQCINA72VmEADHI=;
        b=gBLsGXFLSUAZaz3yHIvAE3FU9GIRJd64KUOh+s5Qp1Vnri0xi72/evixK2GmtHJpWW
         1Z6PP60lN7x/dme09u+spq04QpNvrHAnzSPFUFNqOtzafKV6VcIZUFp/qVH0V+Ob5Sjl
         QtiIyi0nr8NfNk9CR5XqWI0FiZBwolT/fwxk5GbxwbJjAX+OCiKZdBhkigHQPN6pGOAM
         t0ct3WbLsUsiijeYDtJQUdSt65nrkG9E3WwbqWlBephebMUtuUYAeEg2JAqzs+ieg2QK
         ai0cCPR2yzie+opJFZfJR0EpfaYACEYx/KZ3zv34mSUdqS+66gA6gEP4bdccbtCRwfWs
         u4UQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZ5bAj1U8hzbrQE4pVy9a3NZ6JDHyxoRbfn2GBnodZ8PtCHVUM1Nlu3sqqHbd5LkYhlOKarc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUROSI4Bh0gL5panNwTw98ELPY7cQUQfHCwBFnIH2IxHhKYTds
	frQ0ROMFIltvW5AikkYp+DgphycRUy4emWW/B0esMcr2llBZ+btAH6zd
X-Gm-Gg: ASbGncvK5udmHSN+mbwYHoQPmdDnpLHM8G2Q82jXT43og3BqBEcPU7d4Nfs4mFB+6UG
	r3g5Ji1R/zIVbVEPOiHArGPdYiK58LCJRZw+rX7pPvLQcW7Njyz8QdPPwIqueGQ6P3eRZpVMqvt
	Q0Onem0pjxebSqnCgv/wGoUa1i+PT/9tdHA6FkseZXIC3FP92VALtdW3KCMPOTUzn/9jXdV++e9
	1B5mr0Xun/00lZfqrPunKvHXkAPfxmAb/MzbS/TWfKwYr6j4mF2//BTZONTgNfD2krzNhZz7BDu
	x2kHM/Q+0AY6IlBy9XNxD/u+sC338W6KSuF9UsroR/UNdyMe3a965FcHp2xU3IfVF1XIo5M93r2
	7hDOrHPqle1IVEelMUTDlWgv6fECPwhO9uD0DJ/u827rRxKesOLA87xYIAvduKsQSfrfKOEMKuI
	U5s+3A+lRNvzd8
X-Google-Smtp-Source: AGHT+IHy+rtf55tHyiiQ4CEv5cvwEWRUsQzuw96USB2qMeqTBBtebSf4M22L0dXJgG6e0YZ2uDzt6w==
X-Received: by 2002:a17:90b:544b:b0:32e:749d:fcb7 with SMTP id 98e67ed59e1d1-34733e786f5mr5891436a91.13.1763822973356;
        Sat, 22 Nov 2025 06:49:33 -0800 (PST)
Received: from fedora ([2401:4900:1f32:205a:77ed:572c:240f:9404])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34727c4b64bsm8639801a91.10.2025.11.22.06.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 06:49:33 -0800 (PST)
Date: Sat, 22 Nov 2025 20:19:06 +0530
From: ShiHao <i.shihao.999@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: kerneljasonxing@gmail.com, davem@davemloft.net, horms@kernel.org,
	i.shihao.999@gmail.com, kuniyu@google.com,
	linux-kernel@vger.kernel.org, ncardwell@google.com,
	netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH] net: ipv4: fix spelling typo in comment
Message-ID: <aSHNYmb-3biUl6yr@fedora>
References: <20251119172239.41963-1-i.shihao.999@gmail.com>
 <CAL+tcoCthG3AzW4Gs=XeWjMGYo+UoZSu34N0tJju4+0jr++j6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoCthG3AzW4Gs=XeWjMGYo+UoZSu34N0tJju4+0jr++j6g@mail.gmail.com>

On Thu, Nov 20, 2025 at 09:53:50AM +0800, Jason Xing wrote:
> On Thu, Nov 20, 2025 at 1:30 AM Shi Hao <i.shihao.999@gmail.com> wrote:

> I think minor typo patches regarding networking should be squashed
> into one as they are easier to review at one time.
>
> Please repost them as one after ~24 hours.
>
> Thanks,
> Jasoni

Hi everyone.I recently sent a second patch for most of the spelling typos
which were in the net/ipv4/ directory and combined them all into this second
patch however there are also spelling typos in the net/ipv6 directory too
should i combine this new directory fixes  with the previous one? or should
i just send a new separate patch for the ipv6 directory. I am new to this
so any guidance would be greatly appreciated .


Thanks

