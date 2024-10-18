Return-Path: <netdev+bounces-137154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 844A19A49BF
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 00:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44D5C2841F0
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 22:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8937190058;
	Fri, 18 Oct 2024 22:48:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from trager.us (trager.us [52.5.81.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B7D17C7CA;
	Fri, 18 Oct 2024 22:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.5.81.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729291735; cv=none; b=BlNGsFwapvgEyfPR8b/s4/MqIXLjeG59of8roYZDG7OQNMllRIo266DEzU/eY3zmKn4O3eFYT8GSY/DeVCwF4Yx/Ay4WaGiZrfJwpFxQdyK69GuVRJM/vQ8d3wIMdsr7hr532cjLWjRs9e5fG5+4tTglorH7GqHP/RhXeW6pSXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729291735; c=relaxed/simple;
	bh=0Da96HRJeN9ktw0gyUG3jlCYvRusTcxVT6BOX6TImn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uIhtBqgsW3i7tGIW8iGO/B9r4AY3OGTtgSe6PHZuvG+AD2NQchSq81ZgPBee0BgdnFjDPoPQ6tiXI9MnWzzwjcGPQPjp+otV6Q+/AVcw5aa71XZ/RfIEwyWbJjr6FDIJMq4kYGI35ScmW9TlMq63l8Jh+jV2m0ZKT66BZQpz+nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trager.us; spf=pass smtp.mailfrom=trager.us; arc=none smtp.client-ip=52.5.81.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trager.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trager.us
Received: from c-76-104-255-50.hsd1.wa.comcast.net ([76.104.255.50] helo=[192.168.1.226])
	by trager.us with esmtpsa (TLSv1.3:TLS_AES_128_GCM_SHA256:128)
	(Exim 4.92.3)
	(envelope-from <lee@trager.us>)
	id 1t1vlp-0007L3-P2; Fri, 18 Oct 2024 22:48:33 +0000
Message-ID: <61e80187-49d0-4ad8-a66a-0c3901963201@trager.us>
Date: Fri, 18 Oct 2024 15:48:26 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] eth: fbnic: Add devlink dev flash support
To: Simon Horman <horms@kernel.org>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Alexander Duyck <alexanderduyck@fb.com>, Jakub Kicinski
 <kuba@kernel.org>, kernel-team@meta.com,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Mohsin Bashir <mohsin.bashr@gmail.com>,
 Sanman Pradhan <sanmanpradhan@meta.com>, Al Viro <viro@zeniv.linux.org.uk>,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241012023646.3124717-1-lee@trager.us>
 <20241012023646.3124717-3-lee@trager.us>
 <8502a496-f83d-470c-a84d-081a7c7e2cae@linux.dev>
 <20241015104353.GC569285@kernel.org>
Content-Language: en-US
From: Lee Trager <lee@trager.us>
In-Reply-To: <20241015104353.GC569285@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/15/24 3:43 AM, Simon Horman wrote:

> On Mon, Oct 14, 2024 at 12:18:36PM +0100, Vadim Fedorenko wrote:
>> On 12/10/2024 03:34, Lee Trager wrote:
>>> fbnic supports updating firmware using a PLDM image signed and distributed
>>> by Meta. PLDM images are written into stored flashed. Flashing does not
>>> interrupt operation.
>>>
>>> On host reboot the newly flashed UEFI driver will be used. To run new
>>> control or cmrt firmware the NIC must be power cycled.
>>>
>>> Signed-off-by: Lee Trager <lee@trager.us>
> ...
>
>>> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c b/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
> ...
>
>>> +/**
>>> + * fbnic_send_component_table - Send PLDM component table to the firmware
>>> + * @context: PLDM FW update structure
>>> + * @component: The component to send
>>> + * @transfer_flag: Flag indication location in component tables
>>> + *
>>> + * Read relevant data from component table and forward it to the firmware.
>>> + * Check response to verify if the firmware indicates that it wishes to
>>> + * proceed with the update.
>>> + *
>>> + * Return: zero on success
>>> + *	    negative error code on failure
>>> + */
>>> +static int fbnic_send_component_table(struct pldmfw *context,
>>> +				      struct pldmfw_component *component,
>>> +				      u8 transfer_flag)
>>> +{
>>> +	struct device *dev = context->dev;
>>> +	u16 id = component->identifier;
>>> +	u8 test_string[80];
>>> +
>>> +	switch (id) {
>>> +	case QSPI_SECTION_CMRT:
>>> +	case QSPI_SECTION_CONTROL_FW:
>>> +	case QSPI_SECTION_OPTION_ROM:
>>> +		break;
>>> +	default:
>>> +		dev_err(dev, "Unknown component ID %u\n", id);
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	dev_dbg(dev, "Sending PLDM component table to firmware\n");
>>> +
>>> +	/* Temp placeholder */
>>> +	memcpy(test_string, component->version_string,
>>> +	       min_t(u8, component->version_len, 79));
>>> +	test_string[min_t(u8, component->version_len, 79)] = 0;
>> Looks like this construction can be replaced with strscpy().
>> There were several patchsets in the tree to use strscpy(), let's follow
>> the pattern.
> While looking at these lines, I'm unsure why min_t() is being used
> instead of min() here. As version_len is unsigned and 79 is a positive
> constant, I believe min() should be fine here.

clang complains if I'm not explicit with the type by using min_t()


/home/ltrager/fbnic/src/fbnic_devlink.c:194:3: warning: comparison of 
distinct pointer types ('typeof (component->version_len) *' (aka 
'unsigned char *') and 'typeof (79) *' (aka 'int *')) 
[-Wcompare-distinct-pointer-types]

   194 | min(component->version_len, 79));

       | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

./include/linux/minmax.h:45:19: note: expanded from macro 'min'

    45 | #define min(x, y) __careful_cmp(x, y, <)

       | ^~~~~~~~~~~~~~~~~~~~~~

./include/linux/minmax.h:36:24: note: expanded from macro '__careful_cmp'

    36 | __builtin_choose_expr(__safe_cmp(x, y), \

       | ^~~~~~~~~~~~~~~~

./include/linux/minmax.h:26:4: note: expanded from macro '__safe_cmp'

    26 |                 (__typecheck(x, y) && __no_side_effects(x, y))

       |                  ^~~~~~~~~~~~~~~~~

./include/linux/minmax.h:20:28: note: expanded from macro '__typecheck'

    20 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))

       |                    ~~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~

1 warning generated.

>>> +	dev_info(dev, "PLDMFW: Component ID: %u version %s\n",
>>> +		 id, test_string);
>>> +
>>> +	return 0;
>>> +}

