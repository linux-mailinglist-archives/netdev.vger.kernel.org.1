Return-Path: <netdev+bounces-194771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4825DACC530
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 13:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9623218942BB
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 11:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C180C1A0BE0;
	Tue,  3 Jun 2025 11:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VeNsHPWZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A562C325E
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 11:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748949452; cv=none; b=t8t4AzcRXv4K4JGnJmdqYXwErn4VA+9veqHrxZs0MxIXzyKRBNntFeFQtc8j9tkOhdUyJaakbHsLxvEHSrDZJhiAZDBrLhNoChLE73oVmtuNufh7k7NJBSiYfxsAeXmQIrgR8ceCybPz5VWh5I4Bbf/Jyv32t7isEd74x1GohJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748949452; c=relaxed/simple;
	bh=QFPlPzYOy9+vjKip3QUXt/X9+P7bR5yQLnucJxJ22N8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tlp1D5/9MYeWD83vmhfS2PVQNb2OijD0T1HcHhKghqcGY7LJMgidNdTAKHLoAiC4yk6Vcm10cXVJjencz5vY1dUJUzeL3kIuBEUwYCmsFzRslM3iVKr+isrk40zpM/lSys6I/VkluY/3rKaTPwp3WgqgKZOYOjJ064Qw4lT7ax0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VeNsHPWZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748949449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QFPlPzYOy9+vjKip3QUXt/X9+P7bR5yQLnucJxJ22N8=;
	b=VeNsHPWZT1jqFRe3d33aFxGx329IY2aTjLS2V97MEs29wCgXDY1viDhakwwzxEi+fWTAT9
	68jm0LrPDnp2cDBoiEdN3xa3wkRchsb18LoF+Lc6Sq3vy+C3e/neh/AW0fID/JnxcPjALl
	20MN7GPniYlvqo6TSgBXQBX5ptfQ5bE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-EeLDhDPhPxuOaaC5QaNQqw-1; Tue, 03 Jun 2025 07:17:28 -0400
X-MC-Unique: EeLDhDPhPxuOaaC5QaNQqw-1
X-Mimecast-MFC-AGG-ID: EeLDhDPhPxuOaaC5QaNQqw_1748949447
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a37a0d1005so3446933f8f.3
        for <netdev@vger.kernel.org>; Tue, 03 Jun 2025 04:17:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748949447; x=1749554247;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QFPlPzYOy9+vjKip3QUXt/X9+P7bR5yQLnucJxJ22N8=;
        b=EuVWBNu/5Ph3nD7BphXugzSBaZuxOgOe3cN1CUI/8AcHXtVk0HoV8BxtszN8kLPn7Z
         0JjSbOBaG4XE1doCywPF1Z7mVOkJiHUl37nQkIi0CxTylbr7zJWW95ooWPiecd5CRL3r
         e5uqrzAlApXxlinCmdBfcnD4tAQaql3I5IPbZKnc5oeBdPLgUjU3mmK+tiNwWzxz5wkb
         /GjQA05zit16tnGMY8OgdsEvqHElUTqoJdZU7HXx8Fs4ZdwO1ckKyRDVUuQisaN6Rkfp
         A+6Ow7sa5E/bHWDajGTG0XH/N6Ompk2REnLQaFdfmPYa22Cm0I2cPhd8Gm/9n0ir1uEF
         qcuw==
X-Gm-Message-State: AOJu0YznXLdmMJRCmiN+f0SUxbQFFeDzOsMwoYGUN/2hNVW0lbkAjsuB
	vacQL4tZSlWC93Wf32UW3YrEJ/QZn3/h5y9zThqu2+bFjVaK933ISWT2ff7DbIgWELqm3pDktk8
	0VgNMpMUkHF/kEyOVUcfB+4me2sCXvzOuoeGuq0Tc1S297GD6J8ETAldGOA==
X-Gm-Gg: ASbGncsPnJQenbC0sr7A/Kt/vWxjskJ2skr+i1WmoqAr6U1QqyifWt56tK+V26mZeGy
	8a6/W3jBWWH3AlqklSqTwxHBGTZSi0uuL1Cn904DeNw/WEX4VQNQpTD/2Ov89GZwmom+S+u7Cyp
	ldWy6aSZwGGkwRcjAXuQY9Q9/bNhfKQN9o8Kirgqf5qJ0Y866i9ej+RjffX0PFpabWG4AJ4dwy3
	FalfyAKnTWxYpUsDoC2Wn6aAYDWIe0X725oCJqb5nq3Mf/z1VMXmkZPvRMZ4qPQtfAiN+bQAKpd
	VoCeeX3LKLxckSLtrcABA191Wkr4Q5rHcH7YCd0ou8qgBXcR49FffXKn
X-Received: by 2002:a05:6000:2388:b0:3a4:d939:62f9 with SMTP id ffacd0b85a97d-3a4fe3936ddmr9924191f8f.31.1748949447428;
        Tue, 03 Jun 2025 04:17:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgHkfoSSvodaKiarQ8d4Om1K+dozYk7SljBPcJ37SJ+JrlXuJ7W8CXUiisgniU4ysWii3mJw==
X-Received: by 2002:a05:6000:2388:b0:3a4:d939:62f9 with SMTP id ffacd0b85a97d-3a4fe3936ddmr9924156f8f.31.1748949446990;
        Tue, 03 Jun 2025 04:17:26 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:cc2d:3210:4b21:7487:446:42ea? ([2a0d:3341:cc2d:3210:4b21:7487:446:42ea])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d8000d1fsm156897935e9.20.2025.06.03.04.17.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 04:17:26 -0700 (PDT)
Message-ID: <bc91b431-9cb5-400a-afee-f5cbfda11788@redhat.com>
Date: Tue, 3 Jun 2025 13:17:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] selftests: drv-net: add configs for the TSO test
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
 horms@kernel.org, shuah@kernel.org, willemb@google.com,
 linux-kselftest@vger.kernel.org
References: <20250602231640.314556-1-kuba@kernel.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250602231640.314556-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/3/25 1:16 AM, Jakub Kicinski wrote:
> diff --git a/tools/testing/selftests/drivers/net/hw/config b/tools/testing/selftests/drivers/net/hw/config
> new file mode 100644
> index 000000000000..ea4b70d71563
> --- /dev/null
> +++ b/tools/testing/selftests/drivers/net/hw/config
> @@ -0,0 +1,6 @@
> +CONFIG_IPV6=y
> +CONFIG_IPV6_GRE=y
> +CONFIG_NET_IP_TUNNEL=y

I think the above it's not strictly needed, because it's selected by gre
and vxlan (indirectly), but it should not hurt, nor I think we have
minimal non redundant knobs list in other config files.

/P


