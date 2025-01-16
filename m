Return-Path: <netdev+bounces-158919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE39A13C89
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 15:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A9273A7276
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 14:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E92DB22B8A8;
	Thu, 16 Jan 2025 14:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K901ww6b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E30A22ACEB
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 14:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737038571; cv=none; b=ifSnRIrx2V5STE6c+W6iwrHy6wys7bmVmFyHFkmrn9i08W5tlxLKg6YSRlH8FKXxbl3F1cSTNnaQObzlP7RmJzUiDwDemSxrGeAtOZZMKWjEwqbnINIIqdSHGHXIhzhdt0hzo8FEdri5ub1d52IN2VY7t17yLn3U0w2wCeyEa0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737038571; c=relaxed/simple;
	bh=JWACmNfTekszPz+HRTEGFoU/ZgDEnzAtWE5xeFjnvh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mdeDO4CK2MQ+aqAIE0yZ2yK74LlXl/IM0INbsVUzZOaWz817Fi4bHpO5MxMRdJ1FvgwI/g1t5l4yiO5XHJeUuOLI8GWPt3fJ8ql5/zQg2pAzb5wJHipAaZ3AYxsV7qVKfGu9EZ7W4vQdenHOXF336hLAHNO6bP2vvcvKNZOWfpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K901ww6b; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4678c9310afso216501cf.1
        for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 06:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737038569; x=1737643369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JWACmNfTekszPz+HRTEGFoU/ZgDEnzAtWE5xeFjnvh8=;
        b=K901ww6b9/3jTYQqZzGfW75vbBzeVSxwLDnEcbEzk4WJ6Qczvgj/TnyCgHRiedvylo
         hcMwJDQnTdChYuCM80vL2a1kDSZF8SLqytMNNbm21ZPOOvPMapRT4rRwge63jPrNNNgf
         lIOYIMRZ+uwPNcbNMfQJ9M7jFfqnzoebxjonYno3dqMofniVH01FJgxNIjvDJRmJJ0UW
         FufZAiuUxr9VMinGkD1IWDXQkvIQP4DzewYIJYpxFa9lB5Gbf81WUsqcq06yWKgq2W4Q
         K56g+NEGoXH8oze/v59gMD983oXYCE3YSdf9MuaEel9cNnIGNU4o/xc88dUnYLyGrUE9
         kBCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737038569; x=1737643369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JWACmNfTekszPz+HRTEGFoU/ZgDEnzAtWE5xeFjnvh8=;
        b=P+aHmB1IGrerbnTLBZQQUZImzwKbjBAp+HX8M7Ol77XL0B1reLv11IeAKam93LlT+s
         dj7zxGxblYizizQG3P2pOvuhB/TbMtRHh/o+YNMFTxn3qY55pxZT/BCMxHgwLbYVRgki
         e1cMyjG2tCKbi6/TVQ/ksfEaUFpTjI/PGRo9/cP0183OmYBC2009JLwvWzBzpYFpVONR
         VEG9bf9ZQkAt14gxbEWL6E9WjO9ogMvzcJViZmn06v/jyFKy7UudTXAFBWKYzYPy/ogc
         tbN/sF+mjyb3OlFQCuOER+asDzlFzxvRyGk1nF8tfH9dbQX9CiXmWF99tcRHvnqHevMF
         4j7g==
X-Forwarded-Encrypted: i=1; AJvYcCWqZRxxv6UGSbTO0dxWchfL9AtchY5NGI9XfxAgw4wpQoAy/RcT8KsZVN2EFOiJuI4Ol7c7k3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFjX5U/1v9q5/32+BsOyz+GT5aLkRYOenc9to+ikYJpqxX0u1W
	FDxj1TqkAPtZRqn7QwFhfXSLGkX0D2/XsVVVbxIF+0JNMrBG7emKohMDEEsWxsG+ptaSyplIOAg
	GvQXc2MGiON6TKdFlPCRr5D1F5C8W8Wn6gWez
X-Gm-Gg: ASbGncvv7T1BTuMFrIDHtgUMNng1qfg27C4CL/589WXElm/EFxfImUW9xqBW+Uq99zW
	9Af4xhcIPdUT1itZB4ULfdFePWOekjd0h0pfv1sqmYqo6jYtEQGFANqjFXe3ZqhR28I3lec0=
X-Google-Smtp-Source: AGHT+IGKvDc3v+GBsndvUTDnN86od27z5mw7zJ/ru2aW3tfv3unMo4ooxWmdz5vcY+VXLHE4FHcEQH/EWvULLNL2Wv8=
X-Received: by 2002:a05:622a:182a:b0:466:91fd:74c4 with SMTP id
 d75a77b69052e-46e03fd14c1mr4142631cf.0.1737038568982; Thu, 16 Jan 2025
 06:42:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250115010450.2472-1-ma.arghavani.ref@yahoo.com>
 <20250115010450.2472-1-ma.arghavani@yahoo.com> <CAL+tcoAtzuGZ8US5NcJwJdBh29afYGZHpeMJ4jXgiSnWBr75Ww@mail.gmail.com>
 <501586671.358052.1737020976218@mail.yahoo.com> <CAL+tcoA9yEUmXnHFdotcfEgHqWSqaUXu1Aoj=cfCtL5zFG1ubg@mail.gmail.com>
In-Reply-To: <CAL+tcoA9yEUmXnHFdotcfEgHqWSqaUXu1Aoj=cfCtL5zFG1ubg@mail.gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Thu, 16 Jan 2025 09:42:32 -0500
X-Gm-Features: AbW1kvaVwBLW5lYWLdkNzehmw5hmLMldkACr9vHbBWkHuiNRKt4eWNAPzt8_778
Message-ID: <CADVnQy=3xz2_gjnM1vifjPJ_2TpT55mc=Oh7hO_omAAi9P6fxw@mail.gmail.com>
Subject: Re: [PATCH net v2] tcp_cubic: fix incorrect HyStart round start detection
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Mahdi Arghavani <ma.arghavani@yahoo.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "edumazet@google.com" <edumazet@google.com>, 
	"haibo.zhang@otago.ac.nz" <haibo.zhang@otago.ac.nz>, 
	"david.eyers@otago.ac.nz" <david.eyers@otago.ac.nz>, "abbas.arghavani@mdu.se" <abbas.arghavani@mdu.se>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 6:40=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Thu, Jan 16, 2025 at 5:49=E2=80=AFPM Mahdi Arghavani <ma.arghavani@yah=
oo.com> wrote:
> >
> > Hi Jason,
> >
> > I will explain this using a test conducted on my local testbed. Imagine=
 a client and a server connected through two Linux software routers. In thi=
s setup, the minimum RTT is 150 ms, the bottleneck bandwidth is 50 Mbps, an=
d the bottleneck buffer size is 1 BDP, calculated as (50M / 1514 / 8) * 0.1=
50 =3D 619 packets.
> >
> > I conducted the test twice, transferring data from the server to the cl=
ient for 1.5 seconds:
> >
> > TEST 1) With the patch applied: HyStart stopped the exponential growth =
of cwnd when cwnd =3D 632 and the bottleneck link was saturated (632 > 619)=
.
> >
> >
> > TEST 2) Without the patch applied: HyStart stopped the exponential grow=
th of cwnd when cwnd =3D 516 and the bottleneck link was not yet saturated =
(516 < 619). This resulted in 300 KB less delivered data compared to the fi=
rst test.
>
> Thanks for sharing these numbers. I would suggest in the v3 adding the
> above description in the commit message. No need to send v3 until the
> maintainers of TCP (Eric and Neal) give further suggestions :)
>
> Feel free to add my reviewed-by tag in the next version:
> Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
>
> Thanks,
> Jason

Mahdi, a few quick questions about your test logs, beforePatch.log and
afterPatch.log:

+ What is moRTT? Is that ca->curr_rtt? It would be great to share the
debug patch you used, so we know for certain how to interpret each
column in the debug output.

+ Are both HYSTART-DELAY and HYSTART-ACK-TRAIN enabled for both of those te=
sts?

thanks,
neal

