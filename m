Return-Path: <netdev+bounces-146117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E13609D2069
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 07:46:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6A9A280DAB
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 06:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F357126BFA;
	Tue, 19 Nov 2024 06:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OS2Oge+m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9E61EEE0
	for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 06:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731998809; cv=none; b=GQ+Gubkm9Oy5XgQqKa43Er4mJ9f+SyNplj2qBwTD1VhRAKnqTR1I46Wo6Hj2ark1s3kZ5MMel6A6CGu+fs0gwZ+q74igbLr9re0qfMOR0wr5GM37ojcIjc4xLGMEzDnTe/K0GugxbaAdNgEx0RBNzbEU1KYb2g0FEEcpa6gIpQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731998809; c=relaxed/simple;
	bh=0z1vsNdKrgYHCrrqESVjUREFmqxvtxnCsQDRVR/L304=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=PLl+UTWCyslCMU55THogNGvC06VQrUlRMIR/f8RI6V4/K5t0o7Tmcy519FgJREmt2TLA/XbtB1SRaTpYoRWaNhMvGwJWf+FNH0m/utq5FdlVxIahLoczBNoHRTUHTycg9CIVjCMP/j78R/ocbgSvGTPp7pqjjyTjS5U8dmQS07A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OS2Oge+m; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5cfd3a7e377so1579542a12.2
        for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 22:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731998806; x=1732603606; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=lOvPz3IPVYkDkdKecjW8ncUGqm3Qe5ppUInBCbIjDo4=;
        b=OS2Oge+m84XXvTvk5dO6a9HCFohtjTpBUJh1xKrSQt7amaAsyZdEg092Rz77q8EPTi
         8pxaR5Siprn0Ex+/RgWfDdXRture52VVz9J1izTPy8bpHbHn+EoNRHKyR2WLSZPI45gl
         ade7d7EJvz++hOLI5N/iLo9Vu7qFz6ZiU6TmZ75wx3JZPtgTwxnRJMoTp+l/ZKwEpkjc
         x8l+dVZSnjGgBY0J05M7LF7763WMrNGQcM39/rQWg33oRhmth9L8Wa+Gvbgkeuntkzrk
         KbqsYh83XOT97NdigvAUoRsHhG2PlMk7ylEwBt2D5srjJNaRqfFD5ci/WbhOB+ZgGamS
         M79Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731998806; x=1732603606;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lOvPz3IPVYkDkdKecjW8ncUGqm3Qe5ppUInBCbIjDo4=;
        b=gfXGNgxlQHEPXopaT+LbUt6WPE9sF8+O3t6BK/nHuwx6yX8GVJ12CQl4SgOgxkcBN8
         hH1mPDNUGEnl4gDDYnuNFFf2P9BDRZiU5KvC5tVVu1yFDOQpACsarljbnXI+C3cXSxr3
         Abn0KjsGOgMYsEvkXkb2zS4HuzdVAaXi92zpenVZxzXuRttHrJhs08yrVD+qZTL1NwEu
         6EcuW0B7uGrRCjTzm3cHFv0/HBUe9pu40dAA6Bh4oSv6TLlzJ/sClKAErXAUt+fP4vCB
         l5OAuRt8g7tbXu/LL727ONr8d++U5X6Pv1hyMGkAFAZuk05INZPe6uLA2+249XvsAAeD
         VEsw==
X-Forwarded-Encrypted: i=1; AJvYcCX83TYu/5rh4v7o3pD764OEPykVex7m87uEcCSXU6clJEktDT1mXyq/4yTlb+m61FPKVk4jhsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfO/XNeiArOf4DKwJh5GSz9xfjH/HueizNhuF37vBDniI2382f
	+peAKnWz5DElhz4w1ltRm58bdObJCmbTYrYjZ7Reopp0Pe06WTjd
X-Google-Smtp-Source: AGHT+IFun732DYghNZrKN7QIj0owXyXQDfXF+RG55WwLYPVPI/Kub5U85BP9+1pLrjhsjH9Mip/vmg==
X-Received: by 2002:a50:d719:0:b0:5cf:b002:6677 with SMTP id 4fb4d7f45d1cf-5cfb0027395mr6211471a12.15.1731998805692;
        Mon, 18 Nov 2024 22:46:45 -0800 (PST)
Received: from [127.0.0.1] ([193.252.113.11])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf79bb329bsm5428406a12.38.2024.11.18.22.46.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Nov 2024 22:46:44 -0800 (PST)
From: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
X-Google-Original-From: Alexandre Ferrieux <alexandre.ferrieux@orange.com>
Message-ID: <96ec3de5-76a8-4d72-b8d7-feedff4a3af8@orange.com>
Date: Tue, 19 Nov 2024 07:46:32 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: RFC: chasing all idr_remove() misses
To: Cong Wang <xiyou.wangcong@gmail.com>,
 Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, edumazet@google.com, jhs@mojatatu.com,
 jiri@resnulli.us, horms@kernel.org, netdev@vger.kernel.org
References: <20241110172836.331319-1-alexandre.ferrieux@orange.com>
 <173147403002.787328.3694466422358304986.git-patchwork-notify@kernel.org>
 <40bb5d4c-e21d-4eac-aec0-25b2f722be6d@orange.com>
 <ZzwLU6JHOTmZQ4oS@pop-os.localdomain>
Content-Language: fr, en-US
Organization: Orange
In-Reply-To: <ZzwLU6JHOTmZQ4oS@pop-os.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/11/2024 04:51, Cong Wang wrote:
> On Thu, Nov 14, 2024 at 07:24:27PM +0100, Alexandre Ferrieux wrote:
>> Hi,
>> 
>> In the recent fix of u32's IDR leaks, one side remark is that the problem went
>> unnoticed for 7 years due to the NULL result from idr_remove() being ignored at
>> this call site.
>> [...]
>> So, unless we have reasons to think cls_u32 was the only place where two ID
>> encodings might lend themselves to confusion, I'm wondering if it wouldn't make
>> sense to chase the issue more systematically:
>> 
>>  - either with WARN_ON[_ONCE](idr_remove()==NULL) on each call site individually
>> (a year-long endeavor implying tens of maintainers)
>> 
>>  - or with WARN_ON[_ONCE] just before returning NULL within idr_remove() itself,
>> or even radix_tree_delete_item().
>> 
>> Opinions ?
> 
> Yeah, or simply WARN_ON uncleaned IDR in idr_destroy(), which is a more
> common pattern.

No, in the general case, idr_destroy() only happens at the end of life of an IDR
set. Some structures in the kernel have a long lifetime, which means possibly
splipping out of fuzzers' scrutiny.

As an illustration, in cls_u32 itself, in the 2048-delete-add loop I use in the
tdc test committed with the fix, idr_destroy(&tp_c->handle_idr) is called only
at the "cleanup" step, when deleting the interface.

You can only imagine, in the hundreds of other uses of IDR, the "miss rate" that
would follow from targeting idr_destroy() instead of idr_remove().


