Return-Path: <netdev+bounces-101799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEFA900209
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 13:24:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F29931C212DC
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 11:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B7718F2E7;
	Fri,  7 Jun 2024 11:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SYXKXGyz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18190186E2E;
	Fri,  7 Jun 2024 11:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717759360; cv=none; b=j0uXWduldLrC3vqtMBF6VpfAT39dSj5gBe2jD/n/GJL0Xra3s/wQxa0ulf92obkhi+E/RHgQxZnXMlZ4pPTsDtvY4rUB34EZm2WWycfqI64FFkFzBHMdNvLmAxy4zXtF9D2xcaUprF8aNPEUX6YtGb17NXzKhHlYiEtMuAsb+u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717759360; c=relaxed/simple;
	bh=hScIfhISZ98JzPTpg4Ku3qDuEU0p09+hjxUG+FGVXJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RIS/SkNRNNOgRreEpE4/n5lFNJ4AflO3i5VBWRhcXSt0WKiHOsqtOtmJUmesKPOhQ6NCsKXGIEOhHNPgWsGDAxr2ewMf9djiW4jqUuH8CrMD6Jb6IE+FKI+Y3Zo6akH+cH41+98+FGOCb8QKFqpN2u2I0ShDE5nozB4XtKpAb2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SYXKXGyz; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57864327f6eso2270022a12.1;
        Fri, 07 Jun 2024 04:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717759357; x=1718364157; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x4SehoCtv03vB0qyBAjnEms5p63FCmlkC9bYWqoJzjc=;
        b=SYXKXGyzE86LwSG0xPMoLCgRncJG9G/RaKD4AoTTyUC5fnbeVWtDsyC5/21DDwm4Nn
         vT/YXZYr8ewoqmuiLIGpo912M1iWHIdel0ygAwsI0LFd8SVuxAeDumS0LM9R7l9kHMzJ
         RXKYRnaC+Y3xihE/8so8vYqcNe5CXs/phSJdWDRdTmA7Ujrr/R/BshCpjLjTjk7UHwfe
         CRaXZY5XN0tRE76I4rz6zmi5LC60KsGNrE+3MOwJTUeSOJ4cwQPtemWDQ/nNLIijHVRU
         Q0gvN+PwJfGOjm7c0C9vY4BarmtgfHvWnIQ9TWMxoH/nft+aVpShw/7871MVgVavy7V9
         Ggpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717759357; x=1718364157;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x4SehoCtv03vB0qyBAjnEms5p63FCmlkC9bYWqoJzjc=;
        b=KqnEfkP2GU1JoSaXXuYu5pBaOeVgeXFOLUVVvmH9J7EoHsWr38LkE8OzZa3uZhGMFF
         v7Lo06Yg/GnaBDGa9o27fIey4pn8FG24iSOyKLTfkDtIKhIyGCM6GLePZH2LM/XFzMYu
         ndDvnuyCK3phkM3ktsjXWXAcYng03YgVTIJJbAsnJk1BH3eQk+9puLLHySDG0SPSPu4I
         pPZaWSotAWmA6/3A+1HNEtEMwH5kdJK7Gl8zaPesxbXiSIOuAIp96fsJkr6djTgLLMua
         hFmVuiWJKt+XnW4y7MgvvtiiH3/FI6nH+Yo83CvNTOFykPoz5DKPAuLvNdD7RrmOg/AA
         h+bw==
X-Forwarded-Encrypted: i=1; AJvYcCUl1OQiaz5/Zj2JbVCq985Fk+Anw8drs/njZDGEz0OweoK6XSPzPHOomB4N9jYghntYwY98u94W8GVFCZYlnjRqYVGCx3xWwm9bmXEHh0YNcfEnqwbVZ4pz8JbEWMcJz526Wj8mv6UuCLvS8YZCKzTUdjnPCoC1qmCAKGu0UOKFxw==
X-Gm-Message-State: AOJu0YzZeVIfd7EpwYgt+Iua53EL5pbsRTg3rrp9nX0YrSinIIXE/2kg
	aPw4QXA3DR40eNWp6ycCkroNYoEo6Sc7H/AN1tZXypzwTt3GQkQL
X-Google-Smtp-Source: AGHT+IFPvVYaiIMh+GNWOoawH4HOzp1HfkHldBJuZ+ZQInPWBlie18sIKnuf5nleeGSWWALy0jGBpg==
X-Received: by 2002:a50:9550:0:b0:57c:57af:6e88 with SMTP id 4fb4d7f45d1cf-57c57af70a9mr1271729a12.9.1717759357289;
        Fri, 07 Jun 2024 04:22:37 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aadf9d064sm2580085a12.10.2024.06.07.04.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 04:22:36 -0700 (PDT)
Date: Fri, 7 Jun 2024 14:22:34 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Martin Schiller <ms@dev.tdt.de>
Cc: martin.blumenstingl@googlemail.com, hauke@hauke-m.de, andrew@lunn.ch,
	f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 07/13] net: dsa: lantiq_gswip: Change literal 6
 to ETH_ALEN
Message-ID: <20240607112234.t2n4c4mijbpaziqu@skbuf>
References: <20240606085234.565551-1-ms@dev.tdt.de>
 <20240606085234.565551-8-ms@dev.tdt.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606085234.565551-8-ms@dev.tdt.de>

On Thu, Jun 06, 2024 at 10:52:28AM +0200, Martin Schiller wrote:
> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> The addr variable in gswip_port_fdb_dump() stores a mac address. Use
> ETH_ALEN to make this consistent across other drivers.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

