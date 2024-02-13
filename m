Return-Path: <netdev+bounces-71235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 657EA852C6D
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 10:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 224952835F5
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 09:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F22122635;
	Tue, 13 Feb 2024 09:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cB9QLakE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C26422625
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 09:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707816954; cv=none; b=fA2+BKam3yaNhiwULyoiR8XTknIygplZVxjkC5S04FggMj35KfCWpnbYocpDU5bBA8x7pQwvijUHlRtL8MiNqX/s1K4ecosRH/ylmaO5Im5TDlTR2vKkNim5vZO4aORRSSz0UYLITVTp0A8X8F6rvoKdDdHnxTj/6DBl9wKAUt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707816954; c=relaxed/simple;
	bh=gNK/bIfzf1aAV+eK4yOEF5kDdP6hr5VB3dFIvT5pWds=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mz+UiXAG4MUweJ2gkMjRA2lkW67l/oCP6g80j8+d5sXgSLWf1ijV3bMnvM+WZZgMJOP9Qkzgodv7e3hRDxGwEakkoS/4xpttn8nLfLAljlmsCfq58Rt3nc+8mKtqKhxsAOt6Z3qCl2slRgh33zcgeOHtqPtX76/7H+yDXQWiIr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cB9QLakE; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56101dee221so6189a12.1
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 01:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707816950; x=1708421750; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gNK/bIfzf1aAV+eK4yOEF5kDdP6hr5VB3dFIvT5pWds=;
        b=cB9QLakE4KDyi5hjE0ONM+X2SrK62NvgStIO5wjCwNLKIv1Q/ns95PG40n40XkcCeH
         sGh+H0WFIQZ+VFDl9dmVFLTa9sECuOQ45l4xLPFqAdog04rbCGcEFM+sfqMM44aHH3h+
         2uPwRC8VYfS5OHlmRZ9ik5sh5vxFvxxwjIzI3TCmiX0uQ/IXSmzIgFwiWpr56u3/Ld/D
         E8xofipUkXjAVqc9Hu8K4XQXJg3Py8RbiFEMMGGLUS2K3k5OuMC1IncofcPhrkjtmsLs
         37IWM4FhS9LvUr4iWpWybf6e+zocjMeZpaX6TQFMVnB9bEiIPOBxhx8wl1T7yHa3yWsD
         IBeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707816950; x=1708421750;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gNK/bIfzf1aAV+eK4yOEF5kDdP6hr5VB3dFIvT5pWds=;
        b=TsnaSqJpiLwryW3kwrdMDLFyOyJibogXOrQy19gpC86xQa9gPYHdZSpYqLupTmMnfC
         LsetRevvIao7ungvUfx4+s0vg0c8/Nc8nogpxPfcr7duF2FsV+zvthIlkKcLUOHvi/Ro
         CrqWMnyOfalsjASstSPNthaNiHA5lQmwvoAXSMpLfsMmYtyzYGzbREnWVkb02JCWfy11
         zpxxTobHFNK78Yj0freLqdwLhvX7NeujelitM1OX79cb+mHDoSTddqq8W11awBx8BPiM
         LAa7fkOxiMgcfOm5dBBJvc2CpT3qNZ+sjVnIF6z2fMdJuy4TeCFktSphsWM/3rgKW6S2
         nk8A==
X-Gm-Message-State: AOJu0YzLbK4uw6miIkcm3c/zQzBbQBEHpOBjOxIOQKKS2B7UpFfUPzXg
	lkf1PG0y3yn8LcbarTI+TYxi/6W16HTR+CW5wvkaF/o138sTt+sxRhWxhIz1hhFjqZgMiXiUXyL
	mzyR3xNjZzl7gixL7R//c3VF0TVJO5VXMShyF
X-Google-Smtp-Source: AGHT+IGncPzooQ0B0+2HRUGIoCVM+mvkw40WodOm9iydTH/T8JIu57wPm1rFGFsS7SuDYYYfb8K7ju3Lo3bLcDDBVDo=
X-Received: by 2002:a50:cc96:0:b0:560:ea86:4d28 with SMTP id
 q22-20020a50cc96000000b00560ea864d28mr110912edi.4.1707816950340; Tue, 13 Feb
 2024 01:35:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212092827.75378-1-kerneljasonxing@gmail.com>
 <20240212092827.75378-4-kerneljasonxing@gmail.com> <CANn89iKmG=PbXpCfOotWJ3_890Zm-PKYKA5nB2dFhdvdd6YfEQ@mail.gmail.com>
 <CAL+tcoAWURoNQEq-WckGs6eVQX6VFpHtw4CC9u4Nc7ab0aD+oA@mail.gmail.com>
In-Reply-To: <CAL+tcoAWURoNQEq-WckGs6eVQX6VFpHtw4CC9u4Nc7ab0aD+oA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 13 Feb 2024 10:35:36 +0100
Message-ID: <CANn89iJar+H3XkQ8HpsirH7b-_sbFe9NBUdAAO3pNJK3CKr_bg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/6] tcp: add dropreasons in tcp_rcv_state_process()
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, Kuniyuki Iwashima <kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"

>
> Hi Eric, Kuniyuki
>
> Sorry, I should have checked tcp_conn_request() carefully last night.
> Today, I checked tcp_conn_request() over and over again.
>
> I didn't find there is any chance to return a negative/positive value,
> only 0. It means @acceptable is always true and it should never return
> TCP_CONNREQNOTACCEPTABLE for TCP ipv4/6 protocol and never trigger a
> reset in this way.
>

Then send a cleanup, thanks.

A standalone patch is going to be simpler than reviewing a whole series.

