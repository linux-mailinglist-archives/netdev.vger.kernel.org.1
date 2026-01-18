Return-Path: <netdev+bounces-250842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA9CD39529
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 13:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 49BE730194C8
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 12:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DCE632E6A2;
	Sun, 18 Jan 2026 12:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nYurh6nX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8632032D7FF
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 12:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768741015; cv=none; b=ip9zFKUVC6tFaBqgz6DUfEyb25P1vRLPgYBFJZxVZwbAIDWUwIUhDjr3oP3FW5EZbc+Sx+ZMvEm8nWT1qCPFlpKVuLCY9K6l3dZ3r3zhU/loRqOVFUoaCZhC/iq/fCBIv2elvkF9svbPyw8s40JRbczUYdaiwst+ltnbdFVsyro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768741015; c=relaxed/simple;
	bh=62HYj/ZcUKlmj3QaojvdKZAilxIz+qBawy2FHsZ8X/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SfXFFmXy3hoSnZz7E93HQAF5DxglnzRjLc0hBpxlEipN8kNnCDsImvFLl1Gkb7KD0QAV7jc8gat+hK7YTX2+Ispi4DyykJHTgHaGTODfVl7G1gc4EsSY2hJgYhlmqB+6lvp7u9ErgAWKXlbn8BKjQfl3AUVcIUptUtQpCpV9xUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nYurh6nX; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42fb03c3cf2so2316395f8f.1
        for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 04:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768741011; x=1769345811; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5vuppoT7xEbD8pTBXyzO8MGSdOfeAdBaep+fRisqsu8=;
        b=nYurh6nXKUgh7bpdP9uHR2IVaOj1BGzecSS+jhWwD9E+aY1jgYba3c/jdfXWiB/bu3
         bjDAzVqxsCSixYlBjEbdusSkES6Lqqe1t+esyBUJauFQNnWQMVTYTPbcbLzmGpyW47J9
         bLdOuv/WOIMmWvY46v+Y9EAJEkp2l3aZxvPi2iP+6nyYmiOYObBquEVSMy0DjBROKb1O
         MrMQbOvniYrIMUV6BbtzLPT2tg/HG5bpaeeChhQXrGDVIuJo2h+GYH6iMKkNuMQmYtCx
         8roWGMczfSRy/qhJhI42VvnpdHSI5ip8VW5PsYnPCLQUv/SccbilreLjtzHNvm76ljz9
         ZFpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768741011; x=1769345811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5vuppoT7xEbD8pTBXyzO8MGSdOfeAdBaep+fRisqsu8=;
        b=bSOFLGqefbFWbCaAkX5MUur+ypvFDkhi2ZiTPbJavi8xCGXHe2JTcUD7m+RcV2vXt1
         oux/j4GP/pkeTWEwAvo9K3H38wUTU2K8p6acFTjyTKPyFMi34Bg5N9BMm+LkuD+WCrX+
         WdHGv0bmD9HYZGqD1AHigoodI8+E8fGxKUcDna3mTZ17XqNNQcnmRamzGrKojVjeBOkk
         e6PqOsRh7s3yTBNVJfaOV8TQEJMTGBc1PIXssGm1Zg7pEt6bE7LFLeaBjh31PMWh4Z95
         M9EL+MXqg5+ln0LUSFMxERHgzzlGBsjv4OQCfT1dXeaeH/o/J6kp7z/PVfQe5HW0G1i5
         A5fw==
X-Forwarded-Encrypted: i=1; AJvYcCVK96JLE/pwctKKwS8FV4XBlrRcz/adJBiBjzRQ5d6WVkUxFvJHS07wNTGkz9tIR/kzJUsms+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXOuQggtBFZTp/uHVF6bA8DLa9DmTfietQPY91jKvuJgKtvlP7
	5ccNO9L+lTGA6PsQor3JxizEyxE8tuvzJQDkJvC4WA8okv6HNycpQU1zlQ2F00xeG+8=
X-Gm-Gg: AY/fxX7YwjWdOU3/Lr6Vg8tXRZ2hPctycJj4C+h04ZvJrsN9pzm+c2EiX+3XXXWl/hw
	MdK9R21lB1cKhvY5vfnbKNwGWAYOuYYbMRcSqhWJMFgzzwGgjaKn54hVt3jXxMBEgHxLvx0y0j7
	gx5+jwQj0ZdAkJz4xR29DUMe1HwMwkbnsDvfe4+Cg5MDo4Bnv5OOHuhAa58SaE6DQ9ctCa9BcHI
	t3BRYAUuWGwoZxbIdR+YHh0EMTqQ6ljgeKBOElkJPxuB8nXHgLt9vB7+8rYEZOAsIDYPEBz6Sge
	aa7+ApsqIzP7LvgMcptp79sDb8fijM+GoTIVKP1C70Ozb3tSuQ9WrCFIdEGbi11WpStGytgntYS
	sGGvDq7XRZLcDgBFd6rxwVJFGMUNfDi+dSrOPaxb4OezgaTixy427jLjoyPyWyixasuVkhsNk4R
	xFvbWrmZklfXEbIkgQj9Eb/uZmUI0=
X-Received: by 2002:a5d:588d:0:b0:430:ff81:2965 with SMTP id ffacd0b85a97d-4356a060dc4mr9673825f8f.49.1768741010676;
        Sun, 18 Jan 2026 04:56:50 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356992201csm17368207f8f.2.2026.01.18.04.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jan 2026 04:56:50 -0800 (PST)
Date: Sun, 18 Jan 2026 15:56:47 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	horms@kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH iwl-next 1/2] ixgbe: e610: add missing endianness
 conversion
Message-ID: <aWzYj1cfVuhHpGCO@stanley.mountain>
References: <20260116122353.78235-1-piotr.kwapulinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116122353.78235-1-piotr.kwapulinski@intel.com>

On Fri, Jan 16, 2026 at 01:23:53PM +0100, Piotr Kwapulinski wrote:
> Fix a possible ACI issue on big-endian platforms.
> 
> Fixes: 46761fd52a88 ("ixgbe: Add support for E610 FW Admin Command Interface")
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
> ---

Intel has a lot of code which assume that it will only run on little
endian systems...  Which is probably a fair assumption, honestly.
For example:
drivers/platform/x86/intel/uncore-frequency/uncore-frequency-common.c:90 store_attr() warn: passing casted pointer '&input' to 'kstrtobool()' 32 vs 1.
drivers/net/ethernet/intel/i40e/i40e_common.c:4345 i40e_led_get_reg() warn: passing casted pointer 'reg_val' to 'i40e_read_phy_register_clause45()' 32 vs 16.
I seem them on occasion when I'm reviewing static checker warnings but
I ignore them because Intel chips are little endian.

I don't have a problem with fixing Sparse endianness warnings, but the
commit message should really say that it doesn't affect real life.

regards,
dan carpenter


