Return-Path: <netdev+bounces-222512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70405B54AC9
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 13:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F0213B12E2
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 11:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012EA261B96;
	Fri, 12 Sep 2025 11:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="mwmWvLNi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A743009E7
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 11:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757675714; cv=none; b=lMfc+72iq/ZtrfTPvSAkCEJnElGVrEndg4EOm5HmZ2m4N4ts+drQbM4SoRI0GmfkxiyqVJ4Lgg1ne9cq3z6n6Pqe9XFw77UhMeEfpP6pz6dzKUvxDArkrWn2hQ6+ZXKA8vDCThETviqtnkM5AaKV0hs1kTg8T8R+FSd+SjBF0LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757675714; c=relaxed/simple;
	bh=e5L+tVWzscZr4jLHDRbnNlvC5wSer04cc3J4F0Re2yw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a//cZqk6dEhgd2F9QaugFTu/YtgAlZc4z/VtR1mB44QqCY40DptScotiNlh67dORRHeGbz3D9p3nua4gqDElW/yBiaLMBoSNCd1JN7vcyU6wPfOsNYQGElXTQjrHvnXUurhpCbvDaRkPYadvjk6cBimdcXr5jNlFe8U7ngEgOHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=mwmWvLNi; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-560888dc903so2042949e87.2
        for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 04:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1757675711; x=1758280511; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y79xIpnC424FlOC64ZAsCAV+HYrgKwpFVZghrIQKO/0=;
        b=mwmWvLNiXML6exy4SRXlTldwGg6pMxhlr2TDF/7r2m8nA1D5kLFX2CLPLNmcVh60OI
         ucX3z7bq1gtD8cUHmFrkIL+HugwnqzuTCzdrZuGz3DY8pcQBtDIr9ICTVxIJvsiBzIOt
         KBmjJWxNuXi/c75xo5pqh2SEtQlmUlmNM2GzbbaIBSyBq9ttp5aZYOgu07pu5JzBsPwe
         4akkqM2jiK8Zxp7eROQ09tSc2SNqLn2lqdqn+UHrMoBEi/EvveY78lK33EascoHarWRQ
         zYi/35xeuoYzX2FTi98CcXYbwh+3TROE3VWxymt1ivvcfdP9E2pXN09smovEYPVrJt23
         Ossg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757675711; x=1758280511;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y79xIpnC424FlOC64ZAsCAV+HYrgKwpFVZghrIQKO/0=;
        b=R5tz/6jfxoaANIA2SdHEea9k9fC57hwULx/bR2fPIg8vveWJDv68CTa1wetGyuJ8Ry
         JFHY1LNt5FcKloPS1vrzBAlbcU/KFxT7L2Pv0xDutJg65wrSj555XSQiV3dTYyAEIs56
         hrcXKUrADttvtSMkyo7q4BT6Oi3A1A3vPhZpt9CPOHk7Pn6zWj5/7Ue3jV22f1OFxODv
         /eS20X4TTI45g1od4/nb5uqpvYTjWZyP4k7Gxb5z2oEyUoF4sCMB4QmD0NG5h7a4y3VP
         GcrRae9XPSUaFlxiyIayT464s+ESwZHsOq5EuqyDfHvisapUaEb/BC/zCVrqBkCItDTN
         aHeQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9Pwvk037j+cNdRpDBt3KBlyySfmsXi7ttvWnHde1J0TCm/kQIaDh/xNVKWHya6PR6u2yGrow=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTOIpV11YxJpjbHbLRkR+7JWMi+Vm3FM6pS15fIVFyFNbYcJ+g
	2jINBmGtzmuYy1YoVPk1xv8EKhd+lANA/7s63wqeCAsg+jhL0sumi15puw4/2HfR9t4=
X-Gm-Gg: ASbGnctPgSk24mql/faTS/Hl5vyRNuB88DFwTPBmGQw9/+Xq/Q8zixsaYLaq43FVPiP
	N8rjh/dPI3kJCtWzc+twRhCYMhbOAnXLpUCtwRyLvFeU6B5YErp2lflclymmaU1DfHAzlL5mLnF
	uuXfq6FIEynSsf0evZ6va/z9NvAhu8B73g8XRQCMAdrMvY5OSU5dlj9ow47/uC+rtOebrjraoT5
	TZpq7FeWxMcKeGpgoRNo6tS8bipouMfMFcIcWDbglOWFP+/1m420icih2GdXV7kIP9qg7Qr5HHo
	qtH+egfYWlA7Vkssbk7YFrtjPYbOhW6osZiRFsE0bRf44Vygh3gxvmlySqLkDv9z3q/T+hLTW2/
	nEbJvMVNZJ3IVw3FDAL3xjsmrOXyuZm459syRBFvvtEi0FwKcmvBmIQprCijIwh/WrrdLzF5pFa
	hRZQ==
X-Google-Smtp-Source: AGHT+IEX8lJuZL1YVpyfdl9mCWUkwiQ29IuRWpeUaJuKHQ4wANXuzKH9Gz1hogCk60GadYXtZCSGpA==
X-Received: by 2002:ac2:4e99:0:b0:55f:65f2:8740 with SMTP id 2adb3069b0e04-5704e34edd5mr666546e87.42.1757675711175;
        Fri, 12 Sep 2025 04:15:11 -0700 (PDT)
Received: from [100.115.92.205] (176.111.185.210.kyiv.nat.volia.net. [176.111.185.210])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-56e6460f138sm1063220e87.111.2025.09.12.04.15.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 04:15:10 -0700 (PDT)
Message-ID: <4daaaa7e-7a02-4e4c-be3e-c390d7f6e612@blackwall.org>
Date: Fri, 12 Sep 2025 14:15:06 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net 1/1] net/bonding: add 0 to the range of
 arp_missed_max
To: Pradyumn Rahar <pradyumn.rahar@oracle.com>, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, jv@jvosburgh.net, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org
Cc: anand.a.khoje@oracle.com, rama.nichanamatlu@oracle.com,
 manjunath.b.patil@oracle.com, rajesh.sivaramasubramaniom@oracle.com
References: <20250912091635.3577586-1-pradyumn.rahar@oracle.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20250912091635.3577586-1-pradyumn.rahar@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/12/25 12:16, Pradyumn Rahar wrote:
> NetworkManager uses 0 to indicate that the option `arp_missed_max`
> is in unset state as this option is not compatible with 802.3AD,
> balance-tlb and balance-alb modes.
> 
> This causes kernel to report errors like this:
> 
> kernel: backend0: option arp_missed_max: invalid value (0)
> kernel: backend0: option arp_missed_max: allowed values 1 - 255
> NetworkManager[1766]: <error> [1757489103.9525] platform-linux: sysctl: failed to set 'bonding/arp_missed_max' to '0': (22) Invalid argument
> NetworkManager[1766]: <warn>  [1757489103.9525] device (backend0): failed to set bonding attribute 'arp_missed_max' to '0'
> 
> when NetworkManager tries to set this value to 0
> 
> Signed-off-by: Pradyumn Rahar <pradyumn.rahar@oracle.com>
> ---
>   drivers/net/bonding/bond_options.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
> index 3b6f815c55ff..243fde3caecd 100644
> --- a/drivers/net/bonding/bond_options.c
> +++ b/drivers/net/bonding/bond_options.c
> @@ -230,7 +230,7 @@ static const struct bond_opt_value bond_ad_user_port_key_tbl[] = {
>   };
>   
>   static const struct bond_opt_value bond_missed_max_tbl[] = {
> -	{ "minval",	1,	BOND_VALFLAG_MIN},
> +	{ "minval",	0,	BOND_VALFLAG_MIN},
>   	{ "maxval",	255,	BOND_VALFLAG_MAX},
>   	{ "default",	2,	BOND_VALFLAG_DEFAULT},
>   	{ NULL,		-1,	0},

This sounds like a problem in NetworkManager, why not fix it?
The kernel code is correct and there are many other options which don't make sense in these
modes, we're not going to add new states to them just to accommodate broken user-space code.

The option's definition clearly states:
                .unsuppmodes = BIT(BOND_MODE_8023AD) | BIT(BOND_MODE_TLB) |
                                BIT(BOND_MODE_ALB)

Cheers,
  Nik

