Return-Path: <netdev+bounces-118164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E051F950D0C
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 21:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DD3D2862B2
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 19:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E231A3BD3;
	Tue, 13 Aug 2024 19:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e/BtrOOE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFFB19D089;
	Tue, 13 Aug 2024 19:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723576799; cv=none; b=RA8pIJrWQRQSoVZHztBqb5fEx50/41Ksc5mD3uLuku6Z6jAPa66HHIllMpwPpnt88Gl8goOgwlx+aiCnPTVPbGzV1Pyagw2YH1NL2zbcq1ROKYjBDP0J+atQ+wNvH7F39t80e8vzsWN2u1UyI6U+G6rBAT+57d9v9UlQvE5PoLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723576799; c=relaxed/simple;
	bh=91jbPqvG8mg9PHjdwVI/XMIHAZ7qHDpuV5SCZA4vFdQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=HoufYp2ClJIUXNsK/7k3aiX7o3O/sYpBNGV4vIkKPSN1JK/rHxlqH7WmZsxnpB6jEVydRfgja3jHraXFcJVcIx27c+tDZ1qBEGw70cTg7qrrNAbkql4ubrn6JEXkMFbg0HwlBuNLvn31LJgcjTGrhzuTFVG7olnVC9Rhm1rtBr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e/BtrOOE; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6b7a3b75133so40133476d6.2;
        Tue, 13 Aug 2024 12:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723576797; x=1724181597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bXP2A7Yp0aLXfQfJVM0Q1xT0ky4rj4OjQsff/aI+tMU=;
        b=e/BtrOOEtc4XDVaCwz+Fxy8Y4t6mK2rC3pVNzkPDb1+FaOwm7NwzWAYS3ZeGTficcd
         WTyl6xtf6JB9v9aFxSyozhBSMm/2Axa/NW/TNR9KFV86GqJZ0xccOkbnjsRRRPOPL8eX
         21Tbh6hYR1LLMTmvaibNmVjCftkLfCb9cr9/4fWmk2/6G1ytEcuBnrYZbkCfFghRE4jg
         Q6vnJol103eIA0YhOm6pqpqvhU1rl5oxCwjRjcj+ImWAoXfbIjydkpfSuNtOGvTZDQ4Q
         DFG2NMQims2qNAPLKJ2HEwLz8Iu1aZDGv0Gc+qj15vjDCj2EpLmQv9oQQLQ0EYv4/zHD
         xp4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723576797; x=1724181597;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bXP2A7Yp0aLXfQfJVM0Q1xT0ky4rj4OjQsff/aI+tMU=;
        b=W3N2kuvHXMggA+Ad9G6Qo75vOPe6iPYe/BaphvKr1HboFBGm8fbj6fc/uaCYKRDWCR
         u91HxPqMBE1MzvvYKRGOpqdSsHyuEnni7taNggnf86msTNff2G6YvHXCGVQDy+R5Ffsc
         YyME/31k7X9e5WFaVG++5/4xrbsczMf5MTsq9GWhxZJszeJyMjQssFwHpEeaVX6ilfl3
         HL7XF2l1Nkqe+vUNeNOyHHjR2P5BfJRBnDF67EzCSKM3snnkJE5i46m6uyOWphx9HX00
         OSF/0h+z5KTXXypMAMCV+1IGi//0eCFjUqHnzSSlm8haLsXdv6R/mFalfQ3PNSmRsMCT
         UbQg==
X-Forwarded-Encrypted: i=1; AJvYcCVlyPixmjrkXHYHriv2PI2a7iHzsKEuqaKSFbLXB1amamcivq8XyL0n9WFNlj66dxn2k7yxvJu+c2Jai/UT8YVojHZdQaIOJBC89l8i
X-Gm-Message-State: AOJu0YwpgWzPLFn/c/kAiMZY57lDTGbsCYW0pnTgIjbEmuJbUHaK9nru
	Hla3JpZRVeRNoK/2pcS1Hp8t0zCOZqg0PGFLzOofvgIgGi3c6EkU
X-Google-Smtp-Source: AGHT+IE//BtTdgGtcjY8KsbsPDOzbBdfE4Wbq7FrqHt1qDrQehdsHgj5k0ppLZ6VyszfHnaXk9S6sA==
X-Received: by 2002:a05:6214:3a08:b0:6bb:3f92:13d with SMTP id 6a1803df08f44-6bf5d24a89amr4791716d6.24.1723576796290;
        Tue, 13 Aug 2024 12:19:56 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bd82c7d684sm36691996d6.33.2024.08.13.12.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 12:19:55 -0700 (PDT)
Date: Tue, 13 Aug 2024 15:19:55 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Manoj Vishwanathan <manojvishy@google.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 google-lan-reviews@googlegroups.com, 
 Willem de Bruijn <willemb@google.com>, 
 Manoj Vishwanathan <manojvishy@google.com>
Message-ID: <66bbb1db36a9c_8a56a29485@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240813182747.1770032-6-manojvishy@google.com>
References: <20240813182747.1770032-1-manojvishy@google.com>
 <20240813182747.1770032-6-manojvishy@google.com>
Subject: Re: [PATCH v1 5/5] idpf: warn on possible ctlq overflow
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Manoj Vishwanathan wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> The virtchannel control queue is lossy to avoid deadlock. Ensure that
> no losses occur in practice. Detect a full queue, when overflows may
> have happened.
> 
> In practice, virtchnl is synchronous currenty and messages generally
> take a single slot. Using up anywhere near the full ring is not
> expected.
> 
> Tested: Running several traffic tests and no logs seen in the dmesg
> 
> Signed-off-by: Willem de Bruijn <willemb@google.com>

This was an internal patch. Not really intended for upstream as is.

> Signed-off-by: Manoj Vishwanathan <manojvishy@google.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> index 07239afb285e..1852836d81e4 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
> @@ -218,6 +218,15 @@ static int idpf_mb_clean(struct idpf_adapter *adapter)
>  	if (err)
>  		goto err_kfree;
>  
> +	/* Warn if messages may have been dropped */
> +	if (num_q_msg == IDPF_DFLT_MBX_Q_LEN) {
> +		static atomic_t mbx_full = ATOMIC_INIT(0);
> +		int cnt;
> +
> +		cnt = atomic_inc_return(&mbx_full);
> +		net_warn_ratelimited("%s: ctlq full (%d)\n", __func__, cnt);

A single static variable across all devices.

If this indeed should never happen, a WARN_ON_ONCE will suffice.

