Return-Path: <netdev+bounces-184149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6A7A93808
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 15:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64259175F7A
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 13:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915EF278146;
	Fri, 18 Apr 2025 13:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YpoYy0pU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC34720767E;
	Fri, 18 Apr 2025 13:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744983456; cv=none; b=atrdjbmf9PkbH9AOoHHIajb23Ag8FCX7OMBEb1Gx4e9GwALC/B4Y3Jzm94H+cgsJOaMq/GNvQQdkwECatfgof14NgleZY9bVYWPZoNOajWwk1VAqvGmMdgfjG/Pz4/ErgeRe0LYttB4wPk+c44DzDfncfLnURdg61EX6qZmbygg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744983456; c=relaxed/simple;
	bh=Hxo9zaOPkXdZykBjxIAn9bbpS7iZhDxl9xQqQQ8hkng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rRrvhERF+klALsvz5ZIT59uCewjbygctVy2KPJvcdr8763hyNFLGGl7Gbhr5nuEqeAGzgPE8YlM+47kKga+VEzn+wfJrUB+IAFNplYSSeyZzCSjI3fPmiS9tM/0PNtX5UssVbGpXG+cRRDbaiN4cCQsUjUKdrdC+bqbM23jjDWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YpoYy0pU; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5edc468a7daso284072a12.2;
        Fri, 18 Apr 2025 06:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744983453; x=1745588253; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yaVB0jzsgxgFF8kGT+Ni2eZz8vIf7WxRo6XWKmn6f+E=;
        b=YpoYy0pUrkqd1b4ndgFMMzwA8OVwwDVd0LU1gFTm+4dG4u7uqElBoQbY2yZYodkl0J
         Wh6xXBWvbd1T6ZDTj4/A/6M+SyxEP8oqH2ipqMgZpXfsLYFvBFyxgQq30mpv1MejSPIm
         QfcW5SS6k7ZHHQLLADGbxfmUwGjJUyGq9Kr5wqa0Sy2tiBpvh5qhnb4ex8+dh0tzxQ3g
         Y7Unb0AbUZK09An62llHUco0rShbZTH1HtY46EhdcC2wakAmVAKS0xtg2cHxlDN/ltnT
         xm8dtLTl036d75WbYFYi0Rg+EvEImgmHw2/4jrhkH4QWEQgKwSdZ26jRHkGt9/L97jik
         GlSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744983453; x=1745588253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yaVB0jzsgxgFF8kGT+Ni2eZz8vIf7WxRo6XWKmn6f+E=;
        b=K5z6eDQ+06T/fgqkENM3kiPi13NTrZ6iwY625uIu2OtGjfyuY6DByqZwNtYNnhebPk
         +NOSKbhCsKBLUMx0pBCPFBWPv1lqKFPOEKG1G41ksSMoVt+bDG7FqXjVRjpgEeGVxv4g
         QkGGgsm9A6RhjA8cP6f16N39i183Eexm55WHPKW6iF1QeSwBJt7FMvMGroLtIcRAHyVT
         2nylCYg7HPRvZhj2ONNiGYKKsCqmULlzTp4tKcXzcVu8YQCQM2GwNRAn3XNcf0Qfu4ww
         tupexUVORfJWMxerMq0NTTYCDsnmVJT0fgjLumLYojWc8FaRjD+QrTnzzVQVoG/ii3Lp
         +/Sg==
X-Forwarded-Encrypted: i=1; AJvYcCVqG95ckgPkG6AGR5nTOj9ZJScE5OOWwuJw2o/7zQQl9WZpEEp7NW0Ve8rBcuoq6iwLJl9jtFrn4YW1ySo=@vger.kernel.org, AJvYcCW+M5c49SNx7QN7lZnPQyxfipWSVe/V4SVBRGGyC0/NPLv6yB1spNnUvR5wfVdsZFFxa7ZlVGeP@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5Rl7tZTaZAZPrXkKHEqj6osmt441blfGtCzh4dhY1PVxOWF/+
	/TYRFS6+TI7edFoF2trMqa6AnuexKi8Yh0acAFI43XnBEiakWyeQ
X-Gm-Gg: ASbGnctw3uv2kCEAxj4cj8yksWDvb8qGczQNydmglxF3nOaCHqjdoInuukKNi1RAk0X
	KoHZ+e+VpFVEtUiswQq40+v47adQJCz4y3wjdLTevhINfVoksU/THDaJFYeYjSGOuKQJrXkZF9s
	lZv6PxipoExZ1lhAM+zhHbf3zwg/3NaYIxyS9A54mPtexdk/Ib/xSuhRcBIeZaW7vlYmvrL05hT
	/xsZbfHlqvTxfCL2RLv92BzAz8juHTuTBre8MjcPF2+NZg1YfLCQThsSjaa2mtRwc4TXn/jAeX+
	82vcic57RWxgtw5SpdQJnPxdQ4b0qf2sXqGHnYw=
X-Google-Smtp-Source: AGHT+IHDLcatUwVL3iYay48R00vjtUcVAnpAwx2hlm/q6/jMDb5Q5PmviuzfcY6HTPtV69wle8gO+Q==
X-Received: by 2002:a17:907:1c0c:b0:ac2:6d40:1307 with SMTP id a640c23a62f3a-acb74dba1d7mr79825366b.13.1744983452751;
        Fri, 18 Apr 2025 06:37:32 -0700 (PDT)
Received: from skbuf ([188.25.50.178])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acb6ec4f6c8sm123584966b.64.2025.04.18.06.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 06:37:32 -0700 (PDT)
Date: Fri, 18 Apr 2025 16:37:29 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, christophe.leroy@csgroup.eu,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 net-next 03/14] net: enetc: move generic MAC filtering
 interfaces to enetc-core
Message-ID: <20250418133729.ul4ocm6ie7b4my3y@skbuf>
References: <20250411095752.3072696-1-wei.fang@nxp.com>
 <20250411095752.3072696-1-wei.fang@nxp.com>
 <20250411095752.3072696-4-wei.fang@nxp.com>
 <20250411095752.3072696-4-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411095752.3072696-4-wei.fang@nxp.com>
 <20250411095752.3072696-4-wei.fang@nxp.com>

On Fri, Apr 11, 2025 at 05:57:41PM +0800, Wei Fang wrote:
> Although only ENETC PF can access the MAC address filter table, the table
> entries can specify MAC address filtering for one or more SIs based on
> SI_BITMAP, which means that the table also supports MAC address filtering
> for VFs.
> 
> Currently, only the ENETC v1 PF driver supports MAC address filtering. In
> order to add the MAC address filtering support for the ENETC v4 PF driver
> and VF driver in the future, the relevant generic interfaces are moved to
> the enetc-core driver. This lays the basis for i.MX95 ENETC PF and VFs to
> support MAC address filtering.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>

