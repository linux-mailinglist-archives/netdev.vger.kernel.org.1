Return-Path: <netdev+bounces-161727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B6AA23992
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 07:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F5F71887061
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 06:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C85F1369B4;
	Fri, 31 Jan 2025 06:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="E/TtfXBU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5E4143888
	for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 06:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738305566; cv=none; b=Pq2xfvU8qT9ID3za6YfTz2Kg6oB8f8kdJcd+Sc4KQ7wLQu6AekmkJPhZUYIrH3m3lBNI3R8s0HLM8L9PosrY7t+TAs+z8nQzw+89ZasCo55YcMwfYZAOHU7/UUbdja11mzbUuKk1J0JoaYm9BL1L3+/GS7sRs9wr75SqFSpVUs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738305566; c=relaxed/simple;
	bh=vYxGeBLhsC4Ii5nfXYewohZKI6sY1gOUaEQ62wwJB/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nlbipCtprevJRFdhhtQY21L+4HFQLkdggnP/9MPlG+26CRCOOJVHZEpuDJHZhg7kYRg+2ynvYgabxIXdXYhg1xTcY9+EklRYEFPj6Pm9VYXkdyu08mQnHhKlGSJ+87+QopnivJuKn6uZKcd2EO0+lPP6flDmwDyFmHhN/CedBVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=E/TtfXBU; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=vYxGeBLhsC4Ii5nfXYewohZKI6sY1gOUaEQ62wwJB/Y=; t=1738305564; x=1739169564; 
	b=E/TtfXBUPRylekYBIrAEc4TNdKPoZL/EbxpP/8n9P54B5KrhwAzFniH7/pfGUt4W523QV7zR3Yy
	vJsnmMUsVHG9FW4q2aassL4/xwXmrTnxvNth5OTwwh6zV8ITDXNaYzgu0C/+CMSYChOJs7C4GJlTX
	1Qca5DCgt0ej+FT3f7KvNIZAfSL49UMI1N4DZvgkauU4SJm5NE++cFM8QbI8T/HKCM/w/+jMGStkJ
	0SSBgGXJHyId5C7VkCdM+8JA19Z6X+UYKMgCKaJBZmLK07kg0fMH/+eJWiBCIePeyvfmRWBl+PdwI
	iJo5VFiafQNmRV1lVCoRm+XQ3PGXAJ3AlNqw==;
Received: from mail-oo1-f49.google.com ([209.85.161.49]:42191)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tdkgP-0001s3-KS
	for netdev@vger.kernel.org; Thu, 30 Jan 2025 22:39:18 -0800
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5f4c111991bso842118eaf.0
        for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 22:39:17 -0800 (PST)
X-Gm-Message-State: AOJu0Yyu81Bz6PduVy4Phot0/SwPf0VYYdWioYI+7lr/RoskQqV6M33C
	KWidxvh5qX2e81e36+XCmWEgld3uGziDLcnR/WjUccIxhHshYGFt/Y7tX4sjqOBGb+CLZt8EAB8
	lYWpc52wvi2X/3SdIwSNHA8Bne3s=
X-Google-Smtp-Source: AGHT+IEx/rAFEXiggBQs3PkS/l6S8j4s3HJUCfzR46sUKlsZ9N2u3GaqhOllj/klBNaoi4wJ+VrzSHL6Ctz4CzAp3nQ=
X-Received: by 2002:a05:6870:d1d0:b0:2ae:d23:3c2d with SMTP id
 586e51a60fabf-2b34fe99372mr6288961fac.8.1738305557038; Thu, 30 Jan 2025
 22:39:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250116195642.2794-1-ouster@cs.stanford.edu> <CAM0EoMkkk-dT5kQH6OoVp-zs9bhg8ZLW2w+Dp4SYAZnFfw=CTA@mail.gmail.com>
In-Reply-To: <CAM0EoMkkk-dT5kQH6OoVp-zs9bhg8ZLW2w+Dp4SYAZnFfw=CTA@mail.gmail.com>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Thu, 30 Jan 2025 22:38:41 -0800
X-Gmail-Original-Message-ID: <CAGXJAmyxX0Ofkb-bzK=gXHJtjiVFczYcsvwAg9+JfS0qLjhqnA@mail.gmail.com>
X-Gm-Features: AWEUYZnZtWvYmteJf78K40hbtbFe0TKmBlnk3Jdg4L4SeBzTz32kgALctWW7ydg
Message-ID: <CAGXJAmyxX0Ofkb-bzK=gXHJtjiVFczYcsvwAg9+JfS0qLjhqnA@mail.gmail.com>
Subject: Re: [PATCH netnext] net: tc: improve qdisc error messages
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, xiyou.wangcong@gmail.com, jiri@resnulli.us
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: 0.8
X-Spam-Level: 
X-Scan-Signature: 9c8d7c79e82d9ccd3af9a51b4d3246f3

On Thu, Jan 16, 2025 at 12:00=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
>
> LGTM.
> Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
>
> cheers,
> jamal
>
> > 2.34.1

Sorry for my newbie ignorance (this will be my first accepted patch,
assuming it's accepted) but what happens next on this? Is there
anything else I need to do? I mistyped "net-next" as "netnext" in the
subject and patchwork complained about that; do I need to resubmit to
fix this?

-John-

