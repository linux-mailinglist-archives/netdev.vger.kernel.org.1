Return-Path: <netdev+bounces-142261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 660D49BE10C
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 09:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BA64282B61
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 08:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3C31D358F;
	Wed,  6 Nov 2024 08:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="q9lffgI1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B2238F82
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 08:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730882109; cv=none; b=BDC2vkBQa8ejwMflRFKzkp6PlT5sNfEUlcI+7MSzurUGCwJg7I2brgX6rUrT1fDSPva8d4FJ22fn7hqLLOVJz6WFMuY9WDUX5WvYExjuHhXiMMrEpSmJJeK7HboShUD+FhBzVarWYhxYfRiTBzjLdPtaaB/oNWmVA2HNhqmkh5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730882109; c=relaxed/simple;
	bh=e4d0J1mON+nner407B/cwkTDyHgK6lc1uIuucXRrqT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l7BgOFQC21tPNs3ExQoGJBUHJRcbrBla2n5ijf0dB+JFD/iqnes3xk3PrO0bluU9fOx8RSQko/WrlWRzK0YCSEj8fxZxswxbHwr14RJ/QM5ahGUjcrcqDCP1eSqMyAUMH3jwTPIJtp4gQZZrhjBKOQrID8SnFFtwKoTq5/Iojg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=q9lffgI1; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9eaaab29bcso419631766b.2
        for <netdev@vger.kernel.org>; Wed, 06 Nov 2024 00:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1730882104; x=1731486904; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e4d0J1mON+nner407B/cwkTDyHgK6lc1uIuucXRrqT8=;
        b=q9lffgI1Z9QPsvTwRzlF6BXYBjzbepACUq36+AURSSp7MGgVPvS68yk2ZKtQ0AtkiW
         6dzFc7q0ftS2EsnVFAP9cQvOYjd/myy1519m67HdtGfa3b/HZFJR9D65pLQ36dYEtzvJ
         RvUnfDyVouPAOzraSRxgIJxd53FvJCtwTq4iNo1hMeP2iTcfGuf20UvCxZNbSyOrQG7t
         MzvfLPBRWezjzZjp8BtV5D2/V9CskvYvt7q/QkEFI5IGInsGdIH67aBWETZVYJLlve/e
         O6aV20Gfhvp+4k+2MCKVTMBuvbJcoEI1geA8+uzI005oG5v4WNXknNIiOJZvJPr30vTY
         ZnWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730882104; x=1731486904;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e4d0J1mON+nner407B/cwkTDyHgK6lc1uIuucXRrqT8=;
        b=C2GP9S+geSU8BcuHajLVgDxrLUhtXkXbIznwubjtOOM/dhjiNHoufBLnxlYbhWIbbG
         e0kXY9jFlENdPjCyxE8DRLzaKJaRXI+PRkRwL+/WPXsmSjT5a1VzVCEybb1XeczEvqHF
         ziwJamw0MPAQfsq31QLdjCQww5qMsEi4su47OngbpAPgbN/zFDl7E5aDi3by0RnaaDTv
         gQUTQli5R+oOUJmS/z25Ab1L2INeEqhyHTQHa08iEkO1X8PuLJ5wEAvpgW0Aarr0SvjL
         ACNETtPK/J4SyTHr6p99jxGq4n8rrytnSZPBQH/aFMMoypcApj9IBXqZthgWuy0DOGJy
         Q6vQ==
X-Forwarded-Encrypted: i=1; AJvYcCULN5X4eU2w88j2D4H72eJ6MSMYTx8gQy+mpQoqzK/7aioZvD8lloMkOVgHI2BTxnDf5L/wPuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrF05y1dSc9UTPGGN9w95b0WaIMcMsS+y0+GTvKFotAu5noIIP
	+q8CgLAmyg2pgPw+k1Dn5QM4vPyp0c9IqxgIzz2TBKpGTjEQqVQrv+lw7yfNn9l3ujqF2SSFEkF
	I
X-Google-Smtp-Source: AGHT+IFTUZQaAcwJvlvgaKXWEFp9EXf7FD1qecYtXRjGDo8UW4IcikhnGzNSM8+vU54fWa75fAPAKw==
X-Received: by 2002:a17:907:7e8f:b0:a9a:183a:b84e with SMTP id a640c23a62f3a-a9e50b928acmr2219634166b.40.1730882103611;
        Wed, 06 Nov 2024 00:35:03 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb16a10cfsm244206766b.9.2024.11.06.00.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 00:35:03 -0800 (PST)
Date: Wed, 6 Nov 2024 09:34:59 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: Jay Vosburgh <jv@jvosburgh.net>, netdev@vger.kernel.org
Subject: Re: [Question]: should we consider arp missed max during
 bond_ab_arp_probe()?
Message-ID: <ZysqM_T8f5qDetmk@nanopsycho.orion>
References: <ZysdRHul2pWy44Rh@fedora>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZysdRHul2pWy44Rh@fedora>

Wed, Nov 06, 2024 at 08:39:48AM CET, liuhangbin@gmail.com wrote:
>Hi Jay,
>
>Our QE reported that, when there is no active slave during
>bond_ab_arp_probe(), the slaves send the arp probe message one by one. This
>will flap the switch's mac table quickly, sometimes even make the switch stop
>learning mac address. So should we consider the arp missed max during
>bond_ab_arp_probe()? i.e. each slave has more chances to send probe messages
>before switch to another slave. What do you think?

Out of curiosity, is anyone still using AB mode in real life? And if
yes, any idea why exacly?


>
>Thanks
>Hangbin
>

