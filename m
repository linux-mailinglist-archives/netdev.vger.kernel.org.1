Return-Path: <netdev+bounces-274442-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qONtBuYzzmk8mAYAu9opvQ
	(envelope-from <netdev+bounces-274442-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 11:16:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B644386AA3
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 11:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCFEE300D443
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 09:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB1C3624D4;
	Thu,  2 Apr 2026 09:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ODsubffe";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IR7l9K+o"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2143819F40A
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 09:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775121225; cv=none; b=BEUk2JsXv72WxbvRfEScqkhvhhopti2NIPaDtYbEhZqcPDQDGUnYKS7U/XbQPwgjZ9V++rBkZKkU+arxqqKG5ZNw4dxHaUm6DdHH9Eb+NJCyY5QnQtgdg12ydTRNTZTw6kIbZFLkH2Ogzhuq8bXFqdA+/Z2Uzk/AtIeqUUCgOzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775121225; c=relaxed/simple;
	bh=4xw/ga67voI/myNm1PvWwzm5TeuMOLMx8Q/7T61VA8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F/7YnjP52QfWD9+pC74wMDi1vxIrKFqRp3sXxWkeBslqrwzX8n8wE+0IkK9afnl7pow9CkJlbHHCSUPTuWIMtazUSh7joiqPpFWbOstVPhtawhkwARMqreeHftXfWSmoAchI5zPTuHizs71KDavyydfiAjd6aVBPQfMKVKOkbvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ODsubffe; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IR7l9K+o; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775121221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uo3OmzGA2ckZBESUf6sgSBkAP6Pbi+eIBXMIiQ/bWFY=;
	b=ODsubffeOdnjR9VjD9cDsWT8HOAce6j5PqXk/QiPv4fNcXOxGG5f0BEfq/YcLPIu0zqU0D
	4Z8Z/r4ZqM41dgY+bQVZuhYc1RJoCpUaPXjDncQ6KY9GHq0PVLqkbol7Epr6s7QqxB/USl
	LA8v5gT0ZgUALb527fyp39M+f6vgvjY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-104-3Q_2PpvuMbGG6hWMNCYUHg-1; Thu, 02 Apr 2026 05:13:40 -0400
X-MC-Unique: 3Q_2PpvuMbGG6hWMNCYUHg-1
X-Mimecast-MFC-AGG-ID: 3Q_2PpvuMbGG6hWMNCYUHg_1775121220
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b940da8ec09so59102666b.1
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 02:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775121219; x=1775726019; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uo3OmzGA2ckZBESUf6sgSBkAP6Pbi+eIBXMIiQ/bWFY=;
        b=IR7l9K+oVTv+cYUWxs5+ZkUcrUo/WZ91PutMRIx4mvSZs5MNO6EvZK4DMe8KntMQyA
         9dh1Qdv2IyoydoaKySAIilno509AwDF35IbUELFL0TLMGqDkhLz01dCdsCI96UzW//nc
         KSGvJ48RkAmq9wlcoiyFmczwtnO1ahMNUuU3wTrBbkW6fktVC6BuOyPQxGzIak7XZjbX
         5g4uHFXiDnnDUDHZHja3l5ipjx2Xxq+ns05ceCnqdohoq01G/wRNwEVrhI38ruKCIRCE
         em4lypi9tYaT+tfqL+d/lhpuBOFYSsCvjwmFQpDPRujni4h34oDA0al7l3dAX/XgGSgo
         Nydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775121219; x=1775726019;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uo3OmzGA2ckZBESUf6sgSBkAP6Pbi+eIBXMIiQ/bWFY=;
        b=L8jJvL3Tutqi53NpmbYsRk50573ZFc8p2qq/vy4y/qAZM2SAwUocl5naC5u1bx9Is7
         WMPrZmlVEojF75iYpIPbClx+tEx7iOm1nYmWD2xp2bNJDUM8BfaKj/Nd1CDPy/Rf1laO
         IKm7PIFZ5sw/tTOtd7acQjt3KmeDITxPoM1BbZADEZVYG/z74Bv0o31gjt+zjK1GOYhz
         FQxCmZ3jupVdBEviZcU5bjziCRElMuY2hfN5UDhsCPkV1ai4did6DKZd0ZuhqbrAy4va
         0Eykzv0xk9X3C4OhyJL+5H/z4kQRwE9DpPRZR9JUrQqq3d1Xp5+NKrgWLcRCZ0tASXAv
         4t5w==
X-Gm-Message-State: AOJu0YwAhmutKYo4qS33lPRz6Hwy23jEJGHkDXYxqCR9W0IYyRWUkWlW
	a+quSr2II5RNyYmlXp6tTPI3ivLPmlYwDR9VAqo5Ye0VVWHf/TFAkBxkIdbRZCW1UmluZDFI4Ay
	T2dgoLH6m/AXc44oxSChnNUVx2wnUc1GpTKTg5oGMjXZJCtPyt9UGng3N+A==
X-Gm-Gg: ATEYQzwrlneMo7uCoIAMUfB5quKgME2gVHWY9kt1UIZbFHh4hMufcwXiVgDEgo4Ah8W
	8NG8Rm1L5Z0491sFNY4R20V5D7rYbbe3Ff6IGNpkeX+5n9uWnFfb4gQyFobhrAbd8QP90kyfYqk
	bdRzh0skUkfD0IgtFNo5CJAaPV6sQ+hWHQcZ0+JjWP3nSK9oza+N5g3+npa7J5yd0Y+drGfzX2f
	2oUqrnwQC7JkhqMf6f7BWKHq5X1my3/3Ko9NexiKkusWiDK3C2/20eNfpr5xwz+2kyw54kkfcmE
	pyWUzz44z99QGdqQpQ6d35TmywAq+c/BoCt7BuBQtfDNby2Z3wWCaS0e2IfdEnZwVA3FwBKOuEN
	qYJPUksvyDeV61gxEYn1IB4TDn9+tlETAXYtLbtIuhHepP+EeqG3SXSP66Q==
X-Received: by 2002:a05:600c:c0d5:b0:46e:4e6d:79f4 with SMTP id 5b1f17b1804b1-48883597d5cmr86145655e9.15.1775120724270;
        Thu, 02 Apr 2026 02:05:24 -0700 (PDT)
X-Received: by 2002:a05:600c:c0d5:b0:46e:4e6d:79f4 with SMTP id 5b1f17b1804b1-48883597d5cmr86145105e9.15.1775120723689;
        Thu, 02 Apr 2026 02:05:23 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.153.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48885553118sm39116485e9.14.2026.04.02.02.05.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2026 02:05:23 -0700 (PDT)
Message-ID: <0f9e9d4e-8083-4297-91d3-10d0f614c87c@redhat.com>
Date: Thu, 2 Apr 2026 11:05:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] net: caif: fix stack out-of-bounds write in
 cfctrl_link_setup()
To: Kangzheng Gu <xiaoguai0992@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org, kees@kernel.org,
 thorsten.blum@linux.dev, arnd@arndb.de, sjur.brandeland@stericsson.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260329190350.19065-1-xiaoguai0992@gmail.com>
 <20260330065342.145549-1-xiaoguai0992@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260330065342.145549-1-xiaoguai0992@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-274442-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,linux.dev,arndb.de,stericsson.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 8B644386AA3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/30/26 8:53 AM, Kangzheng Gu wrote:
> diff --git a/net/caif/cfctrl.c b/net/caif/cfctrl.c
> index c6cc2bfed65d..373ab1dc67a7 100644
> --- a/net/caif/cfctrl.c
> +++ b/net/caif/cfctrl.c
> @@ -416,8 +416,16 @@ static int cfctrl_link_setup(struct cfctrl *cfctrl, struct cfpkt *pkt, u8 cmdrsp
>  		cp = (u8 *) linkparam.u.rfm.volume;
>  		for (tmp = cfpkt_extr_head_u8(pkt);
>  		     cfpkt_more(pkt) && tmp != '\0';
> -		     tmp = cfpkt_extr_head_u8(pkt))
> +		     tmp = cfpkt_extr_head_u8(pkt)) {
> +			if (cp >= (u8 *)linkparam.u.rfm.volume +
> +			    sizeof(linkparam.u.rfm.volume) - 1) {
> +				pr_warn("Request reject, volume name length exceeds %zu\n",
> +					sizeof(linkparam.u.rfm.volume));

It looks like this printk is remotely triggerable from each incoming
(malformed) packet. It should be rate-limited.

Thanks,

Paolo


