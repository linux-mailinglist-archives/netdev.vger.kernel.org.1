Return-Path: <netdev+bounces-139248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E969B12AE
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 00:33:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD8D01C21BEF
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 22:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2D0214401;
	Fri, 25 Oct 2024 22:32:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from trager.us (trager.us [52.5.81.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C4421312D;
	Fri, 25 Oct 2024 22:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.5.81.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729895568; cv=none; b=T9kVWajy+6LZkxrMzOKeW7//ZIF/BwXjIeYlHhwIrxTtrQfF4sOdX+V8DfYsZ5qtaoPPiYeYONen2/vAwFhQUBX/JfD2lpLpYlgN7oX6mRplCgin4zz4xkNrEJZp7AajWveNuRbTsCWyvN9S9+lRgFBFDRn7bVn0ooInn19rKPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729895568; c=relaxed/simple;
	bh=KwnQJqiRsCWMxc9Z25pBZlicEvkalDLV1dR5FfpXCtg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J+aQKylV15OSbO83s3MRF0e3JWXGhODV9fbV4PZdSv5jaWR95sNv7eqp607fswzXYllB+CGnrAl5mZeaWuD1MkstlG93d860dJOTYZQp0yAB4PYO0KScdvLGWYUJu12S39CSHzkjabI+K0x0i6fbsh7wgKwghbhAVUMUzJwnjBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trager.us; spf=pass smtp.mailfrom=trager.us; arc=none smtp.client-ip=52.5.81.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trager.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trager.us
Received: from c-76-104-255-50.hsd1.wa.comcast.net ([76.104.255.50] helo=[192.168.1.226])
	by trager.us with esmtpsa (TLSv1.3:TLS_AES_128_GCM_SHA256:128)
	(Exim 4.92.3)
	(envelope-from <lee@trager.us>)
	id 1t4SrI-0002DC-C4; Fri, 25 Oct 2024 22:32:40 +0000
Message-ID: <13229808-dde5-4805-b908-ce65c8b342b4@trager.us>
Date: Fri, 25 Oct 2024 15:32:32 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] eth: fbnic: Add devlink dev flash support
To: Simon Horman <horms@kernel.org>
Cc: Alexander Duyck <alexanderduyck@fb.com>, Jakub Kicinski
 <kuba@kernel.org>, kernel-team@meta.com,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Sanman Pradhan
 <sanmanpradhan@meta.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Mohsin Bashir <mohsin.bashr@gmail.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241012023646.3124717-1-lee@trager.us>
 <20241022014319.3791797-1-lee@trager.us> <20241024091032.GI402847@kernel.org>
Content-Language: en-US
From: Lee Trager <lee@trager.us>
In-Reply-To: <20241024091032.GI402847@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/24/24 2:10 AM, Simon Horman wrote:
> On Mon, Oct 21, 2024 at 06:42:24PM -0700, Lee Trager wrote:
>> fbnic supports updating firmware using a PLDM image signed and distributed
>> by Meta. PLDM images are written into stored flashed. Flashing does not
>> interrupt operation.
>>
>> On host reboot the newly flashed UEFI driver will be used. To run new
>> control or cmrt firmware the NIC must be power cycled.
>>
>> Signed-off-by: Lee Trager <lee@trager.us>
> ...
>
>> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c b/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
> ...
>
>> @@ -109,8 +110,274 @@ static int fbnic_devlink_info_get(struct devlink *devlink,
>>   	return 0;
>>   }
>>
>> +/**
>> + * fbnic_send_package_data - Send record package data to firmware
>> + * @context: PLDM FW update structure
>> + * @data: pointer to the package data
>> + * @length: length of the package data
>> + *
>> + * Send a copy of the package data associated with the PLDM record matching
>> + * this device to the firmware.
>> + *
>> + * Return: zero on success
>> + *	    negative error code on failure
>> + */
>> +static int fbnic_send_package_data(struct pldmfw *context, const u8 *data,
>> +				   u16 length)
>> +{
>> +	struct device *dev = context->dev;
>> +
>> +	/* Temp placeholder required by devlink */
>> +	dev_info(dev,
>> +		 "Sending %u bytes of PLDM record package data to firmware\n",
>> +		 length);
> Could you clarify what is meant by "Temp placeholder" here and in
> fbnic_send_component_table(). And what plans there might be for
> a non-temporary solution.

Temp placeholder may not have been the best wording here. pldmfw 
requires all ops to be defined as they are always called[1] when 
updating. fbnic has an info message here so its doing something but we 
have no current plans to expand on fbnic_send_package_data nor 
fbnic_finalize_update.

[1] 
https://elixir.bootlin.com/linux/v6.12-rc4/source/lib/pldmfw/pldmfw.c#L723

>
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * fbnic_send_component_table - Send PLDM component table to the firmware
>> + * @context: PLDM FW update structure
>> + * @component: The component to send
>> + * @transfer_flag: Flag indication location in component tables
>> + *
>> + * Read relevant data from component table and forward it to the firmware.
>> + * Check response to verify if the firmware indicates that it wishes to
>> + * proceed with the update.
>> + *
>> + * Return: zero on success
>> + *	    negative error code on failure
>> + */
>> +static int fbnic_send_component_table(struct pldmfw *context,
>> +				      struct pldmfw_component *component,
>> +				      u8 transfer_flag)
>> +{
>> +	struct device *dev = context->dev;
>> +	u16 id = component->identifier;
>> +	u8 test_string[80];
>> +
>> +	switch (id) {
>> +	case QSPI_SECTION_CMRT:
>> +	case QSPI_SECTION_CONTROL_FW:
>> +	case QSPI_SECTION_OPTION_ROM:
>> +		break;
>> +	default:
>> +		dev_err(dev, "Unknown component ID %u\n", id);
>> +		return -EINVAL;
>> +	}
>> +
>> +	dev_dbg(dev, "Sending PLDM component table to firmware\n");
>> +
>> +	/* Temp placeholder */
>> +	strscpy(test_string, component->version_string,
>> +		min_t(u8, component->version_len, 79));
>> +	dev_info(dev, "PLDMFW: Component ID: %u version %s\n",
>> +		 id, test_string);
>> +
>> +	return 0;
>> +}
> ...
>

