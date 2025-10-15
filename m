Return-Path: <netdev+bounces-229591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70957BDEAE1
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 15:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86F0B420461
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 13:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90446324B3A;
	Wed, 15 Oct 2025 13:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QMLUJMhc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC64F32A3D3
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 13:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760533919; cv=none; b=bTQ2zercQN1JdVJ97slvttFJE1yCM700kOkz07byj/9ft7yWZBbeFvx0FKKvTB3A21lXznu8u/MwOhpBZJ0librL7fFTqUovJISTCKcRasKsx3y52ZvqkkDTDN0A179a06a96UY1cqDIdH+BXMMoS7yBS97fNqRxfHDxchvJ2Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760533919; c=relaxed/simple;
	bh=ZGbYqs7P32usVQ205d6Oz67//Nvsw1DR0lRtzK/d8/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tozzSBGNskddr69hpHzv20plI0ptgETiu6LJp7t1BWXfuGDpRPmZZIJfqnW7tdgdqkcTRGkkSLrNa9FLaKBdVkkIn1kmbsqvAPdKar2yk2nX8PbRwhAOS05MPm6PFgLltfQ9/c5y7j537PvdV4KzeNTUMVkBEbkKyUg56JWBr5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QMLUJMhc; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-635c9db8a16so6061496d50.0
        for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 06:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760533917; x=1761138717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZGbYqs7P32usVQ205d6Oz67//Nvsw1DR0lRtzK/d8/o=;
        b=QMLUJMhcT9Qm0iLrXHKQSApHwlJsn8jDosnZu3Sc7sCcoVm41N9kRwQjtx+f8xdwaY
         vrDQdENJp5Yf6dbI3CBAPnnrz7qBmzQsnZfNUwmyOezJRfbri5Yjm/3NMMKrchyfQeNO
         a0PK0q9cW91U8yi6CH7RfOwYmSHqFxh4l874MfGcGtFBs2cVJrD3cFv+GRS1rOAr1w1q
         gXNNwvVrjPj/0UPJ8cULMO7NmU/sAZL5I4Ofvqv92FTlHh9as816MoqVeLTy7MgVnOR0
         sAAsl6C+10/5aYCbrI6O2UkMESJqMWbKJu8AINf7xzAKYkwIhfdLRlIjir4ReNniRx2t
         yEmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760533917; x=1761138717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZGbYqs7P32usVQ205d6Oz67//Nvsw1DR0lRtzK/d8/o=;
        b=dIhmZoRSFG6UKniRCefc9Y0uPy/21m152WNdeev3xYR9/tzoj9BRRA/8PqLfjHJl/G
         uyqX1KrRlVf/ROhr61kE8yvN7m1fjnneduZiJavYo582BxD42WVOrF41HiBXFjXxQO9V
         +gBpTCWqqO9/pDwzkqLQb1Q3Dy6gqaaGPt//t9U7DN/Aisax9bXzLNWhE7f6Scmzk8NQ
         9iCjGb7VTQT8I5qNhl8xv/Dv6XJDSbv9JZhAPuRNH+dFVhQaISgkgDJZGEDAB+RYufis
         vYkWuvtlEMqUwnyazbfa4zrucTdkDrhdPONJC1calRdNQkgx9RJEZyNID+NcEB5Q91B4
         SqLw==
X-Forwarded-Encrypted: i=1; AJvYcCVrbLICdRAQbiZZh2n0ODO9hbeltueg8Y9F4l2guiIS5GwYJDIcnK4fxjfp2OnPE5EBELgYYng=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywd3A70P02Pa/2AsGIjVTzqVDFaSX7zs4tDk8jP+LcZQ3n+HY41
	Vr8bP4ibT5J57rwl50mTAtF1O48LX34AYCgYpiX2+psOzKjkRru+nx8iiVp+bZvAy+Ks00un7Bk
	gDwGtkQKWCxxXbB5ZNPD+UAX0gQ6SaTWW7PtRru+g
X-Gm-Gg: ASbGncsOIaLGdK7bOGntTHGS+BbLPDY118kOsK5lWz9HsxggAws/jElaI2BS2T6dDb4
	S0uoUrOyrcyobPxL0iF6QwS6kIQDP5csqLmnS5eTxc1oF2ddD9fUl31E2Im0e5ZRim2/vE4mHUj
	yYPsZWhH9soETfr1WHwFsSUUoGL6QCT26Umb+L4Ov+aVk0W9qkEGJue4YhNHYaj29nDeWwgZfNV
	ze1lgXH9WmvRNBlhRWojN97AlllCGor9Id3uD0EDGap
X-Google-Smtp-Source: AGHT+IEicYEiXEI701yep7cItFTOi9YlXZDTX8rGNJzHlhDRG4AiRBfZriq7oQ1mP8AWsHWNF+L2FND/GBUQcKkxjss=
X-Received: by 2002:a53:c058:0:20b0:63c:f5a6:f2ff with SMTP id
 956f58d0204a3-63cf5a706c5mr10676460d50.65.1760533916331; Wed, 15 Oct 2025
 06:11:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251014171907.3554413-1-edumazet@google.com> <20251014171907.3554413-3-edumazet@google.com>
 <a87bc4d0-9c9c-4437-a1ba-acd9fe5968b2@intel.com> <CANn89i+PnwtgiM4G9Kbrj7kjjpJ5rU07rCyRTpPJpdYHUGhBvg@mail.gmail.com>
 <f51acd3e-dc76-450d-a036-01852fab6aaf@intel.com> <CANn89iLH4VrGyorzPzQU66USsv1UP3XJWQ+MWMTzrceHfUNYVQ@mail.gmail.com>
 <9539f480-380b-4a29-afc5-025c3bf0973d@intel.com> <CANn89iLVxzmJrxhyEXYp26V9SZy5D66PS4ywf=vZ7piK99Hdww@mail.gmail.com>
 <c09e552f-883a-4e23-aaf0-5626071524bc@intel.com>
In-Reply-To: <c09e552f-883a-4e23-aaf0-5626071524bc@intel.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 15 Oct 2025 06:11:43 -0700
X-Gm-Features: AS18NWAI08LIZb3TbkC5vxI8rzGjA-oQc363lbQVzlCR2ItIWWfTnIa1VW2DhiE
Message-ID: <CANn89iK=VqVHGF57c0hb0_QHTvamLFAjx1f_xcMLoSr=KpX=dA@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 2/6] net: add add indirect call wrapper in skb_release_head_state()
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 15, 2025 at 6:08=E2=80=AFAM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>

> > I added the following snippet[1] and only saw a stable ~1% improvement
> > when sending 64 size packets with xdpsock.

1% is noise level, I am definitely not convinced.

