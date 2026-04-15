Return-Path: <netdev+bounces-278722-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEN/JFZW32ndRwAAu9opvQ
	(envelope-from <netdev+bounces-278722-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 11:11:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAD24025ED
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 11:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 395533068EEE
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 09:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8AB2308F0A;
	Wed, 15 Apr 2026 09:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HYMs2//w"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479CB285C8B
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 09:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776243891; cv=none; b=QOUJ6ZK1eNZoQYWX9grJswLb6cMZt+3impIMZ2tYZKs2nlx4tYqhRJ0HzXkD7bI1XJ28fvBm7OysM7pmEk+89SPi6G7U+ZHNA5UXM/ospkgsvTJ5/aEM3G93gumP10HVy3fWz1U69GzBPnZBpEY9JuTmp9B71uPqbj7aLMdkr30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776243891; c=relaxed/simple;
	bh=mB+Z57T+Ixu12b+jnhEZinrL2SMrxuU+ujHtCNxBnek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lv+W5DXLtXHXMEGLuNGPnobSxChv432hDz+iCGKmtoNUj6gnsS4M72Ypu4qKAwA7Ys7VNq9dgtLlGYj1osvmkaLHKxlNURTFlcjBmu0ooz0rd1YDo+eH9Bih4Ld2CuzeIyl5ozidE12e3yHH51U/bhVQwgFir0NCaVOeBVxUiJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HYMs2//w; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776243889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HG5r9CsXm++J30U6+pXxtyB6ti3k7GWkSFNgjgKK4uk=;
	b=HYMs2//w7zE33FoeRn+g3qQe70TiaaCDBlUO+b/lORsbJekwrIxzrC0c6QkQpvlEhTVJSC
	jKPDMW/IucwivqayXA2fEstKzscWJ2kenXre/uyZtdeOoNk9roiDnQqf7hei3PAZClpVf3
	HNYu6viZRZ3xDVBv8jE38dLj6CMKCa8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-501-JV9eXoeyNfyRSc4kgjfAig-1; Wed,
 15 Apr 2026 05:04:45 -0400
X-MC-Unique: JV9eXoeyNfyRSc4kgjfAig-1
X-Mimecast-MFC-AGG-ID: JV9eXoeyNfyRSc4kgjfAig_1776243884
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AC9CC19560AD;
	Wed, 15 Apr 2026 09:04:43 +0000 (UTC)
Received: from [10.44.33.94] (unknown [10.44.33.94])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6CE7B1800446;
	Wed, 15 Apr 2026 09:04:39 +0000 (UTC)
Message-ID: <94692bc9-fe8a-4d78-967f-f2d2db7aa3a6@redhat.com>
Date: Wed, 15 Apr 2026 11:04:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v5] ice: fix missing dpll
 notifications for SW pins
To: Jacob Keller <jacob.e.keller@intel.com>,
 Michal Schmidt <mschmidt@redhat.com>, Petr Oros <poros@redhat.com>,
 netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
References: <20260409102501.1447628-1-poros@redhat.com>
 <68b5cc9d-81d2-4ff5-9d3e-a6d6746dcb3e@redhat.com>
 <b40362c7-a749-4915-93a9-08243ab09cb8@intel.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <b40362c7-a749-4915-93a9-08243ab09cb8@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278722-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2EAD24025ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/14/26 10:46 PM, Jacob Keller wrote:
> On 4/14/2026 12:16 PM, Michal Schmidt wrote:
>> On 4/9/26 12:25, Petr Oros wrote:
>>> ---
>>>    drivers/net/ethernet/intel/ice/ice_dpll.c | 74 +++++++++++++++++++----
>>>    1 file changed, 63 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/
>>> ethernet/intel/ice/ice_dpll.c
>>> index 3f8cd5b8298b57..d817f17dcf1951 100644
>>> --- a/drivers/net/ethernet/intel/ice/ice_dpll.c
>>> +++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
>>> @@ -1154,6 +1154,30 @@ ice_dpll_input_state_get(const struct dpll_pin
>>> *pin, void *pin_priv,
>>>                          extack, ICE_DPLL_PIN_TYPE_INPUT);
>>>    }
>>>    +/**
>>> + * ice_dpll_sw_pin_notify_peer - notify the paired SW pin after a
>>> state change
>>> + * @d: pointer to dplls struct
>>> + * @changed: the SW pin that was explicitly changed (already notified
>>> by dpll core)
>>> + *
>>> + * SMA and U.FL pins share physical signal paths in pairs (SMA1/U.FL1
>>> and
>>> + * SMA2/U.FL2).  When one pin's routing changes via the PCA9575 GPIO
>>> + * expander, the paired pin's state may also change.  Send a change
>>> + * notification for the peer pin so userspace consumers monitoring the
>>> + * peer via dpll netlink learn about the update.
>>> + *
>>> + * Context: Can be called under pf->dplls.lock, dpll_pin_change_ntf()
>>> is safe.
>>> + */
>>> +static void ice_dpll_sw_pin_notify_peer(struct ice_dplls *d,
>>> +                    struct ice_dpll_pin *changed)
>>> +{
>>> +    struct ice_dpll_pin *peer;
>>> +
>>> +    peer = (changed >= d->sma && changed < d->sma +
>>> ICE_DPLL_PIN_SW_NUM) ?
>>> +        &d->ufl[changed->idx] : &d->sma[changed->idx];
>>> +    if (peer->pin)
>>> +        dpll_pin_change_ntf(peer->pin);
>>> +}
>>> +
>>>    /**
>>>     * ice_dpll_sma_direction_set - set direction of SMA pin
>>>     * @p: pointer to a pin
>>> @@ -1233,6 +1257,8 @@ static int ice_dpll_sma_direction_set(struct
>>> ice_dpll_pin *p,
>>>                ret = ice_dpll_pin_state_update(p->pf, target,
>>>                                type, extack);
>>>        }
>>> +    if (!ret)
>>> +        ice_dpll_sw_pin_notify_peer(d, p);
>>>          return ret;
>>>    }
>>
>> ice_dpll_sma_direction_set() runs to process a DPLL_CMD_PIN_SET command
>> from userspace. It runs with dpll_lock held - taken in dpll_pin_pre_doit().
>> ice_dpll_sw_pin_notify_peer() -> dpll_pin_change_ntf() will take
>> dpll_lock again and deadlock.
>>
> 
> Yep. I think you could use __dpll_pin_change_ntf() which is the version
> that assumes the lock is held.. but that function is not exported
> outside of drivers/dpll.
> 
> Either way, this needs to be fixed somehow before I can apply it.
> 
> Thanks,
> Jake

I'm solving the similar situation where some setting on some output pin
can change also sibling pin.

E.g. changing frequency on OUTxP also changes frequency on OUTxN in
certain situations (depending on signal format of the output)...

In such cases would be useful to inform about such change on sibling
pin.

Thanks,
Ivan


