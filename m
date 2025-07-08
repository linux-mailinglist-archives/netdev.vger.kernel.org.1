Return-Path: <netdev+bounces-204933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96D17AFC927
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 13:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED2124A269B
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 11:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565CD2D323D;
	Tue,  8 Jul 2025 11:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7WUSjHO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AB6219A6B;
	Tue,  8 Jul 2025 11:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751972845; cv=none; b=eDf1ku/LQgL65b2p4fa3UPt1bs5okv/p7A9BhJWuI8O6AV4OHofRi5teMpwWhfAliPqsobzrBn9XQlgTqP0wquPTl10VN+591xRbwSeYDvMvQ6H2p80wizBkCwMGiCoW2wMSZZ6GD5PCoJPn5bkzfnQKodPwoGxxai6QDnTPdkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751972845; c=relaxed/simple;
	bh=ZbSluK+goZoZ2vBUeFQl34xKzEtPRYiwW9GIygGl56g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ARXqZUQ5HFG0b+km2RELl4/K5HrYaCdiNmwZKyMOg1BkIWsMTRBc46CCoTVjeSceOxYvec0rJZ2NBYS46kTgGLC3RFpoRBhJ4KWBepbAPvabiMI9G2UMD79UYXdUCkx3zpbqyDha/wmrcBmQrKXadY30Cmt7DjFynPYOJesbFtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F7WUSjHO; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-60789b450ceso8207201a12.2;
        Tue, 08 Jul 2025 04:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751972842; x=1752577642; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tckhY3cCUTf4GGK16hiCXvEoeDWgoUQjK8B2G9y/l10=;
        b=F7WUSjHO7shgAkfH/JqxMdyfcnK25TLJkA2KV1QQtk6Jcw+PX/ce6w4fUL/FPn2TsN
         Y2HLCB2xLYeFdHvaPazLrjqCnLbOjSNdT7NElKhskfT12uJud0/d5u/AJ3eLfqjp14ew
         N3CfMS+bAitbF1qRdnulSiFMMyxxKHMehg331poPEVpiiJObiCDIO7le5l7zOHdXmJpr
         4oEUF5g8brW/2X99TcHrgJc+yM8cAE7Jvdhseh7pBXmPutfT90Xq2A+2amsdYYhprtrl
         SnrzHv+p3UUhL5Dq0jK9fiNQrTQG5UkNs9/HnLTb5R7Uu7AaaQddcWSM9pbizrmZ2lVG
         O1HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751972842; x=1752577642;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tckhY3cCUTf4GGK16hiCXvEoeDWgoUQjK8B2G9y/l10=;
        b=T7m+x6AaNY8RL4cBSnhFljpR3LYzDM5Nn7m8WKny4W+hlw+ntBo0tUNqiYazveFBng
         7iuvEfpytCTEvufa+SgYKTG753b3Zh0PaK5zaKtTRPcoh1SazMsueaDxLg4n6ILBxmB8
         9lNXEpDlzUP+WSzf8LDMbSYXZwXO3sGV+3thlNx2ZOjmUuNLh5TQnOd+kFZKnLZk16+m
         DYxtMpzotBVTRDDdZpEykAyNwlk9YGqANSDdzj+lpDeBMig0kkwqLiSwyIg+0Oyb1pf7
         VWpzbpCLv86BPRS3vgI3/nCtuSJ3teEsc6i3k0A07JyPfK5ieQnO6Q564zrriXy+nW/0
         jyww==
X-Forwarded-Encrypted: i=1; AJvYcCVWi6ITVjULnqK396X0X0Sge3+8eCapvm640ckPrIMRTiGpeBL7gptALa53gNv5IgECEVX3Yaj2@vger.kernel.org, AJvYcCW/siPCCsZSzYQdjdb32EGPaKTlXEBPhWjIvu9tKGdoQZndLlOii4G0pxM3IrXGX58INoH989Zt9ZSZlkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyecPyaRnF7jaFWD+6wVH4md6jkwkcwm0N85/+y1kFfNJI6jDd/
	USyASOgM0+bk1CScazrUbW6+Muge6ujsHQ963QI1CIej7TSo9Vh9JagB
X-Gm-Gg: ASbGncu72MGQBQr+VbhYhUbnjQuOQ0WsyyvbJKqcc6h3QChk5nyUAG9s1whGHuLg6eX
	xvzXw2tzaUP1SJ7c4csdo19rn8jHITXY84I8bNMTHrbRp5LcozP79al+oG0XMoxqmChbLuN1ICg
	22liQZaQH9ehLPrVRkFTQTU6Cgn0iycZ67z6ofaRYhay7vrasyx3Dh6PZj9L9GHye9vD2lXwIg2
	eKrGlv+RsMs1RBzZwaqySACxKdxPN/J/b0SVWlC770o1PtjH1ta5zXPhngGJ4tnGXWDk0ImAckD
	dVOh0nR2/8n1W1m8UqntZyFsPyWQ3QqfszbIaVzyAXaaQFN9UtAg7q+IHGlrXb5iBSAce0FpdUs
	=
X-Google-Smtp-Source: AGHT+IGN90dbnrn0GPt8YwyNv+T5NnqipNjNezqerVCjBFGAxVLs3WRntZcgzmMTKdg6W2CvpS6vhg==
X-Received: by 2002:a17:907:96a1:b0:ae3:ab68:4d7a with SMTP id a640c23a62f3a-ae3fbce896emr1851830466b.25.1751972841651;
        Tue, 08 Jul 2025 04:07:21 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:325::1ac? ([2620:10d:c092:600::1:4dfd])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6abfd8bsm866154366b.81.2025.07.08.04.07.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 04:07:20 -0700 (PDT)
Message-ID: <c006f353-8b35-43c5-b010-d058954ff993@gmail.com>
Date: Tue, 8 Jul 2025 12:08:48 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 1/4] net: Allow non parent devices to be used for
 ZC DMA
To: Dragos Tatulea <dtatulea@nvidia.com>, Parav Pandit <parav@nvidia.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: "almasrymina@google.com" <almasrymina@google.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Cosmin Ratiu <cratiu@nvidia.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250702172433.1738947-1-dtatulea@nvidia.com>
 <20250702172433.1738947-2-dtatulea@nvidia.com>
 <20250702113208.5adafe79@kernel.org>
 <c5pxc7ppuizhvgasy57llo2domksote5uvo54q65shch3sqmkm@bgcnojnxt4hh>
 <20250702135329.76dbd878@kernel.org>
 <CY8PR12MB7195361C14592016B8D2217DDC43A@CY8PR12MB7195.namprd12.prod.outlook.com>
 <22kf5wtxym5x3zllar7ek3onkav6nfzclf7w2lzifhebjme4jb@h4qycdqmwern>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <22kf5wtxym5x3zllar7ek3onkav6nfzclf7w2lzifhebjme4jb@h4qycdqmwern>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/4/25 14:11, Dragos Tatulea wrote:
> On Thu, Jul 03, 2025 at 01:58:50PM +0200, Parav Pandit wrote:
>>
>>> From: Jakub Kicinski <kuba@kernel.org>
>>> Sent: 03 July 2025 02:23 AM
...>> In an offline discussion, Dragos mentioned that io_uring already
>> operates at the queue level, may be some ideas can be picked up
>> from io_uring?
> The problem for devmem is that the device based API is already set in
> stone so not sure how we can change this. Maybe Mina can chime in.
> 
> To sum the conversation up, there are 2 imperfect and overlapping
> solutions:
> 
> 1) For the common case of having a single PCI device per netdev, going one
>     parent up if the parent device is not DMA capable would be a good
>     starting point.
> 
> 2) For multi-PF netdev [0], a per-queue get_dma_dev() op would be ideal
>     as it provides the right PF device for the given queue. io_uring
>     could use this but devmem can't. Devmem could use 1. but the
>     driver has to detect and block the multi PF case.
> 
> I think we need both. Either that or a netdev op with an optional queue
> parameter. Any thoughts?

No objection from zcrx for either approach, but it sounds like a good
idea to have something simple for 1) sooner than later, and perhaps
marked as a fix.

-- 
Pavel Begunkov


