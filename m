Return-Path: <netdev+bounces-106602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82456916F26
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 19:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 512F41C229E9
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 17:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82369176AD0;
	Tue, 25 Jun 2024 17:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Evts+dwQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221A3176AC0
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 17:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719336302; cv=none; b=sUreTQZL/tx1uZK8RvSsEY9JMyD81gLtQm5XF5LgYwaIqWyqQEEpcweYXsL5GK3loB43Gx0sUCPLRKjJSpIHU4l/p+PZKjgugY1+kpamnHTJsaRW+OWP43DOTLGr0r3E10IMQ52yHi/2aTNoV3+bXIqFt23QQaY2tuqW8vXpztQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719336302; c=relaxed/simple;
	bh=K+1KMq3hsVQMJkShpR2cXlDyfTtxSLNMBwn4drbtfy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TTxpVTlY4bq16x3zP4Z8kCn5bkJrxvElzL8+Ap2h080/cUPGx4mIAvzYv7ixZtxwv8kD233PtsiuP3+hcpt4yKnw6CuAHi2HoCssBJW02PxEPpDWZ7Grx1nUiwGlYELWIpoom7AaT+7gDyAcv5aqVv3iSRO/IqpjBHeaZVyOgJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Evts+dwQ; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-25ce35c52e7so554060fac.2
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 10:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719336300; x=1719941100; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=K+1KMq3hsVQMJkShpR2cXlDyfTtxSLNMBwn4drbtfy4=;
        b=Evts+dwQaOhPG6xX0opFRjU7oJoz70QpcH6BCB9CBfTMBKvImAUXtAK0U803AekpjF
         1QAKqAZuQHyFhmiov3t3eL0FFGvkKQbli2kmDRnJSjP16MgoLQBrThJKGPgG+afGftyt
         dxmOSOLUr1h4FbAbrE4rD9VAt0hvOygXhYev1DM5pbgaDEqvmtlTB/HUQmj9vmgUZ8O7
         ioY00B6EzvVnWom+KapsBNSJCHi9YJ9L2ZAS+5AOCLl4HvqgsdZY+eTOAPrMjpNwTGIW
         l6z8k5bPr8uCH2j1wppeOF4YLkfzApyuGyBnjXqtunZaKf9RgjAO9me4V9MUrfNhyulL
         yPJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719336300; x=1719941100;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K+1KMq3hsVQMJkShpR2cXlDyfTtxSLNMBwn4drbtfy4=;
        b=a0xNsbrhgdnB/ybhnXVczfZ9CBt5m6qPoOtXGcdx/xhtrab2m7HsLnYt089hGfiJfr
         XPcHNxT7AV2e82ZpAsxkjYOffx1ooEBDWdBxamySWaffXqnKrA0zIHUXPhIx0sgKN9hR
         Ol+tlJVVrOiCy+MrCtvraeb1X3IestQrovSCW90RB7ox3/TnOzFng61R5DbWobJKEyMt
         nLLbLyysVzDyhxmmSoL7TZdw/cOW7qmJWRXaVf+cJ7pTVHP0qHthGRGQ8FXmAUphZgLd
         K/XY8FBhkzwzei4baJiowNOZvpvup+TrtgBgcAwHF0C34ACczcCgZRXzEW/5iEkTTF/H
         dvxg==
X-Gm-Message-State: AOJu0YxPLvaVm4oapVLVjfDjOIW/zTJRMjFcnCsJuG4KcDee6x9kyy/B
	V2o5bazDFNO9lv9d0N+iizW9ANv6Zca6ISsmS/ck+GGK/N6+MGYas80NU1uo0+9F/f9TH7IGjqt
	sGy0kLgpIoihhcMfUykv9ECWztBShHAC/
X-Google-Smtp-Source: AGHT+IE28I51vxw0khfEBghQWeM3cUmAu+A+/rgZ0kJdSiFJN/L4D42fz2JktGTX2KYS19yXBm/GtyOjK6BlTqIkEnY=
X-Received: by 2002:a05:6870:8a24:b0:254:cae6:a812 with SMTP id
 586e51a60fabf-25cf3f17d37mr10776213fac.3.1719336300126; Tue, 25 Jun 2024
 10:25:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+Sc9E2oKba+C2EhBvmyJQ5wVS5=S=ZVzP+Gt_-xsRNtMCm4tQ@mail.gmail.com>
 <20240625075715.3f61ab48@kernel.org>
In-Reply-To: <20240625075715.3f61ab48@kernel.org>
From: Michio Honda <micchie.gml@gmail.com>
Date: Tue, 25 Jun 2024 18:24:48 +0100
Message-ID: <CA+Sc9E2-1S3_b0zFsgmicYOj8FrCMiJWenJbBuE+EkxAjZV4ag@mail.gmail.com>
Subject: Re: [PATCH net-next] tls: support send/recv queue read in the repair mode
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Sorry, I didn't follow. This patch makes ktls repair (serializing and
restoring the kTLS/TCP socket) work together with TLS_RX and TLS_TX
get/setsockopts. Am I missing something?

On Tue, 25 Jun 2024 at 15:57, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Fri, 21 Jun 2024 12:05:45 +0100 Michio Honda wrote:
> > TCP REPAIR needs to read the data in the send or receive queue.
> > This patch forwards those to TCP.
>
> TLS doesn't support repair mode. Life is hard enough.
> --
> pw-bot: reject

