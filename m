Return-Path: <netdev+bounces-89431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB3C8AA42E
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 22:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A708282360
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 20:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2080F1836F3;
	Thu, 18 Apr 2024 20:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="G7csDnwp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60A22E416
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 20:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713472818; cv=none; b=HRKcf4+Cq3JMiI9Ra8a922yRbjIkOjT+HlsEdTmYg/HFuPR+qajolSO6BYxu4yowkauWs25GUUc83g/50kKA46X692XTfkf7ZfpV8eSEr2ZWqHFAyQmIcCiLA8dhBjH/98FtrRLSJwYidNMzVic4485dZMe/iq3OO/r/nnrOEng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713472818; c=relaxed/simple;
	bh=00/ufMs1+Xx2AccIYbXrYDK6m6xU596GkiMgesAyWME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RNOEWlQlfJZ421f4ZY3b86YC8M8pWOUbzsyjXmADg5QhNZukNCP/SGAzr91dQq8TJRwOkCcdvhAmEEPwAa9dR4ihRhPmBjbK5h1Sa0PgZbz3cijw9XF3pUXd9+0+DTx08rCTuVF27XNANYd+J/Cdaah/nqbkTVbrUdBxQi3/DRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=G7csDnwp; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2da88833109so19678951fa.0
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 13:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1713472814; x=1714077614; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=skhLuDKlSCdODlSvgl5qYp5ZcdfNeBvD4iVpL7mwIe8=;
        b=G7csDnwp3NnAS/E5kdYKR8EYrxpsmimZzLwSzet2wRUvqe0b4Q8Kv56drbQcG2Z509
         d3NGYg7N/1iaAhSnVJIc9djmaHkeyvX+TbAOaftiA4TI7deeS1vYeqqPfvHjoHg09el+
         HE8tr3/AztgHsnD2isNU5DDTS6J7XfF0X+xpU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713472814; x=1714077614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=skhLuDKlSCdODlSvgl5qYp5ZcdfNeBvD4iVpL7mwIe8=;
        b=j8fYmRDCxvkqcXfrFYW9gPYNYSdHUArIH3g4/g6bVz4mIeCaJWBQOYEDs5AUYB8h8y
         E8SWkIgxhroeTXJi+0Tsnn8LPTXO4ycMcUEpd+RcF/UAsiQ8INK4v14qri88EWV6mSEH
         7/t5oKHmOi0NCcrx4RBN4FNtRtH/5jdy5WN6yobtbwS/QUFlu7tNiF9uHC2bfyd9ec2o
         vHML9ZCn7VR9AFivUQhX4rwOpHbxYIsthVHLEpaFGFgm9mAwSJ13wQ3T+5lnSAotP2M9
         XBi4mbiCE3u+0en0c0gIqyL2f7vSt/pOKOV/NY8/lSp8rvhPoA6KgKHs3B2LJyi412vO
         avNA==
X-Forwarded-Encrypted: i=1; AJvYcCUHcHFLEyjOqJuhYm2MuOS+Ak6ju5r7qfCMDhYibQU+ffBjnBYCjjPj2ZiRJemZMc4xXepQqaJfFQQYbtAKZ51W0TYW5eZ2
X-Gm-Message-State: AOJu0YxJG361Vf9wa0LMFxiN+Q4Jd4fEW7Yu704jOPmMp9Tmr6Cy4dsM
	go/qX7L56vWrFLJUYtwFN9DyU4BnNZ4zwboQjJGCS8SLibJCHa7f58AHa0OfhBwYFv//hQf+5sy
	cgy0+egG0WT2OuE5e4idUKscrtAs3bORdshvcT01W+G8shQo=
X-Google-Smtp-Source: AGHT+IEydvJBYIeVv36fv2ZnFX6ETxI1kGNtWukT6MbAQShYhS34XSJWofY92AQ/yvZLqkPxSORKyg8Ue2UxBwZy/MM=
X-Received: by 2002:a05:6512:34ca:b0:518:d5c5:7276 with SMTP id
 w10-20020a05651234ca00b00518d5c57276mr83537lfr.58.1713472812862; Thu, 18 Apr
 2024 13:40:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <871q72ahf1.fsf@a16n.net> <e5d3c578-6142-4a30-9dd8-d5fca49566e0@lunn.ch>
 <87wmou5sdu.fsf@a16n.net>
In-Reply-To: <87wmou5sdu.fsf@a16n.net>
From: Michael Chan <michael.chan@broadcom.com>
Date: Thu, 18 Apr 2024 13:40:00 -0700
Message-ID: <CACKFLi=geVU6TSciS37ZvGuKn0xzrk2ifsuytvPGubsqNMNk_g@mail.gmail.com>
Subject: Re: [PATCH net] net: b44: set pause params only when interface is up
To: =?UTF-8?Q?Peter_M=C3=BCnster?= <pm@a16n.net>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org, 
	Florian Fainelli <f.fainelli@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 1:27=E2=80=AFPM Peter M=C3=BCnster <pm@a16n.net> wr=
ote:
>
> On Thu, Apr 18 2024, Andrew Lunn wrote:
>
> > Please include a Fixed: tag indicating when the problem was added.
>
> Hi Andrew,
>
> I=E2=80=99m sorry, I don=E2=80=99t know, when the problem was added. I on=
ly know, that
> there was no problem with OpenWrt < 23.X. But I don=E2=80=99t know why. P=
erhaps
> the behaviour of netifd has changed from 22.X to 23.X.
>
> So I guess, that the problem is there since the creation of
> b44_set_pauseparam(), but it has never been triggered before.
>
> So what should I do please with the Fixed: tag?
>

It looks like this dates back to the beginning of git.  So I guess it shoul=
d be:

Fixes: 1da177e4c3f4 (Linux-2.6.12-rc2)

