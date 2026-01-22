Return-Path: <netdev+bounces-252531-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4I1RHSKHcmnAlwAAu9opvQ
	(envelope-from <netdev+bounces-252531-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 21:22:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A036D644
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 21:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63052300AB1D
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 20:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCC036F415;
	Thu, 22 Jan 2026 20:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EnRXrnkD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FEF31771F
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 20:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769113375; cv=none; b=Kkj0LleFPGJwwlSQcScbVK+TSXI7iJMBXOYErf9LJ7AZKgAiC9DiRohR1Y7C494JykTwxqV0sOVK4mHAvvBTWJ2ybISEfhhG1Br7sUn5GPkaZXzkN4HUame1G3x+vpTAbeEySBiEYCO1gmM0VNXesHUE0G/dtjzyGP41PLplAb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769113375; c=relaxed/simple;
	bh=1758xF63dDPlYatlBlkFF4jgc8NopGHyt/SDyYB0XqM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=UySSPVM/3r4lNrQtjdH47Yxvl+8M/2Ad+4Iv8a/AodnaUCLcaJXh8Pm7Hy//DiSAiBSMcNoRcZva5nhBPwaXR8oiuRTTFovrWPJBZcVzgldQEfLKg3Yhb5eS9IfSSgc+QjtA9Gr83VJXG/cvl8rroKDHK3BqGsuIp3LgNlepxxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EnRXrnkD; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-649523de91fso1170377d50.2
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 12:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769113373; x=1769718173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xvc+cwdidV5pghmalPoDl53VSKzOSD3MilYMvD1Qf28=;
        b=EnRXrnkDF8+NuW24l4v3omeO5FOZz5fVxFPnH4BSZBwS8He9jQ5TOw/UYHyLdJ4A0/
         Cy7JqEIzyHyRg7fwb+QeqJlWXnaGgzvDW0gyJcFcaNUqLyBgDMHZoBMtwK9T93+veEbU
         JsxCMpOTsbC/Lfj+d+gb+BBx5/Z7kFIsImR/xZX7I/1br7EF7a5ZQacraEQnF/ztemmS
         WXz7cntDLiZm07Gx0zeLQfxeV8RTPpbU/U1BGMYqfg00b7GjnB6KtLNaUeTIF3ZCnQ01
         1Wjab8B+2vUIJhNy9Ae1xWDj0Fa3jqAzOKnEiU7fVTlWWazVHkGF+WO+ZRYngLYLIX47
         Sa5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769113373; x=1769718173;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xvc+cwdidV5pghmalPoDl53VSKzOSD3MilYMvD1Qf28=;
        b=w5qKeNZYXGIqbat33fZOYTKoe7lpSHS0+Gy1QayKDsYqDqPaw/92b/HZr/9LPTU24R
         ke7B9/Eja7njs78LyPTsbvm+IQ66aTclVL8kueQ4m2I1Ekof16Q6oqi4t0GXIf31nJTQ
         QNMOQNDIzQFIa71mCh1Je3nJiJhaBP6tk1/FMWevtf4C0I5ckZWlzPOujZ4TpgreXjN9
         2/vN6TKOMI9VU3F0tipX7yEv7ruLtFj1YWmfRuilzRagireULeQdaT0uz+ep/+PsK7+Z
         fLk2QSQorQJGVJu9o51EuCBHIwH6UEzpUVyfW34wo/5LYZh2V1pmtoWlKHYF4Wa3leji
         Bhjg==
X-Forwarded-Encrypted: i=1; AJvYcCWC6q5ck3tBbQs0orlbCFEjKo7/34lwY7NjVpSJKpTdk8s4SkGB6B2QEa2UP00CSJJBDoSGC6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YySyhCDaDEzoQZaclOdBzoLpbCykiyBvEoiBCQUz1lcY4C4Q0CV
	7Qyh3aZztH7VH0O6F9iM/kRvipfv1V+XW7d8YIrSewBDoqM7dqiOXYAcgY7stA==
X-Gm-Gg: AZuq6aJ+aFSAb2wYPeDMQQRvIZ0rNrfmk8SPHrHgMyW0zqBEgrCQQiGX6EUbgB/wRoF
	phvl7dFeszDGVILJpu5NKRbD2mYoJO/hoZlqWxjAPT3+zH8eoFFwaUuZq+3j9KUAh0M6za3C5cM
	7A6ZDOQDjCiAp3gtJNco09MW9+/EDaA18HavRJoYOZ4d778ngKwGwpCdRtUscmyFVDnhta/d/Vg
	obYXKnBIwWPS4UC2FKFjgyu4SORSDkwoGn/itTgHWyeu+JNjIKOkCWJcotoNUCkGVuCdbf0Y1+Q
	z0vQSpVcQCZb9xA5fq+xaEKbG3cvbV7Sb9DbjESxlGZgk4fj5uz6eab7DAWq/do0t6V44lKuv0C
	tyCoQqARujsEcACnXyPdt0K/GfAtGJP8dIeoCW+MDRfCPFlyZL1JjV9nCol7RdQmkuN9zzttO7/
	IrMl4w8b35+gqDxn09o5xRl5lIUTYHcywVvSE2vaS+mGdlg7HScM4LerUny8s=
X-Received: by 2002:a53:ad91:0:b0:646:e643:d14e with SMTP id 956f58d0204a3-6495bfc9631mr518605d50.53.1769113373312;
        Thu, 22 Jan 2026 12:22:53 -0800 (PST)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-6495ccd1d40sm151442d50.0.2026.01.22.12.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 12:22:52 -0800 (PST)
Date: Thu, 22 Jan 2026 15:22:52 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Eric Dumazet <edumazet@google.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 Willem de Bruijn <willemb@google.com>, 
 netdev@vger.kernel.org, 
 eric.dumazet@gmail.com, 
 Eric Dumazet <edumazet@google.com>
Message-ID: <willemdebruijn.kernel.65df45c3b4fe@gmail.com>
In-Reply-To: <20260122190349.2771064-1-edumazet@google.com>
References: <20260122190349.2771064-1-edumazet@google.com>
Subject: Re: [PATCH net-next] net: expand NETDEV_RSS_KEY_LEN to 256 bytes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-252531-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fake_table.data:url]
X-Rspamd-Queue-Id: B2A036D644
X-Rspamd-Action: no action

Eric Dumazet wrote:
> NETDEV_RSS_KEY_LEN has been set to 52 bytes in 2014, until now.
> 
> Jakub suggested we bump the size to 128 bytes or more.
> 
> Some drivers (like idpf) were already working around the core limit.

Idpf still bounds to the max?

Iff respinning it may be informative to explain how drivers intend to
use limits beyond standard Toeplitz. The tunneling that Jakub
mentioned. AFAIK there is no Linux control API to configure the device
RSS block in that way?

> 
> Since this change might cause some issues in admin scripts,
> bump it directly to 256 in one go.
> 
> tjbp26:~# cat /proc/sys/net/core/netdev_rss_key | wc -c
> 768
> 
> tjbp26:~# ethtool -x eth1
> RX flow hash indirection table for eth1 with 32 RX ring(s):
> ...
> RSS hash key:
> fe:16:5b:2f:93:85:c2:c9:c1:ef:bd:60:c6:e0:2b:99:4d:bf:b7:14:c8:1e:8d:cb:31:17:51:da:55:eb:91:d9:9e:f9:89:9b:44:a1:dc:08:72:3a:b3:d6:31:86:9a:fe:02:3a:0d:eb:a1:7c:f5:a3:51:3b:08:56:c9:3f:71:69:01:ba:70:38
> RSS hash function:
>     toeplitz: on
>     xor: off
>     crc32: off
> 
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Link: https://lore.kernel.org/netdev/20260122075206.504ec591@kernel.org/
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

> diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
> index 05dd55cf8b58e6c6fce498a11c09f23fd56d8f34..0f761d4b94471a5f8bbe0810922cf59e009be99d 100644
> --- a/net/core/sysctl_net_core.c
> +++ b/net/core/sysctl_net_core.c
> @@ -325,10 +325,16 @@ static int proc_do_dev_weight(const struct ctl_table *table, int write,
>  static int proc_do_rss_key(const struct ctl_table *table, int write,
>  			   void *buffer, size_t *lenp, loff_t *ppos)
>  {
> -	struct ctl_table fake_table;
>  	char buf[NETDEV_RSS_KEY_LEN * 3];
> +	struct ctl_table fake_table;
> +	char *pos = buf;
> +
> +	for (int i = 0; i < NETDEV_RSS_KEY_LEN; i++) {
> +		pos = hex_byte_pack(pos, netdev_rss_key[i]);
> +		*pos++ = ':';
> +	}
> +	*(--pos) = 0;
>  
> -	snprintf(buf, sizeof(buf), "%*phC", NETDEV_RSS_KEY_LEN, netdev_rss_key);

Why change the print method?

>  	fake_table.data = buf;
>  	fake_table.maxlen = sizeof(buf);
>  	return proc_dostring(&fake_table, write, buffer, lenp, ppos);
> -- 
> 2.52.0.457.g6b5491de43-goog
> 



