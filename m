Return-Path: <netdev+bounces-77183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA808706F5
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 17:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE2BC28112D
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 16:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078284C61D;
	Mon,  4 Mar 2024 16:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="AC0XRdkA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37EE48CD4
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 16:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709569507; cv=none; b=azGBV1nNODhToLUbUiCEqW9+gVg6RyN9j1odVgbG+Ro75bkGroQz4d3Z0u6seF25jGbY9SQ8PNCK2jSqux+qBa47t5gGyQGCnlaAmNSbZTYWg+10MPiHnWDcDPhoHEH84QhFL59FzdmWzz2Czx5aGa8oz5ps2XyJhqTclCdngpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709569507; c=relaxed/simple;
	bh=vV7NMpe33430XQUFW+1+LdvLQnHo23DlKyDNSxZlyjE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=giJd1Lzjd2+Sk4yPBlb6tB5mxxV9vPdjnOun0H05m9eHuaLoJvhpw4qiJVWLagOWVtNjAyTi4IPHw4mjhfbc2cliqQoWPruRg7Z7e9z7eipX3xX/hsDajyA2X59oM5EiMEfLFJy/6q2SHjiEyz7aCejv23ThznbwZTlyenz18Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=AC0XRdkA; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e558a67f70so4117338b3a.0
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 08:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1709569505; x=1710174305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=82/NNiMoNPeL0V7embphVs4ckpBE2jmSPsU7+oD52mE=;
        b=AC0XRdkABjihJtLbIuSmFpGUM94BEdCDwIHOlfsPm3hZLZhhk4RoGe379LoaWLlBDv
         po/6uFx5gIAUgus2AIhUwe5XaCgHqkSWSQTgfpHDWY2/yU+YMX7wshYI/eEvsi1Z1zkg
         WNLPlD/bt7aL5kU96tqMOAbIiX/6w3X5K70CPcAgZnJ+OjDtRobLPO0AuT4/hVK+9PDT
         MJWNtJJPoVVkpzdRZKlhM3LL9aZAWw7Ush4ZykyrVMUK1DRN/MngCZs4JFcyigchvsoN
         KhPUUlOw3qzAWk6WSVCl0OJvqA+t1FMcD7EQOFJcE/Sc7yGp8WzBk3Etp1/OJlPLG3a7
         KAuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709569505; x=1710174305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=82/NNiMoNPeL0V7embphVs4ckpBE2jmSPsU7+oD52mE=;
        b=sS9f1Wy8ZcwP5G9huGYl3EyEmY3YdbvIeT/v36O7l2BBY6O4d8FidpKSvjgjqf1uSI
         D5cyhvsckBWN4CXUYv1QnrsgikuXFVYKwOE1YuqR3VQKLi7JgfPoCiU7HFd53zh5v/ve
         ZwfWEfjRVdvGL/8de3MFwLhYMwE4AcMlsKi5ruqGIJFpfM6X0veugV7yWdHWuU1vbAv+
         jDmRk1UpjVdfkbtwh60hZHU4Dn1Bd9MnYzM7BmpH78wO4aHhPdV59YbSRxdIooMklUP5
         t2p38m9B42oT3eAJ2lMJhbfLISA0AQOnSyHVTf2vY7TnCEP3h8yoCK2/nsGov/R+1kzf
         Jwlg==
X-Gm-Message-State: AOJu0Yyj++bMKqIDGQKg8IIG3ZdbttZqAJ2Qr5fLtvZtNnScfeazFRRj
	uLAqFfTQdY7lwDE7qjUdz/NGedD0p97VyjJJYxphURrnlMvvQQmB2vNU3Hzx0qYHGqzwCUTUuWx
	ESvIFMw==
X-Google-Smtp-Source: AGHT+IFXV3+3w6QE0V5mTkfl85Ptj9bqF0Rlng2+I6BHnQDuzuj2gmhHP9Deb/8caNyuQgjTEOnh4A==
X-Received: by 2002:a05:6a20:258b:b0:1a0:d103:7030 with SMTP id k11-20020a056a20258b00b001a0d1037030mr8387503pzd.32.1709569505172;
        Mon, 04 Mar 2024 08:25:05 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id b64-20020a62cf43000000b006e5a915a9e7sm6888353pfg.10.2024.03.04.08.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 08:25:04 -0800 (PST)
Date: Mon, 4 Mar 2024 08:25:03 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Lars Ellenberg <lars.ellenberg@linbit.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH] ss: fix output of MD5 signature keys configured on TCP
 sockets
Message-ID: <20240304082503.5648447c@hermes.local>
In-Reply-To: <ZeHLFNX7f5x1M10/@grappa.linbit>
References: <ZeHLFNX7f5x1M10/@grappa.linbit>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 1 Mar 2024 13:33:24 +0100
Lars Ellenberg <lars.ellenberg@linbit.com> wrote:

> da9cc6ab introduced printing of MD5 signature keys when found.
> But when changing printf() to out() calls with 90351722,
> the implicit printf call in print_escape_buf() was overlooked.
> That results in a funny output in the first line:
> "<all-your-tcp-signature-keys-concatenated>State"
> and ambiguity as to which of those bytes belong to which socket.
> 
> Add a static void out_escape_buf() immediately before we use it.
> 
> da9cc6ab (ss: print MD5 signature keys configured on TCP sockets, 2017-10-06)
> 90351722 (ss: Replace printf() calls for "main" output by calls to helper, 2017-12-12)
> 
> Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
> ---

Wonder if the out() method was really good idea in the first place.
Would have been easier to use openstream to redirect stdio buffer and count
bytes on the other side.

But will merge this. Eventually, ss needs a bit overhaul/rewrite to be not
one monolithic program and handle json.

