Return-Path: <netdev+bounces-107786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5130191C586
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 20:15:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A8EE284821
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 18:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5911CCCAB;
	Fri, 28 Jun 2024 18:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EArBTuls"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196861C6891
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 18:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719598518; cv=none; b=cpC88jvo3/DAZ1piy/uBQk2Zm8MQycfhWEWGQnJQ4f/2iyo4w0TQZS4uTM6T6itmm1xbTcwBUu2bBVY/kpXkxjgvec/ACkxHaidF9LuuYscM2JEuqII8jRl0/zQlAcQyyjLUDIPZvirqeTVn4rPoW3w5xebB+uasbvs34FSXKws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719598518; c=relaxed/simple;
	bh=I6SwX75zD4uLLMOyEySdEAkaogA/COnC9oOl2ywW3O0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NYdjFFBmi8x/u81jPK8925udx/uBEMRrx0yLcEmE/S70KIWu4uT92ViYsgG65IiFMyD+HT/VJKlCZrwoe97avEl39W4Jnm7otvYtWmNkc+A5Zxf7nlg/y1WCcVsw4EN3BvtbeIXSWOc6dPQrfacMXHrdVmpyw7TDEyAhlcBc1QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EArBTuls; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719598516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I6SwX75zD4uLLMOyEySdEAkaogA/COnC9oOl2ywW3O0=;
	b=EArBTuls+sXTlwRCzWffOn0L41peN1XDZLB2w6CXFU0ppqSMU0BYEVzDyV3ZLRNY1RI8s/
	io1aqywyWbEMKas+5Y30au6TxZv+8roTWRqCrnzyf18CBqPqB+yvb7AIah6HtDHKNIV9Bm
	QisRpuGHEwuiTQmgt+5Wt95e8ulbpiQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-QbyF60ElNGmMo9PvH3_gZQ-1; Fri, 28 Jun 2024 14:15:14 -0400
X-MC-Unique: QbyF60ElNGmMo9PvH3_gZQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a72436378bdso74036666b.1
        for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 11:15:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719598513; x=1720203313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I6SwX75zD4uLLMOyEySdEAkaogA/COnC9oOl2ywW3O0=;
        b=oauwQeLNnGIF8883ay7fI+J3jnrYRQTbasBP38hRIfDL1aY2YlIKsqVBlUM7YbTb9s
         WX1gkJmFeHEqdBJVHH5DfToRhAQFP1CclB4tBMXw6nsgKIQ/0iGxxWCjxxfWi2sgd1Tn
         J4tYW9+/CGJ0Ter3HPDWhxIGlPInYlX9reaK9C5du5kxgKqnVMAFhDknSXT3l0QNxvkY
         I5Krkz77I0bxR5HGykWCLFworigCdpVexG+y6SprJf8lYHC34aTh4cc5ikKEs22GLdTy
         YXfw0clnAyj2swR+fUTAEaCAgWy7eZ1yfzU19/aUaxGuxG0NCLSTuChGq3L3pFUlXEPw
         2TXg==
X-Gm-Message-State: AOJu0YwQuhupbD1VbYorHvNo060sPrYVLuO6Odk97dzJd/NScIouohQh
	p/qs+4iJW8rh9sSlImhp1QxEUEqVIje/XdTS5zG9oEpSnZufIzA1vjry01i1lcRM60PUqF+XXPC
	GoxEXS+avjvMTn8/MK/gb6n34uam2mRND36BxKriH38FcE3PeAQEUAg==
X-Received: by 2002:a17:907:6d19:b0:a72:b055:3dd7 with SMTP id a640c23a62f3a-a72b055407bmr190679166b.1.1719598513216;
        Fri, 28 Jun 2024 11:15:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGqybnIlUkh6FCuDhsxUzrNgEu8zdev7yIXr+vZIF1T8yLJCjO+nmuU1Eaa1BjPkAvAX9eDrA==
X-Received: by 2002:a17:907:6d19:b0:a72:b055:3dd7 with SMTP id a640c23a62f3a-a72b055407bmr190677866b.1.1719598512804;
        Fri, 28 Jun 2024 11:15:12 -0700 (PDT)
Received: from [10.39.193.120] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72ab0b8892sm99875466b.222.2024.06.28.11.15.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jun 2024 11:15:12 -0700 (PDT)
From: Eelco Chaudron <echaudro@redhat.com>
To: Adrian Moreno <amorenoz@redhat.com>
Cc: netdev@vger.kernel.org, aconole@redhat.com, horms@kernel.org,
 i.maximets@ovn.org, dev@openvswitch.org,
 Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Pravin B Shelar <pshelar@ovn.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 05/10] net: openvswitch: add psample action
Date: Fri, 28 Jun 2024 20:15:11 +0200
X-Mailer: MailMate (1.14r6039)
Message-ID: <437859E4-AD40-4257-8860-841097AEE51D@redhat.com>
In-Reply-To: <20240628110559.3893562-6-amorenoz@redhat.com>
References: <20240628110559.3893562-1-amorenoz@redhat.com>
 <20240628110559.3893562-6-amorenoz@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable



On 28 Jun 2024, at 13:05, Adrian Moreno wrote:

> Add support for a new action: psample.
>
> This action accepts a u32 group id and a variable-length cookie and use=
s
> the psample multicast group to make the packet available for
> observability.
>
> The maximum length of the user-defined cookie is set to 16, same as
> tc_cookie, to discourage using cookies that will not be offloadable.
>
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>

I think this patch looks good. After some offline discussion on alignment=
 with the userspace model, we decided to proceed with a psample() specifi=
c action.

With that in mind, and considering the additional changes, this patch loo=
ks good to me.

Acked-by: Eelco Chaudron echaudro@redhat.com

Cheers,

Eelco


