Return-Path: <netdev+bounces-218346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0363AB3C0D5
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 18:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2291D7B0009
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 16:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB7CF320CDA;
	Fri, 29 Aug 2025 16:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yZzcFSeT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EC41917ED
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 16:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756485248; cv=none; b=tg4dQihtvgyCQfZ0j1vZMYs0VhBO5H9TMI3Ego989584lcorAXagPRKi6ucybEWnt7Y9goqe0Y0QHkPF7uzTfiWZcWxzLZLlrm7ure8gul7ETzTeTwkLBg6tPdaL3LvM9Oj0vP7C0E+56EaJXG231Lqc0mf5JkopfobVpeJai6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756485248; c=relaxed/simple;
	bh=BEpZQhYzjwsLfJeudrqgmT2DRJfFRuBpsoElnQM3kF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ubLl8pLRnzdP5ZUBlVYgTgkiK8DPRx99Hfdqd8exF2a04zCP4+hxumyaS56vmfo4eEPjd8UuUqIzb4WxLzKP+eu1A7hih6lsPAvff8LkOEQyWXV8hoLb8eZ8hFIHlPBMqQW7N6vFHzUSTyiukXGmBX2zPcZTc15ohKDL3AqYklU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yZzcFSeT; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7e86faa158fso241487185a.1
        for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 09:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756485246; x=1757090046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BEpZQhYzjwsLfJeudrqgmT2DRJfFRuBpsoElnQM3kF4=;
        b=yZzcFSeTDXtfG7Io66w+4NDacXOOjav1C0B35w5lxY6j1aX9bK3x//As59NIOj7xJi
         /JxrPS7mMQhVF3xl1MZOQWk9G66ugVlwYd90mG31i4G4Mepfwo2NyFJdiHq77idXJEez
         X8EV+uUto469lwnDZ0OqjuEwkG5N4nRYf5x1iWSYdOehIW2vpzgrds1LlMGhSkIOGhGE
         Di6gDbSYB1J57eHce+omAmcBqHDvXve+hQqkY95p+3tOxrQf87PyBu3Ry7SEosgPsQFK
         XQoFrCxN0Dthwz9ZHeaiF6h55KteB+uHgeuz3Ra3p8wS7xUGNotxBULYzYAxCYWORXKI
         +rEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756485246; x=1757090046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BEpZQhYzjwsLfJeudrqgmT2DRJfFRuBpsoElnQM3kF4=;
        b=cx1uJTa04DYc2nYAfQ+A+UtRxHmk//pUBPxkMSK65F1FoFYV3ZB6Ut4ThsDoABpSUZ
         d5dpTu4yYmKZTdhhCXPWkS3vysn5DyeZf91ybaBejenpzbGaW+zHiOg8UXbvx1mG8xG+
         VFHj74ywendAu68K3JOlC4XJ2IM8gfAafHmaIVRgKSR9MGJI5xmppkixVHaXqWbHSOBw
         789rjcVz9tMSn7sviebpXej7LxqmB7FHEQsuQojZ4a4uvqh4la8g/9XHCPN4yV/BU/UB
         UabRoZ+d1KkMaERCiBhoE8YzfOmD6ot9sb6XFEDNr1y1dhY3jhdOSTpGlZM+oQvmHIbz
         b1Aw==
X-Forwarded-Encrypted: i=1; AJvYcCXpg7xMA7VVBq6Hb/gqMi+rF+jEF6U4uLRcF7mYhRw1Ptry1FKFMEAxO5mAcFvX9wN/TIXqzVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwL5ZWcNlkrxDhpAu6MgLy7FYMZu19WObff1CYAPk4cfDUXjd1P
	Whx8oX4JKwfhV+dCuDnzHKJGmyqMPxKLDK/S/6lv5QuB44mN0Bq9ObuK9nY+XoaAkQA2p8wEZiP
	E/y2ttgIMO0CRAUecrLy4frSk2WohkQSlgj0wN4MM
X-Gm-Gg: ASbGncsYgSNlAGRCrS5uLmxykPiadYPqLYxabSWJzjZals0kSCJSwCbxjUN65dwSKxZ
	ZpagBsd3EHTPn4PlM1hmkQZRfAiZv44Bg7XIR3iHgyxVsSCs0sIS5g1g2g/EsD71LTDWXZZERTA
	HKsHuWPBlLa24Dkbhe+/ceVSY8ZY4JKPvFRrWAnuNTpiKWSntvrabRifaXGqhZRfkmlFocpXFDC
	QkAVWVcwEetZ22XlgdXFZt6nhO1f6Jg5SM1nXNZ5zuXAzOHoV/Q31rE2YE=
X-Google-Smtp-Source: AGHT+IHtYMp7MaCT41dAq1EckC1KoVCTKnXamBjtK+0KAq3RniwlNivEAWcGZmijh3OPLqGjBp/iT2msuf372hEp+iY=
X-Received: by 2002:a05:620a:a80a:b0:7f6:f290:d7a2 with SMTP id
 af79cd13be357-7f6f290d81emr1339269085a.26.1756485245616; Fri, 29 Aug 2025
 09:34:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v4-0-bfcd5033a77c@openai.com>
 <20250828-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v4-1-bfcd5033a77c@openai.com>
In-Reply-To: <20250828-cpaasch-pf-927-netmlx5-avoid-copying-the-payload-to-the-malloced-area-v4-1-bfcd5033a77c@openai.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 29 Aug 2025 09:33:54 -0700
X-Gm-Features: Ac12FXzVKBKIpycRTThoYnOUy1NOmMvnFdIRovbc3ZCcjbrQ-vjmY06SJZt7nbo
Message-ID: <CANn89i+Zw7o+iGoN4Qf+wS-hL==DSZn8sMTT_7HerNuVd+uVPw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 1/2] net/mlx5: DMA-sync earlier in mlx5e_skb_from_cqe_mpwrq_nonlinear
To: cpaasch@openai.com
Cc: Gal Pressman <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 8:36=E2=80=AFPM Christoph Paasch via B4 Relay
<devnull+cpaasch.openai.com@kernel.org> wrote:
>
> From: Christoph Paasch <cpaasch@openai.com>
>
> Doing the call to dma_sync_single_for_cpu() earlier will allow us to
> adjust headlen based on the actual size of the protocol headers.
>
> Doing this earlier means that we don't need to call
> mlx5e_copy_skb_header() anymore and rather can call
> skb_copy_to_linear_data() directly.
>
> Signed-off-by: Christoph Paasch <cpaasch@openai.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

