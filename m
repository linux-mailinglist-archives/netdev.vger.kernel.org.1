Return-Path: <netdev+bounces-140222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A21B29B5900
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 02:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65D2D2845B6
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 01:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F298782899;
	Wed, 30 Oct 2024 01:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNab54lf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D51E1773A;
	Wed, 30 Oct 2024 01:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730251049; cv=none; b=Kcf0CyPUxyLWY8hM51sNJk0RP4SDIWRaZ+bjHXVAI3fpFwgokSY1/CVDEMlP/Rrf6FhmzxXw9Jl8aHh6KgdGnQwQx2WYNWvx1oQMEfEeC0agtCL5OPep5zTFHn/0Zmm7wqavswhPmOUkkI2YF2a6MvaNIB/OQD7oO6Iw8JHe+8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730251049; c=relaxed/simple;
	bh=B4QwBQJ4d3C7YS6xsMevdxfVDWZ930qw3i8lMoKG+h4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uCnEHevKub67TLtgo72P7wkFvyyLFFipLTFiM6M0VVmdSCG5xcDyfgVS0Fveig8ABkuGpqh9HKS1UZKzzes/McpcTH3coTAN8cK1nmDGVkXk6h6dcHQW6lYU1B60tORVqX59hjSPEcyNa2LtAvhPq0J1DJaGVCePbcZ5bbSXMII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DNab54lf; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-6e5a5a59094so53253737b3.3;
        Tue, 29 Oct 2024 18:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730251046; x=1730855846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B4QwBQJ4d3C7YS6xsMevdxfVDWZ930qw3i8lMoKG+h4=;
        b=DNab54lfHtkmiHEhHsxpwQRIqQNIZcvcgUECqKjHcTNI5XX0Uhxoh6f39dDhLrm9oD
         HDfCoCT+fUsXv5lQnlUzJi/n4f5y90CkE57WIkBQXZLUI0fYpQfSfbiBJKlM6uRMmNpO
         zo8K5qzhtdJoTaoqdkJz2Xucl8WLNpscz7BZoFZbMfmsfWn4CjtoyJK15NBiPcc1jvsD
         L5S8W+IrYZlAfRYii8BLkQCpZ0NDJP3qpItsaCJQpnJbt+7QmjvkBubgNoYdsLd9Sm5w
         bGOnaCaQQDIoU7casWcGncxSyuJZH0eu0xjNOu5kG1VcQucmmmhEMIt8iDulalvbMYao
         NBSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730251046; x=1730855846;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B4QwBQJ4d3C7YS6xsMevdxfVDWZ930qw3i8lMoKG+h4=;
        b=BXknCWJzDS4/idrkmLKcTZWGDmFDrIIVS62h5leqzP1Fifou7lTe5aw4cgIq6ZgGG/
         MaNUm9kQZrhG3oUhpWfdhugQFN0q9qsOIGrxggRYVgYH3TJ2J7BT542DbyT9eJriK727
         sm7XlhtEQzg1azsS4u+hoq1cPTZq6xmDIENc3sG1cDHI4bSsqsBozAJLyBY2sN8Iaw46
         Ov9szqChAtv5bxQt8fyeUFPS67To9tCpN5TYJSQTbIPyf9ZVKawROvqq0NbIfpuGxvDw
         4mPZ4ox1jYf+5TI7T2DT7Jcj4sose/5tKY8Au0j1yIZ9JgXexncrZWRwrfN2Muy3EFY8
         LZ5g==
X-Forwarded-Encrypted: i=1; AJvYcCUPcMOqABMrJqvXlyyj/gkc6T02rWctHZiXTWJnYSQIu8gWogyoIKWvD1bpS0GLz4qPnQS5j3Os/H4Kel8=@vger.kernel.org, AJvYcCURCat8h4m/VXq+yfSUlwSRvOuaiTi6j+8x+MfoOYSWPB6iotj/BWeURw+jn6PadE3pTEKcADtO@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9pzuto/GVjX+go0cPS5Sl5ACf42FBbsimFldIgL+oq+Sy7EgW
	mthlIC0ypgLKUJIrx/KAQhFMTw2Sg+smBc3CQXRgSQBCQaeMdE8TrwzfTA+opxEt/Jx2AlrwRbz
	gIhY1tHS9JBrIxu4GM2eTRYbNc1IXyw4V
X-Google-Smtp-Source: AGHT+IGo5fwsbWtmFl7W1kUtIw3s96firGROCyx+bwBG33OAW49ptqGOfZe/Um3FNYmr9WGYefoZN+S8SYeT3JTf1T8=
X-Received: by 2002:a05:690c:9a8d:b0:6e3:120a:71f1 with SMTP id
 00721157ae682-6e9d896fca2mr141407067b3.15.1730251046073; Tue, 29 Oct 2024
 18:17:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241026065422.2820134-1-dongml2@chinatelecom.cn> <c6a30471-46f2-4cf9-b94c-c0a9119a77ff@linux.dev>
In-Reply-To: <c6a30471-46f2-4cf9-b94c-c0a9119a77ff@linux.dev>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Wed, 30 Oct 2024 09:18:28 +0800
Message-ID: <CADxym3bNPuE_a0tT4WETzcAJ88i6_KAOmZ4dSy-4HD3gw_dCMA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] net: tcp: replace the document for "lsndtime" in tcp_sock
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: edumazet@google.com, lixiaoyan@google.com, dsahern@kernel.org, 
	kuba@kernel.org, weiwan@google.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Menglong Dong <dongml2@chinatelecom.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 2:42=E2=80=AFAM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On 10/25/24 11:54 PM, Menglong Dong wrote:
> > The document for "lsndtime" in struct tcp_sock is placed in the wrong
> > place, so let's replace it in the proper place.
>
> The patch lgtm but this should be tagged for net-next material.

Oops......Sorry that I tagged the target branch wrong :/
I'll resend it to the net-next branch.

Thanks!
Menglong Dong

>

