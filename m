Return-Path: <netdev+bounces-260500-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YN0/I56YnWnwQgQAu9opvQ
	(envelope-from <netdev+bounces-260500-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 13:25:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 208E6186EA1
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 13:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A54193160128
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 12:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72561396D12;
	Tue, 24 Feb 2026 12:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZenJmevi";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="H/cdB3Of"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2C2396D13
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 12:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771935790; cv=none; b=hLF1Bt4PKYSu6q4BFdoclVeknjtLpVD/OvP47d0k9cP0bbX5vOrr+9UJaNvRgCo0/sUAI35mAWkFSTHA/w9o1cQC620GjFcCTsteM/WobtQjAuYyTwLTpNfNFVYyyRndMe568YdTY3YlivslAAC6q5OsCzslmGzrTH3qcIfn5Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771935790; c=relaxed/simple;
	bh=tS5a+Gcznr5+KGRAN6eb80AVTnEhD2VJxbtMcJ/cG1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XkG5nRs91kzNZMu9AhkXork7Lp8FLSzBFN+dkh70lpIbV/6gmzHH1Oj9tpc4S79faVikGb8FUOlrt034/JIvRfkWieoxKECyd8vhTp+n9et4t0Qehhum7lAj674uHu5NUDioFeqkSHGFNqeDUK7GDG1i2iiUyIv5ixwTzWoXYEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZenJmevi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=H/cdB3Of; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771935785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1VU+UoY5nfa4KZiwPxzUFBpVpI9AbrMZQurHI87xYhg=;
	b=ZenJmeviArj8t6/XEN4tORPVCL/ubTno1/k9h8o24lOiNoNuRsqiJ5yizhaDANkWL5llRM
	Y6uOJTRa6CcdFGipWQUfpu2S6CALceFIuFcY+Lc9zwFMMWjC+aoBOergArDiasYJ0+BQUh
	B9QzzddrGHrcFo7NRH+/CbZv9FqVsV0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-DdYUzUZyOduVXPA9HCZ9tA-1; Tue, 24 Feb 2026 07:23:04 -0500
X-MC-Unique: DdYUzUZyOduVXPA9HCZ9tA-1
X-Mimecast-MFC-AGG-ID: DdYUzUZyOduVXPA9HCZ9tA_1771935782
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4836b7fbf4fso49068095e9.2
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 04:23:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771935782; x=1772540582; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1VU+UoY5nfa4KZiwPxzUFBpVpI9AbrMZQurHI87xYhg=;
        b=H/cdB3OfASqVcIe6Lkv6/NoTlW+Q5nY4jzBdqoqMf0vxNW13apJtkp1LuMYdyztmXV
         iDPNiB3IedBZKE7hDEwOaw86yBDccbcFk6b9zsLxZqbMOZEh2kI0sXye+xlPE6xEzuNm
         hwK3+8fZ4GLGxkr5IXF+oIFlk2xWsvWhSR/YIw4cudfJtAwlqV9C+WTu0cGHm06h8hcr
         10V8J3mGRM+t8fvNfp7Zw0RwYxRPTmQzEZzvtg+hsPKE5BYCfeulhao8hvrj8pzuvA87
         pBibs60gWeW5kj61Vx1zkpWqa1aed/sC/XjqMtRR05DV63qrfKYMD3QKUO8EYhtbE7Na
         6UCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771935782; x=1772540582;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1VU+UoY5nfa4KZiwPxzUFBpVpI9AbrMZQurHI87xYhg=;
        b=Yg/SznfNg817pFseGB66A2p9ksVjVhWG6g+gr1Endxda9PrtSD5KpNTVtZ21smAWaE
         lAdnycabP59k9ymo1mOYdOA1SbNfUoXmsLIGD5pr4OoTSGbqUsFc2iLI6UTXp+exDjyI
         LQfz4lOCALr/2ar+q/1ax+g7PhKDhnf5Yff4e1i/Yu2R7sZ1JavhQk2BO/cf5WL2idl2
         xa/dm9eectT7YEqeIlYulQ4rdvJRzGmRAo8/4TvBPLQVsRPh7Xm2s8yAcaaLa/lONCAk
         ouXPJGkNo2+qp1e1mJBvO+8GbiuhAPjCfUwmKJCZ5pELn3bHpsgqWiU3MR0QmaI3XP/V
         pxpw==
X-Forwarded-Encrypted: i=1; AJvYcCX5PQny8eXNopoZVgDFK52iqG+i3Xt3RYVNo7viqcnHzZ+VhKfdkWdLWflpgaEXSClNbNYfTas=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7lennF+rsH/MVJ8MQbN0gf+51CMvpBZ8NeguPUXoUX++Hyvb2
	ccvuHh5QrL772UL1hQECPoTSg0BHNJapetF2BU/Xo22EigoAKWhtM3fdWZrTulRb97H6nLf9GiM
	A82dN0d/IghZ1f3NRlhMrgp6xemoaTtdevQPvefZrtRPK/6CRxuO1lzNX5g==
X-Gm-Gg: AZuq6aL0ezAGnyzp7bDAIKsqOaAX4ZdP09cKiuKQpVYAf/ThVAOmEHVmljbFqPSqDSa
	tQOxCpYG6ufjBD64NK1rrVreD1fRNLa57Qq8YCjpFKlNC8H4uhcrGGDEaUhVvohkLNDVjiCB1Qi
	oRvUySJGoTQOrCXznLkpSHKud0Y9nibJpmkGN/VUG39peywHt6O8LO15rKIRWnxsSf37p83keon
	YLqv9U6Ya73Lf9O6wQdlB1SsbP2Y4enyo6UA4kmybolbczL6a5LFG7vzOkRjqUqKnPt98vHIBVL
	bxozTDtQVmBnWCfPkHwyf6QJUXQxSlI+74+ulZFcIK3cHNhhYTuG1nhgNT4BoXy92XPmSNnVhjN
	e8LbkY3/UHiaw4cxinO1W
X-Received: by 2002:a05:600c:3111:b0:483:612d:7a9a with SMTP id 5b1f17b1804b1-483a95622f5mr207112475e9.0.1771935782152;
        Tue, 24 Feb 2026 04:23:02 -0800 (PST)
X-Received: by 2002:a05:600c:3111:b0:483:612d:7a9a with SMTP id 5b1f17b1804b1-483a95622f5mr207111825e9.0.1771935781643;
        Tue, 24 Feb 2026 04:23:01 -0800 (PST)
Received: from [192.168.88.32] ([216.128.9.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31c56d8sm501015885e9.8.2026.02.24.04.22.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Feb 2026 04:23:00 -0800 (PST)
Message-ID: <2f11ece1-cb85-4491-89d5-c8818666ff41@redhat.com>
Date: Tue, 24 Feb 2026 13:22:58 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] net: mana: Add MAC address to vPort logs and
 clarify error messages
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
 Erni Sri Satya Vennela <ernis@microsoft.com>, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 longli@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, dipayanroy@linux.microsoft.com,
 ssengar@linux.microsoft.com, shradhagupta@linux.microsoft.com,
 shirazsaleem@microsoft.com, gargaditya@linux.microsoft.com,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260223040826.750864-1-ernis@linux.microsoft.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260223040826.750864-1-ernis@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260500-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 208E6186EA1
X-Rspamd-Action: no action

On 2/23/26 5:08 AM, Erni Sri Satya Vennela wrote:
> @@ -861,8 +862,8 @@ int mana_hwc_send_request(struct hw_channel_context *hwc, u32 req_len,
>  	tx_wr = &txq->msg_buf->reqs[msg_id];
>  
>  	if (req_len > tx_wr->buf_len) {
> -		dev_err(hwc->dev, "HWC: req msg size: %d > %d\n", req_len,
> -			tx_wr->buf_len);
> +		dev_err(hwc->dev, "%s:%d: req msg size: %d > %d\n",
> +			__func__, __LINE__, req_len, tx_wr->buf_len);

I fail to see any relevant information added here ...

>  		err = -EINVAL;
>  		goto out;
>  	}
> @@ -878,6 +879,7 @@ int mana_hwc_send_request(struct hw_channel_context *hwc, u32 req_len,
>  	req_msg->req.hwc_msg_id = msg_id;
>  
>  	tx_wr->msg_size = req_len;
> +	command = req_msg->req.msg_type;
>  
>  	if (gc->is_pf) {
>  		dest_vrq = hwc->pf_dest_vrq_id;
> @@ -886,15 +888,16 @@ int mana_hwc_send_request(struct hw_channel_context *hwc, u32 req_len,
>  
>  	err = mana_hwc_post_tx_wqe(txq, tx_wr, dest_vrq, dest_vrcq, false);
>  	if (err) {
> -		dev_err(hwc->dev, "HWC: Failed to post send WQE: %d\n", err);
> +		dev_err(hwc->dev, "%s:%d: Failed to post send WQE: %d\n",
> +			__func__, __LINE__, err);

... and here. The string message should be (and apparently is) enough to
locate the relevant code inside the tree. Please don't included
unneeded/irrelevant changes.

Thanks,

Paolo


