Return-Path: <netdev+bounces-86267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C891589E4A6
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 22:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82EB6282742
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 20:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C77158209;
	Tue,  9 Apr 2024 20:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pFeIJf8h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E772905
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 20:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712695672; cv=none; b=qXDi9YYg5OCuAdbVOLCTYfZSRcvqBhgV7z3ORA6qiodYlLf97VfpEmLqsEyTxdDDvHHomlqQdqeG2ASnxAaSViCov9CF5LQ9aqRA0MCyEJuNMyKz3bjFPSjOcyvzfjdO6Ky/uT536AfncjDzDfsIorh4FuaRpaa29VjIiN1dn7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712695672; c=relaxed/simple;
	bh=ly4HEDGRIIfWSmkQwmZD7sqaKCpGxTM16mzbWb1iDFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NxvipDrs9JFiByVwbMlokMyjSPokdqawtzmzw2r0r6PPHvYLj9wTWxrpugW/jVyTjaHX1KvQT2YibACNQVurcGdvagKo/FYoTVA1whnIMPtJLsykg2RliFYP9Ztb5vg65VZG2FQw1zWh9oDi/MlYnuqvpGsbh7QS2kpKWoSo0rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pFeIJf8h; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56e85b7d2d1so1603a12.1
        for <netdev@vger.kernel.org>; Tue, 09 Apr 2024 13:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712695669; x=1713300469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vk639B3gQVwH7movCKIr1m3a+eQVk9EtJRWyGcsGvTs=;
        b=pFeIJf8hf04e4CquHKkBLUe+cXFLIKbbg/Q8vlwJeD4AYkowD5FnWkl5SZZZqt+5JZ
         HXZsDICc1Lya6L9LKOglNcJY/g42jxS0ppYHhPEo/kDEZyCImhPmwfQSb6l0vFycuxV8
         9UyOsO2n9sVJc2mdAVOo3ey/JcdIUTmdaMrUqdNWwvmBo6L0mKoyt8t25rwP9htsmPf5
         Fo2raXY3xjGIpWNrF856J/IADh6CYupdfym5qd1fpTklwxzzqL0gTOGCnVpdCyZjCQI9
         5gH89OTixOSJt3OOjbphnLO4fzUnaoa0u2rw24b+DyoptGTpTsTQ+SSap29BWXkxbpAT
         SElA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712695669; x=1713300469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vk639B3gQVwH7movCKIr1m3a+eQVk9EtJRWyGcsGvTs=;
        b=lUUIWcygrcdupvyZn42k6ccMlPql9lpMCrgcWr0QEecJaIufVQEXGWnBfSh9+S6wJN
         pN6STmVoQeD9nRTZvqQiGxFKxkRdMEMt6SPY4UmPcHHY6gBvWvwI5roYk9xZt8saD3ai
         VZlWB2e032g2DCMmm2elVJQ028+KZq0xhMrMyGjnYbVSZGUq+JQ97pc+GK198GGumKIz
         uY3zsmwqOFDQK06kFtZTGJ5CGsT6GS4YHip7zJr/mxnEHCZ4AM2azws9sFk9waFVwJBe
         y3Bw7gpxZmxHslJGHGDoVeBUV0xPJMOvYNnqDGYsh4cBrkwFC1Ko/WtZMYRGasQo8od2
         Bj1A==
X-Forwarded-Encrypted: i=1; AJvYcCUkB+h5VqTJ44jzOLWTQJMAAQHBZMewGmfjYR867MiLedMAKlgsG44m7ub/kM+xQGScsbL7yLJQ/PH7x6K8snO5EEOYVMBP
X-Gm-Message-State: AOJu0Yw/hm9vXJgBjdi9J+NaSwsHe41QCsyyqa43rJA2152yCQUy++A0
	Wzbl48RHLopJCdIF9hnijE67BU8Qo8pKhs8pDeo+UTMRu9oItghV1c95ttyplTMnzCg9DyHzLUr
	kdRmIes9VYBkyDB1bHU++zKQBWWCkLax/SJDV
X-Google-Smtp-Source: AGHT+IHgLlIUnAxHuTFgN0iM5kbclBWYNM9VcM9ykxsg7GgDSkxIXFSip877hi3CzGcilCpoHJA1TmTVanaegzQnhPc=
X-Received: by 2002:a05:6402:1612:b0:56e:6e04:4fb9 with SMTP id
 f18-20020a056402161200b0056e6e044fb9mr3669edv.1.1712695669190; Tue, 09 Apr
 2024 13:47:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408190437.2214473-1-edumazet@google.com> <20240408190437.2214473-4-edumazet@google.com>
 <17498.1712695173@famine>
In-Reply-To: <17498.1712695173@famine>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 9 Apr 2024 22:47:38 +0200
Message-ID: <CANn89i+qQ0zk4+jua1oiTNz6wqj2r1LTbp+W+d5eUaK38U8THA@mail.gmail.com>
Subject: Re: [PATCH net-next 3/3] bonding: no longer use RTNL in bonding_show_queue_id()
To: Jay Vosburgh <jay.vosburgh@canonical.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Andy Gospodarek <andy@greyhouse.net>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 10:39=E2=80=AFPM Jay Vosburgh <jay.vosburgh@canonica=
l.com> wrote:
>
> Eric Dumazet <edumazet@google.com> wrote:
>
> >Annotate lockless reads of slave->queue_id.
> >
> >Annotate writes of slave->queue_id.
> >
> >Switch bonding_show_queue_id() to rcu_read_lock()
> >and bond_for_each_slave_rcu().
>
>         This is combining two logical changes into one patch, isn't it?
> The annotation change isn't part of what's stated in the Subject.

The annotations are really part of this change, otherwise KCSAN might
find races.

