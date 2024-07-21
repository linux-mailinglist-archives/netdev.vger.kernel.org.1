Return-Path: <netdev+bounces-112344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB9793860B
	for <lists+netdev@lfdr.de>; Sun, 21 Jul 2024 22:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D338928113E
	for <lists+netdev@lfdr.de>; Sun, 21 Jul 2024 20:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8A2167DB7;
	Sun, 21 Jul 2024 20:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AaUKtbNI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A2779F6
	for <netdev@vger.kernel.org>; Sun, 21 Jul 2024 20:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721592517; cv=none; b=RJxfW4eeHWWFrAG+6lt6CgZrJmsAFa37Y80f3xqtFZOOeaUjgwOWxkPQzlTRILF6A1DhjorKBbR3+2fRVUDonI9uqybLQZJijToRKJSH500Ts5dkZlZyXaPfKsdnYg+nvh/SiA1qjohi1+7vI9Tnr2s1pi9GgElmBKasgrzCQ4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721592517; c=relaxed/simple;
	bh=6LECqKhQlIXUpg7mFcQEr4+oKb6b5zgB96gs0e/gih4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P05OC9Tn60/idt0DMksSbMedSsxBABs9iXO0gHNT4RNHFybF1T7Nk2d6Qt78tVyy+Y/OoP6w6G505BU49eKh8LGM83PeqlBr6otlF9Oja5fj4W1hz+KIpqSXTEfGOHlhG3kuWvzT3r9pyv225d2MWo8HFcOpyQLtCZbOB9MbCL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AaUKtbNI; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5a1337cfbb5so2955420a12.3
        for <netdev@vger.kernel.org>; Sun, 21 Jul 2024 13:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721592514; x=1722197314; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Am3yjgg/9yWu4S/oZ3UlSSFlfvdqVYbggOXsd9kY1bE=;
        b=AaUKtbNIrwVX6K1xgiflUKiR7QyE/3lN3btVAZsBCHm/x3x5gMhs8S05cIL1UxX254
         Gy8gQPhi5C6T0E9tfeKYhLiSa6CuG9FB0Okx27xS79an4UGYX4dF4VnukogpCKbOPrYN
         rS+KfonEcxYYgU1sYvhtsNtNyPqaksJszb85AzO3GkUm/46MBsWFeAHux/1eqd9FmjLC
         MUG5+pE+DpOPCEo0cY8GtEaTH9wXKyGkUwjBUH7QTJcmoZSgUk/JU7yEdewrxkUs55z6
         TzADdRiW5c2ZSNSsTugDqlrzeAYXBDgmM9S+N2xEqax+U9vToOrKqBsXaZu5gwrs4HaA
         qcqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721592514; x=1722197314;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Am3yjgg/9yWu4S/oZ3UlSSFlfvdqVYbggOXsd9kY1bE=;
        b=UqZDtmPHMukB0Pa1TGEG4S+93A/GEt7tCQM1kN1IWPG21prhiBCJk1GPyS8L6oRDyI
         BymkQ356qU/DNrteOvGoayK++FL4x/I8FoOdibdVFW3ahRTOxHjUd0/ji+lwG02hUdXw
         sOIU0Hy1LMBmoxZ2P9Fun9GSWDICoLVkUihhQ1cA+haKEe3EZUoI0XTn6k8s9OoF/7Yf
         8lwSgvg5OXQEZlljQkwSApKUAcK3UtVKM8intrzFE7d0mTAJimlnAawvPAfMHazs6qav
         OU2Sdo6G+1rTKofEJ1/Jcbfmt9lOrSWqomRFJ+D/l7IOW43CA1IHbXmil5IaMxI3m2Pw
         lCYA==
X-Gm-Message-State: AOJu0YxVTXj+ZIIfZ26f+1enDBgrMbNKuVm6zQ+3YdrksOdT3ocyWD53
	wLvolm/kYCMFjV2XV3B98fzn76CXaNCpxNFwGeKs7iAqPu+ZVV0v
X-Google-Smtp-Source: AGHT+IFs7IkEH6FyBeR5Cn7mCsCBBrBLkBdCSXoPENKybb5s2vNmJiD0sVQyR/Gx4Ho+NVuDegu0Kg==
X-Received: by 2002:a50:f69e:0:b0:58e:4e62:429b with SMTP id 4fb4d7f45d1cf-5a47b5bc534mr2884111a12.33.1721592513509;
        Sun, 21 Jul 2024 13:08:33 -0700 (PDT)
Received: from ?IPV6:2a01:c22:72ae:7700:9138:3414:3add:3bc? (dynamic-2a01-0c22-72ae-7700-9138-3414-3add-03bc.c22.pool.telefonica.de. [2a01:c22:72ae:7700:9138:3414:3add:3bc])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5a30c7d3277sm4956135a12.87.2024.07.21.13.08.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jul 2024 13:08:32 -0700 (PDT)
Message-ID: <47017183-419c-438b-8b5b-b2b584bd62f2@gmail.com>
Date: Sun, 21 Jul 2024 22:08:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Debian Bookworm requires r8168-dkms for RTL8111D - regression
 from Buster 10.13.0
To: Dave Gomboc <dave_gomboc@acm.org>, nic_swsd@realtek.com,
 romieu@fr.zoreil.com
Cc: netdev@vger.kernel.org
References: <CA+dwz-12S8EeJjJ_FHtTvP41-Ru4pcfCS2ub5KjGHSY0=F=jog@mail.gmail.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <CA+dwz-12S8EeJjJ_FHtTvP41-Ru4pcfCS2ub5KjGHSY0=F=jog@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21.07.2024 03:33, Dave Gomboc wrote:
> I am sending this email because of the suggestion in
> /usr/share/doc/r8168-dkms/README.Debian.
> 
> Installation using a Debian Bookworm 12.2.0 amd64 DVD-ROM does not
> find the onboard gigabit ethernet (RTL8111D-based) on one of my
> mainboards (Gigabyte GA-890GPA-UD3H).  The network came up fine as
> soon as I used apt-offline to update/upgrade, then to fetch and
> install r8168-dkms.
> 
> Installation using a Debian Bullseye 11.8.0 amd64 DVD-ROM does not
> find the onboard NIC either.  However, installation using a Debian
> Buster 10.13.0 amd64 DVD-ROM does find the onboard NIC and can use it
> directly.  (Unfortunately, installing from that DVD-ROM later failed
> for some other reason.)
> 
> With r8168-dkms in operation, the relevant part of "lspci -v -v -v" reads:
> 
> 03:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
> RTL8111/8168/8411 PCI Express Gigabit Ethernet Co
> ntroller (rev 03)
>        Subsystem: Gigabyte Technology Co., Ltd Onboard Ethernet
>        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
> ParErr- Stepping- SERR- FastB2B- DisINTx+
>        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
> <TAbort- <MAbort- >SERR- <PERR- INTx-
>        Latency: 0, Cache Line Size: 4 bytes
>        Interrupt: pin A routed to IRQ 18
>        NUMA node: 0
>        Region 0: I/O ports at ee00 [size=256]
>        Region 2: Memory at fdfff000 (64-bit, prefetchable) [size=4K]
>        Region 4: Memory at fdff8000 (64-bit, prefetchable) [size=16K]
>        Expansion ROM at fd600000 [virtual] [disabled] [size=128K]
>        Capabilities: <access denied>
>        Kernel driver in use: r8168
>        Kernel modules: r8168
> 
> Please let me know if there is further information I can provide that
> would assist you in getting this supported directly by the r8169
> driver.
> 
Questions regarding downstream kernels should be addressed to the support
of the respective distribution.

Please retest with a recent mainline kernel.
What do you mean with "does not find the device"? Even lspci doesn't show it?
Please provide a full dmesg log.

It's not clear which kernel version you're using. Please make sure that it's a
version including the following fix:
5d872c9f46bd ("r8169: fix issue caused by buggy BIOS on certain boards with RTL8168d")

> Dave Gomboc
> 


