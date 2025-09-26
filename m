Return-Path: <netdev+bounces-226660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65E03BA3BA1
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 14:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20AEA6237C4
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 12:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D6D2EC0AB;
	Fri, 26 Sep 2025 12:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gscfe2+X"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2192D6E5C
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 12:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758891494; cv=none; b=HAvGaD7gflAkOAuSC18KQ8WbKj/N36yED0mKQmymTjXGQyCEuy52n8zbUc8COAB/T4BjxSct5+GIpTSWct0dxFVue9sx70KpxAKblC2PoXLHMDWM5vGa+bCIqxVqUAUaxNdnFk+HU5Ic5ZhQoDZTBOb9h+oNrdNbSaQxaUv8xYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758891494; c=relaxed/simple;
	bh=9aoozeymCtilt+qkHUzPEFhKKMah5TAuvXJod7umpVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IpNy6NpQSjUB355tgboZVDCqO3+9Kodg5b0XY1PZvRWvJsqGM0p74i5oDH2wfUuMEQRd1to9UAcjmoA8/3h12ht/qCd0tE9vgm8TZHkhpOjTHRzbPueyoBaRurEAaekfbG4hmDUot/ePEiHLjlUrJk3ClfFYW+gZZ/3nPmX/FGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gscfe2+X; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-71d71bcac45so20803907b3.0
        for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 05:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758891492; x=1759496292; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3+s3+W287EF3WpdqRLN76J6wag+8qKpJsyHBGGlUi1g=;
        b=gscfe2+XBCM7xT6mTvQGtus2atdlgYyTujEw3HJjNn3mR3wOKmbM1EmnJ8WsPl8Jtf
         4I8dVgCGEoXIWn2VKFpjWSxUfK8r0NHrWdlgf43Uz22OnlZ590zeg24dSQh4X+6A2kC+
         M8mfgqa6hJ9+WUltj696cnJ7rcJruBk+2FYvrQywL/b1JbH17xnCEsmZK7s7jvunQ9TL
         IchRVAOQMiGhlF4+PVeozBdpeIajMk5i27Gm1YJCUQt+3GKg0/2j6ZIG6z1TUY66dDkK
         wi95ee0R/tW1t/r1VhsNvvG1vndVCKfCFUepRaa8VY5mF266c1ouEJMbKl7+bG45u1dC
         zbMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758891492; x=1759496292;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3+s3+W287EF3WpdqRLN76J6wag+8qKpJsyHBGGlUi1g=;
        b=rMVaMpKVqpd86Oc3JIJEpdK+nIAcPtdWn+cm5ESdhdR7tJZPCUxexoWMaNX11Z6C/n
         o/k9tcsSLYlGwzzGRxbCFRAUhijFmP1ueJdGdstYCbCkvpGlqlMlCIOxTCotaiD5TEkY
         ovQFmn3AcHH3TdMoBZXcN1Kk6IYri65x2wUrc1XADPwqMMY7avC4Z0sCKMyJOZdPQzHs
         8B2ozQtn9tqTO0ZF8ftZzDiKrHwpiFYxY3m0OxUqfXd2YS5f2EvtdRQmkkomLQyRkHlc
         5U70oY+iiElPMSlAB1JokANVQTuOAbdvQ9utg31a9NDNZRYHtJyA51g9YD0y7m4zxMbJ
         vycg==
X-Forwarded-Encrypted: i=1; AJvYcCVjpx7ta0/p9VgNfzka+T95yBQpoG/PUed8+HGKkmoju7zFK6TlyjZjqcxIqc/2iuGDvqWZxpA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1xUA2JM0Kifxwg1BEptgAZbim2pVn2zFTTWeSHoiWfNCtmj4E
	NiQujSs1fQ30FP+kn1DChqkb6ZR+GYEHRmmNX26ghvTdVNMumj0kAPAc
X-Gm-Gg: ASbGnctVSL7RMG1UGTEblgcuA+qRLBNID3fWBIKuOG5YJ0eT0ZyjVbIL45GD6HPzNxg
	r7JuQIhzY7anizSIqtnVwqOBn5xrw2q6WpVV0MrTrS53lQ5HnV5iqNUq0zzf67WkGk38QE3wfV2
	5e/HqQNF/VdBQrg49mR6ueP2CB9FJVqjNBntcCqT5zWgX8IMfMkdU5HomeSGYSrQl894o1XB/w+
	jGG+MkAWA1ZS+wq3zhn7Rxchp+6t5TRZQBw0AYkUbm/3e4/PAXUOcWuanT8+8T0z8AjR94CCN+p
	lvfnVBUvYqyx/c3d7VHI3jXyplej26LwUiiQMIzyo/+Z8p6qk9O+U4smB65kYyO0bUglLKEoMpP
	WeHMzEiH9adZvvcUWZj0640UudC0KiQ0XcN8c19tdBQ==
X-Google-Smtp-Source: AGHT+IGLIvAM19ntk8+Lddvjl2AdkR8Dpz1fEGG8f6oAy2PmwyG5FhSovK+XEHlRkEKZ9R+AN8qtiw==
X-Received: by 2002:a0d:d081:0:b0:74f:5366:86ba with SMTP id 00721157ae682-763fa430ad4mr57737817b3.12.1758891491815;
        Fri, 26 Sep 2025 05:58:11 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-765bd407b84sm10951587b3.21.2025.09.26.05.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 05:58:11 -0700 (PDT)
Date: Fri, 26 Sep 2025 05:58:08 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: I Viswanath <viswanathiyyappan@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev, david.hunter.linux@gmail.com,
	syzbot+94d20db923b9f51be0df@syzkaller.appspotmail.com
Subject: Re: [PATCH net v3] ptp: Add a upper bound on max_vclocks
Message-ID: <aNaN4DtuP0QJZVus@hoboy.vegasvil.org>
References: <20250925155908.5034-1-viswanathiyyappan@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250925155908.5034-1-viswanathiyyappan@gmail.com>

On Thu, Sep 25, 2025 at 09:29:08PM +0530, I Viswanath wrote:
> syzbot reported WARNING in max_vclocks_store.
> 
> This occurs when the argument max is too large for kcalloc to handle.
> 
> Extend the guard to guard against values that are too large for
> kcalloc
> 
> Reported-by: syzbot+94d20db923b9f51be0df@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=94d20db923b9f51be0df
> Tested-by: syzbot+94d20db923b9f51be0df@syzkaller.appspotmail.com
> Fixes: 73f37068d540 ("ptp: support ptp physical/virtual clocks conversion")
> Signed-off-by: I Viswanath <viswanathiyyappan@gmail.com>

Acked-by: Richard Cochran <richardcochran@gmail.com>

