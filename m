Return-Path: <netdev+bounces-155743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1536A03895
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 08:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38A317A23C9
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 07:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6C91DFE00;
	Tue,  7 Jan 2025 07:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nY07grAI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93488339A1
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 07:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736233843; cv=none; b=tiCwJVzYXMEK7UXfEIFMkonvV3eDuqTpt6EcsaZHbg1qxg9IL5qBkG//8p/3UvtG6TmoW4LxFpbZqmC9XoHAygIuRxX3wIqXJ2Hk1/me8YC4uU/Xj9aKxhR/ko2vcX0rXOkTS9pXTrnbnBT/+JAiRRUzZiMiJ33icc/wuB0WeEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736233843; c=relaxed/simple;
	bh=knmlkzZmomk2UGvcFIon1Q9Wd0GhVKMpQAKMHPp8gtk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=sYkB+hof5ISROnNHB06igqSa1ZYLbZKdQfhKuBkMKzw0NpEBwi5VuZdzGjUODk4HsAmzbfScgdPNjCDFoc0yG1Sv/BssE9zI2Hv1T0ZodAakmH1YxV6YsPCPfLpPGPQc6wehGMIHmtQj9gxkb8B3mR8D/GCBeljdrTfpeXHhOgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nY07grAI; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-38633b5dbcfso14520875f8f.2
        for <netdev@vger.kernel.org>; Mon, 06 Jan 2025 23:10:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736233839; x=1736838639; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LxC2QvRLaa9fhyMEEmnqLTIucuZnpaiOnMycBsmrjig=;
        b=nY07grAIu5GxOWhj8qkyen4YX1WpMqUKvSnvoMmwLJxFFSlSe7p2DqCN4cX0l0U7bx
         Yz6lG7gaTXkjoNcAciRuA31qEBmLw/lBrhZhANJjt0raTro+naYFpFj/vmlHtA90J3pb
         rsGR5/JMDSPojgnbOgmPkAEm9UPJwX1aHLbJxMESzj49+jgJtPR2iauDKpiezAnB3/5q
         YATiBO/ZLJd+tGSjSWyT0s/Lzrs5DJTlRv90ajXdpbUfzuNo64vXRChAwMHEX7JTm7e7
         dd1/NI5OL+/jRBHLAX6h8tAujlQjxmatNMnDJywSfgGjZb99CFhQhvWNXH/txizC0byt
         K77A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736233839; x=1736838639;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LxC2QvRLaa9fhyMEEmnqLTIucuZnpaiOnMycBsmrjig=;
        b=Vu/48DcU/fhbf8pUJtzf7HkvSYc3sd7Bj8zqkc4RQMl0mA/vIf1zoVIZbZo3w4HPby
         tFRgOAlr2Stf5RXiJQ3+wWInNggGA+v8Qp8cJQKUUcibKofkA+szcueyeDnlQ8Ant56O
         kWUH136Dw0jx6lUZP8yADdpiQ0RjdltfVqtGhMlEU/cEzag8uy/v4BVhgtixgdfRjdxp
         Jq9BuO2Zc8o9XP9WEOkBGeidWF1tCyehhMAyAEQbPdAJR/iupl7W+wtgzU+ZQmqkJnCe
         9v+2lAe5Py6uMO4qc92eyr/m1CVW8ImU17xGGkywMXssaYHt5wJr6lOTZPW7oA/3FaBx
         eKLw==
X-Forwarded-Encrypted: i=1; AJvYcCXJT2OmpCNyE8mLjTZ1lTTvdeN3u/t4OPhUKHUMs4NJJWUrJh45hAHG8yXm0oVIxTs0D9+8Uf0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmN6B6+p1XEYult+cZhmOtbnK8oUYbAHxKJVEw3+8vDbvW2Yda
	ayjiqS8lnKlLzbeaPR0p2WVDfgdO0FkD+SbpVvogUCQEo7J18GDRKjNB/a879yM=
X-Gm-Gg: ASbGncvdnDkrHx1OjhuM+ls65OZo6fGtyIpEVFiqcK6iTCFrXV//P6Pk0mPEqWVR1IK
	dFYXww3HmLBF3Ub7HoP5g1e4j7PUotISMVQeZjWKL0HTaV7caAkCYBpyO8u9JBmTcSh8ziljYwJ
	ut6hQXUTdRosyxlKEamlbsA3gbzdo0ZSA7MepDl+PdxeM11x2qTLstntocNKEY7QEb3jddZCuhE
	c/iswtZpRiU7nsx6VX+LlalJFprLwAVmm6pVXenxP/MEZ07MbEHSXKsOVoVrw==
X-Google-Smtp-Source: AGHT+IFIR4835eW6e7ZZ8gI1DpDQcwGI8R4kehDIZa6LnIgHnu7A7jNtqUCLWF6+KIJF30TnCX1P0g==
X-Received: by 2002:adf:a445:0:b0:38a:2b39:9205 with SMTP id ffacd0b85a97d-38a2b3993dfmr39812671f8f.33.1736233838547;
        Mon, 06 Jan 2025 23:10:38 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c829235sm48855108f8f.15.2025.01.06.23.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 23:10:38 -0800 (PST)
Date: Tue, 7 Jan 2025 10:10:34 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev, Divya Koppera <divya.koppera@microchip.com>,
	andrew@lunn.ch, arun.ramadoss@microchip.com,
	UNGLinuxDriver@microchip.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, richardcochran@gmail.com,
	vadim.fedorenko@linux.dev
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH net-next 3/3] net: phy: microchip_rds_ptp : Add PEROUT
 feature library for RDS PTP supported phys
Message-ID: <f65330e7-825b-46ff-8e95-c046a2359705@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250103090731.1355-4-divya.koppera@microchip.com>

Hi Divya,

kernel test robot noticed the following build warnings:

url:    https://github.com/intel-lab-lkp/linux/commits/Divya-Koppera/net-phy-microchip_rds_ptp-Header-file-library-changes-for-PEROUT/20250103-171126
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250103090731.1355-4-divya.koppera%40microchip.com
patch subject: [PATCH net-next 3/3] net: phy: microchip_rds_ptp : Add PEROUT feature library for RDS PTP supported phys
config: arm64-randconfig-r072-20250107 (https://download.01.org/0day-ci/archive/20250107/202501071428.F9gIQY3T-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 096551537b2a747a3387726ca618ceeb3950e9bc)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202501071428.F9gIQY3T-lkp@intel.com/

smatch warnings:
drivers/net/phy/microchip_rds_ptp.c:247 mchp_rds_ptp_perout_off() error: uninitialized symbol 'event'.

vim +/event +247 drivers/net/phy/microchip_rds_ptp.c

568c86a861124f Divya Koppera 2025-01-03  228  static int mchp_rds_ptp_perout_off(struct mchp_rds_ptp_clock *clock,
568c86a861124f Divya Koppera 2025-01-03  229  				   s8 gpio_pin)
568c86a861124f Divya Koppera 2025-01-03  230  {
568c86a861124f Divya Koppera 2025-01-03  231  	u16 general_config;
568c86a861124f Divya Koppera 2025-01-03  232  	int event;
568c86a861124f Divya Koppera 2025-01-03  233  	int rc;
568c86a861124f Divya Koppera 2025-01-03  234  
568c86a861124f Divya Koppera 2025-01-03  235  	if (clock->mchp_rds_ptp_event_a == gpio_pin)
568c86a861124f Divya Koppera 2025-01-03  236  		event = MCHP_RDS_PTP_EVT_A;
568c86a861124f Divya Koppera 2025-01-03  237  	else if (clock->mchp_rds_ptp_event_b == gpio_pin)
568c86a861124f Divya Koppera 2025-01-03  238  		event = MCHP_RDS_PTP_EVT_B;

What about: else return -EINVAL;?

568c86a861124f Divya Koppera 2025-01-03  239  
568c86a861124f Divya Koppera 2025-01-03  240  	/* Set target to too far in the future, effectively disabling it */
568c86a861124f Divya Koppera 2025-01-03  241  	rc = mchp_set_clock_target(clock, gpio_pin, 0xFFFFFFFF, 0);
568c86a861124f Divya Koppera 2025-01-03  242  	if (rc < 0)
568c86a861124f Divya Koppera 2025-01-03  243  		return rc;
568c86a861124f Divya Koppera 2025-01-03  244  
568c86a861124f Divya Koppera 2025-01-03  245  	general_config = mchp_rds_phy_read_mmd(clock, MCHP_RDS_PTP_GEN_CFG,
568c86a861124f Divya Koppera 2025-01-03  246  					       MCHP_RDS_PTP_CLOCK);
568c86a861124f Divya Koppera 2025-01-03 @247  	general_config |= MCHP_RDS_PTP_GEN_CFG_RELOAD_ADD_X_(event);
568c86a861124f Divya Koppera 2025-01-03  248  	rc = mchp_rds_phy_write_mmd(clock, MCHP_RDS_PTP_GEN_CFG,
568c86a861124f Divya Koppera 2025-01-03  249  				    MCHP_RDS_PTP_CLOCK, general_config);
568c86a861124f Divya Koppera 2025-01-03  250  	if (rc < 0)
568c86a861124f Divya Koppera 2025-01-03  251  		return rc;
568c86a861124f Divya Koppera 2025-01-03  252  
568c86a861124f Divya Koppera 2025-01-03  253  	if (event == MCHP_RDS_PTP_EVT_A)
568c86a861124f Divya Koppera 2025-01-03  254  		clock->mchp_rds_ptp_event_a = -1;
568c86a861124f Divya Koppera 2025-01-03  255  
568c86a861124f Divya Koppera 2025-01-03  256  	if (event == MCHP_RDS_PTP_EVT_B)
568c86a861124f Divya Koppera 2025-01-03  257  		clock->mchp_rds_ptp_event_b = -1;
568c86a861124f Divya Koppera 2025-01-03  258  
568c86a861124f Divya Koppera 2025-01-03  259  	return 0;
568c86a861124f Divya Koppera 2025-01-03  260  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


