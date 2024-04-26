Return-Path: <netdev+bounces-91573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ACA28B3166
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 09:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9E371C20E5B
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 07:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F5E13C3C9;
	Fri, 26 Apr 2024 07:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aZqJMYr2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5E313BC2B
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 07:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714116803; cv=none; b=YMjlKWbLUzb6KhJrbMZdO5txxGF/J5eV03jWwfeh35bLsHXJyZMk6QVsJAP1cUYHl8lTwBVntf3V25yIj9PuYqw0UdyjpyGGU+SMDOfX3ZeYCIFijDThxdgqxFZU1YungVu7UwPLrzByZaFtRcLthxVGy/VW+PX2iTg1N6j0QiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714116803; c=relaxed/simple;
	bh=VeXvoXACL25UjHU8k2pGOUmm1D9NjDb4mHfPS5pOncs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RdatANMlsqThAuW0rAjDa8vZ2NqJsP/QgPyZvOXrmJG2zzyKh3FHaIAwTuAxEDEtmxenY9jPXwY5qKKoJORIRPcmR5zrwLLmC2ulW1sUbe+2eabQP+sTn4ECvWBs9AzkQCqME4+5bwIMntgqnTaJMv1SCF/eAPPvThgtvrAfG6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aZqJMYr2; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5722eb4f852so8502a12.0
        for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 00:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714116800; x=1714721600; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VeXvoXACL25UjHU8k2pGOUmm1D9NjDb4mHfPS5pOncs=;
        b=aZqJMYr21PcqwTbYxp/25D8INmiIU1jhE8LUmOz7/Er7K83wPvep94Kx8AT1ahosu8
         +DVzK6owP73YyBV4Z+Jg8xQWvFunSaU6Kv9rHO4PTZlRvh6BgrorR2Mdyol2mqJqUC1y
         rGTrMx/yQH1x80hy6duX8XtlMxoov7htpe52o1TIexRdMlh/r3TCfBp+cJ0LBB7ZU4tW
         7U9LWsYVrx4GRwagSScXeY/Gxf911dsZd5u1qh7BtFXm1tglNERP+FDBPy4NB+8jmWV8
         FS7LHLdlUttC7kw5mHw3Ctvjr20PbkfTUxxhzfjeI4o5HLE7oGZUXG5cHPe9aE0Fn1Yy
         +cFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714116800; x=1714721600;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VeXvoXACL25UjHU8k2pGOUmm1D9NjDb4mHfPS5pOncs=;
        b=MFfWYDeDA4jfcnFiktIWzRxEo8gd7w8qRUHLD9MZaZ2MJJfAtA8wTwVfuf8bvF9KzR
         OPzUOu0jQkWyPEUD5c6tiRA6yv1kgG+aEjMY6bU48mpvRSH94TLbq2/Uk6Hyhmio6Dx9
         YrQfV50UAJKc+eQCyudtygW0Wk12F1F2ccR2RSpSB1GGoqadbFbWK3QeW7dHb9w0WmH3
         hca8Z8QiWh8rsv9M44gkk3YH7eK2eOCTF0CZJX0k28783OmCmHWHeyoUzlEuZ2xCAZZV
         0Tj4s/tk3zVM8VGwHNuQICBJTPvOcS/wtjsXMDYEUNWYwuyTPDuVWtygh8Rr1+igRxIv
         zbfg==
X-Gm-Message-State: AOJu0YwNyp8f2NkR5Bbfqb7gddmo4fe0PBLaP+kQ7x2+k10Ry7fRMoVC
	uEyfwfeVrpm+RlWLeB2ogN3+Yzp4UnN5T78OQRoJoSDDmpBWzUpGZ7WjEC3prdEawdqhax3/AAI
	bJ8+S+ljn4D11LEkeg66H0fyaydcHTbNBOgCo
X-Google-Smtp-Source: AGHT+IFThgRtdsQLo9VBTOlpLtMexsuemQAIhrWu83M0GKnW9dcH/4cbcdUtwWVkZ1K4lae/j4Uu+5K95AqiK/dyHWY=
X-Received: by 2002:a05:6402:2d9:b0:572:336b:31b7 with SMTP id
 b25-20020a05640202d900b00572336b31b7mr116253edx.2.1714116800073; Fri, 26 Apr
 2024 00:33:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426065143.4667-1-nbd@nbd.name> <20240426065143.4667-2-nbd@nbd.name>
In-Reply-To: <20240426065143.4667-2-nbd@nbd.name>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 26 Apr 2024 09:33:09 +0200
Message-ID: <CANn89iL8VJP4u1daKKN1rC9FE-cJ7M6_JvkfEHd4yOZT91sFAw@mail.gmail.com>
Subject: Re: [PATCH v3 net-next v3 1/6] net: move skb_gro_receive_list from
 udp to core
To: Felix Fietkau <nbd@nbd.name>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	willemdebruijn.kernel@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 8:51=E2=80=AFAM Felix Fietkau <nbd@nbd.name> wrote:
>
> This helper function will be used for TCP fraglist GRO support
>
> Signed-off-by: Felix Fietkau <nbd@nbd.name>

Reviewed-by: Eric Dumazet <edumazet@google.com>

