Return-Path: <netdev+bounces-64195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D311E831B05
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 15:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1236B1C20A72
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 14:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B1725756;
	Thu, 18 Jan 2024 14:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GzLLYuZ3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260A025579
	for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 14:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705586563; cv=none; b=MU1KnHa6xisXdtPMl/TC4Aa9RVtaIE7QMXGkm+kvdvryWXzS62WNBO8gk+qk5BR6u+ox1u0h7hsFiwFArSgYorMjAGpn7aR9HIv+sIGIUd97dWBtMHaZCApGiwRm6DpeUJrvQa8TDs9IWNpJF4Qav9zY3+GzT1cc9/3VfPONSws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705586563; c=relaxed/simple;
	bh=XwFPnCD3pVIp4nOoRB+Uc7ghygah+08p/DypU6fuYjo=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=A2pBfbKlW1cJxiCpWWhFQe2HZkRfl/A2XeDShaGtacNliXQofN/f82Flan6n4ATlhmwnVLei4YZ+tjkHwQkfcs938YYg7h6RVrcETsa8Cuufptgmeqgeo0/xqMdMvGjYj90+WbPRXOpYiK+sdmK8+nvw2VIJsEp6eq3x/FPnTeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GzLLYuZ3; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40e913e3f03so7147075e9.3
        for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 06:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705586560; x=1706191360; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=20bX/XFWinF8o/RfO/KBZGAkxhlss84UAKlLhQSztPg=;
        b=GzLLYuZ32qlTqrIVfUVp/YWhcyJ/jmCKY9I+fKZGA8bzp44VBlHoet08HyhtjQ3UFu
         pkyFzO0eJxFk3IImR0Hcas42saBlj0L58EIhFRaEnVynT5iKCtk8BFq2rEACGhQKZeyC
         hRaz1c0sK9VHTGB4PRnqK/wm1Bbfanz+E/N0ODYyecKxNbkgUflRoPpUSPGejlZGcd4y
         tUrZKihDvBuX6sPcBAk5BYjbEM4aIgeUl1Kh81GsrBbXnjsGWuuu7Jhv2vt63D3Gvc/w
         p2OgYtFFR0oKgN+ZMoUyCy5HVxXNoZcImsgg484I1OBf/xc5tGPbpzcZgp3wmPUAlBP4
         lW+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705586560; x=1706191360;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=20bX/XFWinF8o/RfO/KBZGAkxhlss84UAKlLhQSztPg=;
        b=fFnmLZo/QvsTqiJKMXeel12CS5Zjh0l/726N04lIsfHfmKFpN8tUPNtjrsSJezn3do
         qcqSamXf/sxCWPhrdPZeu/0QcSdSXMFEfePuSDRsTZCE63Mj/Va8N+EOnS2M6BvBjxV0
         hWLAHyHSzFiqyBZa/4A0zmGKYHEgxb0PID6XUwGoqqmeB05Eb71M0PwwaUUIR3pfRj9e
         Mz+4a5Bh7cLoNBGF3i/gWgw5V9Qv3Fdi7mLXXmItI+lmJbmXmLJUYk4naUShz5D0m/o3
         Lagf/Vpi3oUp4dNpwDDWu4/nLulGLbXx6XHnLYhB/qx6KtrstxYsfmo/TcHo1sxQMov6
         Sxtw==
X-Gm-Message-State: AOJu0YwymCuJKFgYAMIh08gXmJXN1nyHtHOivfs94/W2pj4kAhRQMju8
	fseeG2J/7a/8kcCUzn59NBKR4P4LfLdKLV0djUTx6TT8+cR6z77O4IMwSyMPA8Y=
X-Google-Smtp-Source: AGHT+IHWI//6laMgHdYMGjsOTaEMH9f1zk20uprry/MLMWjdw5OyhiMBKxMuHGUcyVloSb3CWRNThw==
X-Received: by 2002:a05:600c:ac5:b0:40e:9007:5cf1 with SMTP id c5-20020a05600c0ac500b0040e90075cf1mr613691wmr.19.1705586560394;
        Thu, 18 Jan 2024 06:02:40 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id j28-20020a05600c1c1c00b0040e6726befcsm22212876wms.10.2024.01.18.06.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 06:02:40 -0800 (PST)
Date: Thu, 18 Jan 2024 17:02:36 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH iwl-next v3 2/3] ixgbe: Fix smatch warnings after type
 convertion
Message-ID: <1a2bbad4-f5c6-4a46-8dc1-ff853987bd59@moroto.mountain>
References: <20240118134332.470907-1-jedrzej.jagielski@intel.com>
 <20240118134332.470907-2-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118134332.470907-2-jedrzej.jagielski@intel.com>

Thanks for this patch!

On Thu, Jan 18, 2024 at 02:43:31PM +0100, Jedrzej Jagielski wrote:
> Converting s32 functions to regular int in the patch 8035560dbfaf caused
> trigerring smatch warnings about missing error code. The bug predates
> the mentioned patch.

It's not really a bug, just some suspicous code.  Especially the
"If 10G disabled for LPLU via NVM D10GMP, then return no valid LCD"
return.  But it's actually all fine so this patch is really just a
cleanup.

> 
> New smatch warnings:
> drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:2884 ixgbe_get_lcd_t_x550em() warn: missing error code? 'status'
> drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:3130 ixgbe_enter_lplu_t_x550em() warn: missing error code? 'status'
> 
> Old smatch warnings:
> drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:2890 ixgbe_get_lcd_t_x550em() warn: missing error code? 'status'
> 
> Fix it by clearly stating returning error code as 0.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202401041701.6QKTsZmx-lkp@intel.com/
> Fixes: 6ac743945960 ("ixgbe: Add support for entering low power link up state")

No need for a Fixes tag.

> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>

Thanks, again.  I do think this makes it a lot more clear.

regards,
dan carpenter


