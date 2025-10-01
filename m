Return-Path: <netdev+bounces-227446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E50FBAF8D6
	for <lists+netdev@lfdr.de>; Wed, 01 Oct 2025 10:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA6A33C5AEC
	for <lists+netdev@lfdr.de>; Wed,  1 Oct 2025 08:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B865B2773DC;
	Wed,  1 Oct 2025 08:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Abgo5lh/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E8F18FDAF
	for <netdev@vger.kernel.org>; Wed,  1 Oct 2025 08:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759306270; cv=none; b=svsqANklLmt3/LAIteEzQ/jsnATmcghBTGrWLRSquqmo2dM+yLFClqRJfMo7YosLPCktPXdseKjqRFlDZpZ1Y64zxC1JhVjW3iRs81t/VAOWKXNyjiivRyFwzeJsQDUMRmBAzxw+TVGWI9KMnD3kRFUjkogbXQUBcW0M2umQE9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759306270; c=relaxed/simple;
	bh=k+98mlzkrp2RKhBDwIPjhFLJEPpjV7PkE1WVmkbrgf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z1cGLUJkthttde2B/DWMgObQOkR+5ykmjcOMSfBoypeeAVq5fpagvGRd5+pNpsMzZvMHuUba5DR2M8NpY9tu4XVz5ue1+241ZHtB9Nrd35JzHsorbzgPwfGYsoJhSmFlUcs6ZbXm9gCfg886wbJq5O1s6KCJ+oztm4l+XOabfWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Abgo5lh/; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-781010ff051so4793483b3a.0
        for <netdev@vger.kernel.org>; Wed, 01 Oct 2025 01:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759306268; x=1759911068; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9sp3cgB81mX5j3kEpDMGkvj6tFo6ebH1h3lg6uJz188=;
        b=Abgo5lh/JCCIIue5wdaD9BskXSeuDy8PRlNm1hDR209mYk/UtT/Uj0pTBC9Mfc152x
         48Xp1WVnUe6AUwbO063ozdnTX1QL/9vaiiFj+ABlkdlAII439wy16D4kgPZG2r2isW/x
         0og96lgLCugtrfp238+GVdiOjc9JNnZOgzXv7yd8+AVdW5ANGMXIewo/VPc+IDwnongB
         HYvI5KHv3gMPmcUs223YrbTO+c9qKuD+LTNDmRuyCCpbVoyX1S/nPithBGbS7dqaSWsb
         32ZoE2xW+Z1CphlsV9YdLvyhN0RgMJt7XTkLAWMKrAMB59M+aVYUNVwBV0nQmVxWeSNK
         DD8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759306268; x=1759911068;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9sp3cgB81mX5j3kEpDMGkvj6tFo6ebH1h3lg6uJz188=;
        b=oernXxNOWe8LvNabQvT/ty1FIu6o2ryiCpekoUlcOWUEIBrQlbUbk0qsTGcV2l7yR6
         0ssjA1Sc3gPCAdNTVTRuCqQ0xqdpsJw942J9OkseevHsn4gsM/tPr1wjgOES4ZmPa3Zl
         Ej0oXAtagukyFROf2ONe08YFGXABzNsWc591kUDxe83ufzi0G8q3KyGgeTgT2oJ9yFSi
         XEqjP7tP4sghekCoDAQl1B9RmkqmgrbIPFeAOnZbCdpv0pvWhBBOEwUFnjPoDhpJJxGu
         cvE9xm7ysIydGGO9hi+I+UL4Kdhl/urjPi+UPXDw7d/KjV+92Mf9jaBj1IErZtWExH0y
         mi8A==
X-Forwarded-Encrypted: i=1; AJvYcCVlKuq1egD72NihJeK/MlqbtrdnUOkuGGIvY+10vBpCUbjsc4Hy2lxNcclboMRTyavXFKMYjMg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpzz3nOhYM6zoTOAXpcdx4Em6UO9qC/beXqPCQmapsibKXG/bK
	h/ohRNJeiILPMEPmptycO5KupjmOpk8dGGBI/aLxSPJEEkB+q/k4JhmV
X-Gm-Gg: ASbGncuC8yD/Bmla7HSqwN6oDQM3xxjH+/hhM9Gx0Ls2QQncPF1ZKOfZCSPOse6FsHK
	g2GmdUnt8AMS0Awtfisu6Gs2mp2Fx2UctkEbk0xmlwV3aJtbEKVSqD/qF7MG7W4baICy3DCwMim
	BZDYj0n/JSAJoT8NCY2MQBprx5MHWAxafqCfuk2k1FNsAcl+l5CtfgaX7bitjRIu5+1OLGhHNRm
	sbVzmLf+/B23D+21oGVMgxlBXSD9ckE6c0KSAr2iPUv76aKF+HxqG8sm67Nfm2acTdk4Mp/4+Qj
	zdFMNqWd6Nf39GGSk3FxlbTDY4rluJ65aJyF9/lbd3Jt7FLoG7WtuCSs7xzHa93gAqfb/hcp1Lp
	xRJ7xgvmu3U//8wbA5L9SiCyyJjy03Jtc+hJlsuYbNcKpIfyCrakTjKPFgbrCAizpAqq8/g==
X-Google-Smtp-Source: AGHT+IHupIF/aqS/uN1p6eF0m90zcA2AmdFfz6VwfCnH2eMPOA8mf1cKet57vjwVNF8IksMnMrnXfQ==
X-Received: by 2002:a17:903:9ce:b0:272:1320:121f with SMTP id d9443c01a7336-28e7f332d05mr39109295ad.27.1759306268561;
        Wed, 01 Oct 2025 01:11:08 -0700 (PDT)
Received: from [10.0.2.15] ([157.50.93.46])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3399c0b24eesm2038496a91.1.2025.10.01.01.11.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Oct 2025 01:11:08 -0700 (PDT)
Message-ID: <e956c670-a6f5-474c-bed5-2891bb04d7d5@gmail.com>
Date: Wed, 1 Oct 2025 13:40:56 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: usb: lan78xx: Fix lost EEPROM read timeout
 error(-ETIMEDOUT) in lan78xx_read_raw_eeprom
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Jakub Kicinski <kuba@kernel.org>, Thangaraj.S@microchip.com,
 Rengarajan.S@microchip.com, UNGLinuxDriver@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+62ec8226f01cb4ca19d9@syzkaller.appspotmail.com
References: <20250930084902.19062-1-bhanuseshukumar@gmail.com>
 <20250930173950.5d7636e2@kernel.org>
 <5f936182-6a69-4d9a-9cec-96ec93aab82a@gmail.com>
 <aNzbgjlz_J_GwQSt@pengutronix.de>
Content-Language: en-US
From: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
In-Reply-To: <aNzbgjlz_J_GwQSt@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/10/25 13:12, Oleksij Rempel wrote:
> Hi,
> 
> On Wed, Oct 01, 2025 at 10:07:21AM +0530, Bhanu Seshu Kumar Valluri wrote:
>> On 01/10/25 06:09, Jakub Kicinski wrote:
>>> On Tue, 30 Sep 2025 14:19:02 +0530 Bhanu Seshu Kumar Valluri wrote:
>>>> +	if (dev->chipid == ID_REV_CHIP_ID_7800_) {
>>>> +		int rc = lan78xx_write_reg(dev, HW_CFG, saved);
>>>> +		/* If USB fails, there is nothing to do */
>>>> +		if (rc < 0)
>>>> +			return rc;
>>>> +	}
>>>> +	return ret;
>>>
>>> I don't think you need to add and handle rc here separately?
>>> rc can only be <= so save the answer to ret and "fall thru"?
>>
>> The fall thru path might have been reached with ret holding EEPROM read timeout
>> error status. So if ret is used instead of rc it might over write the ret with 0 when 
>> lan78xx_write_reg returns success and timeout error status would be lost.
> 
> Ack, I see. It may happen if communication with EEPROM will fail. The same
> would happen on write path too. Is it happened with real HW or it is
> some USB emulation test? For me it is interesting why EEPROM is timed
> out.

The sysbot's log with message "EEPROM read operation timeout" confirms that EEPROM read
timeout occurring. I tested the same condition on EVB-LAN7800LC by simulating 
timeout during probe.

Thanks. 


