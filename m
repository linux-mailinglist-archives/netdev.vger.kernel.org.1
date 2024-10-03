Return-Path: <netdev+bounces-131692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BFE98F44F
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 18:36:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A0571C20D39
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 16:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7683E1A4E8A;
	Thu,  3 Oct 2024 16:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMcmHj8Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8CE2E419
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 16:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727973399; cv=none; b=JI/bFoaoCQBvnuqRfSIoFnttz0H5hFfSlMH8ijlDWd+V0062AaCdWF6F88WiqKEyMNdWs1Kh6c2eyuYn46+B0SpTxvXUGl0vI6xweUo+n8lSsnujMc6og6pzaD6Jbxy2w0dZjgjl6UXtNO/q2GU1FDk3neYWrePLz5FpB3z4BeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727973399; c=relaxed/simple;
	bh=xmsI7gBRmZUcgk7y6fFJezxv/S4VFTGHOnRUKbXjRZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NNxMhh5SXoEgevkxV8jwSgLTBstTTE26wLr3IcO16BJpx0CjW4DQCsm3MANf0I72lzUgxSf33cs354exb8f1Rl7DGyc5j7QwfXgMK1Dol3SriNBVKL9dPWs2XJZrP0JUiCvCbB6dN7cMQ2P8WhbAEG+Wv3mZcs0VpLBx9TdWNQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMcmHj8Q; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-71b0d9535c0so898438b3a.2
        for <netdev@vger.kernel.org>; Thu, 03 Oct 2024 09:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727973397; x=1728578197; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=y3RS+c41GXm4iwPMmdgepJPuJIIkslSh8cwn0CwMjuI=;
        b=GMcmHj8QV2YX4WUfcGpnPqRyDGHMvbuJpX9q7Q+SR42nTnstZjb2nJeAcWo11JWT14
         L9GPV8tPdpre2MbiC4uqIqDZdDYLN28r79Ops2KSig1RVxV7LVb1Ahmc2kc+zTvrUSmp
         9lXJGGKz6fXuCDY4RrBjAGRY9FxCAxq5T7tZjxfK9RcWlFSJ4Jp6ofhe1KvhLT+ilFhZ
         vqq+92yFdpW55Cid2lDQA1Nc4Nf7XDGAWxq3ZOnhvLAoL9SPskeVaunVSGbe5Q3ICLaf
         aGFHM2mBvrmb2Maiy9dNKyelFvyTcnzh5fmAyWKc7HBJb8p3Tl0XB0MUvQxMH3FvosJC
         0KOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727973397; x=1728578197;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y3RS+c41GXm4iwPMmdgepJPuJIIkslSh8cwn0CwMjuI=;
        b=ATWBhZq43zOfCaJlLc6V41GPRx4xZzBty0GnJnlfP7QBmHRR8o7lGDTM5Yd4MGkDu1
         DlPAvh9lgAnBL7pSOmZzMcjCdjncglO9iWRmW6/zETbpyd2Gkh3UXdOLy/nZIm7Q/vbq
         pkZETQZ+KD+iZmso0K8rlSfKK/W1I3d1o7z7UKupAu8LV7f5aATZYoj9t0dT9MirVEwa
         96tQB4Uc/5cBnrqUhQGPqVG/7v+iZ7SyVWTMGPSx23iJX7JxA/HtCEjC8BKPuCZKDUqa
         OyFz7+UO9meea9wzVw/wpUcdGe902sIhPT29XO6JgXrUonbIutHlPCIJYKQLm2jO5bkW
         s8vw==
X-Forwarded-Encrypted: i=1; AJvYcCXF3t/5EZfM5PrivTNV3EvnebBkCoq/0ruf+DurRiCt7TSNcMHIBLHyg4BezrOh+aclWh13Up0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7XVaNTkc1xMgVqo4+7LlnFfGl3doZ+Z2lSzwvqigzD8RMQTWD
	waZoN4srNtC7luuJXJU7IyApOsKbBr1MH0034MG3zFLphLp+Pno=
X-Google-Smtp-Source: AGHT+IHg5PtUlAVjRMshorImekCp2I0La0nIDlRJDUwN1QBPoa+NL+JHqh8qS1Nw0zpKko1eGGG3kg==
X-Received: by 2002:a05:6a20:2d08:b0:1cf:658e:5107 with SMTP id adf61e73a8af0-1d5e2c65716mr10488641637.21.1727973397174;
        Thu, 03 Oct 2024 09:36:37 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e18f77aba7sm4023256a91.16.2024.10.03.09.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 09:36:36 -0700 (PDT)
Date: Thu, 3 Oct 2024 09:36:36 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next v2 05/12] selftests: ncdevmem: Remove default
 arguments
Message-ID: <Zv7IFJqBbASyl26L@mini-arch>
References: <20240930171753.2572922-1-sdf@fomichev.me>
 <20240930171753.2572922-6-sdf@fomichev.me>
 <CAHS8izPbGa7v9UfcMNXhwLQ6z2dNth92x6MF7zwgUijziK0U-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izPbGa7v9UfcMNXhwLQ6z2dNth92x6MF7zwgUijziK0U-g@mail.gmail.com>

On 10/02, Mina Almasry wrote:
> On Mon, Sep 30, 2024 at 10:18 AM Stanislav Fomichev <sdf@fomichev.me> wrote:
> >
> > To make it clear what's required and what's not. Also, some of the
> > values don't seem like a good defaults; for example eth1.
> >
> > Cc: Mina Almasry <almasrymina@google.com>
> > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> > ---
> >  tools/testing/selftests/net/ncdevmem.c | 34 +++++++++-----------------
> >  1 file changed, 12 insertions(+), 22 deletions(-)
> >
> > diff --git a/tools/testing/selftests/net/ncdevmem.c b/tools/testing/selftests/net/ncdevmem.c
> > index 699692fdfd7d..bf446d74a4f0 100644
> > --- a/tools/testing/selftests/net/ncdevmem.c
> > +++ b/tools/testing/selftests/net/ncdevmem.c
> > @@ -42,32 +42,13 @@
> >  #define MSG_SOCK_DEVMEM 0x2000000
> >  #endif
> >
> > -/*
> > - * tcpdevmem netcat. Works similarly to netcat but does device memory TCP
> > - * instead of regular TCP. Uses udmabuf to mock a dmabuf provider.
> > - *
> > - * Usage:
> > - *
> > - *     On server:
> > - *     ncdevmem -s <server IP> -c <client IP> -f eth1 -l -p 5201 -v 7
> > - *
> 
> No need to remove this documentation I think. This is useful since we
> don't have a proper docs anywhere.
> 
> Please instead update the args in the above line, if they need
> updating, but looks like it's already correct even after this change.

The client needs '-s' part. That's why I removed it - most likely
will tend to go stale and we now have the invocation example in the
selftest. But if you want to keep it, how about I move it to the
top of the file and cleanup a bit? Will do for the next iteration..

