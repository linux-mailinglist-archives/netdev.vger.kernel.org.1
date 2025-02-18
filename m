Return-Path: <netdev+bounces-167356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 513D2A39E5C
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 15:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C577B1895EF4
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 14:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A466926A087;
	Tue, 18 Feb 2025 14:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s61Zd+sy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA46269D19
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 14:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739887849; cv=none; b=dH4Sgq1K2yrajiVWsCdmpHGjREhsBdWw0CXEV+TylnvS/UIlR2OS58UB2rj87w+bA0Abfi6NfECdJxqdHb6+TtFG+2subkCKVgtAB1MO//+YAMdRSePliXGyGnkXFSiIV7mm6kjTeyPA5L5pNnDN3NHsuBHPbXe0Co87yZGKL3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739887849; c=relaxed/simple;
	bh=pYZQoGq0Q6jiIla+I6H4Cy+gFjN7ntyNXEcQWfUkRfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aOT+bMrdlDYKlwM0SiInj3ZkSMnK4vIOuhBywyZQdbxUdtYuahW7nZOzDWjzPgJlYs8gv/4rIu5g7wC1kXDpuMjsh+tzWJTANklSLjm9NYdwL9eo3rg6o28NIKZdF7o4LLVL4lThbGoxc1eJlVMW71tqjh4EZu99rob57dkyBgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s61Zd+sy; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ab771575040so1270015066b.1
        for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 06:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739887846; x=1740492646; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J/Px4JvO38gHs5ao30isbGAauKHfVt5a0v/k8jIDyq8=;
        b=s61Zd+sy/JvNYeo32paIAhfdjXcekbQ5Wzngt+FdmuiOG1LctcQsUMSywTQrhN1+V5
         weR5uwXdGQrG3qVH1BNKW454YW1hpPxoVdEDGugFjdjtEMVoVoJHd7IQhQX62Ma9ky6Y
         AqQ9DKkgR9ddW6H3egRqoIUQWqcRM1DRDVF/yYVw0LdvAzJNXEJnzjokesIGgRlejikl
         Gs5oYu5qbA4Dz9ABrJsTjlTi+ygolA/LO5YkJzKVQpzIM/1+Lkx+0KcUWb0qJ1e+4cxe
         6jpj/gdrw+3mzC19gbE2BPtju3y/lvosEShXuUzQiLEWMEjaDOemZXuXFd6/D5pAoZZi
         mAPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739887846; x=1740492646;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J/Px4JvO38gHs5ao30isbGAauKHfVt5a0v/k8jIDyq8=;
        b=IdBOeJ3nrTOEZfwg1u9LbXFbNda3+Oq9D9cADqWFyisRUMBzpN5q2BiOQqCergCc0v
         dS/HF/66M7TlvorpnWAMn9LrkCLELO6ZeMCeZWm9u4r9TqxJ8bJ9wxKVZrGst+E6za4P
         5g0CJmnU4tUdPxjNIuBbU9wEWPKXTrnGzRmqlpVSzBRiBRBpokDnGFzWnGDUlqf125RJ
         gtd71LbhipoHr6MWpnzAd05NkIEkIiknN9K1gutmssh97HXByxiv20U0IheFC5y3GCsF
         61yJcTEdmBtFi3PJ2c81pNW67rRH949eN/C8Qt6mcCPkvpq/FCj7yphgpuSR80OZJ92F
         B+Ng==
X-Gm-Message-State: AOJu0YxLfI6BlWxIpYHVkBD2OhuGuUZ3pELyRmOdZftC0mqAG5X2EA5x
	X6sv14gAlWoghbLZx/XDqxqmsoXm6D6gAk/jqcgcoHxKK//amh44/XOuBuefbytdYYXi8s9jQXt
	h+sbT17EHhjdrk/gdMFj+kOwj1qfvWU18Q2oeOiK6vBSdsD5oxw==
X-Gm-Gg: ASbGnctaxGQKDIjy1KUICCpC2OTr68qMPrx2wa3HHUum8D5dHyjpe/8e8Z3dcLaZ5S0
	VEfBfmeQkFLe7VGWWqEF4kKA5c0zNpsvWtd7gGmxUDay0EkD9At90dSEjrofC7I9E/dpMJ1Dv
X-Google-Smtp-Source: AGHT+IE1dJvhnIvFLWZwika96Z4PCepmLPP76R+6toQn2zfH3moEMEgM9+mGyhPPpldf3h50snfI0Yt6j+b4MXaS93I=
X-Received: by 2002:a17:906:314f:b0:aba:e1eb:1a90 with SMTP id
 a640c23a62f3a-abb70410b2fmr1328338266b.0.1739887845830; Tue, 18 Feb 2025
 06:10:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217232905.3162187-1-kuba@kernel.org>
In-Reply-To: <20250217232905.3162187-1-kuba@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 18 Feb 2025 15:10:34 +0100
X-Gm-Features: AWEUYZlJETlY32j9jekVjsBYuM8nMla_Wmt0l0MOAbPovoDlKyF0WEu1bFsX6WI
Message-ID: <CANn89i+bKi_fyfj5ui1Evq0WTjGRFj5Aj9Yf1f+L31FfVQeF6Q@mail.gmail.com>
Subject: Re: [PATCH net] tcp: adjust rcvq_space after updating scaling ratio
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, ncardwell@google.com, 
	kuniyu@amazon.com, hli@netflix.com, quic_stranche@quicinc.com, 
	quic_subashab@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 12:29=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> Since commit under Fixes we set the window clamp in accordance
> to newly measured rcvbuf scaling_ratio. If the scaling_ratio
> decreased significantly we may put ourselves in a situation
> where windows become smaller than rcvq_space, preventing
> tcp_rcv_space_adjust() from increasing rcvbuf.
>
> The significant decrease of scaling_ratio is far more likely
> since commit 697a6c8cec03 ("tcp: increase the default TCP scaling ratio")=
,
> which increased the "default" scaling ratio from ~30% to 50%.
>
> Hitting the bad condition depends a lot on TCP tuning, and
> drivers at play. One of Meta's workloads hits it reliably
> under following conditions:
>  - default rcvbuf of 125k
>  - sender MTU 1500, receiver MTU 5000
>  - driver settles on scaling_ratio of 78 for the config above.
> Initial rcvq_space gets calculated as TCP_INIT_CWND * tp->advmss
> (10 * 5k =3D 50k). Once we find out the true scaling ratio and
> MSS we clamp the windows to 38k. Triggering the condition also
> depends on the message sequence of this workload. I can't repro
> the problem with simple iperf or TCP_RR-style tests.
>
> Fixes: a2cbb1603943 ("tcp: Update window clamping condition")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks !

