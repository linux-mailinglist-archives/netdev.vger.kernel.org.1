Return-Path: <netdev+bounces-70763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B0E8504C3
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 15:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C87CA1C20E36
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 14:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1305B69E;
	Sat, 10 Feb 2024 14:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c1LUaewm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E04A54BEF
	for <netdev@vger.kernel.org>; Sat, 10 Feb 2024 14:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707575858; cv=none; b=s6cPcYVRzzy9w1LcXT4d2NXXg/t00STZ7HbqNKFwK6X2AGuxKPF8CYhyNuuulpTXQ+ivMbix2jXEgLsyeEhaLRiI4rhucVIKUBCcwJI0YvrJP10ig4vIW8MFulMm5TY0P0aPt+CcxPsOwPlEKRYvJKnZaO/VEJo+5fGNxasVMos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707575858; c=relaxed/simple;
	bh=pcaKJPAQrWYnh5Tex6k4bAAQOTVLi1Mlp6lIgQdGlXs=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b/Kds1oWrAfCb4Ou+3nR44T/nRpJDsJ7S5/fPoMPVefRrNac19YzNaFKm4T9LKacdfCm04VCmcgupImkRKhZzO7LaVWyDFmqNkXyC+/joIIYE1hLfKz9zYZBS2d++Hf9JUOLyKdMQBrIl2LwL5bBA+hf6EUKb+xarkSAwUlwr3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c1LUaewm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707575856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pcaKJPAQrWYnh5Tex6k4bAAQOTVLi1Mlp6lIgQdGlXs=;
	b=c1LUaewm2c9rLBwP3jFnvB2aDcSQN+It9RYA9fl9BRG/eXDijsep5oV0gamJ1tqX0fjCve
	cXXCuII8jCvHRVjxS/mkav/EvlmOzCmVp/B2P4y9pRrpTN+VBwFGb7d5PSvOZw1//MNumw
	Y1PrkE0p/n/3MJKJfOALWjwk0UBCVwU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-g4fRwJSDNAufFczHVJkF6Q-1; Sat, 10 Feb 2024 09:37:28 -0500
X-MC-Unique: g4fRwJSDNAufFczHVJkF6Q-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5600ba5a037so1185447a12.0
        for <netdev@vger.kernel.org>; Sat, 10 Feb 2024 06:37:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707575846; x=1708180646;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pcaKJPAQrWYnh5Tex6k4bAAQOTVLi1Mlp6lIgQdGlXs=;
        b=jSZ5H/MAsvHZGNUg5Z+FoR5l3OPDvpiNuyZZFE4aVYDfdQepVi2dHhpFciPOThbms4
         8rP5Xoq/75NntCIQMzUQ5Q3XUOiMy0lGTMc57I0BedxUpW+6144QBWohKTaJ4WbjX5r0
         iVimoMb40IKeWCnZSVeDtZds2NNUuJxf5puTqtFme4mojURgKvhz+VOIYhQOFM+HsSZo
         GLoFaBAr894uXf77I6mYu4ig41kyNioFEl/LRtG99p/Th0CNiNC5LgBXt5MYggJkSt7X
         Bv9q526HX4bUsZrAbMPKXcqG5IYTdeXV4+P2g2nJVpI5msKR80IrKnAmV3BpQlKYnpli
         Egyg==
X-Gm-Message-State: AOJu0Yy1kMmmePpkBgpc0bjgTBbWkohpKqM1RbfsQOM5NCaRA74NhF7e
	MnqgxOIjrWG7+jrb3ahagzhy+DwVA8zp+4RbWN9fNiSENgusod1MH9DYpOiJPn+CjIxjgWAFnY9
	9HG8f84BchIjAFgM9/QiFkBe9XLY4OOGF1OlSl6Y9d5dVFDmO/2a2sUTdUIPhYdSAVOMNOvXeeA
	NgjPzgPTIR4ss/DoaskN/wBOgeYxa8AdDzuhA7M2A=
X-Received: by 2002:a50:fb98:0:b0:561:199a:3304 with SMTP id e24-20020a50fb98000000b00561199a3304mr1295793edq.39.1707575846653;
        Sat, 10 Feb 2024 06:37:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfl18hXRoevzJYNEa+uuAZsx0VHrEQrKx37BOkP/jOngpqgXS94QQGk6D22T5hiMwjARbVxpboZYNpLAGcKQw=
X-Received: by 2002:a50:fb98:0:b0:561:199a:3304 with SMTP id
 e24-20020a50fb98000000b00561199a3304mr1295786edq.39.1707575846367; Sat, 10
 Feb 2024 06:37:26 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 10 Feb 2024 06:37:25 -0800
From: Marcelo Ricardo Leitner <mleitner@redhat.com>
References: <20240122194801.152658-1-jhs@mojatatu.com> <20240122194801.152658-13-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240122194801.152658-13-jhs@mojatatu.com>
Date: Sat, 10 Feb 2024 06:37:25 -0800
Message-ID: <CALnP8Za9T2hkZ_HMQu2FkuVkSR6azs0WrfT=m1MmOxDWDehZEg@mail.gmail.com>
Subject: Re: [PATCH v10 net-next 12/15] p4tc: add runtime table entry create
 and update
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com, anjali.singhai@intel.com, 
	namrata.limaye@intel.com, tom@sipanda.io, Mahesh.Shirshyad@amd.com, 
	tomasz.osinski@intel.com, jiri@resnulli.us, xiyou.wangcong@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vladbu@nvidia.com, horms@kernel.org, khalidm@nvidia.com, toke@redhat.com, 
	mattyk@nvidia.com, daniel@iogearbox.net, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, Jan 22, 2024 at 02:47:58PM -0500, Jamal Hadi Salim wrote:
> Co-developed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>


