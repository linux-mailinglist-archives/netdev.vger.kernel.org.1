Return-Path: <netdev+bounces-133908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF856997723
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 23:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DE3AB23EB7
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 21:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9179B199FA5;
	Wed,  9 Oct 2024 21:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U97bJR4e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BE815FA74
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 21:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728507656; cv=none; b=Jw6MN0f94jYeX33Hx3NjfJjKAWsHA9f1I2JywlPv2KkIed/LiQYD5zHico4C49kUVHC4xdfPyw6h4M51oywyVB1tpvXQEwdaL2U1/LI0rhQ4qZMUaSWf8iZ8O8mq718fq/jAk7dHN/AzOkPA42TrJwnJ4K+DzkOARg1qul5OC9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728507656; c=relaxed/simple;
	bh=2mz49rEZUDSSSMogUQ/PTLDIqGUKzRNzHFIRJ4BW1lo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O8COLs8z0ymnMAyWa8Xa6F4E2hgSl10qpS+wlARxonJB1lRBwFb4smqywWOtTrnVNPK9byqtVViIVsHfruY/xpVdjcCTvGuq9GOAzBYD1wW9CNvs7Fs/lWVk5/fM+pNc06YT90UeEJ20Y4r5XWAjtv0xA5daHIQj37e/5Pa+DvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U97bJR4e; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-460395fb1acso87881cf.0
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 14:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728507654; x=1729112454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2mz49rEZUDSSSMogUQ/PTLDIqGUKzRNzHFIRJ4BW1lo=;
        b=U97bJR4ejt1BNIwxDQm7VcYW3FghtBIrQH7zrWO4eC6vc41dsaZPPVV1v7VgNCE5iL
         Ek+bW9cAUx5JcG0re1DamBuohF6wxyj52PDmWQwjlp1DUA7Q0nEDBrvKiaq9tS+TZnwH
         HqqQ4j09UTiLheqaEzc1NuNQoPoHCql27gj+kBzWV59P0/U0cx4+mdFO0wXPgAUIlAiD
         RmRvlouZlzyJTZ3lFcLgzFMpPY1F6l/MsT3QaWBUvmIDYTf4t5+XnNQ7ioAlTQ0kOae7
         OBRPvzKjrI3Ve6Q6KmoBkfjsHGzVFJJD94XevL6V71ZTJADzqRsaQ4Bp5B3W77T68zlO
         V+iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728507654; x=1729112454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2mz49rEZUDSSSMogUQ/PTLDIqGUKzRNzHFIRJ4BW1lo=;
        b=lez85eCwxeLY5A2xy6r7HdgWzznrgs4o1AkPCeOD9MM5Pj7fFRWxDhQ8yjIg7eYch0
         b+Q29bAcloshn/zg8BfAuCFbRR5RMsIrxmvJwpJWq3azSJeoOULr/NE8DyqjNNrpFMny
         gOMh2mxbSOCQJ57KKhT6Q3LP8hy5HK0cTpnVj2k9GFDsk1qR3bZIGXyjJQkBeb3QC0ky
         KnyfsCwCd3PcGF9zqH3dttWykk76O19KzoyHmZq/p4NYyRMgG1nhG3gdp+HsOKNmsnxm
         IIkO4lKql0a1p6/muvJjujsbazoI8S3pK92n20EEMmnwbirZC2oq/TBNAzGMyBIi8k8l
         pK1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUPPW5LgKhPBaYDS/1pdGzhhwGVxI0fPhSDVCbTaSuLpgzB/4D6KI4QieqDwXGnVFfOD9XW7TA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfo++ZErkLGRxRL2Pwx5qvKiQj9MwIQ+oHlTbFimiapEmTmCIy
	o74t4l9MLPU7RBDiGcD0eYWCgKZRLYjOj4RRaYtPZHHmby3M867sOPwZb2cJJyziDpWTw7Km+60
	JXoyTJoIdiHjCpj89ygUy0usQ6miydJpePkSn
X-Google-Smtp-Source: AGHT+IERpFJXwIdQCaz6JVxNCGO9tWecB5hDzS+Hq1qriM+TfdKc4CNMgfEevgAdoVeeof+MLEZB7QaSut6cJPiicA8=
X-Received: by 2002:a05:622a:560d:b0:456:7ec0:39a9 with SMTP id
 d75a77b69052e-4604119ee8dmr209921cf.5.1728507653567; Wed, 09 Oct 2024
 14:00:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241007221603.1703699-1-dw@davidwei.uk> <20241007221603.1703699-7-dw@davidwei.uk>
In-Reply-To: <20241007221603.1703699-7-dw@davidwei.uk>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 9 Oct 2024 14:00:35 -0700
Message-ID: <CAHS8izPFp_Q1OngcwZDQeo=YD+nnA9vyVqhuaT--+uREEkfujQ@mail.gmail.com>
Subject: Re: [PATCH v1 06/15] net: page_pool: add ->scrub mem provider callback
To: David Wei <dw@davidwei.uk>
Cc: io-uring@vger.kernel.org, netdev@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, David Ahern <dsahern@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 3:16=E2=80=AFPM David Wei <dw@davidwei.uk> wrote:
>
> From: Pavel Begunkov <asml.silence@gmail.com>
>
> page pool is now waiting for all ppiovs to return before destroying
> itself, and for that to happen the memory provider might need to push
> some buffers, flush caches and so on.
>
> todo: we'll try to get by without it before the final release
>

Is the intention to drop this todo and stick with this patch, or to
move ahead with this patch?

To be honest, I think I read in a follow up patch that you want to
unref all the memory on page_pool_destory, which is not how the
page_pool is used today. Tdoay page_pool_destroy does not reclaim
memory. Changing that may be OK.

But I'm not sure this is generic change that should be put in the
page_pool providers. I don't envision other providers implementing
this. I think they'll be more interested in using the page_pool the
way it's used today.

I would suggest that instead of making this a page_pool provider
thing, to instead have your iouring code listen to a notification that
a new generic notificatino that page_pool is being destroyed or an
rx-queue is being destroyed or something like that, and doing the
scrubbing based on that, maybe?

--=20
Thanks,
Mina

