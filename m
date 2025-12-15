Return-Path: <netdev+bounces-244754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E62CBE246
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 14:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0FDF5300CA39
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 13:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544C02BE64C;
	Mon, 15 Dec 2025 13:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zy2F0cCe"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF012D3A6A
	for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 13:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765806719; cv=none; b=uBITTZm9Nq7zSj4vnTc7AxTWQfb1uU84OOJXiSO09nvG0AbsoARxCLvcH2BuVK+7K+M5rLo/UD7ow+a5nTmRJWy0DAakbjzbNzfesW+Q3Nd4cIipHJFO6bTHXAitvPjdLOVtNkttS4tmUEwwekf2kfhDepmudjwmNNcyByvzUsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765806719; c=relaxed/simple;
	bh=/bRyiyFmxa4EQkt3MeAqRBCxND5JIxEQAj6OxA7WLeM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RFo3L4+0zTnkkjxqbkYm19YJnhmWM/K6PrmeEL30EywS/JjqIlsXZ6ag77aORQjbym+uhCJLs8g74vjRWeV0ZDyaUbNXYpNXHkJkCkDvPl/GmAu4JCwcwWIy2c74IqwyWDYpPVj8vmpmOlEb/LlgWey1CABXphQBfWjLRXpfFMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zy2F0cCe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765806716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5xOfSsOHTJVPT/asFcBzsToAdyh5F43Xil3FQ+PqXO4=;
	b=Zy2F0cCeUeuDw8hacFZdd4D6bhJiSeHDbi8MYL+mJZVMt5KprMfjNpCShwAYKmN+FiH+Bt
	iYFslz9fMns8BXuajlOhmuxLDajOUWLi2AFBK+rwKETMsHyMKbvlAwFe5l7IsLvOZrhOUk
	8im1gsKVaIQ7cblO9jmf9THbvL3TWV0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-537-EpkNGB0SNJqMAM5A8UhPHw-1; Mon,
 15 Dec 2025 08:51:51 -0500
X-MC-Unique: EpkNGB0SNJqMAM5A8UhPHw-1
X-Mimecast-MFC-AGG-ID: EpkNGB0SNJqMAM5A8UhPHw_1765806708
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AD1AC1800624;
	Mon, 15 Dec 2025 13:51:46 +0000 (UTC)
Received: from [10.44.34.139] (unknown [10.44.34.139])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 86067180045B;
	Mon, 15 Dec 2025 13:51:38 +0000 (UTC)
Message-ID: <eee9be12-603d-4e8e-92f8-e76728974313@redhat.com>
Date: Mon, 15 Dec 2025 14:51:36 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next 02/13] dpll: Allow registering pin with
 firmware node
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Grzegorz Nitka <grzegorz.nitka@intel.com>, Petr Oros <poros@redhat.com>,
 Michal Schmidt <mschmidt@redhat.com>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, Simon Horman <horms@kernel.org>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Willem de Bruijn <willemb@google.com>, Stefan Wahren <wahrenst@gmx.net>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org
References: <20251211194756.234043-1-ivecera@redhat.com>
 <20251211194756.234043-3-ivecera@redhat.com>
 <ahyyksqki6bas5rqngd735k4fmoeaj7l2a7lazm43ky3lj6ero@567g2ijcpekp>
 <3E2869EC-61B3-40DA-98E2-CD9543424468@redhat.com>
 <tawd6udewifjeoymxkfkapxgcgfviixb4zgcjnplycigk5ffws@rdymwt2hknsl>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <tawd6udewifjeoymxkfkapxgcgfviixb4zgcjnplycigk5ffws@rdymwt2hknsl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

On 12/15/25 2:08 PM, Jiri Pirko wrote:
> Sun, Dec 14, 2025 at 08:35:01PM +0100, ivecera@redhat.com wrote:
>>
>>
>> On December 12, 2025 12:25:12 PM GMT+01:00, Jiri Pirko <jiri@resnulli.us> wrote:
>>> Thu, Dec 11, 2025 at 08:47:45PM +0100, ivecera@redhat.com wrote:
>>>
>>> [..]
>>>
>>>> @@ -559,7 +563,8 @@ EXPORT_SYMBOL(dpll_netdev_pin_clear);
>>>>   */
>>>> struct dpll_pin *
>>>> dpll_pin_get(u64 clock_id, u32 pin_idx, struct module *module,
>>>> -	     const struct dpll_pin_properties *prop)
>>>> +	     const struct dpll_pin_properties *prop,
>>>> +	     struct fwnode_handle *fwnode)
>>>> {
>>>> 	struct dpll_pin *pos, *ret = NULL;
>>>> 	unsigned long i;
>>>> @@ -568,14 +573,15 @@ dpll_pin_get(u64 clock_id, u32 pin_idx, struct module *module,
>>>> 	xa_for_each(&dpll_pin_xa, i, pos) {
>>>> 		if (pos->clock_id == clock_id &&
>>>> 		    pos->pin_idx == pin_idx &&
>>>> -		    pos->module == module) {
>>>> +		    pos->module == module &&
>>>> +		    pos->fwnode == fwnode) {
>>>
>>> Is fwnode part of the key? Doesn't look to me like that. Then you can
>>> have a simple helper to set fwnode on struct dpll_pin *, and leave
>>> dpll_pin_get() out of this, no?
>>
>> IMHO yes, because particular fwnode identifies exact dpll pin, so
>> I think it should be a part of the key.
> 
> The key items serve for userspace identification purposes as well. For
> that, fwnode is non-sense.
> fwnode identifies exact pin, that is nice. But is it the only
> differentiator among other key items? I don't expect so.

 From this point of view, not. I will not touch dpll_pin_get() and rather
use new helper like dpll_pin_fwnode_set(), ok?

Thanks,
Ivan


