Return-Path: <netdev+bounces-137532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 570D79A6D61
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 16:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8609B1C2208C
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 14:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313D61F8EEE;
	Mon, 21 Oct 2024 14:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="frkN6YdF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0B41EABDC;
	Mon, 21 Oct 2024 14:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729522632; cv=none; b=sfftRdgc1ksWlxjNObhxg34Z5dGpm3Xb4p8bZv/th53AGjkGYXZma6sdZV+Cu2iY96AYSXH8AxMMe3tLOMfwV+RFEfLY2bUJcyn/Wyy3lQeGadcDYC7gINcECeLsCKPtmUv+UnKTTyFOTOW6L9TpN+G9wQduLpZ2N83nhVVA6+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729522632; c=relaxed/simple;
	bh=XF2XWkvfGVbXYyXVhinJFu1m7SQIWE+VULOwx5F/dq4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=sv5KxJHM7IAWyBdeyelNn+2TByFNOMB35+28KyHWCSP5RjFbMbeVHXFU61q9vMNBfvLSzhNX0Nsy9Xkl4LrvlkCxeRfnOwa33duIl2+j48H2Ff/xlq/n+sOZvZPBtvhLSxEhdZUpLncx8SJJTvQ2PUWT4LR8adjJII0obj6gatU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=frkN6YdF; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6cc250bbc9eso33479456d6.2;
        Mon, 21 Oct 2024 07:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729522629; x=1730127429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NEbezSYTuof1BOLKPVcrMzA3XBTu7g/yrGOgRxbf9/8=;
        b=frkN6YdFy62Gfw8W1S0RKDrdTKztVcEcNBnaGzyeZygsjRxb0U8WG0Vh+puEC+v619
         aNh7VfPWL3cZD8Tis5I2ZBwYTqUEPCWx36pRHdfzlo5P2B0R9LYfIM9Pcf8wwr7OiH76
         y2W2sP+JG35ZMKuzTY9r657Lpo2cGdUkvziS8RJUitGf/ZpObTscbRptZpBpjQdqbX8c
         cUj4Znu2LhIAroabJa5/BNBHc98F7bScly5sZk4Ta7qxhvhqOw6mEkIr8BrsKx6j5D9+
         Fg6KPULkD6YbkfGb4YfXQeSTAIOxXwQS7tIcQ5BF5z71mCAfRPNe4Fobd9YS8GgfWV1T
         vd7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729522629; x=1730127429;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NEbezSYTuof1BOLKPVcrMzA3XBTu7g/yrGOgRxbf9/8=;
        b=TyEuZHgQocxnArgwcXuunipTh1Pr/0JIxw0opqJ8vZpzQfi4baY3DrytLdq0HsTa4v
         6beaIJHhHPEM9Z0+gqJF3iKG6wDMWfthMPL4OgeC3nZRlLo14wuEaQKrE9EfOgYFEAfD
         CdS+EmniOPoa4TEOEJcxzdgnGwNtZbgl7livVhMNwNtvTOMFaJqgVU9XJz5X30ct1DtF
         PbLHgvvdu3kkyEW/c3Tk1EZEXRekxqPSxvNdkXpPRjqxkDKuH3HvK3sPTpk7VuKGKsSK
         Xhjx30i1R3bDDA6vUMpTpxAUjc2jB4I3y6QkkK4n/V+pH1hXd5tAPrgPFn3loh4Op2DU
         FMRA==
X-Forwarded-Encrypted: i=1; AJvYcCU8amdAX19xsdmxFx2FwAiJxShHBo4j9gOlAX/luupV/0e/2No6LRagk+badc99n7Yw3mgwSJtKO28=@vger.kernel.org, AJvYcCUUghySoTRcN5Y7wMULu1DD4nHRg+A7xEjxR6HSkUWYvJc2fc4lIGdmcqApAoDojIWwhmGq+g23PpoYXzQ4@vger.kernel.org
X-Gm-Message-State: AOJu0YxUZmyPIc48NCUTfIyd4VvtsFZfdiarPKPqTvmvYbkBZqYdriCY
	yKdyBqSHE47lCAemjoXPz7bRREbWV2YFJNI46nfRVXDq9mfJVkXMmCck6g==
X-Google-Smtp-Source: AGHT+IHynfpi2UqtXTEDhAhXbSVrM1sWFE9vREPEGJSwrTg8//GGN5l5unzLUpM7R45sDk62UJbJfA==
X-Received: by 2002:a05:6214:4698:b0:6cb:eb66:c37a with SMTP id 6a1803df08f44-6cde163b093mr173326586d6.53.1729522629096;
        Mon, 21 Oct 2024 07:57:09 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce0099eaefsm17600426d6.101.2024.10.21.07.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 07:57:08 -0700 (PDT)
Date: Mon, 21 Oct 2024 10:57:08 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Levi Zim via B4 Relay <devnull+rsworktech.outlook.com@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: netdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Levi Zim <rsworktech@outlook.com>
Message-ID: <67166bc43e131_42f032948d@willemb.c.googlers.com.notmuch>
In-Reply-To: <20241021-packet_mmap_fix_link-v1-1-dffae4a174c0@outlook.com>
References: <20241021-packet_mmap_fix_link-v1-1-dffae4a174c0@outlook.com>
Subject: Re: [PATCH net] docs: networking: packet_mmap: replace dead links
 with archive.org links
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Levi Zim via B4 Relay wrote:
> From: Levi Zim <rsworktech@outlook.com>
> 
> The original link returns 404 now. This commit replaces the dead google
> site link with archive.org link.
> 
> Signed-off-by: Levi Zim <rsworktech@outlook.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

Thanks for catching this.

The original links are mainly useful for historical reasons.

I'll take a look at whether this documentation needs a more full
revision. But making sure that it works as originally intended is
a important for now. Agreed on approach.

