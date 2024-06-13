Return-Path: <netdev+bounces-103192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 421AB906CC6
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 13:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D6FCB2545A
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 11:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113E614430A;
	Thu, 13 Jun 2024 11:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VIsCD5+G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660971428FC;
	Thu, 13 Jun 2024 11:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718279432; cv=none; b=QbDsp59KWBeDhUDtS8QVamh+tW4SETN5DPLSeDK1d+DjgV2Ymg0Shj0VlaTh6Abkm1Gsb/pRW8Cp4vWW3bPHn/q6KnV/hPGH8z7InL4MdSDv6ejnbmhQq18iDRypmBDFPqqly0Zx5CKunkftmw/mcI/BLmeTEvsup9XekuT4ySs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718279432; c=relaxed/simple;
	bh=cuDAYDRpgKBgvveJPHQpekBSVAZphUGu4rY+rzPtza0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qUP9uOXZs2pjg5zAIEiuDOcfkdfIocLvULiWYSz6Em1pVeQVmZkWiAY9LHhWiSwJYWPlCceLqWw1tUzm2wt+eDz4ybhhnFcfP2W/Hjxdr7fAduUG+hF7xu6pmLAirhPPiwx0dcZewlPy2wYr05WU28mOAW54TdNbvKg3X7PxRPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VIsCD5+G; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a6ef793f4b8so103504366b.1;
        Thu, 13 Jun 2024 04:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718279429; x=1718884229; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2mzNTSAFdhxdZBP4YhWh4ayQRjsQOOmjzP+ZYg1zBG4=;
        b=VIsCD5+GBBY62LXppfEuepmZ5PatQGMHp4mOm0BTY5RzyczYh4GIe4k8yTwGz/8G61
         h8psFLelRAZuSJGs7eqYOIOPoQ3JaOFC+rZBz1KoDhwP8EOfzxUzirPKnSAw+VXv5AtE
         bvaYhRcA+Gx9E7GNrcoEP2XPKmd4qNEsXW4ARvgRyKBFVIjYODCYe3TchscFWFXuwr8Q
         vM+h4B9EW+MhEA9Y76TvtxS77Sh3khusxJUyig9hIc9UY/5W4t2iIjWb96uRYfzPUEHv
         a+ykilfhZ8bFzR6Mi7h1VH4BIaYVMKKkNnS14vmC7/KhOCc4dlsigIWbxtaoKpIFDAGs
         ZjWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718279429; x=1718884229;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2mzNTSAFdhxdZBP4YhWh4ayQRjsQOOmjzP+ZYg1zBG4=;
        b=TWFlkH5g5SXcApM+wUW7ROGpYbGG7pxpyvT0NaNuRehyW/OO2pRJYPSrtOX/eNRSzc
         YJKYPVHS1zoHsv4tgmkWFBYgsQ4I9fGtWMvNkfWthif3vJfZbEvRdazD/0AlAyroA/zr
         ou2daqRGiShRDlEfrnYl71Br/YDAltPzlmgJGkKTegLnfU+FEBtRkDy6jHao5i5t+mCZ
         CTvI3rYo0n7yYVWYQWrl4mLUlvoFK+fTgnFf8KyF3T4VN1fhy0AGoocNHJJIYLTL9FMl
         U70xbvhm6FLQR7zPmxRoC0xinr3n9G26JHQ0zl5rN19JgDoQEUVCEppIAzKhqT65lh8n
         rlnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXA/E4AYuteC80iGzpwmKTnI1qiFuFDeuLQccAfNKms6NaCoT81CdliKPlrgnuFyn9ZL4z9VoYfMCsubITWwkOoUR64gG0Y2V/S/NtCAxTzI/GxN7bn+kbPr7OTaGs8aQ6CFBBR3V1Ktrp94Dvg+5io2AV7QfIyC4y7ig6vWxR10A==
X-Gm-Message-State: AOJu0Yy3bC1UvmoN8c/5kjidjclOnmg+jHVylIiUDIzGTY/GWiFWCMEr
	/fIPoqwYvqnXttOFgBfoRZl6lNbavO2muMsagOYYR40ONCuGzjEn
X-Google-Smtp-Source: AGHT+IHYFnmNJYoOzcg6Gs1u0xP4vzUOCzupuQwsJKi8ak72aleSwHXeg3/eztgg+ZIP7pYRUSi0GA==
X-Received: by 2002:a17:906:7f19:b0:a6f:5957:7b9b with SMTP id a640c23a62f3a-a6f59577de3mr78886466b.51.1718279428445;
        Thu, 13 Jun 2024 04:50:28 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56ed379esm64929366b.139.2024.06.13.04.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 04:50:27 -0700 (PDT)
Date: Thu, 13 Jun 2024 14:50:25 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Martin Schiller <ms@dev.tdt.de>
Cc: martin.blumenstingl@googlemail.com, hauke@hauke-m.de, andrew@lunn.ch,
	f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 02/12] net: dsa: lantiq_gswip: Only allow
 phy-mode = "internal" on the CPU port
Message-ID: <20240613115025.2ogzag4p3gp7xf6n@skbuf>
References: <20240611135434.3180973-1-ms@dev.tdt.de>
 <20240611135434.3180973-3-ms@dev.tdt.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611135434.3180973-3-ms@dev.tdt.de>

On Tue, Jun 11, 2024 at 03:54:24PM +0200, Martin Schiller wrote:
> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> Add the CPU port to gswip_xrx200_phylink_get_caps() and
> gswip_xrx300_phylink_get_caps(). It connects through a SoC-internal bus,
> so the only allowed phy-mode is PHY_INTERFACE_MODE_INTERNAL.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
> Acked-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---

Similar thing with the sign off here, and there are a few other patches
on which I'm not going to comment on individually.

