Return-Path: <netdev+bounces-101801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C6890020F
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 13:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 292DB1C213C0
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 11:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C90018734B;
	Fri,  7 Jun 2024 11:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+M9AUnp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E6218735D;
	Fri,  7 Jun 2024 11:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717759428; cv=none; b=Md6eR5OgiFCd4I/4k/YOJPq/3knMwg5Yb6T8NkQe+Ca2i99y+K3Tq3ylA0j+rcTySVLqZGG777IQdHB7IFZyizXTa5gN5TJk8da38ZnK4KtKH4cXdA/Le5a0oKBVyMQSkrrT91NQHdDFx0q3yzaJzyRWm0kVR1OXANugjPUS7r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717759428; c=relaxed/simple;
	bh=VaKEk6EHgyI9rP6cOaBT9oRmsMjLpmhBlFpoLHGcgb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aQ8iLLg/PC759CUrsUUk8VZBGcQKTJMZ6hJg1r1JGRTYNGh0P/RTQYoTizHbu9gFqzYuLyHI46uZ2FvCSMO4WjyWhku5J0mO0gtZLoPcMuHd0fOmeTrzZlivmGIuVsCnQV2mKpX03hTSRsC3TxIE+4bFAa4hhltQSOxSeAWNyX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X+M9AUnp; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a68ee841138so259156466b.1;
        Fri, 07 Jun 2024 04:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717759426; x=1718364226; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=inyK4rlz/5+Y+EFZxkQi2C7wCBnrqfHLVfT02VOvxzY=;
        b=X+M9AUnpsbHbVimqyJPN8OByEUdekjsH39H5564xX48DK9P4HiqnQEcgCsy5OwmdX1
         7GekxePIzYUshAm/LOWbIyDdK+JYwYMMnzvSsg+m4PEBNWVkBCdWevfTMMF/TF/IzgLz
         AqZrIXzYIJ3yrV+1MuLS6lDyd1WhnBTgSMcXAYzqY+9rWVkf5JZTOwJT1HEKsLgKAv96
         EExHtKh2NCM7vS+WnSadSCdZgASQz7PU7GG3B+gYYiBTu8cB8uGGJEWfIJsnt0pzutVK
         qApmlhZR2v1g1pAeQt7zWGCo13nMraeqRqix741bO/y2r36YAR1iWbB79tUDE336xybH
         0DIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717759426; x=1718364226;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=inyK4rlz/5+Y+EFZxkQi2C7wCBnrqfHLVfT02VOvxzY=;
        b=wLegllYlZkrgDskmyAKl365JGnQVNoduUIZ2dh5K17+pQvQ7doGWnHn+7EjyK2A23r
         lMGMaMWixrX0WbRpYL2bi9oJngHBkXcG5RWT4FuluO8IIyxBFu1KBEayrmdS3MrNStjb
         77gZtrMD87zOyCau7HTcU3xA/51yv+i92agBFyUmv6NTh6qxn0RMlh1P/oSx88xpBymM
         c+J507KqhtDp0SXMiMpS4jfpPzXmE9ZRm+8h1Bb732nhGAFGe7RtZ1odiqVahFc2I8AH
         wpSx+LYnBdLMgcutw/r9eIYCMpONcW97bg8Pgv0yre47q+ad/E6zem6oFDZ5L2WViGdj
         xQ1Q==
X-Forwarded-Encrypted: i=1; AJvYcCUuLQneo8PS4L2XpDGmaSGkqwbJ1gMUwqaim+6YtkxJpsU+4xsi4WzKzgeih9V+lPphP4aykn/b23cGTNrYzGtkmvW5prR+u91Hk7vGtsv4ZzqixxrLlnb6jUj5GGRB3zFL3AreTxt81f25teH4cGDWmm0tCupnzXwt9FvbP4Xvsw==
X-Gm-Message-State: AOJu0Yw/1O55mZC6F5enikQH/5jVtodlWU5Bp9MbDuGO7zRsCwrgIQrJ
	W/nN3RGhx/b9sw+F/WrYuZd4ty87ZZzdlB2Abo/aAcQWIDJC0HIL
X-Google-Smtp-Source: AGHT+IHirDaQWzpTxyuJ8inNk7L3Lnf4a72Z3LpjhwZGJsvcrHD8ipWwrZSFU+oAf+U5rOdGOIt87Q==
X-Received: by 2002:a17:906:30cf:b0:a68:be1f:de10 with SMTP id a640c23a62f3a-a6cd7a84263mr165413566b.34.1717759425564;
        Fri, 07 Jun 2024 04:23:45 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c80580f71sm233165266b.26.2024.06.07.04.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 04:23:45 -0700 (PDT)
Date: Fri, 7 Jun 2024 14:23:42 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Martin Schiller <ms@dev.tdt.de>
Cc: martin.blumenstingl@googlemail.com, hauke@hauke-m.de, andrew@lunn.ch,
	f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 08/13] net: dsa: lantiq_gswip: Consistently use
 macros for the mac bridge table
Message-ID: <20240607112342.hn624mbdkp3etmvb@skbuf>
References: <20240606085234.565551-1-ms@dev.tdt.de>
 <20240606085234.565551-1-ms@dev.tdt.de>
 <20240606085234.565551-9-ms@dev.tdt.de>
 <20240606085234.565551-9-ms@dev.tdt.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606085234.565551-9-ms@dev.tdt.de>
 <20240606085234.565551-9-ms@dev.tdt.de>

On Thu, Jun 06, 2024 at 10:52:29AM +0200, Martin Schiller wrote:
> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> Introduce a new GSWIP_TABLE_MAC_BRIDGE_PORT macro and use it throughout
> the driver. Also update GSWIP_TABLE_MAC_BRIDGE_STATIC to use the BIT()
> macro. This makes the driver code easier to understand.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

