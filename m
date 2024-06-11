Return-Path: <netdev+bounces-102451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A38903130
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 07:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FAAE2895EC
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 05:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3937171076;
	Tue, 11 Jun 2024 05:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VgkPHXWa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B23433C4
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 05:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718083859; cv=none; b=Hh1At4CTqkaYQcQmLbIWVxJWtOmD3mLqq0obOWBwtospmSMoe9AEGw7Wm4CtQQ+uogCqtz0Vn/IxOB1p7jdV/eEoA2hUe9GXsgBDPNll3jOVmMs8dirOIXTktyH9yUO8SyRS9l//h2tBNRIQhcOPRwDIMxLXBpgViwrRpDKvfWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718083859; c=relaxed/simple;
	bh=FRmLUy3vdWcYPP0sfg1A4589VGHXaeZ8BEmwZ0UZ+Yo=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=S/QdB5z9mwx0EdIyQMQenhyoyjMdkSFtwSFcsBTB4Y5NV0m73OQM/faeSbBjRZmrRzBcuiBGspDSxBaDD2Lm4/LC3UQuf8gJwUYs8UHaOZ4Et/BWvMWfyu0m2xvUq7UpJB8pqI8YIOJkYiCB5W8mHme68LF9/AaKogj5VkOeN7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VgkPHXWa; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2c30a527479so328654a91.3
        for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 22:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718083858; x=1718688658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jz7KJeRGLe3HMzvun5AT1c/3pa7cTHGJ/J1oz3p8vOw=;
        b=VgkPHXWapdMDXDBKeLpSb+gwJUnhUIyah+E/04nsvX2paR4MqJEaru782nShJd8JCk
         0f1wYgJh5MFcfjtrSMZhLwtvprkPLXoDUvZVS3Npt/4R8hHrGg09fpJlgs3oNuuB7CGs
         2Ns2qh8r8Ai660L/chWrho2iZHtLmktVZ9g/pEMAGkDZZL8UXzbG6TLL1Z26S+W42UXl
         Wc3gnMAI0CgjlgkvjOTBZJNk5tsSOZ+ZoN5A9kD2zUso7145+JkBEoZmC9YcWhG+xxfs
         aSimM/Xub6+3JFR06NtWpgLBR+EBktW3IZR1bedaaLuNhNed5uc7wW1mbnD5xl/Ib1Hc
         14YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718083858; x=1718688658;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Jz7KJeRGLe3HMzvun5AT1c/3pa7cTHGJ/J1oz3p8vOw=;
        b=ewAlLrAzO5/1d59ouMRZeF2AlIyA+NRd2hKbd5BBc2aRavucJO1bLf9YK6aSwModqp
         9NrlpM6NhqjErnXyEK7mLdHm7uFpfzbqben+YdVvYyCOozH4FBaNeRlobp/5cx42u56d
         C5GKGE60do6Tk7ZyeNclZFtY1oyBHHPFn5tEoZckQu4w0lnwasgZ2Nfq+bfKgKiC64ZY
         Xi//nQDiBvgMU2CV1cWudr/VAkLi/HizDeLPJFitXRjHMTr/0Fra0VLFiX2DNDWy63CP
         j66GaeZTGx3yoZgfYJJa3GM9hTQt3n1btm7OjLpe/m7hS7ojkyRjEWlxz/I++czPKWBu
         h4lA==
X-Forwarded-Encrypted: i=1; AJvYcCXdL3mbuL3xL+5yg5D457SWN5W8hRd8bXlWFZ6Wp5tBGug3IK4kXYEK6Z4MJLlafFYEWCs6MLXqOaHR+LBNJx8Wq0CN/2zj
X-Gm-Message-State: AOJu0YxTOV5pXxXnIqniDw4uVnHQKdZQouazc9BXZTt9IhcmmGMqdroU
	O+TT6s7/lnxf4M+wIUrgaknPgccwCZkn/uM21EaKTbjg6CSaTW1v
X-Google-Smtp-Source: AGHT+IEVE/P+GZyD4oxyvMb0a/pP1O778YuoW904tL3ndISSjt2NvvXpvXOcWHWZRwxwF2LWyLxuag==
X-Received: by 2002:a17:90a:5ae1:b0:2c2:c352:5273 with SMTP id 98e67ed59e1d1-2c2c35254fdmr10147299a91.2.1718083857723;
        Mon, 10 Jun 2024 22:30:57 -0700 (PDT)
Received: from localhost (p5261226-ipxg23801hodogaya.kanagawa.ocn.ne.jp. [180.15.241.226])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c31d46fe2dsm2011055a91.26.2024.06.10.22.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 22:30:57 -0700 (PDT)
Date: Tue, 11 Jun 2024 14:30:42 +0900 (JST)
Message-Id: <20240611.143042.1029627013637247866.fujita.tomonori@gmail.com>
To: fujita.tomonori@gmail.com
Cc: hfdevel@gmx.net, netdev@vger.kernel.org, andrew@lunn.ch,
 horms@kernel.org, kuba@kernel.org, jiri@resnulli.us, pabeni@redhat.com,
 linux@armlinux.org.uk, naveenm@marvell.com, jdamato@fastly.com
Subject: Re: [PATCH net-next v9 0/6] add ethernet driver for Tehuti
 Networks TN40xx chips
From: FUJITA Tomonori <fujita.tomonori@gmail.com>
In-Reply-To: <20240611.135442.1008031498769485601.fujita.tomonori@gmail.com>
References: <20240605232608.65471-1-fujita.tomonori@gmail.com>
	<7fbf409d-a3bc-42e0-ba32-47a1db017b57@gmx.net>
	<20240611.135442.1008031498769485601.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Tue, 11 Jun 2024 13:54:42 +0900 (JST)
FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:

>> feel free to add my
>> 
>> Reviewed-by: Hans-Frieder Vogt <hfdevel@gmx.net>
> 
> I added your Reviewed-by except for patches that you've
> reviewed. Please have look at the remaining patches in v10.

Sorry, I meant, except for patches that you gave review comments on.


