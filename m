Return-Path: <netdev+bounces-227194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA6FBA9EB0
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 18:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C64361921EB5
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 16:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E0830C34D;
	Mon, 29 Sep 2025 16:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LNaRV2DX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E74B1F5847
	for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 16:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759161663; cv=none; b=e6IK+ulsS6/KuHxN96Gp46aCw3uap0euda7CG4q7R7KMOrkJOpGd5PAuBkE5JmrU7IvALEXYAFst+SzUgc13pdqfOzU263yCvA0UYhj1Fo//wRnh+x7jU6V95wo3q08yVyaH4h3ti+fZM8sXPb8SE5/lECxb7AJMFWj4n2/FyLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759161663; c=relaxed/simple;
	bh=rvJzaJvHn4ysl0SarKojQPWkHG0cHul95/d7suros2Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bHxaYlXmPXi94Kafh5GeXA2u7L8jWEJostILx6bHsfTr2qq1/m34vnxkIdD/ThKO8m9NN8v/ssbwLNRTTLchbaFRnShdv1RXj7U/HDq0Pj16mRGEdhjUonplwl+L/b0HQHxc8rZXLbo5NmAeYT/Vgi2wZP/1T9fHlmxS4i4Wt+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LNaRV2DX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759161660;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rvJzaJvHn4ysl0SarKojQPWkHG0cHul95/d7suros2Y=;
	b=LNaRV2DXAy3qAqa7MrJNS5Jbzyj/+EdIz+zilGrOcP0+zjaeIqs7os96RRspzyWBo12erE
	HStGwFZzEhu30pQ5X2+qqut/vmE+/DZa5v1wcTX8WdHFFJVrLJuR/KMIGNcpBLBu84cAT5
	z0UnVGIvo6FbyWQDY8ZScZ/0rmWOcnA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-9E-7Pp4cPxOd4v_A1aaxBw-1; Mon, 29 Sep 2025 12:00:57 -0400
X-MC-Unique: 9E-7Pp4cPxOd4v_A1aaxBw-1
X-Mimecast-MFC-AGG-ID: 9E-7Pp4cPxOd4v_A1aaxBw_1759161656
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b07d13a7752so566173966b.3
        for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 09:00:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759161656; x=1759766456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rvJzaJvHn4ysl0SarKojQPWkHG0cHul95/d7suros2Y=;
        b=X+S63QFrbC/o300hslTx6FGgAURF+cGNH4PiWqs/8ElTCJPAdLDi97+iFvI9L0jbYB
         HfZQ3aOvZH31kr0r30vTiK4ZGiWdZJ+1T0luSHEoN5C3qwcXy+d8hEE265FCKkFwvBIM
         JGs2W90PIsqW+vgLrDP0nBj923sN/V3/m1/XKHFU6oeOhk6aAgske0U0AIBX5B3vLAbb
         s9ygkK8NfJjHEFChqsJzQsm86T2xBjm2kd3LaVskvKO96XPA7ZCWV+jsRmcvF3I/LVRg
         fZdYhhYtfZm8QbmvsU1+6G5Amtmalec9K03r9Yn1cMO37sYoNsFiQa9pRYfHQ+Q68GhP
         zmiw==
X-Forwarded-Encrypted: i=1; AJvYcCWFBJBnCLcIqpUbHyAiN57+gaaWHBvfQVixAQTXOKztJZb0J520JvRaz64dBrNN93v4IjtHjTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiecF/2xn+qWLTl2AfFGZr8yuhGYjxBQtM75evJFVXulXzJ9VO
	0Y/G4ZiEvinViAAW8dkUwq5Kgun0tSwAn7kt9fkBK5UDjTuZ3LwuYERPfteIDkFL+jjh5Aq2SNd
	Sq3Z/yGZbbtlbBZBwPlWT6vMlc4qN20APRQm9InYvpkl4Y/JNoDT9RVMfBlD/D4nUBLss9BWAxW
	iEWyYrpfb8lgTRUDrbyOrqMSJKMGFJ+gh/
X-Gm-Gg: ASbGnctM77/RoRrLBYjN/uxjhoJ81WLnyNzTBIFF7UKZg3XgxK8UwjZuNYCcpKuqvfi
	xM1vCrYDEnxmDrZlTfTIC7vkxw+hky9J78b7Dor/McFyc0qgDo/fGIY6lWVy5iwgK3HofBKzgFF
	pWE6VYwR1fYM9+HAuDf4E8Ng==
X-Received: by 2002:a17:907:3e9f:b0:b3b:d772:719b with SMTP id a640c23a62f3a-b3bd781ba71mr843425566b.41.1759161655729;
        Mon, 29 Sep 2025 09:00:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6hzu6lwEjjnhGnHFD8M9ofM8ojrlvCKKGBmnqXaS/KCPAQ0khSQKd+hnPIMyAHKH3zg+/WlTMjm+XtQu+5y0=
X-Received: by 2002:a17:907:3e9f:b0:b3b:d772:719b with SMTP id
 a640c23a62f3a-b3bd781ba71mr843420566b.41.1759161655326; Mon, 29 Sep 2025
 09:00:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cd637504a6e3967954a9e80fc1b75e8c0978087b.1758664002.git.mst@redhat.com>
 <CACGkMEtU9YSuJhuHCk=RZ2wyPbb+zYp05jdGp1rtpJx8iRDpXg@mail.gmail.com>
In-Reply-To: <CACGkMEtU9YSuJhuHCk=RZ2wyPbb+zYp05jdGp1rtpJx8iRDpXg@mail.gmail.com>
From: Lei Yang <leiyang@redhat.com>
Date: Tue, 30 Sep 2025 00:00:18 +0800
X-Gm-Features: AS18NWC2orrPAiafpnWLj0PiUo6H6ktFe9pH1En2rWhE1VkgRlQKrFKPhSd3Jgc
Message-ID: <CAPpAL=z9GZKTDETJVEpq1aop8q1Rgn7VaXbV_S4_y-nsVfzpxQ@mail.gmail.com>
Subject: Re: [PATCH] vhost: vringh: Fix copy_to_iter return value check
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, 
	zhang jiao <zhangjiao2@cmss.chinamobile.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested this patch with virtio-net regression tests, everything works fine.

Tested-by: Lei Yang <leiyang@redhat.com>

On Wed, Sep 24, 2025 at 8:54=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Wed, Sep 24, 2025 at 5:48=E2=80=AFAM Michael S. Tsirkin <mst@redhat.co=
m> wrote:
> >
> > The return value of copy_to_iter can't be negative, check whether the
> > copied length is equal to the requested length instead of checking for
> > negative values.
> >
> > Cc: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> > Link: https://lore.kernel.org/all/20250910091739.2999-1-zhangjiao2@cmss=
.chinamobile.com
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >
> >
>
> Acked-by: Jason Wang <jasowang@redhat.com>
>
> Thanks
>
>


