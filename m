Return-Path: <netdev+bounces-203316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C11EDAF1496
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 13:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0785A1C21D12
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 11:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CEE2266B59;
	Wed,  2 Jul 2025 11:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KzXqL7mS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A471E1DE0
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 11:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751457190; cv=none; b=Y3lU+UXOv/rkPbEjDcvu1zRRrMqCuIMtDGWcpN94MMxjmOeFcqkav0kVZ3GA6ZAHVRQpPEYhlu0lTmOM+M3b0Wd1XVWvLHQyJ7BKTNa1papIsV47iMhbm8jFyv177cXu/c819ZvcOq1RPOaHu6DmEKBFZZkX6ETCgWftuL9Qsco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751457190; c=relaxed/simple;
	bh=DGb0u1+Yey05DF9oiPF0UmaSNG+xcmpqNU2r/Lt1orY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VzUAq0Sb7G7c01SA57OclM5OO8Dz4hFHaXOcO86+fHp6VEQNzZbmgoLxiGuLhrD2ZxruSXzIQVx78Nx0KAwbbJ/Xdj9TGuVlePHyscHBK13HmByZR2NfYp4AP6QHQ4DgpB5lbKpt2cfZqHZDn6gy9SYtdglgXseeGqqK9Fb/7x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KzXqL7mS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751457187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UX6iWtdjjWEufEPPIf5yuj2QCAoygSiCS+chk9oU/Jo=;
	b=KzXqL7mSPKXtGZ+sGk0kUMJY/Swi6JqJXoKncxD+VCqDB3qy8TEMZezQTaCYgGixU7ByDU
	98YdwgPzQ+qTAUvMtOqlZnD8V2tQk6nMPGq2UvDlqC2mDt/SApjV+a+Q6IodL41Za6bwxd
	hHNChG4JIbdc1lx/xq7jOIz4B4Duurg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516-4zvToDAlMpqDkeFJv_e56w-1; Wed,
 02 Jul 2025 07:53:04 -0400
X-MC-Unique: 4zvToDAlMpqDkeFJv_e56w-1
X-Mimecast-MFC-AGG-ID: 4zvToDAlMpqDkeFJv_e56w_1751457182
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E3A23180034E;
	Wed,  2 Jul 2025 11:53:01 +0000 (UTC)
Received: from [10.45.226.95] (unknown [10.45.226.95])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8BC77195608F;
	Wed,  2 Jul 2025 11:52:55 +0000 (UTC)
Message-ID: <6050475d-0387-4eb0-8a72-15e81a14e6cf@redhat.com>
Date: Wed, 2 Jul 2025 13:52:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 04/14] dpll: zl3073x: Add support for devlink
 device info
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Jason Gunthorpe <jgg@ziepe.ca>, Shannon Nelson <shannon.nelson@amd.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Michal Schmidt <mschmidt@redhat.com>, Petr Oros <poros@redhat.com>
References: <20250629191049.64398-1-ivecera@redhat.com>
 <20250629191049.64398-5-ivecera@redhat.com>
 <x23jvoo4eycl5whishhsy2qpb5qajsqcx36amltwkqwu5xuj7s@ghg47je4hbjt>
 <351c8eb7-26b2-4435-a6cf-6dac36e55ad9@redhat.com>
 <vhv3wdiaphtilm7w3v5iro4aojo5go5vlacwfmsycimxnljhsl@itc567adbkey>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <vhv3wdiaphtilm7w3v5iro4aojo5go5vlacwfmsycimxnljhsl@itc567adbkey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17



On 02. 07. 25 1:41 odp., Jiri Pirko wrote:
> Wed, Jul 02, 2025 at 01:38:03PM +0200, ivecera@redhat.com wrote:
>> On 02. 07. 25 12:25 odp., Jiri Pirko wrote:
>>> Sun, Jun 29, 2025 at 09:10:39PM +0200, ivecera@redhat.com wrote:
>>>
>>> [...]
>>>
>>>> +	snprintf(buf, sizeof(buf), "%lu.%lu.%lu.%lu",
>>>> +		 FIELD_GET(GENMASK(31, 24), cfg_ver),
>>>> +		 FIELD_GET(GENMASK(23, 16), cfg_ver),
>>>> +		 FIELD_GET(GENMASK(15, 8), cfg_ver),
>>>> +		 FIELD_GET(GENMASK(7, 0), cfg_ver));
>>>> +
>>>> +	return devlink_info_version_running_put(req, "cfg.custom_ver", buf);
>>>
>>> Nit:
>>>
>>> It's redundant to put "ver" string into version name. Also, isn't it
>>> rather "custom_config" or "custom_cfg"?
>>
>> As per datasheet, this is configuration custom version.
> 
> This is UAPI, we define it and we should make sure it make sense.
> Datasheet is sort of irrelevant.

OK, 'custom_cfg' make sense.

Will update.

I.


