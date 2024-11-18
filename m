Return-Path: <netdev+bounces-145984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 156D29D18E2
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 20:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDE862824D0
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 19:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6195E1E493C;
	Mon, 18 Nov 2024 19:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Mt5cq18N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06B11DED64
	for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 19:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731958096; cv=none; b=IenrDkS+IUYaMbkXrDOlNJtrI/ZVpTV6rr3yIRw1vDtkoZ0YTPYETHhU9nfpKN+8akHB9MnLtZO7XBrX8DmgHvItVicuchMe7aOqq++LSrzZGxzeLjSt6fDCLUZn7HYKbKBMDC3CCRdPEM6219Ovgu8mnnE0DW+Ws5eu3COpEbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731958096; c=relaxed/simple;
	bh=hcgwkTCp79b1DCsjcYjhjRELBWe7RVdQaNEQOIUKc7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ow6YDjJNocftGhE0JkwELI5Y2Cl3/8FuUUNa7GkC3b1Q+Aaxn9J1S29hiTLPxURZTZahfuZ/zWNV5r7eyUjsgCKSIdxqblKSNQ1ek3ACqS5JnvGwc32mtWO76/JPUzCsLKWntoznoOO2So38ZoAjxgMUbV+YPK2xxa1b4CKjubo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Mt5cq18N; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9e8522445dso402850266b.1
        for <netdev@vger.kernel.org>; Mon, 18 Nov 2024 11:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731958093; x=1732562893; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2pcLDdAbjtm+SGh+6c+WCUOCK4EOF8hgLIEcUEGS3yM=;
        b=Mt5cq18NBUUwKaB0nQHI8jO+dNur7IZ1EIAsTbRO29upPRk6j0CK1yPq9b7BDQGmKn
         rmBfO5CVyXfpMjbSXFviuoi3NtUcixPlkQ2Ge7WsuAIO+NWQRXzJsgZqeRjwpLXNJxmB
         LrB0ROF688swwrlwUM1e1kfC1Dcxl1ZyZFAJBgKiviPClXn0prwUrztPpmI5CWB4sstA
         db2crq/2ghcqUx5SBcmVqwhU14VE2WErsft9fXJ63rEgMIVcjppEzvkOuqvSOdAmNuaU
         MgJEejtMEG7LMLCZ9UbgcXZ3DM/wHgll/GJOso9g/t4PFrXYaWfxdJ/8cHGvD1U18Lpl
         WHHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731958093; x=1732562893;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2pcLDdAbjtm+SGh+6c+WCUOCK4EOF8hgLIEcUEGS3yM=;
        b=a2hiXF88ZPD9/jXNYbcSTk4+88zb1EY/Kpnz3C3RGYLErwYwHwys3xxepd3KcJ/pyw
         JY1X6XSv7s01/UlH/G29rtygPF+ojrFi3ika7R9KPJa1ZElgkH4pQUzldgXYJfbVisoF
         Mksnke3u9ROOOgLTwptSLc5JrEPnb6t6TmS+1Z+IAEIvK1qdZ11OLuQDiqjG+H2KEAv+
         k1BhuR4G4imr6IgC81iH29AfbKG0k40Ihq7KNnaMGETnze2/xIVUX3c4GcPk7ualsGwn
         sXyaLUuVE92RUsLhpBlSL4Bp6pr/cKCqVYXLWoX4t2DvqBe9rXAwyzuMumjLWvcR5pxQ
         jY5Q==
X-Gm-Message-State: AOJu0YySMqxBzT1mESFRY7+oiF6VudCneUauHLd8/MV7QCyxt3TQ4DDQ
	tNt0oi92cVFZ8EBtOcww+frgO2kfYLZVUjpL4b2SDiJ2HhTc/cSs7I3Wb2S4sU5a9uWcF+o4Ri3
	56Mh8ozersez8ECE1SM5vzSORqn3xA4zdKsKb6Z2y+qI/bwpPKdYdL1M=
X-Google-Smtp-Source: AGHT+IFqFTbN960Hz4kc1DaB5/Jix2Kw8Myr0VZXs5tDIF2yZEJb2CZr6F4dTremWsccEQRiBqnqqk10ky8PZXTJxn4=
X-Received: by 2002:a17:906:daca:b0:a99:f675:b672 with SMTP id
 a640c23a62f3a-aa48347e831mr1071876766b.29.1731958092962; Mon, 18 Nov 2024
 11:28:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112192249.341515-1-wangfe@google.com> <20241114102706.GB499069@unreal>
In-Reply-To: <20241114102706.GB499069@unreal>
From: Feng Wang <wangfe@google.com>
Date: Mon, 18 Nov 2024 11:28:01 -0800
Message-ID: <CADsK2K-Fi7U+OwRquyjD-mwwVuiqaUk699g9zEJCdk_HA+tPYA@mail.gmail.com>
Subject: Re: [PATCH] xfrm: add SA information to the offloaded packet
To: Leon Romanovsky <leonro@nvidia.com>
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com, 
	antony.antony@secunet.com
Content-Type: text/plain; charset="UTF-8"

Hi Leon,

If you are concerned about the case when if_id is 0,   I can make the
change to add the SA only when if_id is non-zero in the .  When the
XFRM_XMIT flag is set,  validate_xmit_xfrm will return immediately,
there is no need to check extension and flag. Are you ok with that?

Thanks,

Feng

