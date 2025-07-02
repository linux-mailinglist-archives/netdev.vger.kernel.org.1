Return-Path: <netdev+bounces-203312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B78AF144A
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 13:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 412784A233F
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 11:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F398F267700;
	Wed,  2 Jul 2025 11:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PuOSjVRY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1AD255E4E
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 11:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751456643; cv=none; b=I5fNkkR7RjbrcConGO4E0/pblxCpFbyiV5mtm2PJmFUb+WMCbNY5/iNvIPqsIyhPo2ej/HcHx0VIVMobdbLEPhoAWbqg0CiM2FDdXsbTv5XjTNCSrT2OQu1RF9Az8KiekDhGvCuf0KgkmeP3RK8lAXzRte/6b9ne3bfCuiJ4ezI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751456643; c=relaxed/simple;
	bh=lQ5pOB3PF0Ozj2m53e3VhTH0wmfKLgTVASK5lMyhgEI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IBs2aqrOB1SHcwykwmtV6GFTp41fITkJBh50woiyT7xOIPW8jKbmI+0TE+FHAIu0N4W2zH0i12E+vrqVuMPd9meEd8hOP0WUP99SCtFXH10+STnE/5InQX+t/v6pqVIWFK4rJHMwMpSWMJc/LEQn7v5kKs3yMmn927zbAkWY19Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PuOSjVRY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751456638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dwvTGYy8qX0iUTJggFcHacmEi3yRTYRCFkLK9Jl7i5c=;
	b=PuOSjVRYMvpSEOOesEFYcJVK6x7J2SDujw9W+TaKj25g1u6+/Sw2jtf6pOE0W7lCCYkoxQ
	AvT1BiK140UI3lNruVmHl2KRJv9vBG0fXBYnjG144Z14AQRDZQloxll30wGdN1Go9SCRSX
	nvLOhDmy0GXrLDunT9Ri9ZzGE2m94NE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-328-b07H8pFiO_mvNmbmdKQTUw-1; Wed,
 02 Jul 2025 07:43:51 -0400
X-MC-Unique: b07H8pFiO_mvNmbmdKQTUw-1
X-Mimecast-MFC-AGG-ID: b07H8pFiO_mvNmbmdKQTUw_1751456627
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 852EF18011FE;
	Wed,  2 Jul 2025 11:43:46 +0000 (UTC)
Received: from [10.45.226.95] (unknown [10.45.226.95])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A0E02195608F;
	Wed,  2 Jul 2025 11:43:39 +0000 (UTC)
Message-ID: <e5e3409e-b6a8-4a63-97ac-33e6b1215979@redhat.com>
Date: Wed, 2 Jul 2025 13:43:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 07/14] dpll: zl3073x: Add clock_id field
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
 <20250629191049.64398-8-ivecera@redhat.com>
 <amsh2xeltgadepx22kvcq4cfyhb3psnxafqhr33ra6nznswsaq@hfq6yrb4zvo7>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <amsh2xeltgadepx22kvcq4cfyhb3psnxafqhr33ra6nznswsaq@hfq6yrb4zvo7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17


On 02. 07. 25 12:31 odp., Jiri Pirko wrote:
> Sun, Jun 29, 2025 at 09:10:42PM +0200, ivecera@redhat.com wrote:
>> Add .clock_id to zl3073x_dev structure that will be used by later
>> commits introducing DPLL feature. The clock ID is required for DPLL
>> device registration.
>>
>> To generate this ID, use chip ID read during device initialization.
>> In case where multiple zl3073x based chips are present, the chip ID
>> is shifted and lower bits are filled by an unique value - using
>> the I2C device address for I2C connections and the chip-select value
>> for SPI connections.
> 
> You say that multiple chips may have the same chip ID? How is that
> possible? Isn't it supposed to be unique?
> I understand clock ID to be invariant regardless where you plug your
> device. When you construct it from i2c address, sounds wrong.

The chip id is not like serial number but it is like device id under
PCI. So if you will have multiple chips with this chip id you have to
distinguish somehow between them, this is the reason why I2C address
is added into the final value.

Anyway this device does not have any attribute that corresponds to
clock id (as per our previous discussion) and it will be better to NOT
require clock id from DPLL core side.

Ivan


