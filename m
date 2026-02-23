Return-Path: <netdev+bounces-260054-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKDpHFxinGkoFgQAu9opvQ
	(envelope-from <netdev+bounces-260054-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 15:21:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F5C177EFA
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 15:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15B8C306F7AD
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 14:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86ACB2853E9;
	Mon, 23 Feb 2026 14:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A1zphGZg"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D1A1EE7D5
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 14:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771856277; cv=none; b=YB80/w91entQDC/fXnNvpU+Sqhc1LbYRCSVKX4CMWaMkYMUXLaPDFXzVxqrW7brUnQ1tbl5susZJtSJG5WN7OQcylSk+APR9uM5GERRqe47KKXr8ptS7I0KiaUs/Of6Qr/kJRuR6zNUuHQjR6vC1MLHfcJi0zShyEOKokiIIYQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771856277; c=relaxed/simple;
	bh=JWsui+EWFnQrBmHYf1mqBxCA3Tuwor+dau8D8mdOYVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rKJbFmraMAiX12ThzBjUdOox4f71Ua/zcM8sEl/82ZrCfg4U94606z7Fw21Qsp1VOE2/D5lsMEGgJeSywo77ah+TMXckHLYGfzYWOsC0JF79yjrSTZgP5pDQaqJWucH/hQwWWDQyVcDF6t1ZAqhS7DO4Hah3uj2YLmwIZSWJ9nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A1zphGZg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771856275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9nFQ8yLvXH/beCpBhgLReW9OM7l5WZuY8fuKFKXKbMY=;
	b=A1zphGZgaoQJ17rbBkxrm8X2j/Yibxh/L/iA8CyXt+ctvxRBAwfenyt1RyTZcuQosMrkbq
	xxgqFN8cQxkO666lwWM5415AVO53xOSHdZ/YRgHhfpqnbTlo+ddOBFVMqCXCn0tDgrYi3l
	B51ugaX0wm0pXOf26cw6mxF65WLDwmI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-VBDO78dHNviaeI-HvsoW1Q-1; Mon,
 23 Feb 2026 09:17:51 -0500
X-MC-Unique: VBDO78dHNviaeI-HvsoW1Q-1
X-Mimecast-MFC-AGG-ID: VBDO78dHNviaeI-HvsoW1Q_1771856270
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 32CD1195605A;
	Mon, 23 Feb 2026 14:17:50 +0000 (UTC)
Received: from [10.44.32.92] (unknown [10.44.32.92])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 956213000C26;
	Mon, 23 Feb 2026 14:17:47 +0000 (UTC)
Message-ID: <d0a3a425-689a-4d97-8940-05bf83b7b513@redhat.com>
Date: Mon, 23 Feb 2026 15:17:46 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dpll: zl3073x: Remove redundant cleanup in
 devm_dpll_init()
To: Felix Gu <ustc.gu@gmail.com>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kuba@kernel.org>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260223-dpll-v1-1-d99f18c12bae@gmail.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <20260223-dpll-v1-1-d99f18c12bae@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,microchip.com,linux.dev,intel.com,resnulli.us,kernel.org];
	TAGGED_FROM(0.00)[bounces-260054-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ivecera@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C4F5C177EFA
X-Rspamd-Action: no action

On 2/23/26 2:20 PM, Felix Gu wrote:
> The devm_add_action_or_reset() function already executes the cleanup
> action on failure before returning an error, so the explicit goto error
> and subsequent zl3073x_dev_dpll_fini() call causes double cleanup.
> 
> Fixes: ebb1031c5137 ("dpll: zl3073x: Refactor DPLL initialization")
> Signed-off-by: Felix Gu <ustc.gu@gmail.com>
> ---
>   drivers/dpll/zl3073x/core.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/dpll/zl3073x/core.c b/drivers/dpll/zl3073x/core.c
> index 63bd97181b9e..4ad21caec0e8 100644
> --- a/drivers/dpll/zl3073x/core.c
> +++ b/drivers/dpll/zl3073x/core.c
> @@ -982,10 +982,8 @@ zl3073x_devm_dpll_init(struct zl3073x_dev *zldev, u8 num_dplls)
>   
>   	/* Add devres action to release DPLL related resources */
>   	rc = devm_add_action_or_reset(zldev->dev, zl3073x_dev_dpll_fini, zldev);
> -	if (rc)
> -		goto error;
>   
> -	return 0;
> +	return rc;

Please use:

return devm_add_action_or_reset(...);

Otherwise, LGTM. With this change:

Reviewed-by: Ivan Vecera <ivecera@redhat.com>


