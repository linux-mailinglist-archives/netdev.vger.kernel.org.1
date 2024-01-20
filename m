Return-Path: <netdev+bounces-64449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D188332CC
	for <lists+netdev@lfdr.de>; Sat, 20 Jan 2024 06:03:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A90BB1C212C5
	for <lists+netdev@lfdr.de>; Sat, 20 Jan 2024 05:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27580138F;
	Sat, 20 Jan 2024 05:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NFNEVtK8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A18137D
	for <netdev@vger.kernel.org>; Sat, 20 Jan 2024 05:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705727018; cv=none; b=VoItLVQdKUXIkADdX5kt0k3JByjQBZYFwAUArqtg1aeIuuXyF2WSDsNILwV/35xqWK6DbTbqCUtSOp/hltGsAlAy4Owe4R69NiPeBeKaZ+H5PB1uRHmtqFp2h8ISY8/pmOr7qp8socL8OrNPWVBs8Cend9XRIPAZnht/bdeEc1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705727018; c=relaxed/simple;
	bh=PfSxBA4zHQuqm6PRVCl10z6kBnnUtQNvR0FxKJ5FaRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e2Rrpb7Z+B3cXH55IE7W90R5oWQd9uN90kW15Qf46zQET/bjVvYrj2Y+IXK6R0QEsMdMiEJfg/pyzeMOwythNSC2SNFFreZy5l/PePLHew21zv7AlPJLKMFga/WKlzkhYWY75L3OW8YnnrpNCps51+Px/D6w4hGAk0WN7zVJTz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NFNEVtK8; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-78336bfc489so104899485a.0
        for <netdev@vger.kernel.org>; Fri, 19 Jan 2024 21:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705727015; x=1706331815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ox03DUzeK46nNcS/JT+ZQHCq7KHV9kzAZDi5zk0zMFM=;
        b=NFNEVtK8ZIdUCekJXEBNETjv/OfVuoCxOlK8x9bA9UlgmVNtNHM6era3zwb8vGtLv4
         PtW01PZbWlhjCYocu/IwaD5ZduDRU4oaXjUhLOPdorGuuUEUfhIlgYJpo2P0BeNBEd7t
         3xcddL+bZ96shhwcZSYXs3K2utTB1AP7qc09OvKuvQenZx6Ma3svS/+FHGu5BW86WBl5
         8k2Vc+S5lzxzOJblJzYDDK1KLaia9UgpblCRp3LW1jroQfc/MfF5UXRAryQZwHaxW1Uq
         ot22inzijTbdnOMAACGF0+ql4sk92/75NS/UjYbbWhSNCaSfufzez7QQ2I1ZNC2rPQsC
         TdYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705727015; x=1706331815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ox03DUzeK46nNcS/JT+ZQHCq7KHV9kzAZDi5zk0zMFM=;
        b=wo/53PyRxJo4mWp2yl0XomTyqsX+DOsKYDUs/YOj97Oc8iWxsux+jvI3y8yneqkSkR
         HiufYQ/oZqnszfQxF0YLMa2i9ikB45qVHkv/abieqdJe+4SUtNLPZ1nLQv+zwvpewlAQ
         j4NTT1lrdKZacofNp6eWQl9vuI80t2fX8MoHLC+a4sQ2fW6u5LKv93skA37D/nFOVVOs
         bt20/J6qtVWP2S8Jb57ixkUnCJQZ/wUD2wZxZam68SmJymzF0zaVG5Y9gXQmCmZXCS1R
         10aTy9fSysHr/zOUX2bim6Ygz4/c3vhr+UE3J75wQwpEDKSFZUOIqkYRtGAyDjMptejB
         O1zg==
X-Gm-Message-State: AOJu0YzANzO28NotZDfYiGHqMg+eHpxqlWDMhS8rY0VoyGEDtbcaRVf+
	OcpeXXKdZ8qqdAApPO6DjSxz9O3GOP6CAGq4PwHvHLHznAigUgA34TXjMbIdP0Pt1DAz2KH09UW
	O/kGF0ff3xnvwkiwQ3Eq9VbJ8WYM=
X-Google-Smtp-Source: AGHT+IFUrBRiqhwl3y2l6gOTpKLChPcV0TYR6IstvFg7vA5IEG0U66CSUpoqYn0yYcSj9gnpdGHQCxuCa8RINGxUOWU=
X-Received: by 2002:a05:620a:450a:b0:783:805d:5757 with SMTP id
 t10-20020a05620a450a00b00783805d5757mr1316859qkp.47.1705727015592; Fri, 19
 Jan 2024 21:03:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOid5F-mJn+vnC6x885Ykq8_OckMeVkZjqqvFQv4CxAxUT1kxg@mail.gmail.com>
 <SJ0PR18MB5216A0508C53C5D669C07F72DB6B2@SJ0PR18MB5216.namprd18.prod.outlook.com>
 <SJ0PR18MB5216EBC3753D319B00613E79DB6B2@SJ0PR18MB5216.namprd18.prod.outlook.com>
 <CAOid5F8TV=LbN_UZzmGfOrq1kh8hak7jrivHm2U9pQSuioJP6g@mail.gmail.com> <0b2bdc15-b76b-4003-ba1d-e16049c7809b@mojatatu.com>
In-Reply-To: <0b2bdc15-b76b-4003-ba1d-e16049c7809b@mojatatu.com>
From: Vikas Aggarwal <vik.reck@gmail.com>
Date: Sat, 20 Jan 2024 10:33:24 +0530
Message-ID: <CAOid5F8L8enzhKfW46SGxoZBp8Sed6xBSpE4Hqt+cY02r_O1xA@mail.gmail.com>
Subject: Re: [EXT] tc-mirred : Redirect Broadcast (like ARP) pkts rcvd on eth1
 towards eth0
To: Pedro Tammela <pctammela@mojatatu.com>
Cc: Suman Ghosh <sumang@marvell.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"jhs@mojatatu.com" <jhs@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks so much  Pedro Tammela & Suman.
Getting bit greedy here with tc filter :)  -  Can i also use some
boolean  for example dst_mac !=3D aa:bb:cc:dd:ee:ff

On Thu, Jan 18, 2024 at 3:10=E2=80=AFAM Pedro Tammela <pctammela@mojatatu.c=
om> wrote:
>
> On 17/01/2024 16:15, Vikas Aggarwal wrote:
> > Thanks Suman that works.
> > I need similar "redirect rule" on egress side.  Suppose if i do udhcpc
> > -i eth1  then I want  DHCP to resolve via eth0.
> > Syntax on egress (root) side is different and more complicated and I
> > need to learn egress syntax.
> > I am trying to tc filter + mirror  based on udp and DHCP port 67-68 .
> > Can you please help with this  egress side DHCP redirect too.
> > Thanks Again
> > Vikas
> >
>
> tc qdisc add $ETH clsact
> tc filter add dev $ETH egress ...
>

