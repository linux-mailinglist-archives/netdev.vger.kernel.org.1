Return-Path: <netdev+bounces-212824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C685FB2229E
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 11:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7469A173C1C
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 09:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0002E7F1D;
	Tue, 12 Aug 2025 09:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U05wqZda"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE57A2E7BBE
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 09:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754990086; cv=none; b=CcH8uY181d+2/8UvVVUB7wqYk2fkLHMf1snlS1JTXTXIbczaf8fTOP/WX6l3U1eY817TATARzs1q5j/BaSrd6EP5NuXm2MzdC4xP610kkVsYNiYiazo4HdXaa1Voc3Sx7hsfa8oyJE5e+ImU5CtiXOgRkmS+KXZlzCNO9UB9oyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754990086; c=relaxed/simple;
	bh=fbkvdHbzO5iMyqUyNMSQ2ifyYq35TUmApmNBn7z38C8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n0mF25a3xHqB0ieGOahdMGBRaf5qa9RC83pQ71qIYvUPTkHVtOAkCbrdSM24vXBpHFmOPDCdl3g4C4iwijuk7fo3x85CPfp2gw3KmHDRw4b6Rgh48Ix3Wp9YzkzP4vKriedEsIoGaIQ+eqeuZRhEQy1A4fDVX5bGKkw52j5iHJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U05wqZda; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754990083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GfnH6UdWPTLsT4NE037V+5yMnBpvuJn2hgsl4bTLdLY=;
	b=U05wqZdaaFrxmbAMhoc4EWztNWUjs59w/KZ+Ku6rUz8TIh5pPHsW44pwu/vnCKScBJ4qko
	uFXj7TOAsDh9Bf9iGnv91up8j/p0yTejY3r2hQlBF8SGy1CXKBTKGt6pDhqa1Y8D/2HuNE
	+O7jG919gHynclc1RR9YD3banrM+B44=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-JbVaS0flOniJcKFoSy051Q-1; Tue, 12 Aug 2025 05:14:42 -0400
X-MC-Unique: JbVaS0flOniJcKFoSy051Q-1
X-Mimecast-MFC-AGG-ID: JbVaS0flOniJcKFoSy051Q_1754990081
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-459f53d29d2so22305055e9.1
        for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 02:14:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754990080; x=1755594880;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GfnH6UdWPTLsT4NE037V+5yMnBpvuJn2hgsl4bTLdLY=;
        b=ewaoIsmT3E3oa7775xWdGiMf/XcHu7ofhF++RZnOwysms5254NqC9SPyOVvt1TRFVU
         tTu7smbFlYjROU22x/EbNhJ85Itn8NIs6hccH4dSYeoG5YPC1TVT1U4RM38TNJi1yGEk
         at5qvJIKXRzOw+bXkcvggoN9Ksk67qvDBakNQ3VifOQ6LZCmEhYEGuhU1gV1yPFCITef
         QCaK06S5sYQ5BZzdJUitx9S+1CdqYIiLHK7OYHbR0A3mCNCKOh+1rq+c6vg4vMwdDRnY
         lwlueb0arf4Og4cWqHkm6SeXd2AKIcpFqSSvGU/nDFHPEI14y8JffwGkMCGoxEmtVwnC
         e5eg==
X-Forwarded-Encrypted: i=1; AJvYcCUhnmTlVaRug4qAZd/nSk4pmqXSreVjid6t/M3fInEmhzqSIUPEvCOcgWhFcjJTJUakaHcwVsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqqTxmpPpAgOQRPeZvhtiHUDHzqfrENFKrOZzlruNSQ8M9nCaJ
	Fzk7q3fiUL7HzXZ/Ot41X2kZA3+d9JXdhnXfCzKrB2rA6ruD1g7G/c3PitZG2+VckWb09GQwo3e
	znhj14SEf3j91YbDpWtifpfhZ9KZ5nHxMuszjZ28tbx7XNcDGf9xx9Mdlmpxon8k33w==
X-Gm-Gg: ASbGncuvD2KS41GEhFtTUG/zDELURa30gGGk/8SLOdsV5qsQdWcEMo2rHPpnRrs1Eyw
	Gkrc7xorMX9qKrdqX3vJem+LkXG6frZFuYSehSOxaxtfDfsMc4J7oSG/Mk/Ci7pBQDddp4dcMwo
	48mcdNGSfjTP1eictLlNMfTPjxupxKXNnRJKldm5A/3czf2r8FR6oMWm7eXRIOdCSGvYj+uAdTy
	Vb5iFdcevEF8UKy5oDOlJ2t06HJBQ4rwBDGLQkv4ESA7ByB05xYoS0q+2RZ6s4If5NTDWlZTez7
	ykFy+4hl8Ln2nWiFm9/837FQOC2Qede9r4upofSbpH4=
X-Received: by 2002:a05:600c:a46:b0:453:5a04:b60e with SMTP id 5b1f17b1804b1-45a10c0020amr20225215e9.26.1754990080407;
        Tue, 12 Aug 2025 02:14:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6aoDZQH3cS2UCnVzBBG1Izm2yKQoFjrOrA+8ZiuIJILKKDdscGnHzDMcfx14lN7+SN/qnwA==
X-Received: by 2002:a05:600c:a46:b0:453:5a04:b60e with SMTP id 5b1f17b1804b1-45a10c0020amr20224905e9.26.1754990080025;
        Tue, 12 Aug 2025 02:14:40 -0700 (PDT)
Received: from [192.168.0.115] ([212.105.149.252])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3ac093sm45795951f8f.9.2025.08.12.02.14.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 02:14:39 -0700 (PDT)
Message-ID: <fb08ab9f-4d15-48c4-bd2e-52077dce0b82@redhat.com>
Date: Tue, 12 Aug 2025 11:14:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 net 2/3] bonding: send LACPDUs periodically in passive
 mode after receiving partner's LACPDU
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250805094634.40173-1-liuhangbin@gmail.com>
 <20250805094634.40173-3-liuhangbin@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250805094634.40173-3-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/5/25 11:46 AM, Hangbin Liu wrote:
> @@ -95,13 +95,13 @@ static int ad_marker_send(struct port *port, struct bond_marker *marker);
>  static void ad_mux_machine(struct port *port, bool *update_slave_arr);
>  static void ad_rx_machine(struct lacpdu *lacpdu, struct port *port);
>  static void ad_tx_machine(struct port *port);
> -static void ad_periodic_machine(struct port *port, struct bond_params *bond_params);
> +static void ad_periodic_machine(struct port *port);
>  static void ad_port_selection_logic(struct port *port, bool *update_slave_arr);
>  static void ad_agg_selection_logic(struct aggregator *aggregator,
>  				   bool *update_slave_arr);
>  static void ad_clear_agg(struct aggregator *aggregator);
>  static void ad_initialize_agg(struct aggregator *aggregator);
> -static void ad_initialize_port(struct port *port, int lacp_fast);
> +static void ad_initialize_port(struct port *port, struct bond_params *bond_params);

The `bond_params` argument should be constified.

Thanks,

Paolo



