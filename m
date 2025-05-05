Return-Path: <netdev+bounces-187681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C940AAA8DCE
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 10:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C186174176
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 08:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822731E492D;
	Mon,  5 May 2025 08:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZYtHR5Gn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C241BD9D2
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 08:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746432204; cv=none; b=QMHFCNsnww2lxYh2ww9wVX6yAOozD/qhAPhpMU5at+komD4iNgmagrGfvKV4dVsoNfSRRKNKPZxtPa+k1eqIZI0Mp+kSASX4OXQJJnyrs9+uduEOnY36gKm5K3IrozOj4vG/cDQBH2hWYvw/RPEQyG+t/2AhCK5fppe0Pb0Pt7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746432204; c=relaxed/simple;
	bh=UFpaOKLkbwI8uG1p8AwuYXFN2Y3l5XlBxM9SmUmLDIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f0ztAxOMZm2TGMkv+1AaDSMQPPPPT0UiL0Q5CDtv4esjYQb5C/Eiuix+YOz1P1WzpYpDpXQ6wEjucVURH++itHZaxBCwgqShNHfNYPmqFIle2K84BAYbYvYFioCJgtExou/CcmFTkSvO2U0CTvXfixLf2vufPt9CZaSVh00nYMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZYtHR5Gn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746432201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YaoWopPCGeYkmxy4svbHRxdGyq5Wkloks/++8tW8NqE=;
	b=ZYtHR5GnJ4Fyx61aNgFYXxRGLh6qN5yvrrtxeiqO2UV8h6FclzVmnzpUyDXvsNrKbKOwb6
	72tIHTl4wsCKoy9ONIzXq7QDKQ1q4Umobc+nsXrU/XgOfIdzFMfNv/N5gtzYbXdMMa4JO8
	ypso0Mg327XSX7lUtQMSRMjJyqoISqY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-pUDumkyrPLOjrI4tMX8RGw-1; Mon, 05 May 2025 04:03:20 -0400
X-MC-Unique: pUDumkyrPLOjrI4tMX8RGw-1
X-Mimecast-MFC-AGG-ID: pUDumkyrPLOjrI4tMX8RGw_1746432199
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-391315098b2so1167282f8f.2
        for <netdev@vger.kernel.org>; Mon, 05 May 2025 01:03:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746432199; x=1747036999;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YaoWopPCGeYkmxy4svbHRxdGyq5Wkloks/++8tW8NqE=;
        b=j8Zljjwehv3fG/w+m/j3qUEzDfQBGDjM83pWWG+7+UJo7IhyyDA1kJtcPf9RQBHQ6B
         xjPQMbLrl6+2PqmUEwkF3VSt59wjYAb4SURkZG+Ju+CXzNDq8iKl9ZT6bDLTZCbXDz2i
         f93xzNO9r5IVrwKzdCmQOW37ihx7hz7hQ7bx6yKmYgBkVBkGgKqueOTMgL11DrKSb2g7
         zkPhWLw/ORywdXjrBUYio8BpOvy/YJ8u6fDSTukZHEYHMFEydzOwoTwekXq9BRWUpG2X
         +hheUTA2kVzqZF6OF1nBKXx14rVQDuvlzGcOOYNtp2cdUSGEV6tUSZND0OrjsfFWG1Du
         +/QQ==
X-Forwarded-Encrypted: i=1; AJvYcCUuMiKjLbs5bmuLdhpSZ9+LgOXomIVWylCSoslC3t0Axbkj8DpkszZFm+EU8ilqVEAdl4QHqE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuF9iV/WkYX4kKOg6p04jZD7h7+LbKp8XHaZvTMzTxAJpbXWYE
	1fwxuzVzzxdaXLWpncktioABMwY5LnOpwNawKzd1kGBB4U5A+M0yHaqJmWCiFrCB4zbfJ1dagJ3
	fX1zN9vahTwHmXCFbNSKftPRJEqbihp5BXFJGRR3tymXR3fKcAtjt/A==
X-Gm-Gg: ASbGncs/8QOz+JnkMRbdO6WxNMXbV+xKhnP1D2NjI5Rabkzq79pBpNupmUWyJZVmJWo
	kCuj5WMtUm3nm33z/58BXK3eV5xUBLVuumR54GiEntmpfkdkKiSgrO/tY6bgmpRkdk8IJ10XEBB
	GS6aTRZn9w81x651w86qm8hTGlT5T9sS7sNkqkGeg4xVsNQP9tHQCBex1kSdXkB34cD0lilWOvk
	gxvv8nVlu9v/ol5jM0hkEhCXgDf4nvJY+QKaXG01ar2SXVYUnzvDQHLPXHkfX33SzmiZo9djI4t
	6ACYHkcz3ZLIFsdXApozJBiatbIT65jiikTkJvIuJNwI8+29qZRNAYkscug=
X-Received: by 2002:a05:6000:310f:b0:3a0:88e5:dbb2 with SMTP id ffacd0b85a97d-3a09fd6b796mr4751047f8f.11.1746432199110;
        Mon, 05 May 2025 01:03:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDEh3UpxSAypbHyMAqaPnyryoI2GkGLtFvCTlP+KLOXmTX4bqvmoNoKqUVGkd+zPRzIaOiSw==
X-Received: by 2002:a05:6000:310f:b0:3a0:88e5:dbb2 with SMTP id ffacd0b85a97d-3a09fd6b796mr4751020f8f.11.1746432198769;
        Mon, 05 May 2025 01:03:18 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2706:e010:b099:aac6:4e70:6198? ([2a0d:3344:2706:e010:b099:aac6:4e70:6198])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099ae0b9fsm9403566f8f.4.2025.05.05.01.03.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 May 2025 01:03:18 -0700 (PDT)
Message-ID: <7addde54-1b77-4376-b976-655a2776a31e@redhat.com>
Date: Mon, 5 May 2025 10:03:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 01/15] net: homa: define user-visible API for
 Homa
To: John Ousterhout <ouster@cs.stanford.edu>, netdev@vger.kernel.org
Cc: edumazet@google.com, horms@kernel.org, kuba@kernel.org
References: <20250502233729.64220-1-ouster@cs.stanford.edu>
 <20250502233729.64220-2-ouster@cs.stanford.edu>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250502233729.64220-2-ouster@cs.stanford.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/3/25 1:37 AM, John Ousterhout wrote:
> +/* Flag bits for homa_sendmsg_args.flags (see man page for documentation):
> + */
> +#define HOMA_SENDMSG_PRIVATE       0x01
> +#define HOMA_SENDMSG_NONBLOCKING   0x02

It's unclear why you need to define a new mechanism instead of using
MSG_DONTWAIT. This is possibly not needed and deserves at least a good
motivation in the patch introducing it.

/P


