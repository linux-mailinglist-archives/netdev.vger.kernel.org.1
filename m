Return-Path: <netdev+bounces-211657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62693B1AF86
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 09:42:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36279189D8A4
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 07:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2673C231A30;
	Tue,  5 Aug 2025 07:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bagpIbUy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621F522D4C0
	for <netdev@vger.kernel.org>; Tue,  5 Aug 2025 07:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754379753; cv=none; b=bR1uuyl7Vg6BvtHUxD3Om88BHSZ5Jwur1M2MRBWtXuT2FgLlWn3sEBoW26AT/te98MngYqGZzHnDvqrlhzYK6wZ60TxKHf6qPHotwnHHeVzVzG7BSytw1ENZxeB9wGMbreeOJb3mcGf4YeODuEEu3rLo8e77CxmIqythpuoFr7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754379753; c=relaxed/simple;
	bh=PvOjOq4a7/sLJ2mPzI6vVWGXUMPe7WugpFCPR2jPV1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DNLBd0NBhyLDCcWn7B37yUejiUYUEpeunKLFjHXt51BpkwTE4svEoTPezgqZjXVrA4MjXIE2xlPQ4ZvVqhnatmO4JxT9KLu960uDjCDd/AFL0IxcCfcVNX9oENFl3cEfhXBhr6QQku/hW6QXEZhTLfAufUoLbsIb6VEeTmwywSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bagpIbUy; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-af938dd1109so61173066b.0
        for <netdev@vger.kernel.org>; Tue, 05 Aug 2025 00:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754379750; x=1754984550; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N7lYQKeM21EfOgHZuI+h8piKSOuVs5hvK8kasVWKtYw=;
        b=bagpIbUy8ogJfSfr2L46J42z5Xn8hx14gAXBtQ1TPLlb72CmK9V5ECjiCoeylqoEVZ
         n5MDmaPMds1qaRUHj+FZaUTb9tMdWeAXrL4CqN29I1daSbRZz1Rfpaugtywa/FGPyumK
         zXUeI1LoYO0qAsg0c4mMzrPf2ZWFs4VWReFfQloSC+ZvTnnOvtth3xm1LSDHoxbNLR7i
         S2s6PRUj6iKkG3978XuC9wllvTpM2a6kNfr+CsoRavXmy5AblitPnbzX3OExQ6gKheVD
         tcE4AK1WrhF1jPA6WjMpV4mP//Unftd3KBcrYDkf4OSxBq8einyHaKPSORGnOYVkbsXz
         D8kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754379750; x=1754984550;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N7lYQKeM21EfOgHZuI+h8piKSOuVs5hvK8kasVWKtYw=;
        b=SjmrvU58Jr9MZkAN7CQzZAlMT/Bi2QRTjpvl3bKHWgPKYT/db6hkpFO8hzhMWKLOF4
         KOiaBBpszWKspK+nSuDLienWGjuXxA6cVgGSo8mdj14Fb40PIN1+g7GuamDOEqexGhcF
         cninJzYW79F6VcMM5/jlPXLai0KfJRJV6aIsbru2OLKaHZ82zHPDc0UbwwXwprI26Ntt
         hh/uaK2S7p+atFH0Qz5tLemOXVGFVfa3T0WUx6875hRso0E68+NDHBlvICWol8WVpHeA
         5+rJoiCJl0EjFpLenUkHylmNIaPGH184FM6MeC5KHBN9N4R7eiXTFhw93eYQyqYB5NU7
         L+3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVNxryUsNi5qt2q7vSJtDBHKo4hCaFyMu+OupjVyPd1dPi9/YoheM4nuNr7sbIX/gdLQQusKTo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1KdzlZFFLpMWmOzNSPOFE1aCA6OBD6CUBPDjqsndw3KSdfiEP
	BtfWRlgtERMjLtR+s7orxiOFh/KCOkoDtWzFowYZxuWGKxo4DbaTSWl8
X-Gm-Gg: ASbGncuy5qnXgb6RFAYOfjp8rfLvct+o9vtNZ1AFozqGfemmKTcvl8hSYnBzibmvLS+
	z2brxflUjAlKapoBS61l7ZZtO2fX4Kvqw67lEBiqOeXX/f9H/iAwpzxe0W6RRRCDryKXs27gsJI
	Lkp7OobgqfwqqkNKz5xoN1Tsb+bw7jYSqvBpWUZ04k0IjJw4Qaokprv/3Y39Yv5NL44UE58xHNz
	4Se6j1brxwqPoMymES992hdn8JK++0L8mGtO6DVnKkLE5etW87ONfIbh0a2Tb8pJogS12feIlIP
	g6xn1u5vfMUpscSaHbnGEaf/1hNrmf8RrpI33X5pIpTZlIOY02oUXFKAA0zP5ojRVbT67k0Ql+G
	P+0341ZgiahGa6yQ=
X-Google-Smtp-Source: AGHT+IFWGYkwzA0RuZT0uDIEDegQJi6foC5CD9vSepUZkSGPYUBmDD4KzEXhsF/A2nzV7SLLxKiuNw==
X-Received: by 2002:a17:907:6d14:b0:ae3:5118:96b3 with SMTP id a640c23a62f3a-af93ffc6aebmr477733766b.3.1754379749267;
        Tue, 05 Aug 2025 00:42:29 -0700 (PDT)
Received: from skbuf ([2a02:2f04:d30d:7300:21a3:d17a:9a3c:9dd1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a21c08csm865599866b.118.2025.08.05.00.42.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 00:42:28 -0700 (PDT)
Date: Tue, 5 Aug 2025 10:42:26 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Ryan Wilkins <Ryan.Wilkins@telosalliance.com>
Cc: Luke Howard <lukeh@padl.com>, netdev@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net] net: dsa: validate source trunk against lags_len
Message-ID: <20250805074226.agdnmeaip5wxzgkz@skbuf>
References: <DEC3889D-5C54-4648-B09F-44C7C69A1F91@padl.com>
 <20250731090753.tr3d37mg4wsumdli@skbuf>
 <42BC8652-49EC-4BB6-8077-DC77BCA2A884@padl.com>
 <20250731113751.7s7u4zjt6isjnlng@skbuf>
 <C867697B-7F5B-4500-8098-9C44630D7930@padl.com>
 <CAD3ieB36VnKAQPXUGbnRdWYFThf-VfLkhZTRfb9=ddndZEW3=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD3ieB36VnKAQPXUGbnRdWYFThf-VfLkhZTRfb9=ddndZEW3=A@mail.gmail.com>

Hello Ryan,

On Tue, Aug 05, 2025 at 12:06:32AM -0400, Ryan Wilkins wrote:
> I cannot confirm if the problem reproduces without the in-band management
> patches applied as I’m testing with a Raspberry Pi that has no current
> ability to connect to the switch chip via MDIO.

Last I checked, the RMU patches did not offer the possibility to control
the switch exclusively over Ethernet; an MDIO connection was still
necessary, mainly as a fallback to mv88e6xxx_rmu_available(). Has any of
that changed? Who enables RMU management in the first place?

> It’s possible that I could get into a place where I could attempt to test
> if the problem reproduces on an i.MX7D which is directly connected to the
> switch chip, but this will take some time to work up a custom software
> image for the board to enable this test.

I think that would change too much, and the possibility of spending time
in vain is too high.

> Luke is correct in stating that I am not using LAG between my Pi and switch
> chip.
> 
> We could probably modify the system to capture skb_dump() output when the
> error condition is detected, if that helps.

That would help.

