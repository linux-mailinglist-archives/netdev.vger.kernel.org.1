Return-Path: <netdev+bounces-290732-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KthM10hEGqjTwYAu9opvQ
	(envelope-from <netdev+bounces-290732-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 11:26:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 503075B1276
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 11:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9B163006385
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 09:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D5F3BB128;
	Fri, 22 May 2026 09:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="XkHkLDKj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727B73BB66B
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 09:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779441689; cv=none; b=CKAWb3iZ+uoyh4ONUEqDY4e/sQEQTFjmQgmLqiUH/7fBUTifoXqpr9XeXbgJpJVgRHq4f/o95GvIyZfWejNfa7fitQjns+YYRQgkH5pHow9hPkriQ2zYBXzsRJLzp8hQL7XWeg5yL1z++fMnC844HU9JmWNyQwGOCnPpYb+XO8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779441689; c=relaxed/simple;
	bh=wRoazhwqy/LGdWqNsz6ZbYTEW9e0MWez/WLRYs5P6yA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vA/fqXuWSR0wLqXrx/2d4AqhSuy+J7GEm7yQB2y/6faH7n8mHP7nJVXCk6MU6tjE1xVZmNiPAqkl6wan689v5e5RhRQ17Arg30XCGmtyaP0zemVj06+TAf4y9F6Pj7c1RAlWoCaM8Xrk8fLjftrltfMGX1wWnLO0c6gMmszgLA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=XkHkLDKj; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4903d730b1fso13091275e9.2
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 02:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1779441684; x=1780046484; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AJOgUrZoGB6SnVjXzRYIRgyj/cL/Yt2spEyFm2v+9LQ=;
        b=XkHkLDKj9/QW2o3v1fDd2uAQLJvTOkCP/7xgHdPiqAw6p6FDUHgqtUJkOcxn/43BMa
         ALifpCzQW+vxMwlImO68DDPTz100y36corrixqTcTF0CzsuEtjuTqXZseKDJLuGFwj1a
         KG+8JLLpudsr0TP7kq+rhPmAmmp4N8rx9M/g50s4zjogVkr3k9Oelv7L+RwGRxRvZ2p4
         GgCi0W09fsT+W93XgjvEPkOHNMKa9LYBObgdnVzB5VCI+MVLA42WVDkTZ38cgPQ6K5Kp
         hWm6rE4/dgKcO1QkUpojmKpxTNDI0o9BBQA0p8gNRM5msugWNPYpbpScD3hJSOEeLmUI
         Y/nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779441684; x=1780046484;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJOgUrZoGB6SnVjXzRYIRgyj/cL/Yt2spEyFm2v+9LQ=;
        b=YfnQL/bfkqiSvLNeCBne/isk2NHxLaa6CwU8WWl2ezXkdGD67TwREd9Km14K4+29/D
         KPUDtvLCVoTvbbk6OlkGHI13G24LIkcvuVW10NS9Ai4KYJspcANkM9kkuWX6PT73dbDa
         nFR6TimJB3KW3FXuscjIShV7laEG/xSh4aTkBl+ZlWEQ9iGiChxUTDnQqJrX6WjB8Bfh
         B+NqByRh9XLA8un69TiTyo5Fu50zzjseVp2NKn0pRQ0p2tn+yyXpPoHVahWededO5JUs
         ajB1A5NMJtnd7JadaLfGz8LltG0K1DpqtweWxnlKRYyGP0u8bL0A6/VSz6VufC5i63lO
         Wcng==
X-Forwarded-Encrypted: i=1; AFNElJ9kpRqhx/7cruHa3mndaS9Fdd35/HPGvpwwd8I8W1WxSwu1S7+JOFD5JMheI/jEe2qOCQiYdmU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc6FwaDUdejgcOaQeTl3XNc6Ks+0hUZj4Y3TkkkpZVITwQ6WjI
	/squymwaMmzak0ALtIE41OqZi23kSrr4xuuLR1uloXThGHObhOZuCziV346OYw1Zl3AIsfGWiGh
	j+hA5RA2Fog/IG045vJOBcz5bhSrSDiscYJbmrrs/LR0R0MN2NmREAZ5CH2pE05aaroM=
X-Gm-Gg: Acq92OF/eoUsCYUaiBP0Owzg38uzwgkN3t7YrPAeUrDeadwyOQltiouRQs6tJubF8Wx
	JLqL46BJdfXkdpRUNeEl9rsR6o6L28J3vz/lluTINkPvv2pcSqcao/EdEpA1U6qZIR3i5fDoIwU
	l38Ccfjjmquwc2PayIv8gJ6m9UUvecuEFk7h3HkUGdYVUOyDN8C/0USlvVkxHEbNDeCQXL2fjrz
	Aelgysliv8t28MBLVn00ntKAF7sMjav21ma/bn98sjGCcv4waliQL9o4ry0vssXzBOOwjgfQL/W
	6kFeYVY8anMeR3FNYIOTFoA90KvrM+5qDe3KcBFdDe+5hy6kMECiTFhBVLrCw+RwCts++yYUq0P
	PHsfNAeVkaH/ZMvwLkE5cwdOdu5jEygoDRMQDfmqe5X1UV3zF/PtaHp9DK/AApk5OWtr0/hXiL3
	UknHc8Z9qiZHVh+GR9LK1ovl8Y2PlCJ7PeXQIxsZvKK/fETdL3/Toa/qsrk4QvT8Y9AUxO1f9Wd
	QBDzpTH7f4=
X-Received: by 2002:a05:6000:1867:b0:45e:9433:f301 with SMTP id ffacd0b85a97d-45eb38df5f5mr4080423f8f.41.1779441684385;
        Fri, 22 May 2026 02:21:24 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:c745:5339:4482:9cce? ([2001:67c:2fbc:1:c745:5339:4482:9cce])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d70d89sm2816997f8f.37.2026.05.22.02.21.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2026 02:21:23 -0700 (PDT)
Message-ID: <2a191e9f-f86c-4f1c-9f76-e0a7557ce51a@openvpn.net>
Date: Fri, 22 May 2026 11:21:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ovpn: fix peer refcount leak in TCP error paths
To: Pavitra Jha <jhapavitra98@gmail.com>
Cc: sd@queasysnail.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260522091718.270956-1-jhapavitra98@gmail.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20260522091718.270956-1-jhapavitra98@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290732-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[openvpn.net:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,openvpn.net:mid,openvpn.net:dkim]
X-Rspamd-Queue-Id: 503075B1276
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On 22/05/2026 11:17, Pavitra Jha wrote:
> diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
> index d651ce85c..2c7d830e7 100644
> --- a/drivers/net/ovpn/tcp.c
> +++ b/drivers/net/ovpn/tcp.c
> @@ -283,9 +283,9 @@ static void ovpn_tcp_send_sock(struct ovpn_peer *peer, struct sock *sk)
>   			/* in case of TCP error we can't recover the VPN
>   			 * stream therefore we abort the connection
>   			 */
> -			if (ovpn_peer_hold(peer))
> -				if (!schedule_work(&peer->tcp.defer_del_work))
> -					ovpn_peer_put(peer);
> +			ovpn_peer_hold(peer);
> +			if (!schedule_work(&peer->tcp.defer_del_work))
> +				ovpn_peer_put(peer);
>   
>   			/* we bail out immediately and keep tx_in_progress set
>   			 * to true. This way we prevent more TX attempts

This patch now lacks the RX part.

Please wait 24h between submissions (i.e. before sending v3).
More comments may come in in the meantime.

Regards,

-- 
Antonio Quartulli
OpenVPN Inc.


