Return-Path: <netdev+bounces-209729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5DFB109DB
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 14:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AE7C3A4787
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 12:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3923D28541C;
	Thu, 24 Jul 2025 12:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ag76d2cM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A0726A1B8;
	Thu, 24 Jul 2025 12:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753358549; cv=none; b=nSQQzVPns+ROTw+PeOYho2ya/YhD/rHrhDWXVgbE2+Cb+x1h5ENBmGKjiyWyrtOurw1Xixm0NypSaQsISIuTTgURxeWMR5Pjt1HDhCzMPRza5ezNjX0Li5uqJdFHQpuUKWGkEmyiuVin+y63ebXPAY1QuVRpy6nPhrSVk4/F9wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753358549; c=relaxed/simple;
	bh=K6wFiF3aPVQCcd7WPZ3i1vEqpPjmDklDm5kgow4PrgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EsR0gvUvtRw3uTnj6iQCHkEDwqHiN41zP5YPQd/Wwr0RI70xEBJb951Q1XVBDnENug0Se7SgjHucDxoALtIC0x5QwVnD7xaIPG4VoYgDWhkaApmpdbNMwajFd/IEhCdnXnpMIa0hdrX2Oy5/RKQvS9QTO7NrAIKmUgvfXyzW3Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ag76d2cM; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b26f5f47ba1so824762a12.1;
        Thu, 24 Jul 2025 05:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753358547; x=1753963347; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HMARVpWb7qO6j5xEl6IUDVhdkLX0mNgAEw0wIm4jH8A=;
        b=Ag76d2cMM3TAX7+XZJRfhrFe5uLXOnpWwyX9gbSE+9YL5BTv9u4xA6MzIUSQTnTaym
         WIScK6eGta0ACiACiDRIzTrMLWq9wYjq7cJBIhOoJ/+AUr43dWilAQHTQ7XSOzKCkVf8
         /seTga1w8hEbQG0vkYHb03IeZl8MUepEYaRMVYL3IHNLXtzeCYksDANnU44RxePaF45G
         bNAN5W6RIIEDdiOLT+I1VPKIWqmnNZxAfkDP9tsqRqKvCxdjrmmzYtmBdBNcROE9T1CR
         yDesa76AdS+6xnKSb3sEQIUerwypr+dQjfpx75Sqf3guV109+/v7ZM4DWQSbnKmBI90z
         G6Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753358547; x=1753963347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HMARVpWb7qO6j5xEl6IUDVhdkLX0mNgAEw0wIm4jH8A=;
        b=LdZhth1YnN+FKKeLaP/l9ujmM9AsgmoL3+rVWSLAHTs3j26th7B4xO9WII8+deYRN9
         +15x5x8RC8X4Xed7H67MeCtjACFeKsOKobR/b+wlOzNplVB2SBmf5lQ812SoD9+0/Xk7
         FYF/RW71nLBsy2h7oBi0UN3yaWkVQGECbOtAe5UPYtPPm+OiDMBEgp6qHpkBoixKXjWv
         Yo6DmESfG0Ni+pRl7P9PmuyjytmsE3AOrQjMna90zAP250y/pc1vht6Ps9oYwUoI3LMo
         zaIFXpc3wHZg+2ziFODaDfF/EPXTDWAi7z3SgwuzRQJvs1kb4bl73Gy7vmvPFGPeM6iY
         z1Kg==
X-Forwarded-Encrypted: i=1; AJvYcCU56ueH9cUhq7xQkRLh0J7d2e4fTdAnReOy0m9FHY387Kl1j7fApiMNn9l4b/fCu1xT8d4Fnt0QtBc/pX0=@vger.kernel.org, AJvYcCVPcx/WMi0FHdyqJMpl4x5/TUxbjO04FXd/0rSAnf6uqq7vSYu0x2t0WPb9JxMI4WTvYVVbFqdI@vger.kernel.org
X-Gm-Message-State: AOJu0YxTXtoOLM6Tw9ex9lmwGVnqme9A6UqrivltWGLt7a+9HA+ZVcnl
	q4u1WaAlZ25yDW32ciLELN3oWVA/XoCG1cX6zYBTnadCMoKxvOIVvIr5MzjfJA==
X-Gm-Gg: ASbGncuYvU24MtUSwMOzrAge3bSvDTzMGTdSVZUCsaeAmw5pBrKS8u1x4m0/53qP8mW
	0KcGaMofEnqx1JBKfUanrlmfNoCXnSmCD7qQYBFjl6Z3+9VXTnVnBh2xyCnatWvFyO3E22HKaSc
	OlqY0eQkWlYbFH3UtTe+8ySyGW3Cb/64M3p1XQHW4xBb9zYEZWcMSD73OaSL+X8W5Zi4z2/7+h8
	g6st2HQfZiQjMYUYDBGIDIRSZjp4iip2JdXxiXxol5ae+gwGyDYjkLxIKJa4emlhds266i5T2/a
	ujImSeKeIQA487pvhMFaGK16JtinaYhaYi5dVlM/vDSXgcs7Yg4+QBGTNxWHHaqPPBq34x7m05l
	psNa+pOvGHi5G/MoFYiVc+3WwEFDrY74J4/m4YQ==
X-Google-Smtp-Source: AGHT+IEdl6Fbt8I3BHrC7vXu5S0UB6jJDmdyqjs5D0XQ3FmP16D8pEHXvbvPP7Y+LLvSVyuO+nAoGw==
X-Received: by 2002:a05:6a20:7491:b0:235:86fd:cc99 with SMTP id adf61e73a8af0-23d490ef288mr11402252637.24.1753358545424;
        Thu, 24 Jul 2025 05:02:25 -0700 (PDT)
Received: from C11-068.mioffice.cn ([2408:8607:1b00:c:9e7b:efff:fe4e:6cff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-761b0649833sm1529502b3a.141.2025.07.24.05.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 05:02:24 -0700 (PDT)
From: Pengtao He <hept.hept.hept@gmail.com>
To: edumazet@google.com
Cc: aleksander.lobakin@intel.com,
	almasrymina@google.com,
	davem@davemloft.net,
	ebiggers@google.com,
	hept.hept.hept@gmail.com,
	horms@kernel.org,
	kerneljasonxing@gmail.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	mhal@rbox.co,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	willemb@google.com
Subject: Re: [PATCH net-next v2] net/core: fix wrong return value in __splice_segment
Date: Thu, 24 Jul 2025 20:02:11 +0800
Message-ID: <20250724120211.30050-1-hept.hept.hept@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <CANn89i+vzHO3yferPBi1kBmVkRAd1mu9gD0S8tUPdVaDXapkVw@mail.gmail.com>
References: <CANn89i+vzHO3yferPBi1kBmVkRAd1mu9gD0S8tUPdVaDXapkVw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> >
> > Return true immediately when the last segment is processed,
> > avoid to walking once more in the frags loop.
> >
> > Signed-off-by: Pengtao He <hept.hept.hept@gmail.com>
> > ---
> > v2->v1:
> > Correct the commit message and target tree.
> > v1:
> > https://lore.kernel.org/netdev/20250723063119.24059-1-hept.hept.hept@gmai=
> l.com/
> > ---
> >  net/core/skbuff.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index ee0274417948..cc3339ab829a 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -3114,6 +3114,9 @@ static bool __splice_segment(struct page *page, uns=
> igned int poff,
> >                 *len -=3D flen;
> >         } while (*len && plen);
> >
> > +       if (!*len)
> > +               return true;
> > +
> >         return false;
> >  }
> >
> 
> Condition is evaluated twice. What about this instead ?
> 
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index ee0274417948e0eb121792a400a0455884c92e56..23b776cd98796cf8eb4d19868a0=
> 506423226914d
> 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -3112,7 +3112,9 @@ static bool __splice_segment(struct page *page,
> unsigned int poff,
>                 poff +=3D flen;
>                 plen -=3D flen;
>                 *len -=3D flen;
> -       } while (*len && plen);
> +               if (!*len)
> +                       return true;
> +       } while (plen);
> 
>         return false;
>  }
> 
Ok, this is better.

Thanks.


