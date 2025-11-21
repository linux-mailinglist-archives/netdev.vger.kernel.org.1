Return-Path: <netdev+bounces-240723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 585E4C78953
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 11:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F2FE734747B
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 10:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636A533ADAA;
	Fri, 21 Nov 2025 10:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="gzIqciAj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192853451CB
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 10:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763722596; cv=none; b=Rm0r3/6C4ZHQyFAFXzFEYdZE0gNcanLlqYmPe98pqwvQpK/m1R5ThP7beBMAjUE5ifylFmPC/Dq6xSbkgXwYTtldfnvYxALjOCL7AqczhbviYtor4IED0OJDdcZtbMXmqSQ6HuKDn9sXwueSfg7pUMD1AGxMReDEHsUzUuUSnMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763722596; c=relaxed/simple;
	bh=2AJ/1GSmQksetn+BMiMiEJuDmPHGDBntt2UbOIs1azs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GDknEf+t3kc4Lert+82S32xZKIbWwiI7eqqFlOzYca9+6ujdczo3mo4P25/C7rwJm2kDGavR2zb4b/8EJIHtStAutHj7Vo6vviO6Jmic8rBmfuzH9bXaelCd5X304cfNkitFO0wDPk0WQZGMhLY9J2yy7sSEqSaKiZCtRSs/exA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=gzIqciAj; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b71397df721so348309266b.1
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 02:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1763722591; x=1764327391; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=P//Wm4lYmYe2NXo70RM8HR66HjWu4DiEiy4uHI2HTIg=;
        b=gzIqciAjl2pCqLatD2i0itBmVjwjnBmX8mpjil2qs8fXn+4/AXiOyb6qLHfAo7vfVF
         P30bpUuJjK5VBbB5YeV3zSMeR6XBDgz/mLUVKEI7GDxsbyUzoB2qK6Psc2c3Tkw8wLyZ
         sdm3sKVPhbaC2xZgBp90kp0htw2Nk2D8hNPYz/KGeaQI+JYbWZftqLSYBnDPNjnP1wl/
         e2lrP/trnCeoBQyZjqyrZuSErsKTUZDo/uJWrW19jz3CA7UmnV4VCaQ315Pb9pbEiKjY
         P/bWSuiDUWNlBv45/VL2TT7k/qiv9FZUlvl/xJa6CyCujYXkwoo5iHqghIbTe3pT5O7e
         bHzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763722591; x=1764327391;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P//Wm4lYmYe2NXo70RM8HR66HjWu4DiEiy4uHI2HTIg=;
        b=ga/W0zeUfplrD6bOGbkJCmAwTDDbUHqN1ohbXJQWCxvZU8GvSvtThpzwY2510ZpRcv
         bVCDYo5Uc7HRa20NABUqt2zMrMw9xE4ZqB2r8rteaWSNHTlJ2S0tkewWzp8NUsVwZuRs
         u56I6rQLwjTgOlebUTMx1ccXdMTRbk9HBAFlKTGhu2Gc3eT20YeYeOdbeh884wHzL+G3
         w3wu/qZbC6XD05pRRBksZ48N0KkuC5APMosB1h3gibZIfPmWH8e3tydIu9IiYrbzE06X
         2tDFpxdRjAzfDYbpPH7D9eteKSm11nHh4EmIa5GxnK9bafui5v1/oTSOhGVed/5ReKzx
         3jKg==
X-Gm-Message-State: AOJu0YxTVQNby9B+Hp8b3I3oIK2P4RiHnrvuQ+QhrxaohduCQE2TwUZe
	fqcNLN7RFGJaci7MbPLd1hTTt5j+GYWl30RawOfHNWRHx50MCuJ7G3CA2BznuBTNvgBVvgQ4FOi
	j4o7+2/9+vJX7/Oj3WdDJc6rs9AZfkzbs/4nmtZB08/f8I2Jb+vhdTaWUyY6hbkgZ
X-Gm-Gg: ASbGncs0DNGH9KKD7avJWIrWtK5alAeh3FavcIppPEykBwyivDH8BSnsSjt0PHAgOp3
	IG/RAMWqYBHGgidO1h/ZsdFqkh2d/lIO9V+HUlQAx8d0iNlt4h7PqttiOhUbQRb3UCAMKGIyDSx
	/DjmmkVr/fpuvnswA9WEErygMe0VDfzN1kiUqgWe0N13ergRyuEH157y+aEw5K8aTF1FF35AHzA
	0POE5Zw/iGEPEfK1g282nGoxhSMvDI+ijMwnfQgsE/04KasH28N0+UrBTR3cmw+/vFYNTdVss6t
	3/VxKK4BRI8HBEWNq2mbfk5OTSsEK4sx/v5e7YxKtUtVtn+cb4u8hU8jLbvsw0KOpbISBIvJV2k
	Hp71AAzfvpdc8klbArEshDjlu42cTu/i3o8PQWdO5yuO3SIp80IrGr6cWtlgN268nbG2lgv4wtz
	PFdP1r7Ce1zPqPcsvjiCsN9RArDtUi+V/s4C58yl0JSmKsDIYOZg==
X-Google-Smtp-Source: AGHT+IHlv2Qu20FDUlxa+R9aFr0uHdh8aR0rjq/DU86F3C7QUQxdHUbK438q04auWjtUAYthu033UA==
X-Received: by 2002:a17:906:dc89:b0:b73:6b85:1a9a with SMTP id a640c23a62f3a-b7671591ebemr182097366b.21.1763722590971;
        Fri, 21 Nov 2025 02:56:30 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:d094:6d8b:cd60:2f1d? ([2001:67c:2fbc:1:d094:6d8b:cd60:2f1d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654fd4e51sm430988966b.42.2025.11.21.02.56.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Nov 2025 02:56:30 -0800 (PST)
Message-ID: <767e0c63-a674-4f03-a893-2b6a456d1dc0@openvpn.net>
Date: Fri, 21 Nov 2025 11:56:28 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 02/13] selftests: ovpn: add notification parsing
 and matching
To: netdev@vger.kernel.org
Cc: Ralf Lici <ralf@mandelbit.com>, Sabrina Dubroca <sd@queasysnail.net>,
 Jakub Kicinski <kuba@kernel.org>, linux-kselftest@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>
References: <20251121002044.16071-1-antonio@openvpn.net>
 <20251121002044.16071-3-antonio@openvpn.net>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20251121002044.16071-3-antonio@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/11/2025 01:20, Antonio Quartulli wrote:
> From: Ralf Lici <ralf@mandelbit.com>
> 
> To verify that netlink notifications are correctly emitted and contain
> the expected fields, this commit uses the tools/net/ynl/pyynl/cli.py
> script to create multicast listeners. These listeners record the
> captured notifications to a JSON file, which is later compared to the
> expected output.
> 
> Since this change introduces additional dependencies (jq, pyyaml,
> jsonschema), the tests are configured to check for their presence and
> conditionally skip the notification check if they are missing.
> 
> Signed-off-by: Ralf Lici <ralf@mandelbit.com>
> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>

Note: this patch should come after 05/13 - this is why it fails in pw.

Regards,

-- 
Antonio Quartulli
OpenVPN Inc.


