Return-Path: <netdev+bounces-96812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F528C7EEF
	for <lists+netdev@lfdr.de>; Fri, 17 May 2024 01:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 599BC281C23
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 23:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123F32837B;
	Thu, 16 May 2024 23:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="YFJAVgjX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7262AF15
	for <netdev@vger.kernel.org>; Thu, 16 May 2024 23:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715901681; cv=none; b=PHrcqbTsXLsq1Tq0Tz3uZLwxCcShsFY1xWGBFLXO3wenWz7xAWEs+4zQMjNfagt+KqzzDi0oZBBtSNJcFKknJ84/vB1Qvh5MFsr995PtCrXceYumed9muz68Y+LXdwBdgniq4IGLg+xid1YOAG2L8uvuAHU2sXJCnAnV6Sggn7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715901681; c=relaxed/simple;
	bh=Qui0DEbevuwNLaQ5JuIVShEJXLfv1M7Yu4u8VZtKVeM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=MMGflL7Y33y0/1j8vtUveolFZdZRrsYJ3yGCtFfj6T/WF+cbcuqSgoLoZ1tBvBjZ5MaC9Fm5mWmxIH5+/XT71IUd9iq/CLRjoL8i+7z6TAO3vi08QvB7pYW9Y4OfjXmIDNwOakMhBg7+QpKdOVqACaR3bBJogJtOGVqaHqmk06U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=YFJAVgjX; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-34d7b0dac54so5031511f8f.0
        for <netdev@vger.kernel.org>; Thu, 16 May 2024 16:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1715901677; x=1716506477; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lp5Q4kFI8X/cmoTJxmxu71qy/umo6wOz6GO12/MOAWM=;
        b=YFJAVgjXgPMDvfKpjas29KRGtjZbCn+OLM/26D1l5/mTYQZCe2frNM/j0j2kfgXGDg
         kIQb79ENVSRdV8A7phKrflSIVQpjXN64OlAxYn1YuRojCWtmIc3I3QbIdhXuPDjwiNJx
         DevigPwXbyHsnU3FSUz0i+9/PyZC+K7KBEIZLB4oHn+pGcfqaYTjlLhFcziDi6N8zpbE
         cRL5WwgKrwalFEtV3uo1UCFPEdbOcqGPq67Tl8SSZcZ8LeVAyO2yBgpG3Rd6ZytkPI5A
         Lf5m6FEVI+9fPFZBpsCBePkKr+JDhj+29gkyjlmVxF4+kx9dstZEOnSlLvMaAdZR7b87
         khYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715901677; x=1716506477;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lp5Q4kFI8X/cmoTJxmxu71qy/umo6wOz6GO12/MOAWM=;
        b=wCMWBx/AD5TzAcdJKqzMhpwUtyKwNAp+fG2TRfF5Zk/EsaQ+v71pY0y+UuTAEs1AFh
         gNliOn9vpN8/tO7AtdsjsvRptcccdPZUgoqUBVk9T9DFoX1ZJENvaCL5t+uwQ13nexUQ
         Y5ymTYpw2O2otW/yCogXQShNfSdTVp9XR/Y514MB9kODb3aJELghcA1L2cuhBxGk2Lng
         eVTDGv+w1/ZnO3A0VQxdImRQmWA2c+8RNGF7YjBd45U4Z4FcwuAmaZuredHmfeaSacH+
         4b0fC+GV+Fx9q2TzzSNYlrG0Tu/SXEFEjynVtKcY6udAppgO/G18c/PlfegLh4mZWDNg
         Txmg==
X-Forwarded-Encrypted: i=1; AJvYcCV4QI8KBr5GEqnPYIxj88ntfngULFGXd/XxpNonDuOKkqRiuIs87LQ2gVGNV5qKAMPUljzcezwlYmO8m7YnkRa0Da2inqlk
X-Gm-Message-State: AOJu0YwEXwsErrJpoHC0LetMx+70oC2ilUDSwRjr8L/WuZcFvJTOW2sl
	bR10ysySAN0YWBStVXVyxX5T51xLGXAG4zlcSB6Vv8UHTb6k9MdRHDYjgGd0rdU=
X-Google-Smtp-Source: AGHT+IG/4VDfaLpKv9+Hy9psRkakHJC/Qh+jThNDXbSICnYlct9NikIvzEy+1yhDJ0NQy6xbO4H4Ig==
X-Received: by 2002:a5d:5889:0:b0:352:12ff:2323 with SMTP id ffacd0b85a97d-35212ff240bmr1780438f8f.28.1715901677079;
        Thu, 16 May 2024 16:21:17 -0700 (PDT)
Received: from smtpclient.apple ([2001:a61:aa3:5c01:4c77:13bf:9f9f:140])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502baad1f0sm20293435f8f.89.2024.05.16.16.21.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2024 16:21:16 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.500.171.1.1\))
Subject: Re: [PATCH v3] net: smc91x: Fix pointer types
From: Thorsten Blum <thorsten.blum@toblux.com>
In-Reply-To: <f192113c-9aee-47be-85f6-cd19fcb81a5e@lunn.ch>
Date: Fri, 17 May 2024 01:21:04 +0200
Cc: Arnd Bergmann <arnd@arndb.de>,
 "David S. Miller" <davem@davemloft.net>,
 edumazet@google.com,
 glaubitz@physik.fu-berlin.de,
 kuba@kernel.org,
 linux-kernel@vger.kernel.org,
 lkp@intel.com,
 netdev@vger.kernel.org,
 nico@fluxnic.net,
 pabeni@redhat.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <66AB9A6F-4D24-4033-96B9-E5F2F700029D@toblux.com>
References: <0efd687d-3df5-49dd-b01c-d5bd977ae12e@lunn.ch>
 <20240516223004.350368-2-thorsten.blum@toblux.com>
 <f192113c-9aee-47be-85f6-cd19fcb81a5e@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>
X-Mailer: Apple Mail (2.3774.500.171.1.1)

On 17. May 2024, at 00:51, Andrew Lunn <andrew@lunn.ch> wrote:
> On Fri, May 17, 2024 at 12:30:05AM +0200, Thorsten Blum wrote:
>> Use void __iomem pointers as parameters for mcf_insw() and =
mcf_outsw()
>> to align with the parameter types of readw() and writew() to fix the
>> following warnings reported by kernel test robot:
>>=20
>> drivers/net/ethernet/smsc/smc91x.c:590:9: sparse: warning: incorrect =
type in argument 1 (different address spaces)
>> drivers/net/ethernet/smsc/smc91x.c:590:9: sparse:    expected void *a
>> drivers/net/ethernet/smsc/smc91x.c:590:9: sparse:    got void =
[noderef] __iomem *
>> drivers/net/ethernet/smsc/smc91x.c:590:9: sparse: warning: incorrect =
type in argument 1 (different address spaces)
>> drivers/net/ethernet/smsc/smc91x.c:590:9: sparse:    expected void *a
>> drivers/net/ethernet/smsc/smc91x.c:590:9: sparse:    got void =
[noderef] __iomem *
>> drivers/net/ethernet/smsc/smc91x.c:590:9: sparse: warning: incorrect =
type in argument 1 (different address spaces)
>> drivers/net/ethernet/smsc/smc91x.c:590:9: sparse:    expected void *a
>> drivers/net/ethernet/smsc/smc91x.c:590:9: sparse:    got void =
[noderef] __iomem *
>> drivers/net/ethernet/smsc/smc91x.c:483:17: sparse: warning: incorrect =
type in argument 1 (different address spaces)
>> drivers/net/ethernet/smsc/smc91x.c:483:17: sparse:    expected void =
*a
>> drivers/net/ethernet/smsc/smc91x.c:483:17: sparse:    got void =
[noderef] __iomem *
>>=20
>> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: =
https://lore.kernel.org/oe-kbuild-all/202405160853.3qyaSj8w-lkp@intel.com/=

>> Acked-by: Nicolas Pitre <nico@fluxnic.net>
>> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>> ---
>> Changes in v2:
>> - Use lp->base instead of __ioaddr as suggested by Andrew Lunn. They =
are
>> essentially the same, but using lp->base results in a smaller diff
>> - Remove whitespace only changes as suggested by Andrew Lunn
>> - Preserve Acked-by: Nicolas Pitre tag (please let me know if you
>> somehow disagree with the changes in v2 or v3)
>>=20
>> Changes in v3:
>> - Revert changing the macros as this is unnecessary. Neither the =
types
>>  nor the __iomem attributes get lost across macro boundaries
>> - Preserve Reviewed-by: Andrew Lunn tag (please let me know if you
>>  somehow disagree with the changes in v3)
>=20
> This fixes the warning, but we still have the macro accessing things
> not passed to them. If you are going to brother to fix the warnings,
> it would also be good to fix the bad practice. Please make a patchset
> to do this.

I would prefer to submit another patch to fix the macros. I submitted v3
because the patch description for v2 was wrong (type information or
attributes don't get lost across macro boundaries) and the macro changes
are unnecessary to fix the warnings.

I should never have changed the macros, but after first adding __iomem
to mcf_insw() and mcf_outsw(), I kept getting the same errors and looked
for the problem in the SMC_* macros. I probably didn't do a clean build
or forgot to save my changes and just refactored the macros as a side
effect.

> It would also be good if you read:
>=20
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

Will do.

Thanks,
Thorsten=

