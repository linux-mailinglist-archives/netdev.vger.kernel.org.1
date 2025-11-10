Return-Path: <netdev+bounces-237153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30122C463C6
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 12:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3A483A6BE8
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 11:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1582530AAD8;
	Mon, 10 Nov 2025 11:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EtsCD+jK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E729211A14
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 11:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762773875; cv=none; b=HHgwiiWBNCyT8FNPvqjQiDwlh2LtXRMDMQE/0LMfHKrbeADByyXahO+uB51CnPujwvPO3zunDZnWnrKRANUUDlj/HqcC1nRbi06eQPHPzq0FQQHoP7YTsiCOAsn2Et7zhfu0YIvMQZjOcPcwss/hbpUiK7Ds1ZKD3YTh9NKL1Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762773875; c=relaxed/simple;
	bh=EJyeyu9qrbyFTW3ZAMU0Et/efH4fzledufkx17gz7vY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gawt7M73rrqgcvcQhr8ruEULUdSTR9rX1crmH5vvjPIMddb6wc1+2hEFOoIfGkttTrCn8dqg5l4mOo2QEQnlhlxdr+4HSVMsVmmeM/SiSXuiR5Ld9lCou/suDJi0iMMlbrQDv9fb8o3hAsmZhBLygv6bxfp38R7tEiZ8HcqAi1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EtsCD+jK; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-477774a878aso714485e9.1
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 03:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762773872; x=1763378672; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XHVkVJbJqK7JYa82NcNOlxoAH1RMsDuV8bpVmsumva4=;
        b=EtsCD+jKv58s9eVORzVXNuNc77WkQghEV4IGdqYijPMRZUg6UDXCScInsqnkeJ+3wk
         KM5vt8eQiV5zEd7/CdmicGm661eqlfaZzOqEaVB3qFnx6uL2PfcMPc5AMhmGfoPLyNJW
         GV/uWhhwzS5I0PO4yXoUUOR8BnhO3rLXqM7I11gUHc0SgYBioGpd02P6VhTFlAIa9CzT
         JaikZrLQOoF9PC/9Ru/pL+kBumsQ4RCiw1ALoAHC68bhMvq7TA44nqMspN5nf9Ln+F2u
         K6nuBBm2Dezi0vGdP16K9qWg4b0BBws4tZlU10doWRXQHF6ZsRd5CHN+ysbLAGU45aD5
         1DXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762773872; x=1763378672;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XHVkVJbJqK7JYa82NcNOlxoAH1RMsDuV8bpVmsumva4=;
        b=ipM6fSF9ArwLkFqz5og6ligvc+MLnWR9/a2T8rvyobm5PW8XMkglAN7K8rb6/bx5lC
         wrOQ3OyqCzKQWb5cQ2l4TjKZr5fCMqqlc+ukPTk13ev2Dq6Z/AApEkMoJxIsOc1H7g/l
         +iHQr0P9v1UIGbj90e1jrmTx48GPeq/LzTMDXKP4NpABqHp+Q9BVz3fK62iqpogGaWT7
         780cYhtA64DGk2l3vT36GxWifC/epSeAu+ud+NeZZ8+jrJ+FuhfayGiKoOuNQ0B3xklE
         1D0+5EQ3zQnYbO27+fWIJebFO/8/83ASqHWOSJZLyT57EPHJjjuwrg7kcumxAcDGxkfW
         xx1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUZVeGvT0guW5MFHhMTgCzxXW2hnTPE+cUrRzzVT2pf95IK6lX3jIyxfVTkKHLNWM5mlNXMRu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YykLu9XEM3EcmT17xdRgp0SQ96EHRFNN/OKiswe9Tjg1xGTLZ7i
	wrOfX+94CWR96TTXbxV62KuBAWNyLX1k2LYG5ao1RY9JdUPB3ickp2iv
X-Gm-Gg: ASbGnctRcYx9ne7GQu66xSCcj1BYIpFZtxVERBdvNc2LEd41pSrzSthp5yZ++dAw0Kn
	IWhXamITvlA/sBUX2vzhVtHMrKxl57y3603yLWeFtrU6IE8ylHpDm7GpbaHBFEvnBsOPXIjDPC+
	9cFDbZc6J82UfIUMxtWhKzD9uCPLaIux+tAto9Y/wOnxzgNSgQrKDKVWx6N4y65iB0atgZuaYKM
	4PnxKqr9gNUyDerg41/nkeuB8TNehtoUXIdvRo1Q5ACdkBaSzdgylsXt0U+qBxbvhCiEFxL5TT2
	pZRifabeirvd7inEbUgEOMZDjiFUXZhB2Hjfa56e4NYA4EfOMp5NExzgrskA6FInIpqJ/B1Op1M
	Y9p7uAVZmSlFcTNcVycUgD0vWMzbwm3YzBxZhtS256J+a+X35D8xNavjAmz5HfcIi4sLp
X-Google-Smtp-Source: AGHT+IFv2MC97DDRVbWlWDwdHkT6SZ1RsmqcVG6EYHokOKf3aRIupq3sW4kWIWGv6LqQLEOY+RHrFA==
X-Received: by 2002:a05:600c:1987:b0:471:ab1:18f5 with SMTP id 5b1f17b1804b1-4777328fc49mr38719265e9.7.1762773871479;
        Mon, 10 Nov 2025 03:24:31 -0800 (PST)
Received: from skbuf ([2a02:2f04:d00b:be00:af04:5711:ff1d:8f52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477789f3f0esm92528885e9.6.2025.11.10.03.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 03:24:30 -0800 (PST)
Date: Mon, 10 Nov 2025 13:24:27 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	=?utf-8?B?w4FsdmFybyBGZXJuw6FuZGV6?= Rojas <noltari@gmail.com>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: tag_brcm: do not mark link local traffic
 as offloaded
Message-ID: <20251110112427.bxibfxj7ziyukzfs@skbuf>
References: <20251109134635.243951-1-jonas.gorski@gmail.com>
 <20251109134635.243951-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251109134635.243951-1-jonas.gorski@gmail.com>
 <20251109134635.243951-1-jonas.gorski@gmail.com>

On Sun, Nov 09, 2025 at 02:46:35PM +0100, Jonas Gorski wrote:
> Broadcom switches locally terminate link local traffic and do not
> forward it, so we should not mark it as offloaded.
> 
> In some situations we still want/need to flood this traffic, e.g. if STP
> is disabled, or it is explicitly enabled via the group_fwd_mask. But if
> the skb is marked as offloaded, the kernel will assume this was already
> done in hardware, and the packets never reach other bridge ports.
> 
> So ensure that link local traffic is never marked as offloaded, so that
> the kernel can forward/flood these packets in software if needed.
> 
> Since the local termination in not configurable, check the destination
> MAC, and never mark packets as offloaded if it is a link local ether
> address.
> 
> While modern switches set the tag reason code to BRCM_EG_RC_PROT_TERM
> for trapped link local traffic, they also set it for link local traffic
> that is flooded (01:80:c2:00:00:10 to 01:80:c2:00:00:2f), so we cannot
> use it and need to look at the destination address for them as well.
> 
> Fixes: 964dbf186eaa ("net: dsa: tag_brcm: add support for legacy tags")
> Fixes: 0e62f543bed0 ("net: dsa: Fix duplicate frames flooded by learning")
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
> ---
> I shortly considered changing dsa_default_offload_fwd_mark(), but
> decided against it because other switches may have a working trap bit,
> and would then do a needless destination mac check.

Yes, exactly. Or they simply don't receive link-local traffic via packet traps.

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

