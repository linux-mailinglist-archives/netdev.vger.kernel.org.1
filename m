Return-Path: <netdev+bounces-110734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D1292E08A
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 09:07:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D42301F21D68
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 07:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197C812FF7B;
	Thu, 11 Jul 2024 07:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GBti8U23"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED69412EBE3
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 07:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720681636; cv=none; b=Z/ZTp21EB7u0bfsiNF3McTbAfadJ1EtCMTk1rbBMVtSiqNN/B5yKdv2BbBgSXas1Jg7WGt5z04362t0sZFteprfieTbY8jWvnzgrsGRXgIDpsM5vL4hjS12GnuG9HmNrf8YWxEtG4ySzDpkYKqVA2GgFdHS7LWTrBoDQ0xMnklc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720681636; c=relaxed/simple;
	bh=M6Q4Y54tcX2mSlvfFlPj/ernw6oyX4Le4JdM01IEiT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EfzZtOSVJuORu/AN/igm+Hz5JwyJASOSrs3zOrsNpHh74vhKqaAtNHghM1JnFwGaB5nrtUQcHL736pQk5wbZXqNLg5yHyF7f6u81GSFLM7LbUnW5Na65FLjFO+xdzBZSNnqgQdqhwYyyTjnJ5R+RUxBVqLfb6sjCljjH9BXnpgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GBti8U23; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720681632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+gwiURRRyYCMTdBJLlcbFXQzpT51EG6fdosWSqyzJyw=;
	b=GBti8U23ek7MzY9bvNQfPUrqYsEvk9zTvD8B0NMm/vam8YG8G067G9IqjjP5nhur7OZZEt
	8MqwtDpXpsF19l30rqER5NH1bln41sNM57Dpxhw/wW4Z6OPELFfiJx+VzHs9Ce1sXBFGHs
	S0Kx95y/6mYPsOcDrEm5sK+0iKN5ct4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-HAnti5btO5SPy_x-ohJuvA-1; Thu, 11 Jul 2024 03:07:11 -0400
X-MC-Unique: HAnti5btO5SPy_x-ohJuvA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a728c02df80so54574666b.1
        for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 00:07:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720681630; x=1721286430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+gwiURRRyYCMTdBJLlcbFXQzpT51EG6fdosWSqyzJyw=;
        b=Mo44/3pFTDCjuPqXlgGGqtbX5dFC1ujPWWe72AC8B0ZYDIgJzcSxrqakg0IG5pUgXP
         ggOlV8tbBwSSpyDB/EKUb0eNRtRn2KYA6gYGA7qvvl+gKxcboLp/2hEKITlY2gVVMu+i
         04Ly3HWKe3Ru67nQaZaIlnfNpLap9QtHIz7P6slA4/PNT0tBpBwuUWwk6BOykZBJZ7Wd
         hW1zKFgIZtc2wSPnjJ82gab8sX+nc6eezP/dZiuaRH8JFAOkkaTQ26TOEVAwKx1oKvTt
         tRhUvTCbDfn1yjKHBtb/v6EkCOQp70K69YNm0IpoSyvOyAlMnZDm9lqtna0Arff/iaD8
         aidw==
X-Forwarded-Encrypted: i=1; AJvYcCW3gfDdyYTgHdRNqgn4fcotDa6S+8ZBJGCR/dTqcPyv5kgFvrI2CibjEa/qaPxnS1v0VnfXXVObEDuMmo2zjDNjDmqBCwdL
X-Gm-Message-State: AOJu0YwLSzlTUmwC4DGHQw8GvB5WodEr1CzJUDyLLnVLEriuajxa0kJJ
	3lq4u4TdlNq9Sfw0XtHCqDxaYnKM4AnhxgalK1UH3mTujKOp0z5Ap3e9SZGBByqmMoZMesiC1w7
	pePJ/vYx5V6Zu1v8IqiVDLtiVJUQHRDaym2SaTPrDSB4hQHC3X4nOf0TvD7eaOg==
X-Received: by 2002:a17:907:7f20:b0:a77:e1fb:7dea with SMTP id a640c23a62f3a-a780b688767mr673480066b.2.1720681629839;
        Thu, 11 Jul 2024 00:07:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6fcNSUdwOXzcVw0nvIFIjlIr5dl9NwMN5RYz968tXKLEx4Zbt1Hmp7deL2qMOfvVI3bkxJg==
X-Received: by 2002:a17:907:7f20:b0:a77:e1fb:7dea with SMTP id a640c23a62f3a-a780b688767mr673476166b.2.1720681629127;
        Thu, 11 Jul 2024 00:07:09 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-153.retail.telecomitalia.it. [82.57.51.153])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a7fef92sm230972466b.125.2024.07.11.00.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 00:07:08 -0700 (PDT)
Date: Thu, 11 Jul 2024 09:07:04 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>, stefanha@redhat.com
Cc: Peng Fan <peng.fan@nxp.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] test/vsock: add install target
Message-ID: <hxsdbdaywybncq5tdusx2zosfnhzxmu3zvlus7s722whwf4wei@amci3g47la7x>
References: <20240709135051.3152502-1-peng.fan@oss.nxp.com>
 <twxr5pyfntg6igr4mznbljf6kmukxeqwsd222rhiisxonjst2p@suum7sgl5tss>
 <PAXPR04MB845959D5F558BCC2AB46575788A42@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <pugaghoxmegwtlzcmdaqhi5j77dvqpwg4qiu46knvdfu3bx7vt@cnqycuxo5pjb>
 <PAXPR04MB845955C754284163737BECE788A42@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <whgbeixcinqi2dmcfxxy4h7xfzjjx3kpsqsmjiffkkaijlxh6i@ozhumbrjse3c>
 <20240710190059.06f01a4c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240710190059.06f01a4c@kernel.org>

CCing Stefan.

On Wed, Jul 10, 2024 at 07:00:59PM GMT, Jakub Kicinski wrote:
>On Wed, 10 Jul 2024 13:58:39 +0200 Stefano Garzarella wrote:
>> There is a comment there:
>>
>>      # Avoid changing the rest of the logic here and lib.mk.
>>
>> Added by commit 17eac6c2db8b2cdfe33d40229bdda2acd86b304a.
>>
>> IIUC they re-used INSTALL_PATH, just to avoid too many changes in that
>> file and in tools/testing/selftests/lib.mk
>>
>> So, IMHO we should not care about it and only use VSOCK_INSTALL_PATH if
>> you don't want to conflict with INSTALL_PATH.
>
>Any reason why vsock isn't part of selftests in the first place?
>

Usually vsock tests test both the driver (virtio-vsock) in the guest and 
the device in the host kernel (vhost-vsock). So I usually run the tests 
in 2 nested VMs to test the latest changes for both the guest and the 
host.

I don't know enough selftests, but do you think it is possible to 
integrate them?

CCing Stefan who is the original author and may remember more reasons 
about this choice.

Thanks,
Stefano


