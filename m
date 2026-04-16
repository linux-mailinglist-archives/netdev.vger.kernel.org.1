Return-Path: <netdev+bounces-278964-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLloJNqb4GnokAAAu9opvQ
	(envelope-from <netdev+bounces-278964-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 10:20:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C8CC40B745
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 10:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9368C302EDAF
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 08:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B246C38C406;
	Thu, 16 Apr 2026 08:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TLKFykEP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eK++YzT4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7102B390C90
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 08:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776327638; cv=none; b=plCMsqCJWK+wp0PHjBwu4EJOCXxlNOm6dkgHeDtuEKl+Q/20u3sYIR4ieig8xOx0CeJX2beDN7tUg4uwM6jAeZ7O+epu00Co/gyuC/KOucPJDcBYdpX+aW8n40Wn1btwLpVUWmK8BRYVo6M6heNFtsNLrTg2SwYixNNXAvYPtZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776327638; c=relaxed/simple;
	bh=jKVD7gcqSOI/d89shuIq0QcEvDTqxrAavgJ4nLtzFb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RMXJY0WsX/wZ/V1Myn18fGZnjHyclroButxhzki9vu8kuMl3zx4ovaxdXgZliD5oZoWfBoPVrBrYYXP0WB2qpkU1/2nof1LVe9w8TKXtCrsDsPQX5hlj/+ldWmN+rZ59bmFG1luOW9fk3uWFFwFVGLL1kq+KUtEr+ILKSQJt3ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TLKFykEP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eK++YzT4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776327636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0o1lXFcqNizTAH/JWCRzanFNBvkMTtJb4hA4booKnh8=;
	b=TLKFykEP4v5zMO6Sh44JBwObJN/WxV7G6R+j2+0vXRhx/gLPDSUuF9JAI4L6IP5zKXM27T
	jn0rwBsbJn+Eze7UUICsbB5h6qOUwnI0TYc9Gq3HRhfN4ogrUwXGoqxYnMu/vdTd14X8aZ
	ppl9ohYptspRLOihURN7Z4MdoubXwLo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-rmWxfhFZOnWhmOMGnAbTSQ-1; Thu, 16 Apr 2026 04:20:33 -0400
X-MC-Unique: rmWxfhFZOnWhmOMGnAbTSQ-1
X-Mimecast-MFC-AGG-ID: rmWxfhFZOnWhmOMGnAbTSQ_1776327632
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-43cfedb10a8so4821398f8f.1
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 01:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776327632; x=1776932432; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0o1lXFcqNizTAH/JWCRzanFNBvkMTtJb4hA4booKnh8=;
        b=eK++YzT4DupNvloihQ2ZGZ5y41XHgodmDoOW/rn6N2CtOP4+xWrcnCLyuMGObdUSKZ
         q6qlnoDkQk6NeLjaYk/7p5LWA15lOsjEZAYsypIpzR2KO/8tKuxFoe1rsMn9ddNLgWXe
         zMvFrdJ10zuRI0A3EdVusKvHrtYTtgvIjlYb4qx5Ff/dJxt7IZtj1bywKDrGtmJsZJEV
         9Dzpl/vzp836g/5NDFqKL10MpnM6JmPWWgGJvrMeIBHujMa0cQemWMhvkhIKQfXWA8yu
         dEN/U7DbBvvF20XpK33TEIvhNOUXSXvqPVsq0ZApAsBqFxvLsraqTqvdvZfaUqLzUsN/
         y9sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776327632; x=1776932432;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0o1lXFcqNizTAH/JWCRzanFNBvkMTtJb4hA4booKnh8=;
        b=byF566uXF2NOWCskgbNz6XtgkHJFhuc5ngjrl7UTPSnhnGoVgBPX/3p1bdilrp8KS2
         8TtCiRWrCbfXxnC76GjU7dNHOy5IXPRquBnuR7uQPvCp74Jx7C9Q9TA6EGK6Th6ymWGg
         G65y6s7N2liW6nPQs4K4mjC1rSpiMrNWCvhxjf8+iOvwaNuSLkDBTotS4lUMXREPxLJz
         9l7vI53k3b6fSCRYcKs30Gz6NY/f1s5ofw4OBJ4LDsup62gvbbS4C1t7HbGNp6Z3sAoH
         8N1k0Nkq38fknArx4V8JBQsdfURb8iKTNbo1/pVIJzCbHcDqPZKD286Sg0HA/FSsJluJ
         Yqxw==
X-Forwarded-Encrypted: i=1; AFNElJ9gTw30MuFpzpe2HW9TH/oXkEObwzzVL+ye3srK3c7GK6SdkA5leVDz3XTaf1y0Q8J8o7dDSw0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLnMjENv+UvUQjF+hqNSXAh1yo54rGZDD55Vq675mRSJy+U3TZ
	f8EN4jPWVhAPIR4uRkoZ0KzgBRszZRx8syLeprF4NE44EpWClxI94ZwTB1P1OtmvDoASC3kvfji
	FkWo7teIEIjbopOai5cTkIfpk4D60DBmwb1/p48Yr+VeVI7o5SOWgFmtrSA==
X-Gm-Gg: AeBDietzCLJ8qO+a3x9zmGFvlcoEoEoEYfL2SEIb9mKWNqWAm5O0SH3O9ztb5XaykaE
	IVR2wIwuOWObmgVJtLYfwM6YZqY+zMb2VDJOBxIBVm3/if7PaHDDwlEB/zpcQTkfA/94B8/Q2jv
	3ixnHWy3URnhforhOfvk602umrZZNQqOf9lE4V3pggh9/52RPrMcyvbHXqekWo0Fb2e0mQEm7MX
	52rVjjbF303Sldp6ZH8hrClBUmi23NJLwl5EVdAhARDJQrKl2MJHbyG9Q+k4XdVthOJVAUt4t7N
	x7EVFf2GOvkSqVKWfJQE62KWOn5hThPE7VRYmfbxVmwBdwQg2UDl3fXDxyyCRfHYfRgMf4a8GPm
	NduVGMbkm6BIkfwRzJVNamu2oAxJd9/foIy2zBqbVgBDLJLMegNecA/cVMY7Pd59Bm7s=
X-Received: by 2002:a5d:5d84:0:b0:43b:4136:1e76 with SMTP id ffacd0b85a97d-43d642b6a47mr40994731f8f.29.1776327631787;
        Thu, 16 Apr 2026 01:20:31 -0700 (PDT)
X-Received: by 2002:a5d:5d84:0:b0:43b:4136:1e76 with SMTP id ffacd0b85a97d-43d642b6a47mr40994653f8f.29.1776327631147;
        Thu, 16 Apr 2026 01:20:31 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.122])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43ead33d670sm12883172f8f.2.2026.04.16.01.20.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 01:20:30 -0700 (PDT)
Message-ID: <d0e820ce-2a79-4443-ade5-a03d16f712bb@redhat.com>
Date: Thu, 16 Apr 2026 10:20:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] RDS: Fix memory leak in rds_rdma_extra_size()
To: Xiaobo Liu <cppcoffee@gmail.com>, Allison Henderson
 <achender@kernel.org>, "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
 linux-kernel@vger.kernel.org
References: <20260413070005.15272-1-cppcoffee@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260413070005.15272-1-cppcoffee@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-278964-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,davemloft.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.7.a.0.0.1.0.0.e.9.0.c.3.0.0.6.2.asn6.rspamd.com:server fail];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7C8CC40B745
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/13/26 9:00 AM, Xiaobo Liu wrote:
> @@ -595,11 +600,20 @@ int rds_rdma_extra_size(struct rds_rdma_args *args,
>  		 * nr_pages for one entry is limited to (UINT_MAX>>PAGE_SHIFT)+1,
>  		 * so tot_pages cannot overflow without first going negative.
>  		 */
> -		if (tot_pages < 0)
> -			return -EINVAL;
> +		if (tot_pages < 0) {
> +			ret = -EINVAL;
> +			goto out;
> +		}
>  	}
>  
> -	return tot_pages * sizeof(struct scatterlist);
> +	ret = tot_pages * sizeof(struct scatterlist);
> +
> +out:
> +	if (ret < 0) {
> +		kfree(iov->iov);
> +		iov->iov = NULL;

Is this really needed?!? AFAICS rds_rdma_extra_size() is invoked only
via: rds_sendmsg() -> rds_rm_size() -> rds_rdma_extra_size(), and the
rds_sendmsg() error path already frees any non NULL iov.

/P


