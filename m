Return-Path: <netdev+bounces-184116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97644A93624
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 12:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D431F3B20A8
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 10:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C57B253F00;
	Fri, 18 Apr 2025 10:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YxAlanCK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563A320B1FC
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 10:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744973197; cv=none; b=V5wzPYzmda9FkppjCSWoewL+Qwm/Nz502n4qRr6mhN++7xxSmHgjWhMeBKVPK1hedVu9Z3gfUnJ9zddEaC/QDPVyZ1bS2NdNb87ZgmSDd7Oyd+Nyyg6Y3AXoX+h8mE/ZFr305n6WDGfw/ztsPTG8np2kirejrjRM5/yrKfIVErY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744973197; c=relaxed/simple;
	bh=SerV+gGT2ewDc74X2CLDt4bTNrOEtDnv3KfMaSoUqg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qt62jJqj5F6WS6LizaDJQ8bLTrGsGQHOE8ddlcVLQeAzPYt5koDt7VU0HuXdTOE3w7/3ARF5IeNQs+8QNl1KW6XrlGuEDvhQmOD+G1k7nUxuajJphUZZ13qKi4+Z6kAisLUvMUZPIwphIU11GD/Aht3Ig/X5DM0OP0L0tTbTTa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YxAlanCK; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5f6222c6c4cso1761051a12.1
        for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 03:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744973194; x=1745577994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SerV+gGT2ewDc74X2CLDt4bTNrOEtDnv3KfMaSoUqg4=;
        b=YxAlanCKvyBXFJbdWajkpjB8WxSpcJs1UfytaGsZuNUTWO9aNGM7DZaP5V42o3KMfb
         CfgraB3CsEHHS27T0qo3N8jpF/XwCuVq91ZWfqxcrIp8A6omXvgT9HxKEV5TszESffDA
         j77RI752OmJkTnJAVvOdQEXE0eeUSRFrYm70iisMMAJhoyNFDsdfSf8JIqxNCdh58l/D
         fRnWaYJ6xIppQCllv2+Fj1f/gfU/WVX4kqlHJm41Jpwg77vAYsbKEORBZydX0q2zvTjF
         QsjVmsyj5vt4YLiqgNTRL5Cmbd2wVedfgJpKHEYkz/aO8RYn7f/RHEgLVo3y05j467RJ
         /nUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744973194; x=1745577994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SerV+gGT2ewDc74X2CLDt4bTNrOEtDnv3KfMaSoUqg4=;
        b=nD3AVKDogl7gmX8TKGNYA4/630oRCsvJov+I64D2EP1tWUj8qNFgtodX5F5vqn0U+a
         iHU+b0rh+gU4sP2E7Cg3jIqAWLzdnVYo0H8NXrdtDvPgXwCstwAnvJxVFOIWy1f9YDqP
         h4BvMDgPGTyVyYspoTxA7+kdhis3kaUok4q9On9iZFx2DkcTV/q1THdj/cLSPxGKE59b
         TqjfKmJzcNQv3nemp0StUhRzS6JaEfG+Lqhsr3RTf5i4eTE15iMZ9y7Cwsnnl0KOiR3V
         qtC12p+o3nIPhahdtLRueIASDcmJymFPoPKvJ6tT0nZ/i9J6BkCjUgtgUzvlk7Dj/mIA
         JpOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWoMwcjpXvFrc8g9IyEkLPUtxt5q+qqUnrMtgnNlXjVDOJ0Kqj6FihZPLV+TSIWLEbVP4tgNYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsTCozP33AFKuoGckVHrkOfZK9yBpKGL1PpnIcghR+eUj9pdK7
	GDJ7tKp7NDue3uN+nA6OhwXy17N4Cx10ZIipZw2NsgsWYi/d75R+lBG9PmrbYtpmxqy7jZjTQYg
	6DolQ9nQeyymkpNssrrKT1wMwfz40IYgM
X-Gm-Gg: ASbGncscFvSm2KCxrZb+l65IF3jQ1aBYW862BmnSS/dd1tYCM5pSE8l/v2WqQAkRH8l
	wK7x6MVZyq5rcZVmMBywPwpkmGszDP8g+8kUffDHT9EnNUFO/wWC6fadYYZTPmJItNI082MIcoR
	CGOssz01WSEmTuH+ieeSmPwco=
X-Google-Smtp-Source: AGHT+IHexy7lqV4r+LIDOpD0Jks6u34PoWQUqxuwSNjZjhA3wq8x3mt/RTqSSzrPDR4zBn0Vq9mQi3Q/aHrUZZFS6sM=
X-Received: by 2002:a05:6402:3586:b0:5ed:44e7:dcf with SMTP id
 4fb4d7f45d1cf-5f6285ed202mr1760595a12.24.1744973194347; Fri, 18 Apr 2025
 03:46:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250415092417.1437488-1-ap420073@gmail.com> <CAHS8izMrN4+UuoRy3zUS0-2KJGfUhRVxyeJHEn81VX=9TdjKcg@mail.gmail.com>
 <Z_6snPXxWLmsNHL5@mini-arch> <20250415195926.1c3f8aff@kernel.org>
 <CAMArcTWFbDa5MAZ_iPHOr_jUh0=CurYod74x_2FxF=EAv28WiA@mail.gmail.com>
 <20250416173525.347f0c90@kernel.org> <CAMArcTXCKA6uBMwah223Y7V152FyWs7R_nJ483j8pehJ1hF4QA@mail.gmail.com>
 <20250417070937.332dc7d4@kernel.org>
In-Reply-To: <20250417070937.332dc7d4@kernel.org>
From: Taehee Yoo <ap420073@gmail.com>
Date: Fri, 18 Apr 2025 19:46:22 +0900
X-Gm-Features: ATxdqUGGxqOIiVVrNEExV6k83olwf20irmKkmAkeehz-14KP71S_UfAdDrC5qcc
Message-ID: <CAMArcTV4Go2axa9EiKARcnEatoJ_RfM2-_CN=R3rKoUTEfjJ2A@mail.gmail.com>
Subject: Re: [PATCH net] net: devmem: fix kernel panic when socket close after
 module unload
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, Mina Almasry <almasrymina@google.com>, davem@davemloft.net, 
	pabeni@redhat.com, edumazet@google.com, andrew+netdev@lunn.ch, 
	horms@kernel.org, asml.silence@gmail.com, dw@davidwei.uk, sdf@fomichev.me, 
	skhawaja@google.com, simona.vetter@ffwll.ch, kaiyuanz@google.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2025 at 11:09=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Thu, 17 Apr 2025 15:57:47 +0900 Taehee Yoo wrote:
> > Thanks Mina for the suggestion!
> > What I would like to do is like that
> > If binding->dev is NULL, it skips locking, but it still keeps calling
> > net_devmem_unbind_dmabuf().
>
> note that the current code in net_devmem_unbind_dmabuf() is also not
> safe against double removal from the socket list.

Okay, I will look into this too.

>
> > Calling net_devmem_unbind_dmabuf() is safe even if after module unload,
> > because binding->bound_rxq is deleted by the uninstall path.
> > If bound_rxq is empty, binding->dev will not be accessed.
> > The only uninstall side code change is to set binding->dev to NULL and
> > add priv->lock.
> > This approach was already suggested by Stanislav earlier in this thread=
.
>
> > Mina, Stanislav, and Jakub, can you confirm this?
>
> Maybe just send the code, even if it's not perfect. It's a bit hard
> to track all the suggested changes :)

Thanks! I will send a patch soon.

