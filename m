Return-Path: <netdev+bounces-180500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C3CA818D0
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 00:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6C9D3AE712
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 22:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9762D24418F;
	Tue,  8 Apr 2025 22:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PedIoj3d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66A319580B;
	Tue,  8 Apr 2025 22:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744151714; cv=none; b=ddVJnkY8zzis4YaNKs/fWzoJwzappxFaChn/V71ZujoKgh8ZnW/2wtBJ7eYkiTnMipNfXOiGrCdvdwWapGsouOsRNyyxS1oWfadLCc+sDbN52VxETKC15ByyP8omKf6WIa3p2ZOBiDUjSIyz4kKprBRw+v645JfiNOanV1T82Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744151714; c=relaxed/simple;
	bh=p3pVpx/VwMqHuZmzIgDl1OhltWkd9hOvOIWcHNtVOo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qJNR9gXzrqZurKLmTVffcTlkkK3znGkFYIN29Fhjf39TnRmmniWJNyvA6iuzKaA0Pr+uCfWM66HZEaggWbZ+bhizbxG3zmP8xvJk8ubFFN4Ar5l27kz3TPe2oBpY5KGRswub186erEhcmkH2aq4Y8a8/2tMSOfkiGsyHusz0Z4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PedIoj3d; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-54afb5fcebaso6801415e87.3;
        Tue, 08 Apr 2025 15:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744151711; x=1744756511; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mlD2KqrfnMmFYhmlW5RFHJBshe8wyA1SZAy/tY6ywgY=;
        b=PedIoj3dwUryovcOPRLPfrdBlgxhS9dCmB6Zok8Fe2ujqK7GfCMgvOscz1cABS+0E4
         ZzBwy19XkNF62TWfxKXo5mTVYWa+pl5M+UxsiqZDho9yoLOqclnkIaHchUEe4gq42YUS
         mxI0wgtK+72XdkxArrahO8zy7m79vW36+WlYbQsGHwuPOmAULXAK48I6duyf7JpM2cKk
         lhXxb2dy0aR5abfxODMIGLJUpgDOCG0kLIIv49C60VBiCkBCWkcqz+aO/8KGfCRUww6h
         dcw0WpX7ja8m7Sd4pi58nhrj0hVjwvkY/npUQjeCNhG6cupLbt01S/IEctWi0Q/yxguH
         g1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744151711; x=1744756511;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mlD2KqrfnMmFYhmlW5RFHJBshe8wyA1SZAy/tY6ywgY=;
        b=MTg7LHailPT7RDyX9DczwhA1MoScvUE6sdgmVONZDCfxd6NMzvtYRKiCg55D35ZLA8
         eyF7uBot1HvLHbwgAGFT7RoAKE4GzjfETZ5bCdZtya1COwI3j7RGKt4MyISuoHjBA2tb
         2zAmMT5Ny7XYVZCfSGZhS6oG5IygbkmAt2mGG2lIlvys1nh76OQ/tuYRE36dk21uHQWz
         Di1NF+Vh8NLcTTHwXTY6d0zdkdyTBI6bdNeIz8a0XsnlR/lH4TBPxXgY0QHtN6druHo6
         4sW6OWts2CkaujR9SXLVwL358GfDUopDDnwLbQqMpu5LkiUENWnITWOsY8SOXN4yxbvs
         pq7g==
X-Forwarded-Encrypted: i=1; AJvYcCU3Lc8yfEpeHYyR1/e6gcR0aluZGEPQ+EDSUl2xAQAGybVPjopQKZAczAZUU+KgIDuZEA8tSaYA@vger.kernel.org, AJvYcCVhdDDcl05WqW77CsU5yeDL2hW3DI6YZ3cjAIdp/wlqcsytIuqRxy9VZOFbAy6t28csmdoYwRbCeGvYyNM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMG6GCTL95omye/OHIrthVeMYamXPn7pQGt4yS0Ew/kgPV7CNd
	U2jzSCwtxQRPhvrWVq9pAeaKhZrdavTIEhJHuPUhbyuYC1CtuQu4
X-Gm-Gg: ASbGncuDfGAPkJwdQOut6BjXdIuNtsRiyKiSJXW511WfpaeMJVt949jR6qMlyUcD07K
	zSEGEDgSdNbw2aA/6LviiaVzgFGZNkvpQoEPp8Vc4xj8RJDu+r3NX3n8vV96T6peDR/drOpgI3l
	HlRZVkZW1Igc5NUAHMgyqSIwcevGr6i8aLcZn6qrtiDgcn9x8BF8cXc9HgkcSjPQHcL7A9Sa8Zr
	7BmokbXDXzqnSCXoVqk0IW9qrAWEx67Ifxou2xP+8ThUONbNePSsT1btIEMZm7tn9kdwjP9i+Oe
	gXcf41os7uy1nrEU0vc9nq5N2yTYMsAOFDORhczw/GABR/MBQ4WvIpA/r3A=
X-Google-Smtp-Source: AGHT+IFezkMToIsvrqEXJ3FIwrq2zr1M8hDZTVQjVxKua0cX47u4u44qQalqMF6pZmfqsQ9paKwjcA==
X-Received: by 2002:a05:6512:1318:b0:545:2c2c:5802 with SMTP id 2adb3069b0e04-54c437c9468mr149090e87.48.1744151710605;
        Tue, 08 Apr 2025 15:35:10 -0700 (PDT)
Received: from home.paul.comp (paulfertser.info. [2001:470:26:54b:226:9eff:fe70:80c2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54c1e5ab48bsm1673159e87.33.2025.04.08.15.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 15:35:10 -0700 (PDT)
Received: from home.paul.comp (home.paul.comp [IPv6:0:0:0:0:0:0:0:1])
	by home.paul.comp (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTP id 538MZ6Zq026177;
	Wed, 9 Apr 2025 01:35:07 +0300
Received: (from paul@localhost)
	by home.paul.comp (8.15.2/8.15.2/Submit) id 538MZ5ZY026176;
	Wed, 9 Apr 2025 01:35:05 +0300
Date: Wed, 9 Apr 2025 01:35:04 +0300
From: Paul Fertser <fercerpav@gmail.com>
To: Hari Kalavakunta <kalavakunta.hari.prasad@gmail.com>
Cc: Sam Mendoza-Jonas <sam@mendozajonas.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        npeacock@meta.com, akozlov@meta.com
Subject: Re: [PATCH net-next 0/2] GCPS Spec Compliance Patch Set
Message-ID: <Z/WkmPcCJ0e2go97@home.paul.comp>
References: <cover.1744048182.git.kalavakunta.hari.prasad@gmail.com>
 <ee5feee4-e74a-4dc6-ad8e-42cf9c81cb3c@mendozajonas.com>
 <b1abcf84-e187-468f-a05e-e634e825210c@gmail.com>
 <Z/VqQVGI6oP5oEzB@home.paul.comp>
 <1d570fb8-1da0-4aa6-99f5-052adf559091@gmail.com>
 <Z/V2pCKe8N6Uxa0O@home.paul.comp>
 <b1d373d7-77e5-4341-a685-07a617935db5@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1d373d7-77e5-4341-a685-07a617935db5@gmail.com>

On Tue, Apr 08, 2025 at 03:02:14PM -0700, Hari Kalavakunta wrote:
> On 4/8/2025 12:19 PM, Paul Fertser wrote:
> 
> > In other words, you're testing your code only with simulated data so
> > there's no way to guarantee it's going to work on any real life
> > hardware (as we know hardware doesn't always exactly match the specs)?
> > That's unsettling. Please do mention it in the commit log, it's an
> > essential point. Better yet, consider going a bit off-centre after the
> > regular verification and do a control run on real hardware.
> > 
> > After all, that's what the code is for so if it all possible it's
> > better to know if it does the actual job before merging (to avoid
> > noise from follow-up patches like yours which fix something that never
> > worked because it was never tested).
> 
> I would like to request a week's time to integrate a real hardware
> interface, which will enable me to test and demonstrate end-to-end results.
> This will also allow me to identify and address any additional issues that
> may arise during the testing process. Thank you for the feedback.

Thank you for doing the right thing! Looking forward to your updated
patch (please do not forget to consider __be64 for the fields).

