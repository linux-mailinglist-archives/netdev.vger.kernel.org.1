Return-Path: <netdev+bounces-67735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5D2844CD5
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 00:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6012A1C24118
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 23:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C993D3CF73;
	Wed, 31 Jan 2024 23:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="O70duw7r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04513A8E7
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 23:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706743164; cv=none; b=OmjJdCsnjPejCI1D/1MXDltEHjoPBlNSxfP68sJFgcC7OPoQEFOXVlbH1d9fefwGZmd+5D2IUh8EyVQEvj7FvWJjyNqvItwDjrqSAM1SipUYrtLEi9YV6PuO72KeL4CoeQkoLHrgPh5GI2eKXR+bTWuUDv93tUl2ybSzVkmvKhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706743164; c=relaxed/simple;
	bh=xblL+yrpEo1gb8xzx/6pV+ZF6z63Q7arn5+fxeove9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cz/YXpu/G6THrx366Vppz+sw9zZQeBH5mJt8D6Ak4wd5s6IySHYpXgLEq3+U3rQ5UWxlwSDQ0V8jFzJp1G3WiKoGaAf7UlSwMLMHBaCofF1DmBV09tRat3ebW5dArlDoBd03DjEO284Z48lGCcnoPrBMb0YHPwF0hIY4NjdV+9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=O70duw7r; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a318ccfe412so27343666b.1
        for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 15:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706743161; x=1707347961; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LFVGRon0CDQR02O+c0btFX180m2QPPnDAgbj2eP6Q1I=;
        b=O70duw7rvT1IZuIH0qVXGitPsGKguqxuQHo9q6B4DB1yLLCV2BJaNUFSBSLR9fEaDE
         YERZSb5eAJx5miSc3coWGymYZbYrKGWJyt0QQgNjJVSnoQj0k2V+XDqELUsNEUBjZohm
         xwp9D5AOn5xv+fi5NVoOkvQmxVDSuQch54zVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706743161; x=1707347961;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LFVGRon0CDQR02O+c0btFX180m2QPPnDAgbj2eP6Q1I=;
        b=PrxW1DC2hyW760R+bjkKdB74L+GWAltiPNeBPeVIcKPu38U54d2niCZUqj5t7KAZw9
         rA+hn2+YAnfwd1Drrgo5B+A1QTmk0GESbK099unFnsmW1v+gzT5/LeTDh9shLuSYw+R1
         2mYPNqNrfuFKDdFfHK6k8jTZO1aZDZfdvSu2qvNrGe/y7zRe0I0mg/vmcQdkE6XxjIBD
         mb+7ugD3IhZWZqIMnaEyPJ12a7HEqsF6SwMoppMRZloKhbq5tncD1OS575TD1dzPea98
         eSxb1Z7ISz/hLLkP6WmuR8qZ/HYIT87YGOwvIAvle+WhdI+XA5NjFB2rfuLNJRd3oAXs
         Nyuw==
X-Gm-Message-State: AOJu0Yy9jRK4xaRPG/x4LXXcdRdp3HMmSJGYqgRyhkM0GrOQ/y6aq7rF
	IEqxjRjY8fgau695vLm+A85kq4WY4QIM23R3K/N5tIT8eSOzOJuOuiePzHHNkewYHFehd9N4hu+
	3/F2OcQ==
X-Google-Smtp-Source: AGHT+IF1vYY5QccpfFayqx1sXESU+Ky/U6W8kGzeHBZw71ddbc54EQ4bz9g0vddPjl7M9UcLDUn4Sw==
X-Received: by 2002:a17:906:e0cd:b0:a35:6b83:2a0a with SMTP id gl13-20020a170906e0cd00b00a356b832a0amr1791755ejb.36.1706743160970;
        Wed, 31 Jan 2024 15:19:20 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id s14-20020a170906454e00b00a367c8d2cb5sm957966ejq.190.2024.01.31.15.19.18
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 15:19:19 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55f50cf2021so369799a12.1
        for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 15:19:18 -0800 (PST)
X-Received: by 2002:a05:6402:895:b0:55f:aa1e:2a2e with SMTP id
 e21-20020a056402089500b0055faa1e2a2emr474082edy.8.1706743158122; Wed, 31 Jan
 2024 15:19:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130091300.2968534-1-tj@kernel.org> <20240130091300.2968534-9-tj@kernel.org>
 <c2539f87-b4fe-ac7d-64d9-cbf8db929c7@redhat.com> <Zbq8cE3Y2ZL6dl8r@slm.duckdns.org>
In-Reply-To: <Zbq8cE3Y2ZL6dl8r@slm.duckdns.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 31 Jan 2024 15:19:01 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjMz_1mb+WJsPhfp5VBNrM=o8f-x2=6UW2eK5n4DHff9g@mail.gmail.com>
Message-ID: <CAHk-=wjMz_1mb+WJsPhfp5VBNrM=o8f-x2=6UW2eK5n4DHff9g@mail.gmail.com>
Subject: Re: [PATCH 8/8] dm-verity: Convert from tasklet to BH workqueue
To: Tejun Heo <tj@kernel.org>
Cc: Mikulas Patocka <mpatocka@redhat.com>, linux-kernel@vger.kernel.org, 
	dm-devel@lists.linux.dev, msnitzer@redhat.com, ignat@cloudflare.com, 
	damien.lemoal@wdc.com, bob.liu@oracle.com, houtao1@huawei.com, 
	peterz@infradead.org, mingo@kernel.org, netdev@vger.kernel.org, 
	allen.lkml@gmail.com, kernel-team@meta.com, Alasdair Kergon <agk@redhat.com>, 
	Mike Snitzer <snitzer@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 31 Jan 2024 at 13:32, Tejun Heo <tj@kernel.org> wrote:
>
> I don't know, so just did the dumb thing. If the caller always guarantees
> that the work items are never queued at the same time, reusing is fine.

So the reason I thought it would be a good cleanup to introduce that
"atomic" workqueue thing (now "bh") was that this case literally has a
switch between "use tasklets' or "use workqueues".

So it's not even about "reusing" the workqueue, it's literally a
matter of making it always just use workqueues, and the switch then
becomes just *which* workqueue to use - system or bh.

In fact, I suspect there is very little reason ever to *not* just use
the bh one, and even the switch could be removed.

Because I think the only reason the "workqueue of tasklet" choice
existed in the first place was that workqueues were the "proper" data
structure, and the tasklet case was added later as a latency hack, and
everybody knew that tasklets were deprecated.

             Linus

