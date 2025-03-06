Return-Path: <netdev+bounces-172495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE3FA55067
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 17:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5C1A170E67
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 16:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9AB20F09C;
	Thu,  6 Mar 2025 16:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="dS7JjNSp"
X-Original-To: netdev@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887D71991CF;
	Thu,  6 Mar 2025 16:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741277983; cv=none; b=tVw1BWDL5pAxrOrGxDiPQORWbXhCw/HrjhKFdHTc9dgvxUVqDfPrxLb4iwUNLcvA2Dds5GgWmPxvSn1OI7mo9i3gVG2hzu8WI6xtcj8nlPnTZJkUcRdG1jPrUHDUueQB5OXG8s8+BCHfERQqKmAEXl9Rkou2wO6WncDgHAoiieo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741277983; c=relaxed/simple;
	bh=mha3/rqc6BD2iffoShtz4KfaDYz7lkqmtpJkKWRR2i8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RW0wfx/polUzRPoaaFZzGT1M0Zhywkox/swGVgEIbk6XhQWOPQ3NVOB+WlIuGx//LSIKQWVuXFg4RBfrg0ZZr0y8nlk0yUxxtj7B7xAIep00VdY9PFyrhP+cpU8ta6gTlTebKlwCm3fMkg7d+/UxNxwokFaAf3tOwXtJqEeZkHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=dS7JjNSp; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 25FEC40E0214;
	Thu,  6 Mar 2025 16:19:32 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id XhiL8TMhWTUD; Thu,  6 Mar 2025 16:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741277968; bh=2JaKV6O0O/0Vj73XlyNNmyimAQdzhmggMcmuSrsq1/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dS7JjNSpUUz8pB3vHUR83NVR42s86t/OupTWRDjgGYObQuWambmQhTl9elUQFq6ZE
	 TrVPLF3PVOZEsheqDeohpwMU2+sOMIdWqzlDnuyAccGUWkzCi8x4Wt1AUS5BmukxVX
	 S9QfoEtvekOzRH/tZTWbuSzgMK56ezgEDuOkNrpIPYVr2mVZhDBbbqqsPo5qCrU75z
	 n+CMXj8PkxkZC4KPNEGk11OORutA1UITOMp+giZjCshSlqnR4tbOZpx/Y9ehQywDJ2
	 exgKMv5iRAeczNgwt+ZzkmKTooUCyonNHIXbA29DuI9nKmyOVcFOzjLWMHoxrg2fx5
	 S5Rm2AvLLV9bOHhEitJx1FuvMuNGZB6ZZIUXwnoT7twZcFnDtovt6CcOTtH+MNv3PL
	 TM2DpPkYBguBK9dZj9eo5KzAUtElAKwUuXtml7UndvvF0QGXj1pDkVsS2L1ESgCwqM
	 ms4aRTEcSnUji+0tdT1WPsHIdKsvdaHnmNr2E2hSl+cAS0Iou+rYlPERSPyH/gywe2
	 RiaVZKwbKMRXAJXCv2vNbNOaMWS64dwJNv2lShtWCVk0qMWlU7oHh9J/cIC0eC3Voq
	 csTEElcfNt/dnvBIymmztWXU0rCSnMfYC1RQQruI/dnE7iiidrQEjKdu87TUd+/ZSf
	 sm3T6DemNaXPeWKzA6umfHM8=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 68E8440E015D;
	Thu,  6 Mar 2025 16:19:19 +0000 (UTC)
Date: Thu, 6 Mar 2025 17:19:12 +0100
From: Borislav Petkov <bp@alien8.de>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, linux-kernel@vger.kernel.org,
	x86-ml <x86@kernel.org>
Subject: Re: request_irq() with local bh disabled
Message-ID: <20250306161912.GFZ8nLAAVKdlx0s4xv@fat_crate.local>
References: <20250306122413.GBZ8mT7Z61Tmgnh5Y9@fat_crate.local>
 <CANn89iJeHhGQaeRp01HP-KqA65aML+P5ppHjYT_oHSdXbcuzoQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANn89iJeHhGQaeRp01HP-KqA65aML+P5ppHjYT_oHSdXbcuzoQ@mail.gmail.com>

On Thu, Mar 06, 2025 at 02:45:16PM +0100, Eric Dumazet wrote:
> Hmmm.. not sure why local_bh is considered held..

Yeah, it looks like it is some crap in tip as current mainline is fine.

Lemme see what I can find there.

Thx and sorry for the noise.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

