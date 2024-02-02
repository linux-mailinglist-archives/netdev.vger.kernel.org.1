Return-Path: <netdev+bounces-68317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD166846932
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 08:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 719EC1F234E6
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 07:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBADB17994;
	Fri,  2 Feb 2024 07:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="uW0kwOv9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA67517C62
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 07:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706858613; cv=none; b=k6oHcLIEvz0Trkjp16o3ElNZr55Ko+6j8oBi80IQ55rP+ZmkW6v66ULMpZTzjhDa2rNUiLeZyjVYj1fAhkNfs/GZFCgtr4LMMaoMZZLIn0pSxPI1lUtrOrxTPko4qSaTe+y+d0smIMVgGltDdWs9U2sARS83g29zmps2UI0k900=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706858613; c=relaxed/simple;
	bh=FKYeyb5r+mQMu/bTvkzq/zXSluKwypESmMB0zIXlNXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q9abWle2rvjMueMDVwB22zZUKPWPN7Ih99cJv4Ws+x3iTCvltOz74PN482auEHKO468FGy96gZgBiDIcT7t86sFOlkkBb3vP2wwS7jPmWKHidkLd6LicekIsQ6pex7s6ymK0W78MjoxWNWGHr65Tu0VSNb+3RZT6Pp/yOa3LPN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=uW0kwOv9; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-51120e285f6so2161360e87.2
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 23:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706858610; x=1707463410; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FKYeyb5r+mQMu/bTvkzq/zXSluKwypESmMB0zIXlNXs=;
        b=uW0kwOv9S7f06LK0YRMnfDnwMtUdFneXYFXpBtBPgDIyCJ8Pxx9FDCHFpJjuQPeX4e
         5rvxFMvQE9NZhl46MSkNxmT0SGnMjDXhPrqlCJMbGM2ceLT2ALFqcRLb2zGZu2PxxbyX
         H/rbuB12y2PZkoCtvklV0ArBzwlNmQAlghnSsWtKeM44WmqIkgqhmG684yBbSRU12J9n
         5bUuKj91pf4eVd/w0rCPaVuPHEpeUgT9eZJUNdneuGjstaH02SCpyLKJmR9wOYQWzPBr
         hJ7ocIp5c4NLAakjYSRk/IUwUlROq6x9QQ8ycJetKnxfa5PGQdLj7W4hzZXk1hhIhFKb
         EshA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706858610; x=1707463410;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FKYeyb5r+mQMu/bTvkzq/zXSluKwypESmMB0zIXlNXs=;
        b=MPbAKipkY1l2iOC/MCSYWmai4vcSCQTRdebjQgPJ8IfSvMpZVdR7nojtEkmroysOiB
         VjzO5FVIMzd6hj3248E9dZf9U808L3AdO+mS9fz4+EXNW6NJh8dNHRR/VeQQT3k0wdQS
         gHOU0X9CW/pT9kzDwCJXoLFYxmXFd5dr0Ux3yxCXAUcbZX3QfK2S0uwsUEQ40rOJzSTW
         INeWTXsmc3L/nvsfVIYdtQfMyQbgqZY/BLyhPl4jjumMK4Tb0XkCMVzOcNfB+u6jz55y
         jx4MZk6AltNV0cXlD7J5ETWT4Y7y0QNwGvFbagsNTf1GnQUnR51RDlB63JrELHHcSeZw
         /1Qw==
X-Gm-Message-State: AOJu0YyJ46TToDk2hkG+BToVh5ancfj6++3oWCdRw8+Gz+nZlhNlm5Dy
	KFoQDjBt5E+jSlWWKt5ViFufgJwvoxor07EOfCEyQ3WGTiR5rCJUHr1I4+rO9Lg=
X-Google-Smtp-Source: AGHT+IFjz8mAdecH3QpcLaRDEYDQ6LYhmaHa5wbSffnEPR+knURnCIOe1byh2RJzy/Eb5bo9JQigbQ==
X-Received: by 2002:ac2:4563:0:b0:511:3299:1475 with SMTP id k3-20020ac24563000000b0051132991475mr1593360lfm.51.1706858609797;
        Thu, 01 Feb 2024 23:23:29 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWlWUcaXlM/rDQQLZt8vC+9Xd6MKg3XIIC5SEbV5XoagsuTXdxmGOG3Hjq6wmsVlBgTk/4sxqjnlal9LwsUM/bwSJypos+ScpNHdEC9jviu+lGFtmBhdTRUpNtmCCf+BTH4muPp3W9Z5dD+WPF8XJCYoC7sX7opCLthkMUU+RcAILMMoXjfPJxS1WyqXuO1yAfBp7k0Ke8OvrVo+2FaYLXPbWfQZSiBprF7ps+JbIieZwvqN7lZQNZZI9RBVB9mgg69ydfde6hrQo7BUNCVwFzSZej36tn16hxSrbklvwJzDOTk88wVDUODANUKQ5aHu4k+tmMnu57clhdpp+MHwxNaBeDfEqRyaRHEemb91iDo8n5ZiFgo4MG6bLS709nNX/WJSk+nkaBoo0okIvLk9vbV065XeXQ/F9lKipUViJQAqrDCdgHpFHYVe/mcxYnMr/o6IVzkBuo0DYAOsqJpm9oBvCrTucYGqMxqKsKvrSM6qW2vb7qAmpOhbSw06+SeDXDJolQuRnbp1eB6TVb/PXA6UUOSmR3wHoVvKa5mVgQCVbzV7nCIVW8RdmWI11PbI1b5oPLhKVFs35JBu41H3jIl5eewLziNqX6ikls0mjvgVm/1Od8/Y8GYzF7+Lj0eB9uMQfeBSErsPTaYER1o0XrtcLaRNN1SWa4hKfE3+BmcM4QX9SNbDH1D/Mm5sTNCCzg95As0TovFpDwg1M3+tk5+JJQyIibLyTNFx8BgIgD5FqdaeFPGDsKZCkNSA0pYKizLUy+XqMKDK/CoveudYha6VB8hvnRPcxHjNe3LfNI7ZABWMWAjvcipj+SaRV6g/LR67b29Y+3G+sYEewxkC9zFVCMFicS7J6pglBhHUs1v4xmT7RaB5xUl/Eks5zOS5zsfGAXVw6NcdZiQeQRZd5bokMd86DMtTFLnB9k7R/iA3B70
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id u12-20020a05600c138c00b0040fb989f4bdsm1756338wmf.23.2024.02.01.23.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 23:23:29 -0800 (PST)
Date: Fri, 2 Feb 2024 08:23:26 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jinjian Song <songjinjian@hotmail.com>
Cc: alan.zhang1@fibocom.com, angel.huang@fibocom.com,
	chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com, danielwinkler@google.com,
	davem@davemloft.net, edumazet@google.com, felix.yan@fibocom.com,
	freddy.lin@fibocom.com, haijun.liu@mediatek.com,
	jinjian.song@fibocom.com, joey.zhao@fibocom.com,
	johannes@sipsolutions.net, kuba@kernel.org, letitia.tsai@hp.com,
	linux-kernel@vger.kernel.com, liuqf@fibocom.com,
	loic.poulain@linaro.org, m.chetan.kumar@linux.intel.com,
	netdev@vger.kernel.org, nmarupaka@google.com, pabeni@redhat.com,
	pin-hao.huang@hp.com, ricardo.martinez@linux.intel.com,
	ryazanov.s.a@gmail.com, vsankar@lenovo.com, zhangrc@fibocom.com
Subject: Re: [net-next v7 2/4] net: wwan: t7xx: Add sysfs attribute for
 device state machine
Message-ID: <ZbyYbul92taHMPgq@nanopsycho>
References: <20240201151340.4963-1-songjinjian@hotmail.com>
 <MEYP282MB26974374FE2D87ED62E14549BB432@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
 <MEYP282MB2697CBD4E366DBE80DA59216BB422@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MEYP282MB2697CBD4E366DBE80DA59216BB422@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>

Fri, Feb 02, 2024 at 03:16:12AM CET, songjinjian@hotmail.com wrote:
>>Thu, Feb 01, 2024 at 04:13:38PM CET, songjinjian@hotmail.com wrote:
>>>From: Jinjian Song <jinjian.song@fibocom.com>

Could you please fix your email client? You clearly reply to my email,
yet the threading is wrong. Thanks!


