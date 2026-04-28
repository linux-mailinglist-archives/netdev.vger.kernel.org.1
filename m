Return-Path: <netdev+bounces-281879-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SH8DDbnA8GlPYQEAu9opvQ
	(envelope-from <netdev+bounces-281879-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 16:14:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CDEC0486ADB
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 16:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6178A32BDBE0
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 13:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C528C43DA30;
	Tue, 28 Apr 2026 13:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DQqL1ppB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="uOmkELf4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD1E43D4EF
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 13:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777382723; cv=none; b=OwKGHJbVQcpqVyrYZ/9AqYIVi8DCjo+hc/8jLwP3CqyH+Xexn0hqtXppiKPw2HhZN1oIfm+YV8X+qmuJyrminzU6h05osnzayOttHfbB/RnquJ6J8Dk+Ei3bR+MACvgFBxFX8RXHJOXpvJGcxAI55IpKw7K66xeBdgKRW/b4qtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777382723; c=relaxed/simple;
	bh=8phl3r8wmo18LdSVaXgD5wtaI76RJIWuV2L538kI6as=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y4VWB0sefE5kL7TgijUI1SIle46BRlCX6VW/6sNnCUOPE8WM8ftw+mwuW++uXxSZPKpQfFyWNF+gbqxo8lgUY8HLHSS7lQFvv0fznWvhVplgkA80p4JkoyxkJYGnFD3+YSQGwQcr9mnqLULbXJJQrmVdujQBC/D0YqExIB2cu00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DQqL1ppB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=uOmkELf4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777382720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/VoR+r0EdztbuqvfyfykBdYULmnz7rnigVpq7HE85tk=;
	b=DQqL1ppBPXvGrj+eMtC+Xd1NZZdy+F10GIS3/ReRvO/FrqVpMPpBuYea+LJDh5Bjux/lkR
	wErJK9j7R/XKpiS9lJ2/5na6nmj227NJTtSn4um0c4LRdWSLFTgEhZLt5mkzTbAnXwUvfL
	il58aBcBwScxZ9yXbP9g2KZiP2vRShw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-vtyYLSfUO6qOESNyDUcmgg-1; Tue, 28 Apr 2026 09:25:19 -0400
X-MC-Unique: vtyYLSfUO6qOESNyDUcmgg-1
X-Mimecast-MFC-AGG-ID: vtyYLSfUO6qOESNyDUcmgg_1777382718
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4411a36715dso6813367f8f.2
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 06:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777382718; x=1777987518; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/VoR+r0EdztbuqvfyfykBdYULmnz7rnigVpq7HE85tk=;
        b=uOmkELf41QksGP7Kso1O6oUyLxgqnHmsD6fNzzK376asLPmgCKdM3n7hzXI6L6m8q+
         GgBGd711lp2EiFHJd2m9aSO+qMU9Mv2A3VnNSXZNZ9GXbpdewEM7RM7tPajTbSp3yOWV
         83pObq32eE6Tdx6j9ogNtg3ZtlmNwTeYAjRE4IPCX1n2d1aXlfwbSac1vCr04vmOZnS2
         FqCFUFpkrwWe5Awm1/4r4hqF2D78G2zBUo7bnnGQPwLWgGJfazgYj2I2HHtP9Ku447Ol
         ZyYtiaRJzjxxOo/EaGJi5lwWe1YR2dkBqSIeFNnLatBuf417g075nSjCijPp+sdt6C7N
         udVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777382718; x=1777987518;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/VoR+r0EdztbuqvfyfykBdYULmnz7rnigVpq7HE85tk=;
        b=buJjwqFn7+V1fGsYKi99+PtyMVysTPE75vkk86gqGBT2vs0QDyNfG/9/EFvp8v9J/z
         GRWzQlf0s75sDV4+wTh5xBZEsiAh2qZlVG8wY+yCTXmCRY/fv0d5JXpq31UScDa5GQ0/
         PrSfxVGJezqi9X94qWUGWaSBQHwoP/el/r5RHQEyN8XGNnCySz2zLUf+Bz98lC4260Mz
         TCtkxgbUjARaSRXQwTwzVQIAc9fsmQkvMzrSVnclrcv36xH8fmOIfE19xoDlFQx6Ed6g
         66IJVpX8JLK1A1YnANx2lJRAgrMVcc0y+2zsbbHYsVGcukGTJUCgRkbzzwF1/rrdNTMH
         qoOw==
X-Forwarded-Encrypted: i=1; AFNElJ8y105hWB8q3iaV6LcGqqNAJ3fIQiFgRdIt1RUElG4rcLs76MC34dk5auOklssaZDLCIOo3C6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN+ZrgRc/2CKO+WWH513n8Et1ebrEDvGAwMas848JW92G7EIDP
	T/AmNHtUhs9miibdhO/Y8y2PvLUbnEonRjVP4U1Y7pWNRK0IECKU23O1wLvSumnZbNhzeNR1g0V
	32GwKJuqtNYPXrBcDzrRJF51jTMdB2iA0oDQFka4hdlpmAco6vHmn3l79XaWtVAZLwg==
X-Gm-Gg: AeBDies0oYPc2aTdMDYPfQah3AqlUc+48V8w/GFzE6KxqWR2FIdONie+wy3aApW+VWR
	HKgdkPISIPr66KqeSWiTkbY62fDeSJCRl8bnGf3Rdc2JfZLvGc5+xCU5FKDtLRFwV4LX12NUZbQ
	dtVlT4k6mOTnds9dBmbS2xtDaXoJZqw5Inrr+dVZlo7WvZ/bKngitZgAwNQBuJy7JbfDTHlvuHb
	bfHZAFafKudodsoZNjObz1eIbX6WqUTsins68q6JNMrYCO41uHR+8rpe2TivqP8jclE46BeFCBA
	yeVoJZ3Ub3ooc7+7ivCSw2wjGJ8Pk4O8Wrb+VAMM0Ypvxw1FZ++JF5OecfIxM7UGVDyK4jyU2vN
	tPc98jP25kJ9HpEXn5xAUeOTqdimqQVSLB1ZhH9IGOnxKMxWuq9vzdUs9kp8+HlryNA==
X-Received: by 2002:a05:600c:3f16:b0:487:55c:e0c1 with SMTP id 5b1f17b1804b1-48a77b1da5emr55604845e9.14.1777382717854;
        Tue, 28 Apr 2026 06:25:17 -0700 (PDT)
X-Received: by 2002:a05:600c:3f16:b0:487:55c:e0c1 with SMTP id 5b1f17b1804b1-48a77b1da5emr55604145e9.14.1777382717385;
        Tue, 28 Apr 2026 06:25:17 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.9.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a773a874asm72235935e9.3.2026.04.28.06.25.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 06:25:16 -0700 (PDT)
Message-ID: <679ebe0a-5889-4a84-afd6-3da50a07bced@redhat.com>
Date: Tue, 28 Apr 2026 15:25:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: airoha: Move entries to queue head in case of
 DMA mapping failure in airoha_dev_xmit()
To: Lorenzo Bianconi <lorenzo@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Jacob Keller <jacob.e.keller@intel.com>
Cc: Simon Horman <horms@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
References: <20260428-airoha-xmit-unmap-error-path-v1-1-aec44c6765c1@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260428-airoha-xmit-unmap-error-path-v1-1-aec44c6765c1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: CDEC0486ADB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281879-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On 4/28/26 10:44 AM, Lorenzo Bianconi wrote:
> In order to respect the original descriptor order and avoid any
> potential IOMMU fault or memory corruption, move pending queue entries
> to the head of hw queue tx_list if the DMA mapping of current inflight
> packet fails in airoha_dev_xmit routine.
> 
> Fixes: 3f47e67dff1f7 ("net: airoha: Add the capability to consume out-of-order DMA tx descriptors")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
> index 5effb4a4ae84..82018a085e46 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -2123,14 +2123,14 @@ static netdev_tx_t airoha_dev_xmit(struct sk_buff *skb,
>  	return NETDEV_TX_OK;
>  
>  error_unmap:
> -	while (!list_empty(&tx_list)) {
> +	list_for_each_entry(e, &tx_list, list) {
>  		e = list_first_entry(&tx_list, struct airoha_queue_entry,
>  				     list);

Coccinelle says:

+/srv/nipa-builds-contest/testing/wt-cocci/drivers/net/ethernet/airoha/airoha_eth.c:2123:1-20:
iterator with update on line 2124

I guess you should additionally drop the statement above.

/P


