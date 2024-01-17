Return-Path: <netdev+bounces-64044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 549EC830D2F
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 20:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66BED1C20F4B
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 19:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40F824208;
	Wed, 17 Jan 2024 19:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WlUqDEhB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C7E249E0
	for <netdev@vger.kernel.org>; Wed, 17 Jan 2024 19:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705518952; cv=none; b=BSUOtyHUGdJas4Y3mxNNYNNsTU7Mijn0Bg3RhNlpVwAaRoWhKBv0rlDw9OEW+dRQrQiaZyrW9Eoi8zfHVR36TvRh3o9oxf47BwT60IHyX3XTb+QhbmzC16LhP6Y/+tyqGVoTuEvgBKqNf3FB3ReqlKHyUeWBYU3qVpHw0SZc65Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705518952; c=relaxed/simple;
	bh=ndeVmTSympbvoFP9PtZ3+RePaSKFZ1ZgOfmAi+k5FB8=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=MnBKMWu+vKmuHKsNRjR+V3ThJISYVKe8QCeh8s7GHwT+0A7J4HizcZLpvtTSkQiOt7eLOG1IjV8X3R4hJ6IhPuY5/BjdmxovgDDHZm9LdtxCvKhKo3Vl9ATxPz6IMorIFAETPpfCo9+0qJPlBdp7qJUJB0zipnP5k3m8JmGEtTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WlUqDEhB; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4b7a3189d47so2856424e0c.0
        for <netdev@vger.kernel.org>; Wed, 17 Jan 2024 11:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705518950; x=1706123750; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8u7/YUYi6X+124aNRigORl9P3Y9dhPfI5XUwuqBIIfk=;
        b=WlUqDEhBnliHV/0H+wZwKg5TDpmQCRXqnuD4QXmVXKhOI+MvFjbxS0KpHBJ/wxmTlS
         qmHR5oFSl6Mii+MEccKAAiIEw3hMvvEUS4WRfax+hHcYsv1H60LNpnkJ59Px9Js1w81O
         mA3NZ1C639Q2JMf+LTt6zsGn9Sri7vw7z9mibFr7P3/5CSPH2Rgu7r0ZmNDtNJIojDAX
         Qju39Ed/M4+36ko4qH5dZlyRgCNFYkDwTMA9UoeFEwAvoJIYLXBU9FpSe5b3qhlDHF/Z
         iR0WHvNX9Cvb7Qra/28Yjt6HqndUD8v21FqNOz2OHSwq41Nx+Q//Cz+fCh70yGixL1FV
         BAYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705518950; x=1706123750;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8u7/YUYi6X+124aNRigORl9P3Y9dhPfI5XUwuqBIIfk=;
        b=UkLUX36wqAd0pqYw5r/lpnS71lYL4GQN9+p2ngkcbo4TMek3H37dZzttT27sLxnXQJ
         d3cx1bi6+ECr+mXqXIgzSvZCGrz0IH4g+M+mr2D3p2/7iaK735vC4IAsKL/nkSkb9Ro9
         6pEeCnbVHmSfm7sbMYSY0GAUtVpyrI/Wwsrgv4pZFQs7Qi1NKgCWbt0MS8JE5KJmbEvo
         euBvJXzrdyEht55e5yg0te99g2CPFOJpEjviAziqrCnwE2zSXP3GNAeMZCbzDyioPz5X
         OaCPhMq5eFtg0kjnOwA4sTPpCYxDyJ7Y4x9g1zpW53xFBjfYmYLvLj99sqfmPkHUJBkX
         VOhQ==
X-Gm-Message-State: AOJu0YyRjXxVvhFLiLj/qxmX0hmKjdQYcJy74Mb1gv0NriuHfvtklNSB
	Az/AQ9Ti2OlcuPPnzx8sHQKfYP11fcy1/Okh0uA=
X-Google-Smtp-Source: AGHT+IG+5f0xumCQdR+iMOuk5gHknkxNPe7A/uosT+T189qCthxbfb4XTMwBx6hhfKtBNNaR965c8S+qpprzfHO6wLI=
X-Received: by 2002:a05:6122:45a2:b0:4b7:e07c:57b6 with SMTP id
 de34-20020a05612245a200b004b7e07c57b6mr5464179vkb.7.1705518950189; Wed, 17
 Jan 2024 11:15:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOid5F-mJn+vnC6x885Ykq8_OckMeVkZjqqvFQv4CxAxUT1kxg@mail.gmail.com>
 <SJ0PR18MB5216A0508C53C5D669C07F72DB6B2@SJ0PR18MB5216.namprd18.prod.outlook.com>
 <SJ0PR18MB5216EBC3753D319B00613E79DB6B2@SJ0PR18MB5216.namprd18.prod.outlook.com>
In-Reply-To: <SJ0PR18MB5216EBC3753D319B00613E79DB6B2@SJ0PR18MB5216.namprd18.prod.outlook.com>
From: Vikas Aggarwal <vik.reck@gmail.com>
Date: Thu, 18 Jan 2024 00:45:41 +0530
Message-ID: <CAOid5F8TV=LbN_UZzmGfOrq1kh8hak7jrivHm2U9pQSuioJP6g@mail.gmail.com>
Subject: Re: [EXT] tc-mirred : Redirect Broadcast (like ARP) pkts rcvd on eth1
 towards eth0
To: Suman Ghosh <sumang@marvell.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "jhs@mojatatu.com" <jhs@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Suman that works.
I need similar "redirect rule" on egress side.  Suppose if i do udhcpc
-i eth1  then I want  DHCP to resolve via eth0.
Syntax on egress (root) side is different and more complicated and I
need to learn egress syntax.
I am trying to tc filter + mirror  based on udp and DHCP port 67-68 .
Can you please help with this  egress side DHCP redirect too.
Thanks Again
Vikas

On Mon, Jan 8, 2024 at 12:19=E2=80=AFPM Suman Ghosh <sumang@marvell.com> wr=
ote:
>
> Sorry for the typo on the last netdev interface
>
> tc filter add dev eth1 ingress protocol ip flower dst_mac <DMAC> m <MASK>=
 action mirred ingress mirror dev eth0
>
> Regards,
> Suman
>
> >-----Original Message-----
> >From: Suman Ghosh <sumang@marvell.com>
> >Sent: Monday, January 8, 2024 12:17 PM
> >To: Vikas Aggarwal <vik.reck@gmail.com>; netdev@vger.kernel.org;
> >jhs@mojatatu.com
> >Subject: RE: [EXT] tc-mirred : Redirect Broadcast (like ARP) pkts rcvd o=
n
> >eth1 towards eth0
> >
> >Hi Vikas,
> >
> >As I understand, tc mirror is an action and can be applied with any filt=
er
> >rules. So, something below you can try
> >
> >tc filter add dev eth1 ingress protocol ip flower dst_mac <DMAC> m <MASK=
>
> >action mirred ingress mirror dev eth1
> >
> >Regards,
> >Suman
> >
> >>-----Original Message-----
> >>From: Vikas Aggarwal <vik.reck@gmail.com>
> >>Sent: Monday, January 8, 2024 11:36 AM
> >>To: netdev@vger.kernel.org; jhs@mojatatu.com
> >>Subject: [EXT] tc-mirred : Redirect Broadcast (like ARP) pkts rcvd on
> >>eth1 towards eth0
> >>
> >>External Email
> >>
> >>----------------------------------------------------------------------
> >>Hello "tc" experts,
> >>
> >>I have questions regarding  tc-mirred.
> >>
> >>Can tc-mirred tool  match on ethernet destination MAC address as I want
> >>to redirect all broadcast pkts recvd on my ETH1 interface from external
> >>network  to appear on ETH0 ingress interface.
> >>
> >>Thanks & Regards
> >>-vik.reck
>

