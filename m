Return-Path: <netdev+bounces-127783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEF59976708
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 12:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8681285BEA
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 10:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B948719F402;
	Thu, 12 Sep 2024 10:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VoKHfiif"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF0F19CC27
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 10:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726138457; cv=none; b=FVM1bq/vLqmesExli7Lpj/hfzOzUhMJ8J4SasFGU6bacn1d5QYTV+vZJ7T663eLcF8I2k6x07aYjAfFNc0VCtc8lRidFH5tpJUu6uww8r1xPJMfXDV+qopJIoatuc2rvww1Rq9tHTBiWJSnMWct2ONQyFgpfpI8romsCTervd9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726138457; c=relaxed/simple;
	bh=d0DzkbzKG76vXT0ymBXG4aOJbKILpuqsNeFGPFN/3rM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LO1pCwUW8VeLL5OZncjgWNJDKrqYQNMz0ocEicdQlNpxFpyO7O+mEeHIUfYiAxDt6NnLrzwUc/ZGaCNeODqFBwkv5HlvIYXruUXjVOJVrt27nhiGajGdhV5mJQJP0aqVjSsKZk3DDSZMc2Qm1mqbiJo+dH2SRiFo6c8FHZfLLhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VoKHfiif; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-53653682246so1030183e87.1
        for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 03:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726138454; x=1726743254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d0DzkbzKG76vXT0ymBXG4aOJbKILpuqsNeFGPFN/3rM=;
        b=VoKHfiiffpGWaqPcytFJ2YGUgeG+wiZck0BCmNCxG+iWsJjh1bMkYOm4bvl4edsMFu
         GUlfl3RS4lRh7hs3wDjCooK9S05yHlY+8telkOyh/BSyIWVEx3nzYMrn0xmkP8AWfc5V
         B3yl2OQjqtAwzUWaDbnt4BX3hq6i/7VDdFehuxW1XOUMviAv8FYkB9rki96vquy9n1Lt
         M+vokpm6GKvW9Gv7z7PuTV+DEQlpdvUgawzk9krDSYaGJ8pVqgDeqGAwCZr5VBVm2d9f
         H8j+wrTVlurtdKu6Hvq8vhqh9/7QM7g+8QmyIYvMDT6hY4OxnK8k0/+gTEiUyc+zn9Nx
         Nvyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726138454; x=1726743254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d0DzkbzKG76vXT0ymBXG4aOJbKILpuqsNeFGPFN/3rM=;
        b=qPbyJzdZtkesffmQ0Mr4lmVRTWhlanUw5fdso4G1Jv37OgyKurGIOADczNePd0d4Zs
         LudiV/0f6bCTpyzvop1R6aOhmupuF2KZbRmp6qk/9AzyTWRd9Hhi4BvBda2oGjwdpS4m
         ggCfMqxOYhnE9uv5fhCJn4yGZy2PIs6EogWd/+zdneYQGsdrjcH+DriIpco3TG9JB5aX
         G4DZy//0G0s9KOUWJRGRNfxhHA+8Bb9NDRTvvXrTK8/gvmB6WiCZdap+vwAnCr46H/ng
         H0sbiIFSQ8GdpVXxiMzY3xeM+SZeNwczB8yAej+eGAx7jh8I5ldDHJAn76sdSKTB7Bdb
         EcHA==
X-Forwarded-Encrypted: i=1; AJvYcCXAKefF0R6SIDLZIpe5WxL1OnC4dVXLuXTyM9hFP+RmBxjWPbLiaQKbDAfeYY56htai3yrneDw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXRAyplscKXRuizvtbbhjHw1xBREenxk2QsYTUw/linCXL8p1s
	qcrTPzAdGfKL5i11wDYagJlj72q5UV6xTxTZyximY9SAOIDAyLW9bVvCt1r+9sib1I/8rMYZoY6
	4NftxMw3cj22MZEngB3ThA9HRhdkiwiFHHH6P
X-Google-Smtp-Source: AGHT+IGq6zXokPIMzhfJKZtNReSDwJ67+QqTvap67eYcwKY04gpU79NBiS1SHGCYFm5kv5weOdjx69Fb0lBE8fQ0/L4=
X-Received: by 2002:a05:6512:b9b:b0:536:52c4:e45c with SMTP id
 2adb3069b0e04-53678fcd1c1mr1486136e87.31.1726138453287; Thu, 12 Sep 2024
 03:54:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240912071702.221128-1-en-wei.wu@canonical.com> <20240912113518.5941b0cf@gmx.net>
In-Reply-To: <20240912113518.5941b0cf@gmx.net>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 12 Sep 2024 12:53:59 +0200
Message-ID: <CANn89iK31kn7QRcFydsH79Pm_FNUkJXdft=x81jvKD90Z5Y0xg@mail.gmail.com>
Subject: Re: [PATCH ipsec v2] xfrm: check MAC header is shown with both
 skb->mac_len and skb_mac_header_was_set()
To: Peter Seiderer <ps.report@gmx.net>
Cc: En-Wei Wu <en-wei.wu@canonical.com>, steffen.klassert@secunet.com, 
	herbert@gondor.apana.org.au, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kai.heng.feng@canonical.com, chia-lin.kao@canonical.com, 
	anthony.wong@canonical.com, kuan-ying.lee@canonical.com, 
	chris.chiu@canonical.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 11:35=E2=80=AFAM Peter Seiderer <ps.report@gmx.net>=
 wrote:
>

> Same change (and request for more debugging) already suggested in 2023, s=
ee [1]...
>
> Regards,
> Peter
>
> [1] https://lore.kernel.org/netdev/d1cf5a66-03e1-44b8-929d-ac123b1bbd7b@s=
ylv.io/T/

Indeed !
Nice to see some consistency among us :)

