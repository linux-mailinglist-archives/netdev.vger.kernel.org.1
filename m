Return-Path: <netdev+bounces-233734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C43DEC17D2E
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 02:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF478424CF5
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 01:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC3B264617;
	Wed, 29 Oct 2025 01:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQ7DpnPm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C111E9B1A
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 01:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761700539; cv=none; b=CQ9Kj5Nt1eK6VPCpVQxWA4U3pcUOtxj+X9braZ3tj4KfnmaxoLMOMf1HjL8e4BDy1iJLR8+DPuUlckGpLucBpj7OefKxASgznfxKjTtiWDFEqvHWS36qxq3N0vHjEM7oI64+p79eApEdI4pC8vibkzrNu3c4IHe6Rt2iJN68Bjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761700539; c=relaxed/simple;
	bh=Trjbnx5fHwxk8E0IOS6x4lrn2KdbZltAdGvr39MpJXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PvaAIbIwoYwRPeCzJsHyeM3ccwj/OnfdkOROtk3oYyZMiviO7jb/ragCszzqAXrGZq60+IcKOX3psmDr7IQWmWxGZnzMPyt4bXPG2+AE1UquNHfAPhU7oxs9jI4m9jRsm3jf4jHcRgH4uXHiskp5TrAgqrqnzD4obZP8K8/axcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VQ7DpnPm; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-430cadec5deso65181215ab.1
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 18:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761700537; x=1762305337; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Trjbnx5fHwxk8E0IOS6x4lrn2KdbZltAdGvr39MpJXU=;
        b=VQ7DpnPmfLx7aYyZENorGeYM/OM0Nwr2zU2PfjeAymNqqocUiK2xa6U/LAZFPI2bnn
         Gg2h17qh2hl5CxbwrdE1zZrlFs4RD1+/Kt5SdrAN5g78zNDDh6Z7oDkPBhC/xZFTsPKJ
         cML1uWD5L0jxygteNRIshkAmqhT7Yqu6GV1wDF4pfeCN5O0bRk6UYpFMcyvVzDGpIMB1
         GPmEAkNQgVStL2np+Lkp6zYT83BhHioF22wb8y+g3iWaGaHaxafvJBw4dullQEXHijzK
         yZeclln+6NDDV1KOaUL8bVfUck04nLZXv1fQMG9iHDdWgwWBNtS6x1tFqKsW1lKaz+gj
         eS3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761700537; x=1762305337;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Trjbnx5fHwxk8E0IOS6x4lrn2KdbZltAdGvr39MpJXU=;
        b=WF9LKG1EnCEEB9fdidEd9KtOLxOsL95OLwB3WV4siuyse0bdbpQpWJ4x0NyE/ZpjPL
         lO8qdL66Ry27tqd98qawxux5nAaWTlT/YOW1mI3L7kgjTD/KlpoD8OLtMHc2ImV2sAIH
         l3bRqjzGqii7+M1UTlz5QOCnFwI1aPscagkJ6G/XxOQFQgG/HQoT3tr6pT5YZ5mxf76r
         p9iCVLsb1WqyAbyk8L7qiZquikVojkgJKTLF6TkQpf3AbexTkQvFQDoD7iI9l36tGGxN
         UOltcu7Taf7Qr/FWRtHta4TCNxcD3/Yl02xHNMYQPDDyIZ/y/ukguI5ejwjddNToE7NO
         6Wgw==
X-Forwarded-Encrypted: i=1; AJvYcCVMkE6nACu2ZKO/2hX9xys6lPcy3g6IY0DFZ2yNARmtw7refuLf5xU8AK2UPZOI+YNyYR/VKhk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh2ixmoQbFaGAWnoRe6zi6s+xCLCQiUMw2ZNWJ8GuZwLxZ3Obm
	DjcQmwWIkzmHcPij9HRZ9NTJSTaGYfijOyIvpGvkOlym8BYaEnX19z15w5AfoNhHQF3GSpHsr5e
	ji8eMDW9AkK0j887VzzG697AIWOMyk2c=
X-Gm-Gg: ASbGncuPgjrg1Sz13KnJULEnvhL5GznH/ul3EX7AWYNYFPMer+aYuFmaTi+LF1xCOu+
	Hq9KSVrS+oJx+5yVAfN5Pl+tetfxKN7WQcwOEX8J9dW052GMVSqhyKjGJ00Ejd/ol5KFkdUHcEM
	9wn82NJ2AiZAQfmmJTSIeG0x/4mMyqFSUjTlNjgbar4JpHzXy6Na41//OjxlLRg6x+o9C3Jieus
	Jz5a+jLYkZLDtKvogkZuuQQrAwtutDJpsgXUXGRfFgdugLHBGoKmNv9Mpxh
X-Google-Smtp-Source: AGHT+IGiTSMMyX80MwBvdBR0ghaukKH7fS110FJqqJ8ZxCiPcuPSoWH+ji1CTUUWndqjYmj4Pup8RGzvh7LCZfvqkk8=
X-Received: by 2002:a05:6e02:23c6:b0:431:d951:ab9b with SMTP id
 e9e14a558f8ab-432f8ea46a6mr21449745ab.0.1761700537269; Tue, 28 Oct 2025
 18:15:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026145824.81675-1-kerneljasonxing@gmail.com> <20251028173055.17466418@kernel.org>
In-Reply-To: <20251028173055.17466418@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 29 Oct 2025 09:15:01 +0800
X-Gm-Features: AWmQ_bmwqhoq-4WYQNMDo9zMLuaF-Guktg_P0v5-8sNZ8cZZn80tUr4S6FrawBo
Message-ID: <CAL+tcoANtmLDuAHeW4JynJqiXoeTwNL2cVcGB5Ff0AxJMkR7mw@mail.gmail.com>
Subject: Re: [PATCH net-next v2] xsk: add indirect call for xsk_destruct_skb
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	bjorn@kernel.org, magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, joe@dama.to, 
	willemdebruijn.kernel@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 29, 2025 at 8:30=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sun, 26 Oct 2025 22:58:24 +0800 Jason Xing wrote:
> > Since Eric proposed an idea about adding indirect call for UDP and
> > managed to see a huge improvement[1], the same situation can also be
> > applied in xsk scenario.
> >
> > This patch adds an indirect call for xsk and helps current copy mode
> > improve the performance by around 1% stably which was observed with
> > IXGBE at 10Gb/sec loaded. If the throughput grows, the positive effect
> > will be magnified. I applied this patch on top of batch xmit series[2],
> > and was able to see <5% improvement from our internal application
> > which is a little bit unstable though.
> >
> > Use INDIRECT wrappers to keep xsk_destruct_skb static as it used to
> > be when the mitigation config is off.
>
> FTR I don't think this code complication is worth "stable 1%" win
> on the slowpath. But maybe it's just me so I'll let Paolo decide.

For xdp or af_xdp, the best practice is to turn off mitigation since
it has a noticeable impact. But in some cases we still keep this
config on for safety. This patch is one of small optimizations that
mitigate the impact because I'm trying to optimize the af_xdp in every
possible aspect. Besides, adding this one will not disrupt the benefit
which Eric brought in his commit. Please review.

Thanks,
Jason

