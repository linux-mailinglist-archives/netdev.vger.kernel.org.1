Return-Path: <netdev+bounces-164383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7422BA2D9DF
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 00:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D46216175D
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 23:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0273F1922E7;
	Sat,  8 Feb 2025 23:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EGRHuTub"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADAD24338C
	for <netdev@vger.kernel.org>; Sat,  8 Feb 2025 23:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739058473; cv=none; b=YjLBWwpSaZVRTygOLwAs0ok7+WdU1yvzzLwd/5VHkEfoyb1kXGL0xCD65RzPNHJztheTgSiWvYnmeQtQILNF/EgUvs6Fw2zxDP4yrbAZ+gX7xHnXMNYskIYo4WF8XbBN5Fh8zKgGlhzPDiRP8NHfMi0JqAdfJbK7sB+WsMfp9ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739058473; c=relaxed/simple;
	bh=5gyvwXll5Pz9a9ISlp34v7AaMEXugnxVOAb2wP7mJag=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ETelTnglUg/m0PZFlR2NvEZVPDYEsvRNn02XYsMkhrbGn+XZ5++rTrU/KLaroIYQrWKqZBzD3xwyiSoTpanzI2ZoiX7nX2HzvT5zDthVajuTu4GOP0cYL6ziEK1zDuFXnSgNnqKZOgTR388ZgXnXxWmni7E7aGatXDLI/R2lrhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EGRHuTub; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4679b5c66d0so197031cf.1
        for <netdev@vger.kernel.org>; Sat, 08 Feb 2025 15:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739058471; x=1739663271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5gyvwXll5Pz9a9ISlp34v7AaMEXugnxVOAb2wP7mJag=;
        b=EGRHuTub0pzqAuSODYrMFGJrV5p1xlIz69rYqJcxE1efelrHzW1uDGPIy/VBc1gyJy
         1uFat8zYEx/LTXgUvAr3Gc4HzUP7rhBQ0L6uSUBhJMQPrM9epBN3paL1OgAH8BEfclV/
         Em0kmcu5CCixcfXf2cuy4UtkmwWUpTqw8WvAt9xTcFegn374OlBnVrIuyzi78vnxN+oH
         X60E38bfn2+ouOj05CBDHBALajhl0qIPzCehaw+zzvEPIkXDW9Kfn5KCw0g+XRD6e97/
         VeN2KCSg5jDKbspSb3K4KQRgK8fiSTe3EDOZKJpk5CZf2Gz7t2ar99griXK/7yOCg/aU
         1UnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739058471; x=1739663271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5gyvwXll5Pz9a9ISlp34v7AaMEXugnxVOAb2wP7mJag=;
        b=KHOh4NowbjKc7cvYN7al5nLfiyybYzg31EOseSgDcBxkKG+HxYl7HCxoBsetzAzxS7
         /gEltZYPtDZcRIIOPU5pupD9l9ONk0XSy/hjP/9Rw4Z4TBY71g+dJhLPL/Bk7d+iKOl4
         VjGqJf8L60mFC3TxjBiZd/lMVEM2spke6LDGQ/vTAJtnXFIdDAVZ1oZmQf9g4BGLMYFx
         20FGCrM6TPxHcUkA6zgmfE5E28XMPdleyenIQ8/eD272IzmZPqsIwGl1L9kmFH2GHTDQ
         m5OLJQRNRzeaSqkROrNdmD/waO0Xk+AqfEpdvfM1P9PPbnoqSCFpJbmv3LHCZjicGpfn
         sH5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXvHUZhAWe0oQrDeNwod4QUGUcDcYrdOBLIWZa6Z+r4PU2mveNFIToX30VMmrbzvsSpHTO3/FY=@vger.kernel.org
X-Gm-Message-State: AOJu0YweIy0kOyQqGDdUhgbexvNw7P5gtLB6vCzLJndQKRVxHKAqo3RI
	jDRy2Flgxj1oU4e2ahsjZQxch0HyecietpXc4saybjz5wu9hsJiUT3bE7rHgTUY/UommwYwbxj4
	haR1zdmCetn5VWgUVDt50XJXAtKeMOxk9q6Nq
X-Gm-Gg: ASbGncsqTSwufIOvhbL5u5ijcis723LG5ooHTklK1LR5GHfgSkMmyacf4BGsTKZeSgQ
	L89naYqfeJSyf73g/c6wKHAdDmVqSNyo7bqtkIodESK91Ohe1tCA1U26nBpLUh6FCwo4BxeM=
X-Google-Smtp-Source: AGHT+IFf74V+SrSjzZFC5sMBC40Nwy8awh6DD7BhCl5ZPRxSa+RpbtZ1pNo0MaGOsz7pLjPrQ8ijN0cHxLE8XifkTlk=
X-Received: by 2002:a05:622a:5c12:b0:46e:1ded:e31f with SMTP id
 d75a77b69052e-471759fcbbdmr2595841cf.4.1739058470950; Sat, 08 Feb 2025
 15:47:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250207152830.2527578-1-edumazet@google.com> <20250207152830.2527578-5-edumazet@google.com>
 <CAL+tcoD8FVYLqJnA0_h1Tc_OeY4eqmrDPQ7wJ22f0LHxSG+zBw@mail.gmail.com>
In-Reply-To: <CAL+tcoD8FVYLqJnA0_h1Tc_OeY4eqmrDPQ7wJ22f0LHxSG+zBw@mail.gmail.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Sat, 8 Feb 2025 17:47:35 -0600
X-Gm-Features: AWEUYZmMpstqC7i4iEH6AfY3Wy7MDtEVLCKHfgxhqHdeWUDCALq7STTvJdj84sE
Message-ID: <CADVnQy=s-u1MKSwBv-E87rHCoyCSnN8ywXi2TYQc15RXffWFpw@mail.gmail.com>
Subject: Re: [PATCH net-next 4/5] tcp: add the ability to control max RTO
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Jason Xing <kernelxing@tencent.com>, 
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 7, 2025 at 11:37=E2=80=AFPM Jason Xing <kerneljasonxing@gmail.c=
om> wrote:
>
> On Fri, Feb 7, 2025 at 11:31=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > Currently, TCP stack uses a constant (120 seconds)
> > to limit the RTO value exponential growth.
> >
> > Some applications want to set a lower value.
> >
> > Add TCP_RTO_MAX_MS socket option to set a value (in ms)
> > between 1 and 120 seconds.
> >
> > It is discouraged to change the socket rto max on a live
> > socket, as it might lead to unexpected disconnects.
> >
> > Following patch is adding a netns sysctl to control the
> > default value at socket creation time.
>
> I assume a bpf extension could be considered as a follow up patch on
> top of the series?
>
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
>
> Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Reviewed-by: Neal Cardwell <ncardwell@google.com>

Thanks, Eric!

neal

