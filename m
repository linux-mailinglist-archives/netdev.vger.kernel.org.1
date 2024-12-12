Return-Path: <netdev+bounces-151354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9209EE546
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 12:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCD1E280F5A
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 11:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986FE211A1C;
	Thu, 12 Dec 2024 11:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LVhrcXha"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40992101BA
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 11:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734003781; cv=none; b=c7HdT/W8pje/zt7ZZwL6NeM1JXZZCzUAAXUyL34ya1JZRnXJvds6YoI7m1jvck8214GI3q37v0sTPYnqgzDAgkLEOpv+Qh7o+UsvoRqvJCZYOpnpZic1a+kQGtkOgevq4tQ1T9oCE36ujHfirsuE6wCSm4iYBQQPaUqNrUQ3lgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734003781; c=relaxed/simple;
	bh=ta6dcw5Lqi+epCtRiM3z0EbmMHGpPpDCzAYGazBBDJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AZtRlT6MstG5RFxzRsv4KJgGvt4+XMbWUYNzAygDtqpwDPHyFkvTTxn84mRNDnPgV5+xyrzo06VrPpZhjf65SOE2xWeh86HkFWPhZpVA/rnzDrxBqH0S1GcHtCnbIzQ+rr++EHMQX0ZaODYIxRQYesxjZciRhY4VozzNktBmumk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LVhrcXha; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734003778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r7P/AmC8WjbEmUQlPKcMRCF3Av6ELgVoyqiaamWp15Q=;
	b=LVhrcXhaV51GrSazckTi2opJ2b2NHOapukSHjCN3Ef5Eg9y3Nc3fRAv8RZBJRQuy1S2i+8
	3FWNFWj1wjjpWQoIUuBpykfXlSLiUZrhVdEBa8mhTHRi+YjfKcGbP0Z1L1X1852bihp/R/
	/GwfVSdgEFxKC9ZaqjKg+iApOZ0iTwU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-xWnjMae3PByqJy0kc5Uy2w-1; Thu, 12 Dec 2024 06:42:55 -0500
X-MC-Unique: xWnjMae3PByqJy0kc5Uy2w-1
X-Mimecast-MFC-AGG-ID: xWnjMae3PByqJy0kc5Uy2w
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4359eb032c9so4121695e9.2
        for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 03:42:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734003774; x=1734608574;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r7P/AmC8WjbEmUQlPKcMRCF3Av6ELgVoyqiaamWp15Q=;
        b=vmdDzF0xfromXRhXTnXnIH83qLYiCjMVK8XUFdd7uUc/ROM9b8A02PnDaBvhmtX8Bl
         rKHVoFfO84HmAmi43bLW7mvWS5CKToVGqMp/G/iSxzbY2yEmFIkHhxA+Si2FwhXFtNh3
         bQvujt9yCzqg+yodOnENJSB3UJ/SquDG8SeyItM23k9mj+dqs+ZlaNSVkpzYKmRhpFoZ
         8HIOkyo9+xgMoHbvIUAIxM0EHlBci9BcBjb7Xs9w1hIkRUjNUUd3GeX0w8hVCCaGqnfc
         n2geU0nyDIc3EP07DnSijDeFK0IoV4vWv6H4OQ17zg51KJ4eL9hgNzipULC7znRgOnE/
         tciw==
X-Forwarded-Encrypted: i=1; AJvYcCXAN+eWaW0IzgQ6kpG8tnBtoAnhEhC50xbOHBMVj9vuBzpPYCAi/rBKZwmDZ4qtJ5geYe9MPb0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzjy/ejyweMEjmMMQvvYSmWKI0ESbXzm/FssMONba2VFr1JM9rY
	BnJuFkBWTUfSxa4Iydnq0rcRGOjjnbrmm3WmmVWlwuJ0fYlOGRkh+5+csBv43M0c9eAzgIw2OHU
	gWCh4Lx+p6ONVt63sQ++IRu0Ds9I3GCVtciItyN0kVEdswrO2klFGIQ==
X-Gm-Gg: ASbGncvr4Mj7ot0XFC2leStH0Yvh7as4XsWcVSMHLWbUc21rU3EkVTs6PvYPM1bu1m3
	Fh/MWMrkFbxqYkhUj4vkau18jDA3Hj7uEuyP70VzLOapOHYcWizLkLBjqiFGXRtAW5cRX4gBbhI
	z0OdFvWnuURybmwWGJCrAvlaMlPPuiRhy2DUSQRcQi/jDqGtqzrmzSKYHMNQl2CDtkqVveD772i
	n0i3ZY+7HkfDxmCp6euKUl4mtJ4WaV8W90KP3gZZjDjVQbZjazYNn+x0GHGUkDNVkE8bYyG1Oyz
	cIqITEk=
X-Received: by 2002:a05:6000:79c:b0:385:ed20:3be6 with SMTP id ffacd0b85a97d-3878768e462mr2339264f8f.22.1734003774414;
        Thu, 12 Dec 2024 03:42:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEzMbTMQjj/EcKrfC2zE6T1mgloFv3AuV4opo8+3j9huepSafAMh3r5R/Gh/+RpnVOA8JTdcw==
X-Received: by 2002:a05:6000:79c:b0:385:ed20:3be6 with SMTP id ffacd0b85a97d-3878768e462mr2339242f8f.22.1734003774057;
        Thu, 12 Dec 2024 03:42:54 -0800 (PST)
Received: from [192.168.88.24] (146-241-48-67.dyn.eolo.it. [146.241.48.67])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-387824bd889sm3836322f8f.44.2024.12.12.03.42.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 03:42:53 -0800 (PST)
Message-ID: <8d00ebff-5f5e-4b00-865c-aa7e48395d08@redhat.com>
Date: Thu, 12 Dec 2024 12:42:51 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1] rust: net::phy fix module autoloading
To: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 tmgross@umich.edu, aliceryhl@google.com, boqun.feng@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com
References: <20241211000616.232482-1-fujita.tomonori@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241211000616.232482-1-fujita.tomonori@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/11/24 01:06, FUJITA Tomonori wrote:
> The alias symbol name was renamed by the commit 054a9cd395a7("modpost:
> rename alias symbol for MODULE_DEVICE_TABLE()").
> 
> Adjust module_phy_driver macro to create the proper symbol name.
> 
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>

Please resubmit including the fixes tag, thanks!

Side note: the netdev CI is lamenting a linking issue on top of this
patch, but I could not reproduce the issue locally.

/P


