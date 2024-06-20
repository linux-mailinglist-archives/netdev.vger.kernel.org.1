Return-Path: <netdev+bounces-105162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8AD90FED3
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 10:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12FFF2833BF
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 08:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C470B198836;
	Thu, 20 Jun 2024 08:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CahcQ1Yl"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49165482C8
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 08:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718872200; cv=none; b=Zxq/iO0R8dcTD0bCyvVuUGY7Hpv6INawGjNZv2xdu2B8fa5dT70ZpDYSbItjttzEBvk0vCiCxCEUyPWLByMFbwe+qtn9eenhfjPozGOkBdPIcwd8h+Rw828J4UNOUIVV3dfuW/QJxb+kGQRAO7RlcEM6YE1/BpwGog0tam+5S9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718872200; c=relaxed/simple;
	bh=JGZFuJ1BGCs5lhhVARlia/ZbTK9I2R+6a7gVuPvH+es=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QQPQVw4sXmrO0F1SHR4pRJSwSjhqilsuQ3diA20OFZN8JTlyptzv8DoQcKsxw7MxMSRDjmKlIH6gR6r+mXx+K8w9qtCX3bcfAlPxrT0kHzkwKhdA+xXK7+eVDABVsQRnaRujfZ9STwPJDvJVKtDC/cMHKTBRumfgXfit8fzvEUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CahcQ1Yl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718872198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JGZFuJ1BGCs5lhhVARlia/ZbTK9I2R+6a7gVuPvH+es=;
	b=CahcQ1YlaAWGH4Bo3G8TmPgkRpZWl45gcDsYdD5CDduo1/4EHAxZGiaC5oUGl42ZpCJHpr
	Nu1tttMhCaF6+hbiiEsPzQVLqzyxu9eIYhoKMoztdPocF/BkdpSGUG/ceppHSjVLgcDuSX
	wJ1FA/FaSnqKqnqu8yoQ1Cawgdl+TL8=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-c2TZhX6CMH2Dac0kE_z4dg-1; Thu, 20 Jun 2024 04:29:56 -0400
X-MC-Unique: c2TZhX6CMH2Dac0kE_z4dg-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-70ab3bc4a69so667185a12.3
        for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 01:29:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718872196; x=1719476996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JGZFuJ1BGCs5lhhVARlia/ZbTK9I2R+6a7gVuPvH+es=;
        b=eCqqlwp9vJaMOL5M1r7if09lEOsV58RAe/am2s3w9PeVcMMnA0ffkoYuHk2n2a4MPa
         eL4peiBO/dVdM9/fLzMUni8Vy0ZNphOAvqV7Ufz994Q+GU3+zLCzaIegAhlZLtEk2oy9
         1126uo18cdHAIZkUO+KfZ/U8hNVb+Ix22SdeH8cR8wFFkiMCPcrsoeRHxfXlpJQtTXl9
         XlCQQIbvFQDIScuvlIyJ7wiEqy276w5JV2+n9Z2ejshmuvEATuJsmie7dkgxlBcr+Jcx
         Qxw6TGXae4b3WLt0lCpdpjrjT7n0MLnPrJqWcwoF+Hffi2uvK55BtqS7CuIYd7Tfg0PI
         qu8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUFF+f/XhNnThCEh5nEWdal4mF6b3JTsf23eEG1htyw0i8mecTChujRPXeTIooaDRB3qoE80GZyz/rIbVE9sqi5t+s9Mrvk
X-Gm-Message-State: AOJu0Yy539FUzrnH9LyPE1cI3V9oE1RMOxg9RUajVj0cVg0TBwtJ2Ty0
	1Ha+wVnFEnIKS9PBeOBJOTo1hpOsW1Cd4lsRVLzfoaLS7/PTM3Hhyx8+n6w6RiAR7rYWMNH6jrU
	QNT8a6C0OCvHxYNL9ObydBzVacXmsF4m7I+uCzTXixcWhkVX2p2fPlV0IrjFyrsYxdzSkAa1iAV
	D78+mVLNQve2kEZOhLXdeZcfkM6GA1
X-Received: by 2002:a05:6a20:ba08:b0:1b4:f581:23e1 with SMTP id adf61e73a8af0-1bcbb14da2dmr4345350637.0.1718872195905;
        Thu, 20 Jun 2024 01:29:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF85/UJY37FatqbRbzaKijLCbd6FNTx+yAG3Qno4IThT0VNKeJXp8HH5a+WWVuJ6oGKz1acfzDBjAi/BBBmMvU=
X-Received: by 2002:a05:6a20:ba08:b0:1b4:f581:23e1 with SMTP id
 adf61e73a8af0-1bcbb14da2dmr4345341637.0.1718872195524; Thu, 20 Jun 2024
 01:29:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617131524.63662-1-hengqi@linux.alibaba.com>
 <20240617131524.63662-2-hengqi@linux.alibaba.com> <CACGkMEvDUcVmaT1dBoWnFx0CO5kH+HYp9je5bJ1dFR1+EEdyWA@mail.gmail.com>
 <1718680142.7236671-11-hengqi@linux.alibaba.com> <20240618181516.7d22421e@kernel.org>
 <1718762578.3916998-2-hengqi@linux.alibaba.com> <20240619080802.07acb5ac@kernel.org>
 <c4b2d4a9-2fe4-4822-a5ab-57d1bb98f0b8@linux.alibaba.com>
In-Reply-To: <c4b2d4a9-2fe4-4822-a5ab-57d1bb98f0b8@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 20 Jun 2024 16:29:44 +0800
Message-ID: <CACGkMEsf-5mA-C+2=Qjm6C=QpBrWOooxOMGHgE=rowYZKB=4SQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] virtio_net: checksum offloading handling fix
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	Thomas Huth <thuth@linux.vnet.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 11:44=E2=80=AFPM Heng Qi <hengqi@linux.alibaba.com>=
 wrote:
>
>
> =E5=9C=A8 2024/6/19 =E4=B8=8B=E5=8D=8811:08, Jakub Kicinski =E5=86=99=E9=
=81=93:
> > On Wed, 19 Jun 2024 10:02:58 +0800 Heng Qi wrote:
> >>>> Currently we do not allow RXCUSM to be disabled.
> >>> You don't have to disable checksuming in the device.
> >> Yes, it is up to the device itself to decide whether to validate check=
sum.
> >> What I mean is that we don't allow users to disable the driver's
> >> NETIF_F_RXCSUM flag.
> > I understand. What I'm suggesting is that you send a follow up patch
> > that allows it.

Exactly my point as well.

>
> OK, will do it.
>
> Thanks.

Thanks

>
>


