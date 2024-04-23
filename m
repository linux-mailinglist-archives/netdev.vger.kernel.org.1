Return-Path: <netdev+bounces-90522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 919BA8AE5B3
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 14:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEE34B20EA5
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 12:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8293E84A54;
	Tue, 23 Apr 2024 12:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="usxrKTft"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038178405D
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 12:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713874333; cv=none; b=J0N+YRhVfvNWlbhmfkMXExtAU7xeWIKkOYVbrILxzjXw1BDXnHpGt/59MyWThyd/Kzlh+s6nBRDv7tRJhZbhOwEyvapCsE6Ajv/XlS26YBaDuDJTFE6nqr7KpkQv7PMuDld8OXYUQAX7IKeWFD5K7Frek6AMfQbXvO36+gFiDuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713874333; c=relaxed/simple;
	bh=QUMOkPeMucCrVnY3P+UvLezzWpEMIoKiJLXkw/+9teg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j++FYKYFNYnBhdVLWKlIvZBy3cJOofRIUEMBYjTwQBU4tE/9uwJKjbigw6wkhKSnVqb95Xwh92b743yI2vOSnbhMDkWocl+IPBXh77tkCldJoQTv0vm2tsSmO7SvRp5raFtYXxJGQREz50/M/k3z1jQ0Jys8Xv989iFUSCG2Z54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=usxrKTft; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5720583df54so9659a12.0
        for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 05:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713874330; x=1714479130; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QUMOkPeMucCrVnY3P+UvLezzWpEMIoKiJLXkw/+9teg=;
        b=usxrKTftqr0M1ywr7mtAx68AfLSglhIAYTYKR/O6op6vPqR6oLMCnAjGsKlJxW/eqH
         gckISObPuWCsATxL3TkHE3ca9TMbXusUKyHCYFX3B0M3gtFrAXDQsGSdLo7/75lCnEjr
         tlN93vgScYksR/Bm0lL5r07CC7/ybqRTl2SJjqgryvageV3hyMljbO70a+j41ZO/P+GX
         dddJR05QJltVAxpQrQ/rfKTMAPR9JnuuMWLdOYjhSK1drNmiHnCEmq0DVZx1X29h128O
         9eidYD6vQzRJZQUkx3SybExOQrXs2VCp0GqkiYMs96FVbGenwSzH3WhDqk4Pfzx3vwlH
         rOAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713874330; x=1714479130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QUMOkPeMucCrVnY3P+UvLezzWpEMIoKiJLXkw/+9teg=;
        b=S9lDS/zzG3MStV/Mdi7LHApoj9JIUl/s3GQRe2M+UD/l65cCD8EkPBe0PxzGCqJ+PB
         3AxQABn/M68VVghbs+d/CkCOwwvI03q0dV5mv1eYOMTCCduu3P5yvnG4XUjz1TEuNVZr
         RM+dB8wo3aXx9Lj2BJyd5R2EI8HJqrB3dRzk8VocmTB6YuwG121xDIzfBdNeen6Wi0SE
         13FKj3KW4wf9PFKEqQyOXL+1MuMp6JLyspTkECNmbVP6wAsFzHXNPZhfxa+AEitiaxcs
         0XYeWFiGyrcwjnOtk4ZTDJl/IqftuTSz95dEDuTiqvSxFa5KvOWMLsBiZhpOHj94cmZA
         PQhQ==
X-Gm-Message-State: AOJu0YxXHftiJ9x0pyNcjVK+zC7sn84AmvVGIzFRICHgYxn+59cXZAKL
	4uEfFoMMEP47vTdaBpDx119fvH88W2yCrgarfZ1HbdF6MeLriG4XW+e2w1I5GfyStq25OVAoEsc
	EAqkLaAYwdriIaH/ueZoSw3G7qfm1cRDdccELGLIzokLPhbIKXtfH
X-Google-Smtp-Source: AGHT+IFVlB2LLAc63mkiYhIlX/rzXgT9wq/+wtd+D/UFA8YHSy2TBcn+TwTyewKoFydcmZ6uWZynzLAtkEJ38ocmXeE=
X-Received: by 2002:a05:6402:884:b0:572:145e:d6de with SMTP id
 e4-20020a056402088400b00572145ed6demr173985edy.0.1713874329999; Tue, 23 Apr
 2024 05:12:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423094117.93206-1-nbd@nbd.name> <CANn89i+6xRe4V6aDmD-9EM0uD7A87f6rzg3S7Xq6-NaB_Mb4nw@mail.gmail.com>
 <63abfa26-d990-46c3-8982-3eaf7b8f8ee5@nbd.name> <CANn89iJZvoKVB+AK1_44gki2pHyigyMLXFkyevSQpH3iDbnCvw@mail.gmail.com>
 <7476374f-cf0c-45d0-8100-1b2cd2f290d5@nbd.name>
In-Reply-To: <7476374f-cf0c-45d0-8100-1b2cd2f290d5@nbd.name>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 23 Apr 2024 14:11:55 +0200
Message-ID: <CANn89iLddm704LHPDnnoF2RbCfvrivAz0e6HTeiBARmvzoUBjA@mail.gmail.com>
Subject: Re: [RFC] net: add TCP fraglist GRO support
To: Felix Fietkau <nbd@nbd.name>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 1:55=E2=80=AFPM Felix Fietkau <nbd@nbd.name> wrote:
>
> In the world of consumer-grade WiFi devices, there are a lot of chipsets
> with limited or nonexistent SG support, and very limited checksum
> offload capabilities on Ethernet. The WiFi side of these devices is
> often even worse. I think fraglist GRO is a decent fallback for the
> inevitable corner cases.

What about netfilter and NAT ? Are they okay with NETIF_F_FRAGLIST_GRO alre=
ady ?

Many of these devices are probably using NAT.

