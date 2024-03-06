Return-Path: <netdev+bounces-78071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9280873FC9
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 19:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26F231C220EE
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 18:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192A8137C4A;
	Wed,  6 Mar 2024 18:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nEx3WC8l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BA5133425
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 18:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709750435; cv=none; b=G0rcqrea3Uz6wO0DGGYGpGnglqZdh3X+6qwpIwkj979TmF2vJT0m8yS38qNbrjYMpATx3WOjdIFvzrm3QQqT7saxi0ZZp1Hd3OSDVScBXz3RdQXySzeOk5n+bhWI10KZrBYKAZc+WE+XqtDpq3m1FwJpaHIriNrWK0EMEfUgSkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709750435; c=relaxed/simple;
	bh=U2TDEDbzI/eyW42FWVQUXblhPZOJdBmq4TZX2PR2F1Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tdwGSNJBKpCnWRKHW9Ka1ktoFT5JMehdmfQAHf+BtKisF5bQGtOT+P6KEb3ph4taXrhNcOOMLzP9rUjcdxw22pF6wxobDIkfgNOMxYVvKHAj1ah3gco/zl2zECNu3VR9n5PudW/xUisxHla3Mf+8zpr9VsZKRMG11C2ItF6TXiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nEx3WC8l; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-565223fd7d9so1149a12.1
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 10:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709750432; x=1710355232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U2TDEDbzI/eyW42FWVQUXblhPZOJdBmq4TZX2PR2F1Y=;
        b=nEx3WC8l6f3kPzWGNcJ987KHj1s1zjfMevApEHht0zBKUYWnBrZ9UoeM6x7gO0Qzog
         ZALn9k2O+gm1WpKjukZTziTY8JCUAJK2fdj51yYd+c7XSveneqz1yw/sFw6nhyUKxh/L
         zTOKubkr73Y48n+PW6A6UZgiGl/W1j+VTIWE2qU/smEkCDvSjHAoHub3VlRG+d651VaR
         zY/6HMzgNwcmPIvsHHcUKotX7/ZjKf92jxR4t9czn39sufihzlls1cSuMIE2T4nxl97S
         M5eNuNP+Y+2EPv9OFP395JkhzSCxEQXr3NGiSkVBx0GI2zP8IlCH62Bh6A6i08Agn/8g
         XFlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709750432; x=1710355232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U2TDEDbzI/eyW42FWVQUXblhPZOJdBmq4TZX2PR2F1Y=;
        b=FAnotlOT1yvxF6k3tG4KXGglZgG0DMgn1/Lw/9rlbB68LvQ7aLvGXQJy8gaH0nHABZ
         w1IDjpqwUl/Ss9zFDQroVLGnmoEjBt3IRKrVWb0YicrYuQVPw1J+XcoVitNp3HMQJoPl
         djEqKY5dsNhEX/gW2bvQjP/qzqRu2SLzOTOv/Bkuww4asnC60fUryXz7f5exOToMmUn5
         9Y3IT5x6jo0vD0IxafTzWUCWvhMx1LKciCTURDiJlyl1KQNcNHzFPthq7VlDjWTDaUh2
         6vekszPVLAgKlYm0PjixwVZCSP9lhmWi29qaxRtFmIHvwFYyDAFJytYoyd1jiyM5iptJ
         nihQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmRdEg8NOy1VAGo3jN5c686rwd0PNColr981j05B1n4eBgID+GOSLBwdYyishlyQtYGDPSlmrmLWOXBkwhQkGKdWDXh4Oa
X-Gm-Message-State: AOJu0YwKtxNgnbtU5kGBJx7t+noNF0YnxFAeVU4a12SPexw+U/XaYzVb
	dc0WKNuUQpTnkEWqf+DYwrNphjkel3XYOLeA192JWttO27MHEKsyLhipvblU7VIRcBiaeSf7LxV
	NHuck/o7CHNIXnVICBpx39y0YPl28CeM+vQ6B
X-Google-Smtp-Source: AGHT+IEGsBWFaIyhG3To35qNuslceF5Oz92VF8h4uF6xYeukj1lpnl+FsajBT35LrzZzl7anTJ5dUL6dDdco21K0/x8=
X-Received: by 2002:a50:ee90:0:b0:565:ad42:b97d with SMTP id
 f16-20020a50ee90000000b00565ad42b97dmr48160edr.0.1709750431360; Wed, 06 Mar
 2024 10:40:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306181117.77419-1-cpaasch@apple.com>
In-Reply-To: <20240306181117.77419-1-cpaasch@apple.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 6 Mar 2024 19:40:16 +0100
Message-ID: <CANn89iLrwYrKy7LEb+tpq=gSB9pn6M5jwtW_VE2LSxd6DoZL8w@mail.gmail.com>
Subject: Re: [PATCH net-next] mpls: Do not orphan the skb
To: Christoph Paasch <cpaasch@apple.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>, 
	Craig Taylor <cmtaylor@apple.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 7:11=E2=80=AFPM Christoph Paasch <cpaasch@apple.com>=
 wrote:
>
> We observed that TCP-pacing was falling back to the TCP-layer pacing
> instead of utilizing sch_fq for the pacing. This causes significant
> CPU-usage due to the hrtimer running on a per-TCP-connection basis.
>
> The issue is that mpls_xmit() calls skb_orphan() and thus sets
> skb->sk to NULL. Which implies that many of the goodies of TCP won't
> work. Pacing falls back to TCP-layer pacing. TCP Small Queues does not
> work, ...
>
> It is safe to remove this call to skb_orphan() in mpls_xmit() as there
> really is not reason for it to be there. It appears that this call to
> skb_orphan comes from the very initial implementation of MPLS.
>
> Cc: Roopa Prabhu <roopa@nvidia.com>
> Reported-by: Craig Taylor <cmtaylor@apple.com>
> Signed-off-by: Christoph Paasch <cpaasch@apple.com>
> ---

This seems reasonable to me, thanks.

Packets are immediately sent, there is no queue.

Reviewed-by: Eric Dumazet <edumazet@google.com>

