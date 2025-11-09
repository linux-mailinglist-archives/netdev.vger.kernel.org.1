Return-Path: <netdev+bounces-237038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 12904C43BC9
	for <lists+netdev@lfdr.de>; Sun, 09 Nov 2025 11:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7226F342DA2
	for <lists+netdev@lfdr.de>; Sun,  9 Nov 2025 10:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92672C2ABF;
	Sun,  9 Nov 2025 10:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="QCy+5ifj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFDC26738D
	for <netdev@vger.kernel.org>; Sun,  9 Nov 2025 10:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762684630; cv=none; b=VVEG7WgYbBAcJrwFXviHD+XiS7ceckiLrRTnDxVD/uHKk8D0xEwN5l3OaOumcGY+plWiWkMOV9USiNh8sLS7ZlmVbPXG1o0GdPPIqp5T6zBiq1vTRrsHelbrje6hFWNY3eZIXFNG+tirqJ5JAxF+idEAhktXTvl7MxCuImHCFlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762684630; c=relaxed/simple;
	bh=lm/iZbsyFzxn5kQIG2Ub7G//rZ8rGXfD4g+y3AG04PQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZX6NKIeZ+eXN85yL+aSeD4k6YNgompVCTurCZSDmGbgULoS2M9/vk3I2f8+IOSLyyP9Qr3No1ValrAcfw2YG4BxvQIyhb34VpI99HlAINTXOaVxYrZYXotBqaVlRqQ1ZVsWQqAxZ9Gw8YeU+92+f5QcmZbAoWNV9QaypRI63R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=QCy+5ifj; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-64088c6b309so3402552a12.0
        for <netdev@vger.kernel.org>; Sun, 09 Nov 2025 02:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1762684627; x=1763289427; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wLEi3FY3R8yLDeWkcJs5QaKXb4kMtZGvr5BAdfLs/b8=;
        b=QCy+5ifj8yvLmB/M4lfeR7EUrZidETntbv4TF++jiQyr5t1zS2xhuqewNmyt3k4zsA
         LoJlmyxHvXj/lCPWais4omJTA2/CHS0WqO1KiWMNLyypwGb9cdKQ6Xz721LpMqpT2V6P
         6AWKZgf2TxyAdAVthJc2No4druBPQpfmaCvGXjSjYXO9vEy/AXQqpJZ1VCskN8uKbUrJ
         0H38vG0y1nELw+QLe6OhNchMVP6SXsN1+hle/4Qbv3Bgvx72hDDmLgIUFVDJ3H6RCsAk
         oPm7KGcgpGERuIKbwf6SmZIMSNGtI73r0ylTAK/tiTos9xnxs07nBLz+Epj+MpUEdnkV
         qypw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762684627; x=1763289427;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wLEi3FY3R8yLDeWkcJs5QaKXb4kMtZGvr5BAdfLs/b8=;
        b=jX3A4P5Y5WctU9KYfYaaJA0iaIUUFJURigHbRyvtFUWvT0xBr4N5wdcM0KDcEGuWnY
         6LMraMKgSx1iGc56C3FVnwHG8X+ofaQ4cbLR2/Vlefa+gvX626Z73O9psT+EGDzEzrXY
         1QpqBp6Sw9hsTNHh7JN0Xy9uUBSI9HnXKSKC0xUjCiE86VdwOFpxORKytO2Z74G/gX4i
         GOAF4Jg+5H36QRh5kyJ5GljjMfgsbH8H9ivKhqF38kJdTvqQeOUlKVbGt0vHKrKtLyhc
         Iar1/w/oRCq47yNVZlVSQ0yTmbpoFJErKb6V6Q4S/mjpXn0N/0WDeUa+oKsFRhhAn4M5
         37jg==
X-Forwarded-Encrypted: i=1; AJvYcCUimzExjsAEyPyHlGA2zmul2y9yKh8iuGZ20D0FutaoCXw3xLJTOhWVuufuGzPf4mAN5Ay63pA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwubGU9DTeWy7TbA346ONkvrAfnap59LadtlV9X4KpvrU15zZaR
	TBSoO/QgjjuaRgudPQPKHM29JFZicED5Y1bz/01ixM0hxTUq7PIunrYazX5Wrxf7IJU=
X-Gm-Gg: ASbGncvtDLY5QtPIQFVzshU1406e1AdIvfV4FvdRIL4y0qG+oJEu9UOyWRAANU+RmCB
	yu9SZQaorEUBvVY9c+U/9b31IDiqq+pEPF6M1DAuwjjpXKYPGOcQko67vaRyJe2hLy919cQ6ict
	92sfkT0uxE3fklU8o4OajEoTax38kj5CCm90oKurnKCPtqTx0rV5JKyEzaqr0Bsgyz4h0S7j7Ha
	LTI/eik9Pw8vxvO4AN6iF+oRFQQvHJVFmOMbChpasZ5hjLvGUFbwEC2aEkwqdA+Pu5Zjtdinfzd
	NTf6Qf08n5Mz21Gqjjy9lRCFBDZSozs3mePjAfMw1fAkgy+B2vjH6yU4jUCs5vk1it5PqE+HlBA
	oG4R87EE5G8Op6m+Iec2goa79JkVazFz9Y6tVwqjHr0XCsGDdMVh5ekCfKfcCZ2UkA+mtaZ/IPb
	pS3QTqWPQfdH2NS3jV
X-Google-Smtp-Source: AGHT+IHaHIj6pMYgrtnGgyPEbnoCPcv9+h0U8aTlvRy8s+b5dWYGafxzPV9vjN/4tKYk16VfiLaOFA==
X-Received: by 2002:a17:907:2d8d:b0:b40:b54d:e687 with SMTP id a640c23a62f3a-b72e055e508mr471128366b.47.1762684626905;
        Sun, 09 Nov 2025 02:37:06 -0800 (PST)
Received: from jiri-mlt ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bfa0f1bbsm758571366b.65.2025.11.09.02.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 02:37:06 -0800 (PST)
Date: Sun, 9 Nov 2025 11:37:03 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Saeed Mahameed <saeed@kernel.org>
Cc: Daniel Zahka <daniel.zahka@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Srujana Challa <schalla@marvell.com>, 
	Bharat Bhushan <bbhushan2@marvell.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Brett Creeley <brett.creeley@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Michael Chan <michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Sunil Goutham <sgoutham@marvell.com>, Linu Cherian <lcherian@marvell.com>, 
	Geetha sowjanya <gakula@marvell.com>, Jerin Jacob <jerinj@marvell.com>, 
	hariprasad <hkelam@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>, 
	Tariq Toukan <tariqt@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, 
	Petr Machata <petrm@nvidia.com>, Manish Chopra <manishc@marvell.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, 
	Loic Poulain <loic.poulain@oss.qualcomm.com>, Sergey Ryazanov <ryazanov.s.a@gmail.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Vladimir Oltean <olteanv@gmail.com>, 
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
	Dave Ertman <david.m.ertman@intel.com>, Vlad Dumitrescu <vdumitrescu@nvidia.com>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/2] net/mlx5: implement swp_l4_csum_mode via
 devlink params
Message-ID: <utjcgietdlf3jva5deqt5a6qtv7clkysth473hfa3szlwmll7l@6i6fqhem64mf>
References: <20251103194554.3203178-1-daniel.zahka@gmail.com>
 <20251103194554.3203178-3-daniel.zahka@gmail.com>
 <mhm4hkz52gmqok56iuiukdcz2kaowvppbqrfi3zxuq67p3otit@5fhpgu2axab2>
 <db5c46b4-cc66-48bb-aafb-40d83dd3620c@gmail.com>
 <6aa2f011-3ba5-4614-950d-d8f0ec62222b@gmail.com>
 <p3pj3mu4mabgninwowqikegeotxgzhc4yptf7qrfhns37bnkoz@ugkbgvlkxqxb>
 <78db1fab-e482-4ebc-82ce-ba84b3f561e2@gmail.com>
 <aQ7XWOI68rVDRewR@x130>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aQ7XWOI68rVDRewR@x130>

Sat, Nov 08, 2025 at 06:38:32AM +0100, saeed@kernel.org wrote:
>On 04 Nov 09:48, Daniel Zahka wrote:
>> 
>> 
>> On 11/4/25 9:39 AM, Jiri Pirko wrote:
>> > Tue, Nov 04, 2025 at 01:51:16PM +0100, daniel.zahka@gmail.com wrote:
>> > > 
>> > > On 11/4/25 6:38 AM, Daniel Zahka wrote:
>> > > > 
>> > > > On 11/4/25 5:14 AM, Jiri Pirko wrote:
>> > > > > I did some research. 0/DEVICE_DEFAULT should not be ever reported back
>> > > > > from FW. It's purpose is for user to reset to default FW configuration.
>> > > > > What's the usecase for that? I think you could just avoid
>> > > > > 0/DEVICE_DEFAULT entirely, for both get and set.
>> > > > I find that 0/DEVICE_DEFAULT is reported back on my device. I have
>> > > > observed this same behavior when using the mstconfig tool for setting the
>> > > > parameter too.
>> > > e.g.
>> > > $ dmesg | grep -i mlx | grep -i firmware
>> > > [   10.165767] mlx5_core 0000:01:00.0: firmware version: 28.46.1006
>> > > 
>> > > $ ./mstconfig -d 01:00.0 -b ./mlxconfig_host.db query SWP_L4_CHECKSUM_MODE
>> > > 
>> > > Device #1:
>> > > ----------
>> > > 
>> > > Device type:        ConnectX7
>> > > Name:               CX71143DMC-CDAE_FB_Ax
>> > > Description:        ConnectX-7 Ethernet adapter card; 100 GbE OCP3.0;
>> > > Single-port QSFP; Multi Host; 2 Host; PCIe 4.0 x16; Crypto and Secure Boot
>> > > Device:             01:00.0
>> > > 
>> > > Configurations:                                          Next Boot
>> > >         SWP_L4_CHECKSUM_MODE DEVICE_DEFAULT(0)
>> > This is next-boot value. You should query current (--enable_verbosity)
>> > to show in param get.
>> 
>> I am still seeing that DEVICE_DEFAULT(0) is read back:
>> 
>> $ ./mstconfig --enable_verbosity -d 01:00.0 -b ./mlxconfig_host.db query
>> SWP_L4_CHECKSUM_MODE
>> 
>> Device #1:
>> ----------
>> 
>> Device type:        ConnectX7
>> Name:               CX71143DMC-CDAE_FB_Ax
>> Description:        ConnectX-7 Ethernet adapter card; 100 GbE OCP3.0;
>> Single-port QSFP; Multi Host; 2 Host; PCIe 4.0 x16; Crypto and Secure
>> Boot
>> Device:             01:00.0
>> 
>> Configurations:                  Default             Current       Next Boot
>>         SWP_L4_CHECKSUM_MODE DEVICE_DEFAULT(0) DEVICE_DEFAULT(0)   
>> DEVICE_DEFAULT(0)
>> 
>
>When default value of nvconfig is managed by FW, 0 will always mean
>DEVICE_DEFAULT, and it is a way for the driver to reset back to default on
>write, but on read FW should never return it, so this is a FW bug.

What I understand is that 0 is still okay to be read back after writing
it. I don't think it is a fw bug. Also, I don't think we should expose
"default" as devlink param value.

>
>But this shouldn't block this series so just return 'default', from the
>driver perspective we should return 'default' when we know 0 means that.
>

