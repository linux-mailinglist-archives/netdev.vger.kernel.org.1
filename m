Return-Path: <netdev+bounces-112553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCF3939EB9
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 12:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9383C1C2130B
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 10:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460E814D711;
	Tue, 23 Jul 2024 10:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y502uqtX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2793D6A
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 10:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721730333; cv=none; b=E6G3gyJJ9yQQslFzBmEqzJDh95r9Uq2dD2OYqmmOvZydG5ai2DvCc7XlTwPdshh6SCb7/cJmLkeUvNhRe23DCSrp6OUSmx91SNQo9aUWV+gbtc7tqza29OoaeJ+izieOL8mPMBctx0FWbUNGYoaZd5l1Fe+s5OqFHIATQ9uN8Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721730333; c=relaxed/simple;
	bh=6UvfCCWUgBgsH4R8JmHleofltyJxcwTM8DzBBW5y2qg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JiKENC3BY1EPluE81aTQgGjM/urrdH2O36GWEMi6nzFrMRJC0DvoLu+u1DztUeNJcHgwBhWhQjCVJ+ydTAbuj00R0plgRhNm6HDWZ06Q4SKpNbHeqKaDTM4fzg9SE5PZqCtxPGSgCQdimWlWkoMWrl7fFNeQpih6lKXzs0yu5+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y502uqtX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721730330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d3KsQIs20zFdXDjrYm7CV7BF6iri7HZo1QLRXb/g8Js=;
	b=Y502uqtX4Y8mYZaOwVO3JKo05QtVK+dwdPdPHzYnFhdfq3uQ/aA6RhhzAVI3YMLIaB521I
	9IOemhTGhrRIDIsmkxZrNVtCokyOcCgGA1S6z1gzPXvRG9FvGKEIKJv+aQfr3iWzUxBuKJ
	Kg5dpEHI+S9fVa1tDQVS82alIQPCZ24=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-xcHEd3rDNR2QS2J29N8j2g-1; Tue, 23 Jul 2024 06:25:26 -0400
X-MC-Unique: xcHEd3rDNR2QS2J29N8j2g-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42660e2e147so3323035e9.3
        for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 03:25:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721730325; x=1722335125;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d3KsQIs20zFdXDjrYm7CV7BF6iri7HZo1QLRXb/g8Js=;
        b=gXrquPRniYMLtEsGn+LbrVWIwA2o19TADLQ5GQbWvkaLOp7I4fjI2LkuHZLEbDIyOI
         2uJ5rcwazFgY8QX4wnPu+P+F4ZF/HgKvFgFxIlgEGzn0G1pBPtq3ROJ11cENhkVETcmN
         nk8hXytu7dLNXUUkf2KzbG2RrHR5q8/SU8U2CZOZ8/2IvxDLghy3HITNxJCOWPJkr3kL
         bV2gOdQpLh2i6mO1yJBZvv8SFHPNpxgXKRNhHtr/sxvq7MG08J5okOTbiFt6ndA37yik
         Ox6i2SkVlN4/QOx/BjV5lUreFp8LuXZFrFHcir6LtFh9sKULw531ih0WCVPY8G/PJQQV
         6PQw==
X-Forwarded-Encrypted: i=1; AJvYcCVzZFvdLRe+PFyhQ+SG1UBbRF8xyAcEcfySUX08SeJu92xI9Ig+wUnaDPyIqh30b21o3BorX9CzHb6nPXAEMtG75/K3XbOD
X-Gm-Message-State: AOJu0YyPx7GkbPL+x+oVlG3g0A+DIZMC3RUN4A5vng8t6H8vwTTdzMdQ
	Fx9NiEv8/aLcT/nYeAwm9GfIGrB5QD2FHtnl5VgLCNxO0ToZP9jOuX/iW1UOKcX4xhvFS6pmToN
	QtYk8NtNQ8wXPGKZCcSCJObckJDMAHbzm2yuTQDge8aLNpIoot87LuQ==
X-Received: by 2002:a05:600c:511e:b0:424:8b08:26aa with SMTP id 5b1f17b1804b1-427daa6d5dbmr45359025e9.3.1721730325663;
        Tue, 23 Jul 2024 03:25:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHz64JC342sJT6sh8wVLgQr8/CnZMqThr9d1eLd/C/l45sSSsVJYJnYJgWNOGJfQqs33dxFvQ==
X-Received: by 2002:a05:600c:511e:b0:424:8b08:26aa with SMTP id 5b1f17b1804b1-427daa6d5dbmr45358895e9.3.1721730325274;
        Tue, 23 Jul 2024 03:25:25 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:173f:4f10::f71? ([2a0d:3344:173f:4f10::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a3b7aasm197778855e9.6.2024.07.23.03.25.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 03:25:24 -0700 (PDT)
Message-ID: <0b0cb62e-4e10-458e-8d21-8a082f94aa4d@redhat.com>
Date: Tue, 23 Jul 2024 12:25:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: bonding: correctly annotate RCU in
 bond_should_notify_peers()
To: Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org
Cc: Jay Vosburgh <j.vosburgh@gmail.com>, Andy Gospodarek
 <andy@greyhouse.net>, Johannes Berg <johannes.berg@intel.com>,
 Jiri Pirko <jiri@nvidia.com>
References: <20240719094119.35c62455087d.I68eb9c0f02545b364b79a59f2110f2cf5682a8e2@changeid>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20240719094119.35c62455087d.I68eb9c0f02545b364b79a59f2110f2cf5682a8e2@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/19/24 18:41, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> RCU use in bond_should_notify_peers() looks wrong, since it does
> rcu_dereference(), leaves the critical section, and uses the
> pointer after that.
> 
> Luckily, it's called either inside a nested RCU critical section
> or with the RTNL held.
> 
> Annotate it with rcu_dereference_rtnl() instead, and remove the
> inner RCU critical section.
> 
> Fixes: 4cb4f97b7e36 ("bonding: rebuild the lock use for bond_mii_monitor()")
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Any special reasons to target net-next? this looks like a legit net fix 
to me. If you want to target net, no need to re-post, otherwise it will 
have to wait the merge window end.

Thanks,

Paolo


