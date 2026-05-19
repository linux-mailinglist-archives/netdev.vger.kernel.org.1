Return-Path: <netdev+bounces-289469-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sH8YNQVqDGo8hQUAu9opvQ
	(envelope-from <netdev+bounces-289469-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 15:47:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA4157FF60
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 15:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 023FD300A53A
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 13:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41F73403F4;
	Tue, 19 May 2026 13:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GmHelViB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QbUPNNXi"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935C019ABD8
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 13:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779198465; cv=none; b=WvsTniCkPjSvTSQ4mHfHfbj1SVg9j6rMWR4q9Gzecok9idWIdYX9Bmlb1j+jRvF0Vx6sOwqivDTtpOzFSCv92bFpb/37JfuopmO/US7Tw176kdxrH5TFB15QVHuss+yCxgO+RAn5QJL1bgoly3FVpwH/2E6VIjM9DCx5Q8WkGxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779198465; c=relaxed/simple;
	bh=7JqWoslFjqYidf1jj/qMD6YjftUZTgJkhwSYulq67mM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AsCCLj8mcVu56Z+sjCZOK4WHVih8pfLsxa2IL3bDZYtE4MNB2XVwIC0bouds0EYogTmMP+MRgglIt7oeJDLu8WcnaymQrEtUvIv0y0VmmnIG9z5diaqj4wr56qH9jZtEKGa+bEp8QeV6eKyt1JpBBh2Kmohh0STLMjq0GjmUASQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GmHelViB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QbUPNNXi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779198463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fFmkk0iPYTHgZ5VzODm8MFyiP+vyFjqDvvRAvBmLKn0=;
	b=GmHelViB77C461LqVQgyEg9uDPzXBUTW96Hec/8WXk1F42QnD0ij2xQnRuitT1UkJ/xctK
	8sauUYH02pOvN66sjlw5H5MCbhB697kvbTrYleTZ9OsBbVfn65T8EYOCRv7GxrviDpGhyY
	pCqtd9JvVOfNZ1QM+71dqcRPhq2DzLk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-_sorveeJOdC9Df7k0g0F3w-1; Tue, 19 May 2026 09:47:42 -0400
X-MC-Unique: _sorveeJOdC9Df7k0g0F3w-1
X-Mimecast-MFC-AGG-ID: _sorveeJOdC9Df7k0g0F3w_1779198461
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-45e736cac42so3010250f8f.2
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 06:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779198460; x=1779803260; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fFmkk0iPYTHgZ5VzODm8MFyiP+vyFjqDvvRAvBmLKn0=;
        b=QbUPNNXiW20nsoyE93KB1/QuE4VOGtFRPdGgITJwqGXpIUWCO/zGr5qbYXnJxDqVt2
         EuyeI9RuWdZ00B4HaD/R3GwM9gNB26gTiG/ByEpGX2GuUwMQaA+74SH90+CfI56D9YM9
         fSwkFsKXe2WD5Nl9BUoIU9L/MfurjGqFVmAE0FeCEZfETU0zRYc2XT8aGxw+ODCuzmd/
         64XIloSdJFzuz1bX8j8rd2d8R/jrZ0Jpc3DwTyjVQWO1xpvZOBtP0mhZmiG3J4AtQPKr
         oLydOvfQbiO18UVgAcN46V2qyTmSsKkYuP4Xo6FVBbHe9ooTUxoscTTGATLNY25Kx8XX
         d2tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779198460; x=1779803260;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fFmkk0iPYTHgZ5VzODm8MFyiP+vyFjqDvvRAvBmLKn0=;
        b=sqGNf9uQD3Pw0eVa4pVMcjt3ST1bQtsF63jN/rroT+ArMqW/9JyGyT4dN9oP143+6L
         uO81bWf3VZApQdNo11OOxZy0vnNLoTPP7KQa/vfdEsqKCu5GkIH9WLZLPr77uoxDstl3
         ImHo+mL3Wi1+66vfEtTrvuvT6M15pWnJkKuD1VxItr10niq6HU8atHkAXgN/UM+OyXav
         uTRCURx6BTbdswB1oyPw3x4zq8Zb6SgyAZT1gn1zdBS7n/NUjf6GVxkkFRrgyifHDquu
         ZLqAwWV1ZVXH0rJAvqZpBOOK+A8RxZrvCMFF0IUXROG3RoUaykBSNM2Koa1JsCXgnjqu
         ai1Q==
X-Forwarded-Encrypted: i=1; AFNElJ+0W4GtEQF5UmcVRvE2gCvth2/OOjOKGsqrvVKrYkhCPgnqD+xPVZAPXcGw1sfi4+EYfp9irn0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqtGo3Z3HXESiSYZxoo34kwhzGGTuLSr1a77N0WSnOMoSyIZmp
	bd5fRpFjXpB9hd85ZmFPvftZEbsyLOkd68/4tSDrn/8KciUOMIXjtCdfuiGXULS+ewrgYUVjm40
	mbZ6RKsr5yaORabwGD/t/uGrs1n7seW8e3MVBNLG0Z/G2YPg7V/4LKn3dEQ==
X-Gm-Gg: Acq92OFSW3Ej2naIqF4QCwf1SkkJ88l0qSkk6rYx+ZC86MoL6n+17TBloyMNi0hRXzP
	FgtbXOn11x+ncxBAYLD8D108gJPMP5msEE7ukESrOc99drbaM/Fcvb3VcwGR7yxNFBzmIgZmyp5
	EUCF00ND32yxuofSo7nU+3S33voCltLTPjGMD3v0W9TRAYwEXTP4dXPNQ1p1MLD9RR+Pr0FWUds
	l2wpW9WSe8KWI5QDgjfCfEzGTbyotbrYpJpTtteQeZwZViVIXY8XtheLIUP+eyv/WBIhJwK0k6g
	YEHAbaGwDEY4uMWZ2QteWWuhd/C052e//1XdFzYX/W3PBDtk9QXr34hUuqzPty2eZ2Qj8BchEqu
	usIS5B0HEkt6EyJSqHTwU/zYcQPxe0s+HK7UGbQQa662OXUS73zbzlzk=
X-Received: by 2002:a05:600c:c086:b0:48a:563c:c8c5 with SMTP id 5b1f17b1804b1-48fe60eabddmr224654085e9.8.1779198460649;
        Tue, 19 May 2026 06:47:40 -0700 (PDT)
X-Received: by 2002:a05:600c:c086:b0:48a:563c:c8c5 with SMTP id 5b1f17b1804b1-48fe60eabddmr224653725e9.8.1779198460221;
        Tue, 19 May 2026 06:47:40 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe4c833fcsm327744395e9.2.2026.05.19.06.47.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 06:47:39 -0700 (PDT)
Message-ID: <6ab22cc7-57d1-40d2-888b-76f0905ad5a2@redhat.com>
Date: Tue, 19 May 2026 15:47:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] net: plip: cancel pending work before freeing device
To: Sicong Huang <congei42@163.com>, netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, linux-kernel@vger.kernel.org
References: <20260515063155.3196112-1-congei42@163.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260515063155.3196112-1-congei42@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[163.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-289469-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:url]
X-Rspamd-Queue-Id: 0DA4157FF60
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/15/26 8:31 AM, Sicong Huang wrote:
> plip_close() stops the IRQ and the poll timer but does not cancel
> the immediate and deferred work items before returning. These two
> work items are initialised in plip_init_netdev() via
> INIT_WORK(&nl->immediate, plip_bh) and
> INIT_DELAYED_WORK(&nl->deferred, plip_kick_bh).
> plip_cleanup_module() calls free_netdev() which frees the
> net_local structure while those work items may still be queued or
> running in the workqueue, resulting in a use-after-free.
> 
> Fix this by calling cancel_delayed_work_sync() and cancel_work_sync()
> after all sources of new work scheduling have been shut down (IRQ
> disabled, poll timer stopped) but before releasing parport and
> freeing any skbs.
> 
> Signed-off-by: Sicong Huang <congei42@163.com>

This is a fix, should target the 'net' tree including such tag in the
subj prefix and should include a suitable 'Fixes:' tag in the tag area.
Please have an accurate read at:

Documentation/process/maintainer-netdev.rst

before reposting.

> ---
>  drivers/net/plip/plip.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/plip/plip.c b/drivers/net/plip/plip.c
> index d81163bc910a..4f0ab14f2024 100644
> --- a/drivers/net/plip/plip.c
> +++ b/drivers/net/plip/plip.c
> @@ -1141,6 +1141,9 @@ plip_close(struct net_device *dev)
>  		wait_for_completion(&nl->killed_timer_cmp);
>  	}
>  
> +	cancel_delayed_work_sync(&nl->deferred);
> +	cancel_work_sync(&nl->immediate);

Sashiko noted this is still racy:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260515063155.3196112-1-congei42%40163.com

you should likely call disable_* at deattach() time.

/P


