Return-Path: <netdev+bounces-298929-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id V9DOEt8XLWqgbQQAu9opvQ
	(envelope-from <netdev+bounces-298929-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 10:42:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C838E67E28C
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 10:42:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=ita42ngD;
	dkim=pass header.d=redhat.com header.s=google header.b=FDnv1mUS;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298929-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298929-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9FF0305B00D
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 08:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE473537FB;
	Sat, 13 Jun 2026 08:42:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D7A1917F0
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 08:42:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781340122; cv=none; b=NGsM6XBkHi83DfJmWvuwj59HS4jNSGr02199YBZEvucaVIZBIhcouTpJWO45w1bez+YCfi9OZhjXpNcNyOMeGMvAnbGIINUbfaPzfgUvGxzziTLolgB2Z8xwDWufeirPrdS7yiN2q8AJnHatgc2Ad8jFbakzGt/q5B4FmJpAxcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781340122; c=relaxed/simple;
	bh=IaywYboz+fU/JPKklrGFTfyvFjd1tpc8+yXTZw7fh2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NbN5Rn3J+gXTDFAAIzT/sMFAS3P+yveUJ7AX7czgLBFXCV5/Z4/wzlvOyCzip8/IR79WeSSwY85n5N2Sgc9n9BARShaqD1odoNVPsBUSdxkg0a8dQp7M5Lmm3O7p/vToxPttG6t1Yswfvc3Q813b6FGva8hv+VP6O6eEDAIva4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ita42ngD; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FDnv1mUS; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781340119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8uJWP9tqMCHTtoSkkYE0M+RWI1R32XPw5b0Ycy+j2b8=;
	b=ita42ngDDabhD3UqUk8rgrIEbkUT84cyLrt+0IDkRwPxwlm5n6j4ugt8PaClJAHilmbxNE
	+xtnBuO98x5xRkHbjaS8D1s5+Ke8DriPTZWT6kb+qztsU8aEhMjC3qGwX7SHfVxc7wHsJk
	aLCgDXtBp0NDxeKpQQqZvmNraRnl4jM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-uLzd0uDaOv2bEWYqipUoXg-1; Sat, 13 Jun 2026 04:41:57 -0400
X-MC-Unique: uLzd0uDaOv2bEWYqipUoXg-1
X-Mimecast-MFC-AGG-ID: uLzd0uDaOv2bEWYqipUoXg_1781340117
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8ccf62978bfso41128626d6.1
        for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 01:41:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781340117; x=1781944917; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8uJWP9tqMCHTtoSkkYE0M+RWI1R32XPw5b0Ycy+j2b8=;
        b=FDnv1mUSUxntJSIH0LFoCseFFFewp2hlRQj+pUshQhnxBmh+SzZwPW3Sx94u6jjaKd
         b8ZbOSh3zuxcDjuUNb08iW1nHLAzL6xbUuJiX2gOh6geLiC8Hhy68AkGw+29WwU1xKsj
         dt30oSVmVO/c6FwAL1Ca30MjYYb1rSbrUoHr7+kJUvWoiJsHxSKzhYiKAvesIwu6bukg
         NPWqmbkY+Kx0Q7Ke7BDJEfAcoPaRsMGGnIvx0a7E1d+Hrgskj060YjNN8kYwTdv6ex3s
         IYVImq1+WQxrdu1bDZRtD9eAhIi/thAJQB6bAfSL9PnYnlXqobKudMlYZiDD0dpu0l2Q
         xW4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781340117; x=1781944917;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8uJWP9tqMCHTtoSkkYE0M+RWI1R32XPw5b0Ycy+j2b8=;
        b=LYqmGf4CL9k0xi/Bd8ynw/iKztwilbSMJymKxxIbzF2t/R6NhG9S3imLrt+QhOK/3G
         fVrwyeG1yBOq+8dp996zgh+Fox6hBSvIwJrEWr9Vv8y2Tl1n+fZFe5oSXANkanoHCbl5
         Bbj6AS/iddRGxxRDe8zcvK4jRZIYC2F70/xzAYzAJJlvNMSsg0Wh4oPWqGna6vIVB32r
         hyR5shHZmrlofJ2PUrEUL6IuRNe2RXrmYZwmWJxeRAyOObOTsSrI6P1A5H75JgT0rY1x
         dyCfRH0+D+EJbFrYMah06FBromdSjXgAvmXwK13CC2kgRzpXszFTtyVbWMZLPsGyc7GJ
         SJPw==
X-Forwarded-Encrypted: i=1; AFNElJ9mWUMhvB1VcxeWqPybpzEit2QJ9PPTpcg7AF7aCA24LS+N0V+aT2gUQOXaUnYGv9v4GH8HRSc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+lr2g8R4gN7B6V+mJq5+3Tl0Kd56SlFW1Y9yLwlIzPa39ZS78
	SVFeuOxjCbzip4RpXpJNlNbPnn+jot6q2tIOCoGVvqmcxXeoBrmM3tZ4KzR3CtQ5T7P+AN8D9nN
	wvRGut0MlrIk1MzZW4oWYnYd0yOb8d+Hri2O0W73JytC7qHfTWQukhVwBFg==
X-Gm-Gg: Acq92OG+jU0BxQ/nsf4HBJnCo/YlbgaIVU5reCyRJ4g4DRkfWlYuiLkIfOx6iCIjITw
	nmsnpbc2Xef1ZnGH5b+WpSUSPJXAHHGhA4EPdHiUYNvwOjFcRLfFG9cnl8ZlaOsLSO5Uc8gG+kf
	Rtu7Gu/iVq3Dmr4tFdz8nLa4aedf4iaf+WcVgDBa6PUL7SkCJ3ROJp6szbf1n7PcLnTPEk0aXVS
	pnBRqjZdPtdSk5eQrqt3r5eI7M+N5VgB5x6kInfokPSZwXTeejvFUU6ABN3W8HPVs0ENkQZHUhK
	e/TLEQajk/TsMTtbx5IEkbfCaOUGmcGcXFaaA8HZzdAtLG2Rp6ON7539F2a2WTfVqfVxaChU4h5
	gSvrhEYK7HL775jowZOW0BjHCUhR/8+GtL15+8JhZn45G6DbhQy63Kw4=
X-Received: by 2002:a05:622a:1102:b0:516:e086:89a with SMTP id d75a77b69052e-517fe4ddbddmr84850751cf.26.1781340117258;
        Sat, 13 Jun 2026 01:41:57 -0700 (PDT)
X-Received: by 2002:a05:622a:1102:b0:516:e086:89a with SMTP id d75a77b69052e-517fe4ddbddmr84850531cf.26.1781340116835;
        Sat, 13 Jun 2026 01:41:56 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.72])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-517fb841970sm44912311cf.30.2026.06.13.01.41.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jun 2026 01:41:56 -0700 (PDT)
Message-ID: <9b78ed2c-f664-4c56-9626-63ee73c6177e@redhat.com>
Date: Sat, 13 Jun 2026 10:41:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: dsa: sja1105: fix refcount leak in
 sja1105_setup_tc_taprio()
To: Wentao Liang <vulab@iscas.ac.cn>, olteanv@gmail.com, andrew@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 stable@vger.kernel.org
References: <20260609074002.204113-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260609074002.204113-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298929-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vulab@iscas.ac.cn,m:olteanv@gmail.com,m:andrew@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[iscas.ac.cn,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,iscas.ac.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C838E67E28C

On 6/9/26 9:40 AM, Wentao Liang wrote:
> In sja1105_setup_tc_taprio(), taprio_offload_get() acquires a
> reference on the new offload and stores it in
> tas_data->offload[port]. If sja1105_init_scheduling() or
> sja1105_static_config_reload() later fails, the function returns
> without releasing the reference via taprio_offload_free(). The
> stored pointer is thus leaked, as the driver will not clean it up
> unless a subsequent TAPRIO_CMD_DESTROY is received, which may
> never happen.
> 
> Fix the leak by calling taprio_offload_free() and resetting
> tas_data->offload[port] to NULL on both error paths.
> 
> Cc: stable@vger.kernel.org
> Fixes: 317ab5b86c8e ("net: dsa: sja1105: Configure the Time-Aware Scheduler via tc-taprio offload")
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/dsa/sja1105/sja1105_tas.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/dsa/sja1105/sja1105_tas.c b/drivers/net/dsa/sja1105/sja1105_tas.c
> index e47967b12d5d..96cb5aa04910 100644
> --- a/drivers/net/dsa/sja1105/sja1105_tas.c
> +++ b/drivers/net/dsa/sja1105/sja1105_tas.c
> @@ -575,10 +575,18 @@ int sja1105_setup_tc_taprio(struct dsa_switch *ds, int port,
>  	tas_data->offload[port] = taprio_offload_get(admin);
>  
>  	rc = sja1105_init_scheduling(priv);
> -	if (rc < 0)
> +	if (rc < 0) {
> +		taprio_offload_free(tas_data->offload[port]);
> +		tas_data->offload[port] = NULL;
>  		return rc;
> +	}
>  
> -	return sja1105_static_config_reload(priv, SJA1105_SCHEDULING);
> +	rc = sja1105_static_config_reload(priv, SJA1105_SCHEDULING);
> +	if (rc < 0) {
> +		taprio_offload_free(tas_data->offload[port]);
> +		tas_data->offload[port] = NULL;

I think the config-cleanup issues mentioned by sashiko here should be
addressed.

/P


