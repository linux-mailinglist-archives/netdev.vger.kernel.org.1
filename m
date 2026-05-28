Return-Path: <netdev+bounces-292656-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LSyBjYfGGocdggAu9opvQ
	(envelope-from <netdev+bounces-292656-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 12:55:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B02A05F0F38
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 12:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 153E130087E9
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 10:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F0C3D5237;
	Thu, 28 May 2026 10:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NxvK/6Bn";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="I822GB7+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161DE3D47BF
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 10:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779965745; cv=none; b=b6UxLoHSqOBMnSBB7KYnGdTpZu3ryYtBvFcmxUOooQkb1k0t6z/1jO2Bc7ESzhkiZ/6/ncPOIFgHOgZFYWdjGZA53DyT71A/gz5nUy9ZZejRGuX1uyxxpJTu6jDNOXs81WRJLiRWR+3Zu5JBcY4D3X7n4rPmSXEZB9Bq2oz79zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779965745; c=relaxed/simple;
	bh=yshw4ayZ6r/hbHnyR6Jfb1EV2fj+judOG4eGEwyRaFU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aLejR6uzINYkUiIpYeGVerCxnBP6wMms4XpbPDSZX5YhdckXwF6WEQI8B9O3dXY7qdfvtjF5B5wDTk2spahCbOpzXLcxDk+P3pDRbTD6fUNmVy58A5hEukL45Sp0zAXxbFbzIuFu669jta7Vt6Wv5nzq8DXJg6gAZwlqknIn1Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NxvK/6Bn; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=I822GB7+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779965740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9nJtqcqyQQDQ54qr/5TdUHkYL8B/U7BhlMSVeD1r3IE=;
	b=NxvK/6Bn+ttuqJXqzUrBJzMYQnB5IPcNbBi1uPbAX3v5R1dS8gjOB89JjpW9K81d0kldv3
	pDeISixyk+A2jT5xzurSg10zF3Z7NwpSnHecoRgvAsYLwCrdE3q0srMTKAwwDu+v5+eb05
	hVQg/W+LuPezfvvq3MqLEHlThWCdM0E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-S0bOodpoNjaunxFkCSVWgQ-1; Thu, 28 May 2026 06:55:39 -0400
X-MC-Unique: S0bOodpoNjaunxFkCSVWgQ-1
X-Mimecast-MFC-AGG-ID: S0bOodpoNjaunxFkCSVWgQ_1779965738
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-45e80183514so8785953f8f.3
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 03:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779965738; x=1780570538; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9nJtqcqyQQDQ54qr/5TdUHkYL8B/U7BhlMSVeD1r3IE=;
        b=I822GB7+EjIDvBNIYUQrtf8upYouRi6oUvCuKPE72UMMkJfPkHXQvkzp2P/0uMahjk
         8Tbjm06TbdK3NBKyDcCgvL03FYirNQMOSsAyZUmRlhl0Zvh5myDFWP5Kvz84LtET05AC
         sxuaXP0pkUNype/q1KxTcBlVXY+ngjnTdqj2g+pkd2Yth6qPNyWMLQ3j6JWsf/VBv8/g
         JN8Xahnb9PkvUvZEZnBfC2JSNHXWTpZFQTlTVk4SF3xJdN+vU8MwrcoxXGn171tbdxgN
         Dd0FBMyXdx6hSCJfFIWd7T10Jold8PhC7L+tcE/EJ+J2okPDhMrIUaR/3LB+0Y3v3wYd
         ddRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779965738; x=1780570538;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9nJtqcqyQQDQ54qr/5TdUHkYL8B/U7BhlMSVeD1r3IE=;
        b=NhRm+KZcKCHwMjRxfBf7XpRZCEAcQSNBvW+IK2ItqjCnv82YhcXi332NztSAt3ukEA
         88YigK4Ix6Ht9UuCGEaY+cG4Gbn3g27qA9e7wm7lhqPX9xJZoRChS5mJtf8M5eaYzZha
         zypIncW5lWxZOc4V/z8QJJB0J1iYHqAjCGakY0f5LNdgYrTsGZ/8gvQDk2FUbP59+alb
         mJ9ko0on5f/0rvIRvO2R5fnoSoD8Kh9JK6A/XF7EtlLxmoN84J/ir3l1KBsZuWpzW6fE
         Pe901NYG5qi3MZ3B90g/4yuZGNJNcHpn4BpfJJ+1/Q2L2UCW0gJIApquyZoKHu0SycKC
         5v6w==
X-Forwarded-Encrypted: i=1; AFNElJ9Z540OxJLFLs+7L6ZN0gpAay2kqIA6oJMha/Z/oHjPBzmH/oENZS4QfDmzkRCCPcNo3FweJV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQcg8m2imx27i/VSkk1g8XmhKS+H3ecU+H88jKy/0n/hgNw/1Y
	CjrpiSdtkj9SfVHxTLOu8YTO5H7xBw3XcDzfZ7frC+HKKKnc/MEDt4EIM9hxGO6dH8y78Hjh/JC
	mTw81sJeVqxKLi4HG9P9lZ+Xf3TLdaTEuHpPQqvGg4c8NEOMtczLHfEv91A==
X-Gm-Gg: Acq92OEtmoIKzZSpUlaArGyGlmwWL6wkcIpXgFaIHSlFbHV2tSG6xIKIZymLds3DAcP
	ajpgIjsKWOD8FPsDi6QnyxFZ1s2IfBKsClkI+XK5JelQzv0WRrfsqvD9pHqCvm4veJX83JUQmnz
	GELpOzi3FcY2krSUEzUq6tG6pWBeug/PP+Jr8eUzqVayO/I/VGlY0WIRQg1tbr4vkIYgbFY6Eyb
	fn9Vmgv32OwAA7WJWRzMmuHeA854viPbPweCAlTVIk9tEmluExTWOKRx+oJL4959MYMO1D3QH7e
	b4/G8TnB5NRfdclQj7JyTeNaPO9L9M+sSopHIFansBSs1cfUf2+aauOO6EPlU1363X5JrfbZnXh
	ih9mHDWgmDV6vJNqkzjRBHklNhWR0kLDpUVqF7dCT0Yl1Sv4XU/mqCAEYdwJdeD1jEQ==
X-Received: by 2002:a05:6000:5c2:b0:45e:ed10:8dff with SMTP id ffacd0b85a97d-45eed108f76mr1192541f8f.24.1779965738221;
        Thu, 28 May 2026 03:55:38 -0700 (PDT)
X-Received: by 2002:a05:6000:5c2:b0:45e:ed10:8dff with SMTP id ffacd0b85a97d-45eed108f76mr1192507f8f.24.1779965737797;
        Thu, 28 May 2026 03:55:37 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb54a3c3sm13227520f8f.8.2026.05.28.03.55.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2026 03:55:37 -0700 (PDT)
Message-ID: <5783055b-60e9-4e54-a17d-79b5e8f64fb6@redhat.com>
Date: Thu, 28 May 2026 12:55:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] llc: Fix NULL pointer dereference in
 llc_conn_state_process() when sk_socket is NULL
To: Jiakai Xu <xujiakai24@mails.ucas.ac.cn>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>
References: <20260526013541.796307-1-xujiakai24@mails.ucas.ac.cn>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260526013541.796307-1-xujiakai24@mails.ucas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292656-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B02A05F0F38
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/26/26 3:35 AM, Jiakai Xu wrote:
> diff --git a/net/llc/llc_conn.c b/net/llc/llc_conn.c
> index 5c0ac243b248f..de65c452f6e68 100644
> --- a/net/llc/llc_conn.c
> +++ b/net/llc/llc_conn.c
> @@ -101,7 +101,8 @@ int llc_conn_state_process(struct sock *sk, struct sk_buff *skb)
>  	case LLC_DISC_PRIM:
>  		sock_hold(sk);
>  		if (sk->sk_type == SOCK_STREAM &&
> -		    sk->sk_state == TCP_ESTABLISHED) {
> +		    sk->sk_state == TCP_ESTABLISHED &&
> +		    sk->sk_socket) {
>  			sk->sk_shutdown       = SHUTDOWN_MASK;
>  			sk->sk_socket->state  = SS_UNCONNECTED;

sk orphaning happens outside the sk socket lock, and before the timer is
cancelled. sk_socket can still be cleared after the previous check and
before this access. You probably need to move the sock_orphan() call in
lc_sk_free(), after stopping the timers.

/P


