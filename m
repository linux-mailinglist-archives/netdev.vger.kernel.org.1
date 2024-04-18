Return-Path: <netdev+bounces-89201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AEFD8A9AC4
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 15:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EDFB1F252BA
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 13:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1E015AAB7;
	Thu, 18 Apr 2024 13:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EVs8k9Zl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F8B156F54;
	Thu, 18 Apr 2024 13:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713445264; cv=none; b=X/DUgKNxat13PQb+G3uPsCtW36BhLBk4FC5bCvacU0Kvf2wTIX/C+hoSBdIRWSbWlrbqBHd8kHRk0gtwt8oDwJZyNCsqpdcgugt0pkAI9hV0bGNzkXd1OkYPPrXzIC6PCzRsukBSVJxAiQTR+YzyZvOd1KfNrbnMdDTrl1hOaU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713445264; c=relaxed/simple;
	bh=yG137aqOWL2/Es/26zWsmfotnkZYxRw8FLvGRhU1IBk=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ixpBS1O173PRlL2uduQCE5GeVDCI1vgrnBQqNYKKx8ct3A3lxONIjhpxGwGFy240RVAFiGv9ZBN89W/WgSV97gyzXUWsJAUlpTbbOxyv7kRZTBTNhteMQVXIlufPnd3Sor1wSIQTiOQaLPDToUscBhfc6M1QGPqiv1Z1d4fAHQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EVs8k9Zl; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5f77640a4dcso50765a12.3;
        Thu, 18 Apr 2024 06:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713445259; x=1714050059; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tUSx5+0U+MIn5uN8jxqNtlkM0T1KLUCAxkQDoeRNuAs=;
        b=EVs8k9ZloncJJkI22XTzdMBCHbpt1dgmKYcTCzLVnUmji8Ywnddl32uH71GgRoor2M
         UpF9CiPiskbNTaHmUpIdLzFLjb4YZEwDvB7siSCGsU0PmSrib6sgxznBtBftLesR4SOz
         62ENQPGc46Q9njAFRrQirrtvigX45xoe2AU+tT3prPpLRwDY9ZhN29MgSAzJGWN7JpMC
         1CTPZfV3vWVWvi1fZCm6LdMaEnS/QFL/zptoFvAgVoOq3EOCsynLwE8Ag9qNDS+eMvLo
         Z7tpMTilfjQq/5D5YQ3T3/l6PjApMGBq+4JJZJfzeaQQN5o/w8tfKvQ5/cUiPvwvy7Mc
         ATlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713445259; x=1714050059;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tUSx5+0U+MIn5uN8jxqNtlkM0T1KLUCAxkQDoeRNuAs=;
        b=to9FtaAHI23cvBfp/dnCCxNXYreDXbISkSNr0Sc9zuaKF3kSgVyQWDcTkhMMyHlVa7
         GJzYXy0pHu4v62DOuv8zl709MWfelSs60hyKkakRRjR2qL09pm/X0eo5bWX6LPsiYdFB
         Ib/LMAP7HyT5uS3faNdCcyKa9tc4EY/qP6aLcAa10ItGrtxY9cL/8NiBcOfdGxwrZouC
         d10cbwRKsyCoNle58Zejdg4hX+TeTqY6o3UQFsR2jiwTmQ6EF07k7OFRg9cx13zEdajx
         pwyg2pYRMBaJ9QVm542QBnONA8uFTxAISPyuY9N+kPgf9ahqAU2Oj/pcEv2extSlUWZg
         znsQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7/Z54pz/CmKfulOnTkbLI91Le3GuLVw+8bUwSIaMghKKRy0zGWq7t7Kk/mVwE5LkeSCnl3+v2AdpMGq/viBKqm/MoQbfKLVjkCKALsND3nehg/Jffa55J05JggIkhfSu9f/QSJF8=
X-Gm-Message-State: AOJu0Ywc+QKD/ryymLRQ6a/M9YzhRdTcYjQ+bfvqBMxsdspyJQSfGJqz
	TDVusXv6J8XJfca2jeI8PBox1vsM7moMwKabCXYk9d5B6d/d76Y2
X-Google-Smtp-Source: AGHT+IH9Arxe9QYJmxruiuiDY72PPgKUD+eChzLJUkPkDhcRFCr2LCrYi1wK+Gniinh8LaXfta6Usw==
X-Received: by 2002:a17:90b:344a:b0:2a7:aa52:5568 with SMTP id lj10-20020a17090b344a00b002a7aa525568mr2564303pjb.0.1713445258623;
        Thu, 18 Apr 2024 06:00:58 -0700 (PDT)
Received: from localhost (p5315239-ipxg23901hodogaya.kanagawa.ocn.ne.jp. [180.34.87.239])
        by smtp.gmail.com with ESMTPSA id s8-20020a17090a1c0800b002a610ef880bsm3427987pjs.6.2024.04.18.06.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 06:00:58 -0700 (PDT)
Date: Thu, 18 Apr 2024 22:00:47 +0900 (JST)
Message-Id: <20240418.220047.226895073727611433.fujita.tomonori@gmail.com>
To: gregkh@linuxfoundation.org
Cc: fujita.tomonori@gmail.com, netdev@vger.kernel.org, andrew@lunn.ch,
 rust-for-linux@vger.kernel.org, tmgross@umich.edu
Subject: Re: [PATCH net-next v1 4/4] net: phy: add Applied Micro QT2025 PHY
 driver
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <2024041549-voicing-legged-3341@gregkh>
References: <20240415104701.4772-1-fujita.tomonori@gmail.com>
	<20240415104701.4772-5-fujita.tomonori@gmail.com>
	<2024041549-voicing-legged-3341@gregkh>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi,

On Mon, 15 Apr 2024 13:15:08 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

>> +kernel::module_phy_driver! {
>> +    drivers: [PhyQT2025],
>> +    device_table: [
>> +        DeviceId::new_with_driver::<PhyQT2025>(),
>> +    ],
>> +    name: "qt2025_phy",
>> +    author: "FUJITA Tomonori <fujita.tomonori@gmail.com>",
>> +    description: "AMCC QT2025 PHY driver",
>> +    license: "GPL",
>> +}
> 
> What about support for MODULE_FIRMWARE() so it will be properly loaded
> into the initramfs of systems now that you are needing it for this
> driver?  To ignore that is going to cause problems :(

Oops, right. I'll work on it.


>> +const MDIO_MMD_PMAPMD: u8 = uapi::MDIO_MMD_PMAPMD as u8;
>> +const MDIO_MMD_PCS: u8 = uapi::MDIO_MMD_PCS as u8;
>> +const MDIO_MMD_PHYXS: u8 = uapi::MDIO_MMD_PHYXS as u8;
>> +
>> +struct PhyQT2025;
>> +
>> +#[vtable]
>> +impl Driver for PhyQT2025 {
>> +    const NAME: &'static CStr = c_str!("QT2025 10Gpbs SFP+");
>> +    const PHY_DEVICE_ID: phy::DeviceId = phy::DeviceId::new_with_exact_mask(0x0043A400);
>> +
>> +    fn config_init(dev: &mut phy::Device) -> Result<()> {
>> +        let fw = Firmware::new(c_str!("qt2025-2.0.3.3.fw"), dev)?;
>> +
>> +        let phy_id = dev.c45_read(MDIO_MMD_PMAPMD, 0xd001)?;
>> +        if (phy_id >> 8) & 0xff != 0xb3 {
>> +            return Ok(());
>> +        }
>> +
>> +        dev.c45_write(MDIO_MMD_PMAPMD, 0xC300, 0x0000)?;
>> +        dev.c45_write(MDIO_MMD_PMAPMD, 0xC302, 0x4)?;
>> +        dev.c45_write(MDIO_MMD_PMAPMD, 0xC319, 0x0038)?;
>> +
>> +        dev.c45_write(MDIO_MMD_PMAPMD, 0xC31A, 0x0098)?;
>> +        dev.c45_write(MDIO_MMD_PCS, 0x0026, 0x0E00)?;
>> +
>> +        dev.c45_write(MDIO_MMD_PCS, 0x0027, 0x0893)?;
>> +
>> +        dev.c45_write(MDIO_MMD_PCS, 0x0028, 0xA528)?;
>> +        dev.c45_write(MDIO_MMD_PCS, 0x0029, 0x03)?;
>> +        dev.c45_write(MDIO_MMD_PMAPMD, 0xC30A, 0x06E1)?;
>> +        dev.c45_write(MDIO_MMD_PMAPMD, 0xC300, 0x0002)?;
>> +        dev.c45_write(MDIO_MMD_PCS, 0xE854, 0x00C0)?;
>> +
>> +        let mut j = 0x8000;
>> +        let mut a = MDIO_MMD_PCS;
>> +        for (i, val) in fw.data().iter().enumerate() {
> 
> So you are treating the firmware image as able to be iterated over here?

It's Rust way to do the original C code:

for (i = 0; i < the_size_of_fw; i++) {
     // write fw_data[i] to a register.
     

>> +            if i == 0x4000 {
> 
> What does 0x4000 mean here?
> 
>> +                a = MDIO_MMD_PHYXS;
>> +                j = 0x8000;
> 
> What does 0x8000 mean here?
> 
>> +            }
>> +            dev.c45_write(a, j, (*val).into())?;
>> +
>> +            j += 1;
>> +        }
>> +        dev.c45_write(MDIO_MMD_PCS, 0xe854, 0x0040)?;
> 
> Lots of magic values in this driver, is that intentional?

The original driver uses lots of magic values. I simply use them. As
Andrew wrote, we could infer some. I'll try to comment these.

