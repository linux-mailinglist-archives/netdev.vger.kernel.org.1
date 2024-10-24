Return-Path: <netdev+bounces-138585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 942DD9AE367
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 13:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EC49283DF0
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 11:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494A21CB509;
	Thu, 24 Oct 2024 11:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FFKSV+Ok"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7779F1C9B87
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 11:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729767934; cv=none; b=ScAMq+BLkvXw30KOjfZEGiPDvcBTo53V1+abRc5WDcUk8KjPPUBoIVVSmq4tFh1phVEzA8Z5MUbBTVOIr1psCHh1scI1kV6swaea81MoTVXew/hIgCljnynBqCefT13dBC4WUEfZcuoRfM2rByAoOfpMrTETh/lb54nI7AjSEAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729767934; c=relaxed/simple;
	bh=jjYyuGSzLYvDtOugSCGUhJhszVe3Gt9vmFcAv/ZyuH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=st9AYVsgm13fmKVzpOO7jCzvz6mlbLtSRJXG3g38HSVwIYZ9iYJ3AVe1/0d/5PAderGx5br9KsUopOapb3diI0U+iWzdeyZmKDXGB/sXwCgxfBXYdxzjZhUa7F1bZX2iz6KxGAhYJ925HcvhXkOmKby2AfDhS4xK3XN2ac/2oeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FFKSV+Ok; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729767929;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g7OjTvApAV59HVeae52wE1LhAHSP+BKWM42WMsGZKZU=;
	b=FFKSV+OkfHvMR0PUaZeVVR14APSEQaZgP1YeDHQ80OQF/N86Iav0gNPkILcZglHsiotifu
	QihKetMxL/Yb0JcrmaKImZJwW7+p9OsUtGslA72kOdmoUXKzsvvpYbhcKcV+UqIHXUXBOh
	5/svZuiDjsDDEeVdlPHoJ4dsjLJoFyY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-xwkCYnjAOmqVl-s6KzWrgA-1; Thu, 24 Oct 2024 07:05:28 -0400
X-MC-Unique: xwkCYnjAOmqVl-s6KzWrgA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37d533a484aso982790f8f.0
        for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 04:05:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729767927; x=1730372727;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g7OjTvApAV59HVeae52wE1LhAHSP+BKWM42WMsGZKZU=;
        b=d3jfopOmMC4KzbtnRvN7N9fRX6adSTlYpVl9HN6A+Ulu/Sw3vmZ5i3DoQNjLBdlBcJ
         dV6xXSE3Op0NcX5hFwpIIqEIsJJVigmb9XYTjHeTx3uGA3uPXeYu62XXVWQ6Hm4ozMfN
         9ept1Oz4Dwzu0BlktpcAvtnWwt68MjNR/BQqfqZ+oHBaQCNGZnrkqkOnV9CyU2+QESfv
         ZQgFcGSAjHeMca15eMFa3JQg2ni0U+80+US9TQTj2K3ifjA4ldAwx0tEozQn1zRNXYXo
         UxsRXo2gv8qJqcr1aiid5HwJKWp5Q9NtJopBo4kn5SOEKTF7wQ4UCxt7NyrZqsoZxbP/
         TaaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHcpDLlMAwAb7m9TvRG8H83lOoWqd+kOmHGI1NGSsJR9E8AXGiQsynddsio5CHcdAHVH1lLFU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHAoWJr/byjDIznnMNwomJEaCGFrDFJVDUBz20reaVNB9ZTq1Q
	lmicE0NgPQ3cgb/FcOOtAsk/LSR0BGnQsFIKdg38O0NY4l7uhTHuGdP2plzFB0Vt5hsYglRoDDU
	1uimvw6zCluYP8JiwEmZU3taNLMTlgblYgEr40bIA2qk3gqRoA4NFMQ==
X-Received: by 2002:a5d:50c6:0:b0:37d:364c:b410 with SMTP id ffacd0b85a97d-3803ac8e202mr923116f8f.33.1729767926998;
        Thu, 24 Oct 2024 04:05:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEy6EiR8rruLA2inrEtuBgfLw2q2XQ4rEH0M7V9j0fn7ncp1qxHUAZ7YmyoWo3EDUeuY9sFJA==
X-Received: by 2002:a5d:50c6:0:b0:37d:364c:b410 with SMTP id ffacd0b85a97d-3803ac8e202mr923099f8f.33.1729767926622;
        Thu, 24 Oct 2024 04:05:26 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:1b73:a910::f71? ([2a0d:3344:1b73:a910::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a585f7sm10890341f8f.51.2024.10.24.04.05.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Oct 2024 04:05:26 -0700 (PDT)
Message-ID: <79005e6e-543e-444b-9acc-f59ac7b04675@redhat.com>
Date: Thu, 24 Oct 2024 13:05:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 net 2/9] net: hns3: add sync command to sync io-pgtable
To: "shenjian (K)" <shenjian15@huawei.com>, Jijie Shao
 <shaojijie@huawei.com>, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, salil.mehta@huawei.com
Cc: liuyonglong@huawei.com, wangpeiyang1@huawei.com, lanhao@huawei.com,
 chenhao418@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241018101059.1718375-1-shaojijie@huawei.com>
 <20241018101059.1718375-3-shaojijie@huawei.com>
 <214d37cc-96c0-4d47-bea0-3985e920d88c@redhat.com>
 <e8f83833-940a-3542-5c68-3dc25a230383@huawei.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <e8f83833-940a-3542-5c68-3dc25a230383@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/24/24 11:38, shenjian (K) wrote:
> 
> 在 2024/10/24 16:36, Paolo Abeni 写道:
>> On 10/18/24 12:10, Jijie Shao wrote:
>>> From: Jian Shen <shenjian15@huawei.com>
>>>
>>> To avoid errors in pgtable prefectch, add a sync command to sync
>>> io-pagtable.
>>>
>>> In the case of large traffic, the TX bounce buffer may be used up.
>> It's unclear to me what do you mean for large traffic. Is that large
>> packets instead?
>>
>> Skimming over the previous patch, it looks like the for the bugger H/W
>> driver will use the bounce buffer for all packets with len < 64K. As
>> this driver does not support big tcp, such condition means all packets.
>>
>> So its not clear to me the 'may' part - it looks like the critical path
>> will always happen on the bugged H/W
> 
> Sorry for the unclear commit log.
> 
> Yes, we don't support big tcp, so <64K is worked for all packets. The 
> large traffic
> 
> here is just want to describe a case that tx bounce buffer is used up, 
> and there is
> 
> no enough space for new tx packets.
> 
> 
>>> At this point, we go to mapping/unmapping on TX path again.
>>> So we added the sync command in driver to avoid hardware issue.
>> I thought the goal of the previous patch was to avoid such sync-up.
>>
>> So I don't understand why it's there.
>>
>> A more verbose explanation will help.
> 
> This is a supplement for the previous patch. We want all the tx packet can
> 
> be handled with tx bounce buffer path. But it depends on the remain space
> 
> of the spare buffer, checked by the function hns3_can_use_tx_bounce(). In
> 
> most cases, maybe 99.99%, it returns true. But once it return false by no
> 
> available space, the packet will be handled with the former path, which
> 
> will map/unmap the skb buffer. Then we will face the smmu prefetch risk 
> again.
> 
> So I add a sync command in this case to avoid smmu prefectch,
> 
> just protects corner scenes.
> 
> 
>>> Signed-off-by: Jian Shen <shenjian15@huawei.com>
>>> Signed-off-by: Peiyang Wang <wangpeiyang1@huawei.com>
>>> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
>> Also we need a fixes tag.
> 
> We considered this issue, and since this is not a software defect, we 
> were not too
> 
> sure which commit should be blamed.
> 
> It makes sense to choose the commit introducing the support for the 
> buggy H/W, we will add
> 
> it.

Please additionally rephrase the commit message including the more
verbose explanation above, thanks!

Paolo


