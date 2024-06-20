Return-Path: <netdev+bounces-105226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC202910344
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 13:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EE4C1F228B7
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 11:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C021AC223;
	Thu, 20 Jun 2024 11:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QWoyWzaY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F06B1ABCD5
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 11:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718883842; cv=none; b=qSsxxYqVvU1Mos1p1QQ/hRulW5CsjvW9MvHoE2BWBw9Rv9roBR0jLcE2tGMxNawF6MgJNvg8bl5voXd6ARXH3Eu09CQ0NOkjjvZKIAo/iT34iTrcnSftksdjMlTT3KK6Z7GzHgUB+39JlVs9CZPK/ubsZBWSPDyIAQXEhvCxUYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718883842; c=relaxed/simple;
	bh=sUtS8W51dT3L0ul8hIazPODbd/otl0eNspJXJPrWCnA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bWARwN9USC/AFikhMnDWCATRiM3txgSH03IRpyIuYRSO7YmcuGP0XGrNE8xiGBHMqJoP9uMSBuyChdkXc6+Lyj84pE9tu50i6o+Psv9A4kWkzYsH8LTQ9r/IJWY6KvsRhtR7dgiV0p3diqrNkM2heSrmU5UOHczK5LZCQdyIXC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QWoyWzaY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718883838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=9LHnXr1dLaOuf5iJD69TLLMfEQC+zklonGqGsW0jKFE=;
	b=QWoyWzaYWOpe0MVG02jGobCp7BXOAoOYmgdhKExRWl3wQEg1SPMIAAlQZBuMTOKR+1BKpL
	GnO2Ktfso/Of1xj1szCrnccNxr8HYEVjOpLNbZaKKQunQrXfTcV01YOLVEzH2Q5ds7DzFo
	DGbOVfuZDuGtlsLK6G+6o29FuLvDTl0=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-9YAABuqsNOSwrGUn8efFxQ-1; Thu, 20 Jun 2024 07:43:57 -0400
X-MC-Unique: 9YAABuqsNOSwrGUn8efFxQ-1
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3c9b5776fccso52202b6e.1
        for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 04:43:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718883836; x=1719488636;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9LHnXr1dLaOuf5iJD69TLLMfEQC+zklonGqGsW0jKFE=;
        b=G7z45JQkyEoo+0625Cn1kEfnc7Vt6mzkWb/p8qi15R9xP2JArOfMhDBd6NoaCnFo9B
         fo/L9MtDv4g5W7MSmS/njCfMHS2oHH9jdnTV0NE1+3m+De9VKekwOzR7pLorFcAA533N
         s2M5t3R0XBEaFbtJu70dt1xEjfudpO5ZFcGgK3CjgKFitR1dObd6kGXAxUxByWTcWLLX
         xevKC9Q7hFwclvN9F3YsCzmMrAPGnhYnj2N49Kip6+7uoVkei9DVt56iAIFSSItAPPHn
         Wlmlt3Mo+0Ogmupl5qa9+DmYmYxNE6090ELGrrpLXWZKV5u4sS1gagQwtwC3x/DsBp8S
         yszg==
X-Forwarded-Encrypted: i=1; AJvYcCUhjfs8G4vHfHHezgFtbYAUNmhpkMsh+FdOJcIW+lu5nj3IYKjGCoJzFSHAlcu5A7KCvV2i/tqwwrrP4drQx5dY6lZt5Z32
X-Gm-Message-State: AOJu0YyN+KYdlnoZYlPr4rfr8t6odYduf3u3Pv1U7NuKkcl50DxFTsfn
	VeeQu6rBarJTCfrGBssWroi2vX8DnbeNAl2F4YIrJNDc+ojgswMUo9kOVxiHBo6KWwTbE1uekOr
	z/ZVSDKCd1t2KPbqYe0e7ub0HQHx5zjZpAINW/jaCWLs2BMYv0JPZTA==
X-Received: by 2002:a05:6808:1b22:b0:3d2:2755:3300 with SMTP id 5614622812f47-3d51bb1a5eemr5584729b6e.5.1718883836567;
        Thu, 20 Jun 2024 04:43:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNO8UolfSq8Wa0y7Zsg/4/vlxB2P5l49ds3c6yjja5vIFPszlLSH+v5Sw6c1KsemJfnkhpJg==
X-Received: by 2002:a05:6808:1b22:b0:3d2:2755:3300 with SMTP id 5614622812f47-3d51bb1a5eemr5584710b6e.5.1718883836205;
        Thu, 20 Jun 2024 04:43:56 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b0b7:b110::f71])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798abc0cfb9sm689021485a.92.2024.06.20.04.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 04:43:55 -0700 (PDT)
Message-ID: <c76d1786c308aeb6e4c836334084e3049c0f108a.camel@redhat.com>
Subject: Re: [PATCH v2] net: usb: ax88179_178a: improve link status logs
From: Paolo Abeni <pabeni@redhat.com>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>, davem@davemloft.net,
  edumazet@google.com, kuba@kernel.org, horms@kernel.org,
 linux-usb@vger.kernel.org,  netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Date: Thu, 20 Jun 2024 13:43:52 +0200
In-Reply-To: <20240618115054.101577-1-jtornosm@redhat.com>
References: <20240618115054.101577-1-jtornosm@redhat.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-06-18 at 13:50 +0200, Jose Ignacio Tornos Martinez wrote:
> Avoid spurious link status logs that may ultimately be wrong; for example=
,
> if the link is set to down with the cable plugged, then the cable is
> unplugged and after this the link is set to up, the last new log that is
> appearing is incorrectly telling that the link is up.
>=20
> In order to avoid errors, show link status logs after link_reset
> processing, and in order to avoid spurious as much as possible, only show
> the link loss when some link status change is detected.
>=20
> cc: stable@vger.kernel.org
> Fixes: e2ca90c276e1 ("ax88179_178a: ASIX AX88179_178A USB 3.0/2.0 to giga=
bit ethernet adapter driver")
> Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>

Please always include the target tree in the subj prefix - in this case
it should have been 'net'.

> ---
> v2:
>   - Fix the nits
> v1: https://lore.kernel.org/netdev/20240617103405.654567-1-jtornosm@redha=
t.com/
>=20
>  drivers/net/usb/ax88179_178a.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178=
a.c
> index c2fb736f78b2..d90ceab282ff 100644
> --- a/drivers/net/usb/ax88179_178a.c
> +++ b/drivers/net/usb/ax88179_178a.c
> @@ -326,7 +326,9 @@ static void ax88179_status(struct usbnet *dev, struct=
 urb *urb)
> =20
>  	if (netif_carrier_ok(dev->net) !=3D link) {
>  		usbnet_link_change(dev, link, 1);
> -		netdev_info(dev->net, "ax88179 - Link status is: %d\n", link);
> +		if (!link)
> +			netdev_info(dev->net, "ax88179 - Link status is: %d\n",
> +				    link);

Here                                ^^^^ link value is always 0, so you
should using a constant string.


Thanks,

Paolo


