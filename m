Return-Path: <netdev+bounces-233113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC39C0C94A
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 10:13:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19BBB188B9B5
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 09:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083A82F7AC7;
	Mon, 27 Oct 2025 09:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MjaM2elC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC7F2F744A
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 09:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761555950; cv=none; b=BVbCEq5F9E3ZstuWdKHtuHA+/LH+Yswcm5TJi75hUjq8Lus4PBbtibS7gA1y1EOXN7xv1g3nwPGBI2HJhAp9dkNpqEfolWctfXEfmfVNNR0XLzvGhw1080gtTkAjPqel/1xBUs4SCHELuB16V9O7exwapt3s56jNvzuOqVePyxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761555950; c=relaxed/simple;
	bh=UbLXuklBu/GCZ86aRS8QX2yiNWWw7KFFDSPmBbwX0LE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J63CsgvY/FcGCikMZWQTYxEvl6jYhR4kMFH2hBC3iJjxIUMiTqqHQuZNHsxL5TZxdjhB8wRRO/5blAzFVYdU4paEiAu7Gk8COiR8N8PfvcaoI3n0rgliZW0PbBUvq0/sQvMti5V2nGKlz/IOCe+q3yYEUu60d9Bnuou7hxE9YN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MjaM2elC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761555948;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=71wVM/GDeMgelTkGuxBKBUPrWLhbi0JkJ5nKz3eovPQ=;
	b=MjaM2elCSaAUf8eomAjSNuIrB1SqbihYEb7A17QNocbUz1aYOLCbKq0zFvwCRGRoLysQrx
	klowaVkMNyQZJ71p/6ZePQMrAIXhbcUNwFie3WLK7mle7WLAs85HAHot0W9wiaect+f79h
	lC+W0qDjsF1YuFnpx41EH2PLussQxb0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-17-K7SC8VPjNCygv7t_VcFaMA-1; Mon,
 27 Oct 2025 05:05:42 -0400
X-MC-Unique: K7SC8VPjNCygv7t_VcFaMA-1
X-Mimecast-MFC-AGG-ID: K7SC8VPjNCygv7t_VcFaMA_1761555941
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 63992180066C;
	Mon, 27 Oct 2025 09:05:41 +0000 (UTC)
Received: from [10.45.225.43] (unknown [10.45.225.43])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BC2241800353;
	Mon, 27 Oct 2025 09:05:38 +0000 (UTC)
Message-ID: <d0e581e5-04ee-48e4-b39b-3502783519b6@redhat.com>
Date: Mon, 27 Oct 2025 10:05:37 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] dpll: fix device-id-get and pin-id-get to return
 errors properly
To: Petr Oros <poros@redhat.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>,
 "open list:DPLL SUBSYSTEM" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
Cc: mschmidt@redhat.com
References: <20251024190733.364101-1-poros@redhat.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20251024190733.364101-1-poros@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93



On 10/24/25 9:07 PM, Petr Oros wrote:
> The device-id-get and pin-id-get handlers were ignoring errors from
> the find functions and sending empty replies instead of returning
> error codes to userspace.
> 
> When dpll_device_find_from_nlattr() or dpll_pin_find_from_nlattr()
> returned an error (e.g., -EINVAL for "multiple matches" or -ENODEV
> for "not found"), the handlers checked `if (!IS_ERR(ptr))` and
> skipped adding the device/pin handle to the message, but then still
> sent the empty message as a successful reply.
> 
> This caused userspace tools to receive empty responses with id=0
> instead of proper netlink errors with extack messages like
> "multiple matches".
> 
> The bug is visible via strace, which shows the kernel sending TWO
> netlink messages in response to a single request:
> 
> 1. Empty reply (20 bytes, just header, no attributes):
>     recvfrom(3, [{nlmsg_len=20, nlmsg_type=dpll, nlmsg_flags=0, ...},
>                  {cmd=0x7, version=1}], ...)
> 
> 2. NLMSG_ERROR ACK with extack (because of NLM_F_ACK flag):
>     recvfrom(3, [{nlmsg_len=60, nlmsg_type=NLMSG_ERROR,
>                   nlmsg_flags=NLM_F_CAPPED|NLM_F_ACK_TLVS, ...},
>                  [{error=0, msg={...}},
>                   [{nla_type=NLMSGERR_ATTR_MSG}, "multiple matches"]]], ...)
> 
> The C YNL library parses the first message, sees an empty response,
> and creates a result object with calloc() which zero-initializes all
> fields, resulting in id=0.
> 
> The Python YNL library parses both messages and displays the extack
> from the second NLMSG_ERROR message.
> 
> Fix by checking `if (IS_ERR(ptr))` first and returning the error
> code immediately, so that netlink properly sends only NLMSG_ERROR with
> the extack message to userspace. After this fix, both C and Python
> YNL tools receive only the NLMSG_ERROR and behave consistently.
> 
> This affects:
> - DPLL_CMD_DEVICE_ID_GET: now properly returns error when multiple
>    devices match the criteria (e.g., same module-name + clock-id)
> - DPLL_CMD_PIN_ID_GET: now properly returns error when multiple pins
>    match the criteria (e.g., same module-name)
> 
> Before fix:
>    $ dpll pin id-get module-name ice
>    0  (wrong - should be error, there are 17 pins with module-name "ice")
> 
> After fix:
>    $ dpll pin id-get module-name ice
>    Error: multiple matches
>    (correct - kernel reports the ambiguity via extack)
> 
> Signed-off-by: Petr Oros <poros@redhat.com>

Reviewed-by: Ivan Vecera <ivecera@redhat.com>

> ---
>   drivers/dpll/dpll_netlink.c | 36 ++++++++++++++++++++----------------
>   1 file changed, 20 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
> index 74c1f0ca95f24a..a4153bcb6dcfe1 100644
> --- a/drivers/dpll/dpll_netlink.c
> +++ b/drivers/dpll/dpll_netlink.c
> @@ -1559,16 +1559,18 @@ int dpll_nl_pin_id_get_doit(struct sk_buff *skb, struct genl_info *info)
>   		return -EMSGSIZE;
>   	}
>   	pin = dpll_pin_find_from_nlattr(info);
> -	if (!IS_ERR(pin)) {
> -		if (!dpll_pin_available(pin)) {
> -			nlmsg_free(msg);
> -			return -ENODEV;
> -		}
> -		ret = dpll_msg_add_pin_handle(msg, pin);
> -		if (ret) {
> -			nlmsg_free(msg);
> -			return ret;
> -		}
> +	if (IS_ERR(pin)) {
> +		nlmsg_free(msg);
> +		return PTR_ERR(pin);
> +	}
> +	if (!dpll_pin_available(pin)) {
> +		nlmsg_free(msg);
> +		return -ENODEV;
> +	}
> +	ret = dpll_msg_add_pin_handle(msg, pin);
> +	if (ret) {
> +		nlmsg_free(msg);
> +		return ret;
>   	}
>   	genlmsg_end(msg, hdr);
>   
> @@ -1735,12 +1737,14 @@ int dpll_nl_device_id_get_doit(struct sk_buff *skb, struct genl_info *info)
>   	}
>   
>   	dpll = dpll_device_find_from_nlattr(info);
> -	if (!IS_ERR(dpll)) {
> -		ret = dpll_msg_add_dev_handle(msg, dpll);
> -		if (ret) {
> -			nlmsg_free(msg);
> -			return ret;
> -		}
> +	if (IS_ERR(dpll)) {
> +		nlmsg_free(msg);
> +		return PTR_ERR(dpll);
> +	}
> +	ret = dpll_msg_add_dev_handle(msg, dpll);
> +	if (ret) {
> +		nlmsg_free(msg);
> +		return ret;
>   	}
>   	genlmsg_end(msg, hdr);
>   


