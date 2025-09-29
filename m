Return-Path: <netdev+bounces-227138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0F0BA8E09
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 12:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55FB13C4945
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 10:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD7A2FBDE1;
	Mon, 29 Sep 2025 10:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Im//W0Va"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C80260565
	for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 10:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759141296; cv=none; b=NvlnnnhxxRWk8VISJFJmbaWIfOduyrs1zeeYPNuHQoec+dRynBUIY6+5iacQP1r+2rOIQ9U6n8B3v7idn8hTtrqOKwR4XLQ3Gbgc2uLiVDPrx0ABQI7EvkM/7csKxEdT/YgoXQQ7TNPmUGVd1uFLqL0APaB/B/2bvx7FLCR64+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759141296; c=relaxed/simple;
	bh=sHzoMkJn5rMuogfvJJiJ1DJ7qKYiNTO4Ufwdd1t8dNg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GuDE0ebELDnBi3d6gtTYye5Vl/KsjSmA7+tuHmm/q5WU9LKpRnfUdOsGt/xhMLIAgdv6fxtofX6hLZOjhXPrXHWoj2pU6dUbxgLEhO5N+rnR55Hlwh3EIwRLdx5oY0uGW/EG54wl59PCcbg/tb3yGXTdxyZHn0JrO2G6nTKI6gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Im//W0Va; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b3b3a6f4dd4so301231066b.0
        for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 03:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759141292; x=1759746092; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=83SCFxQSl2n8uHVURYlncQ6T1axBoOC/n+5RpM43Bq8=;
        b=Im//W0Va4X9unAUA+jaDaArQKRJ1OcYVLX6rGsF65CiK+pv+A6sChWKzczKoZu01Vt
         P1q9+nbQ9bFBW+8yXZp/DDalxI1jmAyh8lyeQwCl3ldmPo1kd5OIQTvmqJka78uq9A5e
         R6/MghNN4Bndy4b7ez8mBTzHSjbEnq9c3+J5xz6g0eRHTzaZNxrAPMWg4P1h2nP9lfze
         KOtXczS2DxYodEflYNEwJlMqbWdRzK/Q5473FkEKqLo/dY0mONen/se9+UqqHkBclbdG
         zkZUihDDPP3lcUPUaRiOKEOs0PP/vyakM8Yvmvo2eahALcqw9w8Ppuax4US6wnuVNROG
         QCgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759141292; x=1759746092;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=83SCFxQSl2n8uHVURYlncQ6T1axBoOC/n+5RpM43Bq8=;
        b=ODGlZpOIxfWmRG4l2un13NrfyNEo7ehTm7WEa5QW/+ut3vRTnJS+3yDfjUyzRBTYA7
         25wUtD+wbsPdTDrFR9Ru1Za0F5/L99K8jO30wrDKgGFhs8a6CBEQuvTZ6bPE9XH0H5DV
         Z4IeEiDXws0dIio27w5YPBICBkhIi6d9UklRvvcKu8FXsbmDD16YiYg0B4XPQqSb2tWj
         rcNTdpSwdzSCKDgiIXzsLzdNv7u0JgkqNvfvQHqhl9Hs0r1t6nJ59VH/JO6z00WbBowp
         7lPtRVIErALdG8miOSF1kGVV4L5upKZHM9BMbXFu7GFjPmjhFk3NAmGxihLItgSNPLfT
         HKxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWDRi6XcnVUM+PhB1v11K5EkiV5bSsQlopFaGb5+8BziGkNb78hASpyouOKLEI7hVUZC9TbOZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYcfZyAqKHVgMIhB3H8PCiiOkzgoOe8LRvDHouH8JqQ0NhwWRn
	TCxFkfp4UvA38NTaF1rkIx3SNtK7gj0JAkl7JNk8R/F8lM0FEPG0hqB4Amv4pqP+iEo=
X-Gm-Gg: ASbGncu7oCsSzO03MFyvgM9t25cUR+G20tkdLOL/dT5InKvOvNjNoRNTK3cs2+ldqxf
	JH49gGbb8RC3ylw2FwAg0S7PyWHL07gBORc9Rb4EMUdHDjScxpuFlHT7TP8qBggE1j8GnjO8+GT
	zMUXltsEZWLe6ZBNWlvIkSuHHlkRBp8I+oAglTjC61LOolJwZ6mpZYWvh4h4P1ZiEB9d145EPQb
	vzkRvS9vZb5Jv/oADvDikE/2xgsJanATYmlRcRCS18QcwXA2TC9xa6Iv6W7jpTs+UU42imZbUqG
	SwZ1Qq2qO6eYZi2eQZcTN/yBUY+FQFOAgHVGRGcHiAnc8VgiLBOik5rZ0t8hmj/9LsCh8V+1dTN
	mo1Wb0V/UHMG96lRGGUVe3t1jvmtpD2UyOqTGoi3il3Rox4FfCu3OeGOQ
X-Google-Smtp-Source: AGHT+IHjoH7Yhek7IIwEqV3iQtifKitwK2zUXthJIq83mjDA2PaIynPMn2TL+eicWpseoUaL5N0fZA==
X-Received: by 2002:a17:907:961a:b0:afe:b878:a175 with SMTP id a640c23a62f3a-b34bc9723demr1856639966b.46.1759141291708;
        Mon, 29 Sep 2025 03:21:31 -0700 (PDT)
Received: from ?IPV6:2001:a61:13a1:1:4136:3ce:cdaa:75d2? ([2001:a61:13a1:1:4136:3ce:cdaa:75d2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-634a36521c2sm7529826a12.20.2025.09.29.03.21.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 03:21:31 -0700 (PDT)
Message-ID: <5a3b2616-fcfd-483a-81a4-34dd3493a97c@suse.com>
Date: Mon, 29 Sep 2025 12:21:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] net: usb: support quirks in usbnet
To: yicongsrfy@163.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux-usb@vger.kernel.org, marcan@marcan.st,
 netdev@vger.kernel.org, pabeni@redhat.com, yicong@kylinos.cn
References: <c9e14156-6b98-4eda-8b31-154f89030244@suse.com>
 <20250929092942.3164571-1-yicongsrfy@163.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20250929092942.3164571-1-yicongsrfy@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.09.25 11:29, yicongsrfy@163.com wrote:
> On Mon, 29 Sep 2025 10:45:19 +0200, Oliver Neukum <oneukum@suse.com> wrote:

>> Please get in contact with the core USB developers. The problem
>> needs to be solved, but this is not a solution.
> 
> Thank you for your reply!
> 
> Should I add the AX88179 chip information into the `usb_quirk_list`
> in `drivers/usb/core/quirks.c`? (Of course, it will also include a
>   check for whether `CONFIG_USB_NET_AX88179_178A` is enabled.)

That would need to be discussed.
Ideally the probe() method of cdc_ncm would never be called.
But there is the possibility that cdc_ncm is already loaded
and the other driver is not.
>  From an implementation standpoint, this approach is indeed cleaner
> and simpler than my current solution.
> Is the method mentioned above an appropriate approach?
Well, no. Declining devices is not usbnet's job. If the logic
needs to go into a device driver, it needs to go into cdc-ncm,
which would need to check quirks.

	Regards
		Oliver



