Return-Path: <netdev+bounces-209278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 251B7B0EE2D
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 11:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 356573A482D
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 09:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A2D22541F;
	Wed, 23 Jul 2025 09:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SUIzAFeb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3870E247DEA
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 09:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753262209; cv=none; b=KNP0l7h4XNoEFEiEK9RDRONcM+bNFI1yKg+h7/nvrCEDVYcbIosv3Q8Ib52DpKozQKSGt+e72maUxQROcO7CHjllsV6r9EWbSR99MniB1AB+zsUaRTBYxwNKGg9fKv/U9JW1gFYD5vCBfL0JhpHmTjjLAtQyTRJgMuLkZU+V4vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753262209; c=relaxed/simple;
	bh=heIxELqJMvNMFec+/799TQQ6cct4aoBx86NutNIU7YM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=gbTLay0LZ0Z5jxdquHwukqtfuWbZlbY4Qq+764DfgfYJnyOZ6+iWBBvksSpHpDLS0r/T8fBCIXoV8ZV5Ufrzgrzffg4wED5e8eff7XbBG53KrZRRaH57g8PRWQshCWeo3l4NpmqGzUIV6tU3o900M/wpHtzcjQvLq/PsW2Vfd5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SUIzAFeb; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-455b00283a5so39388935e9.0
        for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 02:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753262206; x=1753867006; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=heIxELqJMvNMFec+/799TQQ6cct4aoBx86NutNIU7YM=;
        b=SUIzAFebIIcopWi7aS+lyBpxJbjhbXFtO2l7LxjDiVomTcnGbV8kLptkS0xbZ6PGtB
         ezMSKOX0C3xj8UyxWK8N201jFvcj1m1DliE1tVXeRL4yc5ITcwgUEtW+dUyk7J0slvTh
         Dh7MP3IWXiQ8oEdIFta8WXKMCDUlSnm2lCkSoN77mhfDkizuPfBYcFJ2m61Vyd96J/Ot
         MzLClfnuH6HRQDjySZb/gvnCI3ofnAMFePRa6UAeuMK4rfWtWzIo5+nCbULocplydXv0
         +hF5GRXAscvM6KGZGrD1bESjDOeuA7e+vDD8mCGc+J4mJ2Jjbhd+446XstUtMSl/6/wA
         qCOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753262206; x=1753867006;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=heIxELqJMvNMFec+/799TQQ6cct4aoBx86NutNIU7YM=;
        b=w6Xy0Jc7QcXB7JpUtXu6W9CLToUwZiPF1H8gb+Ox14lo9CtwAcfisYvIYsyhmSe/tq
         hVAZg+Aot9gSWxiEHcMKTfQVwVaRaG5Fo5LsH8SFCIz+xRRbDmSPNauocZywM8BgPv3S
         Jw19rRCeu8C3JV+ww8RAXRIiR+ShOA1PUQg+CuzuzmMmkT2mpf0gRwjCiGy1ZAlbVvIP
         EydCduUiKioNIYGhE+iU/41weM5fIxkb6Ro9KXA+sq7LY3luFQVaWfQkBwLws1tIBql3
         MMlBnjuR13LCf8rcWDX4JRUffWlzZ5V8Xgev2KvpVmofal5OyeQg6vK6UZr4z/FjBdRK
         j19w==
X-Forwarded-Encrypted: i=1; AJvYcCU82xZu9zBIjHTCRzRXBs0UPpl0X8R69FQpxlUj3Nm6Q93GmNfRhTRCi//A5XeXsPYvVOFfs8A=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd40/I2lKiw9lFUjcQziDWczHpzSWwt92hmwBVmSUqZqc9vFI5
	FRRciEGI9gXf6AmmmJcgQHvoV3JnZdkSbP7nmilv8mOrgZOGaumwC2tESArVvg==
X-Gm-Gg: ASbGnct8OFT9VCDF/4/07I5Yywhu/EI/7wuze1T+wCgGUmKEzRRu/hONIZCI/Kc1Yku
	p30HOwgTUX1SzOffBj2FK/WXsb3GGfRCMVNU1IMFTbECwXVCIWGC1gMX9JLnp86ML/d+o/FO25C
	2XFU8N6A8kWpfI9bKuciKJrvVysWTS3ogEmaB4KhGu6LISxkIRmfx1x8+r6vcKht6qGbRsq6hA8
	eSW8SigZ2BcnF6d01BJQDLxn7HSVwXxKtd9OF7DM1SoMN7Tt+6HLnO4Q64On3EwxeU5Ch9yX3le
	U0Cs5AwUP+g1IVwEs/iyv/XV5NWC7dOGHPtfPqX7IuWNMyBEsEzFjRc+oOp7W7inHTQLBYrGnZQ
	bJQqBt3BO3lcuBBTFOFx9jnD7lvpw+sEfXg==
X-Google-Smtp-Source: AGHT+IHrYhf87zOO/F7IgQdIJUkog2pz29/SK96tDKwDvYcSACLzhDpORGEAhkp+mPuxAeN1XyEDCg==
X-Received: by 2002:a5d:5c84:0:b0:3a5:39d7:3f17 with SMTP id ffacd0b85a97d-3b768f2308dmr1930419f8f.47.1753262205986;
        Wed, 23 Jul 2025 02:16:45 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:b8c1:6477:3a30:7fe])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca5c8c9sm15938585f8f.85.2025.07.23.02.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 02:16:45 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  almasrymina@google.com,  sdf@fomichev.me
Subject: Re: [PATCH net-next 1/5] tools: ynl-gen: don't add suffix for pure
 types
In-Reply-To: <20250722161927.3489203-2-kuba@kernel.org>
Date: Wed, 23 Jul 2025 09:52:42 +0100
Message-ID: <m2tt339tlx.fsf@gmail.com>
References: <20250722161927.3489203-1-kuba@kernel.org>
	<20250722161927.3489203-2-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> Don't add _req to helper names for pure types. We don't currently
> print those so it makes no difference to existing codegen.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

