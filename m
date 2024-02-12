Return-Path: <netdev+bounces-71023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E2A851A44
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 17:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6E2B1F23259
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 16:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7C13E48C;
	Mon, 12 Feb 2024 16:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="oIzuw7XM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3CE3E481
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 16:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707756935; cv=none; b=hbR2hE8m805RdgVy4T5ckz24giV5hFRsgiijE6MB7H0JD9aEAJP7RfIYfMOs/r5ySoh9L1x86JDQz7F61LtOQraw74f0eMm1YAid5a1CbGj2ibKGpyJDZMn+JPWnXZo16bhBMbwYuFtnUWYSQetKIfejstQ53+C2/oPziK0RP9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707756935; c=relaxed/simple;
	bh=9zuBcuMGP7y5yjx5liG0ZICdcRZUONzM4fRJBdkRvH4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BpjRxiUY0mM+2T40du16Q5tnxRqWS0LZYh7Yymo+05tyv/kpHCBpRtEgSOb2rNHjtsx8FJ/eo0SVtVSiCr3wPB10FYaFj1K2+miXD8z1i2SikgFQkv/tpTgBOxTO1wg5eSf3+XtGhheA0wMmM27KNSjkOCsLwqndu+g489Aa/+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=oIzuw7XM; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1da0cd9c0e5so24239875ad.0
        for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 08:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1707756933; x=1708361733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=48FqN/0WODy8c9uM7Lqj8We/Eqw+lNthJF2vb/ofMjc=;
        b=oIzuw7XMUkkZ6dBReXHbuKlotJs2QbU7Oy/ppfVudqDWwid8zfZbmuPkzGKPoSRvpw
         nfaZkv3KDXmqGhXQ+IeJPmdugWOIjHpulDwET0yuaii8P24Ns7q342Y8X9pxxiq1K7Zt
         5M0r5o1PdEF9XIDwtkRFSL3z9c+7YitnXZhv1kk+zViCUJHWRE/h0O5ryodazjBES8R9
         wfX9jNHyQBeDn8F+atr0qZ7EMHbKDD+8+Bs+YDAfa6q5R/QmE1L5KbOl6yErI0/lX5l0
         rn5PYeSBuHZFvxQSdS3Eje+zdhbsz4ytCc+KDO0WQjWQe9YeUv++kzLPDzoON4lYC49y
         OhcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707756933; x=1708361733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=48FqN/0WODy8c9uM7Lqj8We/Eqw+lNthJF2vb/ofMjc=;
        b=bQ/MNFlcYX4HrHfjJxgOwKWi37tGPrYe4LtWTxztdp0F/9PPlYHrzFSnKzKVzcdqTl
         lPsRImitQYHcroe17H20F2VVvzHBq7GaaCXIILU17twUogEgjZFtUS+ocbeB/a1qUgYJ
         yghZUBtmMvgLsupShetqJZWrDh39MAaqTh/3x0zWlWo8QTSj49/Q6r0nGFowy5k0nZgN
         9I1pCAuNtbREOpth/2gjUhkvXdQ5jw/2d9kcSufYep3EFHcOJJiR5UxVMjV5O/U2rudP
         AE8wUwf+h59wc+P5bZxDEruD6PShaYpzhnv/aCs/OVljW/M9NHK+Gf4VCGNuOI7xeVU4
         8/1Q==
X-Gm-Message-State: AOJu0YyE26nbu+nXLZdxhLDyzQ8W1iycrKnWMyBqdg++Oo34wLdSrhof
	/Ut8EqJynesGnbmUjH515NtIgu9GvO1TRisiYxZ4qfN3eAC+4U0Anh+WdYTE7k4=
X-Google-Smtp-Source: AGHT+IHEUn0QjvdMN/BpUs7KxsNrwlWPflkoAhAo+KIZFQzuXazcVhADDbsstbOHzKhY0/wgkL/log==
X-Received: by 2002:a17:902:cf42:b0:1d8:cfc9:a323 with SMTP id e2-20020a170902cf4200b001d8cfc9a323mr45598plg.34.1707756932746;
        Mon, 12 Feb 2024 08:55:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXr1gsyM+M6nDe+DBNnOX5eFwCDZiD3H9GuUVYTdWhaMQ1dhYwUwBrCY8PZMRd4CxHx9AFxeZpU8wz6mpwAXoVAsaYaXAu4g9yrTjbKxmavrvXmNLHEPOz8/edVtyKZf/qQeSzCgm2kCFu3jEhrbANeFILrvhT0WYj8LZUl+8XDSrN8
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id o11-20020a170902e28b00b001d7726c4a40sm565435plc.277.2024.02.12.08.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 08:55:32 -0800 (PST)
Date: Mon, 12 Feb 2024 08:55:31 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Quentin Deslandes <qde@naccy.de>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@gmail.com>, Martin KaFai
 Lau <martin.lau@kernel.org>, kernel-team@meta.com, Matthieu Baerts
 <matttbe@kernel.org>
Subject: Re: [PATCH iproute2 v7 1/3] ss: add support for BPF socket-local
 storage
Message-ID: <20240212085531.3f1848d1@hermes.local>
In-Reply-To: <20240212154331.19460-2-qde@naccy.de>
References: <20240212154331.19460-1-qde@naccy.de>
	<20240212154331.19460-2-qde@naccy.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Feb 2024 16:43:29 +0100
Quentin Deslandes <qde@naccy.de> wrote:

> +	// Force lazy loading of the map's data.

iproute2 uses kernel coding style, no C++ comments please

