Return-Path: <netdev+bounces-204523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B584FAFB014
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 11:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 838751895864
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 09:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338181C4A0A;
	Mon,  7 Jul 2025 09:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UQ5Kg2wJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B2A274B4F
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 09:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751881632; cv=none; b=te6fbHYo4x+Dp9PlR5x9YWEfTYgpEDzw/KojdW8oFAsOcdHE6LwTey4EdnuXq9KJHtKu+0mFfYyyMFZVec7nrpmWTuTn2YSfMO3zya6I36sI1vp9ujoRZiX7BRS2QWB6hscoF8KEnuMvXeRDxbwfx6o82vqw1tJfrF1ls+bwKDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751881632; c=relaxed/simple;
	bh=30/y4SG4wGEpss7IEM4IeQjEBYvCPPiFYxp6rK9lQ3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MtPL4sEKDMelABQUKAuxhW6AB4ZqUvcarNMvAjamq2BV7XY5qHRBlbJjtOecKLU9SVGAd7gW+SlBo0kxs8t61WxJSEpZfXpzkLfO2EuCN99IVtRFvMBqWklUA+RcTRDovUcFvzaTzUkcMOeptOmH1nt5uac3rinJYnH0w1mSFEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UQ5Kg2wJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751881629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4JOhzMO9hb/LtSXeWxWkjP1ZlyyrhtnOsL7SvQkX++k=;
	b=UQ5Kg2wJ8mpaGQd08AlK8SGp+ggwEIhhjyhCrDf6dfdbJoNKtcX7e2OmtwAUOL+Wx/aOs4
	xRZr7aTqPHvzDgvhX47K3kslCfJuD62RuDJSCJocjbfbtmugvroQo9whJWOtpvU4aKTYYv
	NrnS8js2KCusNJgLwQC8zK9OqfhZ3OU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-313-7syuedqyNHCwk-PKjoBmKA-1; Mon,
 07 Jul 2025 05:47:06 -0400
X-MC-Unique: 7syuedqyNHCwk-PKjoBmKA-1
X-Mimecast-MFC-AGG-ID: 7syuedqyNHCwk-PKjoBmKA_1751881624
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 33767195395A;
	Mon,  7 Jul 2025 09:47:03 +0000 (UTC)
Received: from [10.44.32.50] (unknown [10.44.32.50])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5B15B18002B6;
	Mon,  7 Jul 2025 09:46:55 +0000 (UTC)
Message-ID: <29fb9fef-59d7-43f1-9c45-d6f5a4fe9818@redhat.com>
Date: Mon, 7 Jul 2025 11:46:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v13 12/12] dpll: zl3073x: Add support to get/set
 frequency on pins
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, Prathosh Satish <Prathosh.Satish@microchip.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Jason Gunthorpe <jgg@ziepe.ca>,
 Shannon Nelson <shannon.nelson@amd.com>, Dave Jiang <dave.jiang@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Michal Schmidt <mschmidt@redhat.com>, Petr Oros <poros@redhat.com>
References: <20250704182202.1641943-1-ivecera@redhat.com>
 <20250704182202.1641943-13-ivecera@redhat.com>
 <idzmiaubwlnkzds2jbminyr46vuqo37nz5twj7f2yytn4aqoff@r34cm3qpd5mj>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <idzmiaubwlnkzds2jbminyr46vuqo37nz5twj7f2yytn4aqoff@r34cm3qpd5mj>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111



On 07. 07. 25 10:32 dop., Jiri Pirko wrote:
> Fri, Jul 04, 2025 at 08:22:02PM +0200, ivecera@redhat.com wrote:
> 
> [...]
> 
>> +static int
>> +zl3073x_dpll_input_pin_frequency_set(const struct dpll_pin *dpll_pin,
>> +				     void *pin_priv,
>> +				     const struct dpll_device *dpll,
>> +				     void *dpll_priv, u64 frequency,
>> +				     struct netlink_ext_ack *extack)
> 
> Unrelated to this patch, but ny idea why we don't implement
> "FREQUENCY_CAN_CHANGE" capability. I think we are missing it.
> 
Interesting question... from the driver API it is not necessary
as the DPLL core can deduce FREQUENCY_CAN_CHANGE from existence
of pin_frequency_set() callback and also if the pin reports
empty or single item supported-frequencies list.

Ivan


