Return-Path: <netdev+bounces-260495-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +D6nMJKUnWnKQgQAu9opvQ
	(envelope-from <netdev+bounces-260495-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 13:07:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 20CBE186B7E
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 13:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4DD1F3004200
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 12:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A8838BF6A;
	Tue, 24 Feb 2026 12:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dIH+TXfg";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HEbDeJHh"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAE23803DA
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 12:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771934801; cv=none; b=QrwtDXItx64n40akDEYa3qrSjd3uXUZ3yIpllnS2UZoDQxlks+jNhe4WQffhZQh49Xhn/E79MKxHBCAAEj121mgcIuAtgECV2pFIfw4YZCLL5YpahbFZdGNpOtTtm47Bftws2ash0Y8L5eLCJJu1k/B85BKyw56/Uj6erABfaZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771934801; c=relaxed/simple;
	bh=kBZj9miGFSQFJ0YH3FJIUfJJvnx8d1aKL1JDNWIViwI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DiiqHqNv4PwEC/IzdUDJssQvSy55fJ1jgpXvN85ecplthNEa+ZJlpXaC5TQ9UFIaxT8XBjaC9pxe+n9/KtYgsTrBIGh3PGMo+8KOtgGFxEJIYc4u3+e2gm8MutZageAeASAX0gsRW5Ax33qAIlYVNeaW0pniJguWJ0FmZUr6FgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dIH+TXfg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HEbDeJHh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771934799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mYMqK1cVj3HuIDLVMmhgwBdTK896O5r5K8TYOirOOgE=;
	b=dIH+TXfgBX7fQSOS+M8GdDFkt1FRPDfWyKTadAqxhNhGBVYvCnSgImwP5787TFhuZpZ5ta
	zd7dlS5pKE2SZVL+QUXAI0FV9LdNNKTmbrl3DcAi4mpDCk6Fa7cPF+frjkITy5a48gStLX
	3ByHnyTAyXMOW63HRXQRs1vl73YcGJ0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-jlbiUPEZN66a-Fo3AaNEEQ-1; Tue, 24 Feb 2026 07:06:37 -0500
X-MC-Unique: jlbiUPEZN66a-Fo3AaNEEQ-1
X-Mimecast-MFC-AGG-ID: jlbiUPEZN66a-Fo3AaNEEQ_1771934796
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4836abfc742so36946135e9.0
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 04:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771934796; x=1772539596; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mYMqK1cVj3HuIDLVMmhgwBdTK896O5r5K8TYOirOOgE=;
        b=HEbDeJHh1GChwNUcjwZhabI0gZATiVcCydWRyXtq8pySIAAnEdJQrruUZU2auaJ4Zu
         w6n4yxsUQa4U2r9YnxIqnuD1a6y5Jhek4HVboqYze1EuvUICRYW+ajlG4zA3wtddtowp
         i/Z9xiJXib4tLMWUT2HxZakM/d1CwWPpOdXEoVbZZwheWh2dp3m//QhSdgduRVZKTFtV
         xvqX09uixQ/EFE3FxTsxehH17V2LPuDw+MSg8pbLIblhVqnBl/R3SSPi4rtXsKdFMZow
         ho/m1IZKh8z6YRI0KXWVhuhxQv8sJSFbwLFJxANZCiQ3SjtXwBoj8FWCwOW2Jn54hsOZ
         n5DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771934796; x=1772539596;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mYMqK1cVj3HuIDLVMmhgwBdTK896O5r5K8TYOirOOgE=;
        b=kEwAx2TwLeXDkdyR1HB6FA3gr34wRiXMQIm4g3img3C1k3ZAWjdNMa1HGxZ68HNxYn
         gM0lg7OWDtmXNsSbD56UR2EPscrTYHl9lTj/4a0vdKjsv4Q5HdDB81ZUe2mcWCif5ZYK
         i3vubwT8QtKKOQ+hzFVRwiJLpRqwLAAQiooHv2DSBF71BLaBaHnL2i4uE8vUzQJkZITB
         G/MWeQawvvPNoMhicVgjAymJr1lf/abuJNPNdgFdH4ZGn2cKqi0ZgVqSxKhDsPwDnx/w
         rLiskySlQblvSLbMCEPLGnPZPbjQepYo/VcVc9xQ3D0jE3+AqcYnCnnudNWNWnoEXmh0
         ihww==
X-Gm-Message-State: AOJu0Yxl3O9C7D3MN60cmh1jfcmSk1wAVTzS9KY1PnspUekI4m7P1cta
	yfGQKNklXfTvtR2J6QHhviRVdAyK7trtnpfcAMKfC5Cy1Ed54UW3Toi709d6G+uw4OUq7iOPgR9
	CuMmEC7COA2SOifxeIbBUlljWqi7/vcqUpwoVnT0cH9C4yL7+I4sWeyQ+kA==
X-Gm-Gg: AZuq6aIwMWzLJHn2NFwtbauzWFBy5HCdEX2VyImze3R/64/kEXMJLN9zDMhrtjmElT9
	wDxmg8+xDGJ6uTueslJHD+smmKQEKskWhsZA3ezqeCmKWn8DQI0i+IyAAhKXFR9cpCbUKEHatP+
	NR78OfUTcXf0LP93+kI7/g0Ve8UC4pcV/hZfciz2YSTeIdl920c7KVL7/pjx8GeG91qKmooipAR
	cqQvFfXZYSn3QOs5ssetLMcSxn2z8Tc2niGMwHiUAHnaF0muueOkicC18K1ZYfmaanObo0PkE2W
	dkP7EVDW01o5X1ds6bdRGrJ66idQGxSYzD/9ESFZgQgVeKwNpbo7TNECnSTTSkyku+ohiI2RzAX
	xDitNbBJwmfr71B4dr1Sg
X-Received: by 2002:a05:600c:3b08:b0:480:1c69:9d36 with SMTP id 5b1f17b1804b1-483a95eacf7mr181851145e9.17.1771934796402;
        Tue, 24 Feb 2026 04:06:36 -0800 (PST)
X-Received: by 2002:a05:600c:3b08:b0:480:1c69:9d36 with SMTP id 5b1f17b1804b1-483a95eacf7mr181850485e9.17.1771934795769;
        Tue, 24 Feb 2026 04:06:35 -0800 (PST)
Received: from [192.168.88.32] ([216.128.9.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970c00d0csm26850618f8f.11.2026.02.24.04.06.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Feb 2026 04:06:35 -0800 (PST)
Message-ID: <d3831e27-9d4b-4790-a7b4-74c3e87b5392@redhat.com>
Date: Tue, 24 Feb 2026 13:06:33 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] net: atlantic: fix reading SFP module info on
 some AQC100 cards
To: Tiernan Hubble <thubble@thubble.ca>, Igor Russkikh
 <irusskikh@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260223004139.1444811-1-thubble@thubble.ca>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260223004139.1444811-1-thubble@thubble.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260495-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 20CBE186B7E
X-Rspamd-Action: no action

On 2/23/26 1:41 AM, Tiernan Hubble wrote:
> @@ -992,15 +1024,15 @@ static int aq_ethtool_get_module_info(struct net_device *ndev,
>  
>  	/* Module EEPROM is only supported for controllers with external PHY */
>  	if (aq_nic->aq_nic_cfg.aq_hw_caps->media_type != AQ_HW_MEDIA_TYPE_FIBRE ||
> -	    !aq_nic->aq_hw_ops->hw_read_module_eeprom)
> +	    !aq_ethtool_can_read_module_eeprom(aq_nic))
>  		return -EOPNOTSUPP;
>  
> -	err = aq_nic->aq_hw_ops->hw_read_module_eeprom(aq_nic->aq_hw,
> +	err = aq_ethtool_read_module_eeprom(aq_nic,
>  		SFF_8472_ID_ADDR, SFF_8472_COMP_ADDR, 1, &compliance_val);

I'm sorry for nit picking, but here and later this leads a quite bad
indentation. You should reformat the whole argument list according to
the kernel coding style, i.e.
	
	err = aq_ethtool_read_module_eeprom(aq_nic, SFF_8472_ID_ADDR,
				            SFF_8472_COMP_ADDR, 1,
					    &compliance_val);

/P


