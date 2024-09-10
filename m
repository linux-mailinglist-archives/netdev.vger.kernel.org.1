Return-Path: <netdev+bounces-126889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B300972CA6
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 10:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 252091F220BE
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 08:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08CF818800B;
	Tue, 10 Sep 2024 08:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g4oq4G69"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE33187FF1
	for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 08:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725958634; cv=none; b=EmtF+1IhX5SmQ0d65gRRjByD35Ug7SYBbySPygKEWJ1Y/7SwfxH+eIAai6+xo7xnwXDokEP8lq84Dvf2XF5A5hAhJpHDnotcWqEU+GiKLqi55+3eWLRKBjkFwafLnn9qQoVHZksiPtLSvoD08EKkFwZ/xVH2nu0TD6+ETBS53BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725958634; c=relaxed/simple;
	bh=KWvP5hzroBed5igOh1z2RVnYu3uWa09cY5RjcNsx7AY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RuZHCcTyyxopOHHEmgb5fVc5vjolLftUxUTPUU1A8slbFfEDy3A6PQlfv/urXtwDJtz7ZOKa10DAktSRqK8kpd/j4DBY43J06ihcGkMnYTA/3pQkofhPq1F92s9XJFb6VHFzgY5LFcNT2T8lwh+dWaAq1lrNm3YjTwIui+gYt0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g4oq4G69; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a7a81bd549eso49186566b.3
        for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 01:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725958631; x=1726563431; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KWvP5hzroBed5igOh1z2RVnYu3uWa09cY5RjcNsx7AY=;
        b=g4oq4G69gCeLTrinxH/rP1KvN9na/TPrrsgupcrrCc1aPslxjPE73hx4MNuCXa07t6
         FxQSY4liZkYhN76vxlz20BVkzcAQ8DF8d8moE3oVeyCX5yCI01NwoCz8LFgmGg0Bxgtd
         WlYfxlUee6bWQMjfLbejsjcuf0gMGdyAulBcLMT75wHIDXUHnQ6rrjPNV4UpbE9U+N5y
         IecUhZEpweDvZjrPcdqKv9dp4s+fDw2z/0eo8nsGFoi9xQ7WsnYGUFEZjiAVpEkkyysY
         WpqgGl/4W5ruKUs+qJrsDeEqON3vbLhVeEoBpL/eFCZIravITEBkXVdkferpFVIfDY/x
         4MlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725958631; x=1726563431;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KWvP5hzroBed5igOh1z2RVnYu3uWa09cY5RjcNsx7AY=;
        b=CyjqY7XW+1nellA1zpYJSpEbldLl/jnV/9r7ijFO0uOEXskbPqikcDGT+B/5RJcyec
         3bbBRTB/EMkFVuUYI9d35o0UdWtcSgb0ZlJbXObhBFVes5d5DVhk0NFqhTTdvqnixyPY
         ui3MqKbj2B2WzREH/2PFbLgQ4HPWloSN/E+WVTiapA82mlCEUW7xy2YuUhTP/tfA65rL
         ZQ/QRDV+R0Fl9U4YWmdgfCz6hPIGdenx12q3F2h/qInLPHIhvB4mBJm5RG7u6uNfFpqM
         9g6iADSCKPVl7nKC7yFzXGqnl83nMYgZ7y9E2b7J6wCaRH1rSq8za1Td9S7kFGKKsUl0
         PQ3g==
X-Forwarded-Encrypted: i=1; AJvYcCVKeV6o1L14PNo7TWi5lZaeBzDxiXMy/u6uEXAhLQDeoKoYbaeOA3vw+TboUpZHPwYjLoIe+y0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMnvsvZ7l3osnrZbm8dltq3jNUpWATU9COFfHrNMP/CJXeW95O
	KHhlUUXsTxwK/yb4agtpOqs7oGkOoqHDwPi1pFyP9m1+D8po1M13KtleqZ95c5MfFZdMvwtjQvZ
	Z1znGtIl3DDYu7cVgRDXHtW++Dgn1hwSeNyIH
X-Google-Smtp-Source: AGHT+IGtExah3ON+mtcvZ6TYqbMlUmlezXeColca8ydpxAzUWBAoJTDmkqfimyO8p/TwLjdAwiTKBSJMiyTwISfNC5w=
X-Received: by 2002:a17:907:97d2:b0:a7a:a46e:dc3f with SMTP id
 a640c23a62f3a-a8ffadf90afmr2909066b.45.1725958631179; Tue, 10 Sep 2024
 01:57:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909160604.1148178-1-sean.anderson@linux.dev>
 <CANn89i+UHJgx5cp6M=6PidC0rdPdr4hnsDaQ=7srijR3ArM1jw@mail.gmail.com>
 <c17ef59b-330f-404d-ab03-0c45447305b0@linux.dev> <CANn89iJp6exvUkDSS6yG7_gLGknYGCyOE5vdkL-q5ZpPktWzqA@mail.gmail.com>
 <a4c02c5b-af54-456b-b36a-42653991ea34@linux.dev>
In-Reply-To: <a4c02c5b-af54-456b-b36a-42653991ea34@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 10 Sep 2024 10:56:58 +0200
Message-ID: <CANn89iKMhCJietM70bYx+ZEjqTLQjUvQJFno=AQ9uStkhg57Sg@mail.gmail.com>
Subject: Re: [PATCH net] net: dpaa: Pad packets to ETH_ZLEN
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Madalin Bucur <madalin.bucur@nxp.com>, netdev@vger.kernel.org, 
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org, 
	"David S . Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 8:02=E2=80=AFPM Sean Anderson <sean.anderson@linux.d=
ev> wrote:

> OK, I tested both and was able to use
>
> ./pktgen/pktgen_sample01_simple.sh -i net5 -m 7e:de:97:38:53:b9 -d 10.0.0=
.2 -n 3 -s 59
>
> with a call to `pg_set $DEV "frags 2"` added manually.
>
> This results in the following result
>
> OK: 109(c13+d95) usec, 1 (59byte,0frags)
>
> The original patch causes the nonlinear path to be taken (see with the
> "tx S/G [TOTAL]" statistic) while your suggestion uses the linear path.
> Both work, since there's no problem using the nonlinear path with a
> linear skb.

Maybe it works today, but this allocates an extra page for nothing,
this is an extra burden.

Vast majority of skb_padto() users call it early in ndo_start_xmit(),
let's follow this pattern.

