Return-Path: <netdev+bounces-272176-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIuLCOtvxWkB+QQAu9opvQ
	(envelope-from <netdev+bounces-272176-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 18:42:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E39133952A
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 18:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2177B30221C0
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 17:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C04F1423168;
	Thu, 26 Mar 2026 17:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fdzistot"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6163D4219E9
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 17:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774546918; cv=none; b=oDq1qHzlPPvFVeaiDrPvuv1ARbennagHuZ3vPcOBJvmLnbNCMPzxg37KBTL6qeUBjMWOgewDQL3LerRIuISenTtMdw5IEFqRrk2f4hIlqwS+DtcHkj1TMHfcwC7/MimeY1UxDM8Ikd7dUWSianCIvb7eFCekMKC4hRTMjnscQUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774546918; c=relaxed/simple;
	bh=BzFTvF5t/B6LMlmOGdwHLYYwYDMPyGL2NIRFdw7HOck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=reZjKq+njD/ONKy2R66YsWAnpcM4Vb0l8Dvc272JdzI9fSxSjDEZ3lqsxd09N+BjTc8Wq6mvtoZtEIPKhNq4L56wVpRvpnZXYfwG3IUgVLhuaNZrgEmzjwSMejq9kLpWRvITcpWpHL6wiz1d8o9pT1EzIMxRIbfuETyFv5uJdAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fdzistot; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774546914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MlL0KdtRd8ZQS35f7AZRbMl7B5ahDl/nxKgfSCklydY=;
	b=fdzistote0ppbCsjrw4O/fNgyDPC7Sogp+CejRfzoiAgMRRBaVfJsCqFN5LuvY9kNoprg+
	sjskK9j7TCMBxriHLc0uK6LM3YdTjj5Cf12THKTDBGjAspwPwkxBoMqVO/kbeyuHV9HbiG
	txW271vI2VKvNeawEEq+jMkJPY0Oo/g=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-vMm5o646MxG0naIzniFitA-1; Thu,
 26 Mar 2026 13:41:50 -0400
X-MC-Unique: vMm5o646MxG0naIzniFitA-1
X-Mimecast-MFC-AGG-ID: vMm5o646MxG0naIzniFitA_1774546908
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 832D2180034E;
	Thu, 26 Mar 2026 17:41:47 +0000 (UTC)
Received: from [10.44.32.95] (unknown [10.44.32.95])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C95CC180036E;
	Thu, 26 Mar 2026 17:41:42 +0000 (UTC)
Message-ID: <7b7705cd-4a2e-41a6-83c4-7c66e011689b@redhat.com>
Date: Thu, 26 Mar 2026 18:41:41 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] dpll: add actual frequency monitoring to
 netlink spec
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
 <20260325193914.124898-2-ivecera@redhat.com>
 <c3a01e7b-0b3a-4a0e-86cb-f9fe79a90a62@linux.dev>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <c3a01e7b-0b3a-4a0e-86cb-f9fe79a90a62@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272176-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,resnulli.us,lwn.net,linuxfoundation.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,microchip.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: 7E39133952A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/26/26 12:06 PM, Vadim Fedorenko wrote:
> On 25/03/2026 19:39, Ivan Vecera wrote:
>> Add DPLL_A_FREQUENCY_MONITOR device attribute to allow control over
>> the frequency monitor feature. The attribute uses the existing
>> dpll_feature_state enum (enable/disable) and is present in both
>> device-get reply and device-set request.
>>
>> Add DPLL_A_PIN_ACTUAL_FREQUENCY pin attribute to expose the measured
>> input frequency in Hz. The attribute is present in the pin-get reply.
> 
> Overall looks ok, but the wording can be improved, I think. What about
> using "MEASURED" or "READ" instead of "ACTUAL"? The spec file has this
> note already, looks like there were some concerns already?
> 
MEASURED looks good... will change this appropriately.

Thanks,
Ivan


