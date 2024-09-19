Return-Path: <netdev+bounces-128984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE8997CB59
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 17:08:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47A941C23D60
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 15:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539571A0727;
	Thu, 19 Sep 2024 15:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bKU3398h"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEA21A2C17
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 15:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726758511; cv=none; b=XuzWo0sGT5Lxgt1mpLt8jZFqAYrrP9f7bp6q09130wHy7GdxIBRgiE4x/6BGn7hVFnEZh0yI3mFfZnHYAs+B9ANpaBkZqiy2zw92U1E2A4oqRSNXPwvzSIhgSvQc6R2o3yWuZY16+4LW++AGNt4hzKy1JLXSUAMrWlpicnsbAwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726758511; c=relaxed/simple;
	bh=B6xrLHOiTXPGiLy1Vm65lOgtDiq4Zi6/lhOYoo4a2Io=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hi3yFu7jPN/3gYP8vmtd5AVjHP8Z/MixZoCaNmPYRc3HIcQSzzz45As22KJdyse50Y2ZCeK4nccYHHk4ajs2np6NPH9eMAvxT6F3nGUUpZASOyapHd0iVknibyoFRjvbrJVm3oCYOgfoxU96RdHeLTAZEH7uaBOTMbsIJimQrjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bKU3398h; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726758471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JEDklkIuM4g74LbRiLWac77J7RDe0/5AVecDahYHHj8=;
	b=bKU3398hyNz8br3Eahy9UfMc82sbnMtgJcM6eqlQZ2UDnSh8XBFgneGDMEcdSHD5jV+abx
	972mOC+zNpB4eXqBm+u78uc2iN7m6FzRfGlyE0o7tG1KCWh/1f8nrhYQ5TuW2nrot4QFgp
	NP0erGv6/XrB1lPGz9NAQMXUcwDBJv8=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-g5fA5qTjOK6kMNQaPF4mkw-1; Thu, 19 Sep 2024 11:07:50 -0400
X-MC-Unique: g5fA5qTjOK6kMNQaPF4mkw-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5365fd3fab3so866082e87.2
        for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 08:07:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726758468; x=1727363268;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JEDklkIuM4g74LbRiLWac77J7RDe0/5AVecDahYHHj8=;
        b=TX6e3l5bdsfkg2yxN6NI4epkqQ9bg7XenQDT3aLjWkLEbFw0joEK+oA5CfzhuCfsGI
         joGegmx7J5D/M8sQF3tI+hsW2BFb4YIlHeQCQe1AXnHk+nnCzb30lJKrVeyR04HORvbl
         chMDcy/Tpi044eM95/7uh4x9Ki44tp1qp6Lr+d3IJX1W5OFuEQPTMzyanu2dZ+vngInm
         SjwH+KJVs/hymK984xLMtd8k+o3+l3Pvr4DApA9IVBsrv40XDq3IyOFCmOu2ATW6YoEh
         ckPt8f6VGdaMIeYIlLa+JOVyaZjqP1cs9Jv+RSsXyUy8YkcfPUlPulJrZq0ty1feb7i+
         12Ow==
X-Gm-Message-State: AOJu0Yx3ajWcSLYjGD+jISZg8A+cMG2CjyOwDw08i4zu2Sx/3NL3EwCk
	vRcUD0ZMaYRnvGguEZBlGx98iVhDgZpRQNk+37AMDcLjWS8mXi2HJ7LymrdFgF0GnCiLujbZ/JR
	VAG2kv4DGeCAhxCOwFfJ75aBUCc5yrKKUg5PuvUlaTt9bX+/Op2uRUg==
X-Received: by 2002:a05:6512:1325:b0:533:42ae:c985 with SMTP id 2adb3069b0e04-53678fbf06dmr14588690e87.25.1726758468500;
        Thu, 19 Sep 2024 08:07:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXcMkkrCh8HDpINz1LdCe2tcnd2OREnJby19CPHPVqYGFBcAVw89mmXmpvN21zuCRaOdAyCA==
X-Received: by 2002:a05:6512:1325:b0:533:42ae:c985 with SMTP id 2adb3069b0e04-53678fbf06dmr14588655e87.25.1726758467969;
        Thu, 19 Sep 2024 08:07:47 -0700 (PDT)
Received: from [192.168.88.100] (146-241-67-136.dyn.eolo.it. [146.241.67.136])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e75458230sm24108085e9.38.2024.09.19.08.07.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Sep 2024 08:07:47 -0700 (PDT)
Message-ID: <18971a87-4b52-4ce6-a36c-2d92738d7bfa@redhat.com>
Date: Thu, 19 Sep 2024 17:07:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 net-next 14/15] iavf: Add net_shaper_ops support
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
 Madhu Chittim <madhu.chittim@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Donald Hunter
 <donald.hunter@gmail.com>, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, intel-wired-lan@lists.osuosl.org,
 edumazet@google.com
References: <cover.1725919039.git.pabeni@redhat.com>
 <6c6b03fca7cc58658d47e0f3da68bbbcda4ae1ec.1725919039.git.pabeni@redhat.com>
 <20240910150337.6c397227@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240910150337.6c397227@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/11/24 00:03, Jakub Kicinski wrote:
> On Tue, 10 Sep 2024 00:10:08 +0200 Paolo Abeni wrote:
>> +	if (adapter->netdev->reg_state == NETREG_REGISTERED) {
>> +		mutex_lock(&adapter->netdev->lock);
>> +		devlock = true;
>> +	}
> 
> This leads to a false positive in cocci.
> 
> Any concerns about moving the mutex_init() / _destroy() into
> alloc_netdev_mqs() / free_netdev()?  I guess one could argue
> that narrower scope of the lock being valid may help catching
> errors, but I think we'll instead end up with more checks like
> the above sprinkled around than bugs caught?

I considered moving the locking initialization and shutdown, but I kept 
there for symmetry with the rss_lock. I'll move the init/destroy in the 
next revision.

Thanks,

Paolo


