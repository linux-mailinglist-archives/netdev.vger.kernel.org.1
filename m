Return-Path: <netdev+bounces-199405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C74AE0299
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 12:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91EB94A0040
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 10:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890B6222578;
	Thu, 19 Jun 2025 10:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xp8hvEFf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF67221F05
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 10:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750328791; cv=none; b=dDpVpeESZmeVkW2OmpOAwDuwf6w3GRA2GCb6/m/xhfwzwgyrAhBwfRUE/V38BNPyZMvNhzIxJ2hr00U0oPEzKI7daZqM2mH0dxYcGY+H2MZpPyydsyikUsAqoIFYChOoY6gJRuxwQRdLmrHIWF1dN4opfYGlDPxRhv7Sc6pRpOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750328791; c=relaxed/simple;
	bh=uIkR6jBLvHVVu+t7vvNakNoTzduwd0/oSjyURQUiH7k=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=NmJYUv8q4QfiZxE5CGK7aE1okZv84XHPwOWlKb2b0iAxWTsygyeLBVXCJTa1nDsmmyy/oHpPgAi6vcq0JdhEFThmp8Yh3ZLjlQVEK5MK9wkTKs8xGG/aBY1ORkbAx4qcrVjGFuGqtxPZKBCMlUA72VDb0MzWium9z3wG4d5W6pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xp8hvEFf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750328788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OP3jCXVT1xG5YLm4tZwT7KKfRcEV9RnIaEZyJGpzLg4=;
	b=Xp8hvEFf6m8loejZn5cJfuoIGqYAARfv+80vhNNqQuM8x1O7AloOu21Vukzh7tKiSBDipq
	ppQP26tivEnPlZ0QjduIU6rErEexHkWclzus0mI8eaQvyDX+uuUmMJUEetOv1S2oHwSpG7
	p+4xPibgs6u9MsKzX1Z1OxGw6TtJOBo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-475-SQq3BM0UPoSIFRCVS1DwIA-1; Thu, 19 Jun 2025 06:26:27 -0400
X-MC-Unique: SQq3BM0UPoSIFRCVS1DwIA-1
X-Mimecast-MFC-AGG-ID: SQq3BM0UPoSIFRCVS1DwIA_1750328786
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43eea5a5d80so3680685e9.1
        for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 03:26:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750328786; x=1750933586;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OP3jCXVT1xG5YLm4tZwT7KKfRcEV9RnIaEZyJGpzLg4=;
        b=ok5TsPhSRE5yyNCW/slazm6dyqS3KSUx1WHJ6Lnao/bplUxM0075q/to+S/mQfvJmG
         xKuUJEWMpXAsbFiOGFWQnDU00VMDJyneY0QMfaE+IwrU1yEaxZdT2h/RgPomhf4+agt6
         jvhrMbI/sF8fraE2a9cf6tkCH/r65i6+Jbaui/clvSaBC9/cf8YOquIZOiAFV3FHmWJq
         6bPwCTFEfNZagDnA/DRtluqJvhud+r+nXlYTsCqV/LPtFw+7qoPoTa0iTZLiCdsPId15
         cdKe/WTqNlE0q6fmnWQNhF+rBhKSpjFB0Q+DdW2H5Q58Rs17E7ozHf0+FVU1jAf9lxd5
         BrBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVu5HDRaSnf/Y7+qLgc8OJmJ8fzOClWlvO2rDF75TMFVVw4EGDxaTd8JR0i63biIi3UHjRQ8Tg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGSPZsJsANp6bX2C+jsLz2L66VoHG//phc7XOwkvPucyEWzAWK
	egMcFvyjSfwxGkBfGqeWTkgOknqTLjD0z1PQH4Ib76JNVFDbT252BykHkZxE8/mKBtX/Q4+7kd+
	IjGH3X3rx5Ozybqu6GyhInuhnWyBb298wcf1iJ+Z0F2B6xmxXDYZAxHme0Q==
X-Gm-Gg: ASbGncs8b6NJaT8HN1kU2OpCFM2Pzywg0tlkld20AwGtdw6KG8s9sMjMsJL1322s9H/
	kgIDGrciZJ395OZHzqGO0nOXEf20GH2RKjmer6H7BsiKPvR8/Yh0/8UgSEg1CMbWvXzrWo6ITey
	sYkN+O++bSLLCKqiv/1BkgFSGTB/FHF3j0htTa0IhVKZ0WadRRQ8fuzEfdRJgAgMVAbjwNAHxJu
	tsTfW6mlAmFU9OKFrIpHurlA7MnBeM5fL4Iirt6J3goK4n9gQZ8RDt7G6MN/R/lsEh/nFet+KBl
	Qrb44X2XzJnawu9sRwdWJ8BUtc5XLAeCwWCMy+Q0ywA2lRJQsaV1bd6smAfjTf++xvLbpw==
X-Received: by 2002:a05:600c:1d06:b0:453:c39:d0a7 with SMTP id 5b1f17b1804b1-4533ca7a286mr175812815e9.5.1750328786258;
        Thu, 19 Jun 2025 03:26:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFjtjLrSWYLK97IRqG4e85+6HQ/14bjbSoySDhs2GmA9qzWZgLZmuL0UN20NK+uIgY+VKlqRQ==
X-Received: by 2002:a05:600c:1d06:b0:453:c39:d0a7 with SMTP id 5b1f17b1804b1-4533ca7a286mr175812555e9.5.1750328785837;
        Thu, 19 Jun 2025 03:26:25 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:271a:7310:d5d8:c311:8743:3e10? ([2a0d:3344:271a:7310:d5d8:c311:8743:3e10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535e741757sm25911685e9.0.2025.06.19.03.26.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jun 2025 03:26:24 -0700 (PDT)
Message-ID: <f343fc9d-b3a3-4dbb-9a9c-242b7b79b97d@redhat.com>
Date: Thu, 19 Jun 2025 12:26:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: lan743x: fix potential out-of-bounds
 write in lan743x_ptp_io_event_clock_get()
From: Paolo Abeni <pabeni@redhat.com>
To: Alexey Kodanev <aleksei.kodanev@bell-sw.com>, netdev@vger.kernel.org,
 Bryan Whitehead <bryan.whitehead@microchip.com>
Cc: UNGLinuxDriver@microchip.com,
 Raju Lakkaraju <Raju.Lakkaraju@microchip.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Richard Cochran
 <richardcochran@gmail.com>, Rengarajan.S@microchip.com
References: <20250616113743.36284-1-aleksei.kodanev@bell-sw.com>
 <6a6eb40f-9790-460b-aeab-d6977c0371dc@redhat.com>
Content-Language: en-US
In-Reply-To: <6a6eb40f-9790-460b-aeab-d6977c0371dc@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/19/25 12:04 PM, Paolo Abeni wrote:
> On 6/16/25 1:37 PM, Alexey Kodanev wrote:
>> Before calling lan743x_ptp_io_event_clock_get(), the 'channel' value
>> is checked against the maximum value of PCI11X1X_PTP_IO_MAX_CHANNELS(8).
>> This seems correct and aligns with the PTP interrupt status register
>> (PTP_INT_STS) specifications.
>>
>> However, lan743x_ptp_io_event_clock_get() writes to ptp->extts[] with
>> only LAN743X_PTP_N_EXTTS(4) elements, using channel as an index:
>>
>>     lan743x_ptp_io_event_clock_get(..., u8 channel,...)
>>     {
>>         ...
>>         /* Update Local timestamp */
>>         extts = &ptp->extts[channel];
>>         extts->ts.tv_sec = sec;
>>         ...
>>     }
>>
>> To avoid an out-of-bounds write and utilize all the supported GPIO
>> inputs, set LAN743X_PTP_N_EXTTS to 8.
>>
>> Detected using the static analysis tool - Svace.
>> Fixes: 60942c397af6 ("net: lan743x: Add support for PTP-IO Event Input External Timestamp (extts)")
>> Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
> 
> @Rengarajan: I see you suggested this approach on V1, but it would be
> nice to have explicit ack here (or even better in this case tested-by)

Rengarajan email address is bouncing. @Bryan: same request as above for
you (or any other person @microchip).

Thanks,

Paolo


