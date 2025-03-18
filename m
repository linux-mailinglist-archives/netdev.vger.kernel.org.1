Return-Path: <netdev+bounces-175763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F37AA676AE
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 15:42:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7AD6163FAF
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 14:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E16F20DD7D;
	Tue, 18 Mar 2025 14:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKz7R6xv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A86620B81F;
	Tue, 18 Mar 2025 14:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742308800; cv=none; b=cVYDdHdwMJvaUBQZaY9F5ITr8GJPqrNeyM94blEKqWLQF6Y7VSCvJBF4WQ4BoJ5hToDkxtOWJTZL4PowoHwZ7FJtggI1vUi/+CTRa8GanCZQ7oK5t+8YhZoMWngcrbVo4tC5h0JVokU4VMoLmM4s6q6BdOzIsJzOlQjxJuuluVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742308800; c=relaxed/simple;
	bh=mbRD/1PbuXTS0E3JUTtK1e2LvIi1E8UOY2LTsI1dgAU=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=cqf/Z3WiaeknyfatXpnNGVRxAdfuGwAwkd3vQk85GDBpnCN/6hRaMu53A+lkBod7dTLoezRmIOZVVh20e4decZ8zZpaIYL2hBx+0q6PyYxMFKeSKHzpKmb9QCF2DdqCIvCueaIw99G9Ci1MF3vweN8cgaAZcj+XYwiNoRHpvvmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mKz7R6xv; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-225e3002dffso61573725ad.1;
        Tue, 18 Mar 2025 07:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742308794; x=1742913594; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zLZLDpFG7x1h9JNPf8SL5DH50HKR78iR8QwP6K16Sws=;
        b=mKz7R6xvXwVwOjZ+az2XowGGK5936YHufCQL9eW4EOvNUSr1TwqgqfAWeFsaBGfmd+
         pjgU0m6ICO29ynQNZUL2DbmXU5bVhDRo5q8k4JXKPhg8QsXhHDCAbnJYnMoN5zYYIXdb
         kD7JCeucdaLx/JqG85v+9DKcUdgTFA+181W53YXa1xvcvXt+zK420iCh4r3WsMHm7IlS
         L0RD7o22d1kVVCU3EJApr8h0wZLO0PeqktR3qsPMPFNmBW8sTBIzcjhSHCilhWrm4njy
         72C9fuGPVf/e8IhL7ThkrFIKeAkPIFc1s1cPDO0++LorIZtAbRKOhk0zyR4WlrmKiOSA
         6Dwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742308794; x=1742913594;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zLZLDpFG7x1h9JNPf8SL5DH50HKR78iR8QwP6K16Sws=;
        b=hujKCJs6UeKESqMlUhUZmE9hnOHXFuleTv1kO9bq23ZR702OldK6qi132UBWtdzLQN
         aY0Mxv4YaaYzS33lQbuVNvjfG/zkV9RrHuNEyjX9qmas+A2a/CKi7Y0FrRCPV1dEh4WM
         nxUA//ReFkqyZDvxThZoUk4Z0VMU4cARmILbR0r+dSqZ3LfIUzCwTuuMChvbLO8njnCL
         Y+uN4pOft3uHSzISj51jBZpMZdjrOUgmJgdByarrYiFU+QF44aj8I83IFWEuxfULmAGU
         3NrIDGz+TyXueyg9p1SDLh0jNrdF0G4X+lQ9xd0s2hmQxUD/7BZkHv0H1MnvEgBGhQEA
         hFRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXL1mLrgdhwd2w6mnmAlj3ChD5Gz+ZM8FZSIwtNOU3b1A1LddupRd0kuUpf1XX5Y6oE8/e93nyW@vger.kernel.org, AJvYcCXXhzDwwIoewXLhZr6OqKseb00ktA++If8nlvV9507H5cEoT1Xpt2ydACy7xS5Ma8BJmP/3BEDH0Dl/5n8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSowcGsdkzXPaoYOxUE2xnz0FggXz2/JkOVWW3+A04kaa3MCEu
	1kJdxmUzmujdVAOdpIdHHTUcKoLSVXzzKaz2RG9XGv3pcbA5+qvhOfiv8dA=
X-Gm-Gg: ASbGncv1LrhFxa5bvtDNL2IM0kSc/l+L0J/3gJ6Z6s5t89gNW7GrqfYiQHVU794Z61R
	8Mt17Y2GC3JitoAdoLg54+SDJPwyH/JrfvPyy66oZylfJJvGfL/e29VFy2koH+On6So39b9peRf
	C2n4GACe+zz6Q/KjNS66BWhNoOD5ADgtz5Xiy0GPM9gJylugtrw3JKHLCW/VvDyzckdBiryQ7tO
	nqRlVsrkGU5MOYQgcSwdKqPexIEo7+8sWKrK7Exj1eKg8NPxQViZcn8LmVFlFV5WI73mqZ1Icw4
	+GGXX7GV/6XkM1Z5gk1XExQBtE6Z0UKPEZD8DrvZj2QpMsj0QeIViFzuj+47LMExTZkyW2O2t1O
	cfREFO+HVUMGArsXs9pTB+PblooH5
X-Google-Smtp-Source: AGHT+IHDxjl4wr36J9a99z+NqUdp2ZbndR7Kpom6ltHc66IzgR13RpgOs9HfjAyAN17N7wMIte+74w==
X-Received: by 2002:a05:6300:4046:b0:1f5:56fe:b437 with SMTP id adf61e73a8af0-1fa45a68e04mr6892619637.32.1742308792371;
        Tue, 18 Mar 2025 07:39:52 -0700 (PDT)
Received: from [192.168.0.12] (124-218-201-66.cm.dynamic.apol.com.tw. [124.218.201.66])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af56ea7bd01sm7604292a12.61.2025.03.18.07.39.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 07:39:51 -0700 (PDT)
From: "Lucien.Jheng" <lucienx123@gmail.com>
X-Google-Original-From: "Lucien.Jheng" <lucienX123@gmail.com>
Message-ID: <0aa1cebd-be6e-478f-8fb2-8a9072249bd2@gmail.com>
Date: Tue, 18 Mar 2025 22:39:46 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next PATCH 1/1] net: phy: air_en8811h: Add clk
 provider for CKO pin
To: Daniel Golle <daniel@makrotopia.org>
Cc: linux-clk@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, ericwouds@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, joseph.lin@airoha.com,
 wenshin.chung@airoha.com, lucien.jheng@airoha.com
References: <20250318133105.28801-1-lucienX123@gmail.com>
 <20250318133105.28801-2-lucienX123@gmail.com>
 <Z9l6rWJkE2ALmfzM@makrotopia.org>
Content-Language: en-US
In-Reply-To: <Z9l6rWJkE2ALmfzM@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Daniel

I'll correct those things in the next version,

thank you for the detailed review.


Daniel Golle 於 2025/3/18 下午 09:52 寫道:
> On Tue, Mar 18, 2025 at 09:31:05PM +0800, Lucien.Jheng wrote:
>> EN8811H outputs 25MHz or 50MHz clocks on CKO, selected by GPIO3.
>> CKO clock operates continuously from power-up through md32 loading.
>> Implement clk provider driver so we can disable the clock output in case
>> it isn't needed, which also helps to reduce EMF noise
>>
>> Signed-off-by: Lucien.Jheng <lucienX123@gmail.com>
> White-space (tabs vs. spaces) could still be improved. See inline below.
> However, I don't think it's worth another iteration just for that, so
> only should there be comments from other reviewers and you anyway send
> another version, then you can fix that as well.
>
> Other than that:
> Reviewed-by: Daniel Golle <daniel@makrotopia.org>
>
>> ---
>>   drivers/net/phy/air_en8811h.c | 95 +++++++++++++++++++++++++++++++++++
>>   1 file changed, 95 insertions(+)
>>
>> diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811h.c
>> index e9fd24cb7270..47ace7fac1d3 100644
>> --- a/drivers/net/phy/air_en8811h.c
>> +++ b/drivers/net/phy/air_en8811h.c
>> @@ -16,6 +16,7 @@
>>   #include <linux/property.h>
>>   #include <linux/wordpart.h>
>>   #include <linux/unaligned.h>
>> +#include <linux/clk-provider.h>
>>   
>>   #define EN8811H_PHY_ID		0x03a2a411
>>   
>> @@ -112,6 +113,11 @@
>>   #define   EN8811H_POLARITY_TX_NORMAL		BIT(0)
>>   #define   EN8811H_POLARITY_RX_REVERSE		BIT(1)
>>   
>> +#define EN8811H_CLK_CGM     0xcf958
>> +#define EN8811H_CLK_CGM_CKO     BIT(26)
>> +#define EN8811H_HWTRAP1     0xcf914
>> +#define EN8811H_HWTRAP1_CKO     BIT(12)
>> +
> Existing precompiler macro definitions use tab characters between the
> macro name and the assigned value, your newly added ones use spaces.
>
>>   #define EN8811H_GPIO_OUTPUT		0xcf8b8
>>   #define   EN8811H_GPIO_OUTPUT_345		(BIT(3) | BIT(4) | BIT(5))
>>   
>> @@ -142,10 +148,15 @@ struct led {
>>   	unsigned long state;
>>   };
>>   
>> +#define clk_hw_to_en8811h_priv(_hw)			\
>> +	container_of(_hw, struct en8811h_priv, hw)
>> +
>>   struct en8811h_priv {
>>   	u32		firmware_version;
>>   	bool		mcu_needs_restart;
>>   	struct led	led[EN8811H_LED_COUNT];
>> +	struct clk_hw        hw;
>> +	struct phy_device *phydev;
> The existing struct members are indented with tabs, your newly added
> members use spaces. Not a big deal, but it'd be better to use the same
> style.

