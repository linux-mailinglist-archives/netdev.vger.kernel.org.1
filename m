Return-Path: <netdev+bounces-163366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA063A2A032
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 06:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A9B5164D21
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 05:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1AD2236EE;
	Thu,  6 Feb 2025 05:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N00/OjCK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382D31FE45E
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 05:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738820206; cv=none; b=RW4LB2UdXaGL1X+oIFWoyx21Qm52Wm1ERufNwKAeUeoSre6BJ9RQVvwRzY4sOYgkG1cmIncUjAHM77/4l1BJzkC1Ml24lCeMTNvDowp5MINMGkMd0SJ13t+UwbTzD+elFjBy7aPPsHHhBIxwUbpCzKW6Ua/8SMloZZgu+7rF2EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738820206; c=relaxed/simple;
	bh=9pyhOo7BCC/5+WBB3NSHjByLORK153VyqFapDYXbNf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WmS9koAEinCKUPO8vZ1ECJbhxptPYqxNQjFD3Hwpn9B+Zolr5LkXwCfKPgdDcx9u/aW4U3gNKRqx8Q0YfDlDt8evlkjoAFh2z+MKkUed9DJZ5FfJcda6iWuWhoFEoREW62/56/PTPN8/AWJVq7DRrSuy5tNzyWCbUxnPlauKDiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N00/OjCK; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5f4ce54feb8so304923eaf.3
        for <netdev@vger.kernel.org>; Wed, 05 Feb 2025 21:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738820204; x=1739425004; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9pyhOo7BCC/5+WBB3NSHjByLORK153VyqFapDYXbNf8=;
        b=N00/OjCKpeJhMIBcz5ebNrzJu5MRrEM8T2Pk7hgnALCW2r9XudqU7BjRC7aIK9d6l3
         ok/dRztZqVenB3Oqbfi/UzVc6yvEAk0Dte2bf5g+ZKiNihMePkdxKyE5t1Q0Wqc1n1OY
         +FQv/wFWWRhjwkc5ovp45O3KkxvYRF4geWkJa/NPvmAFwpXCA8hqjkeuAiqTb50le8tn
         l1WPXeDrHwDgaxdPr11RiYq7qoYICZ/fg1NaVUoj1fDNt+K1bxu7iSyf70eTGGsWWi6x
         lDblQXr4mAl4vPHSuUsiiTqXVJfjrcYunxrz+brvWjSJ6rseVK+4s56OMECgwaOrs3kJ
         Gk5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738820204; x=1739425004;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9pyhOo7BCC/5+WBB3NSHjByLORK153VyqFapDYXbNf8=;
        b=ediZszrgdx8zPL4VpgO/C/nLyxGCadS9ZRe6mGhX7bl+Ay5McRZ7gQB0LsYTSV2R5G
         j30g/2dX2cFJGHcHwScsdL/KfhDnMsXf7OhtsUG4GK5H4vzEpGxauUI7luViq7s+pGpV
         r4TXavKFXX9g7auesCZ7/Apuu3op2XRtGtCfewWIhiwRbw33huYC2b++wmFkwzxJJDfs
         mwET+cK757zfKdzWstuv53VPvcLZ+/5JfCwrWLPeJRcEN+CVsQf2VpyXfp5fvlmJD2kV
         KFdnJTdfk5ojnp9Zh2kyPHWbbmFIZQBHuypUx97S1dUmnnL5o9ewVCIBk6pWYdfWkbm2
         wVGw==
X-Forwarded-Encrypted: i=1; AJvYcCXdkHpEpXmHitVp8jxax5oYl0LcMKXBATZ2xZr0Z/2xaO+VegauTlRgoFfKjUTudjbOjGUpN3Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5Dz0cUP1nJalwYurodpXG36V2G4iquW9cAF5GmBhvmsU6dCwt
	uuJCOISEOqIK1kFJhLBJj1xPDpgK23M/QF0ANBc/mppEp/SBFaXeKufMnDYN5nUBpr+BwZKVh2G
	Bum9InTLtejIoTXBzrCWMqU+3SEg=
X-Gm-Gg: ASbGnctxzo0h9f8M2HwHUK3V+u0mKvHIgT8wfE1ZOGZe6I7c9+rieup8/WJ+RuLcbkL
	2qQdLMjxvNPYGU7nyh5MTjwghBSfRogGfBX846gtEOh7sAwvJbir3PiBeIQkHiRMTl/S936RpMx
	8qpLTjhAq2HY1BECbsg0zWYbM2gq5o
X-Google-Smtp-Source: AGHT+IGnJGVdRsjiDYMI/2wWCOubNE3jjtkjGfrg1TIqUaWAwdenyl8ASFvLUf6g+Px7EySGZJ6LS3FfUswMxSt82/I=
X-Received: by 2002:a05:6870:c69d:b0:29f:8a1b:f76a with SMTP id
 586e51a60fabf-2b8051576eemr4156879fac.28.1738820204040; Wed, 05 Feb 2025
 21:36:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205001052.2590140-1-skhawaja@google.com>
In-Reply-To: <20250205001052.2590140-1-skhawaja@google.com>
From: Dave Taht <dave.taht@gmail.com>
Date: Wed, 5 Feb 2025 21:36:31 -0800
X-Gm-Features: AWEUYZmBKTLQQwwIorWsF4xefKaHZRRBOhhgqqSMBEdToT4B63wfIUUT_d5qUig
Message-ID: <CAA93jw7tVyiz6Kj8B5zXMqYKxLZSnctGiwbH5hC+4_ZTWpg3fA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 0/4] Add support to do threaded napi busy poll
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, almasrymina@google.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I have often wondered the effects of reducing napi poll weight from 64
to 16 or less.

Also your test shows an increase in max latency...

latency_max=0.200182942

