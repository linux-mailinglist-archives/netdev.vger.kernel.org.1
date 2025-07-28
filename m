Return-Path: <netdev+bounces-210640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFAFAB141C6
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 20:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BF603A8BFE
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 18:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF5D19AD70;
	Mon, 28 Jul 2025 18:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mn4UnRsG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A102F56
	for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 18:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753726524; cv=none; b=cT5iRXTcqZG+eWKb6ORSF7bf24MTt30ow8AJ5ocZLQUe0llOMAdxjoa1myJ6UlIa23BloT5naqEjeBhp2wfi+BQ7u0Jj0sTH1x3Yjt5CLh+0XTGgAdh1dzA5KsWO1E8aAF0SqbeYZXsuRXftXn9aW3B+7LT1NoVe6n9hKxku+bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753726524; c=relaxed/simple;
	bh=UnNoLvcqby/AXC2wRhJtbbIz5cI7bNawbd3DeCHbhO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kvSlPzlfTydDQuclUGyE5yihUBs07bI7Qzco+BHmVEGwSGv89kJFVw2crTDQifjDs+bGxXFFrzhuxmqmH70U1jLHfu/H0HDd8Mfjq0Hp7Om3iU9d8PfApboymDBPlsSanDmEGjI7GNvHlbtReDRpGhrMSIB1vX8L2jcFuv30Bpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mn4UnRsG; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3e2ab85e0b4so1158805ab.1
        for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 11:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753726521; x=1754331321; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dk0sIdk7+FbFHz5f62Zg+hacvogZgQoEIWE9iCUDLWY=;
        b=mn4UnRsG50obeiYV60r083bKmJ6Ro/aLnWsxEZUv82cYJW+BfaoHTA0KAzqYQY7pOs
         L4YlBmwwWhga6wHjB9VEVMiroS2Mv+uWzF8DSXAhOU+wWteUQUeWtTVYVNfAgaPGgNwq
         97cE0DGhq1TXJiWMYDnvjVhAy5/Fgm3Zzfv1xuCYCwMKl6vlPXJEEPkf+WciV0sfHBQI
         LoHUDj4GA9HlOH3toAS41RLo5COXvrWevJS2CH/eTDk96nXl3XZegzI3Q8p51IWPFfse
         4IxhzdsBO2RmSABzwRObsCzvhwYdWoqH2oXDPXcFnq3M64JoAyn5RYyaXpnQ4Z6ja6Nh
         xPhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753726521; x=1754331321;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dk0sIdk7+FbFHz5f62Zg+hacvogZgQoEIWE9iCUDLWY=;
        b=nMYJLzSFc+V1EJb8chUIw91QhWFEnCsxcqccadAvZ2CeAVhbh+h0tOdFmkAwRMcZD0
         dfuhU73UmzA8I0/Q3Y3tDn1DUCkgq5gfrN7076f5tbmam09PO/cmwBIGUDV+6MTqflLx
         dC7a+ZxTmWWe82ADYcH3AGOc0RlGNwO2RJdPcn5+R10D76k3hbdeJS87y/szibEA0SOh
         UXvfkz+hIi71tAeF0HKeHxasnKlZDYAWWA9yTetMYGMQmwhG+pFPHEj8Iq1et3bfhHeG
         TGCMijRnF6nobQgZepRcJl1dSzFdTR/4qjGF2rV0Njs2+tw1hdflyb4lbFWPncSnU9AZ
         Q3Pw==
X-Forwarded-Encrypted: i=1; AJvYcCXXG3hhhdC51IuugGP2X+EIvBmOvqqSmLYrU2VkylAcdylu46e0O21Z3dt97h09bDANJ919BzE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIJqx6o1L0bTtZ8ImggYeuQplUuVc3G+CNa0+gQxB1zcEru+QQ
	+9HXXuydH9/lYimMzL0RzHe1mE25tm2cqRWSKW7ue93pukv6mtfNshr7/2SXWw==
X-Gm-Gg: ASbGncvh5p0e3LEshFHa8IVGpbGDxCQ/eVg/+So/jCIz9gCVgmm91v/l7+Dcy5zVF+1
	zUKhXwJIGZpkj9M1x026SKdNOpXLtRhXITPM5fJiE0rfprceeF7sIVqaSwzz621qqlWnKkib6s0
	DOrOwxPpFjXzAhRsb29dElHONW3FTMwVf28sp2KA60fssRnVMrtKomyHfsOCehPnPUfIT4ftFZn
	TBa5rRwx2pJ/nw2KkK9fF+i5ZlJ5keyT6n/F65EoHkVCtbstLvN6cXh6MVyMC1sHsphnuTmlzTk
	Yb/+zGziPjCAtaJTFN7/qDxC+KdGxBzziJvX663O769oBJjrLcJdFHlVqHDoVCHXXk+AaRjXgQ7
	dcOsNOVLvIPnfmSVNfBeOCe0XYHtySice/LGISTaMF6VPIFyRCs/SyaR9G3LWzty+T7Gdne3vwd
	1bFFUMbEU5
X-Google-Smtp-Source: AGHT+IHwfSFeuAVqPCZjXFPJP61dr3UmRekmwTdvPKLnlkf0U00nXJRCKDowdacBVxakjRM7Y4BQ5Q==
X-Received: by 2002:a05:6e02:1b05:b0:3e3:b4ff:15e3 with SMTP id e9e14a558f8ab-3e3e92eca13mr7910215ab.4.1753726520688;
        Mon, 28 Jul 2025 11:15:20 -0700 (PDT)
Received: from ?IPV6:2601:282:1e02:1040:1122:1338:f1d4:15b5? ([2601:282:1e02:1040:1122:1338:f1d4:15b5])
        by smtp.googlemail.com with ESMTPSA id e9e14a558f8ab-3e3e4b013a2sm3988965ab.19.2025.07.28.11.15.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Jul 2025 11:15:20 -0700 (PDT)
Message-ID: <796ca41f-37a1-4bdb-9de2-e52a2c11ff49@gmail.com>
Date: Mon, 28 Jul 2025 12:15:19 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next] iproute2: Add 'netshaper' command to 'ip
 link' for netdev shaping
Content-Language: en-US
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
 stephen@networkplumber.org, netdev@vger.kernel.org
Cc: haiyangz@microsoft.com, shradhagupta@linux.microsoft.com,
 ssengar@microsoft.com, ernis@microsoft.com
References: <1753694099-14792-1-git-send-email-ernis@linux.microsoft.com>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <1753694099-14792-1-git-send-email-ernis@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/28/25 3:14 AM, Erni Sri Satya Vennela wrote:
> Add support for the netshaper Generic Netlink
> family to iproute2. Introduce a new subcommand to `ip link` for
> configuring netshaper parameters directly from userspace.
> 
> This interface allows users to set shaping attributes (such as speed)
> which are passed to the kernel to perform the corresponding netshaper
> operation.
> 
> Example usage:
> $ip link netshaper { set | get | delete } dev DEVNAME \
>                    handle scope SCOPE id ID \
>                    [ speed SPEED ]
> 
> Internally, this triggers a kernel call to apply the shaping
> configuration to the specified network device.
> 
> Currently, the tool supports the following functionalities:
> - Setting speed in Mbps, enabling bandwidth clamping for
>   a network device that support netshaper operations.
> - Deleting the current configuration.
> - Querying the existing configuration.
> 
> Additional netshaper operations will be integrated into the tool
> as per requirement.
> 
> This change enables easy and scriptable configuration of bandwidth
> shaping for  devices that use the netshaper Netlink family.
> 
> Corresponding net-next patches:
> 1) https://lore.kernel.org/all/cover.1728460186.git.pabeni@redhat.com/
> 2) https://lore.kernel.org/lkml/1750144656-2021-1-git-send-email-ernis@linux.microsoft.com/
> 
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> ---
>  include/uapi/linux/netshaper.h |  92 +++++++++++++++++

the file in the kernel tree is net_shaper.h? drop it from the patch and
ask for it to be added to the uapi files when posting the next version.


