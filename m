Return-Path: <netdev+bounces-84627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6880E897A3F
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 22:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24B00280D7B
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 20:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C21155A47;
	Wed,  3 Apr 2024 20:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d+HHn64E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A0814C5B3
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 20:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712177278; cv=none; b=LB1k7luRVe175b0Qf66lVBqJscDKZOCo+Ufz65zUWNVQLFy8YzTKU/Q5rDPQKjisBZO3e3Seos9120tjHk5HwQIqYIPFdSGGpKRTglxvEqtx9pe2GG9SasnVcRYONso++tSSSEOQjm/KhDYLWg+VxuJO7Y+jzV48kfXM3rxe008=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712177278; c=relaxed/simple;
	bh=xXfTtETKgSHxVpuLmD8VVq5lzdJjIlJDwo4XjtYHaeo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CcKCVGPl8f7uRRwK8GcHe4VJKwTeY3vXVajqd9iz+CklWCvWLVjGT23K58r/CAk914ySyg9iEXqXiDh1ktTuNE64gZezYQEYX8/3p4FPIwwvGnFSovmeXMrgRG0jBrsz2ULwX2gWpxgOQ2ZCPNai9H2MVqz8IKs6UWhCdhDJJxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d+HHn64E; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3436ffd65ebso139088f8f.0
        for <netdev@vger.kernel.org>; Wed, 03 Apr 2024 13:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712177275; x=1712782075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nwDpKmTTJNDnnAgdVwMlrzCvxWZ0xRelrdj5eIlii+A=;
        b=d+HHn64EYNg2B4txXiF27j/5WIefoewJTJa+NpV6kOsBnuQ4j8l6WI9FPe/YPoWP/r
         NzkhqDCQ2yZ+Y3PK2fJPWZw/v14Md6X8jK9NvMQl6OakZSvyVtSqDC20kwbHhT5W7dFo
         I/QTKXwsQVlJ/yJlrInauV+ZU/uKUw83gln9HjRmQ+bfe5KSH+lVXuwCLyfqPZIPPvnk
         ZEQ3oiuz7NihjUrxyy+4v5b1mrs1zZKctLQIEnOIW0fZNoorNO74sY5GcjSvSsFSGwex
         oOCavewCjBt+H6kG5sRIC+jiyg3alv0MyJ2B/Oyij3qfyCYQqkrhrMwaJ10BtGIc4x+m
         z5ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712177275; x=1712782075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nwDpKmTTJNDnnAgdVwMlrzCvxWZ0xRelrdj5eIlii+A=;
        b=pQRNMb5JXIth6e/4JpVzgnTCcOpGTs3WowgL8qAuDN5lRC1YmjiB8Wreh2RRgFuvHW
         i18JQPubpIF8CpoPwN1gQkZAFqHVuOmAih+cVL7pGR7e8gb7Jpetue43McOz+nTxvMvz
         kPrSckx/6ThYDOQ3Qv5oTlTHzn/nCxuHbsb+2reAEPDFX0iJFxzUr7tY164YAhD1G3XY
         3KF/FThTWOu8miFItpjzeDBzI6swEkSfaJ1xDd5/uQiie2TIctoIwUwfD8Uuo0Phj60r
         PSFYYq4aexJDFoTxdsza39bX9VZglOUXhFJESrHOL8Bl8/bgcyinpvWwe2rNN4I7obAp
         MgaQ==
X-Gm-Message-State: AOJu0Yz4Y/qTh2gCBp4s82Bv1RZgA7Ik8E+sYOiCTc51FbwQBhGtN8o2
	vwiQ7G/NIbLicv8j1c8SmKuOGI47rOrxKRZZmOMKnRLfImOHk9EjRnvXjWkoU3uzlj/oJEmDstO
	U6d3eYHctegN2G1kwRQD+DlHnRc0=
X-Google-Smtp-Source: AGHT+IG7ocVh4SRHtXbuYIfrqq9TkBpQ64Y0F+oSmNNSMQhzN3OG3DtzNKd4v/DMMdBNXzxIq3j9xgNunVy3a2NYJZ8=
X-Received: by 2002:a5d:628f:0:b0:343:44d2:3828 with SMTP id
 k15-20020a5d628f000000b0034344d23828mr529659wru.16.1712177274953; Wed, 03 Apr
 2024 13:47:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171217454226.1598374.8971335637623132496.stgit@ahduyck-xeon-server.home.arpa>
 <171217491384.1598374.15535514527169847181.stgit@ahduyck-xeon-server.home.arpa>
 <7b4e73da-6dd7-4240-9e87-157832986dc0@lunn.ch>
In-Reply-To: <7b4e73da-6dd7-4240-9e87-157832986dc0@lunn.ch>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 3 Apr 2024 13:47:18 -0700
Message-ID: <CAKgT0UeBva+gCVHbqS2DL-0dUMSmq883cE6C1JqnehgCUUDBTQ@mail.gmail.com>
Subject: Re: [net-next PATCH 02/15] eth: fbnic: add scaffolding for Meta's NIC driver
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Alexander Duyck <alexanderduyck@fb.com>, kuba@kernel.org, 
	davem@davemloft.net, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 1:33=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > + * fbnic_init_module - Driver Registration Routine
> > + *
> > + * The first routine called when the driver is loaded.  All it does is
> > + * register with the PCI subsystem.
> > + **/
> > +static int __init fbnic_init_module(void)
> > +{
> > +     int err;
> > +
> > +     pr_info(DRV_SUMMARY " (%s)", fbnic_driver.name);
>
> Please don't spam the kernel log like this. Drivers should only report
> when something goes wrong.
>
>      Andrew

Really? I have always used something like this to determine that the
driver isn't there when a user complains that the driver didn't load
on a given device. It isn't as though it would be super spammy as this
is something that is normally only run once when the module is loaded
during early boot, and there isn't a good way to say the module isn't
loaded if the driver itself isn't there.

For example if somebody adds the driver, but forgets to update the
initramfs I can easily call out that it isn't there when I ask for the
logs from the system.

Although I suppose I could meet you halfway. It seems like I am always
posting the message here. If you would prefer I can only display it if
the driver is successfully registered.

