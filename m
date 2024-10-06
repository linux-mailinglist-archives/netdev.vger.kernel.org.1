Return-Path: <netdev+bounces-132562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 847EC992209
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 00:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CE34B20FBF
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 22:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC5C18B48F;
	Sun,  6 Oct 2024 22:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2AR6tc2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C3B152165;
	Sun,  6 Oct 2024 22:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728252024; cv=none; b=fUQ8NDowGphCC6fX7AV2JH6RVaJ3sEQuSg3Yd6jWlRKS3ZM99jo31L2VP690yLoh1eHABpdYv/h9i6/0yf4jGc1YL7f0Ltb+XJx5xUPfbJjrJBPDYky2ciwTUDP/4NrNkELuWVsynUlyCpPE4nb7+X64nkfNpoGuv+2Rw3fQ8i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728252024; c=relaxed/simple;
	bh=SDWqSnVC1X/WWwMZyagUXcxwjhzgxnAdnjCDCZY6vZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ITS2MngvMpqN38ZJG+1CPRlGYrBLMo1tWwhjwJmlH43lB+RBLO8xzIPFkl5BZUYFx1QJT2JfvZDf8qOiPPQXjWhqvpFdSV8dJNusYW2zuN43tALvqLtP3JCgbnYPVpkXIafdgLjX/vAL3xkzRduOmDVi1d9eFFbDc70WomAymjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2AR6tc2; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53988c54ec8so4192859e87.0;
        Sun, 06 Oct 2024 15:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728252020; x=1728856820; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0GDRC7VyvrSRUCSE+aiTV6hzlc3o4Msg6D2Hu233WkQ=;
        b=T2AR6tc2oLIfTBM7eU8Qq13qjicUOoXg1mhdp2YFVsmER9F/8pc8pGQSbjlj8ZClTo
         MbQ3g/YW+x0uSi3j8FD+eR2pHNO2TA8neDsQcld6ZFuJ4MvlSy4F3L3e4Ur/tSDvZr+P
         3G9RVlwPFt0/8RPGuvFwJM5l50xhdwAiuJ7nrWuwCYVeMkzvPxL55Xr1Qke2VY6ozxTS
         L1Bvbb5FZaI1MFVIO5o60rahF9iB2POORG4q5FofYROoAYpFzTtqHy7qsBqk9lPUvjpG
         c/w40CB5l1+xM+AkQRTwW30vHd/cSACY3labriCJNOTfl/La97kPZrMj3Ie4jrHfkNol
         4nPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728252020; x=1728856820;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0GDRC7VyvrSRUCSE+aiTV6hzlc3o4Msg6D2Hu233WkQ=;
        b=eV8X4Gum3h+QyyEqXJl2PiJ/16VMp8qAwlC2rSTCLJBLbRNM1C2ypRtFo5LcfBNXHg
         1NWvjTpoaNxqXL/pLMBkr0ArMPBA8TyfyGoehugWvE4+1t30wsqqyZKl89d/sbhPNeia
         2D+i6pzwyq6P9yQ/5FGai7SICTYtjXXDPEoZhfDf/Q+mV71irz9OpopAS/+wsY922XZZ
         6r77AKXzt0MK+9HHSmrq15fm9SYPQsn8uFFpB2L1AuvR4rkuwH+5uqnMKXWsZfbRWa8p
         L8o/XINithhxkGtlkjzF1ehoFJjY0UOPNM0WcojwIfQPrpOqP92oBCODdlUN/O25tDw+
         xoLg==
X-Forwarded-Encrypted: i=1; AJvYcCW+5TrBXQFYIkQ8dC2KSoFr0MV8UzoWelQZJKHiwOGgQ3Pu6gVCMZ1avDYftWTnt9IdI0ZXgMdc@vger.kernel.org, AJvYcCXHp4VPbt/YIniRil0kKCQxP0QK4/FhqM3p+g+ij8RHetvHQguSO2MLnca5Qm3LSA9fM6Vi1zzqVuAtSzI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyktr9b0jSVE/IXXEY98AimSGb9D0qhM66B1oS5TNOVY8sPjbUi
	aafLTZD7H00oS5ZWI3garbCJjFp4qz3NqRg7JUEfs6GhWWAdZSlO8Ppl7Q==
X-Google-Smtp-Source: AGHT+IFv4rpLNlUqpXISRj5sLUzk+rr088HIomRzQj6u+Bfu2XakaNs/hxVHEYCCk1fdux68psLEgg==
X-Received: by 2002:a05:6512:239b:b0:539:8b02:8f1d with SMTP id 2adb3069b0e04-539ab88d2abmr4162254e87.30.1728252020265;
        Sun, 06 Oct 2024 15:00:20 -0700 (PDT)
Received: from [192.168.0.138] ([31.134.187.205])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-539afec8546sm625304e87.108.2024.10.06.15.00.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Oct 2024 15:00:20 -0700 (PDT)
Message-ID: <1ebce461-e4eb-4f10-9de8-19240193b262@gmail.com>
Date: Mon, 7 Oct 2024 01:00:19 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: fix register_netdev description
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241006175718.17889-3-insafonov@gmail.com>
 <844f8c95-634c-4153-bfab-d6a032677854@lunn.ch>
Content-Language: en-US
From: Ivan Safonov <insafonov@gmail.com>
In-Reply-To: <844f8c95-634c-4153-bfab-d6a032677854@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/7/24 00:16, Andrew Lunn wrote:
> On Sun, Oct 06, 2024 at 08:57:20PM +0300, Ivan Safonov wrote:
>> register_netdev() does not expands the device name.
> 
> Please could you explain what makes you think it will not expand the
> device name.
> 
> 	Andrew

It is the register_netdev implementation:

> int register_netdev(struct net_device *dev)
> {
> 	int err;
> 
> 	if (rtnl_lock_killable())
> 		return -EINTR;
> 	err = register_netdevice(dev);
> 	rtnl_unlock();
> 	return err;
> }

There is no device name expansion, rtnl lock and register_netdevice call 
only. The register_netdevice expands device name using dev_get_valid_name().




