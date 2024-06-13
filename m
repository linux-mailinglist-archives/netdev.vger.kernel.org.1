Return-Path: <netdev+bounces-103199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 087F8906E16
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 14:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 982DFB24136
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 12:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB77145A06;
	Thu, 13 Jun 2024 12:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1OeiUEZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F0314386B;
	Thu, 13 Jun 2024 12:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718280145; cv=none; b=jB19DsYCYl8PkV6Sqmz0wpPJmO+dtV+ijtF9OtC5ljXrAtvbDiWBPvKXeL2S4ktinyd4hwUzrGbSShtX0rqIJq40EpLAqWb4ikJLjIa+Y3oUWzhkqo/uzbMrjpSRjmYLRS6suzdhvO3+HY00xxiLVFNJEF69SPC7eIsy3mhBHSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718280145; c=relaxed/simple;
	bh=qS/QOH6yJijp+eK1nFIeOEOD0OR6fVC/5+/H8ohrMtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ISVvOBpVzyI5jVdKurVdWbmYnG+bXtLfuA/jfplOzSM/1+4hUoNWUNbPbfZGw5guYiNV0tjrH3IN+TPMFl1Q3b2pfxk+Mjc10W1WLJuAsRJ89rY38v9bF/xu205vme0MHO4KU/skOPHs2wL0q4lMwhn4up1K5jkQeakTpwLjVsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T1OeiUEZ; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-57c68c3f8adso980730a12.1;
        Thu, 13 Jun 2024 05:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718280142; x=1718884942; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y9PvvqPgKOXCPbOZfATBsjBIEGefCubkdSOft2h04w8=;
        b=T1OeiUEZIqWCND74cevukEzUvpsjn8xl2F7qnK6YMm3wSkDmbnmwr5/hKIInFNzueY
         7ULMc44PmzUzu8UWvZeQ0IQDl30kLcbiwUxtL852E3EYpgTrllhpr5h1/5qDNyNRlyd9
         Z9CUizBgVp7l/a+fdxZxn68x60biMH/UpkjB3MJAtvIWv+b63YgW4jGhnwHW1tZAkWpf
         Y0j2uKw6FLo8WZ2GTqMIE8YuGnkPOqkinovl8716L9imZWJtm8Qnz7pgXnUBdwbx8jdh
         7SmAwkgmZBeQnu2mluot7WlSJVJxNlXAQVVdDl/KZdvgqHptwVWA3CW5XwO223tQjX2I
         bB9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718280142; x=1718884942;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y9PvvqPgKOXCPbOZfATBsjBIEGefCubkdSOft2h04w8=;
        b=QxWLFxQ+zxadJ7/hmy8OowFWxIJCtvhhJmJ3t6Vx1Rxg89u60xzhQw64lnvEP8wRYG
         +8i6JtJpOoEmdvBpw3DBPUszA4xcpIug5txEGFjSmMgpP4CsSYaxyxdAVbJpAoEYM0eT
         glFwlKBUbqqx8TZxINniFxit197CxRCT5Wp32ExaRvGI1NMC1lWzS22xpqNuZgTyc1dV
         2bUfU+9oDdO521cBCcUEbUzFYoN3/pecDuz2Rxjv4eIV5G1FS/RKzgSClIY7Zv077vWZ
         njMeDxG+GYl3XS4I1oViutSoIAVS+PqjwCbQHJzmaNTV5XVahAc6pkbQpvTftVxgIixP
         QEhA==
X-Forwarded-Encrypted: i=1; AJvYcCXrBQ/3OImUrxrBv83lHGTaCKcqIIp2tMi9Qj5JQj6pfupwTZs4h+sDc8rIfLbOfaAbV1Dyzm0gQyr+9FErBVFGoP30DVI9cWP/gAa58khbUfjeap8c6SVs9bUscyW0E8pvq8M6mAPPRNzjmNR+BnMmWZFCy/j0Qe7dyJWnOLLNaQ==
X-Gm-Message-State: AOJu0Yy/X77OWZ1R577Z5WlZuS4jgHBXVEJU5IoD3K9y4feV1K+X4whE
	1SfvaUbwMvoNIeNuiUmfCL7PXEYp9iQOqAUfj/NN7TMV7UwQz98W
X-Google-Smtp-Source: AGHT+IF941TAkX0XPkVAZpi4Ynl11V4IPbmDBSA+Fo2QUfhVEy+xEOMgvP1wLvVtlNXcZxDPtnUQiw==
X-Received: by 2002:a50:8d52:0:b0:57c:55f6:b068 with SMTP id 4fb4d7f45d1cf-57caa9bee1cmr4116345a12.32.1718280141816;
        Thu, 13 Jun 2024 05:02:21 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb72e9dd7sm824738a12.57.2024.06.13.05.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 05:02:21 -0700 (PDT)
Date: Thu, 13 Jun 2024 15:02:18 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Martin Schiller <ms@dev.tdt.de>
Cc: martin.blumenstingl@googlemail.com, hauke@hauke-m.de, andrew@lunn.ch,
	f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 11/12] net: dsa: lantiq_gswip: Update
 comments in gswip_port_vlan_filtering()
Message-ID: <20240613120218.yem27x7sf3yld3bv@skbuf>
References: <20240611135434.3180973-1-ms@dev.tdt.de>
 <20240611135434.3180973-12-ms@dev.tdt.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611135434.3180973-12-ms@dev.tdt.de>

On Tue, Jun 11, 2024 at 03:54:33PM +0200, Martin Schiller wrote:
> From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> Update the comments in gswip_port_vlan_filtering() so it's clear that
> there are two separate cases, one for "tag based VLAN" and another one
> for "port based VLAN".
> 
> Suggested-by: Martin Schiller <ms@dev.tdt.de>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> Acked-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---

Needs your sign off.

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

