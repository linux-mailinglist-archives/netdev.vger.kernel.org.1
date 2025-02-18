Return-Path: <netdev+bounces-167476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7CD5A3A732
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 20:17:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2A9E17602F
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 19:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EAF31E8339;
	Tue, 18 Feb 2025 19:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="apNO0xT7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BFE1E51F8;
	Tue, 18 Feb 2025 19:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739905972; cv=none; b=i1nCF5DMW5aKhNtVfEv1aphdfIRdqNWbqu40IGNasMNJglGOv4BaqGUCBBe1qhJJr85OGi3FbCpGP5/iy1G5ZZrpiMyVKS8KFw6LFQA3BM1QLMw/5Wf25wtmI9+E2S8DtVP8SzEAUHatUOtnK2YeTUMkJhqqRa4UHAtatq46ykk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739905972; c=relaxed/simple;
	bh=WoUKh5c/vDRm4FlNeCNrkzPuHxYE4Y4scX3UMvAd5O4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fioGpGPolYM914iknbFRtJ0u9gqlEC6SD3us8tx6TlqUat4gL0F90Jl2Ui6HB9GydmhxODILHEYPDFLSvwG8T+l0a7R1hin9pnunamFZrdQ9Nr2p+rDVwmsaSKVP0U211btmWssZKVO8iITXyOGl1iCXNbQ8GqHEv4CinIG7gPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=apNO0xT7; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3f40ad1574fso512515b6e.0;
        Tue, 18 Feb 2025 11:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739905970; x=1740510770; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oF3IZ5dNlMyYD63Wzfa4O0wknfeiB+PfksPMCxVRCig=;
        b=apNO0xT7oS8blITVvU5AA+T6WNsY+6TwmxVVmJRMLlKjITvOGyzXNV7ZnRjY12n/8b
         sMJWFNdPaNXVlPzMZWB6U5F6Opyl+gZQHTxSTo/Fgrowe/jPQdueQ7NR1ifl1z9Zxzjk
         hFCO8ojfy8FxDfiZWnE9IQoZeQ6d1YVf2Dls+BvEQLWtLrJ/QTxs/NZpG7TcT+/H90Qu
         ZYKB92vz5Kbdwue+BNKAu5MSL8qEwx09PWD0vtsDFjWdA0XYRw9KEBnMTVZSYNQF4WVX
         CnU1a+3ASEdd+J+GWhNrWVSEB2s8GZUXx0uwnBtvECB/caEGaKRxMnVP3WKF3TM0MnMw
         WIGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739905970; x=1740510770;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oF3IZ5dNlMyYD63Wzfa4O0wknfeiB+PfksPMCxVRCig=;
        b=kw47hKfXSdmyC37aW96kZ5iqrwRJkY8gBsp4+1MPc2H5ov6jKtx/zhmh4Iw91DCF9v
         JJsID0Tl7uqW17LGwQxIKDYfWvjyJSSuSq/2G1MbQcvvAie+ik70PLDTscOAKl717oDH
         fzujy0RAa68bU4Au3YfU6w6OLDMdiVY/UssXDKWaPK+xCbe5DXZpxD+z0yNCSyjCStWv
         65CqgyZUN+1xnV+2h085IfFzQkfFnjBnD+/J2PaT5/5O63FPmZOQUH0UEQY9l3CDhfNY
         qZFcT5W2ytGaurNVwCA+42UCfzBibjnVWz/ixnTL6h1OwJaVSYPJlASVAwACPATIheMw
         s8yw==
X-Forwarded-Encrypted: i=1; AJvYcCVTKu8iA+qY5X1X6M2J9L6SEwWwhC429l/9D0Y9NsszCEXu527ToCd6lr7RgxORdZTVIKOPMRVHPwF/vYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiBwb81mg7OYyYtQR+77/HGgaABTeiS5pzXuMxM3w9QHoptY38
	H/5JTOWrRWSCdvadf2SVVfMBlqOGufqcXU1Z98ioAn8NWxi/IHKw1ARmM9QwzSzLiVvpU2GDws6
	Ob+60ohipHazBWnCFFrFNsK1RBk0=
X-Gm-Gg: ASbGncsjiVtgW8YqwVTOyf5N3JSGDOT8wAPs1o7H3QD0kfz9VsSRz0yQ8Zu3WkE3tFS
	aWFYWLntHcUoOsN37aUVl32zn4usUzfOH2ztjUdr3DWvI10uCFTCHvr3SPIJp+inGrHhWf6XYmM
	G73ok/iI0BTNiKpA==
X-Google-Smtp-Source: AGHT+IFb4knJMi3AOcDr6zaVeojXvLaFJxcBcDyvpUv4oVbjmkI7Mm6ZZOndeOhxjCi1+zyZXOxXG+rYjRuy9gA1yt0=
X-Received: by 2002:a05:6808:181e:b0:3f3:d742:c2bd with SMTP id
 5614622812f47-3f40f1e5799mr776743b6e.13.1739905969652; Tue, 18 Feb 2025
 11:12:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218165923.20740-1-suchitkarunakaran@gmail.com> <d194435e-88bf-49f6-bb6f-b52f77248965@kernel.org>
In-Reply-To: <d194435e-88bf-49f6-bb6f-b52f77248965@kernel.org>
From: Suchit K <suchitkarunakaran@gmail.com>
Date: Wed, 19 Feb 2025 00:42:38 +0530
X-Gm-Features: AWEUYZkoRmcxpgXd1SyCu20aEGPfydJydoqEvXvTkpjbLGDJXP09KIF_zfs0pMk
Message-ID: <CAO9wTFhVx9nCPyMzHKCTnuBfrTmvA2QADg8La0z6KcYWpsxnEg@mail.gmail.com>
Subject: Re: [PATCH REPOST] selftests: net: Fix minor typos in MPTCP and psock tests
To: Matthieu Baerts <matttbe@kernel.org>
Cc: netdev@vger.kernel.org, kuba@kernel.org, horms@kernel.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thanks for the feedback!

On Wed, 19 Feb 2025 at 00:12, Matthieu Baerts <matttbe@kernel.org> wrote:
>
> Hi Suchit,
>
> On 18/02/2025 17:59, Suchit K wrote:
> > From: Suchit <suchitkarunakaran@gmail.com>
> >
> > Fixes minor spelling errors:
> > - `simult_flows.sh`: "al testcases" -> "all testcases"
> > - `psock_tpacket.c`: "accross" -> "across"
>
> Thank you, the patch is no longer corrupted.
>
> Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
>
> This patch can be directly applied in net-next.
>
> Note: please next time don't repost your patches within one 24h period,
> and use the [PATCH net-next] prefix, see:
>
>   https://docs.kernel.org/process/maintainer-netdev.html
>
> Cheers,
> Matt
> --
> Sponsored by the NGI0 Core fund.
>

