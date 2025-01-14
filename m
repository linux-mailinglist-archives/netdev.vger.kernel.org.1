Return-Path: <netdev+bounces-158027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 102BAA10210
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 09:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 765837A4410
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 08:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F8FB1CDA19;
	Tue, 14 Jan 2025 08:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sedlak-dev.20230601.gappssmtp.com header.i=@sedlak-dev.20230601.gappssmtp.com header.b="diiM6KCv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269131C5F2A
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 08:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736843552; cv=none; b=s9zpynn/ORnIgK2t8XddbPNSAZNSbyJtwsDcU3NA+cM70KBI9RgtU+a7TpicMyynX7PkO90lZhmsMg6nsTzIEiF+IT6ZJJGAbzCzqyP0G+xq6YyuLafspLZfm0vK+BD0TK8t22e92EQHJ2HqDAZaJ769HaWoLcAsyVI577friyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736843552; c=relaxed/simple;
	bh=/0l7iHb7VE3RNMs4qZVkW1iR2byrT52a/j55VuaJ6Iw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JvXxTe9xXtVieUkLacXXH+R1s9F9iJKXjjdtKhqdRV6in8D1YMy5w2sQ+YDtBmqdmbaJAHOlmxYouCHZoqjGfLufw69A4asCUnRODcNa6oCtvqN9XGW8unP1/UDfPeq2fMERLFyXTc3GAaIFW/aKGZFDZG3OpOn609Cciowe7Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sedlak.dev; spf=none smtp.mailfrom=sedlak.dev; dkim=pass (2048-bit key) header.d=sedlak-dev.20230601.gappssmtp.com header.i=@sedlak-dev.20230601.gappssmtp.com header.b=diiM6KCv; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sedlak.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=sedlak.dev
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5d90a5581fcso8816621a12.1
        for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 00:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sedlak-dev.20230601.gappssmtp.com; s=20230601; t=1736843548; x=1737448348; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=viLJXrRON3LuId3kJGF63clQ3P8ymoENgh5ioS2JxAM=;
        b=diiM6KCvz/0423dr/4+K64F2501nyc+oTakWc7+olQlBDIKPGND+55qcieoJVKByp5
         5uVxUUjt/6HXCK3VRS24uiZXtqAHw2fu2gAif8lcBeFQHPIj8sGYbvGhUC9Lc+MUFQ6Z
         myT9JPFSFHnacRINaiGyyB4oZVc8ltH6QN/uW2JjwCNS1jH3MOMbY8/CLsdnnWh8EY24
         KpgD7l1Bo98J2dAHw5pNwAW/CQMgL5fOWUUmy2OcYIjN3Yz4gFxKTZ+wnAlbUFkXx5s+
         HsTrMQrRp72+NFYw6FoBQJ+KWD7+tkABcAWlzl92pUfcoSkYQEV+iosHzc/p9Igdmfss
         8jyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736843548; x=1737448348;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=viLJXrRON3LuId3kJGF63clQ3P8ymoENgh5ioS2JxAM=;
        b=rpb7+FWZCOKvdeaSTfAKaax3xNJ5LjC3LxP0arkM38NrDDSYbnayknrhJq0v9XpTcX
         VqPvO9QqRhgjI72FJGYKRc+vgKbEVWWkMAKpvjDDwxKoZwpmGaE9h+5Xu9zrmoLyws16
         wYCqsQNGwo57iJ/drR9nKNBHjAbVLwHuLmQWiWWBjG3yGYgzk43MREp8KfK0aW/xDWCB
         lnfZbpM9cIhUO9wQv15Ytd2PwRIdybATzbZbD52DESosBcI7ax+KUr2Fsi9bIGKYqT/u
         YBnwGji35WsxAmLUHJpFnbI61mttg0vc+EkILuKKYaBFbyee0AKJW+qn1TVmTjt7eoEC
         hH/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWFiOMf193W28loknYu9N1SRrFFpADLEO/KLTbHnRavQB+0XgpaXb40FDpZGfxD6yEdKBCDCX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrUFsVpai1R45GvSwToREe4rEV7nthm083peXJCnjSxbPMWhBh
	dFqVoBHO3UIOR2bpQAhnpCPjeGLwq9NNyuzSeUG9FDnjtDSYI8ZAqYdiPqMAsMjVzpv70eVT9RZ
	N
X-Gm-Gg: ASbGncvVi68MdBmGK91p+cHzjjoKfZUpQGJOOFK3+TVFAEKhJwCNH4f/Mejug++qWbd
	MnTaXeGYaExtDBVuwlvTFyFEuXwh4yxOikdYsRaXdKAsOXWZ2PsC7VXGtKlCQb3xNDd0CDd2VEB
	AO0XHYMRorVcUWZk90BVfW/J3Q0oxSpr9H9l/tvqMizA5AWNjpEJUb57+B5X23I6iYx8hVIFxX3
	EzXfBk50zEQdP1U3+UZLw8FBfekecj81rmiF7Mfjix6gOfhuN0jd1EqEXCsm0ms8po=
X-Google-Smtp-Source: AGHT+IEoAu/bHC6PMPvHq2cBmT5tImWGnk5L4zFRS9n/NANKyF0/dMSpnJNaS5yxIlE07gPl4SJLNQ==
X-Received: by 2002:a17:907:1b03:b0:aa6:86d1:c3fe with SMTP id a640c23a62f3a-ab2ab6705b8mr2506074766b.4.1736843547977;
        Tue, 14 Jan 2025 00:32:27 -0800 (PST)
Received: from [10.0.5.196] (remote.cdn77.com. [95.168.203.222])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c95b299dsm597600166b.160.2025.01.14.00.32.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 00:32:27 -0800 (PST)
Message-ID: <adf7c053-ffde-4df8-bc24-99740906410d@sedlak.dev>
Date: Tue, 14 Jan 2025 09:32:26 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Question] Generic way to retrieve IRQ number of Tx/Rx queue
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org
References: <ca5056ef-0a1a-477c-ac99-d266dea2ff5b@sedlak.dev>
 <20250113131508.79c8511a@kernel.org>
Content-Language: en-US
From: Daniel Sedlak <daniel@sedlak.dev>
In-Reply-To: <20250113131508.79c8511a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/13/25 10:15 PM, Jakub Kicinski wrote:
> On Fri, 10 Jan 2025 10:07:18 +0100 Daniel Sedlak wrote:
>> Hello,
>> I am writing an affinity scheduler in the userspace for network cards's
>> Tx/Rx queues. Is there a generic way to retrieve all IRQ numbers for
>> those queues for each interface?
>>
>> My goal is to get all Tx/Rx queues for a given interface, get the IRQ
>> number of the individual queues, and set an affinity hint for each
>> queue. I have tried to loop over /proc/interrupts to retrieve all queues
>> for an interface in a hope that the last column would contain the
>> interface name however this does not work since the naming is not
>> unified across drivers. My second attempt was to retrieve all registered
>> interrupts by network interface from
>> /sys/class/net/{interface_name}/device/msi_irqs/, but this attempt was
>> also without luck because some drivers request more IRQs than the number
>> of queues (for example i40e driver).
> 
> We do have an API for that
> https://docs.kernel.org/next/networking/netlink_spec/netdev.html#napi
> but unfortunately the driver needs to support it, and i40e currently
> doesn't:

Thank you for the link, I somehow missed that part of netlink…

> $ git grep --files-with-matches  netif_napi_set_irq
> drivers/net/ethernet/amazon/ena/ena_netdev.c
> drivers/net/ethernet/broadcom/bnxt/bnxt.c
> drivers/net/ethernet/broadcom/tg3.c
> drivers/net/ethernet/google/gve/gve_utils.c
> drivers/net/ethernet/intel/e1000/e1000_main.c
> drivers/net/ethernet/intel/e1000e/netdev.c
> drivers/net/ethernet/intel/ice/ice_lib.c
> drivers/net/ethernet/intel/igc/igc_main.c
> drivers/net/ethernet/mellanox/mlx4/en_cq.c
> drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
> 
> Should be easy to add. Let me CC the Intel list in case they already
> have a relevant change queued for i40e..

Thank you for directions, will check Intel's mailing list and poke 
around with implementing that.

Daniel

