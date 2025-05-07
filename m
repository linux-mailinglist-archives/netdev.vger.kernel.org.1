Return-Path: <netdev+bounces-188674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC436AAE21C
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 16:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16A33B27303
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 14:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F37028B3E3;
	Wed,  7 May 2025 13:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f7dxLqEx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7620289E2F
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 13:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746626214; cv=none; b=KSM5/BDjMBe2SaptACEzhovOMoFwK1diHKZZpl/k9hyeyRMjSldC55ZkTqnSJ866Uccjx7Fxqh3rK7sZrPIUs3tkZTfrLg2PG13AzMuy9C1ZLuu5H6CHo5Olng0rSvHBEZ/lC/vKaQQxkEuoqnqCt//MuZ0Dqi50/yqgX73SZIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746626214; c=relaxed/simple;
	bh=sGa1g1PPLfg0IIMC8cBZToyVlaK+S6WfeD7ZsrQBI2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iVCwwfsSixerbG+Y8mw2EXyfTRZsR+HOOQH6MlwHDAG7Yd/YAaz+Q7XmmscSUMT41FhmnRLifjYd1zBV7niMr2DCVgp7lUCR1hzux8Kap0GZisuyDx8rSyCUyqE8I+fggHp9rWGH4YmRMLQTsgNttZAHk24XQttb2/Da0f0sWGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f7dxLqEx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746626211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eCxlh7OLGZ6tmVtPGqGmXKkGEJLdZqILpcZUyhVzTuI=;
	b=f7dxLqEx7h7TYbAiwREjBwHsvDU0b+SuQT892hEaGIS16trbGhg8Rt+ofjlM/l5pw1n9NU
	bDLf+k3/Yodo1JUdoA7M+SKhqb6qiFNoUGVfUCPo3Yqa4eTS939cCz+ExpUGWZTBPTS7BF
	K/EEzxeSwSS81R0vRB8uYTx6pwV+l90=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-496-slc2Hx5AOXe4P0uxASBc5Q-1; Wed,
 07 May 2025 09:56:47 -0400
X-MC-Unique: slc2Hx5AOXe4P0uxASBc5Q-1
X-Mimecast-MFC-AGG-ID: slc2Hx5AOXe4P0uxASBc5Q_1746626205
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BE39B1800875;
	Wed,  7 May 2025 13:56:44 +0000 (UTC)
Received: from [10.44.33.91] (unknown [10.44.33.91])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 263381800268;
	Wed,  7 May 2025 13:56:38 +0000 (UTC)
Message-ID: <2e3eb9e3-151d-42ef-9043-998e762d3ba6@redhat.com>
Date: Wed, 7 May 2025 15:56:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 8/8] mfd: zl3073x: Register DPLL sub-device
 during init
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Prathosh Satish <Prathosh.Satish@microchip.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Lee Jones <lee@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Michal Schmidt <mschmidt@redhat.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20250507124358.48776-1-ivecera@redhat.com>
 <20250507124358.48776-9-ivecera@redhat.com>
 <CAHp75Ven0i05QhKz2djYx0UU9E9nipb7Qw3mm4e+UN+ZSF_enA@mail.gmail.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <CAHp75Ven0i05QhKz2djYx0UU9E9nipb7Qw3mm4e+UN+ZSF_enA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93



On 07. 05. 25 3:41 odp., Andy Shevchenko wrote:
> On Wed, May 7, 2025 at 3:45 PM Ivan Vecera <ivecera@redhat.com> wrote:
>>
>> Register DPLL sub-devices to expose the functionality provided
>> by ZL3073x chip family. Each sub-device represents one of
>> the available DPLL channels.
> 
> ...
> 
>> +static const struct zl3073x_pdata zl3073x_pdata[ZL3073X_MAX_CHANNELS] = {
>> +       { .channel = 0, },
>> +       { .channel = 1, },
>> +       { .channel = 2, },
>> +       { .channel = 3, },
>> +       { .channel = 4, },
>> +};
> 
>> +static const struct mfd_cell zl3073x_devs[] = {
>> +       ZL3073X_CELL("zl3073x-dpll", 0),
>> +       ZL3073X_CELL("zl3073x-dpll", 1),
>> +       ZL3073X_CELL("zl3073x-dpll", 2),
>> +       ZL3073X_CELL("zl3073x-dpll", 3),
>> +       ZL3073X_CELL("zl3073x-dpll", 4),
>> +};
> 
>> +#define ZL3073X_MAX_CHANNELS   5
> 
> Btw, wouldn't be better to keep the above lists synchronised like
> 
> 1. Make ZL3073X_CELL() to use indexed variant
> 
> [idx] = ...
> 
> 2. Define the channel numbers
> 
> and use them in both data structures.
> 
> ...

WDYM?

> OTOH, I'm not sure why we even need this. If this is going to be
> sequential, can't we make a core to decide which cell will be given
> which id?

Just a note that after introduction of PHC sub-driver the array will 
look like:
static const struct mfd_cell zl3073x_devs[] = {
        ZL3073X_CELL("zl3073x-dpll", 0),  // DPLL sub-dev for chan 0
        ZL3073X_CELL("zl3073x-phc", 0),   // PHC sub-dev for chan 0
        ZL3073X_CELL("zl3073x-dpll", 1),  // ...
        ZL3073X_CELL("zl3073x-phc", 1),
        ZL3073X_CELL("zl3073x-dpll", 2),
        ZL3073X_CELL("zl3073x-phc", 2),
        ZL3073X_CELL("zl3073x-dpll", 3),
        ZL3073X_CELL("zl3073x-phc", 3),
        ZL3073X_CELL("zl3073x-dpll", 4),
        ZL3073X_CELL("zl3073x-phc", 4),   // PHC sub-dev for chan 4
};

Ivan


