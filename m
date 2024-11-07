Return-Path: <netdev+bounces-142899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EA79C0AD3
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 17:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98C6C1C227A1
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 16:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5560421620D;
	Thu,  7 Nov 2024 16:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pPGxdCxc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2CCC216201
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 16:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730995702; cv=none; b=pDGyV6p3Tv9Xlohg653DsEV5lFoMlWWfy7n8OKN3Hf6ugHNlNuTF+unOkT/nDTFlCQ4PsjvkVjzxjh1vF1ky8V4GCnQBDwTNSP43X7+dkYHwpO/eUbUN6CqmRj+pdGrmFGtd1vxMkj75QGL9XDt+/AeHfn6Kvg8iYd5qZQoPnMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730995702; c=relaxed/simple;
	bh=HGoeyJ5bHQ12Psq6V7bsPiX+e25OZ+wMwh1XPFe09FU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tcUGPc3/deNNasQeDH80AN5PTT4XpQCJWOZfryO+0g58P0bempPdBeLQBSyeustem/MQWkvohBbOdRFq9ieTExJ8qG1Bs5MWoZoNC5NnCQEaF5Gp5C3pWBOwd1Dzp7bqMx53rvfWp7P0aDwonsM8O1fVVGTtHnxDValtsxY3t5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pPGxdCxc; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fb3debdc09so9627861fa.3
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 08:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730995699; x=1731600499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HGoeyJ5bHQ12Psq6V7bsPiX+e25OZ+wMwh1XPFe09FU=;
        b=pPGxdCxcDDbThCnIXhs1t5HKvMiAAsdTl7vsAnlLkgoSZBx0nX59uUprS06P/l35ZQ
         aE+j0eCzA22kdrmAKLA0hqCDcHtN4a3uABfxT0AWrzvDkmNelOvqdGmP3oU3IBsrTxcX
         Xmv4FxbJyAsIAxT+O1KEwKMBTcyiTYcLUu9CQhssq51h8q/JInPhvmPp0vlYucCpfgk5
         LVNnmXC4h2tWm9oHDKnsgZofJF01+JfUOvqJrfN5KJUMooxZ1toFBbhyiLUGmiqkbJ9N
         FaTS6Zb4reU3fViu6NzYJ8nWPVjc+XAD+HRKXLNC7Mn03P+wEW8ufQZBScXUMXy55PLo
         2Dyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730995699; x=1731600499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HGoeyJ5bHQ12Psq6V7bsPiX+e25OZ+wMwh1XPFe09FU=;
        b=DZylp9LQJR+Fjnmqc4tOU1juCVfNVVl8GoitN8HIUN9ZI5PG9avPYmbXrwgNHS4YeI
         ySA3BiHuDvqFftJbGoZ4ERbnyf0MbX70rorYH6BEuwQKyz3BIXXIJO7Tyno1u9YG0F1v
         QpRLo7VQyh9lKP36N+o9wCzi7X60hLJm2uikp53t1+AMHB5diMmMtvxhaCE1B57NstLW
         0OhUwiHHObyi87tMCYrdEBfW2f0eMrhuK14MlOlRZY0ZhuyLKdwXv7xAoNljQBrh7I/9
         wAvZLrhHl+FlY2bYHsXMiEbzbwGhEGsC4XKYgPe8pxhHbgKAkxH+5+JNDNqCevvJgw/9
         6htw==
X-Gm-Message-State: AOJu0YxW8Lrjqz5Jx8KKahna4FTpEX3e1NgJdJJpW72xXCtiFE1pm9Au
	4MvCwwIhiSNdlmJrFJeDuuKbpqJ+Uki/ZdcV9+1pDM9XFB3xvz7Ldu5rXYi6Ro5/pLlXLztCRRi
	LhRO0mt3m9e+MJsCZvoeJaBCzcq80M1rKcs7z
X-Google-Smtp-Source: AGHT+IF/ojqIMUY4oZNbdHdbQzrLC0HkYYG/5IHFg8HU510AFrA+sNJdCRBVk6/mhI6dvrrUR0nSwEpNQXKZhS1z0sE=
X-Received: by 2002:a05:651c:b0e:b0:2fb:61d9:d717 with SMTP id
 38308e7fff4ca-2ff1e94bf90mr3780451fa.26.1730995698681; Thu, 07 Nov 2024
 08:08:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107160444.2913124-1-gnaaman@drivenets.com> <20241107160444.2913124-3-gnaaman@drivenets.com>
In-Reply-To: <20241107160444.2913124-3-gnaaman@drivenets.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 7 Nov 2024 17:08:07 +0100
Message-ID: <CANn89i+6oAEgYMNwgUx=yO-xhEqveRGCVOnwoQndKFf-HX6WfA@mail.gmail.com>
Subject: Re: [PATCH net-next v9 2/6] neighbour: Define neigh_for_each_in_bucket
To: Gilad Naaman <gnaaman@drivenets.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 5:05=E2=80=AFPM Gilad Naaman <gnaaman@drivenets.com>=
 wrote:
>
> Introduce neigh_for_each_in_bucket in neighbour.h, to help iterate over
> the neighbour table more succinctly.
>
> Signed-off-by: Gilad Naaman <gnaaman@drivenets.com>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

