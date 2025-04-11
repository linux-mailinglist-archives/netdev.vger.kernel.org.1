Return-Path: <netdev+bounces-181848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A73A86945
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 01:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 465C21886E48
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 23:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A482BEC25;
	Fri, 11 Apr 2025 23:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b="beIIIqJm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B9D278E40
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 23:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744414580; cv=none; b=ltfaIuwgYeCUJO56jA93ZxokzudL9RH8Wy6Sgc6K+Obxdkn+s3ITHlUuXAR6ACYXUflLpozPsys/lmOS++Sc6ld6PdhgkjXAq0WBufRHwE0RQhfxxlCAkbC9O3D42KHJg6iMTm0W00F+srsbLEESOa6wWu7rkdl+iA3YkMWOTpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744414580; c=relaxed/simple;
	bh=7+e3NUoylOVeaFENINgghFZuMVpxis8hq2VGdR0NQq0=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=LUldGJXKFWg2DImsPVcrFBBNhwNmzwAcYSmGFI9avt5MThss220bVAZ3FORrrZPLlajUK/eFEuc7ZRqDTJDsXLqaCglo2qZ3F2R+wz/8Q7g0IpqEKJU7NR2I+ea7mCoKLF1hU5WoQzGIHCTbgbM6oDM7KM8Y2Xmj7Ji+zrqCXL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info; spf=pass smtp.mailfrom=jacekk.info; dkim=pass (2048-bit key) header.d=jacekk.info header.i=@jacekk.info header.b=beIIIqJm; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jacekk.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jacekk.info
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e5cd420781so4935780a12.2
        for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 16:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jacekk.info; s=g2024; t=1744414576; x=1745019376; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HwMv8tPiMF0dVPflBOXsWhbXdPTG3gvkPVzHF2vJkxM=;
        b=beIIIqJmGk95RRYmYb9PkD9JzKH11ZcOlwIe57quB6pMNTHcdTCZkEpd7LcU57RoBE
         D+FsgXIt8KACX5DOigjYRm95O0LYDOkIMgF45+LfYE2z0aepQoyuOpeeqSLWYAX/tfU1
         XEvlWRl4vavSoX7LGAU9W7YBvNYc+4GZWTe5wTk79JKYjA0/oLJLnrEFLO/qw35qK2rv
         uN3nTVhozHsjpwh13zNN3PdfywWE1FOAFcR4EsOvyaMMQAryzTlvYGhzfra6McMu6lUv
         KiKLpkewXrcKKl5MTEu6fYT8IXX/29Q3jdFMgssKrhGH0cSmtx2RXPurOur09h17VqHa
         tmMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744414576; x=1745019376;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HwMv8tPiMF0dVPflBOXsWhbXdPTG3gvkPVzHF2vJkxM=;
        b=JW3AILoXeQw93cJSR34i9QwC35l/Z0MHvcm2vNmelA+vUs3t/OgHJHnoMN8WdDBfdq
         eKgelI+YFFXofBg84nzmsY/LgQBi30HwQUpOjft+/IQV9Q9ae7c1QLOiKwRhBx74Lziu
         t9YnQjQFEnKns2HdlstUHf6nsGEBs26yExOYdohgah5b/GAj6NV85PUuavLB9NLyrtjL
         QqnPWLJharVRobdAkI5m4VRrQ1NvlPVhXf//c3bALN7jwzcTCpOOVHYcYjiC2vq/i761
         6G0DAi84sGiXiDGdIUeKttaTpF+x6VusMta2MZGGo5qlrKnLOSXp+XYRuQTaffHCJiuh
         tfPA==
X-Forwarded-Encrypted: i=1; AJvYcCWk6/W1DUSjIY503l9dRbiUkhNQHPSEfij0SFW3donLs1kQ7hNDBV1TTWd+0uhhANXncuiYXOE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq3rDBtkCxm0AINdfnnppmy0PmX7+O8GBCdcn//+1MLaOgzSpg
	gnvPzieihTsoj97UW9uM/b92Ed7tUNIdsoZxyz/AzqlUkRCOZCMNjlCGlA56xg==
X-Gm-Gg: ASbGncu9bdD2qOe+Af4j3RjUT3Vc5yOx5C3prMQz56zoR+nrexj2XGYJqGT2xGr5wub
	/jTPwq3c+/LuOxFS0Q/GGzBRbsPbMFFLEKu7UcGHocxty+ogqS5nHVduibzs+DTFp3YpJxcIAOq
	17z+yLYxFSeawU3Bvwuxcob7t9ctyxV305akMQzZRL5NgiI6zIw/niMPRAWbOcMKxKJRZkjJU6p
	TTS0HVka0Uk6+WgdfI8AbQGtOsyzB+sIP+ERa9drhxbdYOiKV+gZm6Bema1Uh6BJahAtKAcu4YF
	kdXe1sOIqZQVHEu6HEJMPR2AtKIUyoLuE/ML2PA=
X-Google-Smtp-Source: AGHT+IG65JtJTlWzVWTcHoqcK5/jFXj4u4V5EKxD/X2oPq8vmVDR5pde+amvYWacjgOlLdGpJdb14Q==
X-Received: by 2002:a05:6402:358f:b0:5e8:bf2a:7e8c with SMTP id 4fb4d7f45d1cf-5f36f650ad8mr3873062a12.11.1744414576095;
        Fri, 11 Apr 2025 16:36:16 -0700 (PDT)
Received: from [10.2.1.132] ([194.53.194.238])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f36e0ce3fesm1551899a12.0.2025.04.11.16.36.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Apr 2025 16:36:15 -0700 (PDT)
From: Jacek Kowalski <jacek@jacekk.info>
X-Google-Original-From: Jacek Kowalski <Jacek@jacekk.info>
Message-ID: <7c986a61-7214-495b-aed3-ca9f15ac9b7d@jacekk.info>
Date: Sat, 12 Apr 2025 01:36:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH] e1000e: add option not to verify NVM
 checksum
To: "Lifshits, Vitaly" <vitaly.lifshits@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <c0435964-44ad-4b03-b246-6db909e419df@jacekk.info>
 <9ad46cc5-0d49-8f51-52ff-05eb7691ef61@intel.com>
 <a6d71bdc-3c40-49a1-94e5-369029693d06@jacekk.info>
 <ca5e7925-1d75-5168-2c54-1f4fa9ef523e@intel.com>
 <1c4b00b6-f6e3-4b04-a129-24452df60903@jacekk.info>
Content-Language: en-US
In-Reply-To: <1c4b00b6-f6e3-4b04-a129-24452df60903@jacekk.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> If this approach is acceptable to you, I will prepare a patch with
>> the proposed fix and send it to you next week for testing on your system.
> 
> What solution do you have in mind?
> 
> The only one I can think of is to ignore the checksum completely if the
> valid_csum_mask condition is not met on e1000_pch_tgp.

Would you be OK with the following modification:

diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
index 364378133526..df4e7d781cb1 100644
--- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
+++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
@@ -4274,6 +4274,8 @@ static s32 e1000_validate_nvm_checksum_ich8lan(struct e1000_hw *hw)
                         ret_val = e1000e_update_nvm_checksum(hw);
                         if (ret_val)
                                 return ret_val;
+               } else if (hw->mac.type == e1000_pch_tgp) {
+                       return 0;
                 }
         }
  

?

-- 
Best regards,
   Jacek Kowalski


