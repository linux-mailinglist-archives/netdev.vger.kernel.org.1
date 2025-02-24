Return-Path: <netdev+bounces-168958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAECA41C4C
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 12:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 959797A4735
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 11:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB4E25A630;
	Mon, 24 Feb 2025 11:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BsX8k4iP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6D625A2C8
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 11:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740395809; cv=none; b=cQdqz5FvZd1xABqh+124VvUIEokAvHIe8msjv08QDwOfWnPVZWjFiRu3winVqKQRAGRaVZYcs1PORuqymtwO93CMyDmVhZk9WaJYJPLovmS6U6hy9ztl7+6voixSeNChEM3m4xqkMjnUITHiiBEJKGZ3Ocw5N8y3J1EzZbaZtZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740395809; c=relaxed/simple;
	bh=xo1iB6h0IrJbcbhX7m0G0N7TTNZqPjZKr7nxchijw34=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JnAr4zN4SYCUbOAA5oTGyIByQplGMr/qX6yQOd8Tr6xJCFjud/fDFizxZcY7Q4RjrXhdg6W/ypR37QT50sPbj7oOAy1SR4ZTHDPzSIXCSr3Qe7/YoRQYWKcYfxFlO8sqngbx+WprKL685jTgrtV0rjYB16Y/aCFfJR6Gj3Fo3gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BsX8k4iP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740395806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xo1iB6h0IrJbcbhX7m0G0N7TTNZqPjZKr7nxchijw34=;
	b=BsX8k4iPO1fmk3ecdQDt9hnsHFIStkKUNqQMP1cKfRY+3EdQ7qQxX3fVLlIdfmpwI4msKB
	4lBWRMajpmOTyZ30Q8MsTyaqj4duMFD5xU1Gw0ps3BlCF0wrAmDcLJaRrNcm0gezK62vNX
	fEjflX2Fh6DGHTNwsgmzN3omXDQGtFI=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-V1wHGRlWPq2MSGj1mD-Paw-1; Mon, 24 Feb 2025 06:16:44 -0500
X-MC-Unique: V1wHGRlWPq2MSGj1mD-Paw-1
X-Mimecast-MFC-AGG-ID: V1wHGRlWPq2MSGj1mD-Paw_1740395804
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-2ba47dda647so628126fac.0
        for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 03:16:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740395804; x=1741000604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xo1iB6h0IrJbcbhX7m0G0N7TTNZqPjZKr7nxchijw34=;
        b=X5XKhUiujR8HOTGhukd3tzQM2kFHFzy4+Ytt6URzkN0k3taAoYGW2kZH2Wj46kDjxa
         gnWZ0D46igC49/QujXvO8hIsDVKR8KuCx39T3BxY+QBmV3zne/7e1vKG5GcsSaVQy7+T
         sQlV768ITwm9YkIHgfHEuej8U73h9mD8lnkxcrlaJU5E5TxnardRczUQOp5JjSo3eZ7L
         2Hcu81Mpe2W1Dg4fznoed39us7WnzYeDGOWPx1iZFvlQoFIcpZRSmusIbo9pcAKfLiFD
         t2QxoXRNLXlAEzkspFNiA+qMonIq/nXOpftnWMLKwI8jroP1wHn+rViAZnqvm5bMV/uz
         TFYg==
X-Gm-Message-State: AOJu0YzXPDEO3SuBAD1/St4WYzWP3zjPtV1zaxHKmzlfINrLnZsPEUSL
	hHYw1WiW3WQ73GzIV4HfwgrWDEYiighqRK/HWAVqyR/toJyIw9KOtSdgsnd9DwHxJ1PeEMkVPDo
	sZOef++E/sOe9rRWpJu5neDg45uHnmCnljYjIEvdvpnR6kr8Bs3qnfkL+3sAP8yTdmWedberHCQ
	8cFpgGAxmGZP/e/5wnOKRGE6kAsMaY
X-Gm-Gg: ASbGncvQTZntNdTnhq8RlpHx9CrTO4Xi11D7UJonz51t69pkMWM3rnDDZSt2F6Hc9do
	Gt8JG05F9euhF2ULM0/k+sQlJZho30QYK2tIDT5DFPf80w4oQ3oAgyLnUEOPIO0Dzdht91M9B
X-Received: by 2002:a05:6808:218d:b0:3f3:fe33:9ede with SMTP id 5614622812f47-3f4247d625bmr3411253b6e.9.1740395804176;
        Mon, 24 Feb 2025 03:16:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH2GDWgaNTl8CuJ8q3iYUbb5Av5zB97J8p35QIiyckhPpbSG3bpmt9vnf7CvTNBaCxfEpZ1gIPS5MQGrUBOGhI=
X-Received: by 2002:a05:6808:218d:b0:3f3:fe33:9ede with SMTP id
 5614622812f47-3f4247d625bmr3411244b6e.9.1740395803944; Mon, 24 Feb 2025
 03:16:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250223214203.2159676-1-mheib@redhat.com>
In-Reply-To: <20250223214203.2159676-1-mheib@redhat.com>
From: Michal Schmidt <mschmidt@redhat.com>
Date: Mon, 24 Feb 2025 12:16:32 +0100
X-Gm-Features: AWEUYZlHN2na4UxHJsdlSUpeglLBeuo_KSFhHFn9_P96VhNSdfe1eDB2GGWnNB8
Message-ID: <CADEbmW3NXWMPBiTtX-v2XBLMTVgPifF9YW9qxJ=AkVYppfwiOw@mail.gmail.com>
Subject: Re: [PATCH net] enic: Avoid removing IPv6 address when updating rings size.
To: Mohammad Heib <mheib@redhat.com>
Cc: netdev@vger.kernel.org, benve@cisco.com, satishkh@cisco.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 23, 2025 at 10:42=E2=80=AFPM Mohammad Heib <mheib@redhat.com> w=
rote:
> Currently, the enic driver calls the dev_close function to temporarily
> shut down the device before updating the device rings. This call
> triggers a NETDEV_DOWN event, which is sent to the network stack via the
> network notifier.
>
> When the IPv6 stack receives such an event, it removes the IPv6
> addresses from the affected device, keeping only the permanent
> addresses. This behavior is inconsistent with other network drivers and
> can lead to traffic loss, requiring reconfiguration of IPv6 addresses
> after every ring update.
>
> To avoid this behavior, this patch temporarily sets the interface config
> `keep_addr_on_down` to 1 before closing the device during the rings
> update, and restores the original value of `keep_addr_on_down` after
> updating the device rings, this will prevent the ipv6 stack from
> removing the current ipv6 addresses during the rings update.

That's icky. Can you instead avoid using the dev_close()/dev_open()?
Michal


