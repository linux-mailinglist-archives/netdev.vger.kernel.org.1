Return-Path: <netdev+bounces-257160-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEDrA3uThGk43gMAu9opvQ
	(envelope-from <netdev+bounces-257160-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 13:56:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F07EF2DC6
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 13:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B82663040760
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 12:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421B13D3D07;
	Thu,  5 Feb 2026 12:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xn3idYWw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AQXTmh7A"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CF570810
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 12:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770295914; cv=none; b=KOb1OuTL35Nnd+weD0x6V0Ta5bHob9GA4Ilm+dxRIXeAkl3XH21uHRrOR4IoKbdo+CyYr23hshGQ7NDzj99oIDbgfP5GgvymzJRe/DRc35uMu56i39uT0uyGpKrDeWxBuBr2C7VRSVNq1mzweOQkFxVXiycX8iZeD/AqCYx+Rw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770295914; c=relaxed/simple;
	bh=cIIrTOVlC3bXSKi+mZruvQiu25kMcY3J4iVTy2b63e0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oAy3ZCNMaoO2OBqgdh7sic48HGlMWtNVqgJqCSRElGfyhsJTJ8WPCkn8oWSRX7ZjkPstbP+KRjPicB3CUwlZidgpicEqAWrDLmU6JsutJLDvvoil3g8roMcqT5bAX82zaiZHKXQJ27lsEESpuSsptEgGyQStWo5HgWRow+JleXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xn3idYWw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AQXTmh7A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770295912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+KqqY7o17giM2jgPy+d2XiGnDvxNW+2fee3IUyYpT+c=;
	b=Xn3idYWwpxD3yPIpuNkyIcLFMV/qNkH1VFE8jnZvEjDhBEkeBhBJrYsItppAOEqRq4nErg
	lK9JApvMsDeodXiy0MCgzS5RwpMaB9KgB+I1sYSxFVqpKJ5RrXFP8YrzK3zKwjb+fgauxm
	wCuhvbdKOYmkE0r3r4nIzkfZXbM/GVA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-144-E8cX3MGKPBmIZoGpF-8XgA-1; Thu, 05 Feb 2026 07:51:51 -0500
X-MC-Unique: E8cX3MGKPBmIZoGpF-8XgA-1
X-Mimecast-MFC-AGG-ID: E8cX3MGKPBmIZoGpF-8XgA_1770295910
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4804157a3c9so10878185e9.1
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 04:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770295910; x=1770900710; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+KqqY7o17giM2jgPy+d2XiGnDvxNW+2fee3IUyYpT+c=;
        b=AQXTmh7A3wMg4M4qTeXzbGgbHLL3W9iS5cysrP7ufRhL7cSknHPvepB37VBnqdMe+T
         u/wxO833plyPePFB0zmt5LeUH2v6zjL+sAx3uabqx69DVeqFGPGHySZSQMHRCMNL1O5u
         yE4eEE47k+lM3lCXJacxQzl5P1FTRHIEFtIVTquGMePQr7+LjvTkAnISe4OEFsuvEak0
         dn790XcHT3Vln8M4Ub40ZslSczEzNWgW5W8bCaDvyPT3cgw6IBAk2GAPLwarsaowIbi5
         ERGx0AyZqnkp/TQnc/q8z5yfikjflLgAYIMmjyB9wGD9ZTYOXue4bqQzLn7fhnrymzbl
         kqIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770295910; x=1770900710;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+KqqY7o17giM2jgPy+d2XiGnDvxNW+2fee3IUyYpT+c=;
        b=Savo2WrURw8BmMzg3P1wP69HEmXNIcV2Jtw+Rqkyl9NCt/rDvviMLVuv/ZXWM6FIMf
         vVzSEusZnFWvD0nzTjx0TWJZ4bgTMaur8wH3E1wsci7Rp0FetuZ8Q9B3DqZZKZylAPpY
         j1kfuqy87ba0G92NnU257A+WS9biJkJB5ebqAB9LSWflTRptHlN/NJGcfKi2nh1M/9p3
         Ydcmfarr9x7TC8pf+3FixI+A1h0xv/Ct0IBFrj9UodNIGLTv6dYXaaHmsUHMcNyuVcFC
         43/XljoEKUM2Q+Ds38fs3KeRXBuBbPxz7HqSo69tcJqHD5M8I9O0R23IWG7E85KEfowp
         chmw==
X-Forwarded-Encrypted: i=1; AJvYcCVIXbPU8ezWi/2tVAlMO2m4iSc+U7gINNnBDWgi5aG0wVvZi4hZQiVrctr4oSJWHOagVQ3KL4Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5RgFOG/ZbOw9RgK/89TJJWUhhGHQg51YYMXwrx2qlSg+YAeH0
	a26MRqpqB36LHNTUUGSGkCMjzz8DxHBCW+YA6Qq9mToMiqKP1fzM7pbFuHYfLouRkIuOSsuGc5J
	c78sbHfcj76KvGi1oAPsE/OBukcebEjit5uNq9q8vUyyPE98kDYQHamFRTA==
X-Gm-Gg: AZuq6aIcWz0sh3yArjidqjeFdGi2bMYedN6A4SZ9KRS4IYp0E6+hbbXUAxBP/VCF1Fd
	SYkzF/LYP9MsuszMS7NIvVMR15Su7ozAISbkweQAz0EVQgqAl4MBjC6NWJPASjWk31ZlzdOV1gA
	u7XyFJsKXM7mCIdchyHnVcn4GMu6p6mUWqz8t8IygzEJw12B7KZsAvRPUm6tGFP78XlCe1esq4+
	Fv4nmzZBUhP0E4b8tu8FoIva4fvk21F0w3WUbE0Kfx0USJJsfDCSVHKNiHxhbQjCdMZrmgAVJoq
	0m8cNPiDxzQnvz8A/qbudj8G3XCBZSn+N98F84x1wIydhIie4V3AvdYAsz2V29z7ymy+KgtPlEg
	tMxKeY/DTuNQc
X-Received: by 2002:a05:600c:3e0d:b0:46e:59bd:f7d3 with SMTP id 5b1f17b1804b1-4830e96fb0cmr71819405e9.20.1770295910320;
        Thu, 05 Feb 2026 04:51:50 -0800 (PST)
X-Received: by 2002:a05:600c:3e0d:b0:46e:59bd:f7d3 with SMTP id 5b1f17b1804b1-4830e96fb0cmr71818865e9.20.1770295909848;
        Thu, 05 Feb 2026 04:51:49 -0800 (PST)
Received: from [192.168.88.32] ([216.128.11.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4830fe5614asm63353995e9.4.2026.02.05.04.51.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Feb 2026 04:51:49 -0800 (PST)
Message-ID: <1bcfe20e-0103-44a5-82b5-90cba7ba5a60@redhat.com>
Date: Thu, 5 Feb 2026 13:51:46 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,v9,03/15] quic: provide common utilities and data
 structures
To: Simon Horman <horms@kernel.org>, lucien.xin@gmail.com
Cc: steved@redhat.com, marcelo.leitner@gmail.com, aahringo@redhat.com,
 alibuda@linux.alibaba.com, jbaron@akamai.com, hare@suse.de, kuba@kernel.org,
 tom@talpey.com, linux-cifs@vger.kernel.org, daniel@haxx.se,
 quic@lists.linux.dev, jlayton@kernel.org, tfanelli@redhat.com,
 dhowells@redhat.com, linkinjeon@kernel.org, hepengtao@xiaomi.com,
 pc@manguebit.com, kernel-tls-handshake@lists.linux.dev,
 illiliti@protonmail.com, xiyou.wangcong@gmail.com,
 andrew.gospodarek@broadcom.com, mail@johnericson.me, edumazet@google.com,
 matttbe@kernel.org, netdev@vger.kernel.org, smfrench@gmail.com,
 metze@samba.org, mbuhl@openbsd.org, chuck.lever@oracle.com,
 dreibh@simula.no, davem@davemloft.net, sd@queasysnail.net
References: <74174c085fb11b8a63e72a7df730b6f4a7479c5c.1770042461.git.lucien.xin@gmail.com>
 <20260205115449.2195294-1-horms@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260205115449.2195294-1-horms@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257160-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com,linux.alibaba.com,akamai.com,suse.de,kernel.org,talpey.com,vger.kernel.org,haxx.se,lists.linux.dev,xiaomi.com,manguebit.com,protonmail.com,broadcom.com,johnericson.me,google.com,samba.org,openbsd.org,oracle.com,simula.no,davemloft.net,queasysnail.net];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5F07EF2DC6
X-Rspamd-Action: no action

On 2/5/26 12:54 PM, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> 
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> quic: provide common utilities and data structures
> 
> This patch provides foundational data structures and utilities for
> the QUIC stack, including hash tables for socket lookup, connection
> ID management, and helpers for encoding/decoding transport parameters.
> 
>> diff --git a/net/quic/common.c b/net/quic/common.c
>> new file mode 100644
>> index 000000000000..94321f3f213d
>> --- /dev/null
>> +++ b/net/quic/common.c
> 
> [ ... ]
> 
>> +/* Reads a QUIC transport parameter value. */
>> +u8 quic_get_param(u64 *pdest, u8 **pp, u32 *plen)
>> +{
>> +	u64 valuelen;
>> +
>> +	if (!quic_get_var(pp, plen, &valuelen))
>> +		return 0;
>> +
>> +	if (*plen < valuelen)
>> +		return 0;
>> +
>> +	if (!quic_get_var(pp, plen, pdest))
>> +		return 0;
>> +
>> +	return (u8)valuelen;
>> +}
> 
> Does quic_get_param() need to verify that quic_get_var() consumed exactly
> valuelen bytes?
> 
> The function reads valuelen at the first quic_get_var() call, then decodes
> the value with the second quic_get_var(). However, quic_get_var() determines
> how many bytes to consume based on the varint prefix in the data, not from
> valuelen.
> 
> If a malformed packet has valuelen=2 but the varint encoding requires 4 bytes,
> quic_get_var() will consume 4 bytes while the function returns valuelen=2.
> This could desynchronize parsing of subsequent parameters since the caller
> expects the buffer to have advanced by valuelen bytes based on the return
> value.

Hard to tell without any caller for this function. Possibly you could
drop it? IDK if enforcing such check would be correct/safe from an
interoperability PoV.

>> diff --git a/net/quic/common.h b/net/quic/common.h
>> new file mode 100644
>> index 000000000000..bfec0aaf2907
>> --- /dev/null
>> +++ b/net/quic/common.h
> 
> [ ... ]
> 
>> +#define QUIC_CONN_ID_MAX_LEN	20
> 
> [ ... ]
> 
>> +struct quic_conn_id {
>> +	u8 data[QUIC_CONN_ID_MAX_LEN];
>> +	u8 len;
>> +};
>> +
>> +static inline void quic_conn_id_update(struct quic_conn_id *conn_id, u8 *data, u32 len)
>> +{
>> +	memcpy(conn_id->data, data, len);
>> +	conn_id->len = (u8)len;
>> +}
> 
> Should quic_conn_id_update() validate that len does not exceed
> QUIC_CONN_ID_MAX_LEN before the memcpy?
> 
> The destination buffer conn_id->data is a 20-byte array, but the len
> parameter is u32 with no bounds check. If a caller passes len > 20, the
> memcpy would overflow the buffer.

It looks like the check responsibility is on the callers. I guess it
would make things more robust and simpler move the check here.

/P


