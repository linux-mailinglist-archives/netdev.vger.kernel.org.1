Return-Path: <netdev+bounces-131091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85CF398C990
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 01:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDA8C286FED
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 23:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67601D4339;
	Tue,  1 Oct 2024 23:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BcqQd7CQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FAC1CCEE4;
	Tue,  1 Oct 2024 23:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727826253; cv=none; b=hWwKux2TpncD8YE5U0EPeTs/ye2zkDIN7s6iE+ZoAjqWvhZUIkGb07Mk5r6nrJK8b0V988usFY1C6a4S32QGT5pzp+IWZCob8IlU0CWb6uI6a4x2VcgLeIaHPryktB2NAqHugISWe3EbuB6cN0ZUp5FdWmHQYFjmZLvu7wYRdxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727826253; c=relaxed/simple;
	bh=MGEIx62eCkHNvpMW8MWSZKFI2Pn/bv+e1vafouF8wYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NZfS8vnMgkUSTco3wiD8EWYonniVdoi8/72j1OFiQ0JJEMLXdbIQj23w+gjBb5SulBtiebx6kuQr4eptzyqAnZ140e6TIis9TWbzr1Vzk6iJnWU8zTJnd4eEzUxvAjIrDqisPqcrdPnRBzwiHmC8QX0cHFXfYGoeFPQY1BNwABI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BcqQd7CQ; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6e214c3d045so47052667b3.0;
        Tue, 01 Oct 2024 16:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727826251; x=1728431051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D7Rc86JBzho+P6Yy47Ijrb2yVcLWxyAnGCC1DrS6YRM=;
        b=BcqQd7CQ37R9oHp+0GmifEOCZljt1SPU1EGaBexSui5uZO4ou66y6n749zZVO8gKM1
         +hDwT4omvgMcKwETtP/REzxx+o7vAgTIboPy1K5ZYZbB/YM4W+cGD/8Sk/FqLd77rtv2
         f694CdxLxwaJBr/niev3kcmeKL25CoQ/TGvPEqlXax1EmSMd+d5jjQ7/3qVxoAandVdC
         MNXCoYuinRHseNz3mC4Dj+BYAnoTdGtDgGQgvJjqYVfEKuTjsfSSRYpRGr5CyZb10Jf3
         liz8B6Xe/HW9zgm8r79L3LBciZe1DgUl9OXEQUFiprg/4dAe8ujDsCsimhxiEGqKCrZc
         3ckQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727826251; x=1728431051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D7Rc86JBzho+P6Yy47Ijrb2yVcLWxyAnGCC1DrS6YRM=;
        b=agEVmkfIkxnwXJrVsalnHS16dE4bTOr18L4GWEgOjuO/FBfpGqnPjOrZUNu9DciNea
         lMjbiJfTbJr+qTI3ZGn+UCvW1ax0XXtEINQvcoT3BCKT+Igq2J0PsgZwJnfYCbUv1IOx
         aek5Tik6B5yoIsGb3uXE8c3biUaLJg/WQUnd+alkWkRC1X7GSsCimmda9rz3G48kztIe
         G7v/Fz0AALOqhN9uIvLf3PSd5v7hUBeP4d34LlFaX+BFF0h/e3p64awbg46KScFcYl8M
         pMZGsa9T2ijCM0GbTBVnutNBHd8Ge0pwOiKCqF6T2B0SMCjRwSMJq8BCiCPhASfIE7ME
         8uLg==
X-Forwarded-Encrypted: i=1; AJvYcCV+6HygqPAyk/cY159/46U9HKa6XCEphDpMGoYPQC1nJ1iFX/2NiHUH1YiNYzyyqyqy1RmxQ0hzRzzyqcs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOIrTCqdibCZBirjhBgkTFBswqcg9sjfx/k+1UKz6nu7Th++Zn
	T4u3ES2ZF2XDSUPbLI7gr3/F4zkD1M6qpLVwKJ49l+BsLL6YTZB5S72HgHFKC1RrHOYWw7eKLzx
	WRKSwZiRSSoft7ri7NeWwtFuG7X7+mB6/
X-Google-Smtp-Source: AGHT+IHZ+UaivpkqAsfqj3RyJmZzFyWXEu/LrA0FSjD7tlJx+mPJDjnL0Y8+ZfvZrlBJkVtZZ467mT8myFquPL8jsyw=
X-Received: by 2002:a05:690c:d05:b0:646:7b75:5c2c with SMTP id
 00721157ae682-6e2a2aee0ffmr17478877b3.16.1727826251312; Tue, 01 Oct 2024
 16:44:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001182916.122259-1-rosenp@gmail.com> <20241001182916.122259-4-rosenp@gmail.com>
 <ac48716e-484a-4d33-9f00-e793ede7ce71@lunn.ch>
In-Reply-To: <ac48716e-484a-4d33-9f00-e793ede7ce71@lunn.ch>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 1 Oct 2024 16:44:00 -0700
Message-ID: <CAKxU2N_6oGUP8b9fdMkrCtVETcivF5X+w8yaC+PTe2bvYpizvg@mail.gmail.com>
Subject: Re: [PATCHv2 net-next 3/9] net: smsc911x: use devm for regulators
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org, 
	steve.glendinning@shawell.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 3:27=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Tue, Oct 01, 2024 at 11:29:10AM -0700, Rosen Penev wrote:
> > Allows to get rid of freeing functions.
>
> The commit message does not fit the code.
This looks like a rebasing mistake. Will review.
>
>
>     Andrew
>
> ---
> pw-bot: cr

