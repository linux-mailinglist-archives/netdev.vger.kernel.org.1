Return-Path: <netdev+bounces-148421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E77879E1849
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 10:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26872B42585
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 09:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15DB41DF275;
	Tue,  3 Dec 2024 09:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E/Tlxvoa"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C27B185923
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 09:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733218465; cv=none; b=PDxWMV08pICpiBYg9rNhBZSM7VDlPP6yMy70AOWt5VEOAdHJp9yR1spRSu44CaKhQk+Ro1fRvn2YMVhyquAHxtTsxWWdiJ/az1dI3RJCBc84EyNtupU/STToCRbf9QEUxXjNgr7gLYXpKcJlA/1MJKrL/qI1rIf+5aLdAxEDZAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733218465; c=relaxed/simple;
	bh=tmYNp4m0pTcJcMNGtDbDEbeNdXv5xyGIZImT4smrZE8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gLtWtTl/XW6FpIAsstRO59BTNPgvg3oJJiIt4pzt4wXUIxROkTuqQiT+HzKk08agSbE14xQtWjbWo+X9/Y3YA7AwtRLmIkUYKZRk3q1kCjweDYfoo18ZxhVPEj3Kbh2VRCVKV+w0YTWQI75mcUZXjRpyFXOvi6vvfAzGSPyLbfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E/Tlxvoa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733218462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iKuqay+zTpWkFnfMu6dqxG2vMVa9093BS55rnW6Saqw=;
	b=E/Tlxvoa23D/boA8BuoeVmowxyBhmK5R5iWjC8BGz6w6IGBsYvqpXIdFfvxZFa6Q34jY8c
	z+/2KrTJbsTHNgIFPBeIim8ChZe4E+y1Xa96nVhsR6QYgFlB6iyrBb1qpWNoSeL8375o8a
	Lj0JrZ42ThTemU+p5E4APH97jIlMStM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-RE7zmy2sOomozqT_RvNp8w-1; Tue, 03 Dec 2024 04:34:20 -0500
X-MC-Unique: RE7zmy2sOomozqT_RvNp8w-1
X-Mimecast-MFC-AGG-ID: RE7zmy2sOomozqT_RvNp8w
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-385e27c5949so2085060f8f.3
        for <netdev@vger.kernel.org>; Tue, 03 Dec 2024 01:34:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733218459; x=1733823259;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iKuqay+zTpWkFnfMu6dqxG2vMVa9093BS55rnW6Saqw=;
        b=qPuitew9lKEQqkGOU5o2t4Jq7rC3LAwNZFGFUkH3/wUFempVi+cpyS0VOuOkL0HzbC
         DCjb3AYGiqlGEuMY5nPyP97wuPslic2VDVLL22Xsw7e9xGr6NWLzJdZG8W3Z1ajkhbTJ
         TpUc6eyiK/pyjYa00Uk27iVaK1E+mtX+gLulZi1d8fs9IXWd/RKCpUP6+eWZdPXxKT4L
         LM03kFZe0EVXOzO+dv3MVlUGP7BAw4ONSY14xniDOoUoD5tMUR/hL4nC3fpWGYjso8CK
         S/WBu4Hhf6EvKuln92q8vHwcMS8g1j6vifqTXCe7r72SYFRjh+WrIOuNaT6MOLsu/E9d
         W5DA==
X-Gm-Message-State: AOJu0YzleEm7yNr+Ixaq6rLKzVYcMeDqb70QZkKGN+juDe0Q0uTUPrOS
	/u4YqfqkmWgDM+VRS3agI8tvAEPI3KjVmkKIzJFJRswAMBWOi3pWlsSIg92oJ41YUsVi9ka+Ofr
	oo0RYC7vBgHphW2r4oJhdUJ7A1aaMvAMub38w5FN77bvEHmCSt4wJ+A==
X-Gm-Gg: ASbGncvmufO7OFuerSfu18ZcnaWvBwbZe6aC9ol0+i2REatsuIo3ZhCwqxbu8JsS4Fi
	Zggar6Otf3mfK/a1XCyTtQsDdsTRHv5JY098nP/bnBSnMmmVhCtAsUM7zrP8vplIoZnXA6hXOGS
	/4fmZwQWzT9AHwzO0jp98pbOtS+lHjNymVplCjHsQuqgFxW2MXSRawstQ6prcA7V9vFMh5HJBCJ
	kI9QFgXd7qRECfKBMoK8BYzhI3PYHug5As1vYv9ql5zUJy6aRuqnofrNrZxJkP7prVSv8TCuXO1
X-Received: by 2002:a05:6000:2aa:b0:385:e8b0:df11 with SMTP id ffacd0b85a97d-385fd423e36mr1584702f8f.37.1733218459610;
        Tue, 03 Dec 2024 01:34:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEIihO2mrO5+F8zuPbwwSnltX/0Ql5nndhmeyAxDibZj2Her5rsTK1xCeAtYSz9YJ0tENnZ+A==
X-Received: by 2002:a05:6000:2aa:b0:385:e8b0:df11 with SMTP id ffacd0b85a97d-385fd423e36mr1584677f8f.37.1733218459289;
        Tue, 03 Dec 2024 01:34:19 -0800 (PST)
Received: from [192.168.88.24] (146-241-38-31.dyn.eolo.it. [146.241.38.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385e04c6005sm11643968f8f.78.2024.12.03.01.34.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Dec 2024 01:34:18 -0800 (PST)
Message-ID: <3720d154-a838-48dd-bfd3-f0f1cd595f0b@redhat.com>
Date: Tue, 3 Dec 2024 10:34:17 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ptp: kvm: Return EOPNOTSUPP instead of ENODEV from
 kvm_arch_ptp_init()
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241127-kvm_ptp-eopnotsuppp-v1-1-dfae48de972c@weissschuh.net>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241127-kvm_ptp-eopnotsuppp-v1-1-dfae48de972c@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/27/24 08:27, Thomas Weißschuh wrote:
> The caller ptp_kvm_init() expects EOPNOTSUPP in case KVMCLOCK is not
> available and not ENODEV.
> Adapt the returned error code to avoid spurious errors in the kernel log:
> 
> "fail to initialize ptp_kvm"
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

This looks like a fix worthy for the 'net' tree: please resubmit
selecting the approriate tree in the subj prefix and including a
suitable Fixes tag.

Thanks,

Paolo


