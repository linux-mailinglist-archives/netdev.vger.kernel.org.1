Return-Path: <netdev+bounces-181191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A3FA840A1
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 12:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 112D43AE40D
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 10:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F7727CB3C;
	Thu, 10 Apr 2025 10:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LNJOCEez"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C212165E9
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 10:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744280627; cv=none; b=UfNoKA+iEMWNzmHu0g6B8TKov5jAXg8l7SHfg2eTe+TQtVBIgtE3obLUP/4tTZX8wZW6zEVc506Tte3ucB8gtJJMm6QWpg1Q28ejlUwuNzKdPWgC0gQKlDdlgCh/jNnJw1NaZsE4JM3W0035FG+OVDUGmK4eoveaZZeszvoH8so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744280627; c=relaxed/simple;
	bh=OfuCOFKjvMskfnz1F4XFE/u3fByc20wvO3rC2eyS2l8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tdAB0H5ftB6fjoJ+QulY/h93pNA26okxbIZG9Meg323nFh7O89dFFHGxASKTPfOUcLFQlOqIGU7H4Hrb86rvYbwJEnRHt0te6hGxTWttZKhKK1lHWq+AgYgi6A3oiY0tSjLUB/VppqEmZsCm3gZlje17v44bheVds5smFZRBV+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LNJOCEez; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744280624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OfuCOFKjvMskfnz1F4XFE/u3fByc20wvO3rC2eyS2l8=;
	b=LNJOCEezNXPLIHVGgBo3jzS5/MEgDnHHfCMarbzwLI0XldBQ4rj/Bdl3aATEZzXHIoIZ89
	pb8BHk2bUV1kSJ7iFobyakc3IbVmfW5aRNaKNYLMTIo4LFgRW3t8/pSupvXO2Np1krgsoT
	ywPERax/Axk73A8WbnGYKY8JY/T6Pnk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-NV5K0G5tPIOC0XwBJHywVw-1; Thu, 10 Apr 2025 06:23:43 -0400
X-MC-Unique: NV5K0G5tPIOC0XwBJHywVw-1
X-Mimecast-MFC-AGG-ID: NV5K0G5tPIOC0XwBJHywVw_1744280622
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-39d917b105bso232297f8f.2
        for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 03:23:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744280622; x=1744885422;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OfuCOFKjvMskfnz1F4XFE/u3fByc20wvO3rC2eyS2l8=;
        b=qpS1vA4CKHWBMOqgfjakuW4gVjcUrWUtQ30DpHCr+JKwEB9qCxH4dnxGk2fYgDU06m
         hvqc0T7JjsyhKt+nNoIuU99Ap5wxXJ6htuk9CCncyTz+b72vmE0WFvudMygYO78y8KRr
         XwdPEue/ZPaZGA2q43nQgqezxRG2zn3LIKlAgCidTAKZAFWm7R2iC2s8K19rcVTwzFLd
         i0w36FW3X2/MzDFDj8u6RoHdHNwEnpWkZj+JayNTxkq8zA9ZFgNmRX1e/PYcoBzoMhn1
         BSoxIAOFSk795WGdHNdF2K/Cq5EeF6pCr9FUnSJQR9moPHzfgiLKa1uyhpcvllq/n5wR
         CJ8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXbXi99F3DNMFtnBj+Vp2Z6OhrO3Qwvt/gTFvnwfOaVHdHIRGfv0C69NWgzEAFkd/oxCLksZLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsfN45MrjDUQY+qQon2NOTbO8XDiwu9/ASlj1TH8tB2DgQvYuU
	UpfxAfO9hu6CgaLNPbuAQRYjXq7PYVEsvFnXEbfd9+qIluCKJwyK+qNByQeIYRrnPoQ25XWgIyN
	WcrpJz/DnWiGnhPBZWXkwjOsOm33uuc5KpFTmzkJHc/wdu9cGeljz/w==
X-Gm-Gg: ASbGncsXpdc6dYxCNA3Umxxc7Vbx/5sb5HYQQGvGPKxzh8X2eW4Vh1gpuQdMxqDaM1p
	2XlW+U3I0mk65HY/mU+MsfQmNy/xAym68vBYOuJCyCyptXwaPmb6FvDpAi9JY95P7XzLo+gSHKy
	gIAg2pEGlvVSuNvAYr6us/xy1WvV85YREeT/iRT3ui8G9VEnHGPNJVIugpu8uKme2G18NuO62MI
	FMmKnw0pXxIfMU6RzjniP/kxVt+D1A5mpkYZRzBp7jXKlEYsqqwApd/XuZCGsHcqUjFfzwqX+er
	xjrj4F16GBUzIkNwbZpHg5XnbfrbIDtb+OZC6cM=
X-Received: by 2002:a5d:59a4:0:b0:399:6dd9:9f40 with SMTP id ffacd0b85a97d-39d8f271ff3mr1349576f8f.9.1744280622406;
        Thu, 10 Apr 2025 03:23:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlGK+RDA8sZsXCeD/oZHDHITnRrGJZDpmPkdubQYhIgKQAR+h2AH1WJpCXG8zaPEaVZ56PZA==
X-Received: by 2002:a5d:59a4:0:b0:399:6dd9:9f40 with SMTP id ffacd0b85a97d-39d8f271ff3mr1349564f8f.9.1744280622098;
        Thu, 10 Apr 2025 03:23:42 -0700 (PDT)
Received: from [192.168.88.253] (146-241-84-24.dyn.eolo.it. [146.241.84.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f233a2c46sm46370505e9.13.2025.04.10.03.23.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 03:23:41 -0700 (PDT)
Message-ID: <2c779583-bac7-43fe-80db-0dc0bca2e0d2@redhat.com>
Date: Thu, 10 Apr 2025 12:23:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ptp: ocp: add irig and dcf NULL-check in
 __handle_signal functions
To: Sagi Maimon <maimon.sagi@gmail.com>, jonathan.lemon@gmail.com,
 vadim.fedorenko@linux.dev, richardcochran@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20250409092446.64202-1-maimon.sagi@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250409092446.64202-1-maimon.sagi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/9/25 11:24 AM, Sagi Maimon wrote:
> In __handle_signal_outputs and __handle_signal_inputs add
> irig and dcf NULL-check

You need to expand a little the commit message. Is the NULL ptr
dereference actually possible? How? or this is just defensive programming?

If there is a real NULL ptr dereference this need a suitable Fixes tag.

And you should specify the target tree in the subj prefix.

You can retain the collected ack when resubmitting.

Thanks,

Paolo


