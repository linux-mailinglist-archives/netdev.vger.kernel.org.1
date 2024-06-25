Return-Path: <netdev+bounces-106381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CA09160AD
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 10:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D089C281CF8
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 08:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FAE1474A0;
	Tue, 25 Jun 2024 08:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gd3B0gPv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B5C7344F
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 08:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719303082; cv=none; b=csTnJu1Tt6tmAT2DdgqNE3s0aeIcI4TWrVfJOxEoAPwKsECfTSuASSRachk/5HxNKCwM4owY5dHJfNA/ETo44+VrXwKoVOfOnwEPZjizDDO/hLd8/HIH5ceNO6BPkAN2VtJmnX/82PNgpDV4VsudWm08Qk45WYbnunc/S7VbulE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719303082; c=relaxed/simple;
	bh=aiKTsVyZXFeVEbvYSkQtwooDBZYqfXDO1XWCWoqLB6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LW16i22WGbdAa/tLef7pV9jZY1On2PUhOLOdnaY74hwkHama6XKA71zloj4Xr2Ejo1wbUkAw0b9X3nQZfHh8kEVNPkYinckMoKjQHpJEdVRDpcsFG0/COXeQq0/2LmzPP+q+ln4IXhRfeI/5tDo5ExWWXIRuznacc+9A4xFXm7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gd3B0gPv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719303079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aiKTsVyZXFeVEbvYSkQtwooDBZYqfXDO1XWCWoqLB6s=;
	b=Gd3B0gPv0vswlKWAlD6Ny/aPOjFFgwgr3UBY6qaNUYZzrXWNTkYrTvB4dtBCS+aT7Hsr5J
	J4wjeODYl4SfSXj37GjHM7l6HvM5um4rbAK2/Io+stfABrbmDBLMy1a0vNSXW5LLWZmHzW
	sbGSoKwisRrA6LEvmCmdFBka/DjyPU0=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-5eczIZ4IOJ6szz7BwgN6lw-1; Tue, 25 Jun 2024 04:11:18 -0400
X-MC-Unique: 5eczIZ4IOJ6szz7BwgN6lw-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-70ac9630e3aso5914304a12.1
        for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 01:11:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719303077; x=1719907877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aiKTsVyZXFeVEbvYSkQtwooDBZYqfXDO1XWCWoqLB6s=;
        b=O3KRiLad8v2gZ4C2iQ7qsslXOEVAHY1r7pX2aOqlc2LqWsNx1oNDluwTtA2/R1FO4P
         X72WX1xs4Ei4fJEhY9JThp40qdhPPpnkdx0vTSHcA5/kAWLDT+62RVTcOZ+frfepKSOO
         TruYV10Vlqi7jxXUa9U8yIlI99YaClXPh16V+uSW+P2pQUhPZQTkRDe4mCdTUVZKayhk
         C5EbWHkynrVw0SpNxzsAavXg5tz4K+kUqT3QPqQ/YDWDZX5uUvE/LDs2/9I9wvO4MKkd
         kva2m1Ns4mkdeW+Njkacf3F0irL/dTIU2xIxqySxsUAMU/FImAAA4n+Nhkl8aHhJpcus
         dzfA==
X-Forwarded-Encrypted: i=1; AJvYcCWYWXr1iDmkTaxz7FhMmGsDLKMcfyhkLG3vPzZKj8EjwDKVVcPl+mCsJOSveOv7xR1wb4oSqTnJ9RC2FKld2bsiCVJA8tE5
X-Gm-Message-State: AOJu0YzVjsxeC5w8sEPmLGNGpYZCjZ3/QvJryXyUVnqmsyzcWkxztvwO
	YpjgblGDoFQ7mRwKkIu3T/Ue9a9SJCwfT19q+gMHXqKm5PV8iCboTiowjx6vZh4tA4jC0hPNec5
	G4+ebh+oATmQYKzA5hu7Sywe16D2Xz6djl0874+tlsMJm0AYbT6iPjUivFjQ0opMqiXcHRuak10
	H1RoqlgaTmbwauGk8X9cSFbf1X/8Dc
X-Received: by 2002:a05:6a20:841c:b0:1bc:f9ca:6153 with SMTP id adf61e73a8af0-1bcf9ca6221mr6768785637.14.1719303077075;
        Tue, 25 Jun 2024 01:11:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTxP7NUZILtOLpE7RPvLE5M6VrDgjulN2KCLl6SrNH4G4epy0uBszytXEo+lWjLhrJAgoEer6T7AKyi5WlAwI=
X-Received: by 2002:a05:6a20:841c:b0:1bc:f9ca:6153 with SMTP id
 adf61e73a8af0-1bcf9ca6221mr6768765637.14.1719303076509; Tue, 25 Jun 2024
 01:11:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624024523.34272-1-jasowang@redhat.com> <20240624024523.34272-4-jasowang@redhat.com>
 <20240624060057-mutt-send-email-mst@kernel.org> <CACGkMEsysbded3xvU=qq6L_SmR0jmfvXdbthpZ0ERJoQhveZ3w@mail.gmail.com>
 <20240625031455-mutt-send-email-mst@kernel.org> <CACGkMEt4qnbiotLgBx+jHBSsd-k0UAVSxjHovfXk6iGd6uSCPg@mail.gmail.com>
 <20240625035638-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240625035638-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 25 Jun 2024 16:11:05 +0800
Message-ID: <CACGkMEtY1waRRWOKvmq36Wxio3tUGbTooTe-QqCMBFVDjOW-8w@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] virtio-net: synchronize operstate with admin state
 on up/down
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, venkat.x.venkatsubra@oracle.com, 
	gia-khanh.nguyen@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 3:57=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Tue, Jun 25, 2024 at 03:46:44PM +0800, Jason Wang wrote:
> > Workqueue is used to serialize those so we won't lose any change.
>
> So we don't need to re-read then?
>

We might have to re-read but I don't get why it is a problem for us.

Thanks


