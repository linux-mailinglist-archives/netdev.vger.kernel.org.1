Return-Path: <netdev+bounces-128254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D23F9978BF5
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 01:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 114A21C249FE
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 23:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D3414B061;
	Fri, 13 Sep 2024 23:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hiMhAu9g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D938F26289
	for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 23:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726271258; cv=none; b=bQ75RzsX01ivlzGsLQXSbkNvt7MruTGWeU1c5zKiZUyvpsTJCPIpqrfXKTUw0FEMqIekXQ8UhNusPtcV77F2kAkkw5aO7Sb86cNI/+QYZOnxrafPgWDyv24WYMDPA6DBcmaVCQ4wBPrSkmHVxZFp9lF9+tGwsygzBAkIZk0BbJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726271258; c=relaxed/simple;
	bh=IhiAP8VulWRXR2MHte2+Eiv2xY0tAXKAEe27ZlSbo34=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=HmqXjXROx+WpeQFfltAtYsN8A64Q6fn5GOmoEDmZpK8aoMvuvn0+z7x0eeg5LBbjkdJts3N+YZ2xNPMoNsk7xWiO31SdVowhQX5FtpNUPBdhxwBErXKbIIO8oGg2KkmGevvy2jFbQXA+V2ihpCsvBMv0vNQFVQp88//wqEkIj6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hiMhAu9g; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2055f630934so24677065ad.1
        for <netdev@vger.kernel.org>; Fri, 13 Sep 2024 16:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726271256; x=1726876056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3xGcL28VSaxrLY/4G6mXeUXQKeu/sUpw9sltnw81Zj0=;
        b=hiMhAu9ghoTcjYaP5d1pW0vdho64RZiJUBA4WhH0Q7KwbtWbEYwog6U+I36pe1bYqn
         IshwMoKxsFfVFSTfms+IY+9OoHl/BiikNYhW1umIuGFcnkPo8UTWyNcRXOBG14Dljz5c
         IpBuMYY8vIs+9nj9t4/QzerKGLvtNGlLNtwQ+DKWK57DY1I2n/Mn2AQ1yBZRZWD4BE+V
         EicN2PHMsbsEulRlvxbPOhlWY6V5ZMtiubGE6uPdafM4beG54+JmGc1+g6q8BIeiwOwX
         cGKl0afRCvPmpqSq3sB46lmkU1LY0hzFeaEQqnYUu5C+3vF/XrvTQhHULtUJKkD/cwAa
         T9AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726271256; x=1726876056;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3xGcL28VSaxrLY/4G6mXeUXQKeu/sUpw9sltnw81Zj0=;
        b=Gfo/OIBklf8i/uYKNDDtED300vlgP0LYsPaafUaFIOkKTWDQ1VFSuPds4go/HzA1U9
         q6u2tTa4fa797xGUjbQV0oJBZVF5v1OnUUph54nx2RDxKqhdlZntduJtT9H+ji+FKnlc
         BgMJCKHsq5HcsRXOd6kwNep2c+y5JcVS+ff6Hcz+OKcMqENDvOxfEnfmSfOrVP/FS5lo
         DDvG3Lc5mPEQF+JGhaWdGldxxsDnEl7E/2cAOHKh0+Vpju0uznhpZ3traTKMRFVRGyWL
         SeN+hmiUVHemEN4bO++1P9Oue4NnzIcp/U4Ty2pApgZKU/lzexQUmciipbreDlNrFyI8
         9Rvw==
X-Forwarded-Encrypted: i=1; AJvYcCXBxlZpnnAmlphYUAvHlQjc6FLrvTy+mdOtT7GRMxnspGljI/5oK2MXONP1zM92sZVN+qtpxd8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHUkYwUAsx3SwQj1K0MmzBkpc40a/rl86yBitAIX1Azr2cwmX0
	u/E28gnMhP5yTrrlcp9gGk1nYXT3Dish8j/fkJTkUJTHgCiV3lZJ
X-Google-Smtp-Source: AGHT+IFEAmvmPe5Ai4rWQLDU4AQ67rz0Fc7Z5z4KYnBO/AM5VihqMalzSUsfPg7QwwzoPoxhAedDHg==
X-Received: by 2002:a17:902:da8d:b0:205:3525:81bd with SMTP id d9443c01a7336-2076e36a660mr137213235ad.29.1726271255842;
        Fri, 13 Sep 2024 16:47:35 -0700 (PDT)
Received: from localhost (p4468007-ipxg23001hodogaya.kanagawa.ocn.ne.jp. [153.204.200.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-207947365ddsm1480545ad.283.2024.09.13.16.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 16:47:35 -0700 (PDT)
Date: Fri, 13 Sep 2024 23:47:21 +0000 (UTC)
Message-Id: <20240913.234721.69069700051999903.fujita.tomonori@gmail.com>
To: andrew@lunn.ch
Cc: fujita.tomonori@gmail.com, hfdevel@gmx.net, netdev@vger.kernel.org,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next 5/5] net: tn40xx: register swnode and connect
 it to the mdiobus
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <04d22526-205b-4a59-b344-5bafdb9ce37f@lunn.ch>
References: <trinity-e71bfb76-697e-4f08-a106-40cb6672054f-1726083287252@3c-app-gmx-bs04>
	<20240913.065543.2091600194424222387.fujita.tomonori@gmail.com>
	<04d22526-205b-4a59-b344-5bafdb9ce37f@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Fri, 13 Sep 2024 14:46:06 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

>> > +#define AQR105_FIRMWARE "tehuti/aqr105-tn40xx.cld"
>> 
>> This firmware is for AQR PHY so aquantia directory is the better
>> place?
> 
> I don't know the correct answer to this. One thing to consider is how
> it gets packaged.
> 
> on my Debian system:
> 
> p   firmware-adi                                             - Binary firmware for Analog Devices Inc. DSL modem chips (dummmy pac
> i   firmware-amd-graphics                                    - Binary firmware for AMD/ATI graphics chips                         
> p   firmware-ast                                             - Binary firmware for ASpeed Technologies graphics chips             
> p   firmware-ath9k-htc                                       - firmware for AR7010 and AR9271 USB wireless adapters               
> p   firmware-ath9k-htc-dbgsym                                - QCA ath9k-htc Firmware ELF file                                    
> p   firmware-atheros                                         - Binary firmware for Qualcomm Atheros wireless cards                
> p   firmware-b43-installer                                   - firmware installer for the b43 driver                              
> p   firmware-b43legacy-installer                             - firmware installer for the b43legacy driver                        
> p   firmware-bnx2                                            - Binary firmware for Broadcom NetXtremeII                           
> p   firmware-bnx2x                                           - Binary firmware for Broadcom NetXtreme II 10Gb                     
> p   firmware-brcm80211                                       - Binary firmware for Broadcom/Cypress 802.11 wireless cards
> 
> It seems to get packaged by vendor. Given the mess aquantia firmware
> is, we are going to end up with lots of firmwares in firmware-aquantia
> which are never needed. If the firmware is placed into tehuti,
> installing firmware-tehuti gives you just what you need.

Understood. Looks like "tehuti" directory makes things easier if
firmware could be get packaged in the way. On my Ubuntu system, one
linux-firmware package installs many firmware.

