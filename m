Return-Path: <netdev+bounces-71359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7B6853118
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 14:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C58BD1C264C8
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 13:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4089B43AD1;
	Tue, 13 Feb 2024 12:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LTutCdhe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832FA51C44
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 12:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707829168; cv=none; b=CykVbVPXemNnAxaGdHLrEav6xy/hbBM5kao8ivl3z1Cnv1ONgXMAGR+XyJXy2utWk7Nwhqiw5+m60m7Ehd5B92DuzurWu7pChH+ICgV/92NhlmtAh0BRWAE3n6WRksSdJpqcYiWsYh4HGNcHP147MwTbkPpYScV2Oe4LKqs+l3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707829168; c=relaxed/simple;
	bh=ZrfU4G7zJ1uXerR09+qZJlyVPQyIlnNZvQ/ca6DoNDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bE9MMrqtG/xJxQUhGQlY5CJEtiMc+FTD8AJmzjLhVZij7BA5FU00e6lyDme3iUg+xK3t+/V4s8q5N073WYhTXWIv1ge29FiAqMkAlOQ3PoTfL3COGyJKvm8d5l2zmNaEvHm8p5bhprNs7qBYHp5Jq8JKR8F6SZvCrt+SHFk969c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LTutCdhe; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d0b4ea773eso56591771fa.0
        for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 04:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707829164; x=1708433964; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrfU4G7zJ1uXerR09+qZJlyVPQyIlnNZvQ/ca6DoNDc=;
        b=LTutCdheN86gz+D/qcD2I+v0a1AKdtm81ypt4O9FT++BU+1j2uNFbFEZLtlIW3l3la
         Bv1IKjJQ1iYN99Lz5H44UD4QYYuEaiqEDBa/Ub+PgIMAJxb8nXsgy0WLpB2xPqtAN335
         NCsjvVTZG1lT6G63Eb4j7H6b6RoieS5dDGckpwHkWc3Hcp/4m0ZDHXQxM6+bml7TYoL0
         OxDwp1tDU0pKtWfUDXjLxP/k0QTDmq9U+PuOBwy1QOy6072TmkNOoBrBB6UdIdCPzKNF
         ah5xy9574ww4aKkVWDiqmZx9/jMEwb9FoKbAH/YomJ7g8CvjP7ghd7/iBsG9cZkuMlKO
         wZWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707829164; x=1708433964;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZrfU4G7zJ1uXerR09+qZJlyVPQyIlnNZvQ/ca6DoNDc=;
        b=AURoz7n04AnMgaacm3JQ0qlYDBQwpzj9ZvCksiuzov5YKJGydyPNa7tV8NMIhbRK/g
         6lR83U7QValDpF6MH5KqzuP70nq9K6hgPKD5V6R2/FxZ0/L3ss4g5R/oDA6uCDxFchOM
         +w6UuYf/dVSwgEws4EvuE6gLbwZydG/Ruus37O8fd/Fjti17jJfb53J3sQ7zpJxgApaQ
         sYIwSW7oIxlSvopOvQC5Wl2MMtRhr6aRo3Jfx/MIPVqYNSm0bJAupfPDzdXsCi4v7Qsb
         n8q9yECboTm0x60iKSvhNtjQAkElREF8yRjvirL9cDKeuQHQl5BWC5HL6o7LVbo0MzxE
         eAlA==
X-Forwarded-Encrypted: i=1; AJvYcCUEfywGQnnMFkvX2wdHOJU+LSh0eaajEoWWygyb/3xw4t9EDZFBi4qk04FflhQSuENkemhCHUtiHxpVGBMD8Sf7In5AnFtp
X-Gm-Message-State: AOJu0YzQStxM6214lRfn/oBjbQ1eRYYAgFR11KwZUzdftWMU39FhGDcY
	J3m6dm2jH/hGKwiooEBkfrZczCuqlTzynuwW5JUVzdcjyoNYCD6P/O2tB4Qk69DFsrOR307ATOZ
	gtMvTst0W0KXsXn3erzyVK1OSjfQ=
X-Google-Smtp-Source: AGHT+IEujYnnIIj41G1plx69eyF/sT6Nr0ePvf5Sck6cfOt/T2qIGOQ5YdlCyFQRyeNVs4P1Svazee64vscgM1L2vFc=
X-Received: by 2002:a05:6512:31d3:b0:511:8cb2:2f82 with SMTP id
 j19-20020a05651231d300b005118cb22f82mr4858164lfe.44.1707829164231; Tue, 13
 Feb 2024 04:59:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240212092827.75378-1-kerneljasonxing@gmail.com>
 <20240212092827.75378-4-kerneljasonxing@gmail.com> <CANn89iKmG=PbXpCfOotWJ3_890Zm-PKYKA5nB2dFhdvdd6YfEQ@mail.gmail.com>
 <CAL+tcoAWURoNQEq-WckGs6eVQX6VFpHtw4CC9u4Nc7ab0aD+oA@mail.gmail.com>
 <CANn89iJar+H3XkQ8HpsirH7b-_sbFe9NBUdAAO3pNJK3CKr_bg@mail.gmail.com>
 <CAL+tcoB1BDAaL3nPNjPAKXM42LK509w30X_djGz18R7EDfzMoQ@mail.gmail.com>
 <CANn89iJwx9b2dUGUKFSV3PF=kN5o+kxz3A_fHZZsOS4AnXhBNw@mail.gmail.com> <CAL+tcoBdvbA7OFYgdjN=LdLiQ=CyBxCkRy-0S_cPRPhxRHgenA@mail.gmail.com>
In-Reply-To: <CAL+tcoBdvbA7OFYgdjN=LdLiQ=CyBxCkRy-0S_cPRPhxRHgenA@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 13 Feb 2024 20:58:47 +0800
Message-ID: <CAL+tcoAkm_A0isuGhZJNeN+MEF8q_qoJjGwJTVWsem8eXseADw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/6] tcp: add dropreasons in tcp_rcv_state_process()
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>, Kuniyuki Iwashima <kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"

> Thanks for your explanation. Since the DCCP seems dead, there is no

Oops, I have to correct myself: it has nothing to do with DCCP because
the caller of tcp_rcv_state_process() only exists in the TCP path.

> need to keep it for TCP as you said. I will send this patch first,
> then two updated patch series following.
>
> Thanks,
> Jason

