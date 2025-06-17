Return-Path: <netdev+bounces-198508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CABB2ADC784
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 12:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D12017157C
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 10:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A150C22331C;
	Tue, 17 Jun 2025 10:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="frhhjLd6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202512BF012
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 10:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750154782; cv=none; b=SivbI4g6v4u782CHUp1xH79nPkkp8/XuDXm2uhzLbDrZPfVM+a+367QB6cPaGfXlfGii32qMaOgfZonfPIyHqnk63TsaBWaSg+6jVfkmhggtPuWfKBukZdQJhpLMw0CXLe0ag2k+t7Ld/bYzX0FRO56wsPALTX4Tc95hBqyarE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750154782; c=relaxed/simple;
	bh=0VMBpaiUJjAoctJUDdlKV8m9axq2ZpB6MRA4UuRHZTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AjjZ4uAjMwiL01gNFZdIsbBrYgHz9T0pApllUp7V3sJTtyx2WmuzhDFf+PmqNKTVj3Px95CQXROfW0LOkOKJhGO+ZppvIzJ2WzPUzad9hyCsbxBZg+FuXnlli9LSgG+W4229wjiV6BR2L3vMuMzVdSSxaEzSB8ZUUMxBwsxcMvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=frhhjLd6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750154780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0VMBpaiUJjAoctJUDdlKV8m9axq2ZpB6MRA4UuRHZTo=;
	b=frhhjLd6zC5C25jREV4PehDp+hhlMv5FM/cyhyKwNM3AtUflgKDphkiscId27pIIa7ySMH
	Cd3qXvu1wk5IVAvfmqyBMCEzGPrl9RIy1aCsJtTi+YsIcDBdX6Vf4VxDv8f/0jLRZ7+Xo0
	G0gpSw0Su9QwH2T2Mji/DFn5kG+5seM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-437-B1K2nCl4MwSQjgLCqADxgQ-1; Tue, 17 Jun 2025 06:06:18 -0400
X-MC-Unique: B1K2nCl4MwSQjgLCqADxgQ-1
X-Mimecast-MFC-AGG-ID: B1K2nCl4MwSQjgLCqADxgQ_1750154777
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43e9b0fd00cso3223395e9.0
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 03:06:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750154777; x=1750759577;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0VMBpaiUJjAoctJUDdlKV8m9axq2ZpB6MRA4UuRHZTo=;
        b=XNZ9/IlNaox/S0rVL+k6nlV94G8nNDfwC46QEgYD4WTohQ3lx24voUdO/MoPrdbmUI
         5suZebqwC0kD5M0vTnLZdSBcJ3ywjRl/T01AYdrY+E9ovH0mO5e51zu/fFosVZbS3qS4
         pmY5U4PgxluUFyHpEl9NHb9jo2PPY6trmt/iWIr3Y7F6Z17J6WLSuehWZBGvN6C2+mC9
         KgEK1WFymBs3v5c65kiY7ufCGRalHvqhqMXSlcLdf9Qdb0Io2SZv4xQNpGmqz+rT0/io
         UQ1B+XnPAwfCjA7HKjP3QGWJIKP7kq8Sl58jrLOGSSskck5QIvVaAagn+S5neYlDGcKw
         k5vg==
X-Forwarded-Encrypted: i=1; AJvYcCVZVBS1WHNQBqwW9qjcNXjxA0dt1MQ32aObbIsc/n0ozC2tk6Y1dbD3G6/ymTVbdvc/zp3OyPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMA0CTyGm0xcSMoloErEBRsc0C6eV9IpicLOn3qNEU5NcVDlrS
	eq4TEm34/7ZlqTmm4O8e6EkID1iqVqKT7QZvwmmCUTFLOnIvog/vVZWQUOq2p5baSo0LD/xpypG
	DhSQDlc0yLn/A/qSKagV1cYMTDNmZ2HvBuaZuVHgGAZyQbTdZrSRIQA/qBg==
X-Gm-Gg: ASbGncvUj74oncQbzdwYgPhd47V7S7osuIoVN2zLExmR1zIufgO0SQ1+D40/9QxRyps
	n+uGR9OhSfPaM9EaoCJY6wTfYcggqf3GQ78Qu4H/P2TL92GAKQnwTCoLQ7zA/rOzTW8hIGu8AaY
	3KHqnzKPbIwVVV7yXmjp1nhJ0ETJhxXBt7UVCIlvCgv49DZAgvbiTEyZoVNX/X+Uy8JN4lx1ybc
	1ihjCnIMx10xNG1Rj0zHQLnUqc2zisAYJ5MJXuO999bHdZMx9D0DjkbQF7YWrjt0dTbUQnYygEL
	jGZjWLFqggxaJOlSUx3g5oZ39c0R2rW/DGpjnZx7IGZf+BadMSW6jq9sYUIkC1lx8hA0Lg==
X-Received: by 2002:a05:600c:37c5:b0:43c:f509:2bbf with SMTP id 5b1f17b1804b1-4533b28aa22mr134222765e9.15.1750154777069;
        Tue, 17 Jun 2025 03:06:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3/5JLnLHNirrPfF2rQzYp5invZNQiy1GUFJpBMxahMeILMv0OxZGyr9kO0/5EtZr33CmliA==
X-Received: by 2002:a05:600c:37c5:b0:43c:f509:2bbf with SMTP id 5b1f17b1804b1-4533b28aa22mr134222455e9.15.1750154776678;
        Tue, 17 Jun 2025 03:06:16 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2448:cb10:3ac6:72af:52e3:719a? ([2a0d:3344:2448:cb10:3ac6:72af:52e3:719a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532de8c4e8sm168701265e9.3.2025.06.17.03.06.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 03:06:16 -0700 (PDT)
Message-ID: <26b0a6cd-9f2c-487a-bb7a-d648993b8725@redhat.com>
Date: Tue, 17 Jun 2025 12:06:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/7] igc: add private flag to reverse TX queue
 priority in TSN mode
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Faizal Rahim <faizal.abdul.rahim@linux.intel.com>, vladimir.oltean@nxp.com
Cc: faizal.abdul.rahim@intel.com, chwee.lin.choong@intel.com,
 horms@kernel.org, vitaly.lifshits@intel.com, dima.ruinskiy@intel.com,
 Mor Bar-Gabay <morx.bar.gabay@intel.com>, davem@davemloft.net,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 kuba@kernel.org
References: <20250611180314.2059166-1-anthony.l.nguyen@intel.com>
 <20250611180314.2059166-6-anthony.l.nguyen@intel.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250611180314.2059166-6-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/11/25 8:03 PM, Tony Nguyen wrote:
> To harmonize TX queue priority behavior between taprio and mqprio, and
> to fix these issues without breaking long-standing taprio use cases,
> this patch adds a new private flag, called reverse-tsn-txq-prio, to
> reverse the TX queue priority. It makes queue 3 the highest and queue 0
> the lowest, reusing the TX arbitration logic already used by mqprio.
Isn't the above quite the opposite of what Vladimir asked in
https://lore.kernel.org/all/20250214113815.37ttoor3isrt34dg@skbuf/ ?

"""
I would expect that for uniform behavior, you would force the users a
little bit to adopt the new TX scheduling mode in taprio, otherwise any
configuration with preemptible traffic classes would be rejected by the
driver.
"""

I don't see him commenting on later version, @Vladimir: does this fits you?

Thanks,

Paolo



