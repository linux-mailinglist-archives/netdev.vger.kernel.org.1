Return-Path: <netdev+bounces-96687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B12238C726B
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 10:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22E9C2830FF
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 08:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A533136E32;
	Thu, 16 May 2024 08:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3Fz/mo6S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9381369A1
	for <netdev@vger.kernel.org>; Thu, 16 May 2024 08:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715846660; cv=none; b=cJVf7i4Xi4AtHI4uA7qxHPNDyq1rzgJfJSbEgX3o1CObxMWP9A2oaqtsN2aBan721Cm90Nex4ngppbir62jE95tKoI6i5fqwqdvszXhOYhw27ryz/Kj7OWM+aISYxtCJl7V/Cw0043eDP9bABG8cr3mjEqsWU3YTIZT6EFdfi+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715846660; c=relaxed/simple;
	bh=yobwgRL6pIzLvUO+E6nJFjrsnlzyspZDqXXMbvg3zfI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kw70l/P13uwrX6GBTNzugyjqaX85VZsKUtKW7rV/t21PnkrvIw0MynE/nwuJK5rDfuhwCII8b659UFeNfpZUEmCuNVVuD5tNANZxMux2Ww+Wwx48Dovap9MRsg6ngfYGoUQ1M29F7pAdKtYMjxE8K7tZulgBgGZ5wAWFqLqzfCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3Fz/mo6S; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-572a1b3d6baso44284a12.1
        for <netdev@vger.kernel.org>; Thu, 16 May 2024 01:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715846657; x=1716451457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yobwgRL6pIzLvUO+E6nJFjrsnlzyspZDqXXMbvg3zfI=;
        b=3Fz/mo6S/qFaA3f0h22G9pLlPdW99lTBLr73sjmHSHjgqR2RZx2rXxtoCZdLnfqGoa
         Sw9e6B80mlDW4tvO452ICqHrqUnkV7HChFmaGiBxd7+JPQCx+tb4Dg9mY5h7O+qZfmCN
         ol6p32P2OY78HSviv5VjjE3yDgo/fZdZHVizZZXgqxYgVeuX5n0Ly/uEGihELhzUdNQT
         JVAt8TYLR8Hs5CVa0CSN2a/qVz8gQt5OaTmzSzW8oBJAX+5Fe/Jx8dF+Ap0Thlk42pII
         h5UDHwS5ILG7FfovcEa4WleU7X7LGKET08jcDlKTi861tGjXW1KLtHHssylOY8g7kcTf
         YIpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715846657; x=1716451457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yobwgRL6pIzLvUO+E6nJFjrsnlzyspZDqXXMbvg3zfI=;
        b=PPvlOyPboqdb8tWMlrxpi/97aaegpv49qg7N9XBhgDc5r7apsTg92Z/7sp3bc0BOLZ
         KHHNgaylOkxe4j6RFAz3YJugjh+yqkWmrDjBbP8oTYNbrkqLgJn8O3eWNe0NlXf5CvNr
         nCY6scQH/2/G7rJkHlZz3A4cBual+mVcn3w8jSqFzsGsqusY98tANhINpJHMo2tG3R/i
         q4m+sQkxjH8P1RxaJJj4T4MO6Yycg8QxSRYT0ECZXceFJOXSUywTr0qy5/VYEY2MWIM/
         3S0hCaYw8Zu+Wzv/0zKjWzclXLPy5+tOpzXNSnEiIdMqZMMbiMxaongJPZH3XH1u7MMJ
         x1mw==
X-Forwarded-Encrypted: i=1; AJvYcCXS7DhpsLqLhfJ5zdCvtnHQKro0pwatqTBWQqm6P3C2t4Kil3QkA90TgTzWVMCCT2Q44LbZvDJoeIzFFewCPvVu0a7lHq0m
X-Gm-Message-State: AOJu0Yx6ngYEbONFLuUKto4zv2ZJs7f15hm8alwoQXAwfIYSY1geKELi
	bgYaW1rInZ9V+DGIKmCBTwJVgJAEIeF6HvNFA1Zgj7knxEiEw3jHG5Mc9Jej7OVIQLrORYQx8J1
	GU2LjID3A+0ZlqYMNzWy8UYs+Boha6+RUMDrV
X-Google-Smtp-Source: AGHT+IFOjJE7/drUhfz3WH3Wd4RMmJrXvKRepr/xyCK6pfgjJDPTwfmtoVdUPxPYQENLXVwBndM6A2LJ2rHeFI3FW7s=
X-Received: by 2002:a50:c90b:0:b0:572:a33d:437f with SMTP id
 4fb4d7f45d1cf-5743a0a4739mr935198a12.2.1715846656620; Thu, 16 May 2024
 01:04:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7ec9b05b-7587-4182-b011-625bde9cef92@quicinc.com>
 <CANn89iKRuxON3pWjivs0kU-XopBiqTZn4Mx+wOKHVmQ97zAU5A@mail.gmail.com>
 <60b04b0a-a50e-4d4a-a2bf-ea420f428b9c@quicinc.com> <CANn89i+QM1D=+fXQVeKv0vCO-+r0idGYBzmhKnj59Vp8FEhdxA@mail.gmail.com>
 <c0257948-ba11-4300-aa5c-813b4db81157@quicinc.com>
In-Reply-To: <c0257948-ba11-4300-aa5c-813b4db81157@quicinc.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 16 May 2024 10:04:05 +0200
Message-ID: <CANn89iK40zw8hqtut8u9Jp4+24eCM9m9S-kwdDNRq-P=jkF=ng@mail.gmail.com>
Subject: Re: Potential impact of commit dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale")
To: "Subash Abhinov Kasiviswanathan (KS)" <quic_subashab@quicinc.com>
Cc: soheil@google.com, ncardwell@google.com, yyd@google.com, ycheng@google.com, 
	quic_stranche@quicinc.com, davem@davemloft.net, kuba@kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 16, 2024 at 9:16=E2=80=AFAM Subash Abhinov Kasiviswanathan (KS)
<quic_subashab@quicinc.com> wrote:

> rmnet doesn't directly interface with HW. It is a virtual driver which
> attaches over real hardware drivers like MHI (PCIe), QMI_WWAN (USB), IPA
> to expose networking across different mobile APNs.
>
> As rmnet didn't have it's own NAPI struct, I added support for GRO using
> cells. I tried disabling GRO and I don't see a difference in download
> speeds or the receiver window either.

If you do not use native NAPI GRO but gro_cells instead, there is no
reordering avoidance.

Make sure that only one cpu is feeding packets to the gro_cell for a
given RX queue.

This is probably orthogonal, but could matter at high speeds.

