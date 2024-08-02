Return-Path: <netdev+bounces-115278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B36945B54
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 11:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7092280D61
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 09:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F151B3F31;
	Fri,  2 Aug 2024 09:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFy+ivOs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CB4256D
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 09:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722591979; cv=none; b=ffu48pgcwMgqfzPMwHHxvY30lzIoszEkpyqGSvn10lbV//Mj2V6CZI15yltZGElrZXPLWh1IOzEMG1EheBpwRpG9PNuvmkxaUHHg7ohcM8w7PNPH+fExiPc5fP7sE8A+SKp9QoNHLVmZCIR9qan8z8sQCPUm9C/0nf9N7ZbvRjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722591979; c=relaxed/simple;
	bh=i/Ser/7PUtUC4rWgMQwn1QNdnq9PP3CeuzzePam/HWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sj4e7zW1M6Eiki3UKCcfA6oKSpgHufhlHza99ZE+wm3EzigGeX2vSzdl30OBoGlSwaCp0SJg5lb/WM9JyH8EMPhJS3ZLtBh8ga2g27GqXyeH0u3btFl2tlb0aWil9uqI+pEVNAYUT9EddvjeJhTcBkwcQj24Zk3aecwXe7gyR5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FFy+ivOs; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5a156557026so10490323a12.2
        for <netdev@vger.kernel.org>; Fri, 02 Aug 2024 02:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722591976; x=1723196776; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i/Ser/7PUtUC4rWgMQwn1QNdnq9PP3CeuzzePam/HWc=;
        b=FFy+ivOsBQFEDJ5pNS0CbErTDsy6qeEIQooaA2MXWdklYr9Ex6fnUUofo6q3GWySIJ
         LezkTik2zI/TGfeZIa9mVMRVyR31nCFb3+cm6tLl2XD5E8wbMzR83BFZMstxY4Gm+hP7
         MdzpBRAwaXXa3x9rU/u84gSNb9ZXkTYQtLnL5IoVLymKPX7u3qzptAdzJi1bTzelQkoP
         6CwKgOhYWOkoTB0AujiD+xLq/ivxGoIs0KcZIZQNtCs/XSrEDUSf/mJdteyKVYfkC4bK
         TQRV8UovLwmkou/fPbjV0txvhvfo4iAx0G+QfrcEHWmhCg8YY+sfyxMzHstFch1Y3UHI
         Xaaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722591976; x=1723196776;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i/Ser/7PUtUC4rWgMQwn1QNdnq9PP3CeuzzePam/HWc=;
        b=kvbYHl0Cj5dYE242T3llwDti6NIIPJ6VFda+aK21XS9X5G1GrpipWPqq7dU0My1h/i
         sixcXO7cCrCcnuLwYTXMzZKprp1YIscaOfHgCapH6s/vmy4x3clHIEw9qox3Hk8zEaXR
         QxoJql8VLzJxH26d0V4t8ywGE41T/aVYSh1D+gfEOn+6dGn+ZW2AwdwnJmwLS3BFWyUf
         vu+7pv+n/hk2yWOTsxlkTzwVVXqpmzvu85Gz9aeu2ogEfcpHuWphWblCZq9Frj5wxgsj
         x/wHcgOfHa03p7nZXeQhH92t/EezAaYPfTWF6ZpxjXgIdAIbv4DXZE6hQeisJATOfmA7
         4TiQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVX+nUW29aKcabYAQ8xE6EcvBHCZtk9gJvZQfQHc1DOWfcWFl4+n4F/Zjk1oAu8pXPsESX0q/s5FdI6iYGc8hArHjfhm5h
X-Gm-Message-State: AOJu0YzKmQxG4XyRSaw26rwi4Ly2LCV4ca/+Rq/Xx4Ukg3oQvkOvaig2
	/pHe7uCOlmUDQUDKz5VrsECZf/KOQj7yB14Da5IlS8nTmxSLmdlv6uxk6hMnsL6sVPh/jyixxES
	XT6K1DJZ4EghfZsrEzEPFfEHxe2k=
X-Google-Smtp-Source: AGHT+IE3oKP/ZG1r8uKgINUFggM9LogV+j3EcBdZROtDDdmm6ZL8rbAmDIPOfFLxQs6lo+OpxLjOO/ObGtTKutq+PxU=
X-Received: by 2002:aa7:c50e:0:b0:5a4:6dec:cd41 with SMTP id
 4fb4d7f45d1cf-5b7f57f3a8dmr2170053a12.28.1722591975996; Fri, 02 Aug 2024
 02:46:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801145444.22988-1-kerneljasonxing@gmail.com>
 <20240801145444.22988-6-kerneljasonxing@gmail.com> <CANn89i+gpyrzH_gd0oyrfnMovx0B6FWGS+7KKLydaKayFXh_sQ@mail.gmail.com>
In-Reply-To: <CANn89i+gpyrzH_gd0oyrfnMovx0B6FWGS+7KKLydaKayFXh_sQ@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 2 Aug 2024 17:45:36 +0800
Message-ID: <CAL+tcoDpB34ucBe8AH8MAzDv8L-9o_u=Sg=9=rFyuOHP6bduiQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 5/7] tcp: rstreason: introduce
 SK_RST_REASON_TCP_KEEPALIVE_TIMEOUT for active reset
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	dsahern@kernel.org, kuniyu@amazon.com, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Eric,

On Fri, Aug 2, 2024 at 5:35=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Thu, Aug 1, 2024 at 4:55=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
> >
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > When we find keepalive timeout here, we should send an RST to the
> > other side.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
>
> Note that this changelog does not really match the code.
>
> We were sending an RST already.
>
> Precise changelogs are needed to avoid extra work by stable teams,
> that can 'catch' things based on some keywords, not only Fixes: tags.

Thanks for reminding me. I will revise the changelog.

>
> Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks!

