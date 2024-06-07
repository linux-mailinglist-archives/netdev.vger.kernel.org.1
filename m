Return-Path: <netdev+bounces-101750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFC28FFF10
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 11:17:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF41C283668
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 09:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883CA15B143;
	Fri,  7 Jun 2024 09:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IrPUSuTV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B3915B131
	for <netdev@vger.kernel.org>; Fri,  7 Jun 2024 09:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717751806; cv=none; b=TM8omx4fHRO9xpEbfEElZrbl07oEgz1eT3d0+OPmeGOyDwfy6IbtiFcGXofh69/dZOFDplfifOUTllZZnY8VSpZqbjBUpiWPPigFrpYBCL1i6niekkglQROBNgWPLqrjyae1rNb/T5+IXihXjqlWVDfian4ZZR8yniJsDKGvSms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717751806; c=relaxed/simple;
	bh=QzOHaJ+VpQtbU98T3t6z1j5z/fDMO7o6RSHzV4knFvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ETr+604DAuYARzUIy5AcipjTOBoEdCw8gGMamuwryG+JLJr5juoSR+nDIaz9XcVBOpx5auDDye4PYNT4A3kKnRRFPIC5xDyVxCU+PFdPkKUagkto5xMDQYj4Fq7JCJHeF15Y8tBgwFVgv04wNaLlmdnep9FBLLeC2FpHGm+o10w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IrPUSuTV; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a68f1017170so241641166b.0
        for <netdev@vger.kernel.org>; Fri, 07 Jun 2024 02:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717751803; x=1718356603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QzOHaJ+VpQtbU98T3t6z1j5z/fDMO7o6RSHzV4knFvs=;
        b=IrPUSuTVQVG/G1qiqXSjGdmnutyeA6m9IErADYlggMt6saV+8grfQWrgudOGXZNBFV
         ARoQ3wQECxboK7hz+qdmlekidYlsjjdtRhEOglyQ7xuhdZmgcRdnIVwIF1XdYOwzpNAD
         l6S1k6Uv1m7DCd+OnTwJDLHiItA0NFtID/JfeSfGasKIHISKIhWo6FnKhH0hDEUeCqqs
         1U9LSdEWho/RKRx9e73ZKAZVV26yPw2tgjdKdsPj7npDY5wapxYDvroPupNc5rAoHc+y
         mshZhrl/djZFKncyGA9JaFHUrqhqxIBRF6s3SEFhgkMBN6S+HXVuTdzQ4hI8XYJ7FcI9
         zIdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717751803; x=1718356603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QzOHaJ+VpQtbU98T3t6z1j5z/fDMO7o6RSHzV4knFvs=;
        b=VrVHbGkraCDh5gebX3SSqkiQlDvr5RxK7liBpTKbtEX9w9iDrN2hWRMXh+HecKIaMz
         D4igM1C8N20gfnqTp1l58/OSs7zuzE3KBFXk+Tspj2uJ7gIL/pK7wKr3i6FNPsEIZ8HP
         tjZy10vOFqcgVC6QvpJlF1EjYXwgffcoPoqzEACo91GENIfdnogWvcsDiQ94+M7hA9q6
         FqJMx7Idx75spneFVubq6Y6HjO2a7W0g561sfp2CGAUEOe4OhZxY9PXS1HrCS30ZxKeO
         VnKABIXa63va31rwEpwRy2WFbOguvgfrMCELFG5F+cGdpNXYcYrdbUSGQq2ikLWh6o7Z
         RbhA==
X-Forwarded-Encrypted: i=1; AJvYcCU7oXxJWws6o24Va9B5R/LQqSx8JjOKInD/lHKcmaZViCBOMdMkEdHiaCXcbxjvgqvjq7IooJDTuDVYQKo/ir6ew6CWIpBi
X-Gm-Message-State: AOJu0Yya1K7EoASPPy3lQNWXsvNF/nLXgp9g7YGbFZaiVwgnPZRVdICp
	I+VnJ64txhrrkST/B+eg/cVcKoQwPP3VY5Z8I/BEiHHf6UabP5DE03InBMxos/lJClpokkUvQH+
	H2vHoQQ9ezN7+nSMADlfu7K1Mrv8=
X-Google-Smtp-Source: AGHT+IHoguKxRM7exkyMVrRtyhDuFXR6LPgRouKgmIvnNKxWFlca3whZ14HFA5//zRqMaFuM1JDi7nmgTPLIYsEFH00=
X-Received: by 2002:a17:907:6ea6:b0:a68:f83b:22fa with SMTP id
 a640c23a62f3a-a6cd5613cfdmr157790966b.11.1717751802811; Fri, 07 Jun 2024
 02:16:42 -0700 (PDT)
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
In-Reply-To: <CH0PR12MB858044D0E5AB3AC651AE0987C9422@CH0PR12MB8580.namprd12.prod.outlook.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 7 Jun 2024 17:16:05 +0800
Message-ID: <CAL+tcoBXB97rCp2ghvVGkZAuC+2a4mnMnjsywRLK+nL0+n+s2A@mail.gmail.com>
Subject: Re: [PATCH net-next] virtio_net: Add TX stop and wake counters
To: Daniel Jurgens <danielj@nvidia.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "jasowang@redhat.com" <jasowang@redhat.com>, 
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, 
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>, 
	"abeni@redhat.com" <abeni@redhat.com>, Parav Pandit <parav@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 3, 2024 at 12:46=E2=80=AFAM Daniel Jurgens <danielj@nvidia.com>=
 wrote:
>
> > From: Jakub Kicinski <kuba@kernel.org>
> > Sent: Friday, February 2, 2024 10:01 AM
> > Subject: Re: [PATCH net-next] virtio_net: Add TX stop and wake counters
> >
> > On Fri, 2 Feb 2024 14:52:59 +0800 Jason Xing wrote:
> > > > Can you say more? I'm curious what's your use case.
> > >
> > > I'm not working at Nvidia, so my point of view may differ from theirs=
.
> > > From what I can tell is that those two counters help me narrow down
> > > the range if I have to diagnose/debug some issues.
> >
> > right, i'm asking to collect useful debugging tricks, nothing against t=
he patch
> > itself :)
> >
> > > 1) I sometimes notice that if some irq is held too long (say, one
> > > simple case: output of printk printed to the console), those two
> > > counters can reflect the issue.
> > > 2) Similarly in virtio net, recently I traced such counters the
> > > current kernel does not have and it turned out that one of the output
> > > queues in the backend behaves badly.
> > > ...
> > >
> > > Stop/wake queue counters may not show directly the root cause of the
> > > issue, but help us 'guess' to some extent.
> >
> > I'm surprised you say you can detect stall-related issues with this.
> > I guess virtio doesn't have BQL support, which makes it special.
> > Normal HW drivers with BQL almost never stop the queue by themselves.
> > I mean - if they do, and BQL is active, then the system is probably
> > misconfigured (queue is too short). This is what we use at Meta to dete=
ct
> > stalls in drivers with BQL:
> >
> > https://lore.kernel.org/all/20240131102150.728960-3-leitao@debian.org/
> >
> > Daniel, I think this may be a good enough excuse to add per-queue stats=
 to
> > the netdev genl family, if you're up for that. LMK if you want more inf=
o,
> > otherwise I guess ethtool -S is fine for now.
>
> For now, I would like to go with ethtool -S. But I can take on the netdev=
 level as a background task. Are you suggesting adding them to rtnl_link_st=
ats64?

Hello Daniel, Jakub,

Sorry to revive this thread. I wonder why not use this patch like mlnx
driver does instead of adding statistics into the yaml file? Are we
gradually using or adding more fields into the yaml file to replace
the 'ethtool -S' command?

Thanks,
Jason

