Return-Path: <netdev+bounces-124084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93133967EE9
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 07:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2796E280723
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 05:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD891145B14;
	Mon,  2 Sep 2024 05:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWeRYnR0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60BD933F6;
	Mon,  2 Sep 2024 05:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725256094; cv=none; b=nDRjNj9rAN2EQCYNmyj1eXsm7FqBU0Rcq6hFhPfSaYixOEPs0J90fgQb8Ulcg5ik1DtHWdYvZMWDzsjnr4uXdIqObUCYfOzyxA/FySPOp2snknztHB0Q9AAJ6xlCpE56CMdAz9/tIc9U1No//GPibJvuHYqkH6SLJO/N0WXXtO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725256094; c=relaxed/simple;
	bh=agQ9K+4rQ6Dz2BKdz9UdlfxfgH4HVojpBR3m6Be8j90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mY0G/bEjQNvsKbvwoYHdQrZELqt89kZVUlEeMqplxNX7lYItUF8PR8aXPByV6qeFHutW8FRnaD2Z95GLjFOztjO5b98GUTTsosLGg44T6bQVptekw9HZpDFSpqjTVyxW1cMvoRFdvFZYw0ysWnvMohA4DH4JaMqEBPf4H6MBpRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VWeRYnR0; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6d74ff7216eso4720097b3.1;
        Sun, 01 Sep 2024 22:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725256092; x=1725860892; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=agQ9K+4rQ6Dz2BKdz9UdlfxfgH4HVojpBR3m6Be8j90=;
        b=VWeRYnR0aYmUdypLYN0mAzAt8nnBwj7pM3jYPbbdD0Dck7/5i/hxNo5dGcPmH7oObY
         FE6ZCmhWCa7Y9YszjvCk1fGXcRQWuWO7Vtps89x7dTiUjErPVB0Y2CfT0tlgpvon9Lxd
         wx+4fIHM/kTqm15ZdXSigDVh1FyOow2PGSIwfhV7mJ0E4pgNqTkcH78d7UpPTN8tYknh
         88KAOvmZlUxF6l90P5BD3vLfHbch6g4/tUmbVPy2L7aQplPPs7+eQYx72m3dBDDOcJpt
         M3aX2babRKhqg8D55xL2T0Rq+sNZ4pFwiUJnDNuDPK7sgmWBihHnukNazulG99eZum8B
         lqqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725256092; x=1725860892;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=agQ9K+4rQ6Dz2BKdz9UdlfxfgH4HVojpBR3m6Be8j90=;
        b=Y2CUQZDiZ5hkm/mNh7NZ/0kU1MK8FleWV57U3RFHIbbwOpXlfSFINvOz57gkfiqQQX
         6jtpj0auGjZvg1VnJvC2DYtDztCP94yvK7J9S6TQ3HmKVHW+GMsF1syhqYBFEZjCL8Nq
         zjSmq5Swwp9yGYBF2aEw6z45na8rVaFfvqSMZLspJYwyi0WUHKFTwHTDZijz4kvkYlnS
         L9hzsL61QgwrJBbwZ4d1DVx5ZQ6MW6NDqEAgEhRYRWscryDYRV/CfloUFB7MoqRhaHYY
         bVvKCbwooFsTmwXSZDWXWFs4dOBjKlJ5YjR6VHOlDnb2X2mbTf31yfr7oI+o8l8/0Wh1
         eMNg==
X-Forwarded-Encrypted: i=1; AJvYcCUeVZ/QUtXKWGwG/F1tbpkXRoSIELn7UPHE8ZODcmDe6IXXUKO1akvA8roewk3TWjT6xgV5DfW2t+pfrCo=@vger.kernel.org, AJvYcCVCAfTv6Wp862WV0ySGGUg7S3vPcHgtgytjxECqFkRtiwo6SGfTAgQ7fy1hwFJhwYP4+/K5x+9j@vger.kernel.org
X-Gm-Message-State: AOJu0YyqCz/BVRIx5+na+CuIeLcpd9hM5HqIreGU861F5Gj8gt6rtAQB
	pO8SiXKa2klcSFW/PMv/lDWHCWMRf4T0o+41J3MUk5JBGE7Es6B2P06gr85s/J7WR3+80u97xWd
	LwVIAsMsn++gsWIxYLWjcXp244LA=
X-Google-Smtp-Source: AGHT+IEYmBJuNieRAMqiqgHqD0icX1LoNHE5+KCuQqfrE6Bp1kqfG8ga8CIxHoWoqZiuSmgKK0H8ycb97GOYZf+Fvlk=
X-Received: by 2002:a05:690c:490a:b0:699:7d04:c7b4 with SMTP id
 00721157ae682-6d410cb38b7mr109638337b3.31.1725256092148; Sun, 01 Sep 2024
 22:48:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827133210.1418411-1-bbhushan2@marvell.com>
 <20240827133210.1418411-2-bbhushan2@marvell.com> <20240828182140.18e386c3@kernel.org>
 <CAAeCc_=3vXvRgo1wxzHwSY6LJS-vUzeShSdJKLotYSuHBi-Vzw@mail.gmail.com> <20240829074832.0f091f53@kernel.org>
In-Reply-To: <20240829074832.0f091f53@kernel.org>
From: Bharat Bhushan <bharatb.linux@gmail.com>
Date: Mon, 2 Sep 2024 11:18:00 +0530
Message-ID: <CAAeCc_mDM+XygbBDLG+8axXAXgsmh2eUnqdGSFjiLek96LeKxA@mail.gmail.com>
Subject: Re: [net-next PATCH v7 1/8] octeontx2-pf: map skb data as device writeable
To: Jakub Kicinski <kuba@kernel.org>
Cc: Bharat Bhushan <bbhushan2@marvell.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sgoutham@marvell.com, gakula@marvell.com, 
	sbhatta@marvell.com, hkelam@marvell.com, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, jerinj@marvell.com, 
	lcherian@marvell.com, richardcochran@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 8:18=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 29 Aug 2024 11:17:25 +0530 Bharat Bhushan wrote:
> > > How did you test this prior to adding skb_unshare()?
> > > Could you share some performance data with this change?
> >
> > testing using flood ping and iperf with multiple instance,
>
> Makes sense, neither of these will detect corruption of data pages :(
> IIRC iperf just ignores the data, ping doesn't retransmit.
> You gotta beef up your testing...
>
> > I do not see any drop in performance numbers
>
> Well. What's the difference in CPU busy time of v5 vs v7?
> You'll copy all TCP packets, they are (pretty much) all clones.

cpu is 5-8% more busy when skb unshare.

Thanks
-Bharat

