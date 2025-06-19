Return-Path: <netdev+bounces-199573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B09AAE0BB7
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 19:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A318B7A93F0
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 17:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9341328C5A1;
	Thu, 19 Jun 2025 17:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OFexaoMA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1859E21D3E7
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 17:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750352755; cv=none; b=ZmnkvZoJbcslzY3kCW+gDxBstRfweW5miyrZ6toytuazxc1sl57l+OejLkGtmJ4cEp0w6mrJGQc/LZNVZ5q2AlKs2ZU1uFQ7RQdMlyMU+n5XrlCvSy953JMckTEc3OEXlPd9yf/fYvLZAGXLLKUJrwqBnFlE4VcW1WuUVFnAJF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750352755; c=relaxed/simple;
	bh=jN36V+UkEMiuZ2N45ZKWPsXe0sBoHqUVgJq6tSmNwXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bpkL7dveQoQjga5UDrVuyXFsFUCGGhPy7V1ouAIJgoBgV3D566yhxuXli7lSakh4hAWsvMnIa5bGb4g2K15HmAUpnJw3elzFMGaHEnJm5jtpTyIn/b5aIt9OfAc3/pDKJmVwHZh9Z4FpjcSszFJ3Avid6jNAFSGQ+NSPtU848P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OFexaoMA; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2357c61cda7so143555ad.1
        for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 10:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750352753; x=1750957553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jN36V+UkEMiuZ2N45ZKWPsXe0sBoHqUVgJq6tSmNwXY=;
        b=OFexaoMAKOV/tVthYS/EtHnoIm2b3NB3ePni/RQmFNtbaKi8dZpwZ3kWU1uAjIyCuP
         TSCYe335Apb6xf7wIvOimbdHHUIQ1u6yW7eQU9ICyDJcGu70kaEB/K4V5BLVXDahOSsm
         3F9US8gdqQA8F8gVmTysqAw9JDkImOwBSujqcu3mVWfQRUqjBeNxy7MYFxIIpIu3ZT1l
         1et++0bHhdOyKOX2Nwrt0WJZA3hLAdxXxyLqG+vWqoSMJjVnc3RY3w7w2HShMRpKqKR5
         Kfg9j+8w/Pv5eZ1TdDU41b4Q8hzXM/gjjGibDTcdTCDCS6c8W3kgbbLp/qc9GN8xjoQa
         dS1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750352753; x=1750957553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jN36V+UkEMiuZ2N45ZKWPsXe0sBoHqUVgJq6tSmNwXY=;
        b=XVlot689E/dbOzWyy9Zf/4P0nSw3AQguqf+IzGyoSBJ4O8CJjWdUNEpy0/Vh8tJIk6
         sHaxQA4IKoO2dLkZif/XX8VUuZQ5GdD0u2usm0k4XRQtXUBmDvzoeoE85Wy9IrzPjq8P
         nCnawb4bKeLBaUEfP8Lmk6jcm4DoTZ3NAzpf/1ko6J2WwRmk/9lHRclln2yv6L26t4/+
         COmisSBHNmpE1n0p8zky2rW0AYNeA9IAoHA+xpD+dpprzs2W4GUx4gM5UWrXE/CSfKxp
         ddS7ijJCHtywURW6O/tyPSzzzxsfRxKzUXr+oVe87utWR80p5Of8LgqMO4nXnIxD7OVG
         zLdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXr3JtL8Ih2ONqcCxS14ZWm05bkUm1GI2D+kYjY3edQ3q0ubjBHT9wWafV8U0T2113OnzXr+QA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS6yBmz65t35Cd3ijDs0RhonEsgGa+BQ6nYqGTTBTyXn2eQOwt
	xkLLdB3okVO68ahWgc5nY7xgOwzYwLEMzm2ACGfq0HS6b8RswCX67iItXagoeJ+vj2mEtERSJmk
	XQGuktBWzcvNqeP3kUaPdYpg/28IWsCtCrTa07mfs
X-Gm-Gg: ASbGncu+6FxEtYyZCjeqZDTfEAkKLda6Ds7zwPnCO+dVCfY4ps4hm0B3xXpZNT3zfeW
	3sPibcOdB63lBcQ+QhoH51dH968MQ+wLIi+fsdcYhyHAN6pM0uwwYM/HkMbx/mY/OZ1SZ92fsFk
	3O2UlIbmA3ITUw6oAqgAY0X49hxH29VnETzrYCplv+AMlh
X-Google-Smtp-Source: AGHT+IHBoqiPScR/zsv1kvJMCwfwqRmUY/QUQzO9Cn9XCeyjsUJZbuwfk7x6aYyXYdOhd+nVFvJsQ2gPWXvq3cUBLdg=
X-Received: by 2002:a17:902:f64f:b0:234:14ff:541f with SMTP id
 d9443c01a7336-237ce047d0amr2886185ad.21.1750352752967; Thu, 19 Jun 2025
 10:05:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250615205914.835368-1-almasrymina@google.com>
 <c126182c-8f26-41e2-a20d-ceefc2ced886@kernel.org> <CAHS8izPyzJvchqFNrRjY95D=41nya8Tmvx1eS9n0ijtHcUUETA@mail.gmail.com>
 <f445633e-b72c-4b5d-bb18-acda1c1d4de6@kernel.org> <CAHS8izOhNRNXyAgfuKW1xKb8PTernfer6tJfxG5FZmq7pePjwA@mail.gmail.com>
 <a122981d-ac9a-4c7e-a8a3-d50a3e613f0b@kernel.org> <CAHS8izOQLvPAE_E2dgMS7-11ZGFK5jmZ7q58LZCnhymhhUj2bQ@mail.gmail.com>
 <20250619095835.6ef52aee@kernel.org>
In-Reply-To: <20250619095835.6ef52aee@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 19 Jun 2025 10:05:37 -0700
X-Gm-Features: AX0GCFv562JtizA2SIM9AYmy8maTRimTtqBBXtYOtPbIo-G_JCECNhN71fZG13Q
Message-ID: <CAHS8izOeQ7RPHABQCLP8XWfH=V+hDwBg4HTyzWhS=7CS1ZzFww@mail.gmail.com>
Subject: Re: [PATCH net-next v4] page_pool: import Jesper's page_pool benchmark
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, 
	Ignat Korchagin <ignat@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 9:58=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 19 Jun 2025 08:37:05 -0700 Mina Almasry wrote:
> > Jakub, this patch was marked 'changes requested' for good reason, but
> > after investigation we found the patch itself is good and the issues
> > were elsewhere. What do I do here? A resend of v4? Or does this un
> > 'changes requested' as-is?
>
> Do you want to update the numbers in the commit msg?

Oh, I thought it's fine as-is. I can update them if need be, no need
to trouble yourself. I'll upload v5 with updated benchmark results +
make a note on how to cross build it (specify the KDIR=3D arg).

--=20
Thanks,
Mina

