Return-Path: <netdev+bounces-108912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F3292632F
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 16:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C3811F242DB
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 14:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A023917B507;
	Wed,  3 Jul 2024 14:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3a7OGb1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D96178CE8
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 14:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720016153; cv=none; b=c2pfnPRFnIAIgQbNIX9dzDjqrHxgeOCq/R+9zGCAJehbBhHvfnTEmRJITazqUJ7Ko9fV2o8F7oIBpihFsuor1KHaYhyxbj6/De4HE5cyzFPURCOWsKV0n7PWvtwkxRa9GEs5KB1byM5xMSczjCIgqAo7+EPKpVH7Mvp02/hzrDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720016153; c=relaxed/simple;
	bh=NtEn7BaurVxMGn8E6UG/jAtPOsYsSzsdH0Ty+Mol14s=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=axydY7ncXKyp5ZehD9Nx1fvJ/0eBhO1eLXuBH/VfclutjpZ+xd4rcDOzluXLOo9g8e4okL642Wp3X3GArE84k1l7yLpvmxX2suoCibvh75q3sWlj18JLqKXrUDBmwOGpRFNlN/54FopHN2Gj93ryoN/L3bRF7edTQ0+MN6pnnYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U3a7OGb1; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-424acfff613so48623345e9.0
        for <netdev@vger.kernel.org>; Wed, 03 Jul 2024 07:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720016150; x=1720620950; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NRCDleqW4WGYaUZ7walPwBz+GuKOliGpk4nDMIy9VOg=;
        b=U3a7OGb1d4fTTVNhyZDF3G9a+4YIQH3CGT5NmBB7uMKwbCXl1Eo8PUiJexh9LhkSht
         daBlo/9eH0gZYF2FWIlvAs7wDrc4Nm4g571P1RbvcHXu57ICRT4KIr9B9ahVpvyFmxLd
         Il7WOZUwNZIvWnKwjrEwaAgl7y14HMaKt2Mn4Tq5XXmOFFw+1JaL/ilT/qb9lPpCkrBp
         xExZ6mkEnfCGh8TpfskmuNZk/jmSZd90Ue1CnLHexkQBbFt7jfQSKvHz2kI3saDd4Tox
         OIH/0ncy/v7fPyaujQ0n4/izgogL1ZKsOYBCEX9vbxyhIEZgDSBI/raiv7MnlfRdt03z
         Ku7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720016150; x=1720620950;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NRCDleqW4WGYaUZ7walPwBz+GuKOliGpk4nDMIy9VOg=;
        b=a9DoTrqMBc80/6h2FJeukioVPmzgoAOhwrnDgnSraOvZe4pibZjdXP1ByA+5sbd/JG
         GnKgZVWgSvezzW3TjlQsk1adHUyemtSmVFO25m0k3AE1nRlLzltdkZLnSNc8kubm4tLs
         4aeXBUycZlDfQ4x5gH3/tLOdf+SYUCLQOMbWBh7RAB0X6STjyymbGDc8EE0PPY2NQH2v
         uGWb6ygt5y4t+QrTBniVdkB8XBLvYLNtay19bVyCohpgfOxRkZQd+lxaeIh7+5pIpQ27
         a60ri2gblKtQ/gVPShbTdJWHwYC727s7ph972rZVSdYHJObiiu4HF3pqJSJNkgWEnZ7w
         TJbQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpXGznODJ0xRKs7EIoo0SDCqTliEir9Z/bIVXPmb9UAtWrrwKUpOByJv4kDo51GXRE7don6R44cvB7EG+ueWWbZIkzlTTJ
X-Gm-Message-State: AOJu0Yz6l5JmVfWL1oo2OdudbR8iWsB4uED9AKPdG5EjH48HW/HgAtKP
	TSKLbHO5dUelaRsMCutxm6o9hZIdISoSIbh/LKuGO94K8E6K0IvA
X-Google-Smtp-Source: AGHT+IEYvnSMAhFPbRLyhL26TFvUXLD778rI/i2Ru5AwG5ZI2suG1b4TC0q8B3y3cMC62a+Ae8Geig==
X-Received: by 2002:a05:600c:251:b0:425:185c:7a55 with SMTP id 5b1f17b1804b1-4257a0270e0mr76852825e9.40.1720016150245;
        Wed, 03 Jul 2024 07:15:50 -0700 (PDT)
Received: from [192.168.1.122] (cpc159313-cmbg20-2-0-cust161.5-4.cable.virginm.net. [82.0.78.162])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0d9385sm15946071f8f.39.2024.07.03.07.15.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jul 2024 07:15:49 -0700 (PDT)
Subject: Re: [PATCH net-next 01/11] net: ethtool: let drivers remove lost RSS
 contexts
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, michael.chan@broadcom.com
References: <20240702234757.4188344-1-kuba@kernel.org>
 <20240702234757.4188344-2-kuba@kernel.org>
 <c22f9b2b-cbcd-d77a-2a9a-cf62c2af8882@gmail.com>
 <20240703064347.1929a75b@kernel.org>
From: Edward Cree <ecree.xilinx@gmail.com>
Message-ID: <940cec84-36c6-82b8-7cef-b181156ff8e2@gmail.com>
Date: Wed, 3 Jul 2024 15:15:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240703064347.1929a75b@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit

On 03/07/2024 14:43, Jakub Kicinski wrote:
> On Wed, 3 Jul 2024 12:08:36 +0100 Edward Cree wrote:
>> Possibility of a netlink notification makes the idea of a broken flag
>>  a bit more workable imho.  But it's up to you which way to go.
> 
> Oh, have we talked about this? Now that you mention the broken flag 
> I recall talking about devlink health reporter.. a while back.
> 
> I don't have a preference on how we deal with the lost contexts.
> The more obvious we make it to orchestration that the machine is broken
> the better. Can you point me to the discussion / describe the broken
> flag?

We discussed it briefly on v4 back in October [1][2].  Idea was
 there'd be a flag in struct ethtool_rxfh_context with meaning of
 "this context is not present in hw owing to reinsertion failure
 after a device reset", reported in ethtool -x and perhaps also
 devlink health.  Driver could set this flag (which would trigger
 a netlink notification) but could also clear it if a second
 reset (or some runtime configuration change) triggers another
 round of reinsertion which succeeds this time.
Fwiw I don't have a strong preference either — like I say, you do
 what you think is best.

-ed

[1]: https://lore.kernel.org/all/2ea45188-5554-8067-820d-378cada735ee@gmail.com/T/#ma8fce7df8b65601009551839d9d102c49e79803a
[2]: https://lore.kernel.org/all/2ea45188-5554-8067-820d-378cada735ee@gmail.com/T/#m073cb990982d89e35d78edf364389de62256664b

