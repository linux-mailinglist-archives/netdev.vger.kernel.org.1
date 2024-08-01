Return-Path: <netdev+bounces-115042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDA5944F24
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 17:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C72B282531
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 15:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F0519F48D;
	Thu,  1 Aug 2024 15:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z2JTbwxK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B896C13B5B9
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 15:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722525959; cv=none; b=splelDFqu71aG3DlnwYjn9CO50xZLigZJHBRpKCnjF4eHch7h/XsvoZQxC7BSxLBL/ra+r3tHgGY8nU0QCVyiPRxpOy1XT22bH19dJywSIxpVKa9/xWLrxxHwdz3FThNQMxBXZ4FYSFX1CC4eY4uDc/0Ps6pSlU9MtmdGzsK9D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722525959; c=relaxed/simple;
	bh=Z1jKIKulTE34ug3xet7O3o+GBxfTinZs4vEx/5TNXyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GzfbsvXpkN5GZpXHbJJ+u9zThJQWzpbpmYCX1ErvztDTLoGFeZlOKn9DxAS+QlkvZ7NVWq58yDePqCC/KMkDjXRUpmfd9n7IF/4mCggGzx456zBxgDzEWyQOPuwzv40fudEfd5R+OhvHcyEN7V6/FlINqjTHx8mBr9X8eUk2TtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z2JTbwxK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722525956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jS49Rg4cHTwUEzJESAlJBi1vgRVBovsSmKCGfE1T5Q0=;
	b=Z2JTbwxKbiNkUOivgOgCO1lScvpgWPTukozEfVN61nHlvPJKvBZBjKbZoJy8fLRHlRH0pK
	REPxqWwEU2JgQV365Cua48WRScS+6nhZzqBn929Rnr8svxazhd6eL3zso1bSYJCsJpKX5u
	qo75Opq5LJjwCErCBVz8pnBatZOiRCc=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-h4xUGvQiNs2CktcrxwsG8Q-1; Thu, 01 Aug 2024 11:25:54 -0400
X-MC-Unique: h4xUGvQiNs2CktcrxwsG8Q-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2ef2f58ff63so6299731fa.3
        for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 08:25:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722525953; x=1723130753;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jS49Rg4cHTwUEzJESAlJBi1vgRVBovsSmKCGfE1T5Q0=;
        b=WJW7YSJLMe2P9s/yDDhFdEcySa7E9KyLka2PmLqelSYhaFH3B+O9SoksMolZZlW3P+
         L7lp5HrhevNt7QioaIbknOXUafUBp5wXFQArZfbSj/Wkps6tDVXGbA6aLSIpI2Ru1f11
         35Emej21xftCiq5C0v/EuUVyfOu5mZEdv0LGaXq+IcGSDCqOJ4esAABuA1TgW2CsF94I
         WLiGQwlW3TYlXFT7Wk2mQ2HPBlxJtmMeVbTYhQfdie2q82SoPGvruFxKYDtWAvPtI4Rt
         lIAKLuzTqhuJ4N5L9vsTJVkjabySbfZCf8NiFbiO/1CieoCX68rL4C2LLGMV9iAKuwfZ
         9nQg==
X-Gm-Message-State: AOJu0YzNOsbCxg1CVDJZ7TbQoc6AZkDX5JGABuS06ZG1/x9W8fngNemn
	JcJ75wor6nu9O0I+AmJJul6x0KpWz/7v3/ZAEcK6vvkIAEYrkL+GAjqkW+79PXvpgenpSgs/v64
	QpLHiDK2U1t5wDpRhMpNCp4satAzAAhceP3xaziB9gdEmO3HzAvyJ+A==
X-Received: by 2002:a2e:9bcb:0:b0:2ef:24a9:6aa4 with SMTP id 38308e7fff4ca-2f15a9f617emr2957111fa.0.1722525953238;
        Thu, 01 Aug 2024 08:25:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXH+tBC+zuwxvwljvB+H8a/sWhWyEmH87IQkN4ygHuQexDlDGnuyoltUyJRM3ZwL8JdQunGw==
X-Received: by 2002:a2e:9bcb:0:b0:2ef:24a9:6aa4 with SMTP id 38308e7fff4ca-2f15a9f617emr2956921fa.0.1722525952583;
        Thu, 01 Aug 2024 08:25:52 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1712:4410::f71? ([2a0d:3344:1712:4410::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-428e6e9d1edsm378045e9.40.2024.08.01.08.25.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 08:25:51 -0700 (PDT)
Message-ID: <144865d1-d1ea-48b7-b4d6-18c4d30603a8@redhat.com>
Date: Thu, 1 Aug 2024 17:25:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/12] net-shapers: implement NL set and delete
 operations
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
 Madhu Chittim <madhu.chittim@intel.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>
References: <cover.1722357745.git.pabeni@redhat.com>
 <e79b8d955a854772b11b84997c4627794ad160ee.1722357745.git.pabeni@redhat.com>
 <20240801080012.3bf4a71c@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240801080012.3bf4a71c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/1/24 17:00, Jakub Kicinski wrote:
> On Tue, 30 Jul 2024 22:39:47 +0200 Paolo Abeni wrote:
>> +	while (shaper) {
>> +		parent_handle = shaper->parent;
>> +		pscope = net_shaper_handle_scope(parent_handle);
>> +
>> +		ret = dev->netdev_ops->net_shaper_ops->delete(dev, handle,
>> +							      extack);
>> +		if (ret < 0)
>> +			return ret;
>> +
>> +		xa_lock(xa);
>> +		__xa_erase(xa, handle);
>> +		if (is_detached(handle))
>> +			idr_remove(&dev->net_shaper_data->detached_ids,
>> +				   net_shaper_handle_id(handle));
>> +		xa_unlock(xa);
>> +		kfree(shaper);
>> +		shaper = NULL;
> 
> IIUC child is the input / ingress node? 

Yes.

> Does "deleting a queue" return it to the "implicit mux" at the
> global level? 

Yes

> If we look at the delegation use case - when queue
> is "deleted" from a container-controlled mux it should go back to
> the group created by the orchestrator, not "escpate" to global scope,
> right?

When deleting a queue-level shaper, the orchestrator is "returning" the 
ownership of the queue from the container to the host. If the container 
wants to move the queue around e.g. from:

q1 ----- \
q2 - \SP1/ RR1
q3 - /        \
     q4 - \ RR2 -> RR(root)
     q5 - /    /
     q6 - \ RR3
     q7 - /

to:

q1 ----- \
q2 ----- RR1
q3 ---- /   \
     q4 - \ RR2 -> RR(root)
     q5 - /    /
     q6 - \ RR3
     q7 - /

It can do it with a group() operation:

group(inputs:[q2,q3],output:[RR1])

That will implicitly also delete SP1.

Side note, I just noticed that the current code is bugged WRT this last 
operation and will not delete SP1.

Cheers,

Paolo


