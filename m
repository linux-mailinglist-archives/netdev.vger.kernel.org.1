Return-Path: <netdev+bounces-63583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 505FB82E250
	for <lists+netdev@lfdr.de>; Mon, 15 Jan 2024 22:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60C441C21090
	for <lists+netdev@lfdr.de>; Mon, 15 Jan 2024 21:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB981B285;
	Mon, 15 Jan 2024 21:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H5/DfAp6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA1B1B277
	for <netdev@vger.kernel.org>; Mon, 15 Jan 2024 21:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-554fe147ddeso10280588a12.3
        for <netdev@vger.kernel.org>; Mon, 15 Jan 2024 13:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705355448; x=1705960248; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/uIObpjchilUIHpNR4hyBvNJP/PS78uC5dDzZVLMDs=;
        b=H5/DfAp6kdz1HH1U2j4Dp3u8pUjCZEVLzVgMQTlD7lqcio3bSUfBaRXrul77r+Vig5
         iBrbXhXCUM/OqG5r29tAQzqtd1DKdaPzZrcVYSX7N0piQEvRh6meaJvM96w3sYkkMzsG
         3FQoohJa8+PMXTMG0jk1WtkMa0UKkb3KSlE1fWmTLSOlsIA+C/XfRzTo4Hsc5ywarMCG
         exyYpTNNmRMBy5uc65sHVxxiZlKWTAtkJePQseiaSkArtNYFgxQjgHPzp7P0L7j95kCz
         DSDBczB4puGOdwFUxEO1RrA9l/4HtATflMWi8MCqxINZQYF8YpKmSqal9HN2DFu7IqIB
         oj+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705355448; x=1705960248;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q/uIObpjchilUIHpNR4hyBvNJP/PS78uC5dDzZVLMDs=;
        b=c6GP1uB+uhLbzgru0SNzmFAa5PNmkiPjbLNCZxVuigxEGs3BdZJtm3hlw8Wdw+YF/u
         S0qSXv1MVbnQ2aS6MWPHLbQYVHHEhDVztrU2S4fxwBfCES1ATdIJ4ZXHMFKinfUaSVLV
         WogvOfcRFkfLUt70rGlKIgziPerC31ilyO1uUKvGTJtSZCnupoqiD8iyXO83yPI8wBWE
         UQ5Il9tXLSoWyliJSe6Ss9tchGSwU+PNLkeoDbKOtJhGMRNPqhOkXXBAxqCI+pvcbFYz
         r0/KCyQasRitROWswucPSCJROBAR9Figosxw11V7QJ91rTL27kHXX0AsirGs1q2AGyj1
         w4CA==
X-Gm-Message-State: AOJu0YwbusdPbFTsLiydCUCV9T01BoL/U4HTllWY6pjJLZjCyUDtHCGo
	hgXXSwjI/Mhg7jfvAD8KSnw=
X-Google-Smtp-Source: AGHT+IFRnCsJtphB/tbdevOUsXY8sK/JEPVj5RnJrpR8iTm3FUGoVIj1X8GMqLqb6yHkYwEi8E3I3Q==
X-Received: by 2002:a05:6402:30b3:b0:559:2e58:889d with SMTP id df19-20020a05640230b300b005592e58889dmr639035edb.110.1705355448135;
        Mon, 15 Jan 2024 13:50:48 -0800 (PST)
Received: from skbuf ([188.25.255.36])
        by smtp.gmail.com with ESMTPSA id u23-20020a05640207d700b005573b375589sm5859915edy.96.2024.01.15.13.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 13:50:47 -0800 (PST)
Date: Mon, 15 Jan 2024 23:50:45 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org, alsi@bang-olufsen.dk,
	andrew@lunn.ch, f.fainelli@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	arinc.unal@arinc9.com
Subject: Re: [PATCH net-next v3 3/8] net: dsa: realtek: common realtek-dsa
 module
Message-ID: <20240115215045.gnm364kfsw3jbgoe@skbuf>
References: <20231223005253.17891-1-luizluca@gmail.com>
 <20231223005253.17891-4-luizluca@gmail.com>
 <20240111095125.vtsjpzyj5rrag3sq@skbuf>
 <CAJq09z7rba+7LCrFSYk5FjJSPvfSS0gocRCTPiy4v8V5BxfW+A@mail.gmail.com>
 <20240111200511.coe26yxqhcwiiy4y@skbuf>
 <CAJq09z7YKKgCKgc_EeMrHy7ZYrWPP3x9aB9xto3ap8qc3gTG=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJq09z7YKKgCKgc_EeMrHy7ZYrWPP3x9aB9xto3ap8qc3gTG=w@mail.gmail.com>

On Sat, Jan 13, 2024 at 06:38:39PM -0300, Luiz Angelo Daros de Luca wrote:
> I didn't like realtek_probe() either. It is too generic, although now
> in a specific name space.
> How about replacing all realtek_common with rtl83xx? I guess all
> rtl83xx chips are switch controllers, even though some of them have an
> embedded mips core.
> Or we could include a prefix/suffix as well like rtl83xx_dsa or realtek_dsa..

I don't have a problem with just rtl83xx.

