Return-Path: <netdev+bounces-120418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F913959402
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 07:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52C8B1F222EC
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 05:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BF21684AB;
	Wed, 21 Aug 2024 05:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fclwXrrC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A121607BB
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 05:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724217868; cv=none; b=QZil+FJtyhw9+xWOZ29x3kppEtgMzqHp4kaimpMO5howlIUhpb/bP/sm7yJQVKkKMv9s7oJcrBVPgrp3tHaEIGS/k4si3Z9lJORdN3L8ZXd6QV/7BX51OvxRJVm8aYZGiGYTza0WNf7qCpk0njjYUEX2wmEgMTd5qlW+A/3UDbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724217868; c=relaxed/simple;
	bh=+c9ry0gIKwo4UXh5zsTLVRtv/dS4wCh2ZSvVpVlgmGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f9QhC4AqWIzLXuMeSvyH8TMArYk6f5Nl8K6PcQXqj69DA6d1Nzl7DQAgeL4RO1GjgRK2XjhnPHO5raYeEE2CPfuOABoHZSVEmEpfYVMd7jIYcbqfZuVyoQD7/9TVVVN2VhG7o9dObHmrpJlwTuBb0ncDiR0L1Eu7gv742prnS34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fclwXrrC; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-44fee2bfd28so153421cf.1
        for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 22:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724217864; x=1724822664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+c9ry0gIKwo4UXh5zsTLVRtv/dS4wCh2ZSvVpVlgmGA=;
        b=fclwXrrCUbNostfgCMd1La3shPRVOZWX7NBGQo4UHZzjMXPcrSpNKULQ9MImg5XYFZ
         CUegKrg1Fyl7CyJRn/1/tvPw1wlrt+bGmLJHhcMcUUJsGIa8Zb0jsdfkPrzBVQU8OHQm
         8dIMv+2iaxJeeFcP+n2mDKiRM3dkeyalcHar9RC9H8LQ0bWAw/onpJFqpKriGZ01a/1t
         M9b5rA96B74LZiM2zdhf5YwWort6xA2xcpXOx0Bi82d5wU2qSbpIsuQN21WeeNkEXlH4
         LxpudhD6SeYCDorLcudcwf16ua7KSTQhRL/9f9SCln4QOAenhivCtyYt5MlCr6MqTKM3
         F+uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724217864; x=1724822664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+c9ry0gIKwo4UXh5zsTLVRtv/dS4wCh2ZSvVpVlgmGA=;
        b=lCHW/UWlP1px/hc6lWMWEYa9mNaVviRN6zbKsNAiiz3nk3Ui4JHxfsaPvYBqBrQGbq
         7UHcopYUdFH3IglowksBmdQ8kIg5m/WFuxUR9CTw6sDAB4wjD47KwHE2D4NTepVYpnet
         D4Ft+2vGezeOdZKvp/BpwrkSsRD7YY83am7dWZLXcM/oap9BF7MaWCMnhYXFKP8O3Dc6
         oUVryaBB2OD6klYTD0dTcTnslPM702rk/Ejc5HcOKn0fWlNrnhpdGfdvyjzk6IIoXbLG
         wm4hwTwfaprUuJKJ6w9W3+J+GEI2PLxdlfStLslVZxpIgIiMMvd6kqno4WCKGnVaDdj6
         FEMw==
X-Gm-Message-State: AOJu0YySvz3+2bV6XOLTKnaBePge7TD++rXLGI35LWc1Ng/xPoTGI5k9
	KFiC5xiN+5sOmKlmMt6yIEN5Sk0A8APnSvp0s47grQlPaUOP+5M6w1LqQO5PF2dgbzv2v+ZyuhB
	ORyJ/pBZUz3s84a7eYFri/Rs/QYUdJdUxET2z9pq+R0VWN58entiz
X-Google-Smtp-Source: AGHT+IF73BCpn5UEcqFM/BhSSvMcfe9RO5QJr6iMJ/RDZUzv06kFzVkx6JeX8ZkAINLWgUfT5JTOhJyg6PRKU3OeCEQ=
X-Received: by 2002:a05:622a:452:b0:444:dc9a:8e95 with SMTP id
 d75a77b69052e-454e86dd4c8mr4839811cf.15.1724217863923; Tue, 20 Aug 2024
 22:24:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821045629.2856641-1-almasrymina@google.com>
In-Reply-To: <20240821045629.2856641-1-almasrymina@google.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 21 Aug 2024 01:24:12 -0400
Message-ID: <CAHS8izMyAxw8DyG11b6h17ghU6Xa-be-C7tDOvGCjkCJ1bZDKw@mail.gmail.com>
Subject: Re: [PATCH net-next v21] net: refactor ->ndo_bpf calls into dev_xdp_propagate
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, bpf@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andy Gospodarek <andy@greyhouse.net>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 12:56=E2=80=AFAM Mina Almasry <almasrymina@google.c=
om> wrote:
>
> When net devices propagate xdp configurations to slave devices, or when
> core propagates xdp configuration to a device, we will need to perform
> a memory provider check to ensure we're not binding xdp to a device
> using unreadable netmem.
>
> Currently ->ndo_bpf calls are all over the place. Adding checks to all
> these places would not be ideal.
>
> Refactor all the ->ndo_bpf calls into one place where we can add this
> check in the future.
>
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Mina Almasry <almasrymina@google.com>

Sorry the patch title should just be:

[PATCH net-next v1] net: refactor ->ndo_bpf calls into dev_xdp_propagate

v1, not v21.

