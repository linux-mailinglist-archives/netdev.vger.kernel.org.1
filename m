Return-Path: <netdev+bounces-192697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F40AC0D69
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 15:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EECF21BC5F22
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 13:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929EB28C2B7;
	Thu, 22 May 2025 13:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="GIYPcFv7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8876328C2A9
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 13:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747922275; cv=none; b=JXd26caf4YLPxpzwZCZKP6UH7x2wb2XUujPu1OBbCXGEMKVQ9hDU7P8PqAg7trc+L5UEwYLvAAMiomSx0ssiuYxbo+bCkYJl7PIzSziy70ggxFXI2oDqdElxI0q43yvNgTzf7CS+MUwhlaaGzE5YFeXQjx8XowdnR9sUmhmWR2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747922275; c=relaxed/simple;
	bh=W6ryOFwK2ZYe5QKFYR9s57MNquKxn8ms8DDmo89aj+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hqHcjR6YlbFWiAtn5zPkVfxuDNusu/rmrfolhVDWdNRQY/qBr+6AwImukRSUNJC7UqHkk6K7FDJp3xdMnc21pMBhu5EzcPKoKNrdvTKxlz0lzGRQ88Z3jUtZTXZAj32OV0whmEKM1lvxCQqmomis4BFQDg3jDkbeti2d1n/pr0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=GIYPcFv7; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-601dfef6a8dso8012297a12.1
        for <netdev@vger.kernel.org>; Thu, 22 May 2025 06:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1747922271; x=1748527071; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wjoy3zGr6RdUtyKzS40F44AT/YK6SyAZrYVGzQ8/cM4=;
        b=GIYPcFv76YqFKxxeCOzOooic2A57l4kzZPXg/+vsgTLMCCFHsX1TR0w3i2E5QJxBU0
         HuL4RhUFRYQlJCd1C4P2H67Nc92qJdSTp8OMyvZJueNKEzH33iHYCNmvu/oUjLGxZanR
         Rko0ky8RDGIK4DrAg20gZRWjN6Br47iHARXONe8zYHms0NGyzUVKVOQ4eSh4NqPKueKV
         JLeNwtxsNvde0M7QqwPtJWal2TbjVnjlK/iMuteox7RuBWKrly1pbQuEIo7hAZJHFw1O
         HL9TFbz/lIkB+foEh6v9zQyhcvoqp9AuB4+jiinjOSG0gnxmB0cKppxx4owGkbQYowTn
         lfqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747922271; x=1748527071;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wjoy3zGr6RdUtyKzS40F44AT/YK6SyAZrYVGzQ8/cM4=;
        b=GbzosoiZ9tJcP95PVvjMAzVGtH4BgUiSEic7UeIw5b05fVUH964K7k2guN8IsLEbz7
         BytfgIf/lQ8kyJuikLzOr6UPWez1kyFdhFA0bf5YiGPybiuGUINqvSPI4PmQPWobN/FZ
         FL5m6n68WE1sdyN4HC15rCX0mADKn3DszNVxORnew7cjGmCBxQz5W1j0GCbTqvq6VYtK
         2hGgwmSPfGp7ZwWk8CW7Ikp4fzU0Bju0g4k8KBu9BGmpBikmdtL09n6rt92Gubj8glPf
         yECizUoLy9e3Cv6Kcpkr+bKpYZ1QgosXlIypR3ozKusEFPyMsKrVeK9vErH+i3JIlpkA
         BChg==
X-Forwarded-Encrypted: i=1; AJvYcCXjMp5Q29WtrNsypBzNAKaA01FvTcyUVFcwlkbyQQK0arL3eZk5MepTgIVaZ9annZ8C3eu9bms=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPOy8WhHOeUcLPRRo+R8mNSSLE0gGOXnReBTxoAs1i+Z5oYla/
	SXcJlyFEvssN6/VvgDkK1fcwUjv4XISVZduDHi/xjhPyuM05wbc9uSAxTLp9M07GsXY=
X-Gm-Gg: ASbGncvthOoilbrBBTJFlDyTYuqY2RQXfSR7aVEtBFzBa2tAZUBSNgmDQAlU/Igodin
	XsZXpvTWfUn+QLgMrwEg0wVjjTK71mMySs4zps9z6xEYM6CTyZ9bnfaz9bxiRa1+TXmD68m9MDh
	q4vfagaJ/FNtm295IP0RVPAqz0xCSuDs0kZb/CD0oBw7094LWTLTSR6D4J+k/gINDv2RndPwSr7
	fNKdcgKRaJXC96+ldGuUMCzA7Mxt4lG1YE9Bd4N7MmN6ZtSQTzysR2zUQ4rnIMna4dhBl2OEVDY
	cAGK2rxc6uSJE2ZpkkaeCVqXJGzzviS8gdebclx1OAYhCYSMzVmWi8th7TXaRDiHSDxEYT7YiKA
	12ritrwix
X-Google-Smtp-Source: AGHT+IGhbOxHUGpXjp9UPfFI8oA2S5BSMCHcokMGhL9bjINRARQ8HCZLvnS2Lc0d627q3lfEljlU8g==
X-Received: by 2002:a05:6402:5189:b0:5f6:218d:34f3 with SMTP id 4fb4d7f45d1cf-6009437f14amr23482660a12.28.1747922271468;
        Thu, 22 May 2025 06:57:51 -0700 (PDT)
Received: from jiri-mlt (37-48-1-197.nat.epc.tmcz.cz. [37.48.1.197])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6005ac327d5sm10582220a12.63.2025.05.22.06.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 06:57:51 -0700 (PDT)
Date: Thu, 22 May 2025 15:57:47 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: David Arinzon <darinzon@amazon.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, "Woodhouse, David" <dwmw@amazon.com>, 
	"Machulsky, Zorik" <zorik@amazon.com>, "Matushevsky, Alexander" <matua@amazon.com>, 
	Saeed Bshara <saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>, 
	"Liguori, Anthony" <aliguori@amazon.com>, "Bshara, Nafea" <nafea@amazon.com>, 
	"Schmeilin, Evgeny" <evgenys@amazon.com>, "Belgazal, Netanel" <netanel@amazon.com>, 
	"Saidi, Ali" <alisaidi@amazon.com>, "Herrenschmidt, Benjamin" <benh@amazon.com>, 
	"Kiyanovski, Arthur" <akiyano@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>, 
	"Bernstein, Amit" <amitbern@amazon.com>, "Agroskin, Shay" <shayagr@amazon.com>, 
	"Ostrovsky, Evgeny" <evostrov@amazon.com>, "Tabachnik, Ofir" <ofirt@amazon.com>, 
	"Machnikowski, Maciek" <maciek@machnikowski.net>, Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
	Gal Pressman <gal@nvidia.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Andrew Lunn <andrew@lunn.ch>, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v10 net-next 4/8] net: ena: Control PHC enable through
 devlink
Message-ID: <aq5z7dmgtdvdut437b3r3jfhevzfhknf5zr5obaunadp2xkzsh@iene76rtx3xc>
References: <20250522134839.1336-1-darinzon@amazon.com>
 <20250522134839.1336-5-darinzon@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250522134839.1336-5-darinzon@amazon.com>

Thu, May 22, 2025 at 03:48:35PM +0200, darinzon@amazon.com wrote:


[...]


>+enum ena_devlink_param_id {
>+	ENA_DEVLINK_PARAM_ID_BASE = DEVLINK_PARAM_GENERIC_ID_MAX,
>+	ENA_DEVLINK_PARAM_ID_PHC_ENABLE,

What exactly is driver/vendor specific about this? Sounds quite generic
to me.


