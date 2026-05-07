Return-Path: <netdev+bounces-285177-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SA48GFJH/Gk0NwAAu9opvQ
	(envelope-from <netdev+bounces-285177-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 10:03:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BD684E4753
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 10:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 72E8C3006787
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 08:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ED2A32ED4E;
	Thu,  7 May 2026 08:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MYuwx82w";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="kKEHOcPg"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3DE31E841
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 08:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778141008; cv=none; b=Uvxa90sZnmXO+GrYwFe6zkr70cVkNkRN7gUE9dDE9/IqGJBsQr4GIYdDAl5XUGGZ8FiXGESyRW4UC+ymFlMVXYhrf2BAJ4VLevr0aPkQBrIXq8kQnFWexEjc0SuQTwkGygRYvmo7+bt8RGOp0bO4IKSGp8v/z76t+zSDFe8oFVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778141008; c=relaxed/simple;
	bh=JKeHjw5d+vS95B0gqhrrMQ08nSofzwyMUDvN6S3xMYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AiWBZ/OgTidpFAeJx/2OBrH5iYscQxWSyr23zR+IZPQ2omwmd1Ix7ASN/vjlc0ST+fJEqZF7IgGLg3glTL+IqxbtZXjG8VuFJVH3BCuBvUBflTZJ4K2oIZQqrALkaSTmnpv4jhWxwWcDO2PGkTYNFgnAdR0SGsSVx2WUQfk1Rlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MYuwx82w; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=kKEHOcPg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778141006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j0bzjHNwg/4dsgcGNIVawkmXretC17GVDXq9ice+Mi4=;
	b=MYuwx82wWgsiwjIFdFBmcwGAKjz9d4LhA4Jf8fdqB58pR3XTQNw9XjAt2lnMJCxIsUQJJH
	FpbqZHGtq+D/XD+9OjazqxJXDvwkgHgkzg0BMcLzhcW4/PgpjCAvenjA3sThwKE2HITOep
	DBWBnY0tNsWOrxgoc+ALxdhtB0vOZJw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-jlor9-TzNaSTYmyNnsSBCA-1; Thu, 07 May 2026 04:03:24 -0400
X-MC-Unique: jlor9-TzNaSTYmyNnsSBCA-1
X-Mimecast-MFC-AGG-ID: jlor9-TzNaSTYmyNnsSBCA_1778141004
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-44d68ed8f95so369394f8f.1
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 01:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778141004; x=1778745804; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j0bzjHNwg/4dsgcGNIVawkmXretC17GVDXq9ice+Mi4=;
        b=kKEHOcPgO5Yab7HVqOOYaaurDnhzmWaQHxxbdyc9NoKWSVknnOvB+xijdSSAvhUfAi
         DQUDO0GjK/BveffbuysM/z42xALxbgvbA211ku7TQxvaQRLtIKHysws8X8YJ5pQhk5RX
         1Smpo6cA5QHhCFlEvTlIrImTvjNsaRPcDPfDZ02wbZ27JBpxbnHyyFUuLiF0Rtr964YH
         oDy1e6WZgc6mEPbZPJqsN/QYEPNYqzJowyUqD1VP1pKTQ8mETPs1nw+dhSQkpppI/FCv
         Xn58rbL4zA5ZbJypSlO+nY4kv0FAlL4+nJYpKX3GXcy+4rgi0kkKRYIR7qph6NdbXg4q
         JdFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778141004; x=1778745804;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j0bzjHNwg/4dsgcGNIVawkmXretC17GVDXq9ice+Mi4=;
        b=NGayQtPP0dJL2E+//dbojMcSmaugTSE0f64US+zgDV+z0d1tO0nFilkOijKmzVywiK
         XCOgKBM77C1m46ku1+PJK8moRCPcnlRL5VgeYK23K5y+1h3qMvIjbAQTX28IAjLLWcx4
         hSBtwtGfBVkhtQrulxx3YRkhKEa/kcQ9x7/GdtCv6F3xoVcFNvelL1PZnUQNubMEtEJ6
         PG5+azhRc46B3ikzN6kfj6RsWwISwkzQaKqaNcDxx+PmuHNts4cHznFJaHoz2PHU/Mh5
         yor+/RHEOt8KPZKhOMKYPus+MKSzU6TF9Eb+Fgjgd4pv2P5/gc6SGzaP4kVAaeKv+40W
         8x7g==
X-Gm-Message-State: AOJu0YzqoaLx1ZwGnxcoyLAeDx3jU1VpXlMod9mz4CbbngMzlI9w9MHV
	cRfpgwMQ5hpMngCj/3NlslqaMmHy4TTUndQqqV6VuUxHD3XZJsJCOeE0oNvmt+1wQfLp3hwA+T8
	Go4I7Gv5bNuoMr0w/K985q4kSB3J4hWq6PKAxgiXWoMKZVoMG7GC0eDNrfQ==
X-Gm-Gg: AeBDievW1wW4TkWKg70QFnk9q3hzT2IJyMDFMQHoDPacuOy307t66mg99F5ymEnN68A
	/9fmA8jsTuby+qQoV4as5uMARp+HIdfF//4asIHPqOBpv6N9KW63AVuJoeTfg/Sq0VDOBbehasi
	faoSFJ7E/8yXmD4m+r/QEob26pPCsDmqK32acMEk/4QPlEETZnOWcKPaIjM67tHUs/A4QgWrNJl
	IaR1qFmJATij7HypZdtY9hQWC6BXjJhGTHm6JQ1iitwjv5uzQAh1beDOzxzuqnqvaWgCgk41Dtr
	NMo+XQKz2Yvr9/Y5c4Cg7/9K+koIr8G+ORk2Gqm6ikteGgGc7KWTkOvjYrkg2o+TV+qoXCaqpz3
	F3G2P3GvP2Jf88db9bbVnaJA2qxe6wRtNt5d/Hrlty3lrHKs9k/eoWQHZtJ4KEsw57A==
X-Received: by 2002:adf:e905:0:b0:43d:210:2b2d with SMTP id ffacd0b85a97d-452eaa28388mr2016729f8f.31.1778141003657;
        Thu, 07 May 2026 01:03:23 -0700 (PDT)
X-Received: by 2002:adf:e905:0:b0:43d:210:2b2d with SMTP id ffacd0b85a97d-452eaa28388mr2016696f8f.31.1778141003233;
        Thu, 07 May 2026 01:03:23 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.82])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45055960973sm18449092f8f.30.2026.05.07.01.03.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2026 01:03:22 -0700 (PDT)
Message-ID: <3317a78d-de64-4df5-b132-454b4e00a42a@redhat.com>
Date: Thu, 7 May 2026 10:03:21 +0200
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
X-Rspamd-Queue-Id: 0BD684E4753
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-285177-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
> +static void enic_admin_msg_enqueue(struct enic *enic, void *buf,
> +				   unsigned int len)
> +{
> +	struct enic_admin_msg *msg;
> +
> +	msg = kmalloc(struct_size(msg, data, len), GFP_ATOMIC);
> +	if (!msg) {
> +		enic->admin_msg_drop_cnt++;
> +		if (net_ratelimit())
> +			netdev_warn(enic->netdev,
> +				    "admin msg enqueue drop (len=%u drops=%llu)\n",
> +				    len, enic->admin_msg_drop_cnt);

Failed allocation will splat dmesg; no need to added additional error
messages (here and elsewhere in the series).

/P


