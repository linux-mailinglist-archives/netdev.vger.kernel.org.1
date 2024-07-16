Return-Path: <netdev+bounces-111693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E79A493216C
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 09:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D2881F21D66
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 07:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5D82EAEA;
	Tue, 16 Jul 2024 07:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LsLf3Ekv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1207F37143
	for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 07:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721115947; cv=none; b=l/GmKyIcRI7PWWT6EeA5DnEPXLFnDoXDImwTByebyTbXp9poF1aTr9/KpxFenI216t+8Js/Zcjj95YsGC8u7sapYAZSzlCmbKRCUfGFGDkeWV3Qk8M3xqRM+uHPEIYOhMb3sX8IbJq/g4nX1IWlE3aO8JlV9g/4wBdyHA7pUjxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721115947; c=relaxed/simple;
	bh=86MUwza1xWsJAaFKgS4rDz0o1jK2RJQSPKS8NDzal6g=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=LlD8Y3KQxQQOxvDa5Y0uto3+lxOiUvsFTQinhZsVOjpyn5Wp9emcI/oyi13KMCjO8Sck1MRQ07oFPpnvgD3rHQhTZtf6OKiO9qVqdLbvN0K6WsX1SwQdcxrZTCrpl8Wj3a4BstkfwDOEBXmCOg98PKPz9IfaKG0lJkGroMW5yFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LsLf3Ekv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721115945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z+V++ss0Y+nF3bHAtu1rHuXiHCzOFsrcCTkSe7rWi5E=;
	b=LsLf3EkvpO4oDAyyhzmwRDSCRzw1uYZIYpT1c1EEH5/NNN25COufRVPVp96BHRqtgNxy9q
	jwQGRWeVqhGtPi829/CVn62zvovAdxy2zsB6klLoI8QveESQmgh7ulCfgDShe7rU8TIXnH
	13JLJYERLdm3HS93A0iYZBiaxj5uXhU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-NtbMywcBMIqk4dSwkoZQzQ-1; Tue, 16 Jul 2024 03:45:42 -0400
X-MC-Unique: NtbMywcBMIqk4dSwkoZQzQ-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-79efed0e796so959221485a.1
        for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 00:45:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721115942; x=1721720742;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z+V++ss0Y+nF3bHAtu1rHuXiHCzOFsrcCTkSe7rWi5E=;
        b=euYX94IHQVa0yb/XBFcrlCNIf3616dtXVcLAQHDnhX/5PXgs64ObhOFF318G6V0xsr
         zQvNT5IdJGSRodpoxZd8NAhHH9i7XftIG5HkT6r4HebWgu9He7jAHYk7l5ZBC1BKo3Ns
         UyZZaK5I2b1wuQig1rxvXHjhZUAqCDyXAab9wUqMUBZbH1bBIZ1kPzw10gYME0guXCqy
         vTHNzKmh/tG7QawXRGfTWGsir5l8BhG8nlznpO29guId4dV62FZnxIz3marwod7N5c3D
         S6og8sZyErzvOE/gc9X3s7ZqblpJzYlzcd7X4j1kP0jTtgQIFihaG9Nddh7kMAhgNLCM
         KncA==
X-Forwarded-Encrypted: i=1; AJvYcCWG0aBO0KlMrhTYkw4WzwNTSb6R+AjX8D9aDsJ7crEuuMGmGQhOxsj/Yk57TL/KcfqqWqmFnQmS8cWfThdjTDzg2tRd8nNM
X-Gm-Message-State: AOJu0YwmNTV5VR93SnXdMbGLp4t81dBJBeoVEyJaVF+YPh5tQGYH01px
	hstybTxdEiindTGl6RW4pF3CGPcUCSlCmVtfKAW+dKEAersW77SxlZxIoBRHwB5MghtKj38r5st
	1uCLcyf8HkKTA5+MvRG+VSpr3ix7kcXAmJsXdavrysIz0JedLAnPlEA==
X-Received: by 2002:a05:620a:2987:b0:79e:ff18:a510 with SMTP id af79cd13be357-7a17ca0990bmr122367485a.2.1721115942386;
        Tue, 16 Jul 2024 00:45:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHja7LIrw3Q4bZ6oSnFrulhGf/6KoTTkPi7QV9BQCaqrfjnWFBtckwybN/MOQzLHKDVIObrtA==
X-Received: by 2002:a05:620a:2987:b0:79e:ff18:a510 with SMTP id af79cd13be357-7a17ca0990bmr122365585a.2.1721115942034;
        Tue, 16 Jul 2024 00:45:42 -0700 (PDT)
Received: from localhost ([240d:1a:c0d:9f00:523b:c871:32d4:ccd0])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a160bdd7fesm270250585a.65.2024.07.16.00.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 00:45:41 -0700 (PDT)
Date: Tue, 16 Jul 2024 16:45:35 +0900 (JST)
Message-Id: <20240716.164535.1952205982608398288.syoshida@redhat.com>
To: tung.q.nguyen@endava.com
Cc: jmaloy@redhat.com, ying.xue@windriver.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] tipc: Return non-zero value from
 tipc_udp_addr2str() on error
From: Shigeru Yoshida <syoshida@redhat.com>
In-Reply-To: <AS5PR06MB8752BF82AFB1C174C074547DDBA22@AS5PR06MB8752.eurprd06.prod.outlook.com>
References: <20240716020905.291388-1-syoshida@redhat.com>
	<AS5PR06MB8752BF82AFB1C174C074547DDBA22@AS5PR06MB8752.eurprd06.prod.outlook.com>
X-Mailer: Mew version 6.9 on Emacs 29.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi Tung,

On Tue, 16 Jul 2024 07:35:50 +0000, Tung Nguyen wrote:
>>tipc_udp_addr2str() should return non-zero value if the UDP media address is invalid. Otherwise, a buffer overflow access can occur in
>>tipc_media_addr_printf(). Fix this by returning 1 on an invalid UDP media address.
>>
>>Fixes: d0f91938bede ("tipc: add ip/udp media type")
>>Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
>>---
>> net/tipc/udp_media.c | 5 ++++-
>> 1 file changed, 4 insertions(+), 1 deletion(-)
>>
>>diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c index b849a3d133a0..439f75539977 100644
>>--- a/net/tipc/udp_media.c
>>+++ b/net/tipc/udp_media.c
>>@@ -135,8 +135,11 @@ static int tipc_udp_addr2str(struct tipc_media_addr *a, char *buf, int size)
>>                snprintf(buf, size, "%pI4:%u", &ua->ipv4, ntohs(ua->port));
>>        else if (ntohs(ua->proto) == ETH_P_IPV6)
>>                snprintf(buf, size, "%pI6:%u", &ua->ipv6, ntohs(ua->port));
>>-       else
>>+       else {
>>                pr_err("Invalid UDP media address\n");
>>+               return 1;
> Please use -EINVAL instead.

Other addr2str functions like tipc_eth_addr2str() use 1, so I followed
convention. But -EINVAL is more appropriate, as you say.

Thanks,
Shigeru


