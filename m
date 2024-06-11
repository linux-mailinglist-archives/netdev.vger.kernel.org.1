Return-Path: <netdev+bounces-102419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B44902E33
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 04:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A72A284E41
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 02:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363FCAD49;
	Tue, 11 Jun 2024 02:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYwZmOf4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938D9134C4
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 02:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718071584; cv=none; b=KdHcJ2K5fk4+QrVM5F5syZR+9ZpnlYrjEwJTznfG0SRAcVw5YCZOEoEJhW0Mdx+gosuN76kmYv5/4ReTGnrBJ/c9F5uB3N01/OJas/RliodsGrZjgYMyaYqCtvaIMj4o9fWuenGYKTlyjaMqF+w6+4G0T98cli8pwW0U9ZOxYlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718071584; c=relaxed/simple;
	bh=tuff/6OuEt+2hme3SS1LRX+ueYVQOYk0iMP38yw56OQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kSy9vN95UqzhM9UoyPFFvnQ5H1O+aWTiSPOcEBe7kvRuiivRmxUYXfwJODFJ/EnRfyReyBq8EU4HIYWNSQdWjlJjw296U82qfH7eJwfetVvxuKWhMgV1eWzTT2MsZFJbd6igjfEEEiUGSjSZsTSML9rJhp0qrY/A4lnkLeRJL+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AYwZmOf4; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a6265d3ba8fso503522166b.0
        for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 19:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718071581; x=1718676381; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tuff/6OuEt+2hme3SS1LRX+ueYVQOYk0iMP38yw56OQ=;
        b=AYwZmOf4EV0VFoOHdFHLSwJaZX9ZV+Zs2yA/FWwYn8+xDwYRn23R4+A/EYJUY8Kp1x
         lZ62mVYcLTrR06Aec9zlMCxCxO/C7DHVI5VgiLdAjH18HSgPxfqmnQT6tu7vhP93yjKt
         Gma66EjonVzVw4Y+uKMlRf2FYOCnfVdyMPluP+Xt/KuqAkQZ9IlHFjK9ctHCvrbTZN3B
         woexZ267zH9Pm6Ik3xMt/pgAP2MxR3AP4F2uHjPUuG8dYefHW/crc+/Nf5WPKKe2NSgv
         Y9AafY9e0iItmLBcj0w3tEkWHSsIBPZMyqzI+7DnXMzuuVAms2pGAjHIBlt7/EDynbLd
         3KCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718071581; x=1718676381;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tuff/6OuEt+2hme3SS1LRX+ueYVQOYk0iMP38yw56OQ=;
        b=kZoro+DQFXpwfEydIekaS67ZsBvDs68otxcB7erS61kM2v4s8jpjdnXqxfbQ9hfJ/b
         CBIN+iXIwwBtnb/K+cpccMauYx6ORuxfj9OIYpg1ZZYEowb1hAWCqyubD7ZsLwjUsK6e
         tE2VsY83GUwo5ALUgrii3IQTSpTg1aSNZr03TXhYgZqdgfzxuN0pXqckXuiIHh9U/xN4
         1SyvFhorFB15DBKSDDqI/M5HqDEFGg8OQNCexfDZKGcQNftnLn8rC8pCsHgA31QQHyZc
         Ho5dPKAEeTENO2B2xTdKhK0dCUp8D+Us1mud52M/zEKwmc0+SDHgn9/1mcGcKGF2fnpA
         mu4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVVllkzvnTIylV9+H5fUUqYTNEerAHakwRBa6CyM1/UBX/Ah3SZ+z2v3ROl60F+08KdZI3gRSW1dbPZbTSvvr+ppT8pn10t
X-Gm-Message-State: AOJu0Yw2Jk4K2WHiw+0eRIQyKfOqU+lY4lRot1wafNur/VVmEo0ozcFn
	cqR3JloTmjx/jQlObL+qTC8EqferdQYa1SYDa0fOjL+/4+aJ8MxCcvBkL3os0cbEQb0vZOijX2f
	NxoCLT+EwLvEeVcEbv5ED7q9CMnY=
X-Google-Smtp-Source: AGHT+IHJ8AjC2nQdCHkvEIiAg5SYB3Vy4VBsSouM+tmUNPm4sUIJZMgWBTWyiI1mjy8d9yBV3+j6xZozdhfUDe7nhgY=
X-Received: by 2002:a17:907:7f87:b0:a6f:20af:49cb with SMTP id
 a640c23a62f3a-a6f20af4f9dmr298552066b.48.1718071580627; Mon, 10 Jun 2024
 19:06:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130142521.18593-1-danielj@nvidia.com> <20240130095645-mutt-send-email-mst@kernel.org>
 <CH0PR12MB85809CB7678CADCC892B2259C97D2@CH0PR12MB8580.namprd12.prod.outlook.com>
 <20240130104107-mutt-send-email-mst@kernel.org> <CH0PR12MB8580CCF10308B9935810C21DC97D2@CH0PR12MB8580.namprd12.prod.outlook.com>
 <20240130105246-mutt-send-email-mst@kernel.org> <CH0PR12MB858067B9DB6BCEE10519F957C97D2@CH0PR12MB8580.namprd12.prod.outlook.com>
 <CAL+tcoCsT6UJ=2zxL-=0n7sQ2vPC5ybnQk9bGhF6PexZN=-29Q@mail.gmail.com>
 <20240201202106.25d6dc93@kernel.org> <CAL+tcoCs6x7=rBj50g2cMjwLjLOKs9xy1ZZBwSQs8bLfzm=B7Q@mail.gmail.com>
 <20240202080126.72598eef@kernel.org> <CH0PR12MB858044D0E5AB3AC651AE0987C9422@CH0PR12MB8580.namprd12.prod.outlook.com>
 <CAL+tcoBXB97rCp2ghvVGkZAuC+2a4mnMnjsywRLK+nL0+n+s2A@mail.gmail.com>
 <CH0PR12MB85804D451A889448D3427132C9FB2@CH0PR12MB8580.namprd12.prod.outlook.com>
 <CAL+tcoDkpZva=aStFKWTO6_8VK2iu9CeSeW2aeC+2QTXR2nD=Q@mail.gmail.com> <20240610105717.7fbb1caa@kernel.org>
In-Reply-To: <20240610105717.7fbb1caa@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 11 Jun 2024 10:05:41 +0800
Message-ID: <CAL+tcoB3tCw+CypLSaqcFs8CASJDCLPchQs1xcyC9eS+1hYDxQ@mail.gmail.com>
Subject: Re: [PATCH net-next] virtio_net: Add TX stop and wake counters
To: Jakub Kicinski <kuba@kernel.org>
Cc: Dan Jurgens <danielj@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "jasowang@redhat.com" <jasowang@redhat.com>, 
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, 
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>, 
	"abeni@redhat.com" <abeni@redhat.com>, Parav Pandit <parav@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 1:57=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sat, 8 Jun 2024 08:41:44 +0800 Jason Xing wrote:
> > > > Sorry to revive this thread. I wonder why not use this patch like m=
lnx driver
> > > > does instead of adding statistics into the yaml file? Are we gradua=
lly using or
> > > > adding more fields into the yaml file to replace the 'ethtool -S' c=
ommand?
> > > >
> > >
> > > It's trivial to have the stats in ethtool as well. But I noticed
> > > the stats series intentionally removed some stats from ethtool. So
> > > I didn't put it both places.
> >
> > Thank you for the reply. I thought there was some particular reason
> > :-)
>
> Yes, we don't want duplication. We have a long standing (and
> documented) policy against duplicating normal stats in custom stat
> APIs, otherwise vendors pile everything into the custom stats.

Thanks, Jakub. I see :)

