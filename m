Return-Path: <netdev+bounces-272184-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AE0HFf9yxWkU+QQAu9opvQ
	(envelope-from <netdev+bounces-272184-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 18:55:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF68339912
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 18:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53684310DDBF
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 17:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B8039C638;
	Thu, 26 Mar 2026 17:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V3eP2azS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFED397E89
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 17:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774547299; cv=none; b=L7XqzY0EVTASCu/CuOQVwLL/KIuIk+4Bu2XFAA8V2CENL6A7pX2x61i1m4a0c7KsnksRY8dzp7F3I/Vtr8SxaCoz5jAxjiYsRv7tl9rhsqgFl+Zo+O/dNgv6TdL30ytjJhSpAlMYoFkm0C2qXMRuxpLArPOqlpqn2nFlTF6U+/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774547299; c=relaxed/simple;
	bh=dG9nCN/76PXX68Yyw0iuEnwVUAKreuOZlC86CqD/KwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OKO1B4e6cW3zY2Oo7SEXkIPkDrg3V2Km7+PmjnvJSAs4G/324HZQANr5iZM2wSmwOs2hh8cVpxoi0cCVYjWSoCP53DbZITuBQNpa6jVnkaSR36sBhLYcQc4wiSjOyvA2atLOy/8fi6dBaKTBMjZSjy/JY1s74EcQEAHgzznU4X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V3eP2azS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774547296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oz4hGmj4k26d71ek48gh0eEaTkMFDaljaJ8kWGBYZhA=;
	b=V3eP2azSXzHAcWQciMkiMFawxp3dDiGNZAdCMA9HOSJuvFS5S5LA9ORX7AoKq7lXaX6CD8
	J3MYDFGLKd/o9IGcKAH98f7ZL9reoeFuQyU9bGPB7jcy619yA/mR8ReF+W3Qwygcu0EYKX
	xO32Duhb60vEzY8it8qdbxjtONUHijA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-75-7qFBstFSPZK8EkP5wW6X5A-1; Thu,
 26 Mar 2026 13:48:13 -0400
X-MC-Unique: 7qFBstFSPZK8EkP5wW6X5A-1
X-Mimecast-MFC-AGG-ID: 7qFBstFSPZK8EkP5wW6X5A_1774547291
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1BE1618002CB;
	Thu, 26 Mar 2026 17:48:10 +0000 (UTC)
Received: from [10.44.32.95] (unknown [10.44.32.95])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 663E1180036E;
	Thu, 26 Mar 2026 17:48:04 +0000 (UTC)
Message-ID: <e4372a58-13ba-4581-af4e-28d0c880c7bc@redhat.com>
Date: Thu, 26 Mar 2026 18:48:02 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] dpll: add actual frequency monitoring
 callback ops
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 Prathosh Satish <Prathosh.Satish@microchip.com>, Petr Oros
 <poros@redhat.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260325193914.124898-1-ivecera@redhat.com>
 <20260325193914.124898-3-ivecera@redhat.com>
 <d0a6d302-c5af-4ad1-87e2-fa017bdd96a8@linux.dev>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <d0a6d302-c5af-4ad1-87e2-fa017bdd96a8@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272184-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,resnulli.us,lwn.net,linuxfoundation.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,microchip.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ACF68339912
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/26/26 12:21 PM, Vadim Fedorenko wrote:
> On 25/03/2026 19:39, Ivan Vecera wrote:
> 
>> +static int dpll_msg_add_actual_freq(struct sk_buff *msg, struct 
>> dpll_pin *pin,
>> +                    struct dpll_pin_ref *ref,
>> +                    struct netlink_ext_ack *extack)
>> +{
>> +    const struct dpll_device_ops *dev_ops = dpll_device_ops(ref->dpll);
>> +    const struct dpll_pin_ops *ops = dpll_pin_ops(ref);
>> +    struct dpll_device *dpll = ref->dpll;
>> +    enum dpll_feature_state state;
>> +    u64 actual_freq;
>> +    int ret;
>> +
>> +    if (!ops->actual_freq_get)
>> +        return 0;
>> +    if (dev_ops->freq_monitor_get) {
>> +        ret = dev_ops->freq_monitor_get(dpll, dpll_priv(dpll),
>> +                        &state, extack);
>> +        if (ret)
>> +            return ret;
>> +        if (state == DPLL_FEATURE_STATE_DISABLE)
>> +            return 0;
> 
> I think we have to signal back to user that frequency monitoring is
> disabled via extack.

Hi Vadim,

This would break pin-get operation... Do or dump pin-get operation would
fail with this extack message.

Here we can check if the freq-monitoring is enabled and conditionally
call actual_freq_get() or measured_freq_get()

-or-

Call this callback unconditionally and check for return code and if a
driver returns e.g. -ENODATA then skip nla_put_64bit() but return
success.

WDYT?

Thanks,
Ivan


