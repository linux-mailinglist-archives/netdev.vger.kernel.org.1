Return-Path: <netdev+bounces-115498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F91946AD1
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 20:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94A2BB20EC2
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 18:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFBA518633;
	Sat,  3 Aug 2024 18:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="LkEh30BK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F271C182DB
	for <netdev@vger.kernel.org>; Sat,  3 Aug 2024 18:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722709468; cv=none; b=VBx4QH4DJvIBxx2PnVFV5Cyc4dDinNvhiKs86z4U9UHV5ay2edEJw4n4vo8xupwHyfzOHiLfOc8dITAyhMLl2w07I4xEo5pZzQZnXeeHaDgUt4FQnd7QAIPu6iJArXRe+Bx5Jdwq+mrvgfwTQqZpZ+upf/MPYG4m035BsSkoh8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722709468; c=relaxed/simple;
	bh=ME+s3gtFfKN8DN5rKo8+CFG5vjgjAY/BtPYIP+kKzVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CDJi/8v5710Vzq3ftnUREwk4KwyzWkBA1X5R15ZFMrg41xBqjTFXxlx6HfjvpdxfNzIEYDlzEZma5pNX4UhRPMPCZLd8fetU575cJLnFcSWbzhLPHtniuDaq8/saIsAbyjKS53jPAl2doaL6aHeHEUiw8HpzmlSMUx3/b91acE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=LkEh30BK; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3684407b2deso4784743f8f.1
        for <netdev@vger.kernel.org>; Sat, 03 Aug 2024 11:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1722709465; x=1723314265; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zBr5WkXrSporzFvj7+ZgDq7NawA3CvOoBxGxQfbusJ0=;
        b=LkEh30BKYNtdZFESx6+azH3OnFHKp+fegDZXkqECfr8WYDy/R/7T4ZH8/WPb+9Jnop
         nzs4TWWznJ/KdhkSBWkkO0NIK8BzMuU+h4V+Gxi7tLO9R3b83mo1+K/kFbUT43VGqzaA
         Jd4e/nsRaKcTbvq08GEjGhBkFKP+XncHb+ghk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722709465; x=1723314265;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zBr5WkXrSporzFvj7+ZgDq7NawA3CvOoBxGxQfbusJ0=;
        b=xGNqZ1LzeB2cTW/isA9s2XutcDZ/1uJnx9rtHyMk/VGDyVUBwhzIMoLukfjkESZKmJ
         3L+SSnWeqG3O2QeMNpi5fyO/ikel1LS/6y7NhxJQAGenzFvj2irPSUnRQIa6kXF0WRIE
         wMLtPyBsxncZ/aVeiasJN+frlUj1bNV7nGsz8vz2hjtas1IenpADqRoPwQQRDNVxlmrt
         vZQkRtU6BSjaxlu457Wtaf+ZvQpkqsc8SynwgpE6bK+WDFuUrj5xllLe68lMdTpkpnwl
         bCBwMvrxa8EEz/KDjHoqYH2Tmtbt2CmygPLiQ712ZzerzQARKagS2bx/OctsFOFdYJj7
         KbUw==
X-Forwarded-Encrypted: i=1; AJvYcCX1PCsxyFaM+RRCDUfCCsl1+jC3k44o3EdIttv0edDmnYG9L0oNyEY3safVA8Wgo62AijIS+88tOeqQh/WpifLQm3OBw3KJ
X-Gm-Message-State: AOJu0YxqtBhR28BCPEOsaQqQbU+sylIUDOltRgT2UlB7NRY18bvk7zsM
	JtFRdONnMMUCEKx0B5oEgkkPRu5lRBOX6adN6P05pKG2FWsMDANSpzrKhBei6Kc=
X-Google-Smtp-Source: AGHT+IHphvNOr3PmHSRqxafkCHOEE4+pj2H36XGf0P6nTTSTmVyDJzJKoEMLiH3uYSta0SnTltHF3Q==
X-Received: by 2002:a5d:6d49:0:b0:368:36e6:b248 with SMTP id ffacd0b85a97d-36bbc0cc71cmr5215008f8f.23.1722709465074;
        Sat, 03 Aug 2024 11:24:25 -0700 (PDT)
Received: from LQ3V64L9R2 ([2a04:4a43:869f:fd54:881:c465:d85d:e827])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbcf1dcdesm4912713f8f.35.2024.08.03.11.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Aug 2024 11:24:24 -0700 (PDT)
Date: Sat, 3 Aug 2024 19:24:22 +0100
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, dxu@dxuuu.xyz, ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com, donald.hunter@gmail.com,
	gal.pressman@linux.dev, tariqt@nvidia.com,
	willemdebruijn.kernel@gmail.com
Subject: Re: [PATCH net-next v2 11/12] netlink: specs: decode indirection
 table as u32 array
Message-ID: <Zq511qMYE-OFqkPc@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	dxu@dxuuu.xyz, ecree.xilinx@gmail.com, przemyslaw.kitszel@intel.com,
	donald.hunter@gmail.com, gal.pressman@linux.dev, tariqt@nvidia.com,
	willemdebruijn.kernel@gmail.com
References: <20240803042624.970352-1-kuba@kernel.org>
 <20240803042624.970352-12-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240803042624.970352-12-kuba@kernel.org>

On Fri, Aug 02, 2024 at 09:26:23PM -0700, Jakub Kicinski wrote:
> Indirection table is dumped as a raw u32 array, decode it.
> It's tempting to decode hash key, too, but it is an actual
> bitstream, so leave it be for now.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  Documentation/netlink/specs/ethtool.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/netlink/specs/ethtool.yaml b/Documentation/netlink/specs/ethtool.yaml
> index 4c2334c213b0..1bbeaba5c644 100644
> --- a/Documentation/netlink/specs/ethtool.yaml
> +++ b/Documentation/netlink/specs/ethtool.yaml
> @@ -1022,6 +1022,7 @@ doc: Partial family for Ethtool Netlink.
>        -
>          name: indir
>          type: binary
> +        sub-type: u32
>        -
>          name: hkey
>          type: binary
> -- 
> 2.45.2
> 

Reviewed-by: Joe Damato <jdamato@fastly.com>

