Return-Path: <netdev+bounces-223944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4A4B7E08D
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 402243A572F
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 10:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC28635082E;
	Wed, 17 Sep 2025 10:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HTt4Nrr4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31A934F470
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 10:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758103853; cv=none; b=jo/oBYTYh3G+XVdn2jnw5UcM1+EOu+A28Vsq2xLnqQmPPOH8P93fvRfH8kMYwtG6NAoPiS35tkYnFq+6glRvmbHl4sWDFaKwz7+YyrNMKpBDIvn/BBdRAroMOdkw0aF6Icdyo9XgeznFvhvQpbTnorj3KwFsigBYAD+WDj1lqaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758103853; c=relaxed/simple;
	bh=ZZVPr8zwc3jcO0OuCGyJfEYik/KPMCAqckFIByRhOZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kzy2L2PfFI5q0LsMJyIjWJ5wjcQz7KbUPFeXtnRHXMfdOuG8Oa94z0dzD8+Zx5GAAFnfd0vzeiOk2/NCBa/d3cF3QuKutgKuZyLy7wkN+0VQC4nMSEW+jkNtjRnL+duWnoKdx6kGPoytXEeKkcYlR4MxVbP3FvbNtoOVIl4L2EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HTt4Nrr4; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b07e3a77b72so112237266b.0
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 03:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758103850; x=1758708650; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gfhBOmsmCdqnUMz/+8Ss3Stx4dtkUPFOWgiDwJ5M/m8=;
        b=HTt4Nrr42awsw/sWUUmkJaZXN/VLbWtlFTAMScXNR3O99EntNwP3wnXVCsMrz6cEK5
         5LWmcm07ExLRuQMwYcEOZJ+KFyBT/C0vw604BF0B1kN/TACYXQVfJ5c/tvolRvdtZfg2
         iiRH5JEZ6+CP33Qr7uYEVTIX9K/WJm82bG5+PkHJotTgUfMvptfkI2ANdD2XVbyv6B/E
         fzWXURrSyJSIIM0nmTHvg4h2ci6fw4x6aJRnxiRXGqEsOFxxHsjVbz+eaPrIGg+wc6Uu
         Lj2yDsNSVm0CEzUYaYFwI/tj8EPCGUMvvvlISA1CVvsQ/o3oOn02SSrnxf9igWnyyWUD
         MOIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758103850; x=1758708650;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gfhBOmsmCdqnUMz/+8Ss3Stx4dtkUPFOWgiDwJ5M/m8=;
        b=E6BP8zfsc3cQaW/bKS1xp5NyPcybOC6IJmpYoK6k3LJOwu+l4koEqOtyPOZBa0aaKM
         MpNbP2NaUenjq37hJ8x/C4Xbse+XTSkxsfPXy27dvKYk7MxrgH1Z0vmECcdFn5yRbf7G
         jKVBNSFceL9Fq0FKCjcoPQl6X8vu6bTY8E8nbbIMwY3AShKs9zLST06EAZ2LybZnP4DN
         2BrfYfkp8v72gQ+EABZh9+GeZ/SZL11KKfkqihNcA76nxldU8q2tyz+2vvPeQfLAvi8c
         OdKK8pV0gWZ8Igm4u5p/HJkR/F/GYH+clzcXlH+oXb4IC9fX8Isp0i+sz6fRJ8HO2ih6
         IY2g==
X-Forwarded-Encrypted: i=1; AJvYcCUHT0WLPjlsacw/4OuqhpYPq1lAG8vXtgHJClyP29W4dcVphGt2D/hNlcvyGqKcxeu7fg5aMJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY6lNIRglz++QbtOroCcL/qL39/DdNPTcpbb/GaT1h7fov8kTS
	XstBO0+sVxWvifg1PiYBCyQQugl8/hynWk9Yh32bcZ2HFK3gMGoHtJv3vRTIPW+FiMk=
X-Gm-Gg: ASbGncuAcQ/GF3Mx9TwPsEai3Ljf7keM+ZtuXYv1aYK2NW20BxSJ46Xx9VUc7qkJ+z9
	BUqApH8ZM9Swl54Q9gMrVkm3gSBtCEX+NF8Ix576oTCC/OySCCG7NkBIthU2gbT9SYnVI7AY33E
	aYFx8M+7VsWHUdXmu06N7d/FniClf9nqwQ11kts39M6RIaLqhZlNqgRllV3kRbfndHi1ZU5zDLk
	O48RavccuKCVD48lFGu23CpQb0B2ICI6Yr/r6iumRopIJ3cpKXp4UmsQAbCP7Yebf5pVL0x7tFa
	exW08+cTY1ASEob6q4rlF5pka/Vf+olP5V5ofDvRSFiss0s+LIOd01RTKz29I4QxGtSkjKRiI7t
	mD+5jDxvPkw7JCbWsbpJm4lHzPTrLUYgC3HfO72b70OgX6zqa7CIh/QhYthz8ikRg
X-Google-Smtp-Source: AGHT+IEffrTIn04hCkbbCjr83BNBKSLUY7sk2TJEFlqvq5wVXFDKpBzk6i+bXHi14sqiagolHGQ+ug==
X-Received: by 2002:a17:906:c106:b0:b07:c66d:798b with SMTP id a640c23a62f3a-b1be49e1b5dmr185057166b.11.1758103850321;
        Wed, 17 Sep 2025 03:10:50 -0700 (PDT)
Received: from ?IPV6:2001:a61:133d:ff01:f29d:4e4:f043:caa2? ([2001:a61:133d:ff01:f29d:4e4:f043:caa2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07d2870da1sm1004985666b.13.2025.09.17.03.10.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Sep 2025 03:10:50 -0700 (PDT)
Message-ID: <0f2fe17b-89bb-4464-890d-0b73ed1cf117@suse.com>
Date: Wed, 17 Sep 2025 12:10:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1 1/1] net: usb: asix: forbid runtime PM to avoid
 PM/MDIO + RTNL deadlock
To: Oleksij Rempel <o.rempel@pengutronix.de>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: =?UTF-8?Q?Hubert_Wi=C5=9Bniewski?= <hubert.wisniewski.25632@gmail.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, stable@vger.kernel.org,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Lukas Wunner <lukas@wunner.de>, Russell King <linux@armlinux.org.uk>,
 Xu Yang <xu.yang_2@nxp.com>, linux-usb@vger.kernel.org
References: <20250917095457.2103318-1-o.rempel@pengutronix.de>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20250917095457.2103318-1-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 17.09.25 11:54, Oleksij Rempel wrote:

> With autosuspend active, resume paths may require calling phylink/phylib
> (caller must hold RTNL) and doing MDIO I/O. Taking RTNL from a USB PM
> resume can deadlock (RTNL may already be held), and MDIO can attempt a
> runtime-wake while the USB PM lock is held. Given the lack of benefit
> and poor test coverage (autosuspend is usually disabled by default in
> distros), forbid runtime PM here to avoid these hazards.

This reasoning depends on netif_running() returning false during system resume.
Is that guaranteed?

	Regards
		Oliver


