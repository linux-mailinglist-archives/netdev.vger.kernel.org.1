Return-Path: <netdev+bounces-175805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 133ACA67827
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 16:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FD271883845
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 15:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB91420F065;
	Tue, 18 Mar 2025 15:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="y4eREmwl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7A328FD
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 15:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742312590; cv=none; b=uLe0/62zTcYCzXQoVyquoPdQJyZC1Bz9pU474FhdTQFopjlvL+k4RmPG0+XT+OH2w0W27tDxGMRYCQ+Ut/ZlC/o5Ag0GCrh8QlD8B5YNq8LbKvZZsquBY1rnLsEwgdPUE8ZDFpx++xALNsi5qnyjMdRCH8AA/J46ioAuJkzZ5e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742312590; c=relaxed/simple;
	bh=d435AHZtuTLEGL1nqnjHLieFtvDf9lop14Ye+nMsIDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cDcQO5r9S+qIcMZynqBQCzIlu85IU6kSQz3i1GZ6kuMY0XtVei8kiB5m+roIfZZ9QFL71/F7LHWep38TTlHhYm13Rs43tSYCrAegTf19c39TAMsxmtb1DP7jqirMOM+cHtPo0kbNePMSSTQrYSYKU/95joIfh2/lE41N0PH+Ir4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=y4eREmwl; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4394a0c65fcso32543685e9.1
        for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 08:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1742312587; x=1742917387; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T2msgjxCz2DcPYQE12074YoE2WnARoI0a5JesfxOEjE=;
        b=y4eREmwlk1oO8/rsvaQM2yPukGtp6mqy+H4rANURxdOLqr7TlqCAb6P+VsPHyws8vi
         qadOFNbty1bvhT+OQIlpASQAMZpYPS2+zg7QxRwF+0/TwpMgOays+sDopwAu4z85WzPZ
         TX8aoB/4b95A3GUzGxP8dZYmM3yGCUOfva6M4abTviw2mtcgpNoWiSW5fo2wnsZgox/z
         3Ldk26Z+62KItJIElqte2w0H+Dd0UKajZfwD5u4WgcJ7o74Rmb/4T2SSFOGGES7d389H
         D3y48yAQ2ZmdKwNc+vrNoYLlMjfRqiIOc9TYCxXyJDidZKAvVNHjdg8a1tWWKXl6bR9C
         45Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742312587; x=1742917387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T2msgjxCz2DcPYQE12074YoE2WnARoI0a5JesfxOEjE=;
        b=MmMVyVeBPuaEnp/RVkI2aXQcNzF/+FVXlkTxIGqlqkzr6j+93HgRXkWgBgvnzQCgRN
         HLvctadnapNmUQAiC0wQi6GqotVLszL/gd9D7hZE0w7s+ygkno64HPuktin8VRAfyxvm
         dp0kX10bpHqgtSRbBLYD5OW3ViWhjOYg09me9k9UIICP9jh/tIz913J2IWeMl+f1/cfE
         9nplv4xvst9F60ADObZp52cXj0l/m3KGt2YEfJmGW/CSvg2OpPinudzaXEVllutZAN8y
         nRRSiXKpLWBJCAGessq7rxPD9v/YJ/Za6EZRqNlJKF7StQ5iATe3br/xEHaf8o8eEzvq
         cBcg==
X-Forwarded-Encrypted: i=1; AJvYcCUhHLAvZePOfn0OsnjPmPBF87i0mYjNFMpHkgxs8SpF0WSi1B5if8esK6hxfRVLZWhEN6NTqH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyptGErdnRdC/96xCblUULxd6nOvYnS1zS/33BSjEt6Wc/tu2uE
	C6uN5iLGVbKEElDP7ea/IJiTyOe2I0MSkHCm4SeBlXGFTJB4sQodFSAGlztfh+DNjSejB3oS50X
	J
X-Gm-Gg: ASbGncuzt/FaAtzNO7FMdjmtzenkBjk56CtLztv4azWK+/UH0LJOOkkx2Ief/MmX1zC
	RyzGWzugDkXrsnWxYv/2ADSeg20Vqgt5ztzom4BFR10gvFNYksRcm25nXwGV9/h8F6K+7yv3jMW
	Ts+DWCHYFAPaJbAhDwgaOTN90jQrG+xoq9hHHZkdQKNbPYjsfvdoHbTJcLr5wKhbRkA37+rmym7
	9NJPIZRvn5I1963ocJ+Q6Kl0u9NmlakAaKWCGrPo7YrFHcM48uZ4GJ0uNlXEr98ZxB5aM1NEElz
	Ucmepy8bUNLM5TCa+/vsPXv7bqZHz/rRVu/bbGswBFKLYFg5hwbzYA/YYtE+L1SS96vQoHmGOdU
	3
X-Google-Smtp-Source: AGHT+IFYgyumGr+fp7DYJkr3lnZZ0Wg+ROxQga4Jqlf85DUT7rg0dECXHPfzOdbnhe950EIsNaSwng==
X-Received: by 2002:a05:600c:46c5:b0:43c:fb95:c752 with SMTP id 5b1f17b1804b1-43d3b9620ddmr27754325e9.3.1742312587310;
        Tue, 18 Mar 2025 08:43:07 -0700 (PDT)
Received: from jiri-mlt.client.nvidia.com ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d1ffbf901sm136872725e9.15.2025.03.18.08.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 08:43:06 -0700 (PDT)
Date: Tue, 18 Mar 2025 16:42:57 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Jakub Kicinski <kuba@kernel.org>, 
	Cosmin Ratiu <cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, netdev@vger.kernel.org, 
	Konrad Knitter <konrad.knitter@intel.com>, Jacob Keller <jacob.e.keller@intel.com>, davem@davemloft.net, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, 
	linux-kernel@vger.kernel.org, ITP Upstream <nxne.cnse.osdt.itp.upstreaming@intel.com>, 
	Carolina Jubran <cjubran@nvidia.com>
Subject: Re: [RFC net-next v2 1/2] devlink: add whole device devlink instance
Message-ID: <olhqg2npoigaebjnwp5ddqoaegnafizk7jrtshs44v7ytrai7x@6yhpydbawdwn>
References: <20250219164410.35665-1-przemyslaw.kitszel@intel.com>
 <20250219164410.35665-2-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219164410.35665-2-przemyslaw.kitszel@intel.com>

Wed, Feb 19, 2025 at 05:32:54PM +0100, przemyslaw.kitszel@intel.com wrote:
>Add a support for whole device devlink instance. Intented as a entity
>over all PF devices on given physical device.
>
>In case of ice driver we have multiple PF devices (with their devlink
>dev representation), that have separate drivers loaded. However those
>still do share lots of resources due to being the on same HW. Examples
>include PTP clock and RSS LUT. Historically such stuff was assigned to
>PF0, but that was both not clear and not working well. Now such stuff
>is moved to be covered into struct ice_adapter, there is just one instance
>of such per HW.
>
>This patch adds a devlink instance that corresponds to that ice_adapter,
>to allow arbitrage over resources (as RSS LUT) via it (further in the
>series (RFC NOTE: stripped out so far)).
>
>Thanks to Wojciech Drewek for very nice naming of the devlink instance:
>PF0:		pci/0000:00:18.0
>whole-dev:	pci/0000:00:18
>But I made this a param for now (driver is free to pass just "whole-dev").
>
>$ devlink dev # (Interesting part of output only)
>pci/0000:af:00:
>  nested_devlink:
>    pci/0000:af:00.0
>    pci/0000:af:00.1
>    pci/0000:af:00.2
>    pci/0000:af:00.3
>    pci/0000:af:00.4
>    pci/0000:af:00.5
>    pci/0000:af:00.6
>    pci/0000:af:00.7

Please check my RFC attempt to solve this for mlx5:
https://lore.kernel.org/all/20250318124706.94156-1-jiri@resnulli.us/

I believe that the same could work for you too.

