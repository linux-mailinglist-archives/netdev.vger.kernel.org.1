Return-Path: <netdev+bounces-141803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58FCF9BC48A
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 06:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5894CB21BC9
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 05:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632BC1B3951;
	Tue,  5 Nov 2024 05:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QvUo0dvV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564D63D9E
	for <netdev@vger.kernel.org>; Tue,  5 Nov 2024 05:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730783268; cv=none; b=QMMayyCHnw4JJCQ1UsYTNtWAHQTzuiKfV69alXsxIt3imt4j73Pqefc/dt5acSylGG4PWR89tgRaFqGqMATjCz3Cl9zeVPHO0O1frwPlUSDr6gmaLGVwHhVzYEhT6N6qXYOEyl0s4HnPPNcFri2TtRbAi4EYyzJT+XMOWtI/19M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730783268; c=relaxed/simple;
	bh=zrl2XYPD2NvxkFXNYylZOdwMoM7HEYcPRbF5dKoLrHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FUTOPuv7Ddnhu3APySlHwh05zf+IOx5sqxXH5tdW7eHeUj0CXPgj0vbSTKdJUXIArmdtSfXWziv9dSvAIzSnC0lKdxkibrm9uiBPAWdCDElvpk0wQU7+0McDytLpi7EsYLxawVsjefv5Vmj/jbV1gmkCAgc0WMbw7xe6QBzCW8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QvUo0dvV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730783265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zrl2XYPD2NvxkFXNYylZOdwMoM7HEYcPRbF5dKoLrHA=;
	b=QvUo0dvVgPGqfPNk5a4h71MdHxXZTyzGkRvMC8BEdkS+eVI/D5oB9hbiDpDulFm3JUbWlN
	kzebijGCg6XmQwpsPaKbBuaNDUh7DIFIMIhTAmV4TpciTnvEqHXkMz87sYTN0qUzyCAhLm
	3jqizSmYpeq/gjyuF9ZaEXH8gWzFsDQ=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-534-AHgoRYFbPlqOU6sgUVNNJg-1; Tue, 05 Nov 2024 00:07:44 -0500
X-MC-Unique: AHgoRYFbPlqOU6sgUVNNJg-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2e3d74e5962so6167335a91.0
        for <netdev@vger.kernel.org>; Mon, 04 Nov 2024 21:07:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730783263; x=1731388063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zrl2XYPD2NvxkFXNYylZOdwMoM7HEYcPRbF5dKoLrHA=;
        b=pqgdj5KOMncN/leIR09ncFLUUqYefsqnMk7saN/dTGgJHAh0X3ueAVZWGoSIo80lwW
         yG4YSzaNp9vWfrLA4eMq+SKHqRSbbLHASnlZ+IEr6iN/REBNBURpObj5hG4jeNg4HoSX
         xUdMNKPPZGiMzmmncilqHOlUG0DXHJ+hu5X0VWJ2fak5UMj0ZPIXMKMa3HPYjLuBZDlJ
         YnG0EKJMDAt2Zx9o1jC4NF/7TZ0efdaxnbVPQuE8FNPdxlBzognLcBs6xceVyoh1tGwk
         BHOr1290qm4OFQFuaA2156Azla6XeX3/eTebVGsDYrKsmb7dbOjbdiqmgaqHZahZ0+2Q
         oEDA==
X-Forwarded-Encrypted: i=1; AJvYcCXV7gTlXnrEfHNigRBvfyq6jxRZrzGb1wuoiK8O2u9XA6gPdIX2Wgfgwr7eB6+LJUWsOvkjPM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyYXAMvzc1LUssX3JyMfb2W2JmCUYaBDXKSGyE/PbPj3yHRqP+
	rIGDcZefLUhh6Y/w3Kl6I/i8TKSs5z9BEdNaNS/lgaMHmuavYoweD97uWu3iVEkZJUkXdj9SDw8
	RlVgkURsY4RwYCVvI9ngx7YITbAEFYRh3POKZUmBVcDl9wF3FM47ZlGMaFEb/G7oxebWHw5+Dkt
	P/FkepRPRIv/2CcGS/wrlPYMyyr9J6
X-Received: by 2002:a17:90b:360a:b0:2e2:cef9:4d98 with SMTP id 98e67ed59e1d1-2e8f10a7281mr36436636a91.25.1730783262995;
        Mon, 04 Nov 2024 21:07:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHO+OdM3vh9eQqrFq+MTzxcKxDTbAL58SjGs9/5RKPSL4uG9Ecquej/Aq3fG++zjn39UQYP1k8aOuXwkCsX4kk=
X-Received: by 2002:a17:90b:360a:b0:2e2:cef9:4d98 with SMTP id
 98e67ed59e1d1-2e8f10a7281mr36436614a91.25.1730783262570; Mon, 04 Nov 2024
 21:07:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241029084615.91049-1-xuanzhuo@linux.alibaba.com> <20241104184641.525f8cdf@kernel.org>
In-Reply-To: <20241104184641.525f8cdf@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 5 Nov 2024 13:07:30 +0800
Message-ID: <CACGkMEtWrKovFgAiskOshGuP81DnAg6JjtRzNneq1tEa8gQe7A@mail.gmail.com>
Subject: Re: [PATCH net-next v1 0/4] virtio_net: enable premapped mode by default
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub:

On Tue, Nov 5, 2024 at 10:46=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 29 Oct 2024 16:46:11 +0800 Xuan Zhuo wrote:
> > In the last linux version, we disabled this feature to fix the
> > regress[1].
> >
> > The patch set is try to fix the problem and re-enable it.
> >
> > More info: http://lore.kernel.org/all/20240820071913.68004-1-xuanzhuo@l=
inux.alibaba.com
>
> Sorry to ping, Michael, Jason we're waiting to hear from you on
> this one.
>

Will review this today.

Thanks


