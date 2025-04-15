Return-Path: <netdev+bounces-182822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A43B0A89FC3
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 15:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 558423BC749
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 13:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6408A17A2EE;
	Tue, 15 Apr 2025 13:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="alAQXHpm"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB43815573A
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 13:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744724605; cv=none; b=hwcAKPruNR968yViAXezz2hoB0wekl1X8dUh3E2u2mLDuG5a68TGRW8KFspEdDqv01mNrBptyuspzoKkYZ/4RprFqz1ksiqk+BY+plbXi/vBHb0D6gvPxgy8wsx/9STbbumf7cP99VzusqI6Z7CjUJTBErw+sAiM/uXekZh//E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744724605; c=relaxed/simple;
	bh=Kr1AFDD5BTer6jIrOh1jS8j+MJa8b+J/by2OIVffdRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m4jP+RwPv6rhRQM0UngDuKeBUkjPJMnjg0i0VdU3Za72bvERsKHhvXLsYRJnnvrtQ8AAdSVgm+MYTk42dxGJNvPTZFC68I8wrg74cMzShOY3++PlFJJCf0NeAtIo62NL2YVbMn/GUuCfaxxwriCV86g3ovm16pCLo3wxTpZ5fyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=alAQXHpm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744724600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/BknlwHAWOUIUSD2VyjY9YAAgdtDCJlgRixChgK4ykw=;
	b=alAQXHpm6q7vB3vlrIfi04Cz5+LYp0S/EVncI2bIVPU02L8MlVrt4UAhk27E4JKMAPwxhs
	6k+TDMoYps2stPdSVulH2BIBBxRElsqlYNBks5jxWsY+nbBmdDt/43w6C4hAqr9iHdDu8Z
	zpZSilMmlt9BXbVOnIz9+RGhK+yQxNk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-ncZ9SxQBO2yKbaKTLjf4kA-1; Tue, 15 Apr 2025 09:43:19 -0400
X-MC-Unique: ncZ9SxQBO2yKbaKTLjf4kA-1
X-Mimecast-MFC-AGG-ID: ncZ9SxQBO2yKbaKTLjf4kA_1744724598
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-39c2da64df9so3216497f8f.0
        for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 06:43:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744724598; x=1745329398;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/BknlwHAWOUIUSD2VyjY9YAAgdtDCJlgRixChgK4ykw=;
        b=q1xGkwvS9ruKeaqngL1yIqovypsJ2ZFrQAx+nyNeMwct2U8CZAVadbizxcteLGHJdZ
         xU48Rxnq7r1KALxwh1nT8drShM5c3yQTwSooUhQ7SeixP3VIqfoSEMGq268I2QPUskUS
         YIYtijMFz2cmcjvF8YYt7AlnTZ1zYTjCAHLuJj7eBi32SEhoUMIFirazDXrUWZn7c8IW
         rHp5AAkDVa5vw7V4W8CHjNv9S0lPm5om0jpaHZHdUdd6sofyr3jmvFFCUZnPrP2o0LBJ
         qP+Bqn42wkRpP75KHya5KzEvXiggDytqpaxUmPOz8nGL+d0R9MyXJFQ4KVZlMD73eju5
         UWoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzoix60NUq/RnkxcWiAM0V6cDsO8iBee6v5DZhGXV2tpsc+Y+jV0YWS5jwWVmY7uUsH69h5l4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUD+jp7L6rmn1wLjL/v7ogU8tXheJUYexSjidsdZzeqwlQGkZh
	GEyw2TrarSvCM9w5QYGC3NE+rThaSGBt3slzKVttDUggF0I/qwmX5D+FrIHM6iPZc2sbMPZE2X2
	/AoO9O08IDLJdVJkr6WJGgxDC/HTdPh1wnpn32dawGZIe3sVfwE3W9w==
X-Gm-Gg: ASbGnctHNdqvXjol4IhtWyRfZtNqEFrz8Z74Znt2SGUxVrCG7+DlEj7QejXkP40y/IC
	9kJb6Sunu7BmsPAKX7KvbZjVszsGEZklfjV6qe7eDEaqMkdiRzJsyom0WSMryaLwmXYDVoWOAcj
	ISAJC/BPP6gWzJVUGdXVxK+1b0+OHYJomjPQCZj0KcEIwnEAE/1x+xURPlKfPCBq/08t/t+bpKk
	FqWx0SjiJlwuMor8owCNgqxyWV5VqAhgqd2x+pNfsvkcKYegfChp2Z2d5S4B0xZuhuf8hqHZXut
	fHTjTk2lyWrROMZ2xkMqdigybRJ4lcfRMzxVo14=
X-Received: by 2002:a5d:59a3:0:b0:390:e1e0:1300 with SMTP id ffacd0b85a97d-39eaaea4548mr13282364f8f.33.1744724597991;
        Tue, 15 Apr 2025 06:43:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0JyZk7iu1Ps9aWjZNEP8lEOiYdz+v1T/ibFseJb/dw7p9p9LOXvKaUssvdPPF8RDwWIrTgw==
X-Received: by 2002:a5d:59a3:0:b0:390:e1e0:1300 with SMTP id ffacd0b85a97d-39eaaea4548mr13282344f8f.33.1744724597586;
        Tue, 15 Apr 2025 06:43:17 -0700 (PDT)
Received: from [192.168.88.253] (146-241-34-52.dyn.eolo.it. [146.241.34.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae96c02esm14065754f8f.23.2025.04.15.06.43.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Apr 2025 06:43:17 -0700 (PDT)
Message-ID: <4ffd3630-bc75-47db-b63c-3dcb7af8249c@redhat.com>
Date: Tue, 15 Apr 2025 15:43:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 06/14] net: enetc: add set/get_rss_table()
 hooks to enetc_si_ops
To: Wei Fang <wei.fang@nxp.com>, claudiu.manoil@nxp.com,
 vladimir.oltean@nxp.com, xiaoning.wang@nxp.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org
Cc: christophe.leroy@csgroup.eu, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
References: <20250411095752.3072696-1-wei.fang@nxp.com>
 <20250411095752.3072696-7-wei.fang@nxp.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250411095752.3072696-7-wei.fang@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/11/25 11:57 AM, Wei Fang wrote:
> Since i.MX95 ENETC (v4) uses NTMP 2.0 to manage the RSS table, which is
> different from LS1028A ENETC (v1). In order to reuse some functions
> related to the RSS table, so add .get_rss_table() and .set_rss_table()
> hooks to enetc_si_ops.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
> v5 changes:
> Add enetc_set_default_rss_key() to enetc_pf_common.c and use it in both
> enetc v1 and v4 drivers

Note for the reviewers: this changelog actually applies to the next
(07/14) patch.

/P


