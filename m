Return-Path: <netdev+bounces-117008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A2494C562
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 21:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B01031F25BEE
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 19:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FCC147C86;
	Thu,  8 Aug 2024 19:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A6vz2Wly"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC22C7E792
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 19:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723145886; cv=none; b=PKJFwtBmZS2roBt8CFvjG712jsv3MLmNVKlNOyKBNusvLgv6lknO/NZAh55PB/FNGHXxmRUXyCAsGeiPrVhe9rkuDQJ73WkDjiWwp1Mozc/OS9wCBSJocr3TJm8Z/iHzmMYqs7ecHzoXxS1d3Z4Qi7Rv+p24fA6Koxe3D9pOncg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723145886; c=relaxed/simple;
	bh=WiSDBo+zc31BkiTZvbUXDX/NYOYzy4YBxamSw5bkE/o=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=pDNzYpb1I5OpFxp+0V5r2Zm7tQ/HGRiMinjhkanZYkPsf3JgbStPAJO9uISrfV/HYdFcTY5tR1kn8ohAPnY+XQGJT3X3r2fYR/YY+ca0BR94MqGoacffXSYLQFC59khHNf3seXlJFdEAGUZLzjw+LRhZb3MGNZ+MxnK7QnTKmOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A6vz2Wly; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-70949118d26so934175a34.0
        for <netdev@vger.kernel.org>; Thu, 08 Aug 2024 12:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723145884; x=1723750684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WiSDBo+zc31BkiTZvbUXDX/NYOYzy4YBxamSw5bkE/o=;
        b=A6vz2Wlycru8vnbdfRh9PjFhgXvLdlg8LfD+rfcfDtZWNNJSA9VZFMqKYgK2ntAIt8
         plUZ2/ZQxIKEezVbv5n6/0h6kJNAOO/wLGvAEjQfsQZaiTZcxmxcfbg2XufWIZD10Rel
         bzqAYD/fEMknOzGM9UX9WUfHG+VkiClBRila2XrUvlWiYYpy/ihvgV6wS9Oza0NJDpNz
         C7ULVCl/gmYA48KGQT3EpwsQWdXrZcpnQSIV4hrzzHorce3EIAIAQzd5iYYVN0s91ydn
         GRccBNhJ59aTXZqiytbxB3Zqa0u3UUpEYeqWrFS3LUc2daMel4tRinoyxxxJC71V5+IU
         fqkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723145884; x=1723750684;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WiSDBo+zc31BkiTZvbUXDX/NYOYzy4YBxamSw5bkE/o=;
        b=ct88Rj2WUjRYi9t8V5t3yJ00cR8p3kIJEULth+7SzXiLObvaoazBIsKV2fDGm2xtuI
         7PQstW4+gkixIy+/7i0vES3kL6s9PSf94OUr6PD6SElV2GassMyZiWybPkjGn5qiK1dU
         RFexyJgxX+UYAOxhINP8n717iK1UPgpYfSveWPqClCNykM+MEFC0yIZ2yX4S1MxFSJHG
         xeoMoJE/mu5p31k/jvFes/ukli0wILfJcokfxFVbBsp+u77Q5OPGFGzS0ILMQyHhLL0v
         qJMCG9J8rTGrKUUk0IWvWmpNGYEeZ56YBqPvz2vNtxZlhoG8I+6JSqlW6V2917UEJpLF
         e6TQ==
X-Gm-Message-State: AOJu0YyikGU+u1JhbnWcxfsgHkp5N5tqAWs2e/tEV9nFhi7pi8y4E4Yx
	Vjx0bUnGX2Wo7Vohro/sNe0b1HnURyIhxItf0U65vasBbwmAfj85PpQ2+Q==
X-Google-Smtp-Source: AGHT+IGfDnHSOtSVheDB91DfRRV8SoeP9AKaf0/1UX0bdsOTaG/TVv0F/fUkUAOt38/ZAEVvJAm02w==
X-Received: by 2002:a05:6830:3689:b0:704:470d:a470 with SMTP id 46e09a7af769-70b4fcadbf7mr3756128a34.28.1723145884010;
        Thu, 08 Aug 2024 12:38:04 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-451c87d7f7dsm15526631cf.60.2024.08.08.12.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 12:38:03 -0700 (PDT)
Date: Thu, 08 Aug 2024 15:38:02 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>, 
 djduanjiong@gmail.com
Cc: netdev@vger.kernel.org
Message-ID: <66b51e9aebd07_39ab9f294e6@willemb.c.googlers.com.notmuch>
In-Reply-To: <87h6bvp5ha.fsf@toke.dk>
References: <20240808070428.13643-1-djduanjiong@gmail.com>
 <87v80bpdv9.fsf@toke.dk>
 <CALttK1RsDvuhdroqo_eaJevARhekYLKnuk9t8TkM5Tg+iWfvDQ@mail.gmail.com>
 <87mslnpb5r.fsf@toke.dk>
 <00f872ac-4f59-4857-9c50-2d87ed860d4f@Spark>
 <87h6bvp5ha.fsf@toke.dk>
Subject: Re: [PATCH v3] veth: Drop MTU check when forwarding packets
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> djduanjiong@gmail.com writes:
> =

> > This is similar to a virtual machine that receives packets larger tha=
n
> > its own mtu, regardless of the mtu configured in the guest.=C2=A0=C2=A0=
Or, to
> > put it another way, what are the negative effects of this change?
> =

> Well, it's changing long-standing behaviour (the MTU check has been
> there throughout the history of veth). Changing it will mean that
> applications that set the MTU and rely on the fact that they will never=

> receive packets higher than the MTU, will potentially break in
> interesting ways.

That this works is very veth specific, though?

In general this max *transfer* unit configuration makes no assurances
on the size of packets arriving. Though posted rx buffer size does,
for which veth has no equivalent.
 =

> You still haven't answered what's keeping you from setting the MTU
> correctly on the veth devices you're using?

Agreed that it has a risk, so some justification is in order. Similar
to how commit 5f7d57280c19 (" bpf: Drop MTU check when doing TC-BPF
redirect to ingress") addressed a specific need.



