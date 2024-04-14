Return-Path: <netdev+bounces-87650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8200A8A3FE6
	for <lists+netdev@lfdr.de>; Sun, 14 Apr 2024 04:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B35A01C20A01
	for <lists+netdev@lfdr.de>; Sun, 14 Apr 2024 02:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3763912E5B;
	Sun, 14 Apr 2024 02:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LiGx/jhc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EAC3C30
	for <netdev@vger.kernel.org>; Sun, 14 Apr 2024 02:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713060816; cv=none; b=mBu2/lXsYfuCxh5J+j5m/p6NA5ZFZQ7D0e2PB8Cw91cMovjU+5FT4tWoJ1ITdOdo8x86YufxCzHWD39AQv+qIH4IQIoAdM4vhU2kgOSt7nMstiIffwMroWNZ2yAatgOLFBZKmCQKV84zM1QwSX6iBSFmaXgv+o7IyfQIdw8bcVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713060816; c=relaxed/simple;
	bh=DPqtwIzmVqEAMxjw+pCsmKEVAdKIHdKvRLNmCIiwn2k=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=n/7wMI0RD+pgQ6aZbNOts/l8109/8JDMHka7QRvZrpQCir0LCuczaJOCJJ0+vhnaislxC3BgbL9GeNgIzMcc2qNNAxKLDBvEvJa7IREfiXEzvM+LfvwlzvbTjkTEetqe+kGaWBSaNJmtM9ZlWX2HZhzJLZKM4q3oiqOVq9lPNk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LiGx/jhc; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a51addddbd4so244505766b.0
        for <netdev@vger.kernel.org>; Sat, 13 Apr 2024 19:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713060813; x=1713665613; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OSyDp3qAtCv1hxKrzU78LExqVtuLw0Q7qjTdT6JVT0M=;
        b=LiGx/jhcamSC1yZKZMkc6Hw9GJw9L906xaacDiQpMEnq+pkLmlBJ+P0X2mzLdfICFv
         8wyMm0Qo9Kdcy0B2xJcsMeP4NXK8EPFmjlz4melqGH1X8vCzIxE4+vh3Z2y55/MU67Qy
         eEtM7eziw/PcejNcrYMcwIaxUgpndwOP64ZHv9XNjp6ZkPjbuAQbIgv5mNt/8oOkfOtL
         cgehYUod9pfVlmo4URF/+IhrmkmQvVY9SI//jS58ZvOUwPATlOoSiprChO1qSQIjWUBU
         RsQp7RfdNSbpWIGt+sO4VnLpD21MGk8spToSylCxSml5mmL1Evl5dtd3FyEPRKrisJBb
         m7AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713060813; x=1713665613;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OSyDp3qAtCv1hxKrzU78LExqVtuLw0Q7qjTdT6JVT0M=;
        b=Ovn24VrRCemdYMGyZ/4UQtP0EWTiNf7uFuxIOSGpwLo0MxIQ88+FG/+t7p4g4qJKGX
         lah1IwFMpDCihIouugg1IXton8GjJmnjUKJ+Ft4VPsfhODpdBBOsDYOhtpGRVccm0por
         jYuzoHIHeZa5oEd+bgT6j/YZEMnKydsUkKLV9jEOnj11G83/bDXYPcjsId+OKTwpP15T
         ignDRXQmUaQIExDFGoQFSgUeXXYpMeyWA4ipId1sR/fNu6qfhvJlGcb9chqjB2uypbel
         YR2XDkoJn+jfQmQKW8W0EAbfP8XWtqG3KbbDe6iBG4oR+bVdO8sSJGxIulaD1lgPXgr7
         vsoQ==
X-Gm-Message-State: AOJu0YxMm+NwJAV3Qh/XMSoH70BMPcTmceMwYt+Y8q3MdozSdvKUTlc1
	EKYZL/JrDA3EH2ayUb57GZeEIWVVkPRgqpOn2F4MyWoMzyuIUNlUDumd3J1NvUntEV18cbebiIa
	3Sg5KT8A87gEet35aDGa7sDFnw9kN0heisvU=
X-Google-Smtp-Source: AGHT+IG0UV1Oc5XYfof1BB+JILGKte5PGsOmB+MlP0yLZw75h9IKmclruqfr3KLxu6RkhaNGP0oVIn5lK8v2gk1sSZk=
X-Received: by 2002:a17:907:2da1:b0:a52:17f:e693 with SMTP id
 gt33-20020a1709072da100b00a52017fe693mr5380344ejc.18.1713060812656; Sat, 13
 Apr 2024 19:13:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?5YiY56uL6LaF?= <liulichao09679@gmail.com>
Date: Sun, 14 Apr 2024 10:13:21 +0800
Message-ID: <CAHt-b_OiPm-41A8eLZO6UQUmLSbdMZpduVG53ArGhQQcmwDjxA@mail.gmail.com>
Subject: [question] why 'struct skb_shared_info->frags' use page idea insdead
 direct memory pointer?
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I have encountered a question about how gro combine skbs, simply say,
there are two ways:
1. use 'skb->shinfo->frags'
2. use 'skb->shinfo->frag_list'

I have two questions:
1. why 'skb->shinfo->frags' use page idea, what's the advantage over
memory pointer?
2. from history patch "d3836f21b0af5513ef55701dd3f50b8c42e44c7a", I
can get 'skb->shinfo->frags' is better than 'skb->shinfo->frag_list'.
but i don't know why.
    the patch say:"gro uses the frag_list fallback, very inefficient
since we keep all struct sk_buff around", but if 'skb->shinfo->frags'
use memory pointer, we can free skb struct immediately.

Maybe it's a simple question. Thank you.

