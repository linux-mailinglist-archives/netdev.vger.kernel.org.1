Return-Path: <netdev+bounces-199480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7575AE0761
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 15:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C728A1BC6B46
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 13:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E6E285CA2;
	Thu, 19 Jun 2025 13:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zz5Y/5kT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FD92857C6
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 13:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750339919; cv=none; b=tzPHSjEYWRQKumgGu/P0JNRx60D9/kAfs+pbmEkbKxSJTxiJ1wOtMsXPYlhYEQw1NEFKh091mn2jGPT1tflK6YDIJAbdVFq1r331t8K/fMElq2FV0CuxYeOcjpzLnD5YTyOL7V+VktsOrkqSPLbQxoDDB12nDhsvsnxUHtLXBm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750339919; c=relaxed/simple;
	bh=58h5imDC7ZrrPkpgEZ1cnX/LOaZihO2vJOJXwQrC1K4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sf9Hu8Nrfc76rzQ0Eyi6We9faalFlEhIdpFYytAVkuutuI0+cLDozB1K0CEIuFbaqsFDnHyiwCO5aZVCT7DS/uvrcJaKIzsVso0DPROMtpiB6hSvBh1d6KwMXAJT2rkWph59crAANNma069hwNpYA8146gvotw3tvkpsoSAa1a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zz5Y/5kT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750339916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2ui7iuNFkji97PpY0o0kkzp3bgZhOJ77VICnb2WH3aw=;
	b=Zz5Y/5kTg3N+RRS7C0GdovUWE7nm0f6izkejif89syshModPz4bh+62q+th4cdo7nG2vMV
	biA5AeVgRvbPewfYFmBkcj14xEX9Tsly7TQx2KFQCegx4KBkgHZaAjp9d48U6VFRNckEJG
	nYV0fkofmo0zyBb8pKrMw9GXWkQcJvw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-B7qeKYKePiSCMG8qCe_2cQ-1; Thu, 19 Jun 2025 09:31:55 -0400
X-MC-Unique: B7qeKYKePiSCMG8qCe_2cQ-1
X-Mimecast-MFC-AGG-ID: B7qeKYKePiSCMG8qCe_2cQ_1750339914
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4f6ba526eso537506f8f.1
        for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 06:31:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750339914; x=1750944714;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ui7iuNFkji97PpY0o0kkzp3bgZhOJ77VICnb2WH3aw=;
        b=tsWJojujZkXhka2XQlRHQ4jMh/xT0CbjziIUGy7IwQZNl8d+Xs5PdbTpzSMfadjJji
         DlYpClf3V2eecK+Xfif7NPocM5pNfoaBlcTHGWWEtsZP6bh1+9pIDF0xRvFuv+i2RJNx
         o0sFMAVOBsdgh3fQGNpkE1dhDJvxD980AwWXdT73CjPKKGyWGtpT0ScncvulrBNHBBDF
         GEhKYh9gUYOU3BVHj037OizcqajQLbY0RossHhzrZMcUgdASM/kYWVqy/SxiEKo5Vq0T
         s2LK8QFaUOoNKhpyL3ECrjkgOYCGvwNNafVgMtuToaRCuOqRJk8BsQu610HCK0hRKBi5
         AfNA==
X-Forwarded-Encrypted: i=1; AJvYcCXcf0t0ICOxaZOBtFJqol+pfsOuXG4texfoSy0Wxb/GKIWtQ8zDaMugLZOHVccXGDwwD3MigiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOmt/car+CXCwglJ4+7ZHWS8ug3oiZRRXjLfzfXc5FUTYmKp5f
	gO6He9wpWCJs5MrsI2fzcJZCS6SNq1MNdDi3FY7AgrRMPMmMfbfuvZMun7fBNmaHCRaNLCvQRUo
	CdHf30NiDy4qT1aS7D/BO/33Xc6xs67MQ1ksO47mTPVq+cMv6+8P89lbJcQ==
X-Gm-Gg: ASbGncvHSR+muTMtMcujpX6keBrBn3kdoPZeqpupfWlGYiApg/QlZbC9FplRJhznQSU
	p0sVeOHFRSUKG+l8oLyVKpE+/csChg/1LUIkNwHY+eJ9swbEILloZe6ga/9N4e//teiPes0g7GV
	OBEFKXYyuYkpYMUyD7HAKQcTQ5Z63cbzDLrNEnRHSLP/p02HdHYv2/y/suLz2RvyxiVe7laryt+
	AGYmjnHlyTILp6QtZala1vj07zamsgLYUZpv5ZniHrSBxcy/YeE+OpnlYZiuA2C3oYRU5CcUXHS
	H81G0S1k4wDSWYhF/XWy2+RW3LgelA==
X-Received: by 2002:a05:6000:2c10:b0:3a4:de02:208 with SMTP id ffacd0b85a97d-3a57238421cmr19272195f8f.25.1750339913667;
        Thu, 19 Jun 2025 06:31:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVhGNFKW3ALWTi5xSlMwt2bEs7W3Vj5fuffysenqbogYTxJnEpoZeK2Na4qQBfJZCcWXf7aw==
X-Received: by 2002:a05:6000:2c10:b0:3a4:de02:208 with SMTP id ffacd0b85a97d-3a57238421cmr19272141f8f.25.1750339913200;
        Thu, 19 Jun 2025 06:31:53 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:271a:7310::f39? ([2a0d:3344:271a:7310::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568a5405asm19917318f8f.13.2025.06.19.06.31.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jun 2025 06:31:50 -0700 (PDT)
Message-ID: <ead7487d-005d-4e04-b208-38c5f3b28cb3@redhat.com>
Date: Thu, 19 Jun 2025 15:31:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: lan743x: fix potential out-of-bounds
 write in lan743x_ptp_io_event_clock_get()
To: Rengarajan.S@microchip.com, aleksei.kodanev@bell-sw.com,
 netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, Bryan.Whitehead@microchip.com,
 davem@davemloft.net, Raju.Lakkaraju@microchip.com, kuba@kernel.org,
 edumazet@google.com, UNGLinuxDriver@microchip.com, richardcochran@gmail.com
References: <20250616113743.36284-1-aleksei.kodanev@bell-sw.com>
 <d44ccb0adff01e9d36370b705dbc0b0a4fbc4ed3.camel@microchip.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <d44ccb0adff01e9d36370b705dbc0b0a4fbc4ed3.camel@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/19/25 12:39 PM, Rengarajan.S@microchip.com wrote:
> On Mon, 2025-06-16 at 11:37 +0000, Alexey Kodanev wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you
>> know the content is safe
>>
>> Before calling lan743x_ptp_io_event_clock_get(), the 'channel' value
>> is checked against the maximum value of
>> PCI11X1X_PTP_IO_MAX_CHANNELS(8).
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
>> Fixes: 60942c397af6 ("net: lan743x: Add support for PTP-IO Event
>> Input External Timestamp (extts)")
>> Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
>> ---
>>
>> v2: Increase LAN743X_PTP_N_EXTTS to 8
>>
>>  drivers/net/ethernet/microchip/lan743x_ptp.h | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/microchip/lan743x_ptp.h
>> b/drivers/net/ethernet/microchip/lan743x_ptp.h
>> index e8d073bfa2ca..f33dc83c5700 100644
>> --- a/drivers/net/ethernet/microchip/lan743x_ptp.h
>> +++ b/drivers/net/ethernet/microchip/lan743x_ptp.h
>> @@ -18,9 +18,9 @@
>>   */
>>  #define LAN743X_PTP_N_EVENT_CHAN       2
>>  #define LAN743X_PTP_N_PEROUT           LAN743X_PTP_N_EVENT_CHAN
>> -#define LAN743X_PTP_N_EXTTS            4
>> -#define LAN743X_PTP_N_PPS              0
>>  #define PCI11X1X_PTP_IO_MAX_CHANNELS   8
>> +#define LAN743X_PTP_N_EXTTS            PCI11X1X_PTP_IO_MAX_CHANNELS
>> +#define LAN743X_PTP_N_PPS              0
>>  #define PTP_CMD_CTL_TIMEOUT_CNT                50
> 
> Thanks for the update. Changing the LAN743X_PTP_N_EXTTS from 4 to 8
> looks valid here.
> 
>>
>>  struct lan743x_adapter;
>> --
>> 2.25.1
>>
> 
> Acked-by: Rengarajan S <rengarajan.s@microchip.com>

Thanks!

FTR, I'm applying this patch to the 'net' tree as the issue is present
there since a while and the change itself does not fit net-next IMHO.

/P


