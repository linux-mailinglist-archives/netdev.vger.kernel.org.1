Return-Path: <netdev+bounces-126016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3D096F965
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 18:33:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B70828600A
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 16:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41B31D415A;
	Fri,  6 Sep 2024 16:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FiDk3VB2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA271D3638
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 16:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725640350; cv=none; b=Np6FVGBgD1ED2Oich+a2qp88JsBGkSl7PPHoB8wREl19Qs896yffWatyoow4RhPWxSdssNaIm9KL+GiiO1dNCMLpB2uSyaBbTi0qT+XXb6QiaTDApFr0S44loAkOZoI/kqw6//K6RlCk2gkV5jalglBzsyujwSOcIRi2XRmznsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725640350; c=relaxed/simple;
	bh=HJdkqYLUpsnetdCVh6ay2CBlfyS0Lb8vV8W+ynlNlD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ct6OtHDlprrfb+zibJG7gkwqNyNbvZ8e03DTX1HslINFk3CPK89Un5r4XVCkgyc9kIrlMfZDLzA5nDKVIBZRo8X3KD+UQt3Fvi5czfVNlugyJAhCRE2D3f/utjr7tTOMeCi1HDRLMPFkGcnhcwRHAhBlSNB+6CdpIixzjBLjj/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FiDk3VB2; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5365c060f47so493087e87.2
        for <netdev@vger.kernel.org>; Fri, 06 Sep 2024 09:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725640347; x=1726245147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HJdkqYLUpsnetdCVh6ay2CBlfyS0Lb8vV8W+ynlNlD0=;
        b=FiDk3VB27tz7+6nGmHO4THfNm407HD3vtYrIehcptmhBeCqohsEJI3RunoEBGlJCmi
         WvispqPy8O+Xr10cTv9YcKfz7ZNJ1VK1gxCFc9egIhJh90ehQW1HhfLqWyEkxIujz1Z6
         gmA9E3Yl8yMysry9IJ/4HmZ8UrUO15Nk+7Tc95Q0WJJJD7uGJb9WIgtfPR2SL5VDhrYz
         MXTChTs1WKrwwHWfpnyYlCErm89IEL8uNyWXyuJQCYd2KPdm/XcY2n+npRj4/VeEy8JC
         KkE169JjiLkiD46BMo4M4X2G5cF8ZilP/ZT8X9Eh6vt/4Fsh1n+3cJW0l7Sp6B086yCh
         448Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725640347; x=1726245147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HJdkqYLUpsnetdCVh6ay2CBlfyS0Lb8vV8W+ynlNlD0=;
        b=wVRDV+FN74pfEyd0MVkrurkVy6bPC/bRFLgJs0dknvpqMMDNPkjcT6R4r2bYdF8wOf
         AZ5G8PbtwcKrwUSYHcXuS70OKNiKkVZ5OM9cfuTh0UaZgzv4iipyZyPNWSnD+cp2dRJk
         oaNWliirPS81HVBVylyCBysKyc7oNJNsdDGcaytcObe0wwMoeITXglyNVfTGGUw50IR9
         4KHQal/+7aPGwCAPeAFsIic2ZOwdrNQPqFA4fpjp+4Mf5nNDeuSfEAiJbNxlDRwxT5sP
         my+JcM4CXFXI+HpxIrS0qwuuSVGzMS8kXH/la7mTEqC7egPiQZithhhfi98G2+iVfx3o
         huGw==
X-Forwarded-Encrypted: i=1; AJvYcCUxUA98T9cT5uvVM9CWPGOCXS73/aXxLJP4O+PfylYeEZdK22NLxC6HL7YIZFmxTXF6fmqnq1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrwTn0b2RaNL+DnoM4bIgc5Ipj9yLXC9sfrvz8XMvgLrrKv/4X
	Qhg3NgYewCp5/z3S6fqbp1Lr8w88G8OT6rFwnS9cMwgnVF7JfVNGKEV6CxhT0EmJF7LNTVidfkI
	4XmsN+FVQHoYcben8jDr7etCeX6BidFm7pYNowCq4YMNHMpZGcA==
X-Google-Smtp-Source: AGHT+IHdxaaUWgfp4Nt1hmpjWGICwWFVusjHm10LeoLwZcyvAKP/tGjc0mGTGzPWrEE00H2XEvP5WW2ZtycnH1sGo4A=
X-Received: by 2002:a05:6512:3987:b0:52f:244:206f with SMTP id
 2adb3069b0e04-53658809f15mr1945031e87.53.1725640346550; Fri, 06 Sep 2024
 09:32:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906161059.715546-1-kuba@kernel.org>
In-Reply-To: <20240906161059.715546-1-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 6 Sep 2024 18:32:13 +0200
Message-ID: <CANn89iJToC3QymBvU=S_uyjwRMQkN1M6qtY6MX0DYPFpnd1fHA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: remove dev_pick_tx_cpu_id()
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 6:11=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> dev_pick_tx_cpu_id() has been introduced with two users by
> commit a4ea8a3dacc3 ("net: Add generic ndo_select_queue functions").
> The use in AF_PACKET has been removed in 2019 by
> commit b71b5837f871 ("packet: rework packet_pick_tx_queue() to use common=
 code selection")
> The other user was a Netlogic XLP driver, removed in 2021 by
> commit 47ac6f567c28 ("staging: Remove Netlogic XLP network driver").
>
> It's relatively unlikely that any modern driver will need an
> .ndo_select_queue implementation which picks purely based on CPU ID
> and skips XPS, delete dev_pick_tx_cpu_id()
>
> Found by code inspection.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

