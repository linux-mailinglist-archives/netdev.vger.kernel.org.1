Return-Path: <netdev+bounces-140253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF169B5A8F
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 05:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CB5BB23625
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 04:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B34019922F;
	Wed, 30 Oct 2024 04:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="I8jAHgH6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FA2194C75
	for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 04:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730261212; cv=none; b=VWecJO2bJuyzuCSL8SCnD0yLKdF4sBeNOwsg0I47EgQ2Y1SZKWzTx98lKSDqkQZwWLzYsjKqQ5DlGJQJsdMIyelGJn3w5h8CXcqaEkNjCBb94u50AizjT3R0BNTNyOMksI31R3jp9bv59GKEkbRWIIg6KeCD0NMKbfj6uyxZDtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730261212; c=relaxed/simple;
	bh=9O+vcK+aG1bM+4aX7/bKSQqAL3qlfIXyCnxn1sln+3I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cPSGZlZ213JkWuLjM7POwJplpkKDj3a6z9ocZl+5vwvhqSledCSSbquGP26hosq04mI+5mRSW18P9s5IY71gi1Jkes48kTDuE3/TK4pTwVJmkxKCVif1aX7zxIuxN3HjTFLDh3t3MzUkZQTS9pbRxJEjLHY/3Fcb48fC+HKdB5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=I8jAHgH6; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bJZ/HJHqMltWOi+2EAmjoVviBm3eOAD+ovstS53d41U=; t=1730261210; x=1731125210; 
	b=I8jAHgH6v+ccdLn3ONnUkghJub90XZGv+a0gTLvi0TPkmN84+Ry0dIjL8/+PqYgR7GIyouJ7URs
	nRwHSfAEiMBrnip7B3L4Ms5xjJDjWdb2OuH0TDuBmBP4GndZeM3sfN9CjDr2hb/zPb/Dl5DH7RBfY
	tRS0663Zn8iGBniwDj/O33G5FBv4SCTDh6kfV44W78cujL/qu+0p2pX0Pu1/DJz4xJy8eQ27enSQg
	9gVpsMHv1HTkXYq+anDuCdSczQOR2Tm+XhSvtT3tP33Wfe4cfhtS1c4+tdc2J1P8BWT3HAbdWMf5L
	rhxvm45m1RUEC+Mo187QhQfBy8ZH0k2Pc5Bg==;
Received: from mail-oi1-f171.google.com ([209.85.167.171]:49155)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1t5zyl-00078k-G6
	for netdev@vger.kernel.org; Tue, 29 Oct 2024 21:06:44 -0700
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3e602a73ba1so3519686b6e.2
        for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 21:06:43 -0700 (PDT)
X-Gm-Message-State: AOJu0YwuwJVCLW6dcsSQUsrtWrYYs8ekDpGBGdQ9uPl5l3SaCFZwRcDX
	a3Ug9Rc6bpiFmYcOoH6wI7eHVzo+1RShFIgsnpxERo88vcmrRu90+E+4oV2zZZKaVB990Bbu3Uy
	ND9kvMFp0/sHPX2QECQ2ZEcgvKXU=
X-Google-Smtp-Source: AGHT+IG3+APmd+8Tfe2yJ/cC5Fv1vVHN19H6lQaeA0C4ud2SRTlHsiHs5R9uekswLEukCarLiSIyesl1IkxYzhf9kR8=
X-Received: by 2002:a05:6808:1992:b0:3e6:28c9:c381 with SMTP id
 5614622812f47-3e63848a78fmr11086177b6e.36.1730261202867; Tue, 29 Oct 2024
 21:06:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028213541.1529-1-ouster@cs.stanford.edu> <20241028213541.1529-2-ouster@cs.stanford.edu>
 <6a2ef1b2-b4d4-41c5-9a70-42f9b0e4e29a@lunn.ch>
In-Reply-To: <6a2ef1b2-b4d4-41c5-9a70-42f9b0e4e29a@lunn.ch>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Tue, 29 Oct 2024 21:06:06 -0700
X-Gmail-Original-Message-ID: <CAGXJAmwSCeuwy6HXpzZgp8m+5v=NPCOTgKc-8LBjUuY079+h0w@mail.gmail.com>
Message-ID: <CAGXJAmwSCeuwy6HXpzZgp8m+5v=NPCOTgKc-8LBjUuY079+h0w@mail.gmail.com>
Subject: Re: [PATCH net-next 01/12] net: homa: define user-visible API for Homa
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: 3acef658708772c1d00935e7d4d752c5

On Tue, Oct 29, 2024 at 2:59=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > +     int flags;
>
> Maybe give this a fixed size, otherwise it gets interesting when you
> have a 32 bit userspace running on top of a 64 bit kernel.

Good point; will do.

> > +     uint32_t _pad[1];
>
> If you ever want to be able to use this sometime in the future, it
> would be good to document that it should be filled with zero, and test
> is it zero. And if the kernel ever passes this structure back to
> userspace it should also fill it with zero.

It does have to be filled with zero, and it is checked. I'll document that.

> > +#if !defined(__cplusplus)
> > +_Static_assert(sizeof(struct homa_recvmsg_args) >=3D 120,
> > +            "homa_recvmsg_args shrunk");
> > +_Static_assert(sizeof(struct homa_recvmsg_args) <=3D 120,
> > +            "homa_recvmsg_args grew");
>
> Did you build for 32 bit systems?

Sadly no: my development system doesn't currently have any
cross-compiling versions of gcc :-( I think the best thing is to
remove these assertions from the kernel version of Homa. They are
there to make sure that I don't accidentally change the size of the
structure; I will keep them in the GitHub repo for Homa, which should
serve that purpose.

Thanks for the quick comments.

-John-

