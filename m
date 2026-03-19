Return-Path: <netdev+bounces-269402-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOPeBAbWu2k4owIAu9opvQ
	(envelope-from <netdev+bounces-269402-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 11:55:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A10F12C9CB6
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 11:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6CA4031B1FBA
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 10:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F9563C454A;
	Thu, 19 Mar 2026 10:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G+Kx2lPx";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="VvQ8IT3A"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CD73C344C
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 10:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773917409; cv=none; b=pe6MsjDSjPnJE5gbaIC6gaMbhW5x7Es5MCdVi63ZsnGmmu0su7OPAgDLcRkt6yfQPNeXqwZdkXtFqTLoES1bWR3ofh+60YxNBVZPdBNOVZIKcgJb9u8qq3f1g7V9585Z2XakTrcpNewx94nB895rVAVy9sj5oxjeOlvBoGdtWJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773917409; c=relaxed/simple;
	bh=0PnjIJb7BB31tuXTXb9O9K08P7IZqTFP8xOl5ts49z0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W6uAH5wWJoMEaDduicmt2N3zj7CYKjEGSbdlDgLhWe03A+iqdmYfEUHWBq8O4jYo3JTEIEeNVMYihPf6vP9u2FOhUQM1C06fZu65GecCh167NpWgBLhdvRD7g/XFZnN91p24Wriyv/hv/YWLzAlvSIfsbbp7vALrWUrYFg3ySZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G+Kx2lPx; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=VvQ8IT3A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773917406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0/QrmoRE0Ec4371GT4zD9Iw4up8oNW0PlcBOJIQ423E=;
	b=G+Kx2lPxc9Wbbn1+W9zbtvE/F26K9bWO4osEXZCIVPgZYZez2P5n8+vVOAER70/meXY2/s
	raw97bhPHo0nMMnBaY3ergBU77IVcyq6AVGTuxw9Hwwi+LTh6Hhx/S2VPF5r8h7kYm463b
	LCNbtEOngQg34KvjWEktqFdFqtL6dh0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-mJN3Jr8_OgSkonvdemd97g-1; Thu, 19 Mar 2026 06:50:05 -0400
X-MC-Unique: mJN3Jr8_OgSkonvdemd97g-1
X-Mimecast-MFC-AGG-ID: mJN3Jr8_OgSkonvdemd97g_1773917404
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-486fa9ea1ebso7597275e9.1
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 03:50:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773917404; x=1774522204; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0/QrmoRE0Ec4371GT4zD9Iw4up8oNW0PlcBOJIQ423E=;
        b=VvQ8IT3Aq1s1RyVJaXQI4RrEZ7dyWGk020Baz9N+pqwNDlwipjtbf/Skmc0RUvGxmx
         2cVR3/c654Oky2bZ8emjucih6vYPK2Ts61EnpQ8PN2U+88Cu00y143KKPROs0NT+v63A
         V0S7mHyaknQJl2FBHXMmfz2WaZGmKu0QWxKuzSiOVAn/13ZhGIkR8GRc0wrwPQRaer6J
         XmmwVcKjTiJZ+WtZjbWmc6dZkGqPErjV+v7Q65a+1fhjpO8goTmNWgwHNSuNaRHyh5pL
         Dm6V728+aduL770sSAfWXqJQL4JqK/FglPJcpeZJtxKHDBfD8wG+6+mY3CzAgJER/6x9
         Jy+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773917404; x=1774522204;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0/QrmoRE0Ec4371GT4zD9Iw4up8oNW0PlcBOJIQ423E=;
        b=SMeTBZt5L7etUrncV9+8P0TUDgNNQ2t7mYdD5BJoa4gG1RjCpa03hNWwy3cR4wawqE
         AWhCfMcERKEN9/2jALTevrZyF+P/Bjte7VjotiiG9vgrDsRP/L3KDY1QFlfEApSHG4Mx
         pfavFrVfbwhfn8HsyJSbxKxEUcVezUYbMqU7bK1rcMJxXO/c6U69uVZW7/9wqI9GP6D6
         tn/7Gk+a7U19KKu5MLJREbzK+x8BDXMuxL89GT/31o74QU9Etzi2BK1T3DOVsxXFR7j1
         HHZ1m/y2fi4LU7ywpfLRPR/kpky6jmgocD0iv8XfVvTUXY5qn7AUVhh5aCKDjtwKyswV
         gheQ==
X-Forwarded-Encrypted: i=1; AJvYcCVA+Br0yiOMjFRcIq26TXcHh7SuGjQWYWUByqy08O/pFY1OXckJZ+54OhyzzKh3qYJORNxCB/c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2TuU/AjKfNT6iVU/YkcIH/u0TUf2H6woUS9lCIgEnfsANpOMn
	u8B6ETgIVDQF9eeQfyvjZdliQt0EIe/rGeV9BoP/F8eFLocZTGHl/0ml88vs2FQz2FAm2zgNeC3
	LXS1qWaMxITruwWyGVkAtuV3+58hfHN6bmJQ08Y81IMozlimaHthk4biOhQ==
X-Gm-Gg: ATEYQzxJkXs8cXmJUcT76mva17syymZzuOvR41oYcHoJT5E7h1RPbGYE2dxwsiUQ7ls
	xV+9K+TNif1l3D5deSxMfx8ibCMX6b7jVGIzu2GwGLpJyArwFqh66V8/dvYdfYkTZwxJSiAjt+C
	qmqDHHXjafrxjwclck+xXReTosmsnMd9g/R5XmvstMkquPMxtw7KsSYSQF12eMSHGNhNR66JopX
	VSgRyptS91MUT8GQMVdls4jSZYih55r6lU2euZLth3UtUQf/3n6AjG0Q52oEFkBCtCnOspZ3Ezy
	fhYSP5c+h2cAfyHTKGJ/gSMXExlCofLtNfnwa0iSpH4u0IYZsB65Q4hnDpGedfaNQrpVNQ+Dt1l
	s6TQHj5IYYkxwFhqy+UXPjCzM7dey73pwWJg4NxNaAyyrTqJetuphU4ui
X-Received: by 2002:a05:600c:1d10:b0:477:7ae0:cd6e with SMTP id 5b1f17b1804b1-486f4422046mr113298455e9.5.1773917404168;
        Thu, 19 Mar 2026 03:50:04 -0700 (PDT)
X-Received: by 2002:a05:600c:1d10:b0:477:7ae0:cd6e with SMTP id 5b1f17b1804b1-486f4422046mr113297875e9.5.1773917403694;
        Thu, 19 Mar 2026 03:50:03 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.196])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b518a2cd3sm13432241f8f.32.2026.03.19.03.50.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2026 03:50:03 -0700 (PDT)
Message-ID: <f5c9a512-4779-4cc4-aed9-37ce0131b3b8@redhat.com>
Date: Thu, 19 Mar 2026 11:50:01 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] tcp: keep scaled no-shrink window
 representable
To: Wesley Atwell <atwellwea@gmail.com>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 horms@kernel.org, kuba@kernel.org, kuniyu@google.com, ncardwell@google.com,
 shuah@kernel.org
References: <20260317065137.1533226-1-atwellwea@gmail.com>
 <20260317065137.1533226-3-atwellwea@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260317065137.1533226-3-atwellwea@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269402-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A10F12C9CB6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/17/26 7:51 AM, Wesley Atwell wrote:
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 35c3b0ab5a0cb714155d5720fe56888f71aecced..bd3a43148a87e891bc632a47ffb5b82c475e8f6f 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -3375,13 +3375,19 @@ u32 __tcp_select_window(struct sock *sk)
>  	 * scaled window will not line up with the MSS boundary anyway.
>  	 */
>  	if (tp->rx_opt.rcv_wscale) {
> -		window = free_space;
> +		u32 gran = 1U << tp->rx_opt.rcv_wscale;
>  
> -		/* Advertise enough space so that it won't get scaled away.
> -		 * Import case: prevent zero window announcement if
> -		 * 1<<rcv_wscale > mss.
> +		/* Keep tp->rcv_wnd representable in scaled units so later
> +		 * no-shrink decisions reason about the same right edge we
> +		 * can advertise on the wire. Preserve only a small non-zero
> +		 * offer that would otherwise get scaled away to zero.
>  		 */
> -		window = ALIGN(window, (1 << tp->rx_opt.rcv_wscale));
> +		if (free_space >= gran)
> +			window = round_down(free_space, gran);

The receive window already has a similar rounding in the `free_space <
(full_space >> 1)` case. This is basically excluding only:

	gran > free_space >= (full_space >> 1)

which IDK if is a realistic situation, perhaps just do the scale down
unconditionally?

Also minor nit, prefer 'granularity' over 'gran'

/P


