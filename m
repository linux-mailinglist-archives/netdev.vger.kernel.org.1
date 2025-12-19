Return-Path: <netdev+bounces-245487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CC3CCF082
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 09:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 086E1300FF8E
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 08:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C722E717B;
	Fri, 19 Dec 2025 08:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EUjki3pC";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ETWZlwCU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B097B2D837B
	for <netdev@vger.kernel.org>; Fri, 19 Dec 2025 08:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766134165; cv=none; b=H7SEV20/bY+TUW/iZrv5ALrB+zTAHJsox4YfvpBmGx+OFpXuzX/SCyXUkDZfKXh5AjvPnQMTf1+WYkXb1BbUkXRd1XeJ1+Pd5U/Kw6tlqnNctSVUTBbtzS1XYoVHkOOUWp5RoCaFvvLhWAJ3DrEBOIL5nnUox0SXgXzy+89aosY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766134165; c=relaxed/simple;
	bh=uejryCLRQ1VNG1fvpKRtW4mcmwc1LynbGgyohhNlzCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=atbE3y/9Ed0WVh2I4Y2PQuVwYYLXSzLkLgaJuhjIptr2TmDOOTASEQLlf7i2E4PkRRx9NCWlknb9WGrMclTMcFFYkAGTmQshQ39vQEw2v9CVY5zOfy58VMOV/hzav0VydtTyVjGA9QGXZWboReen18FUqH0f9pxDv2BfQb3waQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EUjki3pC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ETWZlwCU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766134162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sW5Hrxdsb7GUKzUzVoNy3hjRSNuogwTUTSagfAq9WHk=;
	b=EUjki3pC8GqFaJBfHwhcK28stfrGS5m1KgPx+qWiHsD4RsmuvhFfYF+ckYw5h+P6VPfiAI
	zs9+utdJcGKe7nBajY8yw23KvBNkg+p0D5ljY7cwdaLoiF/9AJ/cFgf6fjrzu4OxJ2wmZ2
	I59yGzXmemg+OrSEb8N3RqAkXQm1Bx8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-N7y_hWSJPj-1Aum_6YTe2w-1; Fri, 19 Dec 2025 03:49:21 -0500
X-MC-Unique: N7y_hWSJPj-1Aum_6YTe2w-1
X-Mimecast-MFC-AGG-ID: N7y_hWSJPj-1Aum_6YTe2w_1766134160
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4779ecc3cc8so10081625e9.3
        for <netdev@vger.kernel.org>; Fri, 19 Dec 2025 00:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766134160; x=1766738960; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sW5Hrxdsb7GUKzUzVoNy3hjRSNuogwTUTSagfAq9WHk=;
        b=ETWZlwCUhoGaH9KlYqe5nEUYN28PxTDf2RLtaWC/qZS1DL11npGnMBGyjVsaRuhItQ
         7NC3Fmk5GnUs5IIJHSBjKdC7a8p12jUc2+89rJEByE6tI44ZsLaScZQSc900d9ycxS8B
         3FbuMfvLTKvEkf8hj1fJ0VVDs88D5ZwztBlAMy7Q4Y+0SE8Z/28kPnQIwRjI2vW60Gme
         6IrJHARFMBDzbI5dfk9w0OOQTr2R9ssKjIO+bkVITt7GBNXuCDFdekX0M9A1+Qgilvlc
         i8oFwlVHmlYHlnS9faoQHD4aEwyicG04MPBfO5reb0UhSlyi4Z4hk99DKIZ49NJ/Nr+x
         1ekQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766134160; x=1766738960;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sW5Hrxdsb7GUKzUzVoNy3hjRSNuogwTUTSagfAq9WHk=;
        b=tQZoWzEWZibRhgcmgcRnvSkao2ZOh62gLJFqpP1zaIg0QWtdZ4Aj67S27X42RPnVEd
         9f9w2lgZb4ts346OBSF+1HyjBp/+Zpkm9BbocibTgrPfY0uJa1eo/p63qon35qBTS8cQ
         ywg0txvLT/UM1lcEGT7xf3tWdM74WWRxRaVeyezalw/YEv14vQ9o8JoRJYQXXj7klaEm
         JKl/IQgRciuqochcO48QcAgsXBD7RDD2V/Y1rRN9f5ZGEVFSYRkdfpbcmadhVZ4bDTbG
         uBy3BLqaEpwN+TzhRcJbps38P9O0b0zP8p+dAkXu6BHy1xKAISJNTmrE0Q8XnBzy3C1b
         QK5w==
X-Forwarded-Encrypted: i=1; AJvYcCUqgVB46y6Nyn4mKUZ/egLYz97d32JzYmZuiLy2wY2AZ1sWYuzmmrSayEIHcnv/AU6nQBEFr8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvpgdHvqaH3UwA0zjEKtlrfkgc2nne2R8+TIg2cg9yUEhgyBS5
	c5bk9Ot2IWQm/baqK5/3NOFVhssI7uVPV4Y0uth9ZineB5WyDgwxW4BoO10bcApL59ZR/efKYL4
	9uPQhihxSNaTrBfgPampKuMcvbpq0yp1nIhfrW5VIgLgL6RBneC7JK8T+4A==
X-Gm-Gg: AY/fxX4TryhDMUSiAtB/tBMuWdRwvKhKiR/86Dfy2nCq9rjukVn69vtu4Ob6yEAG5Ad
	bARW720cQpV6wZOR5ONZRNblV/AxuuUdJmLLo8KnPXFa/OpsQt3k0A12Bd0dutYDaVQQyPAi0gr
	Zyu5hNfUT5EZsAHnMQS4R5GU9q6NDardOW93XQy9TmCQh25Loz/IMkx+BC4+oJ3oMP/9599WMQ3
	lP66bhA5XUfzSQr/taP9CZFRNGVn8mj8OiavOFrfZ2ptf9hmF9j3ccscR2Pp5lAvxuilY9Geetn
	WlcxDomGuCvOKYUE5JyDZOySBFhn72vkAyu2vvDKUOMxZlersDSlz5ntCPPgc82lEyqgi9mql2r
	DwF9hfkFZ/YKk
X-Received: by 2002:a05:600d:108:20b0:477:9986:5e6b with SMTP id 5b1f17b1804b1-47d1c038664mr8170945e9.28.1766134160054;
        Fri, 19 Dec 2025 00:49:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEqUQk++ajFxa4Fltq1nQ3xd1vcqp5ri720kaNVCgS9smnN4G2iaVta3SyM5UhVrO4wmwHRzA==
X-Received: by 2002:a05:600d:108:20b0:477:9986:5e6b with SMTP id 5b1f17b1804b1-47d1c038664mr8170815e9.28.1766134159715;
        Fri, 19 Dec 2025 00:49:19 -0800 (PST)
Received: from [192.168.88.32] ([216.128.11.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea82e9fsm3873617f8f.26.2025.12.19.00.49.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Dec 2025 00:49:19 -0800 (PST)
Message-ID: <9ebaa762-a12f-4748-9672-05b09706a5ca@redhat.com>
Date: Fri, 19 Dec 2025 09:49:18 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/3] pull-request: can 2025-12-18
To: Marc Kleine-Budde <mkl@pengutronix.de>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
 kernel@pengutronix.de
References: <20251218123132.664533-1-mkl@pengutronix.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251218123132.664533-1-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/18/25 10:27 AM, Marc Kleine-Budde wrote:
> this is a pull request of 3 patches for net/main.
> 
> Tetsuo Handa contributes 2 patches to fix race windows in the j1939
> protocol to properly handle disappearing network devices.
> 
> The last patch is by me, it fixes a build dependency with the CAN
> drivers, that got introduced while fixing a dependency between the CAN
> protocol and CAN device code.

Pulled, thanks!

Paolo


