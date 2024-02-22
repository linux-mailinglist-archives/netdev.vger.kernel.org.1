Return-Path: <netdev+bounces-74056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A086185FC6C
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 16:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CE33B253BD
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 15:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8E214D44A;
	Thu, 22 Feb 2024 15:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s4mgHzoY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E242D14E2F5
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 15:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708615943; cv=none; b=Si1hi3NQbjCjpSYaDWxcLr/bPWkcRnKgqzGgnNUT0zN8Nra49fQMCxb5OJxqkREuBFrakUYnbBN0cXWxat/V+DgeXRV0ZHo91bCUfjJc1VX/CKZaviQbvr+f+QbcglZhFFRnIRsa+gUmMrvAIx06vJwIrQquInkCmNdf6PFDl2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708615943; c=relaxed/simple;
	bh=HZutNOEuozUmilTycsHTvraIH3r8+SypP+r2VRMcm40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eyod3AoXZmK0pSu93YK+7QX5CuH4Q34Xjt/9IK9a3jdXF3VZb7QWDwPM/2d2swkgF8s+SKLLcFaBWq6g/ehekRDGZEFBJ/m0QpnVuhNHyyrYNputpiESgfdP6K70+r4ob5zWco8LqxmNGTpmAc7fcHw9ev56EaKa1L0ixJ8KBAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s4mgHzoY; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4128d787765so3362455e9.0
        for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 07:32:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708615940; x=1709220740; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+q4vsHLhF7Vv0hgSfbRQ/lU/wgrHQF8P9rNsVKFLL/o=;
        b=s4mgHzoYRJTs6oIl/CU+su+3ti314XJjJ8DBd9P2fX2lDHNWu1bPc8E4czizspP1ob
         Bh97ATikC26VrwpCHTfoV21EGyYgTIsffTuDHU1e0pnd8dEGIhM7NkVXOn04LbXdlzZF
         t4kTwuK1HCAMllWowhner2tm8/9av9bXvTPiCRSILn5xySkPs80HYKh3Jh/0GiOFHT8T
         F120R8vTh032xNb+6MJycxtvkvLTKNJgwDAJaJ1LZNtr+13iCDMXPPXqt+mUfnSJ1BpH
         MLwDlUE308xSoFlcGcrJptebxAVmcdxUVjto++7wQZ5G8pgnXMS4yZZaOjmTk3B6NZIu
         TdnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708615940; x=1709220740;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+q4vsHLhF7Vv0hgSfbRQ/lU/wgrHQF8P9rNsVKFLL/o=;
        b=FdRr4xJjJSCN0YyC9V889GBUT+mRpI34fUVLDe5LU9Q0gVeAfkJoTXIf8BwCSwZp9p
         kG7TmRVfn6Tr8me51zuesg8CygU3KGTrBUQSCtHO2NhW9w9NzulbQMfnLxZ4jbf7is87
         liaUOaagPPq5y5v0Mu1jIHihJFOyWFXSLUqImrHUQy5jTN8KzDWiJoYjk7TFti6Md6CJ
         5URtPJqP+ZTVFZ/AAi4cMhDpO+rz/M8YcpRWkxsP0ZYYJgTuAbvzEi5jrOoNXEXY4Rg8
         Ym8MpxBQR1Y7fM+EGXxinwCGl9vu51ymTa8Rsgyo7yxIXys2DoYzCDDMUMJJv8W1BEQG
         Rl0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVtB+WjK4+xGZtV1N659OaZfzyTGuyC4uIto7eT52m4tlmP1Vyj5FINfAIRSaVkayFbJDbVWhh6zoyrwAH11naQbM2BF/DX
X-Gm-Message-State: AOJu0Yx7NGnvCejodrBvOvYQvQLUHeJtPo/7VfTInwmCxBIqBNRdoiap
	QL6eaOqS2OUSjI3rx9lbRTEu8SeveRXq6Ic0AYq66A8uWII/LI1qJex+L/0R8pc=
X-Google-Smtp-Source: AGHT+IHFWn61+J9PBn0aK/tovKHOYNTYZTMeCP4cG4kdpItzeBRLIBT4km0f7vWmhkKsGRxrN0UJVw==
X-Received: by 2002:a7b:cd8a:0:b0:412:a6b:d572 with SMTP id y10-20020a7bcd8a000000b004120a6bd572mr15081272wmj.34.1708615940264;
        Thu, 22 Feb 2024 07:32:20 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ka7-20020a05600c584700b004101543e843sm6434548wmb.10.2024.02.22.07.32.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 07:32:19 -0800 (PST)
Message-ID: <04f0a492-aad2-43f9-a3d2-fe60b50caefb@linaro.org>
Date: Thu, 22 Feb 2024 16:32:18 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/9] thermal: imx: Set THERMAL_TRIP_FLAG_RW_TEMP
 directly
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: Lukasz Luba <lukasz.luba@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, netdev@vger.kernel.org,
 Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 linux-wireless@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
References: <6017196.lOV4Wx5bFT@kreacher> <3790563.kQq0lBPeGt@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <3790563.kQq0lBPeGt@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/02/2024 19:39, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> It is now possible to flag trip points with THERMAL_TRIP_FLAG_RW_TEMP
> to allow their temperature to be set from user space via sysfs instead
> of using a nonzero writable trips mask during thermal zone registration,
> so make the imx thermal code do that.
> 
> No intentional functional impact.
> 
> Note that this change is requisite for dropping the mask argument from
> thermal_zone_device_register_with_trips() going forward.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---


Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


