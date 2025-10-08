Return-Path: <netdev+bounces-228236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA14BC56D5
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 16:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5D6904E10C1
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 14:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5A629B8D0;
	Wed,  8 Oct 2025 14:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wJL2/FZY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B168728D8ED
	for <netdev@vger.kernel.org>; Wed,  8 Oct 2025 14:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759933534; cv=none; b=RJBcg18IKim6QViVnqfipn5wM11cbvPR2CR4WS1DfNpbQQgc2wxIWYj6jTK0ROSJVIOFvAG3yH/glv5IsZiUdAzG5k6fb/O9nYVWVBp0oPAFrXQHmuHp4wU2knz7eD5CHYb8VehTymBhbij4DdlsWmRWQY/W6arEliHbOE08/x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759933534; c=relaxed/simple;
	bh=SMdTEFUDzHtoVlFzTKApCcjXGLBdgo7MmyVL/oAKcD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tzu8OzYZikfrXvQX8r1YOQlcB3QPCeWERn9v+6G9CfNMXWd1Hjal8ATgoVzorUzfvWAsx6f6M+IvTA5s1NSVS1LwvJksJf1nmFSd0rLbNla78TYtz8vPixoWEFWf35abbeatXcWfG14rH8BZEXgzyJd0hYwvNwVYD9Q/Vhuib6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wJL2/FZY; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4df3fabe9c2so380271cf.1
        for <netdev@vger.kernel.org>; Wed, 08 Oct 2025 07:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759933531; x=1760538331; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SMdTEFUDzHtoVlFzTKApCcjXGLBdgo7MmyVL/oAKcD8=;
        b=wJL2/FZYSmrLeSw0DcrB+nwaNTuwG3SiPvdUVO9yX3OLEWo1YbE6D28NLjv+Rm2MJK
         N6ueOVgi8rUUNpskxvrP92xTGkHzuvhVW3vPeR2hqIRUMt+7/qVHWzaM++cMqcjGiUf2
         dIc2cq8p6ELYQ40YLvHh8Add8Kpl0LLHaCsgOb4/kzbMexX7TiIDMWCfTcB2c2LN6v20
         U5bI//ybfLf9R/a4LmSi6jkUqXKP0+aw0ajvo6MjzHa3hjS0v5JhBisisN7fmvX/EWSK
         cIEWz0KHUEqy/KnzpFIcZzlskajD9DFIvjhXA0fp7sap+RMMXabPMTSU9z5jFbd2byAj
         oCMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759933531; x=1760538331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SMdTEFUDzHtoVlFzTKApCcjXGLBdgo7MmyVL/oAKcD8=;
        b=RDZBHRxVkKrU6yFGnl+HYwe4sbZvnuXfEVo43H/k9scS1ewALIz1UOFOphQL1EpEBR
         oq5ZSRFYfLAsGLdxPOuMMosD8S0dDCcw+U9LVRSnWW0cdGwjml7ColQHcILVIFV/uysk
         A7FiRcyAUCFny/jfqQbqy+jQmrAm7AQ5LTD+nESeLYqzyEiCu7EVgR6IloQqTKPm4faM
         Ca6KbFl+8fhx4M2OXx2jicBtv95q0D0p90D/YQGPFVTaoSzaOsDWji5zUZ2hSxN2tffV
         68IWdlmolbaYHLgMMZgyR+pv8+7I5xHHNoDoV5pleqaG763wu6Kv8Cq99xsSO1Zm3pWI
         +YIg==
X-Forwarded-Encrypted: i=1; AJvYcCUaeBOZOYplW4yRIV5/XCF5ga0r+ou5ki+Z/5jpxTQ2ZrMiLu0KmqfsEH3cwC18DB6nBW7cnVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLz+fEW+uXsJpobUC+5b9BJtauJMucj0Tp1h3xtx6P640j5yUm
	rp/hCHtXmZUJ9584ExDTL5WauQaX9G3u7H85AMKc4dBJTZpqb4YtjG9rZRmsmRBW0ar/ZICouXL
	90p9M+1Wvfjk5AThlMvMbMuDeKNrrmzLAsrgMasLb
X-Gm-Gg: ASbGncs8I2CkcKgZFZT8wT3awLwV/ler9cJpL5pnHJRC3eoggPt0of5MhL8jAilDkzR
	ptH+SBQxl8dxdO5iBiDJt6ojnmIboBo7zUFWNuEM+8WWIR00QkwjSJtzOb7GobXvBWjRj157CVF
	ZkfeR/Ou8BUQ5lre3X3NYJ65ZPT5lzVz7Vyut8X9E7qjOvtNmcWPH/X5fnaolGRn4y+wb4jjUf8
	XxPRQ/GD1aFR3QfGTl6Wbu6fEMWftCu4vWcdObd5iqUprtarNTgBcIfQbNFuicWI0Oe
X-Google-Smtp-Source: AGHT+IG/N/C44dqDOJLWzLBSBFXRnGh5t/TWFBgE2KSIEgpSqcSDtbFax25+YRUZ9feQZPVACJ+2IE4Xl+aQ0phChBo=
X-Received: by 2002:a05:622a:14cd:b0:4b4:9863:5d76 with SMTP id
 d75a77b69052e-4e6eab2eacfmr6846081cf.8.1759933531121; Wed, 08 Oct 2025
 07:25:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008104612.1824200-1-edumazet@google.com> <20251008104612.1824200-2-edumazet@google.com>
In-Reply-To: <20251008104612.1824200-2-edumazet@google.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Wed, 8 Oct 2025 10:25:14 -0400
X-Gm-Features: AS18NWAtW7sSxBKsX0QS8g-RcLQ_yLZtgDI0IljFxcGSkflft3e9DFo79yTXMNs
Message-ID: <CADVnQykbzjQB7UXB_darDb-=BC8NpNnLdFepNCoV8Lx_fHXeQQ@mail.gmail.com>
Subject: Re: [PATCH RFC net-next 1/4] net: add SK_WMEM_ALLOC_BIAS constant
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 8, 2025 at 6:46=E2=80=AFAM Eric Dumazet <edumazet@google.com> w=
rote:
>
> sk->sk_wmem_alloc is initialized to 1, and sk_wmem_alloc_get()
> takes care of this initial value.
>
> Add SK_WMEM_ALLOC_BIAS define to not spread this magic value.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Neal Cardwell <ncardwell@google.com>

Nice! Thanks!

neal

