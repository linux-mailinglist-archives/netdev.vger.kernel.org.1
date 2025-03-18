Return-Path: <netdev+bounces-175676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE5AA67147
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 11:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 270C83B69AA
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 10:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00AA4207E0E;
	Tue, 18 Mar 2025 10:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dpuI138O"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B1F19F424
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 10:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742293762; cv=none; b=KoF+EgImGwlXPJ0x+nckVDkXpmjkuCe3Agpp5fcRDkZ4dQvw4i7ThO1gJfUVdj/WPi98LKWTmHhw+XpHLkASnUcQM14Ce9+NAzF04PwyJx9Pv9ObiXKsK5WRGXvORbDpPY9Al46YriygPy1k+nUZQV6gu9lyOE1pxp0aPmsICOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742293762; c=relaxed/simple;
	bh=icRL3FzX7n5CwQlt+hD3T1io+oS0x9c6Jm2EpRDFMI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=grDKY8diLW4KOFD1RFqoW/aOdi+UmDBQZhyuaBnkqfLanDkkbv9mHu1iXOwrlSEW8wBLA8IadqMyh9fZqBXN5u0YteqDR+LF9AqF9o/JW004i9BEb/CbKOXzm2idrwMbvALQUAVPAeQmwqqBnGkbLqTcRQ/K9s0bKB7JCKDMeiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dpuI138O; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742293760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6+RqQ9ZAEqwS3Wc2GhSiEZkrs2uvAiEdXS3wPJ9ZEBc=;
	b=dpuI138O+wuQ0/6NBDI134S7odDCBR1jddYoBdsuiTMt/UMhiR98ag+INXQwpH8c2GSE6v
	M07kuVG7WXvNFVyErXzPJ/4m48wGBdS4FkFpxOJUgYH1MeUQsyJczCzfgUQHF60ymp+dwM
	cNwlY4aMbYvsK2nv8O2AFGZyyvmKzn8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-EtFALHNYMpubJJrGttEWyg-1; Tue, 18 Mar 2025 06:29:18 -0400
X-MC-Unique: EtFALHNYMpubJJrGttEWyg-1
X-Mimecast-MFC-AGG-ID: EtFALHNYMpubJJrGttEWyg_1742293758
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ac29ae0b2fbso543523866b.0
        for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 03:29:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742293757; x=1742898557;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6+RqQ9ZAEqwS3Wc2GhSiEZkrs2uvAiEdXS3wPJ9ZEBc=;
        b=XimsB2by0ZP1MjY1GP+cr23qvHeVHMsYS/tog/UD+oJ2B9DIQvm1qd2dxzktiCdGSX
         EYZXMNUdoo5JYpQNNYEs6tsBWz4uh9VSDLPc/e9btiSqLq2cLsjXWUM280Uw+OB4JnWC
         WCEczX1WENixRaHRHZuNmDpp/xsNgZrw2m0E2Jbgre732IlsJpn1X3vjIO9Wa3EMi/BA
         FkskSnGtxzGrRFaPjPws4BdpuaSeVxv+RVGyWa5d6kgCVtRkBZgEPeRrx0zGGf/Bc6c9
         yyGdn99CZsHSCvCKP/Tf04Ologhmf9OVu9CFnpYfh0G7oiEHx6x4Ucy+E9MWwf3NFTc6
         YRwQ==
X-Gm-Message-State: AOJu0YyGuqfvr69BggECdHdIn5RzftATz83wIXFfQSYRWsXSbwhp3GqS
	D4Q8fsC8vhVcwt9IYAlkfoRKhmC1bop0JMMpsdXCjdTiNmmqudbwsKm0reZjTnazmJ/vAWeyrPp
	o0zzq6oB3AdrshKGosmMPC8QBgb+9TVCvGMAYe0o5unm+ZNGfaMFK2Q==
X-Gm-Gg: ASbGnctHPlwB6b1gaJ6ggWnfYkkfq2LkjTq76myMGjoSm+fOCjp3bpJkk2lnWMyKQkU
	riDBxcnAW8Co7h62tCIdw+EhPEG4smrltyjqo8msynBMLcF6Bo1uasY0sp2V0unIvupIu+PnpTr
	TT86kc78W7kryZWkx5vd5U//PyXhlHfahbXB/AOq6LqT6f5NwQpq8ipzvzQIuYPCEpkhzpQK2Ys
	O27V3kzZUvKuSA3xy747zrQDaEtDTz0v72HzilqYAdK0ytRVSAUOK4iv0p2PPQiVXzEHw1ij8Le
	McF9y+Y4CkjDtiX9vJa3mQH7ngde1SrkGlwqRjyYVGVkAQ==
X-Received: by 2002:a17:907:7f20:b0:ac2:690a:12fb with SMTP id a640c23a62f3a-ac38d405ac4mr326112866b.17.1742293757540;
        Tue, 18 Mar 2025 03:29:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJ9phnirtnPj5YmMubP6Ht2qkaUfOSLn82FDbJFuRSYXcPah8hVaAareCATLF7C7En8FYvbA==
X-Received: by 2002:a17:907:7f20:b0:ac2:690a:12fb with SMTP id a640c23a62f3a-ac38d405ac4mr326110166b.17.1742293757124;
        Tue, 18 Mar 2025 03:29:17 -0700 (PDT)
Received: from [192.168.88.253] (146-241-10-172.dyn.eolo.it. [146.241.10.172])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3147ed1e4sm831316866b.66.2025.03.18.03.29.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 03:29:16 -0700 (PDT)
Message-ID: <491430dd-71ad-4472-b3e1-0531da6d4ecc@redhat.com>
Date: Tue, 18 Mar 2025 11:29:15 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: fix uninitialised access in mii_nway_restart() and
 cleanup error handling
To: Qasim Ijaz <qasdev00@gmail.com>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org,
 syzbot <syzbot+3361c2d6f78a3e0892f9@syzkaller.appspotmail.com>,
 stable@vger.kernel.org
References: <20250311161157.49065-1-qasdev00@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250311161157.49065-1-qasdev00@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/11/25 5:11 PM, Qasim Ijaz wrote:
> In mii_nway_restart() during the line:
> 
>         bmcr = mii->mdio_read(mii->dev, mii->phy_id, MII_BMCR);
> 
> The code attempts to call mii->mdio_read which is ch9200_mdio_read().
> 
> ch9200_mdio_read() utilises a local buffer, which is initialised
> with control_read():
> 
>         unsigned char buff[2];
> 
> However buff is conditionally initialised inside control_read():
> 
>         if (err == size) {
>                 memcpy(data, buf, size);
>         }
> 
> If the condition of "err == size" is not met, then buff remains
> uninitialised. Once this happens the uninitialised buff is accessed
> and returned during ch9200_mdio_read():
> 
>         return (buff[0] | buff[1] << 8);
> 
> The problem stems from the fact that ch9200_mdio_read() ignores the
> return value of control_read(), leading to uinit-access of buff.
> 
> To fix this we should check the return value of control_read()
> and return early on error.
> 
> Furthermore the get_mac_address() function has a similar problem where
> it does not directly check the return value of each control_read(),
> instead it sums up the return values and checks them all at the end
> which means if any call to control_read() fails the function just 
> continues on.
> 
> Handle this by validating the return value of each call and fail fast
> and early instead of continuing.
> 
> Lastly ch9200_bind() ignores the return values of multiple 
> control_write() calls.
> 
> Validate each control_write() call to ensure it succeeds before
> continuing with the next call.
> 
> Reported-by: syzbot <syzbot+3361c2d6f78a3e0892f9@syzkaller.appspotmail.com>
> Closes: https://syzkaller.appspot.com/bug?extid=3361c2d6f78a3e0892f9
> Tested-by: syzbot <syzbot+3361c2d6f78a3e0892f9@syzkaller.appspotmail.com>
> Fixes: 4a476bd6d1d9 ("usbnet: New driver for QinHeng CH9200 devices")
> Cc: stable@vger.kernel.org
> Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>

Please split the patch in a small series, as suggested by Simon.

Please additionally include the target tree name ('net', in this case)
in the subj prefix.

Thanks,

Paolo


