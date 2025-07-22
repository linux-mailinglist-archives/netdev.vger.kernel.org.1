Return-Path: <netdev+bounces-208759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AD4B0CF84
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 04:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD0083A685E
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 02:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B5F1DB377;
	Tue, 22 Jul 2025 02:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DE2Xj4zX"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFA919AD8C
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 02:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753149898; cv=none; b=geKM/OBcWSZ7IoBUstHxaOQrGgAobkIQl7AneaxrX6bLkzeif4keOsg/Kdl3RN7PUjqZw1hM/fB4Zd7Ck/gVO3JY/somPpVB3Ff9L8ReRTz1VKtIGPPW3URGMxiK74xtUSez2jTU9lC5QkzbBbtWFWRT03eKy6kJ9uOMvVo9KjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753149898; c=relaxed/simple;
	bh=bIjUT1U7Vz8QnmyjIn9UODVHrfNoZzjGGz0TU5LVdwI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lagg/JyxC2dO4Hvpikot1V5245DOKhdGh7K7KxbBRNg1GJbicGIWaXO9nr/FGefsF/hE8OGmMPTzv05ssRGDs4ZMyesMIHQc7JanUMROCvlvD5T4n4a5Lk7icg6Ew9ngNoOfvNA7Ep8dYNjWzG/jSB2FawcMak3iAiQIyZaqu2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DE2Xj4zX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753149892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bIjUT1U7Vz8QnmyjIn9UODVHrfNoZzjGGz0TU5LVdwI=;
	b=DE2Xj4zXcB91WkWZT5HCDpd2rlu2XxR9bghiEQTv3r6+dBEl4xFCahu6gJmI+rjLu2XIth
	toAJRujfMwHdEQbI98opcCaE5NymkqnMvgF6KKU8BvshqCBmBjuOSSebfxmQJWDl2yL89A
	g8hqI+SzkwhjxrzdBzTlqasKnaefw9o=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-602-X3rqEkW6MZOpsC2VrvJNCA-1; Mon, 21 Jul 2025 22:04:51 -0400
X-MC-Unique: X3rqEkW6MZOpsC2VrvJNCA-1
X-Mimecast-MFC-AGG-ID: X3rqEkW6MZOpsC2VrvJNCA_1753149890
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-4e8161d0400so220446137.2
        for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 19:04:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753149890; x=1753754690;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bIjUT1U7Vz8QnmyjIn9UODVHrfNoZzjGGz0TU5LVdwI=;
        b=RorV9158SfQVu14w2ODwtS6aA86BZC8yikprEcLfyTQxQoESDL3zaJDd31aIRcLobb
         ta1MzW7AJ6LjmQYB1EYJBkiPZ81ysBcp0tVkc+nmItEeiuzmnB46o7jGBKOu+yOryH2i
         SjSRV0oAH5B7YHCIqhzh8Wu6h/l7mt+f2c5InLTIxtYBjhu4RqlRbUFeSbZnw/PbeirA
         JgGuHenT7l+seSuyheLJglQbNUkCUIYeCaJi/Y9/fPzmc13VEKubHdoJxRuVtcTWR6+b
         EKt+Izyr8YgMgQlbFVgoWgEVU6vD0VoRweManxWgBW+uRqN0B2iwJ+QNOC3/xQHJnnhC
         WKHg==
X-Forwarded-Encrypted: i=1; AJvYcCXZ2kddeedrXcv8jZTIMMWCy9OJdonFAbFLUpLkt9hG3ZI+20zPaH9RaVcNVH5CSgM22JIWTeA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGDwYKZnpbse7c4DqGChAl9GzxGa7RNc+Knlqaogy6e/tbP0wf
	p8QVbxwHHIYOt6zdb0+KlA7hKDkVkfDastaa9qX/6DXUD0RTG0A3SRm8f85GvD6VjyW5EkqFVHs
	/65jx7GaOBCS1e9JTdCGmeUkAFddJvKmmNhrA9XCaB68SfjQxkuVmSuVBGKU6LQPth3E1OjFHm7
	JwpijsLN59pSSWEQE34y+rbWNABHgOo9XR
X-Gm-Gg: ASbGnctjBzofmi+4bDVduCvoHIkD1GqXO/JyvXOZGLU8xWwT28zVUQjvhHFeujUvFXB
	hXqGxcFGIEuObTRB9/VeIdks5PRVCdAcPUeVJu5nfZMcwd3CFZKL2m7p4F4NoWWiLIKgc42D+lX
	eIvwPRl4PW8mgzXTukClGQbw==
X-Received: by 2002:a05:6102:ccb:b0:4dd:b82d:e0de with SMTP id ada2fe7eead31-4f9ab36d3d8mr6612154137.17.1753149890418;
        Mon, 21 Jul 2025 19:04:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzkyjLEZd6sf+Ej+AUlulyAL0R4JIzoMwrGqi8s+KIvdvWhpHy011avGsCSL6qTpWhViHyY43qbrYraDMw+QU=
X-Received: by 2002:a05:6102:ccb:b0:4dd:b82d:e0de with SMTP id
 ada2fe7eead31-4f9ab36d3d8mr6612124137.17.1753149889948; Mon, 21 Jul 2025
 19:04:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718061812.238412-1-lulu@redhat.com> <20250721162834.484d352a@kernel.org>
 <CACGkMEtqhjTjdxPc=eqMxPNKFsKKA+5YP+uqWtonm=onm0gCrg@mail.gmail.com> <20250721181807.752af6a4@kernel.org>
In-Reply-To: <20250721181807.752af6a4@kernel.org>
From: Cindy Lu <lulu@redhat.com>
Date: Tue, 22 Jul 2025 10:04:10 +0800
X-Gm-Features: Ac12FXwbctLUtOGy2Wpgo513rvoL7lTRBVB3h49HlisYxpbYr28YuZNNY6OZJsc
Message-ID: <CACLfguXG7Mpsp=z4zCE7H4CMA_s9qV86SkeL7Q=WxChXcFpNfA@mail.gmail.com>
Subject: Re: [PATCH RESEND] netvsc: transfer lower device max tso size
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jason Wang <jasowang@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Michael Kelley <mhklinux@outlook.com>, Shradha Gupta <shradhagupta@linux.microsoft.com>, 
	Kees Cook <kees@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Guillaume Nault <gnault@redhat.com>, 
	Joe Damato <jdamato@fastly.com>, Ahmed Zaki <ahmed.zaki@intel.com>, 
	"open list:Hyper-V/Azure CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>, 
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2025 at 9:18=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 22 Jul 2025 09:04:20 +0800 Jason Wang wrote:
> > On Tue, Jul 22, 2025 at 7:28=E2=80=AFAM Jakub Kicinski <kuba@kernel.org=
> wrote:
> > > On Fri, 18 Jul 2025 14:17:55 +0800 Cindy Lu wrote:
> > > > Subject: [PATCH RESEND] netvsc: transfer lower device max tso size
> > >
> > > You say RESEND but I don't see a link to previous posting anywhere.
>
> Someone should respond to this part, please.
>
Hi Jakub,
sorry for the confusion. I previously sent this mail
(https://lore.kernel.org/all/20250718060615.237986-1-lulu@redhat.com/)
to the wrong mailing list, so I'm resended it here.
I've also submitted a v2 of this patch:
https://lore.kernel.org/all/20250718082909.243488-1-lulu@redhat.com/
Sorry again for the mix-up.
thanks

cindy

> > > I'd rather we didn't extend the magic behavior of hyperv/netvsc any
> > > further.
> >
> > Are you referring to the netdev coupling model of the VF acceleration?
>
> Yes, it tries to apply whole bunch of policy automatically in
> the kernel.
>
> > > We have enough problems with it.
> >
> > But this fixes a real problem, otherwise nested VM performance will be
> > broken due to the GSO software segmentation.
>
> Perhaps, possibly, a migration plan can be devised, away from the
> netvsc model, so we don't have to deal with nuggets of joy like:
> https://lore.kernel.org/all/1752870014-28909-1-git-send-email-haiyangz@li=
nux.microsoft.com/
>


