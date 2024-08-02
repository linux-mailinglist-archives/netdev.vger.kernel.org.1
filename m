Return-Path: <netdev+bounces-115222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C1A9457AA
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 07:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70B8B1F211AA
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 05:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962C73EA7B;
	Fri,  2 Aug 2024 05:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="M0WrNzhn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AA42E83F
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 05:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722577107; cv=none; b=SOONXxPBgW9lWQQmG8Ua9KB7+obab5PwgG+qHncEktBmS9wGfqZLNEe2sjR17tuGiDMuV0QCPkePo7sA0PtrGse2EVQdIzdqDU4UUCzFHjPRV5PWHq/ggiSmA3UXphQYD7kyxhtPvz4VkNxK//wTOd4VmO6WVBn9fqe3vjqRMp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722577107; c=relaxed/simple;
	bh=r+yRL5NIoWIL7MEb/c3WCpWwOnsPDmf5woeau24tuXg=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=dMXObFtrNoroNqaYqmtiFIzNlUtMQCtUCNZNdey36rVlLnCdIB5HX4zmq25xJgzAJvdunSJF2bHNmfTPP9DgLVXpMvzQHSyNuoRvFo/T6If/TWWA+zLLtpH1iTPvNBcYgVuwFUdljPW3KZygOyJOgHzwCAmSEKAjQ4Oom+M8AS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=M0WrNzhn; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-42819654737so45960015e9.1
        for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 22:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1722577103; x=1723181903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DfeP6amEbFO01B4Acz+SaLNxYhMl+/N6xqPd9wmuVYo=;
        b=M0WrNzhnV1SvxBVE+bBwbkZSkAFjmHarLHiCN44noWobidpnYOSIiffGqPGL69t34j
         KHXwHoNeii3qfc2bD72ymQF4PKYhIkVlYgCYqg+9Vnx2j36/R28lWDIjVwCJxuzb0wPF
         BmKu+ywcofygglt+L/K9pgAM9odHEIF2HioAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722577103; x=1723181903;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DfeP6amEbFO01B4Acz+SaLNxYhMl+/N6xqPd9wmuVYo=;
        b=pM44tDNpcDKww29K2JaRLgDMsOvBCyDJ+ay0WkOAEMYnR0KfGT+eq89IOAVGLGTeUE
         uO5VAZqBb9e6q5jH5MM/JtrY6nMijwtmuQyxirqn77DDKX0t1xrRXI++s/F3mCkj3eNc
         KJQ/hxR49+SlId/1s3iQ+i6HyHWiUqk95kteXXb9n+d0APzvmovWKczntCLfN9punVOF
         WI8oocqJGGhzjTd4T0m0HUQy7XyC3tCfUaEqQX41zRVtdgeHtw0Un0COrtqF6kQUNGRb
         Crhc16MAT8NoNdagXBQBlsAqxbmQfs94BTsNUDlX+fWGvpRzRRfOYTzp6ty9b/FGN+go
         kuRg==
X-Forwarded-Encrypted: i=1; AJvYcCVzWgLQXs7M/RI5PXbyAriYDf3O+Q0gOdPonS/JoLW1wdZGOCLw+GmmJmKwqKrOuvXqPNAslsIbY0W6LSi63nP/CrgEFPT6
X-Gm-Message-State: AOJu0YyruFp+IMyMGWLtBR5oY9yBIKqTD5hFijyN33JGS9D9AGauKGqS
	WgKAsFmIz8aARqIXCJqgSvWCj5vc8s2PNpvVSvcgqD26vm45YrbaDJVaP2Uh8w==
X-Google-Smtp-Source: AGHT+IEejV9gHMncaZ3o/uEqdLFU6pJXfTAhrguKl3WqsWQrl6f780k97r/VhDfVH2wQrwxF/xsUbA==
X-Received: by 2002:a05:600c:1d20:b0:426:668f:5eca with SMTP id 5b1f17b1804b1-428e6af76f7mr14366225e9.7.1722577103013;
        Thu, 01 Aug 2024 22:38:23 -0700 (PDT)
Received: from [10.229.42.193] ([192.19.176.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282b89a946sm81037345e9.6.2024.08.01.22.38.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Aug 2024 22:38:22 -0700 (PDT)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Jacobe Zang <jacobe.zang@wesion.com>, <robh@kernel.org>, <krzk+dt@kernel.org>, <heiko@sntech.de>, <kvalo@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>, <conor+dt@kernel.org>
CC: <efectn@protonmail.com>, <dsimic@manjaro.org>, <jagan@edgeble.ai>, <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>, <linux-rockchip@lists.infradead.org>, <linux-kernel@vger.kernel.org>, <arend@broadcom.com>, <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>, <megi@xff.cz>, <duoming@zju.edu.cn>, <bhelgaas@google.com>, <minipli@grsecurity.net>, <brcm80211@lists.linux.dev>, <brcm80211-dev-list.pdl@broadcom.com>, <nick@khadas.com>
Date: Fri, 02 Aug 2024 07:38:22 +0200
Message-ID: <1911198a4b0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <20240802025715.2360456-5-jacobe.zang@wesion.com>
References: <20240802025715.2360456-1-jacobe.zang@wesion.com>
 <20240802025715.2360456-5-jacobe.zang@wesion.com>
User-Agent: AquaMail/1.51.5 (build: 105105504)
Subject: Re: [PATCH v7 4/5] wifi: brcmfmac: Add optional lpo clock enable support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On August 2, 2024 4:57:48 AM Jacobe Zang <jacobe.zang@wesion.com> wrote:

> WiFi modules often require 32kHz clock to function. Add support to
> enable the clock to PCIe driver and move "brcm,bcm4329-fmac" check
> to the top of brcmf_of_probe. Change function prototypes from void
> to int and add appropriate errno's for return values.

Sorry, but this is moving in the wrong direction. The reason for changing 
from void to int was to propagate the error up to the bus, ie. PCIe, SDIO, 
or USB. Anyway, I reworked this patch last night to do just that. Let me 
send it out to you.

Regards,
Arend

> Co-developed-by: Ondrej Jirman <megi@xff.cz>
> Signed-off-by: Ondrej Jirman <megi@xff.cz>
> Signed-off-by: Jacobe Zang <jacobe.zang@wesion.com>
> Change-Id: I21bf9e21b275452369dce1f50c2f092eded6376c
> ---
> .../wireless/broadcom/brcm80211/brcmfmac/of.c | 49 +++++++++++--------
> .../wireless/broadcom/brcm80211/brcmfmac/of.h |  4 +-
> 2 files changed, 31 insertions(+), 22 deletions(-)



