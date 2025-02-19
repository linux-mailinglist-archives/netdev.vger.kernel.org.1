Return-Path: <netdev+bounces-167555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D44E0A3AD00
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 01:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AECFD1892018
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 00:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF4DBA45;
	Wed, 19 Feb 2025 00:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="uZBJjxtX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAF2E286297
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 00:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739924164; cv=none; b=UkBXI8IX2+mA5ldjjWuaz9HWccB9Woy66cMadxqa+UWXj9slisH9tJQejnpLCJj/GQv8R4HxFNl0N7zBdZwCi1AFuwZDKEKmGZqKXCAefmOCPbQXhXBpS3aiDdZPLr8yodX1SSgiYTWOmMMDIzLFqjPL3DRguJEiI/0x54jrWRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739924164; c=relaxed/simple;
	bh=4afUTfw8twloTKFv6veqSNc3S7boGpWIpq37cR6mZjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pV1Kv/1vdB4pCiY9fGHF25GmOyi7zRn5sHLAPUW1LmoxmZCsZtKdFZHjevhbiHNkAEiS1GG1inL1cLE657t6AauKoTKtzn1xefEnVSHlC47sbaX9bnY1fmdqRwC/+dZIIwJ2yyS3hva5UGRnrvbM/DrNQJzd2yKR4KR1v55hWt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=uZBJjxtX; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21c2f1b610dso155526315ad.0
        for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 16:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1739924161; x=1740528961; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F+Gh4PrfHRYwmN/JuhdKzcKHRNfNVtrP3/weQUhJ/T4=;
        b=uZBJjxtXG1V/LgOjIgKYyr4n2zXeWAD6AttbVKdjmkIF5fUKC6nOjdnPzJgJagkoR1
         ZMveMD981zHR59GLp47hMtP/uXPzRDBnk8YtFf/4/YyldnG3eRPIJlEhMv4PfowsM94P
         tJfr+XWqlE7QEgrgAZmq5MlSYijPvjLUJ7sQanAeDmeZO7+W6aoq07D9/rezEe8SNsMi
         5xtwuYHVCzWrEd+/yVGN8nozsROQ3RFwnqoFuLDN/cUhYMddJ81SPStm9riaSVpUGWqH
         r+g/N6fkKkPLVS+4afb9e6YengMWy2dEYm6CJN2FKDDQoNRwa6zUcSGH7It0HZRupCII
         sclw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739924161; x=1740528961;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F+Gh4PrfHRYwmN/JuhdKzcKHRNfNVtrP3/weQUhJ/T4=;
        b=pyf21PLk/LZ+kDKYuk8xUuHQGlU9+Ad3fosJ18lxCEieHuUFiQf/PE1yataHGTu1t6
         DvHTn2WbQA7OO2LZPhGwUJv+k8SfF/v5JNgzO1O8e76uNVHd/ISXIodQeReqMgUzHXz2
         gCl5mJSWpY49kxxYidMaqlA3O8cv1GJjcI8DTHnlzmOXIGhYEuSot12rva2HwadnbPlm
         NILq1sgMxKjSnVCNKy+HDgG06WGeTPQRJvDbkJmgAQjlYy//Z9BZzHyL+4ZtQ5VBdTmj
         u/x3ecZegpJvB9LyZ6SNetjn7IDpXB/+zfutJH8LT0MaUapw2iOpmu+fXIlUi3Gl5DRW
         QCjA==
X-Forwarded-Encrypted: i=1; AJvYcCVcuyJdUMTFIR8Miczs+DmdOFxjUjie3DPrB8OYgNWkMWb5RcMh3yUsR6PceYceDQ6XNGBCViM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbrJcvrQ5isK9tX9TSB4GItZddhIEpnji7mF9vmPNEJ6rhnR6H
	gZ1FpI35RyNoXSSzwSuGpNjvhpZkAG8a8BmEtbdj5DWeXcAoAV5QNNouJMCD0qI=
X-Gm-Gg: ASbGncvU2Vy3DWhfOoBiif7By/kvp0IGRYs/plrBjqguzyYOf2+du3estRMtnsr2pFY
	RbuO17M7qvoCmpe3BeiUQ22kuANkub06FcS1Rhq0l1XFp5F0sLllBpBaWmorLNQwOzNzHkc2cMv
	RcVVzeHiqrDiN9CjCouIzfYhw5WL1ntB0iySEI/kjNy+uHowr+VDDqwgfpksUC18QGjt2XalxoL
	Jk828ssCDVnL74YiE2PUC+EJ37jzC+Cwue2CnYI5hOe5uOBWpHeUwtI+lsQeESYuHjymU6rjS8h
	1W1qarrjgt/LMVPYwnvmmrjZQONNHkTUPzkp9Llptw3Xy7UOj7+1DQ==
X-Google-Smtp-Source: AGHT+IEehJ0CJQTvwKtuooa6YZUQtdip7vljh1EEdDBXuWMTdmR+h+2oja8FelNoKTbsjNhXhE4d2w==
X-Received: by 2002:a05:6a00:3d55:b0:730:f1b7:9bb2 with SMTP id d2e1a72fcca58-732617dfd49mr23422020b3a.13.1739924160910;
        Tue, 18 Feb 2025 16:16:00 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1156:1:18cb:90d0:372a:99ae? ([2620:10d:c090:500::7:d699])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7326c87a86esm6368001b3a.132.2025.02.18.16.15.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 16:16:00 -0800 (PST)
Message-ID: <5e6974f1-3a8f-42c0-8925-22c7e9c44cf0@davidwei.uk>
Date: Tue, 18 Feb 2025 16:15:56 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 8/8] bnxt_en: add support for device memory
 tcp
Content-Language: en-GB
To: Taehee Yoo <ap420073@gmail.com>, Mina Almasry <almasrymina@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, donald.hunter@gmail.com, corbet@lwn.net,
 michael.chan@broadcom.com, andrew+netdev@lunn.ch, hawk@kernel.org,
 ilias.apalodimas@linaro.org, ast@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, sdf@fomichev.me, asml.silence@gmail.com,
 brett.creeley@amd.com, linux-doc@vger.kernel.org, netdev@vger.kernel.org,
 kory.maincent@bootlin.com, maxime.chevallier@bootlin.com,
 danieller@nvidia.com, hengqi@linux.alibaba.com, ecree.xilinx@gmail.com,
 przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, ahmed.zaki@intel.com,
 rrameshbabu@nvidia.com, idosch@nvidia.com, jiri@resnulli.us,
 bigeasy@linutronix.de, lorenzo@kernel.org, jdamato@fastly.com,
 aleksander.lobakin@intel.com, kaiyuanz@google.com, willemb@google.com,
 daniel.zahka@gmail.com
References: <20241022162359.2713094-1-ap420073@gmail.com>
 <20241022162359.2713094-9-ap420073@gmail.com>
 <CAHS8izN-PXYC0GspMFPqeACqDTTRK_B8guuXc6+KAXRFaSPG6Q@mail.gmail.com>
 <CAMArcTVY+8rVtnYronP4Ud6T0S1eSgQX3N0TK_BFYjiBxDaSyA@mail.gmail.com>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <CAMArcTVY+8rVtnYronP4Ud6T0S1eSgQX3N0TK_BFYjiBxDaSyA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024-11-01 11:24, Taehee Yoo wrote:
> On Fri, Nov 1, 2024 at 11:53 PM Mina Almasry <almasrymina@google.com> wrote:
>>
>> On Tue, Oct 22, 2024 at 9:25 AM Taehee Yoo <ap420073@gmail.com> wrote:
>>>
>>> Currently, bnxt_en driver satisfies the requirements of Device memory
>>> TCP, which is tcp-data-split.
>>> So, it implements Device memory TCP for bnxt_en driver.
>>>
>>> From now on, the aggregation ring handles netmem_ref instead of page
>>> regardless of the on/off of netmem.
>>> So, for the aggregation ring, memory will be handled with the netmem
>>> page_pool API instead of generic page_pool API.
>>>
>>> If Devmem is enabled, netmem_ref is used as-is and if Devmem is not
>>> enabled, netmem_ref will be converted to page and that is used.
>>>
>>> Driver recognizes whether the devmem is set or unset based on the
>>> mp_params.mp_priv is not NULL.
>>> Only if devmem is set, it passes PP_FLAG_ALLOW_UNREADABLE_NETMEM.
>>
>> Looks like in the latest version, you pass
>> PP_FLAG_ALLOW_UNREADABLE_NETMEM unconditionally, so this line is
>> obsolete.
> 
> Okay, I will remove this line.
> 
>>
>> However, I think you should only pass PP_FLAG_ALLOW_UNREADABLE_NETMEM
>> if hds_thresh==0 and tcp-data-split==1, because otherwise the driver
>> is not configured well enough to handle unreadable netmem, right? I
>> know that we added checks in the devmem binding to detect hds_thresh
>> and tcp-data-split, but we should keep another layer of protection in
>> the driver. The driver should not set PP_FLAG_ALLOW_UNREADABLE_NETMEM
>> unless it's configured to be able to handle unreadable netmem.
> 
> Okay, I agree, I will pass PP_FLAG_ALLOW_UNREADABLE_NETMEM
> only when hds_thresh==0 and tcp-data-split==1.
> 
>>
>>>
>>> Tested-by: Stanislav Fomichev <sdf@fomichev.me>
>>> Signed-off-by: Taehee Yoo <ap420073@gmail.com>
>>> ---
>>>
>>> v4:
>>>  - Do not select NET_DEVMEM in Kconfig.
>>>  - Pass PP_FLAG_ALLOW_UNREADABLE_NETMEM flag unconditionally.
>>>  - Add __bnxt_rx_agg_pages_xdp().
>>>  - Use gfp flag in __bnxt_alloc_rx_netmem().
>>>  - Do not add *offset in the __bnxt_alloc_rx_netmem().
>>>  - Do not pass queue_idx to bnxt_alloc_rx_page_pool().
>>>  - Add Test tag from Stanislav.
>>>  - Add page_pool_recycle_direct_netmem() helper.
>>>
>>> v3:
>>>  - Patch added.
>>>
>>>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 182 ++++++++++++++++------
>>>  drivers/net/ethernet/broadcom/bnxt/bnxt.h |   2 +-
>>>  include/net/page_pool/helpers.h           |   6 +
>>>  3 files changed, 142 insertions(+), 48 deletions(-)

Hi Taehee, what is your plan with this patch? Are you still working on
it? I noticed that you dropped it in later versions of this series. With
io_uring zero copy Rx now merged I also need bnxt support, but I don't
want to duplicate efforts. Please let me know, thanks!

