Return-Path: <netdev+bounces-131144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE57C98CEE7
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 10:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E22E81C2157B
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 08:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773DE195B18;
	Wed,  2 Oct 2024 08:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LvqQQfEf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20B646BA
	for <netdev@vger.kernel.org>; Wed,  2 Oct 2024 08:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727858309; cv=none; b=P9MgIvs6snBOduAVk53KTVc8DVfdbr7LnPvZC1QXl0WGsYLSZyd8A+aNDiaClZpesXDICvcNb/nVGXT2gvUWe5baincGpFza51dBVgkbTQrnAydYBsneYnDFxmMhHxXbApXmPjyd3PAOkBssuWaTQxdvHHHVvRxvcOuJJJhtThU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727858309; c=relaxed/simple;
	bh=tg9Yuy1oQqP3uwGcSnIizrVagbfTpx3Bt7fqJHGwzHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RNmojaXDDkD89JdDWZOMEt+3e1iE6lJIyVnecj4gxl9ZnU1t89apush6iDDC5cvVY7xfGTTXcq1rqyvG2cbM8IiA7BazfREaY4EzZLrAOuxTwSDgFNm/wbxBHFIaB4A2eVh9vhvHaYMKPQN6BJ4DexuKv9EKgmj6vH8BUZpixtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LvqQQfEf; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c8952f7f95so3897552a12.0
        for <netdev@vger.kernel.org>; Wed, 02 Oct 2024 01:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727858306; x=1728463106; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tg9Yuy1oQqP3uwGcSnIizrVagbfTpx3Bt7fqJHGwzHA=;
        b=LvqQQfEfSpDVtPB/bceKtmi1B3Fi1lk0IbYEC3Ci85oR2anUmrWmGLZ8Ih5JIFhvQu
         RrF/MbhiaBEn7DkS3mciDZItMzqqpuU0+w4r5ogua6ir/64v+YzHSxVymSAcaJAQ8FtL
         zLh52G6ASnvD0Nnl0n67xr5QDqDe9Yxn7ik+iWFszT9ym9cqyyBZBNDrCo49V0ioYQs6
         klt5838qcchSAPLmVfr5NDYfaM4GI+lirlRg7iLyAyW+oUXl2cPekf0AQuFYV2sqte84
         EQDuyJtEV89VZ7k9l6WYR4VAJC3bUWfj35BSrDDlHWHRrKgCrgZdQcNB0IM1Ne1huALE
         slyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727858306; x=1728463106;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tg9Yuy1oQqP3uwGcSnIizrVagbfTpx3Bt7fqJHGwzHA=;
        b=wUMbgf5RLij1ifuoQdPnxTY4qqbbiRMF+J5C3TJx956D9Sw4nfUDMPPfiHLJPwVw31
         TOvNxLsGx2FuEKhnIZuyBviNAH2NrFzT4kFsp+h/rRzpCxRu10wCS0uimKh9N5cthv63
         jdB2EYQg5PFxzOqW7u5T6YSqG5o/YMaaHb6rPdqiyqwJqGRhFpRLYOKQIP7AlF3dOhYq
         KN/bfrPCsAxDSnD0JAH/iuMfI/V46/nklVejU0WAxdmD8nwzVIKs2E9+qZFdHhhgC1VT
         wgJ9ngfwV97aMQV3FGNjErg3tzyn7gFV9tiNXQ2nmdXeLcdSs15lmFQsXiZOfJ8/Fif7
         hacg==
X-Forwarded-Encrypted: i=1; AJvYcCUpX+MQbgmF+fnkZbhnpzm0lfMKokgTJHr+MaLIp4cLu/bzeON/ByN3YFDTpWT/8nNWIQFYjKs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh917pEjqPSVv2nZMKBrdDRUxCORTNMUyJx/GyuKT5fD0wJ2el
	ttqull9UuDfhrBPPYSwL6SUFztPvqLfhkB7oTsztJyzHsgsb1NCGxvCfJfhYnEsrGQ2ACN+QUeG
	6zccZ0G0bT87Ysl0u37k6/mLIVN9parOzyGiQVinpLdC+LPFDaVaO
X-Google-Smtp-Source: AGHT+IGbII/sXP9pKLqf90mzIKZBgL8roXgI5tS2gtMI96SfgGAAQShZi4TfY3d6RmAQ1MMYTWjdxy98gkx58B+oQWk=
X-Received: by 2002:a05:6402:3546:b0:5c8:8381:c1f8 with SMTP id
 4fb4d7f45d1cf-5c8b1926a16mr1125934a12.9.1727858305501; Wed, 02 Oct 2024
 01:38:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001231438.3855035-1-alexandre.ferrieux@orange.com>
In-Reply-To: <20241001231438.3855035-1-alexandre.ferrieux@orange.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 2 Oct 2024 10:38:11 +0200
Message-ID: <CANn89iKg6J6=MZSLUy6odZSSddJvPyJRSz079pidDxDa1Yu-Uw@mail.gmail.com>
Subject: Re: [PATCH net-next v2] ipv4: avoid quadratic behavior in FIB
 insertion of common address
To: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
Cc: alexandre.ferrieux@orange.com, nicolas.dichtel@6wind.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 2, 2024 at 1:14=E2=80=AFAM Alexandre Ferrieux
<alexandre.ferrieux@gmail.com> wrote:
>
> Mix netns into all IPv4 FIB hashes to avoid massive collision when
> inserting the same address in many netns.
>
> Signed-off-by: Alexandre Ferrieux <alexandre.ferrieux@orange.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

I guess we will have to use per-netns hash tables soon anyway.

