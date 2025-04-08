Return-Path: <netdev+bounces-180155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE45A7FC27
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 12:35:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C043E7A4B82
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 10:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8A8267727;
	Tue,  8 Apr 2025 10:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jlty5irL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C580B26739B
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 10:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744108498; cv=none; b=qtlHhpd1nuH1yugIqDwLpw/tm0cXdbq5xU+LlbZuF0Cm/Tq1zHsRx6X9xKoOuEWBvrVmWD3Dn4uqJHO60Zb53eDyIJn2aKejT5BxMPgM3gbcqyLG5+hxQX979zh8qKYwLadOmV/iNQ2Ju1L0MbxeOhtVWdeuNnt/uNi55Ddd+wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744108498; c=relaxed/simple;
	bh=dIUSGCQJMkWXHVB5T0uBKfCutdPuOePLOlNcmB0Cw8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IDxQ//yPwXhBmWoss6B4ZIiBlBNjO9nt9i+ds2qIfrKhzdS0dKRc32FZqvRPMBXrvZL8kL6nLd3OmcWxufkIU2Px0DB444FyuvpsmC5//jD/88Zs89II5WTbSPucSnETBgBweHbPdz/AaYBQMUstbsmIgeq7DUbh3oeciHs1y0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jlty5irL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744108494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z1kLDCuy0LJWaq40XfbBnptvlV3cFoN35q8yUrDYBAo=;
	b=Jlty5irLdbVVLkbKZpnR/fTezSo3p16sIE/BU6XwLdBaaoX98pdCMCAn6LEQMCQYBm/nOH
	LTG8G5nzsMdBmMI6bWJbZlS7XkEKp8LXk38gnsnROmX14LRU5e3ELwwuAw6tbQNBgLTP+l
	zgMr9U4LRKNvCXkmh6LoejF/OTWJRzc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-85JxnynDN-GwA7fiwA8NOg-1; Tue, 08 Apr 2025 06:34:53 -0400
X-MC-Unique: 85JxnynDN-GwA7fiwA8NOg-1
X-Mimecast-MFC-AGG-ID: 85JxnynDN-GwA7fiwA8NOg_1744108492
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43cf327e9a2so45611015e9.3
        for <netdev@vger.kernel.org>; Tue, 08 Apr 2025 03:34:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744108492; x=1744713292;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z1kLDCuy0LJWaq40XfbBnptvlV3cFoN35q8yUrDYBAo=;
        b=wPjfsYpe7lMP9j2mGtEHpT29REL7ueidbjckZpEUDFp4K194rNKJVLFYhEbhWMHtP/
         134DvXRDfnKvfNZlCUJjg7WSSplSVFOjO7nIAwCGKMVO4gP//r9/vVT+zyCMr/WVi8z2
         QDdSzUwYkorGDzDJaWaYDSETa4qC2FRsnkG8Z+z9gyLKp5O7u8AstV18pg38NYFluOqP
         mJEKbGFjnZiQ91Zva/D7FoiAMR1CvdHHObkE7aGlau4rbZDZw51D23W37AzoTXazIcfw
         82Fgo3kPH7Lgv1OsJb5gUvvPXGkEEawSK+j2yp2ZI54BS1HHmfkc+182se+meC4UF91a
         ou/g==
X-Gm-Message-State: AOJu0YytajSaidw6mn7ILEk/EoNnmN1aNZeM67VrHpTAA8tjntKIWs3r
	ImUWZkkz+EYWLQzbQimZ6kynVv7TExXQwjnzFf8nZOE3L1H6Scn16/ZCMlI6ozH7NIMCzMD+ZJx
	cehWl3d+6CpPmr7UCwevUECRVZ93Bu6k7sFMrqmUNOmsTmavG2BMPzw==
X-Gm-Gg: ASbGnctcZWT4PLDkF492fzMzAadEBtKv9G6ZW5AcwM8Nppr6zNOGaVPEQ7yPaV62eXB
	VqAP4JFDZZkdY2ncB6YIXX2jnjQ0s0DNGhhVWM/shxf40A0Gx7LIH1UietfbV4pd0lrabh/9oTU
	uIG6/h20sf1zWpGTaD7tds8jLbE+am0HT+Z87Yf/1slYGcuMcDboO+r9QT8G7rW3QNQ/6qVlpb0
	3pYbmfURRh7bqensq+fNSjcuoCeQYXmaV+L7UHfaYS/LkLCuLvR4YbDJzJc8QBk/Bzf0Hm1zeor
	bmwlaxo12zQsv9kXa9ujEICyJZd5mEt7eQYhRjBZ50E=
X-Received: by 2002:a05:600c:46d5:b0:43d:fa:1f9a with SMTP id 5b1f17b1804b1-43ee077feeamr114019035e9.30.1744108492262;
        Tue, 08 Apr 2025 03:34:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNrx9b+C4sy+Jf7jez9bNmGMXH7wVN/rHcn9k1wVEeZvgkM6nisFU/CRDVij2cqGe7/JrW2w==
X-Received: by 2002:a05:600c:46d5:b0:43d:fa:1f9a with SMTP id 5b1f17b1804b1-43ee077feeamr114018755e9.30.1744108491905;
        Tue, 08 Apr 2025 03:34:51 -0700 (PDT)
Received: from [192.168.88.253] (146-241-84-24.dyn.eolo.it. [146.241.84.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f121d720fsm8632615e9.1.2025.04.08.03.34.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 03:34:51 -0700 (PDT)
Message-ID: <89f9194a-e7dd-423b-ae54-c082f42edf51@redhat.com>
Date: Tue, 8 Apr 2025 12:34:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] net: wwan: Add error handling for
 ipc_mux_dl_acb_send_cmds().
To: Wentao Liang <vulab@iscas.ac.cn>, m.chetan.kumar@intel.com,
 loic.poulain@linaro.org, ryazanov.s.a@gmail.com, johannes@sipsolutions.net,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250405115236.2091-1-vulab@iscas.ac.cn>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250405115236.2091-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/5/25 1:52 PM, Wentao Liang wrote:
> The ipc_mux_dl_acbcmd_decode() calls the ipc_mux_dl_acb_send_cmds(),
> but does not report the error if ipc_mux_dl_acb_send_cmds() fails.
> This makes it difficult to detect command sending failures. A proper
> implementation can be found in ipc_mux_dl_cmd_decode().
> 
> Add error reporting to the call, logging an error message using dev_err()
> if the command sending fails.
> 
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

This has been posted while net-next was still closed for the merged
window.

You should have waited for the 'net-next is open' announcement on the
ML, or checked the status page, see:

https://elixir.bootlin.com/linux/v6.13.7/source/Documentation/process/maintainer-netdev.rst#L35

in the interest of fairness towards those who correctly wait
for the tree to be open I will ask you to repost this again,
in a couple of days.

When reposting, you can retain the already collected tags.

Thanks!

Paolo


