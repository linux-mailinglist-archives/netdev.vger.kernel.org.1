Return-Path: <netdev+bounces-97305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DCC28CAA87
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 11:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5078B1C216E4
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 09:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FFE57308;
	Tue, 21 May 2024 09:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lfw34S9I"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E395339E
	for <netdev@vger.kernel.org>; Tue, 21 May 2024 09:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716282839; cv=none; b=IHCdQbSj/vO5xkxaMQ1VSFN0xEY7wra+JXqY+FPU96ZkczcOJ9SztLw2OLd52+N49vVDN4a0jHIJj8Zznq2MrHOb7keJNe7ZHkDbp/RYDXoDjlFMY59+eEZjPJym6qFqeQ0pOhLFrOMbxRwBVegYbXh90rmHIfHJMYqdSKN9Xc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716282839; c=relaxed/simple;
	bh=L7aR29FtSZuZ+y/bx0KTKzczdY+Rsy7yZ58GK0tgM4Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fouDmWdOmSTBkcF86WVIE5TAt/MVHZf15Ovx9bqnFU8mYMrksjOgr1EcvKIkXvS+TZcXOAKuaMaXYSCG/oFb2KeFYBszf6helXf+2H3FG7tHJ9PZMi/wyOsMA/cqvBZJlxYG5B3XAPIVCEHQYwnLlV2QR/g49mQHmbzpTMD9vkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lfw34S9I; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716282836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=L7aR29FtSZuZ+y/bx0KTKzczdY+Rsy7yZ58GK0tgM4Q=;
	b=Lfw34S9I1URscSqLpS/pCFW/ZK7MJlHh5eJITHXBzrWPGesNFAmSWfanvgobHUr3nxQZvr
	3sz7T5aQsoKa0J8adC2Z7fHFky8VAdstCOWnZcyT02w7OtVbFI3UABem8I4YTFcdXW5AUU
	QRVIqQzCLRdUDS1QTA2jEmT2ZTXYVBE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-U4FQmJqQPuWh_rkouTCuHQ-1; Tue, 21 May 2024 05:13:54 -0400
X-MC-Unique: U4FQmJqQPuWh_rkouTCuHQ-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5734e769097so949100a12.2
        for <netdev@vger.kernel.org>; Tue, 21 May 2024 02:13:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716282833; x=1716887633;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L7aR29FtSZuZ+y/bx0KTKzczdY+Rsy7yZ58GK0tgM4Q=;
        b=BWdd1kljwgapZLwqZZluXmK4YX/o9O1A9jp8ldo0CSkx1Omsq0oDDiONlQdiS3Q242
         3NKK2SQEmH2VrWPs7IxdR8LslZYlnEGjoKVySIBEWrdUi+bxsnEIVEcPzAln7ZdRumjm
         6pWC0ScrWRxOzFrG08WbxImZXS8qMuxJvjUe5iQeg2V4NMWkNznxNr7k7yvuKcqkNDQC
         Z9l3y6vl3SBn3cLZYq2gtXhSmE6CaXB1Tt/v9vsaChOX6PdYjeyjDIMYDsu2u9a0bQrn
         1xd8gz63YsSh88q+rvNNCLlDC4KI66kM7t/jUfKpNQZ/TA9Yz1rgpYmvVqNArILbopHm
         ghlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUd3USgv2beh1R5bpQM4A9LvU1OBZP/slI3UYT1mi9CApUOD2FGhz/OYZY+An9+ijz0K9UnWMmgd7/XZTox7q/26GrpW5Mo
X-Gm-Message-State: AOJu0YwYiK/jUyFzgNoXsNHaSxmeH5/9aQAjJ6rbE7iN4Na4XwmxNWJk
	LpwK0VZTsPHatjNQ29bwpsUNQ9nFlrFV//ttsgd/hscI1cAWxUrzVeOB8n9IhzX8x3DoZiH8bIm
	oANPSa0IVhN9CVvuroYG7QGSTjQtC3cy4Ow4mWZxjeVSFmjvtmp2GAQ==
X-Received: by 2002:a17:906:5a53:b0:a59:cb29:3f9e with SMTP id a640c23a62f3a-a5a2d508447mr1997674666b.1.1716282833455;
        Tue, 21 May 2024 02:13:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHV1ntPxccpfq9AyVQGuqsGIGjfqnOrRteQNsYcsYGeXzxKtgD6SptYJpS2ho99TR81HfElig==
X-Received: by 2002:a17:906:5a53:b0:a59:cb29:3f9e with SMTP id a640c23a62f3a-a5a2d508447mr1997672566b.1.1716282833005;
        Tue, 21 May 2024 02:13:53 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b094:ab10:29ae:cdc:4db4:a22a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a61c18561casm217908366b.91.2024.05.21.02.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 02:13:52 -0700 (PDT)
Message-ID: <75651199a933427a7fc3980ef8a2139f5f1f1695.camel@redhat.com>
Subject: Re: [PATCH net-next 1/2] r8152: If inaccessible at resume time,
 issue a reset
From: Paolo Abeni <pabeni@redhat.com>
To: Douglas Anderson <dianders@chromium.org>, "David S . Miller"
	 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	 <kuba@kernel.org>, Hayes Wang <hayeswang@realtek.com>
Cc: danielgeorgem@google.com, Andrew Lunn <andrew@lunn.ch>, Grant Grundler
 <grundler@chromium.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org
Date: Tue, 21 May 2024 11:13:50 +0200
In-Reply-To: <20240520134108.net-next.1.Ibeda5c0772812ce18953150da5a0888d2d875150@changeid>
References: 
	<20240520134108.net-next.1.Ibeda5c0772812ce18953150da5a0888d2d875150@changeid>
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

On Mon, 2024-05-20 at 13:41 -0700, Douglas Anderson wrote:
> If we happened to get a USB transfer error during the transition to
> suspend then the usb_queue_reset_device() that r8152_control_msg()
> calls will get dropped on the floor. This is because
> usb_lock_device_for_reset() (which usb_queue_reset_device() uses)
> silently fails if it's called when a device is suspended or if too
> much time passes.
>=20
> Let's resolve this by resetting the device ourselves in r8152's
> resume() function.
>=20
> NOTE: due to timing, it's _possible_ that we could end up with two USB
> resets: the one queued previously and the one called from the resume()
> patch. This didn't happen in test cases I ran, though it's conceivably
> possible. We can't easily know if this happened since
> usb_queue_reset_device() can just silently drop the reset request. In
> any case, it's not expected that this is a problem since the two
> resets can't run at the same time (because of the device lock) and it
> should be OK to reset the device twice. If somehow the double-reset
> causes problems we could prevent resets from being queued up while
> suspend is running.
>=20
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

## Form letter - net-next-closed

The merge window for v6.10 has begun and we have already posted our
pull
request. Therefore net-next is closed for new drivers, features, code
refactoring and optimizations. We are currently accepting bug fixes
only.

Please repost when net-next reopens after May 26th.

RFC patches sent for review only are obviously welcome at any time.

See:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#develop=
ment-cycle


