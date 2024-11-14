Return-Path: <netdev+bounces-144940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 093179C8CC2
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 15:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1B2D28264C
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 14:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B4C2EB1F;
	Thu, 14 Nov 2024 14:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxpQSlqp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BC11C6BE;
	Thu, 14 Nov 2024 14:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731594139; cv=none; b=lPmlmxinW5dka4co3A50zmn7cyF7NzXHDXkczyMeQ6bMYXueKIgwAJPOoXWo6tD50d/pTXm+2j1RcQCijJMegZu+4ZlmKbcB/2bSGMxi5J6WvGUfh200auvvvQM1BYEXMpm+2PCuC5SHYRkv5sqRxImyVK5D1KMbEGW5zgzhKMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731594139; c=relaxed/simple;
	bh=woW4Dbr79nNaGTSt2wV1jo+nBLcBDKnKm3vhJmk7v4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FcyIUBoU88VfYTZBdBzoMXKFHSeao9IVB74wQXCvvTEUpvHKmY5curBDkVStGAOY3eMj84tZNWybrIV8qGtilSziWupg/aQN1EtN1UdCKpHHuE71rnvTqROLy0r6fHcy6TlscGkFvHmz1rdrlpON79ELQXGoiTeyCRmuFTPrlag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kxpQSlqp; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20c8b557f91so7093335ad.2;
        Thu, 14 Nov 2024 06:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731594137; x=1732198937; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rcCCps3bA0DT5Vig5v3Q+cOzEWKwyoNxFgVPNNONgVA=;
        b=kxpQSlqpgQWVGJIGRoxHUHlqEencziowKhEuZunr204jycE3/kIIZJQRhLhjqzphMF
         X709Y0QwpIqD/bkI/uoivMiVY2bjyc9LAPl1tI3JXyCKfjGTEHscjQed+rH424FJm7MF
         m6zFjk6EH8vwAVwMy8HjOVlGyBo6OdlS4jC295ZNhuZM1hz9GbN3jaAQrYGrkvA/5RTV
         dJdlM5PQcTdoZqCkccEXd4VYT21LevQFrsaOsQsYD+aJV9b52aL8R4eKNNu4GuTUmL6Z
         q8K/Q+eeiUdwQodsgmL8z97OVnJ0f5o8vHa7dFQ9wFuM1QrQtKVftJEOeNQrUOC07ImC
         tYQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731594137; x=1732198937;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rcCCps3bA0DT5Vig5v3Q+cOzEWKwyoNxFgVPNNONgVA=;
        b=bJF8KUGiaxIfOGo+83qj0eCgmSNs5jy+miA5SgRMJoaDXXleVQBUBryYhiHVOVEaCE
         YZdFxcQjV6v8zgbus4mgN2ZOLZcuXBeZdDcSQTS+xAuzAv30uj2IqzqBn/fTnuvSiK16
         ia6yWSsyauYjdBT1QGhJK2reWc5jBB4NzWQqUwTyjRPLKULesQmhWjhqr9otKRLsKgkD
         YiBn8lHqPNjFzO/6/rSzPLdTDYCcvv2lfUMPIrFNzz8BXtoqGfhBacf5Xb/A+Ch7uoKV
         9rpL9lklLV74rsPuy5J4Wg502n3VVvjWAFWZdAxiviLWi5KiC1nSfXoLQTzjVjCREaPK
         Yl6g==
X-Forwarded-Encrypted: i=1; AJvYcCWPVTT6y1La/xnZmY/wW2m0Lg50Eal+lQdwwtgj37atsrqEmglcgY6PQIyyeRutZr+aB1BanmA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQPITpA2Qgavs7dImARH3TBUFvrwzp/YqWCCmSFcw7c3UFQp8H
	LR/87L3hF0GnWdiYj2F7dn8urWATUc4/KTii6TnrIlv2EL/LitIm
X-Google-Smtp-Source: AGHT+IGdNC026LNcUMicDzqTvZcNB8zfVKvkb6Hdu7BwOtmmO2FSU037zQZdQAhxv1dA13Kf6UjwAg==
X-Received: by 2002:a17:903:2451:b0:20c:7409:bd00 with SMTP id d9443c01a7336-21183c4268dmr353165635ad.5.1731594137360;
        Thu, 14 Nov 2024 06:22:17 -0800 (PST)
Received: from ?IPV6:2402:f000:3:800:19f0:968c:fe6e:97bf? ([2402:f000:3:800:19f0:968c:fe6e:97bf])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211c7c28f64sm11341595ad.31.2024.11.14.06.22.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 06:22:16 -0800 (PST)
Message-ID: <a33a3a58-ae24-464e-874b-bb924fa32f69@gmail.com>
Date: Thu, 14 Nov 2024 22:22:12 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: chcr_ktls: fix a possible null-pointer dereference in
 chcr_ktls_dev_add()
To: Markus Elfring <Markus.Elfring@web.de>, netdev@vger.kernel.org,
 Andrew Lunn <andrew@lunn.ch>, Ayush Sawal <ayush.sawal@chelsio.com>,
 "David S. Miller" <davem@davemloft.net>, Dragos Tatulea
 <dtatulea@nvidia.com>, Eric Dumazet <edumazet@google.com>,
 Jacob Keller <jacob.e.keller@intel.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Mina Almasry <almasrymina@google.com>,
 Simon Horman <horms@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Jia-Ju Bai <baijiaju1990@gmail.com>
References: <20241030132352.154488-1-islituo@gmail.com>
 <55a08c90-df62-41cd-8ab9-89dc8199fbfb@web.de>
 <1fcd2645-e280-4505-aa75-f5a6510b5940@gmail.com>
 <7f5b2359-c549-4de2-b4c3-977e66a1c1fa@web.de>
Content-Language: en-US
From: Tuo Li <islituo@gmail.com>
In-Reply-To: <7f5b2359-c549-4de2-b4c3-977e66a1c1fa@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024/11/14 20:26, Markus Elfring wrote:
>> We have run our tool on Linux 6.11, and the line numbers correspond to the
>> code in that version.
> 
> Would you like to share any source code analysis results for more recent software versions?

Hi Elfring,

Thanks for your reply.

I ran our tool on Linux 6.12-rc7
(https://elixir.bootlin.com/linux/v6.12-rc7/source), and the same issue
persists. The line number is identical to that on Linux 6.11.

  chcr_ktls_cpl_act_open_rpl()   //641
    u_ctx = adap->uld[CXGB4_ULD_KTLS].handle;   //686
    if (u_ctx) {  //687
    complete(&tx_info->completion);  //704

  chcr_ktls_dev_add()  //412
    u_ctx = adap->uld[CXGB4_ULD_KTLS].handle;  //432
    wait_for_completion_timeout(&tx_info->completion, 30 * HZ); //551
    xa_erase(&u_ctx->tid_list, tx_info->tid);  //580

Any further feedback would be appreciated!

Sincerely,
Tuo Li

