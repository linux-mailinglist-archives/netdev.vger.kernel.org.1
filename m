Return-Path: <netdev+bounces-88883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 619D48A8ED8
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 00:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9181F1C21250
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 22:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EC13BBFA;
	Wed, 17 Apr 2024 22:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="TlhGwZqc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F48F7E0FB
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 22:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713393012; cv=none; b=POkOTqyoGXvmjukdwDJkJN53ujKraCb/3vsz4G9m0JadBSCP77JiR3hu1v75i8OjjvpU1JI2NZOzXP6FripeeEAZFP8XXY2OCf/FYyioUo5UWM2Z82C8RLV8aT9bG1tLgwewXJviisKYegsqr0dnqScuK29j2kodYWKsYozLcvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713393012; c=relaxed/simple;
	bh=P247JodJXQeobK+hPLi21y8wHqmwGi1a7FAwxAcI6XE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ukVvfpzCBbB+Z9p0iqMtTG6lHztyqJZi4MLXW2eJbzdEXXTXWmveNMmy/tHCSYkKGzKR1JX6P5WM1JKKopesVmUh4WPGZqClfrepOgiDQgrkMeLu+7Yhluu3CbhJc/Nt9sdqCG82Ot7NON8nPIKMUSK+ghUbPStSkkcXBce/FUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=TlhGwZqc; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6ead4093f85so289886b3a.3
        for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 15:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1713393009; x=1713997809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tMj3kDds4c2Z+X1vqMpXmpY1ruqjvWfDxs0KmIb5Rc8=;
        b=TlhGwZqcVUdJVhmFTNjQp+b11BtGJ2+IAy3ndRSDBBXQzlHUzYLAxHUe+9fUosvT+Q
         tDPSMZxO0LawwTrXWfaECpmUOfd/9lCMO/dQ7w6p6ZmNNDXckq/NnUCRCdtgvWcSx/wY
         62CoQBun5MDTXx6/t5/RagfRNcLaA1fPjI118No+26CgXJBWOTrkwAFRCcLN+azOjSnE
         HfnrU072GYBcjc7SHgqqVgzcRAKoXtA6ic7aL5Y26dYQjJ1xH1elu2vEGBUJ6bnRB5Ol
         xArhn56QQyfI4VktHFHbH6kzwkPiJFIwGQ47+tR/Lmkig//NKThAZVr5w7M5/MHzazJU
         DOzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713393009; x=1713997809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tMj3kDds4c2Z+X1vqMpXmpY1ruqjvWfDxs0KmIb5Rc8=;
        b=MJuiqCTm+MKvhvgpTcamSY+ul52UJTLlBgAsnhHNFHTL49zENTSUAnhELpNkhmoBUB
         MYzIqt+HuFcNwk0wKzvrCxNQ9Aq7HH5+sJOM+SdZa+ac6+V990gL/bWfbaQvp3skVEpY
         GmTGi132oMfffIxRoPZrJ7QP3UQXWDv1/IJ6tSAjuiqItY+Tg9z/K7cBJTdS0USopgwE
         qz4tBHdNfws57TtXVCzA0JDhn8f2F3wwhJH5NFT1iVbEEOSjRoNxP8skeDPDcvR/ilkP
         gwP96fXINrQI9kLapVeRxdq991RxtNHO8vatcGm/jktlSot+AOqduJC4I2OVnJXK5lXy
         yE+g==
X-Gm-Message-State: AOJu0YwMjsLeCcoJFYCp357+DL0lrmyE7iduTfXpmCfCOWb9Vlm9SibB
	rWBF3jSxa3oZVfiHNfqDq8ejJkrSj4ZcGheNeXY3KJBjMV6qE07CWyEhWFFNz2Q=
X-Google-Smtp-Source: AGHT+IE9Xrg0Y+NjiMcna2yisr52r5CFrx+KvyPx7qHzRAHXC7AG4mkZfMHYbpDjdkySpK/tZmfW0Q==
X-Received: by 2002:a05:6a21:1f2a:b0:1a3:673b:62b8 with SMTP id ry42-20020a056a211f2a00b001a3673b62b8mr1147411pzb.35.1713393009386;
        Wed, 17 Apr 2024 15:30:09 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id z2-20020a63e542000000b005e838955bc4sm106089pgj.58.2024.04.17.15.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 15:30:09 -0700 (PDT)
Date: Wed, 17 Apr 2024 15:30:07 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Maks Mishin <maks.mishinfz@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH] m_ife: Remove unused value
Message-ID: <20240417153007.4bca29aa@hermes.local>
In-Reply-To: <CAEh9MGTwqGVpuq8M+So8bfU2y=bpbQMJjPJo3F52MjFHQ_BiRQ@mail.gmail.com>
References: <20240417170722.28084-1-maks.mishinFZ@gmail.com>
	<CAEh9MGTwqGVpuq8M+So8bfU2y=bpbQMJjPJo3F52MjFHQ_BiRQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 17 Apr 2024 20:08:55 +0300
Maks Mishin <maks.mishinfz@gmail.com> wrote:

> >                 ife_type = rta_getattr_u16(tb[TCA_IFE_TYPE]);
> > -               has_optional = 1;
> >                 print_0xhex(PRINT_ANY, "type", "type %#llX ", ife_type);
> >         }
> >
> > -       if (has_optional)
> > -               print_string(PRINT_FP, NULL, "%s\t", _SL_);
> > -

It is used. The printout would change with your patch. It would cause more
things to be one line.

The lower two has_optional parts have no effect and could be removed.

But before removing them, it would to look back in older versions
of iproute2 before JSON was introduced to see if this was something
that got mangled then.

