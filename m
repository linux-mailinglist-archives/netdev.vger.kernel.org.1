Return-Path: <netdev+bounces-115738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A604947A58
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 13:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45E041F21E11
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 11:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22B014F9F7;
	Mon,  5 Aug 2024 11:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7+kNyfz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F278B1547F2
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 11:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722857134; cv=none; b=RKQvo7JHjruF+aeteSa1m0Vv5mlgob1NyzRI2efGSk+n12AfsowR82UsX7YoJIKAxv8P9ufnlkCf1rSYWo4kzUho6k6tvQruyaA97RlqZ7xmcd/Ziw4w4n0MoBSLkkX+8UL2b9S6e2WMSiQZgeiJVTrubQv6+kktjJRuhY+Hbx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722857134; c=relaxed/simple;
	bh=ed0nQiprdoPexNWIX0wDrZjN9TKWO99DvxxAGrqgR9c=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=oSEL+XMBUOuwnN4tvzzxHsIMJW/jvwepbcangVcNrv2t7hIRMhf7XAEL0MsbXNEPSFa/LHAjRbzVJ4VVA/L2MXwR38pKk5jdxJqy3+Y8hWDNRuvy1/5gfW1whtYOK0OyGS2jMCTOKMoGxU8IkyvYJwWxQcfpc2ADWUODU5E1eQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G7+kNyfz; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ef2cce8be8so126327181fa.1
        for <netdev@vger.kernel.org>; Mon, 05 Aug 2024 04:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722857131; x=1723461931; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ckVu7CFVj/Jw6YS86+5+YO2rkMxdIR/6D9qrpfbKDCk=;
        b=G7+kNyfz3UXdg9lxWH5wx0tVw/m382/WcdYrUkArZj4MBrNwrqMIf7G4MpOR+NrCGw
         bYJSID4DwwtyhdhRn7MfUC8Rw9h/IFVFJFooXVv3AQSu4+kYU0VG7x+ySn6aAOQXA+X+
         npw8Dq/jEZUA/Icjvq2YEbTj5jJdblszRCW6eJFq0b7StKFwFgh2jMd4vTx9B8HoBFh1
         T7ep9pgYJrQLiC6363899h4OmABkeyWUb7l9R+H7GKGM4MHTwfynoYaZ6Vvc6IxcOrXL
         5v1r43aF/3n4lX8leyEAYtMfVFPTOL0jw8R5QfTr9IpGtXyGbajv+1sXJIIHv2PazZGw
         /CBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722857131; x=1723461931;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ckVu7CFVj/Jw6YS86+5+YO2rkMxdIR/6D9qrpfbKDCk=;
        b=GC6IZO+TEgNz4WZK07AxuSFAJz9IptisE2F9cwcsWI8nUn2/tkND3gExYyu6XE6hDH
         a9u58EgGTiulgqZop21IbrO9oHHP+OfypWBDZ1+l5hBD7eZFe+inB4rOQVIx5EQUNRFI
         jVlYXtWpBLeGKEFOj8/AF3+UiR68XhLwrV53Fy8ILNMIzVuKCku1m4JTvt7zIfaNJAoW
         jKFgv792g9U+Ig1NVsUhUuaaG0k4RnQlsG7RoIRySLEzd+rfgOAPBzXQtU3apS/RZQBj
         qE5Si5k7zjFe1w4M60pYziUpWadSu3ov5jVr1H2C1Id8ZioFYSlCziLNzdU0YgtIqu6A
         n7uQ==
X-Gm-Message-State: AOJu0YzCoqa/cl3gTZpqfVuqfmeiCsPHALev2vNVJiI8LiXZ/CwG8c0C
	TirRxw0yZZPN8MuV6MeK65lAyfq4YAdPuRYIg7nFFivXFFM4Sd9t
X-Google-Smtp-Source: AGHT+IFinJrDAWfwk56vsBegQeJNuchtu4pK9hI72b5pDcmrha2iKSs/H85847lQ/DHLCe7o1ePj/Q==
X-Received: by 2002:a2e:8609:0:b0:2ef:2332:5e63 with SMTP id 38308e7fff4ca-2f15aac10f8mr93178041fa.23.1722857130595;
        Mon, 05 Aug 2024 04:25:30 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e6e4f7bbsm135445685e9.27.2024.08.05.04.25.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 04:25:30 -0700 (PDT)
Subject: Re: [PATCH net-next v2 02/12] eth: mvpp2: implement new RSS context
 API
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 dxu@dxuuu.xyz, przemyslaw.kitszel@intel.com, donald.hunter@gmail.com,
 gal.pressman@linux.dev, tariqt@nvidia.com, willemdebruijn.kernel@gmail.com,
 jdamato@fastly.com, marcin.s.wojtas@gmail.com, linux@armlinux.org.uk
References: <20240803042624.970352-1-kuba@kernel.org>
 <20240803042624.970352-3-kuba@kernel.org>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <1683568d-41b5-ffc8-2b08-ac734fe993a7@gmail.com>
Date: Mon, 5 Aug 2024 12:25:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240803042624.970352-3-kuba@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit

On 03/08/2024 05:26, Jakub Kicinski wrote:
> Implement the separate create/modify/delete ops for RSS.
> 
> No problems with IDs - even tho RSS tables are per device
> the driver already seems to allocate IDs linearly per port.
> There's a translation table from per-port context ID
> to device context ID.
> 
> mvpp2 doesn't have a key for the hash, it defaults to
> an empty/previous indir table.

Given that, should this be after patch #6?  So as to make it
 obviously correct not to populate ethtool_rxfh_context_key(ctx)
 with the default context's key.

> @@ -5750,6 +5792,7 @@ static const struct net_device_ops mvpp2_netdev_ops = {
>  
>  static const struct ethtool_ops mvpp2_eth_tool_ops = {
>  	.cap_rss_ctx_supported	= true,
> +	.rxfh_max_context_id	= MVPP22_N_RSS_TABLES,

Max ID is inclusive, not exclusive, so I think this should be
 MVPP22_N_RSS_TABLES - 1?

