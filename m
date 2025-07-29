Return-Path: <netdev+bounces-210713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5328B146FE
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 05:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2879654328C
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 03:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11B9B224AF2;
	Tue, 29 Jul 2025 03:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L4Yb2fUV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08642BD04
	for <netdev@vger.kernel.org>; Tue, 29 Jul 2025 03:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753761325; cv=none; b=SIBZpRMSeXlXTXwLK6JyEMz8LmGEod5p2zcZ056EEEoGxvmI+wlAXq3K6AmtlIMOAjdqI1RZDpvwgFemW0hOJWqwZyOIP10IIYf9XmK554sv1+juFWxhS228ajaZH6ouIehErcaJI0FYnjEj6Du5koeqnaruOhnSglW/vcogFS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753761325; c=relaxed/simple;
	bh=ikYbt7OY1tKAUeevm4XgbRmeViXmIZIulKWRY4Drtbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bsnaKWsmZ8x4uF+btiQl3VIEfc9yLVXvcTzCpB5/vBGZKEgtphfSrK6JWlDHJwWvzzKWKfsGGGXOJLW0QBfO3cNcZuOaIRSz0igkuga9sfBAn3ba9RmCQKhlXz9Wwim4fEwoueQl7OplwONFgTwW6OdEZS9DNy8g+IQhUM8ZcWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L4Yb2fUV; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-23aeac7d77aso47353475ad.3
        for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 20:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753761323; x=1754366123; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W+TmbsFNGGHDVYGGRijT7854DfHSaifYbdmQhv62n9g=;
        b=L4Yb2fUVc+tId62C5iOwLQYRoIvC8ABaYOOTPW9LkRH19uvHzTrYie4QUU4iBg4pAm
         SFbvtyGbchEaLzEVgONRIg5IOBj+zlVXJLtuo92bwu7Iiz2DB8G5cihEMQXZIUDov2wf
         aFm7WvAAAAMf1RGol9aFbcEg+zwHqCXeI05tFDZda3j836xi/E7PIZRxASw+xujHd6Np
         vR/Aynr6kvydE+HNM2dBKDuGLPa+zp5bWnRTHsIzpIIYwzu+xBobK3H0NjiWS6tDYCnp
         tRBg5SIBtZXmG4oBNH7vDEQ0B0NZ4/guRBDFM2z4QLLCNIdTTBYfNFnSK1ihTcMY7KC/
         lXqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753761323; x=1754366123;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+TmbsFNGGHDVYGGRijT7854DfHSaifYbdmQhv62n9g=;
        b=l45KD5MTKclmRPJ1/yD4EZlQ1itURTCVMLMCzH8SyDj0Yojjxu+hJKmuxrKhtDWX7/
         OeJ/9s+0rkQbY5uONwboP88BoovgighdYMHMeDxSL5ucGo7XZRGpraznot1lnJ071b40
         WxVls+rOLM6J4k79z0cnapUJ8OMhzHRCv5nnEFrNCukT3iWyS7ftUEmyNy3zF4z90tRm
         RdmrlwE09x+SU45VBOkkxn8LS0AB/dHxT/r8hf2CCj/pdLHIP4cksqAUxq4y2PNFiL6v
         iApR90g++GkkHsHub6Gi2mpP7ZoE+NCbleU1Y3sTkmBpxWPUkzSl6a7h22lx6337R+Lb
         iRvg==
X-Forwarded-Encrypted: i=1; AJvYcCUp05Eb1jRLsTotO5IARtQCyLgsBQj2AiuDhn8e9oncvvSxMCfWDiitH6ftMwXiirEXDcaQg0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK0uqOxjotyGiX/LsIVcrcLbpm8FDhdwnV4ETN3Am2SDtUexmk
	PH8pzd18CQDnx17GeDbPL0wewlZssnr72Hynj+Gvshce5ciImfir/JbR
X-Gm-Gg: ASbGncuYQtlEY78dJ4cGS642vRdUzNP4grSmrbXbPkLhhCTkAfy1GnDZ0l2npjWYW2m
	N7Vqh/a2JuodbpwURqv7dJxHJYFeFKuzcID/5nDZpM4NhK/hHi6VVTN8NfNmIvfYju7DxQpIHxy
	127R/vgI9eF3gUXc1p9dEFO1wEOTI+gISDDafUSaM5pFk+ab2UhWcUGA6J3labAoampbTC07zDB
	UNu+2GYxMrbPWPpf74XqFKmeM13nP7r7sLCi8uIaGAtAIs+SmmFtMF6sdkfgxdDbT1ydJbKDkAE
	vrN+IEJ9kOoUhz7+cKOW+fL6Qey4TydhwqN5Mdnf3KZVPKW1/B+HyPZsXRtGfS2CHlvZvlfX3z/
	9J7mWHDX3SHoZnVE0alu32tYWS+PzgNu0qJxA5Uw6Tw==
X-Google-Smtp-Source: AGHT+IElQYI7Nhf7awNFrbm8HWFk/DbdG+Ua6xZB831QhjSV+TInxreA3zndu2AXkdhDxftjlYfcYg==
X-Received: by 2002:a17:903:2a8d:b0:234:cf24:3be8 with SMTP id d9443c01a7336-23fb312693emr210809785ad.28.1753761322739;
        Mon, 28 Jul 2025 20:55:22 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fc5a9d25bsm62023365ad.83.2025.07.28.20.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 20:55:22 -0700 (PDT)
Date: Mon, 28 Jul 2025 20:55:19 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: David Arinzon <darinzon@amazon.com>, David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"Woodhouse, David" <dwmw@amazon.com>, Andrew Lunn <andrew@lunn.ch>,
	Miroslav Lichvar <mlichvar@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, netdev@vger.kernel.org,
	"Machulsky, Zorik" <zorik@amazon.com>,
	"Matushevsky, Alexander" <matua@amazon.com>,
	Saeed Bshara <saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>,
	"Liguori, Anthony" <aliguori@amazon.com>,
	"Bshara, Nafea" <nafea@amazon.com>,
	"Schmeilin, Evgeny" <evgenys@amazon.com>,
	"Belgazal, Netanel" <netanel@amazon.com>,
	"Saidi, Ali" <alisaidi@amazon.com>,
	"Herrenschmidt, Benjamin" <benh@amazon.com>,
	"Kiyanovski, Arthur" <akiyano@amazon.com>,
	"Dagan, Noam" <ndagan@amazon.com>,
	"Bernstein, Amit" <amitbern@amazon.com>,
	"Ostrovsky, Evgeny" <evostrov@amazon.com>,
	"Tabachnik, Ofir" <ofirt@amazon.com>,
	Julien Ridoux <ridouxj@amazon.com>,
	Josh Levinson <joshlev@amazon.com>
Subject: Re: [RFC PATCH net-next] ptp: Introduce
 PTP_SYS_OFFSET_EXTENDED_TRUSTED ioctl
Message-ID: <aIhGJ9BzR1wY7ij_@hoboy.vegasvil.org>
References: <20250724115657.150-1-darinzon@amazon.com>
 <aIMDc8JC4prOmpLQ@hoboy.vegasvil.org>
 <3f722a52642dc42ad8d5e23ab06c14050d7bf8a6.camel@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f722a52642dc42ad8d5e23ab06c14050d7bf8a6.camel@infradead.org>

On Fri, Jul 25, 2025 at 11:25:24AM +0200, David Woodhouse wrote:
> The vmclock enlightenment also exposes the same information.
> 
> David, your RFC should probably have included that implementation
> shouldn't it? 

Yes, a patch series with the new ioctl and two drivers that implement
it would be more compelling.

Thanks,
Richard



