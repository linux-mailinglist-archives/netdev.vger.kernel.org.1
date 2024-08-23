Return-Path: <netdev+bounces-121416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0567F95D038
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 16:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03579B209D1
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 14:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB82184550;
	Fri, 23 Aug 2024 14:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cnQ6LVO0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A681581E5
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 14:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724424056; cv=none; b=p1Tg8a7m+CYrrD4IeTKvyrqdqc/f8CBs/8vMj+GgdMs6yDdlCtdwTN0SceFBLeY4EcWIjnxiuNwy6d0QI71IRJoNPRG6u3kjE7s/gPsT65LW+gjROSaery85cyjNxyBJtCQPKf0cDfpLP4Y7Mgji/iq5e7p8tcNeBLwGfgOq/+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724424056; c=relaxed/simple;
	bh=m/uKu3EufFWBdtD3mvmziSannByTi+2/7MUJv2YygcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=efNZjHuhedGS+M8TsyYGQ3GY6wRL07YfQj0l8FomWkC8/2oGIHRspRLn/ucSLOFfceBiSehM0THLRB3LzvfxOPqh57H7iBN52Gq4GUlvwhcJy4JGIvyZ9F7cfnieb1jeiv1a1iFLRrQl/p97FBkh+mDg0t7Hbiwa2XuhSIJJUt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cnQ6LVO0; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-690ad83d4d7so19630847b3.3
        for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 07:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724424053; x=1725028853; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K2XxR6lrCVDVtU62zIwtuFvP7MuBrv6eFVNwiNPLrwU=;
        b=cnQ6LVO0Dc53kKDsiNerGWwCEophpOuREOKi/YRHbjG3yhOWKJtUgIDUMaYhnEZ95R
         QGN4ZsZ8E8RmCrhx5TUAkQto7A2z1iNSfagLm+lfhuxzWrzuOktcwMQwKuOjBQDtZ8qS
         5bQmg09s1MeRliMvqVOQM9vTZ2EHAm2DLVfO63TUm1MwEAqDC+lXlORUasm9d4DwJjTy
         1DYqtFmB9UaIjGcnczxydX8HKb1GyT1+c/Vw2ubNhwXjRL6H8TtPGg5XRh0YgOV0RSQm
         fNilezZ2z60TXqYk6kq6CxauAyJeftZCvYlUMo7tYCZ1cCYZL3Io8BSlmSt7WL8Tyk0J
         OW2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724424053; x=1725028853;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K2XxR6lrCVDVtU62zIwtuFvP7MuBrv6eFVNwiNPLrwU=;
        b=pvbjFZkSiI1iinvxCqBIBhWp/u9vWcUj9AB+vncxgCcmdb0n9NkNzkyLVZjLspXjGp
         Sub7vBFcMKnXzMkCwkrrOlsr3A2ekW4/46/mOq5BUXTY3xrkc/KI669tUha+3FMt3Yfu
         /zo9SXBzVg9MEn5xqsAV3PtgNacDlaoahlhFttOZ9xTZLgaWGYA1ubtJRgWOzgRPU3En
         KQVL9oiDcgv1MCOHAGrHXJo/aD6wLz8HQOvAbI+bt1++gNkYsMDPEKQrOjTcvSVFA+qa
         9pSZ9iCKOtEBchOcJfIG0S052r0r9d+J7i3LHzKV62QWwu8n6wxfQOc0N8ZH/QNaH4AK
         Cqpw==
X-Gm-Message-State: AOJu0Ywh0Z/qhB4vyY8fgqEzNz5hNFU2HU/CbtU9TlQk+bgMcGEVIZ7f
	zsKdS4tfy16clGlzcGEwrFfdZC96ajNcopcICbKLs2guX1PHn8iQx6yOJuKZ
X-Google-Smtp-Source: AGHT+IHFMdZQNdd7SWU0auutmvNK/U6NE9VvH+29eqTqtagGmeXyTbxCHzry+hMz/AV/f6kx+CuQXQ==
X-Received: by 2002:a05:690c:3241:b0:6be:92c7:a27e with SMTP id 00721157ae682-6c6286b8f29mr24881677b3.28.1724424053422;
        Fri, 23 Aug 2024 07:40:53 -0700 (PDT)
Received: from [10.102.6.66] ([208.97.243.82])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6c39a75309dsm5687647b3.46.2024.08.23.07.40.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Aug 2024 07:40:52 -0700 (PDT)
Message-ID: <0b6376c2-bd04-4090-a3bf-b58587bbe307@gmail.com>
Date: Fri, 23 Aug 2024 10:40:52 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] net: dsa: mv88e6xxx: Fix out-of-bound access
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Joseph Huang <Joseph.Huang@garmin.com>
Cc: netdev@vger.kernel.org
References: <d9d8c03e-a3d9-4480-af99-c509ed9b8d8d@stanley.mountain>
Content-Language: en-US
From: Joseph Huang <joseph.huang.2024@gmail.com>
In-Reply-To: <d9d8c03e-a3d9-4480-af99-c509ed9b8d8d@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/23/2024 8:46 AM, Dan Carpenter wrote:
> Hello Joseph Huang,
> 
> Commit 528876d867a2 ("net: dsa: mv88e6xxx: Fix out-of-bound access")
> from Aug 19, 2024 (linux-next), leads to the following Smatch static
> checker warning:
> 
> 	drivers/net/dsa/mv88e6xxx/global1_atu.c:460 mv88e6xxx_g1_atu_prob_irq_thread_fn()
> 	error: testing array offset 'spid' after use.
> 
> drivers/net/dsa/mv88e6xxx/global1_atu.c
>       402 static irqreturn_t mv88e6xxx_g1_atu_prob_irq_thread_fn(int irq, void *dev_id)
>       403 {
>       404         struct mv88e6xxx_chip *chip = dev_id;
>       405         struct mv88e6xxx_atu_entry entry;
>       406         int err, spid;
>       407         u16 val, fid;
>       408
>       409         mv88e6xxx_reg_lock(chip);
>       410
>       411         err = mv88e6xxx_g1_read_atu_violation(chip);
>       412         if (err)
>       413                 goto out_unlock;
>       414
>       415         err = mv88e6xxx_g1_read(chip, MV88E6XXX_G1_ATU_OP, &val);
>       416         if (err)
>       417                 goto out_unlock;
>       418
>       419         err = mv88e6xxx_g1_atu_fid_read(chip, &fid);
>       420         if (err)
>       421                 goto out_unlock;
>       422
>       423         err = mv88e6xxx_g1_atu_data_read(chip, &entry);
>       424         if (err)
>       425                 goto out_unlock;
>       426
>       427         err = mv88e6xxx_g1_atu_mac_read(chip, &entry);
>       428         if (err)
>       429                 goto out_unlock;
>       430
>       431         mv88e6xxx_reg_unlock(chip);
>       432
>       433         spid = entry.state;
>       434
>       435         if (val & MV88E6XXX_G1_ATU_OP_MEMBER_VIOLATION) {
>       436                 trace_mv88e6xxx_atu_member_violation(chip->dev, spid,
>       437                                                      entry.portvec, entry.mac,
>       438                                                      fid);
>       439                 chip->ports[spid].atu_member_violation++;
>                                       ^^^^
> 
> The commit adds a bounds check later if the MV88E6XXX_G1_ATU_OP_FULL_VIOLATION
> flag is set but it doesn't add it here where MV88E6XXX_G1_ATU_OP_MEMBER_VIOLATION
> is set.  Can only one type of violation flag be set at a time?
> 
>       440         }
>       441
>       442         if (val & MV88E6XXX_G1_ATU_OP_MISS_VIOLATION) {
>       443                 trace_mv88e6xxx_atu_miss_violation(chip->dev, spid,
>       444                                                    entry.portvec, entry.mac,
>       445                                                    fid);
>       446                 chip->ports[spid].atu_miss_violation++;
>                                       ^^^^
> 
>       447
>       448                 if (fid != MV88E6XXX_FID_STANDALONE && chip->ports[spid].mab) {
>                                                                        ^^^^^^^^^^^
> 
>       449                         err = mv88e6xxx_handle_miss_violation(chip, spid,
>       450                                                               &entry, fid);
>       451                         if (err)
>       452                                 goto out;
>       453                 }
>       454         }
>       455
>       456         if (val & MV88E6XXX_G1_ATU_OP_FULL_VIOLATION) {
>       457                 trace_mv88e6xxx_atu_full_violation(chip->dev, spid,
>       458                                                    entry.portvec, entry.mac,
>       459                                                    fid);
> --> 460                 if (spid < ARRAY_SIZE(chip->ports))
>                               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> This is the new check.
> 
>       461                         chip->ports[spid].atu_full_violation++;
>       462         }
>       463
>       464         return IRQ_HANDLED;
>       465
>       466 out_unlock:
>       467         mv88e6xxx_reg_unlock(chip);
>       468
>       469 out:
>       470         dev_err(chip->dev, "ATU problem: error %d while handling interrupt\n",
>       471                 err);
>       472         return IRQ_HANDLED;
>       473 }
> 
> regards,
> dan carpenter
> 

Hi Dan,

I had a similar discussion with Simon on this issue (see 
https://lore.kernel.org/lkml/5da4cc4d-2e68-424c-8d91-299d3ccb6dc8@gmail.com/). 
The spid in question here should point to a physical port to indicate 
which port caused the exception (DSA_MAX_PORTS is defined to cover the 
maximum number of physical ports any DSA device can possibly have). Only 
when the exception is caused by a CPU Load operation will the spid be a 
hardcoded value which is greater than the array size. The ATU Full 
exception is the only one (that I know of) that could be caused by a CPU 
Load operation, that's why the check is only added/needed for that 
particular exception case.

Thanks,
Joseph

