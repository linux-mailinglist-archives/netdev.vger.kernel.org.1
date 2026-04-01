Return-Path: <netdev+bounces-273905-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMFUC0S5zGmcWAYAu9opvQ
	(envelope-from <netdev+bounces-273905-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 08:20:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3D23751E9
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 08:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8BEDD301F49C
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 06:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F246D32F757;
	Wed,  1 Apr 2026 06:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XAPieLNq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC0828CF4A
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 06:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775024448; cv=none; b=ird4sJiv5kcg1dbZJjJdg/LbmC4LCI2FMhyBIXOCyS8UwQHWh5dpyYFKDYooZ0ZWhhnfCrNOuknUFHIsZ0lpPhUKu468VHmMQWob6eJGTNwo2ZTh2gF0R9rfSWsYIoDqshBgmqH98MbgRIIW39e/X8mbnJZOHIxPHMGFmGKfXG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775024448; c=relaxed/simple;
	bh=N0WRdyiipvwhpsT7REngNaXtefNGBNwEs9FzPtYDKd0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dwXIUwyqQZ52S9mneN4oCoQp/ibMc/lHudS33nCTlq/F5Rtv5LdYlNizq5mcz8XaBiaa9w2I6rLYMEK24JA0hKv6AhXM7D7hfuSePIldNbZxoeckmm+abC//t4CvTl99JfBKsnWjC29hX2VeL/cmkY++YwPLWYsfriV677zROyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XAPieLNq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775024445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9E5jPoCdsK8lSlhp/+0AlFkBKV0lIvLqzx3CiNVXlhU=;
	b=XAPieLNq4K1VX0dSO/yNxfFjIM176cbi4DcrEbPkDoTJ0g4ERSlffPe+YAV8hvKaSJOENl
	2mSXIH+fJBNuvxT4jaBdje4+3oL57o0DFgLOEiajQmZhewYB1iCHRcXuHb1zHwG1FnzpPx
	O8nXrA4ehVbn31YcXYY2cd/cQRSWVXE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-Rf-lKEyLM5uNAaykHgnFeA-1; Wed,
 01 Apr 2026 02:20:42 -0400
X-MC-Unique: Rf-lKEyLM5uNAaykHgnFeA-1
X-Mimecast-MFC-AGG-ID: Rf-lKEyLM5uNAaykHgnFeA_1775024440
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 74D8E195607B;
	Wed,  1 Apr 2026 06:20:40 +0000 (UTC)
Received: from [10.44.32.46] (unknown [10.44.32.46])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E476219539A0;
	Wed,  1 Apr 2026 06:20:34 +0000 (UTC)
Message-ID: <a4f21dfe-e3a8-4d98-9b12-b1d7856b4985@redhat.com>
Date: Wed, 1 Apr 2026 08:20:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/3] dpll: add frequency monitoring callback
 ops
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Donald Hunter <donald.hunter@gmail.com>,
 Prathosh Satish <Prathosh.Satish@microchip.com>, Petr Oros
 <poros@redhat.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260330105505.715099-1-ivecera@redhat.com>
 <20260330105505.715099-3-ivecera@redhat.com>
 <20260331201001.03339bab@kernel.org>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20260331201001.03339bab@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273905-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.dev,intel.com,resnulli.us,lwn.net,linuxfoundation.org,davemloft.net,google.com,redhat.com,kernel.org,gmail.com,microchip.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9A3D23751E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/1/26 5:10 AM, Jakub Kicinski wrote:
>> +static int dpll_msg_add_measured_freq(struct sk_buff *msg, struct dpll_pin *pin,
>> +				      struct dpll_pin_ref *ref,
>> +				    struct netlink_ext_ack *extack)
>> +{
>> +	const struct dpll_device_ops *dev_ops = dpll_device_ops(ref->dpll);
>> +	const struct dpll_pin_ops *ops = dpll_pin_ops(ref);
>> +	struct dpll_device *dpll = ref->dpll;
>> +	enum dpll_feature_state state;
>> +	u64 measured_freq;
>> +	int ret;
>> +
>> +	if (!ops->measured_freq_get)
>> +		return 0;
>> +	if (dev_ops->freq_monitor_get) {
> what are you trying to cater to by making freq_monitor_get optional
> here? I thought maybe some devices would have it always enabled, but
> then dpll_msg_add_freq_monitor() should presumably report enabled
> if !freq_monitor_get && measured_freq_get ?
> 
> Maybe there's some precedent in surrounding code outside of the context
> but the intention of the patch reads a bit off.

You're right, making it optional was not well thought out. I'm going to 
change it so that .freq_monitor_get() will be required when
.measured_freq_get() is provided.

Thanks,
Ivan


