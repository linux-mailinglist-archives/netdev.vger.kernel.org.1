Return-Path: <netdev+bounces-203310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8093AF141E
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 13:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C0203BFFB3
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 11:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C55026E152;
	Wed,  2 Jul 2025 11:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DuEzTwbm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A3226C39F
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 11:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751456301; cv=none; b=ZCmGogwZdQ1t4PwO3t8MR2zwIDtbCoo9W287ygX9rRNgZ+MluIOaocNwI1R+eXApQ2HjbC+8D2bR5DfsPMVi4bzBVGXHpnenN9GN3ULZwFaYLBe9FAfFFiay0iHwVuH4DIHBhdeE08sRB1u3Z98ceSKCDYRdjMA1b2coJpvyXHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751456301; c=relaxed/simple;
	bh=cdS71tAI3Nx8q7bq1BIepQO374y9DFYjtTkJEkJFAg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=anuACEn7dACqSJ5YBVLVXiu2z/rOlre+1ogeBa0ehAG73WCQkAHpN9aclvssa05cvYsHR5yhGbJx5u3CF56YTsVL24KWeasKxoP0qqaoLRM8sCQVDUDGdUi8WGFe/flQwLkjBYCUC7DO/c/09sX04/vNfYHWp3KfesxC1Lmz8mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DuEzTwbm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751456299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jeaR/weAU/4mIF4C+gkIt+G1cKiX/aTOOLald2KG+J8=;
	b=DuEzTwbmWqDdFKBRgHiXsgv1P5grbbf5BgvHB99ptmDY8wIAVu9QCwRkSrixSbvcgYlAip
	nChdXFfSgsHNeH7FgiuFiW4zx3/el5BjYEzZ2z1voxH2wQ0GiKXnXuH8YLo97em0gaJRM8
	LOKy0RaTk1sGQhL5ClnIKg/VaR5iw0Q=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-v3vjMe8DNs-zc9D7_xlaJg-1; Wed,
 02 Jul 2025 07:38:15 -0400
X-MC-Unique: v3vjMe8DNs-zc9D7_xlaJg-1
X-Mimecast-MFC-AGG-ID: v3vjMe8DNs-zc9D7_xlaJg_1751456293
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 84708180028B;
	Wed,  2 Jul 2025 11:38:12 +0000 (UTC)
Received: from [10.45.226.95] (unknown [10.45.226.95])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7A8721956087;
	Wed,  2 Jul 2025 11:38:05 +0000 (UTC)
Message-ID: <351c8eb7-26b2-4435-a6cf-6dac36e55ad9@redhat.com>
Date: Wed, 2 Jul 2025 13:38:03 +0200
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
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <x23jvoo4eycl5whishhsy2qpb5qajsqcx36amltwkqwu5xuj7s@ghg47je4hbjt>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 02. 07. 25 12:25 odp., Jiri Pirko wrote:
> Sun, Jun 29, 2025 at 09:10:39PM +0200, ivecera@redhat.com wrote:
> 
> [...]
> 
>> +	snprintf(buf, sizeof(buf), "%lu.%lu.%lu.%lu",
>> +		 FIELD_GET(GENMASK(31, 24), cfg_ver),
>> +		 FIELD_GET(GENMASK(23, 16), cfg_ver),
>> +		 FIELD_GET(GENMASK(15, 8), cfg_ver),
>> +		 FIELD_GET(GENMASK(7, 0), cfg_ver));
>> +
>> +	return devlink_info_version_running_put(req, "cfg.custom_ver", buf);
> 
> Nit:
> 
> It's redundant to put "ver" string into version name. Also, isn't it
> rather "custom_config" or "custom_cfg"?

As per datasheet, this is configuration custom version.

I.


