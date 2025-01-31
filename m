Return-Path: <netdev+bounces-161745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A55EA23A1D
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 08:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F2AE188235D
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 07:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80DA14B092;
	Fri, 31 Jan 2025 07:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HxCjP0HC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC01413A3ED
	for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 07:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738308477; cv=none; b=ZHUoWUTpSHHOUDchI9KNQMnzO63QAat72xcM5cbp2FfTpGiDXZcMBh+zWzoBE4Px+DX0WHaGUwt7ZmZb/nR0y5eW8yq+Mbx3DCvHCEN0rD5aBRPNkB4P7KlJXnM/QCTFdtIYdYUvl1oBVl2ZXaRNevsrSji/7CoBZIrX5LH9Ru8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738308477; c=relaxed/simple;
	bh=VvX+BywDjuLXLurRZUDTOeBdeR2HdspsFUORXtucLB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ok1Rsx8+LJDwyiXG6SVlgieUgQKmm+GaIkkPpOFy3nz83saZ2q0ZgzEfdvmAj5T3gJlj7YwNHqjXscY9pCVHmwx/ZKHB9xFgMI+KV3IbNcrZ3rmlfEKjg2wWfgMdQT7BFxDU7cKSM4zhmQ59B052xZwsyaSsnhQf7jFjwgqAb8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HxCjP0HC; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-38a88ba968aso1406037f8f.3
        for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 23:27:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738308474; x=1738913274; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VvX+BywDjuLXLurRZUDTOeBdeR2HdspsFUORXtucLB4=;
        b=HxCjP0HCW1vFrQ3ebktGFSPEj7r3af7YoJAc3IsHTIr+1jnNG6+9xpqxSX1VQVZYXs
         0BbgFN80dir4VsQA2Vptc0+ZOCxKncEkH+RJKl3Gggmt34rG/sOi23bGpdmkeBsFQjaX
         HIZSz/WbJUzEKQo+FtykMFPr8osod3H7cVQMZlgEgKXVM2cEatc+ka20V56Vegg2CgQj
         TNmvKTsYMN5cvdi5rMPn43tKpsVk/fIP4ZwO2Cq9xTnobF+QcnxbFAgstctTf+03a+ij
         L8UZFZCIHLZEgK88zOBCQT5M1EMulT1b0RBmaqW152qAFtqlSbagAbVmjCDbxeOd4C8T
         caIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738308474; x=1738913274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VvX+BywDjuLXLurRZUDTOeBdeR2HdspsFUORXtucLB4=;
        b=XCeejkwF0FzaLAuAEkX4cRff41mQlvWPajFAVBRP2M5swr4fF78f4xoH9VmmDWZjyk
         4KWWq4cRKch3ajsthDIflJPObRDeD8efZsFqyw9B63A9mbiZBILNMie7vFxhtKSvdZxB
         hCk7sGJVyLXU1yXfFYGN9PYbxwDdfDKAFEBXL5t0pgrak5cN7u3vJ2Td+t85nu30+H2w
         pjtP5w4KLZH0qarXHIsViVMQ6j/msfAD1xakuVaRlQl7Oe8IYgoSILEz50Mu05MwFkqw
         LMPEWyFTgB9QIngLrLUtGi5ODKCZ13veabc6wbb73i2zslM9DrVsstu9clKP/WbFjy83
         A0Ag==
X-Forwarded-Encrypted: i=1; AJvYcCXSw+OflBT/W2GlP9S+6Rc3HY9TdalJYbamrEbaLPS0sb8i41T0UvYpJ5+AdGRHz4XuNVsv6Eg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+R3oJj8Nps7RLfgmA9823QiXeRgEs6vmLQOUqMJg0nJmXfrCM
	cXsHVoOvncT1VEAp68TEgPAjDNIu3E0+TO79X6GkRHL2cyL2YgjsgTKa8qXcuAAJKBRNG862Izd
	bl2Yy2X72P5Q3JcOFLVDlLol1R7U=
X-Gm-Gg: ASbGncuizkwXGkFsCSe6DQE/iZuNdb8Eu9VsOvfh93mmLnlBiTt4Tnsoa8v4DZtzwEE
	SJZd/govDlFj0w6I72F/JRzIny2kj1QaX9oU0gSQleeooJm3qKaLULmGSC1QryfQ5rR9XRH7/+w
	==
X-Google-Smtp-Source: AGHT+IH9/f4Wcch/6Ieh0/CMVkT4oLoZvkF2QsmnNlzlbKScReVCT/3eOpzv4+A9cO+pHXfOYkj1UbF7zQjLvK+7dn8=
X-Received: by 2002:a05:6000:1012:b0:38b:ec34:2d62 with SMTP id
 ffacd0b85a97d-38c519698d2mr7790658f8f.24.1738308474037; Thu, 30 Jan 2025
 23:27:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250116195642.2794-1-ouster@cs.stanford.edu> <CAM0EoMkkk-dT5kQH6OoVp-zs9bhg8ZLW2w+Dp4SYAZnFfw=CTA@mail.gmail.com>
 <CAGXJAmyxX0Ofkb-bzK=gXHJtjiVFczYcsvwAg9+JfS0qLjhqnA@mail.gmail.com>
In-Reply-To: <CAGXJAmyxX0Ofkb-bzK=gXHJtjiVFczYcsvwAg9+JfS0qLjhqnA@mail.gmail.com>
From: ericnetdev dumazet <erdnetdev@gmail.com>
Date: Fri, 31 Jan 2025 08:27:42 +0100
X-Gm-Features: AWEUYZlkux3dPZvPNkbZz48iqrLutqsP2gtXz7ub-MGWUxwI5wRbLLCG-0HCjuo
Message-ID: <CAHTyZGwogJxVR1-yFjNgYCDDToU0wY=XJO4WOpsmt2gzeRFgZw@mail.gmail.com>
Subject: Re: [PATCH netnext] net: tc: improve qdisc error messages
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org, xiyou.wangcong@gmail.com, 
	jiri@resnulli.us
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le ven. 31 janv. 2025 =C3=A0 07:39, John Ousterhout
<ouster@cs.stanford.edu> a =C3=A9crit :
>
> On Thu, Jan 16, 2025 at 12:00=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.c=
om> wrote:
> >
> > LGTM.
> > Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
> >
> > cheers,
> > jamal
> >
> > > 2.34.1
>
> Sorry for my newbie ignorance (this will be my first accepted patch,
> assuming it's accepted) but what happens next on this? Is there
> anything else I need to do? I mistyped "net-next" as "netnext" in the
> subject and patchwork complained about that; do I need to resubmit to
> fix this?

net-next was closed during the merge window, and still is.

Details in Documentation/process/maintainer-netdev.rst

