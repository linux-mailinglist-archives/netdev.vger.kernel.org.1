Return-Path: <netdev+bounces-191151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C00EABA47A
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 22:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F6131751C5
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 20:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE82227E99;
	Fri, 16 May 2025 20:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zn8zwB9G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9CE1D5143
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 20:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747426081; cv=none; b=EpKNrmNiQSLeonZSjPumGZ8Cd9TAymb/ILn3laY7sA8/0YNKJZyFYIuC597Tyw2XhX55UJlBSeZYyp7Rj6PJgjjz4HllR+s4UvJPc064/e4h0jG45OtcY0hrgO/aTePZKsnBTq6e8Gd+v18IPk18V3pAKvGTReN/cI9iFa4XdaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747426081; c=relaxed/simple;
	bh=DZx1xzQFzzLIkltwNOLVSRLRDP8xL8W+oBLTLz89S/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SHT7RAaz+JiJzKCK0THpBHhgt34WLl/atLF0tg9rwO6JWXZcXoPe+PV298Y0mda8SSbFq8AyYILncnmEDklTC2i6vG3SxvWddlj9rDQ/LQtWezSNWgYX+rCsYLqqZqgsvR7xkGDl2wb9FYS7+DLTP8vnG8G30ahZYBWjeHTiBqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zn8zwB9G; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-47e9fea29easo14581cf.1
        for <netdev@vger.kernel.org>; Fri, 16 May 2025 13:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747426078; x=1748030878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VDYXmPcCBFUKCrITx9bahoWrqCPbfFOALOeElZxyjJ4=;
        b=Zn8zwB9GZ/kJMOmcgvfacBGtl9xUtdNgmUBc16n6ptipeFyTQ37ct73vVefDcLp9V1
         Am83p5sG2pDvU1HX56JaXGNesixpoJtCAcO3FYgzcSzSvpQ/fxtb2i2USZkJ74Kodhmd
         Jax3HDoWLwtzxuF3bYha3LO4W8JjaY8DqkTPzfdSeSc894TppguSd9LCuSWVPssQs0HA
         SmpnzoRzpHamS0YHFS8wVxQ3KELI8OQlDCgl8Y65GMuKBLZsCijB8z4RHK3oAjkadN4D
         35xmhX3a4WwMNctgkeh7APpvgeeErws7dYKgOZybssI3UPojHMtRH1AfRXGaVY8RAEOY
         ebkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747426078; x=1748030878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VDYXmPcCBFUKCrITx9bahoWrqCPbfFOALOeElZxyjJ4=;
        b=uLlyP8l6Nd8H9oMi9AfjW8bAXrJZYSQhWEb0DqcX/cxbCp7gLAP0wqiYnpP/6rztUs
         e9gI6yZSnOZv6/YUTetgZmk/CovwBNbEc5A3RYk8J+CQzLNyrNAAvZpzWQ1rLt7wVJ6e
         VrTEnHxfh7Zr0iwb8h8ZsHwbi4kEm4f4hy8Oadh7RKThk9tF4cfGSq3sPqe7lcxd/o1w
         GP8m69a3vxvwjs7Z4TdmA9u/GvV21XBqpQH0ebahg2KRNFlXFiVZli7JZUIgYvUsq+Qb
         bssCtaGx6ov2pZXNo4YWBczj+Cc7DpijC0zJaTgCZ6f1heICUBj1Nx5PHNQNFxx0ItAY
         QntQ==
X-Gm-Message-State: AOJu0YwHtYF282eBI6NcX1ni/WVBgnb2QO+QDM9KVbmd9Nlt8yFW+E0M
	PltjNy9ODYDQWM/u9D0X53UY8BJ0zpT7MPC/1v+7sU7WVot0QdvUXCeWDSc4qs75C6iKWk8aMfo
	YnlBVHObl/RZ3udMMLG+FYK06wVWO9AMGGuWaHD1q
X-Gm-Gg: ASbGnct1VkAjcQeoa3J2AwyS800x0H16c5bDrY2riRZp0D/GL/+l9Z31/QHffDfdr8R
	uuu2L7dQLjUsTJFolt7fp3bGJsscPe9bvcM9e4l2clKLnfo/mycEz1aDeklUECJc9hgWSFxIX6/
	VOjO8uDt6l+HcwcP7jjlJG3WT+KJfbMyBMJgQrzGDPRX9583LJqaHg6ySZnXeqoX3yag==
X-Google-Smtp-Source: AGHT+IEFPFax2QvYEfXuA8kORgi6wseYm8AziqtQ4gqsb9hLTsW/9Tjcxay+b1JpOJQlxgO6vSMciFK7fJM5MT8k/Wk=
X-Received: by 2002:a05:622a:19a2:b0:494:763e:d971 with SMTP id
 d75a77b69052e-495a0f5ddafmr458671cf.23.1747426078228; Fri, 16 May 2025
 13:07:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFYr1XPb=J0qeGt0Tco1z7QURmBH8TiWP0=uH0zhU=wCQKCtpA@mail.gmail.com>
 <CADVnQy=upW8ACnF5pN0d_AJtGi_OwT2VWc4Jg1nJ47Np-Qj66g@mail.gmail.com>
 <CAFYr1XOKceKP50Nc=T02McTa0FNdRNB0zEQUVop8PDW4F-dxuw@mail.gmail.com>
 <CADVnQy=C+9ogbtS7fVM9cev5iT+6Fz88H2FTKcjwKFnDbsUe2A@mail.gmail.com> <CAFYr1XNeLcCx4pur-RTHGcn_2hE-w6TYFFuOKFFohAXxTxCSag@mail.gmail.com>
In-Reply-To: <CAFYr1XNeLcCx4pur-RTHGcn_2hE-w6TYFFuOKFFohAXxTxCSag@mail.gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Fri, 16 May 2025 16:07:41 -0400
X-Gm-Features: AX0GCFt-iGCt0RyPPiY4HmHex2mH_b2FyT36XNIks1en_0-BbP1iRxlzBfI0-Wc
Message-ID: <CADVnQyks9OFDNnfm0musnouD8680GO+HfCk0he9psS+3UnfYUw@mail.gmail.com>
Subject: Re: Potential bug in Linux TCP vegas implementation
To: Anup Agarwal <anupa@andrew.cmu.edu>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025 at 3:54=E2=80=AFPM Anup Agarwal <anupa@andrew.cmu.edu>=
 wrote:
>
> Thanks for the detailed guidance Neal.

You're very welcome!

>  I will get back to you with this.

Great. Thanks for the fix.

> I am assuming this is low priority/there is no pressing timeline on this.

Yes, exactly. There's no pressing timeline for fixing this 17-year old bug.=
 :-)

Thanks!
neal

