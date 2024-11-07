Return-Path: <netdev+bounces-142867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AC69C0816
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 14:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFFD21C22E5B
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 13:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5051B2101B0;
	Thu,  7 Nov 2024 13:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mlolKiiF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4DE2076A5
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 13:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730987468; cv=none; b=NPzSb5V6Mf2UnNLPknatHA74KMwM0LRWO9+4PSJbyRabvX/L0fMU2f08FltNtcZSbf5eTtfE0uGrlarUif14neIvn73h2/jU8daMVv6aP7lnXmTs0vGW94VrxwPtddLVt1s1I+jtVhylSBzJYXHTUDP9tTxXUfxzEIhOMsvmyAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730987468; c=relaxed/simple;
	bh=Joqmdgk42QEjwNvXeMHuSOgl4G7/+JS37DUtTPm2xes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gg1gPtAz6vHnfR6IXNg92+lPNu41WgfxOYz5qdZnGscQY/FMWC9DMNLRqlRYoPzamBysZmo5RhRi5AuooCbLyRA6HiGL0FncwQghMfQQLKHMnC15QFG/j8NWoHfXMR98RtlQwgY24xvkkFupBqHGbamOooSbnpUfS2Vg6ld6IyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mlolKiiF; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-83ac4dacaf9so36277839f.2
        for <netdev@vger.kernel.org>; Thu, 07 Nov 2024 05:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730987465; x=1731592265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Joqmdgk42QEjwNvXeMHuSOgl4G7/+JS37DUtTPm2xes=;
        b=mlolKiiFC4CCOWwd1wvG+Me/ujH1CYWtWYfFN6InuYjrfTX0KT139JZSTXum1w/pV8
         W3ZFxy5QlPBdUTyVR73j6UR+HpGSoU/qOa53a6T7N1vqtxmS9YgydWvVv18qBYfPaHU/
         6/S06Bu655ig9pclr6QxSl8HfEdU3+SYV2XeNKLG4r4u1aeTR/Opfhs9KZnGNVQAoyi8
         AvYdGUt0mS08LOzL3ZsQsCFFwRBS5nBAzNi1PRrsuuyUEkSitcSZTEf3nWcKFo7S0CWA
         qdQbNUoOOxafpKiOmVwLdmNMzkV5RYP8DSVjxjBZChxAdwyOEYzuKd4dsM+kumhNyGX3
         FcEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730987465; x=1731592265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Joqmdgk42QEjwNvXeMHuSOgl4G7/+JS37DUtTPm2xes=;
        b=ENiBXofJY/1oU9EfdwBDq3WGxbwzzSD1nqd9NEo2hvFKzZMs6Y8athRhIRl8f+j9wt
         w+33sKGr+EQzzIw7ryJ4FdDK+JvHwhGbFouH3S1f4Y2d9NhGrBK7gorEcED2v4z6WYMj
         H419NXRNoTkyMZR2ET0ydIBxah3Uo8NJznnF11wRJmdFruWfyGb2IaF0WEwTGMBc2lRw
         h8r1AplWaffH4zbCjDuF3j033rvLWDkav215h3tzJhoP3/tyjTakkVKMktNWJl/mG5bN
         HSjJah3wtZlv1SrXEKvJcWbkNuGg6O6ags2W9k/tmYypfUjIIDhgQl0JLSDwon3zuWWU
         TYew==
X-Gm-Message-State: AOJu0YyFaJvbSEa7Y35o7aBAGaDHjqb1gpDsrJ4ZPatYk/Ai3UxBDTWK
	QJwxS0grZcy4nTXIybRvfh9AZRp2bMyc0vZn4IzEBfa7KDPAhYiOEUXdPEAEcGzXxccULNhSi7K
	v847loTbQiTrWV1xk2CYvJciX7RoIbzwUT9ND
X-Google-Smtp-Source: AGHT+IGHaRnAKTGTiImSETVw/h4M6MR6nP/a9TCua8mEewdBvjHNTaETAaep2p2XGbgjcdZlx9P3Z1glBm48iSyalno=
X-Received: by 2002:a05:6602:1352:b0:83a:a8c6:21ad with SMTP id
 ca18e2360f4ac-83dff7cc661mr4022839f.7.1730987465417; Thu, 07 Nov 2024
 05:51:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107132231.9271-1-annaemesenyiri@gmail.com> <20241107132231.9271-3-annaemesenyiri@gmail.com>
In-Reply-To: <20241107132231.9271-3-annaemesenyiri@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 7 Nov 2024 14:50:53 +0100
Message-ID: <CANn89i+FHaLLgk_WUg1AXXF3EwL3uVF_s5NdP3jwZj5-KAaekQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/3] net: support SO_PRIORITY cmsg
To: Anna Emese Nyiri <annaemesenyiri@gmail.com>
Cc: netdev@vger.kernel.org, fejes@inf.elte.hu, kuba@kernel.org, 
	pabeni@redhat.com, willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 2:23=E2=80=AFPM Anna Emese Nyiri
<annaemesenyiri@gmail.com> wrote:
>
> The Linux socket API currently allows setting SO_PRIORITY at the
> socket level, applying a uniform priority to all packets sent through
> that socket. The exception to this is IP_TOS, when the priority value
> is calculated during the handling of
> ancillary data, as implemented in commit <f02db315b8d88>
> ("ipv4: IP_TOS and IP_TTL can be specified as ancillary data").
> However, this is a computed
> value, and there is currently no mechanism to set a custom priority
> via control messages prior to this patch.
>
> According to this pacth, if SO_PRIORITY is specified as ancillary data,
> the packet is sent with the priority value set through
> sockc->priority, overriding the socket-level values
> set via the traditional setsockopt() method. This is analogous to
> the existing support for SO_MARK, as implemented in commit
> <c6af0c227a22> ("ip: support SO_MARK cmsg").
>
> Suggested-by: Ferenc Fejes <fejes@inf.elte.hu>
> Signed-off-by: Anna Emese Nyiri <annaemesenyiri@gmail.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

