Return-Path: <netdev+bounces-95303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7888E8C1D6A
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 06:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BCA31C21BE9
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 04:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B06C14A084;
	Fri, 10 May 2024 04:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cs9K+daU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8656613C3C1
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 04:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715315136; cv=none; b=c59ybyJN9+NMHsaNiVRZ10NI4/V4rZELXwIyU2XigaFkt/0pzjlrTHcO0NZpM8T0+Bq/zF+cavJ4BrMxvdbZCDWq4N0HW4qdM5fbXazQQTe0uCax04YvX3Cw0dIbCNp2fLMSTb2eQlpC7iydDPRdazSVskLuA7IECamcvFzPMzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715315136; c=relaxed/simple;
	bh=XWUM+pYSFDwfKuG/KsJLm2Dw80p4Z8ax4UNSs8o+H6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fOX/YVLuGHX3CavGC5/IF4eAhY5uKRDbCdVHL6A6HCSoJF8kctHGZcxF4+2RTkjwqqbMCCxy08QYe7F9naJllT+ATIoV4eQ0sMGZIeHU75fxEPj3Ebvpr98y/oZ7vNivSqXtKC8NmyxZWO2MDK7TVJ1WO3/BdP+ta+tnpSPDrjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cs9K+daU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715315133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XWUM+pYSFDwfKuG/KsJLm2Dw80p4Z8ax4UNSs8o+H6Q=;
	b=Cs9K+daUMOlBo78JZTmBrwNAaoEaNYQuY1ZRgrwIvXG+MgtW9GidzIOLQA0x4FRIzbq7/9
	ek6jDGmH5ExvLWCUc43wSjAi/qNs6qD37T6PSerGdnlCm1SNbj9JVwaD6nhzcky3Twtszo
	r5ALmwjAQdyP/3Fm54TpdFEawwbDE4o=
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com
 [209.85.221.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-2NQTExDqP3C7GFQAeTmnKA-1; Fri, 10 May 2024 00:25:31 -0400
X-MC-Unique: 2NQTExDqP3C7GFQAeTmnKA-1
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-4df2c1a95easo802679e0c.0
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 21:25:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715315131; x=1715919931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XWUM+pYSFDwfKuG/KsJLm2Dw80p4Z8ax4UNSs8o+H6Q=;
        b=bs8jNUkh6tCORtPlvUrRzAeUzcygsIyMzJf2Y25eBHGRiEXe2HwzknEnWg/wPfO8E6
         TT9Ty2Hng+SsbFo0/SmMTTWPToqLPmbsUVZpCO3FXGUzJiYhJovdxVWWUK87qvF/5TtB
         z3K1RTG7tUa86b6/NnjpjA7OfG8gpCg7wEQCYmVQHl3hLU+oo+vC6B9qu5nY1P3NJIpK
         IAfdBNoYKzqa9rTC6DLqPsHtEarcHcKjPYrWqMOzB8YXScmg/RB3+NTu/e0T3uQjmh/a
         lur30SgOlUJQrxnoHzuTtNSClCBHeke5B5JPG7PXCQxT4ht/b6v84OpVnym9BJCNaFss
         Qplw==
X-Gm-Message-State: AOJu0YyMT3/HklXE3Pm/HW+toVhXKcCi87giry/WaFEFczobTeVrqdMh
	j/2lGngcXpk5So+7xeZXUdeKZA1TGDYjcsBQuParesfmcTLc+bLG4wFm1KeBEZhEcQs9dRklC/j
	lSh0KxwnD2oaPPNh+RnJciDFFFu5AF8grsnKeI0Z8w3UkgsXmYeur6zRyGG05jYgG9fy9SlXPnP
	yROhc1H1y837z7L/D9S/exXosRgnYL
X-Received: by 2002:a05:6102:a4c:b0:47b:dc5d:6364 with SMTP id ada2fe7eead31-48077de5a9bmr1809885137.8.1715315131147;
        Thu, 09 May 2024 21:25:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJumCQ/csNtva7IMpE3rHI4bc8sr1ELddIbXcKw1oYHC2tohwrZs0y/draKO24Zn7Gtug1SyHs9mfVpO6vIzs=
X-Received: by 2002:a05:6102:a4c:b0:47b:dc5d:6364 with SMTP id
 ada2fe7eead31-48077de5a9bmr1809861137.8.1715315130787; Thu, 09 May 2024
 21:25:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509114615.317450-1-jiri@resnulli.us>
In-Reply-To: <20240509114615.317450-1-jiri@resnulli.us>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 10 May 2024 12:25:17 +0800
Message-ID: <CACGkMEuak3=DobCgK=069sogJxqU2yFgrtNmAQCKQg1FLONqmg@mail.gmail.com>
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, mst@redhat.com, 
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 7:46=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wrote:
>
> From: Jiri Pirko <jiri@nvidia.com>
>
> Add support for Byte Queue Limits (BQL).
>
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> ---

Does this work for non tx NAPI mode (it seems not obvious to me)?

Thanks


