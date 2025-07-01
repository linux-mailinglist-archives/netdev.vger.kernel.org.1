Return-Path: <netdev+bounces-202888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4755AEF8F6
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 14:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D8104E0FC4
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 12:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29002741A4;
	Tue,  1 Jul 2025 12:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F3vcLG0P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F46727380B
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 12:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751373668; cv=none; b=vE4n6JJkPEWHJ1XbNBuhYHplCE5zvMaw+mVfIeCgdK8gxb1hNvdJqMT3uqqbIy4imoWJboeYnjn8PCDl0b7wzDhjoAqvhTZZIdk2g/I3cbNovu0odasUeRBqhMRDhPy1O8m0DJL1p3nGzOqM+slckxe9qfMfF9S0fslMpEf7+bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751373668; c=relaxed/simple;
	bh=zyz8nGAXcSfS1GAYo9BS/1zAlIY5auS10EM9wx5ZdRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qD24C0/Ct6asD1KSphHWOcBA2GXlpUNd1QjtI4x1Pmttl6TrIsWxa1SCvnZ9mcmums4T5gjtGRgFfz1NMue/x8bwPN/QDQuRrWTg5/KdUYvGI2l7WIDBIVrorQ6GAIyvS5dLKwlJJiH4wr9nfHRYMFIw1rhsk0tJYIwsNHPXLPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F3vcLG0P; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ad56cbc7b07so563704766b.0
        for <netdev@vger.kernel.org>; Tue, 01 Jul 2025 05:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751373665; x=1751978465; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IZad0KRbavLmdY0b2n+bP8Da0O/RN+UmZpc2G0+Di0Y=;
        b=F3vcLG0PlLBsZzbLJY6+CamXErKPJFZvKqnCEH28I3nQhgxEUO2eCm9lN4pcGMOAWA
         PJG+oIzl7szbY5dA8J5F8S4rn/MzK0GnmoKCm8wXrrNjcqLVAtQFYQP4y/sGF4qgj4Nq
         yIyNxEkCVOiqpgQDDe1nYctrXtrUDenVIzSFJQ91lj9S6Jb5IK8GwQQb2A+0PYnkpico
         5lF7OzUGkStEbQNuMBT+GGQHjevNU0/FK82CyAn0xtS6vTXTh+8T4J1CVlObPpgBP9Ue
         2Dckfiuc1ggokbFL7gYCg16m7JxlpyrWYWt9lyGmq13xVyND6rpjTJQsUtbwzEih3KKb
         Dx5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751373665; x=1751978465;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IZad0KRbavLmdY0b2n+bP8Da0O/RN+UmZpc2G0+Di0Y=;
        b=WG/qurfZXYopWHLvPZIUzSu/gVOW5SOlhZpWIHnrG7fiWVGApoF3ZRrqCmYEfbhJfs
         BQ0ixp8LFvgbGtePf/YNWbyBheS1QL6/yHRdod3ubeqlDn8Xx+YM1+F+AELAho9j7WKg
         kOjJdLBB+0UXce7mzWYl3zHACQa5nHgAzgpHNCuUMn4MmiZqgyjM3RlcApDv14i/2pv7
         0+qIOCxr6q2TdiKZUnEiNfW/geGYNwBOl0gT2FHecog6OmLY3t5e2j97xKiX884MyKQv
         Cy7Kck/04zryQbc9OSfiLUlYgeNCzRsxsxog9OH9EhA7pf72xAq6zY/5ivyAAXNCA3yQ
         kI9A==
X-Forwarded-Encrypted: i=1; AJvYcCX/iMdIdY+U1h1SwieG867Esz8NPGA64/dMnyBDp0jvaQgy6/+56m5m1GQbSRlymL61fh9aO/4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWo5AcWewEtaEkq1+z5mHwbD7lYBy/fcwASU/J3ea1LjC7DKkH
	AXFH8AniYykKfqZrSIvJqCkmk4kKMy0ZXRtPhVmlf8S4dW4bE5QCUsSZ
X-Gm-Gg: ASbGncsOuDV4AbcacwPhucEaNtDr+CHfsN1FmeSrr/l13SjcLAd5xBBema/fgqHjLXH
	RZ5WcfYiKEl0Oh54jbMy8tfs5I4BnqLoxABsOMbIZsivgt52uXRESaV40BKS4c33CDVyP6U2+9H
	xsib1KkZB5bF1Ivf69913mmX+mI3DacPZsEgnwj2u4XOPgrKQfBEqRFcCO4aHMbpgvgNKMSaT6/
	8aj+ODThzDO3I3Olnv+t2czi3Qb3h6YE+gALFDWG8GfcCXvXviiidatPKT66R/NL2AWGHUimzZC
	w3yCVfwNj6uRQdHS6x2AwIwlEfsG3WnW3QpAH4eY/i1/c9T9R8j5g90vn6/krH4Iavpar4d1glx
	8iLSMUKFsEd6PTOmAPp36jWR5do4cyhl+NZpLdAjMYTiaDqHxPcagSEFhZc6Jh38MRE1JH7rfWN
	50dy6XPI3+R82DcQ==
X-Google-Smtp-Source: AGHT+IEOqvAOCkap2zcLD8Kd0EyNR9l/PlgUc01Gl+s6CT3zrjvz2Vdz7tgY1Ixwbhpfgx+0bnlWsg==
X-Received: by 2002:a17:907:9495:b0:ad2:43b6:dd75 with SMTP id a640c23a62f3a-ae34fcf4123mr1627471066b.10.1751373665040;
        Tue, 01 Jul 2025 05:41:05 -0700 (PDT)
Received: from ?IPV6:2003:ed:774b:fcf2:fd9b:fa69:b8ed:4a74? (p200300ed774bfcf2fd9bfa69b8ed4a74.dip0.t-ipconnect.de. [2003:ed:774b:fcf2:fd9b:fa69:b8ed:4a74])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae35363b35dsm873374666b.13.2025.07.01.05.41.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jul 2025 05:41:04 -0700 (PDT)
Message-ID: <2937fe13-d65f-4cb6-8535-3084b29af541@gmail.com>
Date: Tue, 1 Jul 2025 14:41:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Incomplete fix for recent bug in tc / hfsc
To: Victor Nogueira <victor@mojatatu.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org,
 Jiri Pirko <jiri@resnulli.us>, Mingi Cho <mincho@theori.io>,
 Cong Wang <xiyou.wangcong@gmail.com>
References: <CAM0EoMm+xgb0vkTDMAWy9xCvTF+XjGQ1xO5A2REajmBN1DKu1Q@mail.gmail.com>
 <d23fe619-240a-4790-9edd-bec7ab22a974@gmail.com>
 <CAM0EoM=rU91P=9QhffXShvk-gnUwbRHQrwpFKUr9FZFXbbW1gQ@mail.gmail.com>
 <CAM0EoM=mey1f596GS_9-VkLyTmMqM0oJ7TuGZ6i73++tEVFAKg@mail.gmail.com>
 <aGGZBpA3Pn4ll7FO@pop-os.localdomain>
 <8e19395d-b6d6-47d4-9ce0-e2b59e109b2b@gmail.com>
 <CAM0EoMmoQuRER=eBUO+Th02yJUYvfCKu_g7Ppcg0trnA_m6v1Q@mail.gmail.com>
 <c13c3b00-cd15-4dcd-b060-eb731619034f@gmail.com>
 <CAM0EoMnwxMAdoPyqFVUPsNXE33ibw6O4_UE1TcWYUZKjwy3V6A@mail.gmail.com>
 <442716ca-ae2e-4fac-8a01-ced3562fd588@mojatatu.com>
 <aGMEsnYnv0lwBTcl@pop-os.localdomain>
Content-Language: en-US
From: Lion Ackermann <nnamrec@gmail.com>
In-Reply-To: <aGMEsnYnv0lwBTcl@pop-os.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 6/30/25 11:42 PM, Cong Wang wrote:
> On Mon, Jun 30, 2025 at 02:52:19PM -0300, Victor Nogueira wrote:
>> Lion, I attached a patch to this email that edits Cong's original tdc test
>> case to account for your reproducer. Please resend your patch with it (after
>> the 24 hour wait period).
> 
> Or send it as a follow up patch? I am fine either way, since we don't
> backport selftests, this is not a big deal.
> 
> Thanks for improving the selftest!

Thanks a lot. Please just post as a follow up then if this is fine.

Thanks,
Lion

