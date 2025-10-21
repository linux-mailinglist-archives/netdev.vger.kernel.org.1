Return-Path: <netdev+bounces-231121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B9EBF5739
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 11:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 469E83AB05B
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 09:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6A732AAB6;
	Tue, 21 Oct 2025 09:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AWV2O0h9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22802246BD5
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 09:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761038014; cv=none; b=cGmBRQftgLj3Y98k8Q/Ttk1+bDqH8thRgDOhnsu9FxMcGWEOGjmxDms+QdGZvvP2qBN/n2BuMqqvSateNIp+umici2oVhxlLg1dyWmKft7vGutbh5aL/LLTiihWP4S/JnKGhmr/TqARlXOpPobnkcqBbVB4MzS9TAwnl6CVdGe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761038014; c=relaxed/simple;
	bh=FNo66ablbsEBNbP+Xp31Vkt9QboxxnE3NasPNx4kGi4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WLZjCd697sI5MxZjxm7pU8MKVXa8yECJJbIclVJfv7u81SCxbh/E5iRemw/igH4phKx+BG3VRmsHpOXmvnSSWA73DWuYrSFrH98l2uxg2U/fk3S8BSsRWIER90LySUmucXN1nYoaQKBWtAfTl6S+LzmaxdSyH5fuNK3tgJu1/zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AWV2O0h9; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-63c3429bb88so6515848a12.2
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 02:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761038010; x=1761642810; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A1ql3iSX2umr1Lt+k9J1d3sz6ezZqS3QfSbZGtytons=;
        b=AWV2O0h9qOb5a3OIJGUHt+bn3skyja3qpLN/V8kYA0u4luhk5dRr+Zdp+KPy+k45Tn
         1B/JMhkGWNcTiDzGEk+6E2riN66KYcIEjTTD2RpcmXVP9rLuQh3b1p9456pLD1b/t/l9
         7OC9rKkV83COEKeukS9SRgzk3l3Q9rQAtqGhUy+0eMaL6zi//t8BcPpGoFYLDuYQyyA3
         aFkUlytDuxRTk+AgBD5TmOMcx/SOBcYekBkrLbJTg5VlIAmjzCDN4zi54X0lsordllib
         rKKq4PK9KMkCHpBf2XJ/qb6m6283Sg8skav+74QS9ZM+MrhGqtNesqWoECTnZnAAAUik
         qLYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761038010; x=1761642810;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A1ql3iSX2umr1Lt+k9J1d3sz6ezZqS3QfSbZGtytons=;
        b=BqyTwCJ2STSEyxo59+JaTHBI+qGu+zkliLz0kIlf2L3cuclng6tNwMapG79z45xTIB
         Atgi8olvIgIdsGHR9JYUJEZP2vQFi/s7V9hiX9kvv1EZ7r8S1vXenBTh5IrTlxHR9pha
         otIbDaCqQEcPo4Ny8tjPvZKdjOlxR+AcQwHqTnVB4UTHnFUIoVwjcGEM9kMnh+aCy3AU
         VbY3hnNmtoA7gzHj0VTAdeIODMsPc0nrhiRh7NFfenxlYxD9t3PRxcUMrIiV8p27KTw0
         JNRov4/D1H3RYWQqcLuL+IMrCeeQgylXePV4TN7p+ZM4I07QxcCGJWzby4/6cPIjDe2G
         F7xg==
X-Forwarded-Encrypted: i=1; AJvYcCVob8+//EcV5AS8U5x4RlvTxNyQDvPSjch+glV1FEaOJcPFK9B/kuOBgjHu7fZAyQr10VepVEs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0SFHONOKGSyBsTGSN7cQxrcpCK/G5cAe0KooBAe5wb3VP4jLc
	d9TdRjlsI/WvKAoMB9st5k9llDV8p8tJMRt9TRJwG3dmc3cda4BMs65q15c+3vQbtfA=
X-Gm-Gg: ASbGncucucTyQ8QFc/LF9dFDSMEFFxY6Vx7k/94/6YYv3ukJCu8ekERFQb8HINvTQ47
	fyLB1kBjJSn/nC+fLArYAEgwcqX70g4l78w3rUXoYIL8HMOTYSATX6H8OegmE8BEQp92OPEAc94
	nmSKoehbbSX4KG0GV0QUzb2/2e7AmJEE47Ru68Zk06VUNHOY+GXxoWrLrFPBvlzS/W+2JhqHJ3j
	nDkRJU4Ur4tqYvitMIKUag62ozPMrRahxCFt5V8bdmGvPhnFBZohkCxcvJ8wcGDOxc9N6H93il6
	pWv1cDkMmrKr+8fu9r/MYMfy3ZI6YKGkzv5EDUBuULQdNUcBKamcfGqaHY/oqtrOuFwCT6z5Y4e
	l6lyKfweyIdWtfnhDt6botVFEc2sNGIT4DfGYiCAkEyme/+J9ws2XLqegU5beQJDT5Ot5MgJLcj
	76ui8XKjLveUgUbyE+2+TcYufE4DbSopMGGBrOu01Urg==
X-Google-Smtp-Source: AGHT+IFd4QN0J2LW3+xFPMyc6BTdCEN0R8oW3yx+UfHqJIodk+bFRpkHkmyO+iexbcL8GfK3AkDk3w==
X-Received: by 2002:a05:6402:234a:b0:63b:ed9c:dd16 with SMTP id 4fb4d7f45d1cf-63c1f631b11mr17034481a12.3.1761038010298;
        Tue, 21 Oct 2025 02:13:30 -0700 (PDT)
Received: from ?IPV6:2001:a61:1369:8e01:d78f:5536:188:1544? ([2001:a61:1369:8e01:d78f:5536:188:1544])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63c48ab45b8sm8838425a12.9.2025.10.21.02.13.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 02:13:29 -0700 (PDT)
Message-ID: <3cb55160-8cca-471a-a707-188c7b411e34@suse.com>
Date: Tue, 21 Oct 2025 11:13:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 2/3] net: usb: ax88179_178a: add USB device driver
 for config selection
To: Alan Stern <stern@rowland.harvard.edu>,
 Michal Pecio <michal.pecio@gmail.com>
Cc: yicongsrfy@163.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com
References: <20251013110753.0f640774.michal.pecio@gmail.com>
 <20251017024229.1959295-1-yicongsrfy@163.com>
 <db3db4c6-d019-49d0-92ad-96427341589c@rowland.harvard.edu>
 <20251017191511.6dd841e9.michal.pecio@gmail.com>
 <bda50568-a05d-4241-adbe-18efb2251d6e@rowland.harvard.edu>
 <20251018172156.69e93897.michal.pecio@gmail.com>
 <6640b191-d25b-4c4e-ac67-144357eb5cc3@rowland.harvard.edu>
 <20251018175618.148d4e59.michal.pecio@gmail.com>
 <e4ce396c-0047-4bd1-a5d2-aee3b86315b1@rowland.harvard.edu>
 <20251020182327.0dd8958a.michal.pecio@gmail.com>
 <3c2a20ef-5388-49bd-ab09-27921ef1a729@rowland.harvard.edu>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <3c2a20ef-5388-49bd-ab09-27921ef1a729@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.10.25 18:59, Alan Stern wrote:

> Another possibility is simply to give up on handling all of this
> automatically in the kernel.  The usb_modeswitch program certainly
> should be capable of determining when a USB network device ought to
> switch to a different configuration; that's very similar to the things
> it does already.  Maybe userspace is the best place to implement this
> stuff.

That would make usb_modeswitch or yet a new udev component mandatory.
That is the exact opposite of what we would like to achieve.

> Furthermore, with usb_modeswitch it's not at all uncommon to have some
> drivers bind momentarily before being kicked off.  People don't care
> about it very much, as long it all happens reliably and automatically.

That is probably not wise in the long run. If the device whose driver
we kick off is a CD-ROM, nobody cares. If it is a network interface,
we'll have to deal with ugly cases like user space already having
sent a DHCP query when we kick the old driver off the interface.

	Regards
		Oliver


