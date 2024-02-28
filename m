Return-Path: <netdev+bounces-75701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBB586AF36
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 13:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45980B20C0A
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 12:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 999D7605B5;
	Wed, 28 Feb 2024 12:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="y8pfl1AJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FFB208C5
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 12:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709123519; cv=none; b=SJQQS3IyvoTn+jTOhv20BOJ4rX8+fkesQHjQujB/rMk1Anp8RgIm9ezqpKVWNUOf8Wr6vSAqlJM05ND7bALWhRILJDkkucpbwHUimtGYhJso0Xu/z6toemEt6cv8c5JRNBDNugOwI4nfmjEeRo5G3lSywR7sZA1fHuxa0kFYLsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709123519; c=relaxed/simple;
	bh=P2lYtDQA0lj35HQ+5dlE8Zqnu3Tn2q5PM+YJkHO82dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MsuPKzYhxLngap2llmNybLSGGRQSOUWscq4g2rr7g+lF31fgk/V67hyR/4+bEP2Uz1Seu2ma8cGy3Enc9jn22JQrvQM5susPbEKGBTHDLNf2NNbeZtmQT/R0cQeHfMVQFqD6BYaIQ299/GCKrZlh1ePn041GqXjWpL9ieEEMYs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=y8pfl1AJ; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33dcd8dec88so2311969f8f.1
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 04:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1709123516; x=1709728316; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P2lYtDQA0lj35HQ+5dlE8Zqnu3Tn2q5PM+YJkHO82dw=;
        b=y8pfl1AJTf0ZJtvH9XYdButWe3CMGsHXbp8ESxD7PhhYtLXJYj1LKHDeqGG2b3Uu7t
         2V+Y9dGs3wHMAFsfhVx7LFfhDvZRC6wlWS2esavvMAoUCiorw6VqWotXvslnUPkeRepR
         qBCY4jgiWecfM4krJ/eTcW6LXb7etF8VgVwllMBiPhv1WUcujP59Ulw/4CuP6PWVkEZW
         gKSEzRN3YSmDVIDd46IyTaHCV7Vbvph/Q5iDdGhRVp+U/Ygwo1brnOe3OCezFUouUrm5
         Kp5vtQ68dYxDESgcg3UhqPlCLrGxWHyat4q+QFNDmdvfsfibAdXXmzZxuUhqJGeU/6ps
         8Kgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709123516; x=1709728316;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P2lYtDQA0lj35HQ+5dlE8Zqnu3Tn2q5PM+YJkHO82dw=;
        b=w2yj8Ruu6+9cGO0fMHfk7wgnxOZtfgTLFe91d6DttXD2eC9SmUTWvHNPVvoLM+o2Mu
         duY/NFaWo9qhRKr2WnMcaAK05cn60RPEaKqt8S6W17CPXdRYuPCHA5o0xruwhETlXNEH
         3bY0DB+njVN0j45wYbHRYgMMNTua8QbzqP2mOAtfcfU/WnYwmxcfHKQHDF3zd7UDKM9N
         XWOFUiRq4FJIlR9ergTdAbL4LWP3o5SG4BSQdKiGaQdULSpErABC23soLQG0o8GCMdjV
         kKDHzALB2iq5P4OjNW5rA+WJm3NHDFTarUDsMTwQVmttp9gFpILpiWXGYjX6L9Yw4MrQ
         Ob0A==
X-Forwarded-Encrypted: i=1; AJvYcCVJWD6cpGSfXasfQn3WQ7EgIU1i+npddch3z33J9EAGUxwsiCWXulOEnb1h33WDqAHZG8oqrpna07jaIUwdVZLEPxxF0TkM
X-Gm-Message-State: AOJu0YwaIbjwaneoU84zg50irXmpdMNAXjzNHWrEow0E7bK5mGXspze8
	nqeoiV1AiKOK+TQ3Ln6TfAdfJDYrf78mT32cotJgMlWo7LSvs7hxO2/Gd6k9tzM=
X-Google-Smtp-Source: AGHT+IGbPRYXLZbIf/wYxiWdj7CiBE+y0JldKdFOg9+Q0dAspiLsouWPg9onelMeAKThwS0vl+z9aQ==
X-Received: by 2002:adf:e682:0:b0:33d:3be4:6c75 with SMTP id r2-20020adfe682000000b0033d3be46c75mr9591693wrm.71.1709123516139;
        Wed, 28 Feb 2024 04:31:56 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id w4-20020a5d4044000000b0033b7ce8b496sm14247816wrp.108.2024.02.28.04.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 04:31:55 -0800 (PST)
Date: Wed, 28 Feb 2024 13:31:52 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Lukasz Majewski <lukma@denx.de>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Tristram.Ha@microchip.com,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH v2] net: hsr: Use correct offset for HSR TLV values in
 supervisory HSR frames
Message-ID: <Zd8nuLjDxLKPgX-W@nanopsycho>
References: <20240228085644.3618044-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240228085644.3618044-1-lukma@denx.de>

Wed, Feb 28, 2024 at 09:56:44AM CET, lukma@denx.de wrote:
>Current HSR implementation uses following supervisory frame (even for
>HSRv1 the HSR tag is not is not present):
>
>00000000: 01 15 4e 00 01 2d XX YY ZZ 94 77 10 88 fb 00 01
>00000010: 7e 1c 17 06 XX YY ZZ 94 77 10 1e 06 XX YY ZZ 94
>00000020: 77 10 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>00000030: 00 00 00 00 00 00 00 00 00 00 00 00
>
>The current code adds extra two bytes (i.e. sizeof(struct hsr_sup_tlv))
>when offset for skb_pull() is calculated.
>This is wrong, as both 'struct hsrv1_ethhdr_sp' and 'hsrv0_ethhdr_sp'
>already have 'struct hsr_sup_tag' defined in them, so there is no need
>for adding extra two bytes.
>
>This code was working correctly as with no RedBox support, the check for
>HSR_TLV_EOT (0x00) was off by two bytes, which were corresponding to
>zeroed padded bytes for minimal packet size.
>
>Fixes: eafaa88b3eb7 ("net: hsr: Add support for redbox supervision frames")
>

And yet the extra empty line is still here :/


>Signed-off-by: Lukasz Majewski <lukma@denx.de>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

