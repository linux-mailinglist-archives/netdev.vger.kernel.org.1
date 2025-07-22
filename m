Return-Path: <netdev+bounces-208747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED163B0CEF8
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 03:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A0211AA3A53
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 01:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5BF15624B;
	Tue, 22 Jul 2025 01:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QMOjBZ8i"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C1714A60D
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 01:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753146277; cv=none; b=rqsEfv44t5k0U4xKKdoXJvwDlOLmaQOTBDG2OijdYQl4Iq9vBPh/vlhLFvxkZkZJhF7EJE8mIkJhj/ZQYh1POeJMyw+AIgATp3eoKez6cPc/gCl6gpu3iUMvTJPg3FoD89HSd5omQC5VOiHVzxR7nbUvx7JymrTu0Lyef5YD6LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753146277; c=relaxed/simple;
	bh=QSHfY6/I45E7VoqU71vjWN2GGh3FR7Hqm6Zx+uwE1oU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SPB42KWuMnSOfCYWe9xxaw4h7BJ5FfiCOMtba3blm1R7qTMuyIyG7Y/t8/Yb4dHEH0yAInH1STsGsXORIGx/rnlnT/umsR0XPeYgaRE7qXfqI5SmY4K54Sq1L4zT7jtJI4JYMFspCJUg5MhhpuuCMkSw8dRPLg3ww2wL2OxS2S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QMOjBZ8i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753146275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QSHfY6/I45E7VoqU71vjWN2GGh3FR7Hqm6Zx+uwE1oU=;
	b=QMOjBZ8iP55yzOKdWdq460M7cocSn05CTBUIIKF1ZaMFaztzH3wX8bGMcWH9C82TDRKB0H
	/BWsKACpwRP7zdXAYuRnxD9zzqE1BCVyHEPKXE82pwEzoLvgsJlZyh38guSWKXKydrzoCy
	8d/w1qeU8FQhPXn3hxTzyiWUbeIboVo=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-SHwYhWbqNJie-FcOckzJCg-1; Mon, 21 Jul 2025 21:04:33 -0400
X-MC-Unique: SHwYhWbqNJie-FcOckzJCg-1
X-Mimecast-MFC-AGG-ID: SHwYhWbqNJie-FcOckzJCg_1753146272
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-311d670ad35so4533997a91.3
        for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 18:04:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753146272; x=1753751072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QSHfY6/I45E7VoqU71vjWN2GGh3FR7Hqm6Zx+uwE1oU=;
        b=jcCo9o42TBGLYNhCec2hyqTlMNPop0TE1aHfgxNcLQY5LhpHEop5p5DUL+2aELh9Fi
         Cae041hVhi7EQV7JsmIamZSGz3afnYn7ZtK0prg+a/RkXhWEVuw3us7T8pORiFIz13Do
         AiO5P496C5gxJ0CD0ZdNSF8xvO1ZIrttkHvLI5kUhLsY799FNV4cTGGXJgf4RJPHyw47
         Tj+k3kbmRgiXhW7rbH8FGEGDDZXftFlv6ovgfj7sRgKIfYXBs6n5ZUOgcC9Mn0aGevfW
         qIN5bZAyM06vBS7iN6CKFa8YGXhs27Dtni51NlCGYCasbW1O4h6RdkZqDmGSyCJWiFtF
         Jm7Q==
X-Forwarded-Encrypted: i=1; AJvYcCU3mI9u8V4OiByX1LdvDRTZagj8+QbM3aHvOg4WUmi+sz4YPbwNT6QKbEXMjMkK/r565E4L36o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFosdLnUXNp7F8PiVNrofjpe+NctWcFZE8mWhJvtw8QkKtkPpl
	5cuKat0nDJtyuoR9UNx6w0h2b0pqyrYPYJPbgUy2kuPb8CZIBF7a/8nWQZbSkzMbKSAnBExDy8s
	c5JJS63hSNsKB/vZwcohVQ5uhwv/rdJ+qq/JLs2F6reWaBBUoqFgKk8WemeGNs13hhthAMfbbyE
	rwlset0tyRt0+qgr41zPb5iLB/cTyubaua
X-Gm-Gg: ASbGncsIr92eFEr+I+rwVQg40huxCYfPtx5P73etwbb9lL2Z+SFXCwja1tWkn8NAqtS
	L/xQHBXxIyl/wDRqlX4PctJeXiB6NapckOMTUQJatLCq64H5Ubuoy3wH3DphzfyaN6Kc32/SmVI
	2QpzTtX5EJSz5FQ4M6888o
X-Received: by 2002:a17:90b:3fc4:b0:311:c1ec:7cfb with SMTP id 98e67ed59e1d1-31c9f4c33d3mr30854057a91.21.1753146272145;
        Mon, 21 Jul 2025 18:04:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFHbGV5ZoUz9R/WO/NmCH4wsvyzuXu8KWNfORxHSTj8M2vI5FKY2tXFlD0N7kPl5yOe5oFtODb2u9iLGbeS7Yc=
X-Received: by 2002:a17:90b:3fc4:b0:311:c1ec:7cfb with SMTP id
 98e67ed59e1d1-31c9f4c33d3mr30854021a91.21.1753146271717; Mon, 21 Jul 2025
 18:04:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250718061812.238412-1-lulu@redhat.com> <20250721162834.484d352a@kernel.org>
In-Reply-To: <20250721162834.484d352a@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 22 Jul 2025 09:04:20 +0800
X-Gm-Features: Ac12FXz7bcSA4tc5LblLvTxBTyr6TPXP7yPwK31t1GMBpJ5P5WuM1Cl6XkRbI94
Message-ID: <CACGkMEtqhjTjdxPc=eqMxPNKFsKKA+5YP+uqWtonm=onm0gCrg@mail.gmail.com>
Subject: Re: [PATCH RESEND] netvsc: transfer lower device max tso size
To: Jakub Kicinski <kuba@kernel.org>
Cc: Cindy Lu <lulu@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
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

On Tue, Jul 22, 2025 at 7:28=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 18 Jul 2025 14:17:55 +0800 Cindy Lu wrote:
> > Subject: [PATCH RESEND] netvsc: transfer lower device max tso size
>
> You say RESEND but I don't see a link to previous posting anywhere.
>
> I'd rather we didn't extend the magic behavior of hyperv/netvsc any
> further.

Are you referring to the netdev coupling model of the VF acceleration?

> We have enough problems with it.
>

But this fixes a real problem, otherwise nested VM performance will be
broken due to the GSO software segmentation.

Thanks


