Return-Path: <netdev+bounces-283766-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eI8EISZq+GmauQIAu9opvQ
	(envelope-from <netdev+bounces-283766-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 11:43:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3A34BB270
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 11:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12CD0301D064
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 09:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2F337D114;
	Mon,  4 May 2026 09:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DB+pSZmS"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C1237C909
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 09:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777887395; cv=none; b=WcZ/oW0+iUY7TCS+sy03LKNfbcVgtb7/cvJUTxBIosLnWOV/c55xZgtaH0faOoIAEUBIApAIvLN2DNZsjSUyIJzhEzhHKChW2wgY7BU0mjOskJ9vXaZUsA6vKflx4TLgbQOW/s4wmF5Z78Ma/vFU+RTC64Jc43j4pLrK8xb20e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777887395; c=relaxed/simple;
	bh=TaiE6VPRhMdw40zBsC2LL5E3LA6Izko2YcBBVpykQjs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kUXu4NWpFs7OqNqz9OxGmmPr9XySslX2w34aHtMoHn1Zu2sEMcXlyy41NFYGclKFrUI+wDajE2UWpmufmal941flngoLACpuGQTizElRkwAutfhtjVHwCHk7o6OJxxyBdrLqG/vK6fd4igqV19CXoMGfMq4oZLtl0VmkmKVNosU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DB+pSZmS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777887392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nAq+++R2tX36PC5zxXCYWGZvvyeat8gPL+5FluYskoY=;
	b=DB+pSZmS3yz5nncNqv2MGHdS3pG7FBbJ1yKPXHTfvoMNVZ5oqpVL/yvMXAY0L1c0mvGaec
	IM96PDwsxXBp8hFiLjKkAAeFkfYBrdkTc/oPE2ptsjO7bU9T9FaaNug7OnY7HBM4rE2mxZ
	It5IlN4AVLRgQQ4P3z7lZ0trxCepVyA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-272-XpdB2FISPMCx6GsI_yi-_w-1; Mon,
 04 May 2026 05:36:31 -0400
X-MC-Unique: XpdB2FISPMCx6GsI_yi-_w-1
X-Mimecast-MFC-AGG-ID: XpdB2FISPMCx6GsI_yi-_w_1777887388
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CEEF0195609E;
	Mon,  4 May 2026 09:36:27 +0000 (UTC)
Received: from [10.44.48.185] (unknown [10.44.48.185])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1FDE51800357;
	Mon,  4 May 2026 09:36:20 +0000 (UTC)
Message-ID: <290673a1-fb5b-4586-b44a-e109cc1a4629@redhat.com>
Date: Mon, 4 May 2026 11:36:19 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] dpll: move
 fractional-frequency-offset-ppt under pin-parent-device
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 "David S. Miller" <davem@davemloft.net>,
 Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
 Michal Schmidt <mschmidt@redhat.com>, Paolo Abeni <pabeni@redhat.com>,
 Pasi Vaananen <pvaanane@redhat.com>, Petr Oros <poros@redhat.com>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Shuah Khan <skhan@linuxfoundation.org>,
 Simon Horman <horms@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
References: <20260430173611.3312596-1-ivecera@redhat.com>
 <20260430173611.3312596-2-ivecera@redhat.com> <afhdCnT0ns-PgZD8@FV6GYCPJ69>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <afhdCnT0ns-PgZD8@FV6GYCPJ69>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Queue-Id: 2E3A34BB270
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283766-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,intel.com,davemloft.net,gmail.com,google.com,kernel.org,lwn.net,nvidia.com,redhat.com,microchip.com,linuxfoundation.org,linux.dev];
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

Hi Jiri,

On 5/4/26 10:48 AM, Jiri Pirko wrote:
> Thu, Apr 30, 2026 at 07:36:10PM +0200, ivecera@redhat.com wrote:
>> Move the fractional-frequency-offset-ppt attribute from the top-level
>> pin attributes into the pin-parent-device nested attribute set. This
>> makes it consistent with phase-offset which is already per-parent and
>> clarifies that FFO PPT represents the frequency difference between
>> a pin and its parent DPLL device.
>>
>> The top-level fractional-frequency-offset attribute (in PPM) remains
>> unchanged for backward compatibility.
> 
> That is odd. The ppt one was added just for higher precision but was
> semantically the same. Now you change it. Could you still treat both the
> same?
> 
WDYM?

Keep fractional-frequency-offset-ppt at the top-level and add both
fractional-frequency-offset and fractional-frequency-offset-ppt into
pin-parent-device nested attribute set?

Thanks,
Ivan


