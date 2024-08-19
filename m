Return-Path: <netdev+bounces-119597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 332949564AD
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 09:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0609B22B3A
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 07:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A7B9157A67;
	Mon, 19 Aug 2024 07:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RTHU4FTG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE963156F55
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 07:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724052436; cv=none; b=DTONaxR4oWAhex5Zy+gt/YtCvFM8xhMfXLfCB5UI1+O32XozMDRXq1pzy/7i6+WzX8mMlwV7jfBz8YVizdsuBi6VQ3biPeO02EoWBZPHBqElvDF7HzRadgDfVN/TcgWptN7XkdNObMTJCEPHLWOH2TWvDopy4yKmfr+8qzNJLOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724052436; c=relaxed/simple;
	bh=2W1FtRZ5j90Su7YvMx+ud2rdquaZ94dtzoqFUAsig7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MqYYkzfViN0H7gIZ2zLVg9paloKrlEY4QXgOsQ+MK0XsJtYWEKW79zVnGrnSmb90+5SXXn3xV8lv+NZ83QnajgFn52DjR+PUs6RUIh6marazZT4TpU53zgysYB76cahBenLEaOOySQ37q/jilP1iIRNdSAAA7u1i/nwDBOTk1V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RTHU4FTG; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a7b2dbd81e3so551728966b.1
        for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 00:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724052433; x=1724657233; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2W1FtRZ5j90Su7YvMx+ud2rdquaZ94dtzoqFUAsig7A=;
        b=RTHU4FTGQtAiqufIxUxEC/3dtqewQ0JeVdArCQue8oY0C7PkGq0/axaOJ3OVOFDZth
         dcRFD2md8f7Enk837Y/9eIIxr9yXxmXLFUw5rYi+bCse5PzR5gYv+za0G0YgG/AwUE4B
         A+WwJ2WQDB34gHCINYbteiUdGB9jNRtgClNPuNREwCcKChiMRnSU0Py7X7MXvQpdDw92
         c0LMsWjkSbo2ZY2IZbICyBY2mNuURzv2A85uF5VS2LKmhCg2hl+EuZulDPEZPVuAPi1R
         ZfWhZVIasmqto5Zr1lYpV7hwE3vtYKB7nursgUCZ+aD5t9ST8mr+HvnpyDPkI/7Dua0Z
         ZUsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724052433; x=1724657233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2W1FtRZ5j90Su7YvMx+ud2rdquaZ94dtzoqFUAsig7A=;
        b=IeNn71pjAgsd90VOUgZZaJqZxQDy59O2O8w6qtM12/I/G68qPu9WP/vxrV8JBJLAMH
         K83Wpphu4UZuFG9TB8Ydid7bomK0UlKkUvt48sh0j/3XegKjg9+RjHMpUEBWuEFBN7J0
         VOtx6eSE37rtQQVbNlzzta9Um13VJs2p0OZHeClcP+bqp94AHbElZStxYD1+kxlkjcZY
         WJlbuftEPC7vkaJE1uASe/JhFO8gV9gvBJBgNcATjbcVvDbDwl18j7ZX9O04mcCbk+Bf
         m+OBKf+uxH+cPJBm794YN1PPbZwcD9sKfHXfU2kkOoeBNmfC5mbrt2ufHCHye38roEv3
         bOdA==
X-Gm-Message-State: AOJu0YzNiycs5kAL+t27/Cn6xyk7zp535fVdfih6L2XOQX3TpfyzUeZD
	U8LEH35fsSabGF6CoFvfgfCMO4TOtcDVHmW6ipe7FJfPOKPTz4QncMr2QtnEDfsNZtSOdLraKPd
	TYW9eTQzltu+ij60AhQGDDYJ4pJXFq9RmM+eE
X-Google-Smtp-Source: AGHT+IG8gHqF1OK12Yl5mSd1brmXsv1WL08NNHPm0xS5423LDEqm2vslRBHGEUlK1888RoE4VYGiCbBdO9YzvkQfvXY=
X-Received: by 2002:a17:907:e2c8:b0:a7a:8e98:8911 with SMTP id
 a640c23a62f3a-a8392956035mr669540366b.38.1724052432664; Mon, 19 Aug 2024
 00:27:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816114813.326645-1-razor@blackwall.org> <20240816114813.326645-3-razor@blackwall.org>
In-Reply-To: <20240816114813.326645-3-razor@blackwall.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 19 Aug 2024 09:26:59 +0200
Message-ID: <CANn89iJM=R81LtBFD2wsXZprngDqS24+sj7JX99a8+qG72+79A@mail.gmail.com>
Subject: Re: [PATCH net 2/4] bonding: fix null pointer deref in bond_ipsec_offload_ok
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, Taehee Yoo <ap420073@gmail.com>, davem@davemloft.net, 
	jv@jvosburgh.net, andy@greyhouse.net, kuba@kernel.org, pabeni@redhat.com, 
	jarod@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 1:51=E2=80=AFPM Nikolay Aleksandrov <razor@blackwal=
l.org> wrote:
>
> We must check if there is an active slave before dereferencing the pointe=
r.
>
> Fixes: 18cb261afd7b ("bonding: support hardware encryption offload to sla=
ves")
> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

