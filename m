Return-Path: <netdev+bounces-285179-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOwEIjRJ/GmBNwAAu9opvQ
	(envelope-from <netdev+bounces-285179-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 10:11:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B79D4E48DC
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 10:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F17E030934B9
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 08:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5700F335BBB;
	Thu,  7 May 2026 08:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MCbYiUtw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rqwL8mvt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7F4332EA2
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 08:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778141193; cv=none; b=mE9J6/RXCR7SAf1eE4WfGFM1maPl6NcqrdGiNRYTzlbmk0IH40gE9yX62onEIXtRpIgW4Wb38sZy/nKaO7udaqw6pf65zYR/ULC1BXCW65uOvkcxGnmzM/stI2BNWJGsZ/9KFI6H0hOD5ncy+aDdFwYrbOuiOIxADgPhQzadznQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778141193; c=relaxed/simple;
	bh=Zw9brY5wV+GxdZBOypdnRURlfwgBntEB0ZE6QRw/jAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XSkOZRklulL2XCbVcaWSLiZMwLkfdBBOYKEDwF9qgYxTDWC8zFd1S5YwZDT1xEo0C6xz5/L6lzwZ6CeXiiXWM0CCbBLEMQTuQNMZOwj1mjniXMAVMYLA35N5V40W1BeJnMafCScVhb0kGiEwFaPWC946SVKBFsjkGRnYSscvbP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MCbYiUtw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rqwL8mvt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778141190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l3bMSG0lPJSM2Emf2ZOLqrh1ujP+L6IYLdvVg0ZZk+s=;
	b=MCbYiUtwFRR53oe+BktYZj3WQcxol0VdWMDklxutRfWUsases2Zz56i9pTRGWTNN4UcF7K
	AK5j+/r+/XYKqs4+/iKY22cHtuVTqDeurmK7LiluSlDGVn2yRjY/wIcJU+W10Jogdt74c9
	PATnVf3vRtuaoBYj4qGUN36x1896Axs=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-Lh1nNlaJNVuKt8eYcW5oXQ-1; Thu, 07 May 2026 04:06:28 -0400
X-MC-Unique: Lh1nNlaJNVuKt8eYcW5oXQ-1
X-Mimecast-MFC-AGG-ID: Lh1nNlaJNVuKt8eYcW5oXQ_1778141188
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4497a0e3acaso477292f8f.0
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 01:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778141187; x=1778745987; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l3bMSG0lPJSM2Emf2ZOLqrh1ujP+L6IYLdvVg0ZZk+s=;
        b=rqwL8mvtNVE0H3CIGMoOeZycl9e8OxxlFV6cMmrKG3cqIqxok98QeMRoXRffIBlUHl
         0N75s0A5W5grhBNwupZhh9FZbc8wHHANLD3FAvQX0cYo8Fa9PYudUm4is6fCLTp6s50p
         Wh7uoz4/iDLpnht5978bG4XJbZjGlF/iggZztG50eSnzSm35fWEmgY2BK0GykSCSlJfQ
         UmLqlLsSP4ZMmV6WmXy8rems8sXgGI6V1+wu8diSJH7TIVmJ3F8vC0cr6bC5JiWTf90i
         axxHrNE8QpfS0omFMkKury2pVh4cvHko0S/6HlNEiOO0jehDYDOt46agAlwuWcpJ/a5g
         bhkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778141187; x=1778745987;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l3bMSG0lPJSM2Emf2ZOLqrh1ujP+L6IYLdvVg0ZZk+s=;
        b=R2z9bGoGkWEW8KmcRNC4UF+mvEeMiyRj6oe3bxTnHOTk1/KnpqH6HX1D9B2QudYJ8n
         fMAWEe+XcA1NMzN0yeOyACNXIsLgfma/K0rkPYUOl6GerEVeUDKXPjRvUiLgDamMmybG
         rtszhsk4Ner+W9YNXTAN2hwyZcWi5amQqbd5tpJA/Ps7LS+FDAH7H+HyvElQWulkgUtc
         YJDq0Je0PDUhQWu9YkiVn9ZTQ5Oyr7FiCfwuE4lbRHQlGrluoHdAnmwwBGF8yqKOv/F7
         jhFaQUuET/+QnYdRWkvuan9Rb5Oy28ta8UPkRt/kDJqxcCRsdRAwnLe4FYfkV6kzlFdQ
         nB2A==
X-Gm-Message-State: AOJu0YyB+7Glpjw8gFFH7yzdAMEX8lLJ2MwcEyCwF/nY8gncvVEL9wkN
	hdQ4gj6tzDKoH4uCoxcq73TNpB3WqY/iEFfeDLdoEZ+DH1ReVIWXeIgToBj4JXrbYwwkdAL9u4q
	T8XukU7aeg31c8PCuf1ijXVYGgIk7qQu9OWHPm95qLABBWIYG8Kkc5B0/PA==
X-Gm-Gg: AeBDies+x5AeT+Xw+9eEpmuFNC7joYUe43SJBFmITVb3FzmV8qObN/53S9Yuz4MCQyn
	ZAjHxFcBKacSqmwaG6dblwrLntV4B4UP/eUUcvs/uKTh4FZ0YzGZvpx2dqq8xhb6f4lLXO+Dl7+
	pMVoIu3SMkcswnzL4rlK5pGvGg5K1uct6LL5jhK9AZSuVEYIVPaa4Y5BigQ4jLIqss6sIbAmMNz
	yqsGMwuUlhI0Sl0sFz0ysS9WejQI4vxSCuh/N44v6Iuy8WSpSBLm/42Fhg46aqExyndRGGLxlwV
	ML2k67bGlcrLM9dg6yYuivBMIjiQUVx3rigc8rCc+pkUt9ZC/up6SGY3qi0wwB5XLLjn8Z5Ek4D
	YVvWdauidfxtCN4RFOEH0fSzGDCNZP2oW8gzRzRix0JAKL4yRP5QQsPibxyUgxi07Cw==
X-Received: by 2002:a05:600c:3548:b0:489:1b0c:8b43 with SMTP id 5b1f17b1804b1-48e51e0969fmr109472195e9.1.1778141186242;
        Thu, 07 May 2026 01:06:26 -0700 (PDT)
X-Received: by 2002:a05:600c:3548:b0:489:1b0c:8b43 with SMTP id 5b1f17b1804b1-48e51e0969fmr109471655e9.1.1778141185741;
        Thu, 07 May 2026 01:06:25 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.82])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e5310930esm48943405e9.7.2026.05.07.01.06.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 01:06:25 -0700 (PDT)
Message-ID: <dd67b956-b06b-4ebc-8688-ccb5c17c9d61@redhat.com>
Date: Thu, 7 May 2026 10:06:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 04/10] enic: add admin CQ service with MSI-X
 interrupt and NAPI polling
To: Satish Kharat <satishkh@cisco.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sesidhar Baddela <sebaddel@cisco.com>
References: <20260503-enic-sriov-v2-admin-channel-v2-v6-0-0af4fbc2d86d@cisco.com>
 <20260503-enic-sriov-v2-admin-channel-v2-v6-4-0af4fbc2d86d@cisco.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260503-enic-sriov-v2-admin-channel-v2-v6-4-0af4fbc2d86d@cisco.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 0B79D4E48DC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-285179-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On 5/3/26 1:22 PM, Satish Kharat wrote:
> @@ -197,13 +429,47 @@ static void enic_admin_free_resources(struct enic *enic)
>  
>  static void enic_admin_init_resources(struct enic *enic)
>  {
> +	unsigned int intr_offset = enic->admin_intr_index;
> +
>  	vnic_wq_init(&enic->admin_wq, 0, 0, 0);
>  	vnic_rq_init(&enic->admin_rq, 1, 0, 0);
> -	vnic_cq_init(&enic->admin_cq[0], 0, 1, 0, 0, 1, 0, 1, 0, 0, 0);
> -	vnic_cq_init(&enic->admin_cq[1], 0, 1, 0, 0, 1, 0, 1, 0, 0, 0);
> +	vnic_cq_init(&enic->admin_cq[0],
> +		     0 /* flow_control_enable */,

Replacing magic numbers with macro with significant names would make the
code more readable with no need for additional comments.

/P


