Return-Path: <netdev+bounces-64057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EC9830EB6
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 22:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7754B21D2F
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 21:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B313722EE8;
	Wed, 17 Jan 2024 21:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="axWaZM0H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E622E1E87B
	for <netdev@vger.kernel.org>; Wed, 17 Jan 2024 21:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705527649; cv=none; b=H9FgnK5f2Azi/pY3P8iQTBondG8ErxnyxK/kyUJyHmnEKnqwJnLoshYgkkM+PaI+075caINTr2pDJzyBgbuupCDBW0Z53TK+4LExiRjb2RuqQrLWbzjVf9uvIDLUSHUD9gKWPbxWu6eMImtQtS3fdswgw5q2S2akEd5BjnLgcyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705527649; c=relaxed/simple;
	bh=JQFrCXkPGPgkXTSJSBzYNqRfwq+8+dStfD5EPEjROyk=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=M4jD1H79Bp4r/qOuhOy0jCqlQGFuAyE+V9A37H8lUcPcuepW2jcFEjIr8z/iBkPAs4l2MCMq4Yk7JjPIILRhFHzp5v5Bp4vTW9NaLlPSATZBo/+DU3k3e21YrbWDL8WzJVxoX/TuUVHQy+ouVDAlxahbvq6vGOD9mqxXaF9CtV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=axWaZM0H; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5ce9555d42eso9136746a12.2
        for <netdev@vger.kernel.org>; Wed, 17 Jan 2024 13:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1705527647; x=1706132447; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fV+bZWyzCioiYmNEGXM6k3JgAaHWhxF4g9+7kC7fgKo=;
        b=axWaZM0HpGZp0zyKqJgGMnZyAEHb1/g/wuPOOHWEL+K3JPeaMgiWp/lXe5lFl2weCw
         B0hiTD70E8w9Q9pix1LmYKUxD51hqDrzw1rEz7xXZ56vHUlV+If/olabFH/B+QBEkTPi
         iPoAMKGQ3y00NQRfpRAHSJQxeUppLJTPlVzvODuAxaUaIVSms+LWDyW3RKG52rICisVQ
         vIjfIVeJDDOlI4rY7qEQJAT9B5XzkM865HtUYbtycjZU6lKlA3mr+fp2929bNTcs1IWH
         +KcucZ1AX80kY4bq50lm4jnCRIar0jbQMCIuK5SDSKdDLg4D9HDslnhaeCrglLED5JoJ
         Iy8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705527647; x=1706132447;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fV+bZWyzCioiYmNEGXM6k3JgAaHWhxF4g9+7kC7fgKo=;
        b=cKvLaZFCwIPYeJAXC8l0J2/2fiXFKX8TXBP/vz5Hb7/ggwXp0sTxaBLOnxAIdSr0GO
         B4wMWPfjJsIsGCUqfmjkwUjmbFPa4zSeDVEl8dSDRRR9Vga0cv+mmlIpbqvgqLfDJrzM
         rFddyk/BD5iO9YTOhL5CdZS1AEJMRl/eM0pPvSCWZeQDfV8uTBGsNlKTAhTYYSf1uPeZ
         X/fdnbwRxgEsAzHCd8g+RSt9/lmwtXiEc1vXrH4TcJz5nkCF9rbmYDIjYHsEMoTd7f/5
         SHnY/4mo5ulAJxPZecZn6sEB68jq/8R7ZcPfWPyLpOezo+3mPfgY0ktUu2OY+TD9Zcq2
         wJPA==
X-Gm-Message-State: AOJu0YzEHWMWlbuqsR91mcsjsQ+OSf351t5FEOmOhOKmlhDVv6pe492l
	GOWe0lrezrGVrrlmm4Mhyzbwa4uLccmc
X-Google-Smtp-Source: AGHT+IEYwxKJw1rZoFcSlW+3Et9ViTApxs64aOdfR+qmywIJAclWCfgsFziywD2EZ/CDwWJwk90L4g==
X-Received: by 2002:a05:6a20:3143:b0:199:cd81:ba97 with SMTP id 3-20020a056a20314300b00199cd81ba97mr8049562pzk.22.1705527647159;
        Wed, 17 Jan 2024 13:40:47 -0800 (PST)
Received: from [192.168.50.25] ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id t187-20020a6281c4000000b006d99125b114sm2002736pfd.65.2024.01.17.13.40.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jan 2024 13:40:46 -0800 (PST)
Message-ID: <0b2bdc15-b76b-4003-ba1d-e16049c7809b@mojatatu.com>
Date: Wed, 17 Jan 2024 18:40:43 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXT] tc-mirred : Redirect Broadcast (like ARP) pkts rcvd on eth1
 towards eth0
Content-Language: en-US
To: Vikas Aggarwal <vik.reck@gmail.com>, Suman Ghosh <sumang@marvell.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "jhs@mojatatu.com" <jhs@mojatatu.com>
References: <CAOid5F-mJn+vnC6x885Ykq8_OckMeVkZjqqvFQv4CxAxUT1kxg@mail.gmail.com>
 <SJ0PR18MB5216A0508C53C5D669C07F72DB6B2@SJ0PR18MB5216.namprd18.prod.outlook.com>
 <SJ0PR18MB5216EBC3753D319B00613E79DB6B2@SJ0PR18MB5216.namprd18.prod.outlook.com>
 <CAOid5F8TV=LbN_UZzmGfOrq1kh8hak7jrivHm2U9pQSuioJP6g@mail.gmail.com>
From: Pedro Tammela <pctammela@mojatatu.com>
In-Reply-To: <CAOid5F8TV=LbN_UZzmGfOrq1kh8hak7jrivHm2U9pQSuioJP6g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/01/2024 16:15, Vikas Aggarwal wrote:
> Thanks Suman that works.
> I need similar "redirect rule" on egress side.  Suppose if i do udhcpc
> -i eth1  then I want  DHCP to resolve via eth0.
> Syntax on egress (root) side is different and more complicated and I
> need to learn egress syntax.
> I am trying to tc filter + mirror  based on udp and DHCP port 67-68 .
> Can you please help with this  egress side DHCP redirect too.
> Thanks Again
> Vikas
> 

tc qdisc add $ETH clsact
tc filter add dev $ETH egress ...


