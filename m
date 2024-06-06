Return-Path: <netdev+bounces-101527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B28A8FF358
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 19:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 421BA1C267CE
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 17:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF414197A65;
	Thu,  6 Jun 2024 17:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="JTW1IhxB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F457224D1
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 17:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717693697; cv=none; b=aA5XHwF/Uj17lajKxS+ly4io0t/F8iFkoeL8mlzDU3aRlqIMPbPIn5i4+uxzNcBkRCasBE9RX7SUXR/oEmmeZ59s6o8QgompoDR3d1y4iHsqTsKj4bGZGzx2Ryrb+53+HX107dd/vcaB2+ksa88Fwn6nRVWWj4Zg99HYEdu/1w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717693697; c=relaxed/simple;
	bh=HhuREidpeDZIjqanHYYCw1AcjSu5xag0UCnfYNizaQk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fWSFBfXqmM/dyW/h+LZz4dXlXtwvtPqosQ9L9YXDgrL3VWDxON4qCHiRbx1UbRn+aCZ5EdpHGWB/MDvSxnswALUf47I0qLkfw1+G4s55+4IUBB8+IrqYSsj2YRfXS8Hdu8fOzNbUPSvgkY6MyqHU35MJwZxxQ4HPtjeFdkjQtZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=JTW1IhxB; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a68ca4d6545so224838766b.0
        for <netdev@vger.kernel.org>; Thu, 06 Jun 2024 10:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1717693694; x=1718298494; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8E3aKAMaoq1Kv3SjNTexFs5pDtsngECp0LJJhNopW0k=;
        b=JTW1IhxBAdynvsIDd/OW9f8WQVgi6MH2dvLKGKeZdkds28BBqzqQTL38BUMiHL7Fzw
         f9t1DUoadFr5batnSb8GxHQj2S9o6fhMDVnWu8qCHYhM81ZgO8mUgszWh5ipJ+NJdpoa
         hisj5+4TM3QgsMVo8Anc1qrNgzBjV3jouLuDr6h+iv0JUmtjewxwyg5xwd/U4OzoJPT/
         00XeyCiGsJajnB/kLu09jHzyaQU3yDxXU3a1MDXzEBtVlX0L3eowfavzoLD/+YmNh4K0
         Y0a9PIRJOvv9PZUJCnMiYIczUF+PzWvHMvZk1DFOh1qYNplcGAUA4CfY+a0WdrijdNVm
         WXfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717693694; x=1718298494;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8E3aKAMaoq1Kv3SjNTexFs5pDtsngECp0LJJhNopW0k=;
        b=HPEOAiwZWkSDxwFScY5/I/hbYfoe4GoO+Plsqa+8EtNR4iPDmqZuPSFwaQtOxB1Ojd
         AiaLd12cJfte7L2FQzX5adKnH612RzVNuYLtsUym0UWRpRxISCC2UnT2FSrEgKNsZ8RR
         qy5Uny/TV/XhFkJWK3NvXLG3EjOqAp95umfXYvOmana/oz5Meupd4HEIzwL19gnH8l82
         XujsB0dmVSVr0r7pk3AH8CNgnrM1Nchof4EF+GiUVb4GTn6LSVvc/Er52qqtBqK06EUo
         vxkexGOf5T1y8GTv+OUN0C1P6sBsRQlS2ZcSLtfPLehM5a2FeH83MNrLd9OPeFDJz6hn
         /Pig==
X-Forwarded-Encrypted: i=1; AJvYcCWub6NhVbbTFh6Nz2jivjOUF9pkICU6PtMW+r/MV2K67CpCCm7BJKDAjQ7A6iqtcEQNTQfXz0jB9UaqjT/zMmzn6AzP62Mp
X-Gm-Message-State: AOJu0Yw3cFs1KBT5TZSsRTrcq0WpIm0OlImRh4+elg82T9uvItCPKAk7
	VDKXBzv63tqkCeTC5u/vN6YZ/TGxT/h3O+kf1rGZgnZhRxdAbeWLttOW0rY9iMY=
X-Google-Smtp-Source: AGHT+IGNRpL5CwiFORsQNNi4dRS9ZChIPtroVM5guy0B6q5an6caEQTQkzVyI74HL2q6JW6IZe88pQ==
X-Received: by 2002:a17:906:ae52:b0:a67:907f:e68a with SMTP id a640c23a62f3a-a6cbc6ca02amr23919966b.27.1717693694366;
        Thu, 06 Jun 2024 10:08:14 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:82d:3bb6:71fa:929f? ([2620:10d:c092:500::5:a296])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c80581716sm121586566b.19.2024.06.06.10.08.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 10:08:13 -0700 (PDT)
Message-ID: <ce92c93e-88f1-4186-92fa-f2126400ddbd@davidwei.uk>
Date: Thu, 6 Jun 2024 18:08:12 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] [PATCH net-next v3 0/2] netdevsim: add NAPI support
Content-Language: en-GB
To: Maciek Machnikowski <maciek@machnikowski.net>,
 Jakub Kicinski <kuba@kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <urn:uuid:d06a13bb-2b0d-5a01-067f-63ab4220cc82@localhost.localdomain>
 <708b796a-6751-4c64-9ee6-4095be0b62f2@machnikowski.net>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <708b796a-6751-4c64-9ee6-4095be0b62f2@machnikowski.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-06-05 12:38, Maciek Machnikowski wrote:
> 
> 
> On 24/04/2024 04:36, David Wei wrote:
>> Add NAPI support to netdevsim and register its Rx queues with NAPI
>> instances. Then add a selftest using the new netdev Python selftest
>> infra to exercise the existing Netdev Netlink API, specifically the
>> queue-get API.
>>
>> This expands test coverage and further fleshes out netdevsim as a test
>> device. It's still my goal to make it useful for testing things like
>> flow steering and ZC Rx.
>>
>> -----
>> Changes since v2:
>> * Fix null-ptr-deref on cleanup path if netdevsim is init as VF
>> * Handle selftest failure if real netdev fails to change queues
>> * Selftest addremove_queue test case:
>>   * Skip if queues == 1
>>   * Changes either combined or rx queue depending on how the netdev is
>>     configured
>>
>> Changes since v1:
>> * Use sk_buff_head instead of a list for per-rq skb queue
>> * Drop napi_schedule() if skb queue is not empty in napi poll
>> * Remove netif_carrier_on() in open()
>> * Remove unused page pool ptr in struct netdevsim
>> * Up the netdev in NetDrvEnv automatically
>> * Pass Netdev Netlink as a param instead of using globals
>> * Remove unused Python imports in selftest
> 
> Hi!
> 
> This change breaks netdevsim on my setup.
> Tested on Parallels ARM VM running on Mac with Fedora 40.
> 
> When using netdevsim from the latest 6.10-rc2 (and -rc1) I can't pass
> any traffic (not completing any pings) nor complete
> tools/testing/selftests/drivers/net/netdevsim/peer.sh test (the test
> hangs at socat step trying to send anything through).

Hi Maciek, I could not reproduce the bug with peer.sh selftest on a bare
ARM Ampere system with 6.10-rc2 and CentOS 9.

Could you please share your kconfig? I'll see if I can repro on Fedora
40.

> 
> Regards
> Maciek

