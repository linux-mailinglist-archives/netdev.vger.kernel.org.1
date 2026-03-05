Return-Path: <netdev+bounces-264212-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EG1lCQw4qWlk3AAAu9opvQ
	(envelope-from <netdev+bounces-264212-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 09:00:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6D320D115
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 09:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 66137302F226
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 07:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A138A3431E9;
	Thu,  5 Mar 2026 07:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fnKUtjZq";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cjDiFHWp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8921345CC9
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 07:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772697585; cv=none; b=HXb4EENEG095LAHp5ulZHbkdUUHglO9Ziw8G7kkez5BymTVjwu5ysnb7UQaeSNE1IKdc1VExFU7aM6jswwv06xZx792u9xiGCM8Q0kr9ZE0g/uYTA0vJyJZj7cq9M7MpZx5pqCMYu6BESEh4uSxE0AtF6bMMQtXCwuXz/FrG7co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772697585; c=relaxed/simple;
	bh=acjX8ZRXKxIh1g9U/ctZCZrkLhEdMfO/0JcbCEv+DBQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UGImErRX61KeT82oMMUis/s0uu4g/HBo97WvbaaZg9f9tNPSoWAAPhT2H8INbZ2wGuHTlw7JG72kX8ztZ2WdXCOkyvr9hrLGvdjzBfj41rWQOQG/Zc5Ums/xzrTkd8VN9AScNR4+vVsHac8iYoLt19zW51At4BZfosTykrkQG2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fnKUtjZq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cjDiFHWp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772697577;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EA7Rrf5P3Aj91zy1UVwm367bOMnz8VCNbYx+ojgcP34=;
	b=fnKUtjZqRhjdNbeOj5Ke9q/qF37JJ7tBJTXub3LqWeXNJyzqEle/qUQcn/CuBLiH0MTOYj
	ZUTH+LaNubGQWTQiE1962oIEGZXnGD+PY2ubAEQDo/LACQAm2dB5HpxDfhk0gSKv2ykJdf
	CT7usl2MLC38WL09VueCwb44Osna2ek=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-H6bLOrKGNH2JL5pR_CH2kQ-1; Thu, 05 Mar 2026 02:59:36 -0500
X-MC-Unique: H6bLOrKGNH2JL5pR_CH2kQ-1
X-Mimecast-MFC-AGG-ID: H6bLOrKGNH2JL5pR_CH2kQ_1772697575
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-439c2a0d821so1798229f8f.1
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 23:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1772697575; x=1773302375; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EA7Rrf5P3Aj91zy1UVwm367bOMnz8VCNbYx+ojgcP34=;
        b=cjDiFHWpK7xUFdA6IPsXDW8HE71FEqFjMY52y/Nh6mvtV/cSiIdeja07MSL8/x8IEw
         LJMMnhMGa/WLwtQEnWSu/w7pakL2ug5R+/EV+CjmAT4XxHNYnr0KcnM2BFnMLGbMrRXp
         rLLd2Sox0cDqh4K8XA9jPz5GP8S06sg9uyoWgyI26isD9gHBQnAKXg+hd2pMhMbTarSe
         99GwQ3qVoFJj7fEjUSZcGuZXOQGk2H7Zh0aZPugIj2sr/aef2+PBgdULWdWCKi+eSftQ
         KngKwhn7Eqbb2IhNVKar2ZnqUhdAWQLMKKTChaalJIWZo0UBdhbppLw2H1uhg7iyvUol
         dIlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772697575; x=1773302375;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EA7Rrf5P3Aj91zy1UVwm367bOMnz8VCNbYx+ojgcP34=;
        b=q9WawLovmjFXfGqDgwi1As9Vx3Q0pzICu29VQXoTrBnph7Sqx467a8QOnYz2iOuKU3
         ItmnlctxX2Izl//owMUab2Aits6BbZtcoSa83A75kPumSVvgi4GtsUBI5td3NnFFdoJ3
         lfsof7/SmHydAlR9duhiu1EdmB2BcV6WfpjI+IgxnDdFdzUjobAAGDfNp+py+N1M609B
         M1zZINCu9dkuxa5ldJO6t4QU0/nlqemU+ZW94rvBsWAa1PocwV+QLBkdCkNNkxJhKuwL
         XglrgYMvuHNKQP3q6Tdig3m0RgXUuccilI5z9wP6CDgXK3uQIqypSPtJ1xvC7MjefILd
         u3og==
X-Forwarded-Encrypted: i=1; AJvYcCVBUieS3MYDW24WoNtNUCLWYAWIH+KQ0I6nTXOWFRiw70sakl5w/yEQo9JoF5FMIzXD6xRWI28=@vger.kernel.org
X-Gm-Message-State: AOJu0YysA/TRUixJ1BqD2aOqFq0oXGTiiXN46GxNyfsYSh8W8dXN84YX
	Y+o6QC6yBS3UXwGLnnY6LFcr3KJid748wOqYbYzQtkZzaCMnqdoJKfUTW7pmBEASBLKEDNdQ4ro
	h/LZ3uowxz9z2f/KKfVlJj6MBybi8+0PlbHSXaFCyM9721hwW8tTlRnDtDw==
X-Gm-Gg: ATEYQzyQe/QiJvDkxqG0HiDtjSmlPQeY5VArLlErPXa9nVPI6+Iih3swvTc+Bi35qUH
	fgqeMdb1oPzOR50EL2EJeMI5iEQ0H7s9D16NwBC15T65K70ZZaGaITIvhPyTlkocusQzmV+oXdA
	Ixij28DUGuguCbud7Z3wz8u61yYnKTo7VUf/zthqMhy3N2UsW9y3+Du4AltkqvOcCsdAHJIKOV2
	pj6ly89hycISGAUkPF8ZATpj1kMXQUOMmgJmofxAlboFU7eCkfhHERfqU2RDOF3kiNhPJzEyWCG
	rkOPH6JYJpTlCXl1BM4Mx1xhK3udR7YK3jDUQhUjIgm1PHaYIZ40OmuSWVkbpiEUL2c8zveXaHO
	dCs8ETrBcWGLGBmKtdNuWDO6A3Q==
X-Received: by 2002:a05:6000:24c3:b0:439:ba57:5023 with SMTP id ffacd0b85a97d-439c7fd377cmr8342930f8f.36.1772697575114;
        Wed, 04 Mar 2026 23:59:35 -0800 (PST)
X-Received: by 2002:a05:6000:24c3:b0:439:ba57:5023 with SMTP id ffacd0b85a97d-439c7fd377cmr8342892f8f.36.1772697574661;
        Wed, 04 Mar 2026 23:59:34 -0800 (PST)
Received: from [192.168.88.32] ([212.105.149.216])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439c6129017sm13041122f8f.31.2026.03.04.23.59.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2026 23:59:34 -0800 (PST)
Message-ID: <9e430669-7930-4902-ab7f-ed0b63def827@redhat.com>
Date: Thu, 5 Mar 2026 08:59:33 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net 1/3] amd-xgbe: fix link status handling in
 xgbe_rx_adaptation
To: Raju Rangoju <Raju.Rangoju@amd.com>, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch, horms@kernel.org,
 Shyam-sundar.S-k@amd.com
References: <20260305042952.835926-1-Raju.Rangoju@amd.com>
 <20260305042952.835926-2-Raju.Rangoju@amd.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260305042952.835926-2-Raju.Rangoju@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 0C6D320D115
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264212-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 3/5/26 5:29 AM, Raju Rangoju wrote:
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
> index 1dbfa9d4360d..457d6049291f 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c
> @@ -1964,11 +1964,20 @@ static void xgbe_rx_adaptation(struct xgbe_prv_data *pdata)
>  
>  	/* Step 4: Check for Block lock */
>  
> -	/* Link status is latched low, so read once to clear
> -	 * and then read again to get current state
> -	 */
> -	reg = XMDIO_READ(pdata, MDIO_MMD_PCS, MDIO_STAT1);
>  	reg = XMDIO_READ(pdata, MDIO_MMD_PCS, MDIO_STAT1);
> +	if (reg < 0)

Coccinelle says:

/srv/nipa-builds-contest/testing/wt-cocci/drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c:1968:5-8:
WARNING: Unsigned expression compared with zero: reg <

> +		goto set_mode;
> +
> +	/* Link status is latched low so that momentary link drops
> +	 * can be detected. If link was already down read again
> +	 * to get the latest state.
> +	 */
> +	if (!pdata->phy.link && !(reg & MDIO_STAT1_LSTATUS)) {
> +		reg = XMDIO_READ(pdata, MDIO_MMD_PCS, MDIO_STAT1);
> +		if (reg < 0)

Same here.

/P


