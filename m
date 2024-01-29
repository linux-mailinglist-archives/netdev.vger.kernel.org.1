Return-Path: <netdev+bounces-66813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D47840BF6
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 17:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC30C1C22F12
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 16:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE3915697A;
	Mon, 29 Jan 2024 16:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MevcjHxZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22AF15531E
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 16:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706546636; cv=none; b=fyyhLYI6NbuvP2NauqnjXbfSknj0yKDftiozveG0wqpPMGJBX2RUQL+uxilG8S9bof7zEpUFGfzW4Ce4HZPvRZs1OJwmslc+tQFAdig/JXy3Na/YzPwhy9DN9zxxCM+hn3UoD/MoLmHHPCw0TVuzBdmfta5e6dlhskkdUSESlo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706546636; c=relaxed/simple;
	bh=QOSp0TVjLDIEYg1JmkEEci9I6bi6XXfpbscbDmazf6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kw3QD2cxItTTjDpCkPZ4PWqMxXsLcrb7PIJBbONt/29Ui8zhdKdMStLW9eIgijtCki/B+u8svV9NJC73BdT6e+sVrHnBNigZOYICc3zRTgC8R5kYJjX5897XJ3D/GW2vALEKbyddY4OPYBDFF6laaVYvUdEMehaQYJZI0Q1vai0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MevcjHxZ; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-55f19a3ca7aso1143049a12.1
        for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 08:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706546633; x=1707151433; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QOSp0TVjLDIEYg1JmkEEci9I6bi6XXfpbscbDmazf6c=;
        b=MevcjHxZLqdkz20gJegXMZUfT4gNBQM0Lzby3Y7BCUqnOSuxKMDmahZreCFcS735UK
         0FjZMnMOI6WVSQaMAiPiyiq0BNx7gd27AQ3zDcK6yQnSq78Mrxi8TNOak4wqIOcysVYM
         2V5VuTi8prl05flm1DZrEVWDjxmyBlQ2SkDjiemetuZduUQsMxOuKYdqd0sfkhkVWOgG
         CvSa4NtudyGRU3fofR4SsYXSDC/ti2Y7WtuBR2B3J/Q7DtjONSEOFSJqjrzjLOT6oEh3
         o0mB0nZwQdmYsoRGr5zWEcU2WxXX3/zEtkP/rR0T+txFYJMm0NqKEYFY9keyLqik8aEF
         Nqrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706546633; x=1707151433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QOSp0TVjLDIEYg1JmkEEci9I6bi6XXfpbscbDmazf6c=;
        b=ERXQ35MQavaYCg+Yy3x1PgZb5khoNg1MdUEz5iODuK9cRH3oM/yKUWkMkihW0cEeg3
         ughriJLzOLKafK/vVP284BBSjhJtvpEJlwujadPTUoYwZwmseHULwr22oysPpae27Yw2
         zDq9TyH2cAHxqlZmxzrkqtCgCvMxtQEHMYKGRQliaoUQB6rIlzFcZF4RuMpxYtnF4u+m
         6EnW2g231c6oIca3+5PjRmMtYs5ap6vXajSouKT+Hy9D9jYU4Z8fMuwDBiOxhV4ttfNZ
         WSDH0gqihfqNJpbWrPLzE7YfsXh9SfKaAB/DiyA8/htzPA2z2cpTlUTcqmcdmApiDLem
         OmXQ==
X-Gm-Message-State: AOJu0Yx9WgyosfNknUBJ2YfiudkFT9VQYe9v+Qq9pFhxNaw3/+TN7Ly2
	nTbu42aZrd16kW3sWdoL5B9lwvpDYCJEAUlUtKhSAQenweickOm8
X-Google-Smtp-Source: AGHT+IGVkWs2G0GgvqZOZZDEjs7sNWg2//Kwa0I0AuC2N9w1OgI9jVgNNc3sOAX6kKNzrUTIc3/mqw==
X-Received: by 2002:a17:907:cb87:b0:a35:5b80:18dc with SMTP id un7-20020a170907cb8700b00a355b8018dcmr5734747ejc.2.1706546632826;
        Mon, 29 Jan 2024 08:43:52 -0800 (PST)
Received: from skbuf ([188.25.173.195])
        by smtp.gmail.com with ESMTPSA id ti10-20020a170907c20a00b00a35b4edb266sm1329543ejc.87.2024.01.29.08.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 08:43:51 -0800 (PST)
Date: Mon, 29 Jan 2024 18:43:49 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: Luiz Angelo Daros de Luca <luizluca@gmail.com>, netdev@vger.kernel.org,
	linus.walleij@linaro.org, alsi@bang-olufsen.dk, andrew@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, arinc.unal@arinc9.com, ansuelsmth@gmail.com
Subject: Re: [PATCH net-next v4 08/11] net: dsa: realtek: clean user_mii_bus
 setup
Message-ID: <20240129164349.rcuj5hvmoqtzsuxr@skbuf>
References: <20240123215606.26716-1-luizluca@gmail.com>
 <20240123215606.26716-9-luizluca@gmail.com>
 <20240125111718.armzsazgcjnicc2h@skbuf>
 <CAJq09z64o96jURg-2ROgMRjQ9FTnL51kXQQcEpff1=TN11ShKw@mail.gmail.com>
 <20240129161532.sub4yfbjkpfgqfwh@skbuf>
 <95752e6d-82da-4cd3-b162-4fb88d7ffd13@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95752e6d-82da-4cd3-b162-4fb88d7ffd13@gmail.com>

On Mon, Jan 29, 2024 at 08:22:47AM -0800, Florian Fainelli wrote:
> It does seem however universally acceptable to stop any DMAs and
> packets from flowing as a default and safe implementation to the
> upstream kernel.

DMA I can understand, because you wouldn't want the hardware to notify
you of a buffer you have no idea about. But DSA doesn't assume that
switches have DMA, and generally speaking, stopping the offloaded
traffic path seems unnecessary. It will be stopped when the new kernel
sets up the interfaces as standalone, renegotiates the link, etc.

