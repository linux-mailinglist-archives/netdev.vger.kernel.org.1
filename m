Return-Path: <netdev+bounces-90327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B2E8ADBD3
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 04:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69083B21E90
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 02:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCC91757E;
	Tue, 23 Apr 2024 02:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGpydhKK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B4417BA8;
	Tue, 23 Apr 2024 02:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713838691; cv=none; b=TbR7o+HQNjiLcHk+sYrtctt6ELCkiPl2Et1rAC7+6cvpRpxc76jbjX3ZS0ncrVI8sNJy9aqMZx2u8BoCPAXjgU6NCLdfptFbI6j4gOvF546psrnsUsC48mfeem2wRhmCdPbUICMgDwgv8Sue+8xb5VNteBOww+RO6SRxLquEhJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713838691; c=relaxed/simple;
	bh=IopP1bFkYoWAQOq+qAQGXZ+TGVLKYGRlyaC/38OvAac=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PE2bDT4zPmRv3l27dq9AKxmU0JymhG+JLjGezRl61kjVIxLteM7xSAZTjgPqZDQajINb6+7QLYXlSWm4Q+OnWO7vTu+/VclOi+g4CbRQ8dIs4XB/dBn3KcvVYlSwCTNE5XUN1Lb2Sy9B1y0hAdZ5zPQ5elL9RPdw2gPXJ+PVaKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iGpydhKK; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-51bab51e963so28891e87.1;
        Mon, 22 Apr 2024 19:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713838688; x=1714443488; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sNx3rKWvVj9v4h/EIoU/yDC78hRfQ0z6qddPdkKKM5o=;
        b=iGpydhKKjSR6KUzMBc+e8dtpbYLxsBs24tMhnFU0tqa34KuFAKNBG5Z+thiQBjyGgA
         Bb7INvX9uaAiyHubOQD4RiRlxnp+1CqKQqUMnAz2yZdpdOSwOo6S2yl9AkmKNJ4Ibur7
         +CSa2wwCDb/FeR7QHd6l2bVbFTd79d5LkwwQl3TA42jWDeFNchblOx80lXwW9RIu+NWj
         hoVGHrOUriuU8f2tGpt8+9VqkdO2Dqr7214788mtoLockKjQZjyZWpRe8Xr9pdB+UjoG
         ikaAHh15UanwwJJPvIsN50LVkXDNC54EUPrrPpL3ZcPG0o4nLpWJzdSWZIdH+L0LQOOF
         pxyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713838688; x=1714443488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sNx3rKWvVj9v4h/EIoU/yDC78hRfQ0z6qddPdkKKM5o=;
        b=AOtDuv+ggPT+Y6JwnHvHqbhBGe6y9k45x/TixboShj87+MWcXftL0Lo4O9PPWOmH0t
         WRpUZ9vCLVPMDVn1+ICPXBo8MMk+56YJ/qV87Fku7uM48HKxSglykvTTzoXGRBZqV8B4
         6TsoT+wNqP7z7dkzk7gKci+yLLb7MlCwt+IlYdrkWQP3Qd9cyVUN+SOSCvN3e4zdjMuX
         moVTcewtBxTxkunC+WfESDE3dsJmiPRWRihiV3p4ZDcn1QNjZe4gm1agUiLrRdV5wxqt
         nyXIgiqIpvHMxMnsYSmk7vM+eCFNkoL4gK9sG3cZqNHLhoKdRcpIjRu7V8zMCJOdXRTY
         moxw==
X-Forwarded-Encrypted: i=1; AJvYcCXDJtY/VnYhmPQ0KmeII5j21wGbQQ4FZ5YzXi/CwDLmqcV7VlPIFKJCUEtfsB6NHaYJmobVKZhYKFSKc8IAzdHKFqV9NmyxF9x8GFr1xylArr0nPrFys33kQKgVm8RKLdc0MzYQw+3uYJnZ
X-Gm-Message-State: AOJu0YwdgeBHe+8okQ0DvEB4wS5qTDE9nBaIFghlf65ZovXBnTN8KpaM
	GrXj/GO4Mu0KEbJ7HucgXFd/CK3iPZQHG0Y5sBHyIn0T/UVJLwsF0e3q7dtD0KCRn8RYXQgOyv2
	GuevOfO3owi6MDhQuleACVDHzKQE=
X-Google-Smtp-Source: AGHT+IEjFVfDZ1b7bRrb9RNiaXGSUz1z4d0R1LaPaGHytvUP/U/AtHU07YcBD9GKqtXQAIQBGHYMbRVr20cCPAIoj30=
X-Received: by 2002:a19:a413:0:b0:513:d3cb:249f with SMTP id
 q19-20020a19a413000000b00513d3cb249fmr6700874lfc.52.1713838687950; Mon, 22
 Apr 2024 19:18:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422030109.12891-1-kerneljasonxing@gmail.com>
 <20240422030109.12891-2-kerneljasonxing@gmail.com> <20240422182755.GD42092@kernel.org>
 <CAL+tcoBKF0Koy37eakaYaafKgoJjeMMwkLBdJXTc_86EQnjOSw@mail.gmail.com>
In-Reply-To: <CAL+tcoBKF0Koy37eakaYaafKgoJjeMMwkLBdJXTc_86EQnjOSw@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 23 Apr 2024 10:17:31 +0800
Message-ID: <CAL+tcoDoZ5CYn-fdK5AWaMe36O10ihe2Rd89dDmjBxiBDQ37sA@mail.gmail.com>
Subject: Re: [PATCH net-next v7 1/7] net: introduce rstreason to detect why
 the RST is sent
To: Simon Horman <horms@kernel.org>
Cc: edumazet@google.com, dsahern@kernel.org, matttbe@kernel.org, 
	martineau@kernel.org, geliang@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, atenart@kernel.org, mptcp@lists.linux.dev, 
	netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 10:14=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
>
> Hi Simon,
>
> On Tue, Apr 23, 2024 at 2:28=E2=80=AFAM Simon Horman <horms@kernel.org> w=
rote:
> >
> > On Mon, Apr 22, 2024 at 11:01:03AM +0800, Jason Xing wrote:
> >
> > ...
> >
> > > diff --git a/include/net/rstreason.h b/include/net/rstreason.h
> >
> > ...
> >
> > > +/**
> > > + * There are three parts in order:
> > > + * 1) reset reason in MPTCP: only for MPTCP use
> > > + * 2) skb drop reason: relying on drop reasons for such as passive r=
eset
> > > + * 3) independent reset reason: such as active reset reasons
> > > + */
> >
> > Hi Jason,
> >
> > A minor nit from my side.
> >
> > '/**' denotes the beginning of a Kernel doc,
> > but other than that, this comment is not a Kernel doc.
> >
> > FWIIW, I would suggest providing a proper Kernel doc for enum sk_rst_re=
ason.
> > But another option would be to simply make this a normal comment,
> > starting with "/* There are"
>
> Thanks Simon. I'm trying to use the kdoc way to make it right :)
>
> How about this one:
> /**
>  * enum sk_rst_reason - the reasons of socket reset
>  *
>  * The reason of skb drop, which is used in DCCP/TCP/MPTCP protocols.

s/skb drop/sk reset/

Sorry, I cannot withdraw my previous email in time.

>  *
>  * There are three parts in order:
>  * 1) skb drop reasons: relying on drop reasons for such as passive
> reset
>  * 2) independent reset reasons: such as active reset reasons
>  * 3) reset reasons in MPTCP: only for MPTCP use
>  */
> ?
>
> I chose to mimic what enum skb_drop_reason does in the
> include/net/dropreason-core.h file.
>
> > +enum sk_rst_reason {
> > +       /**
> > +        * Copy from include/uapi/linux/mptcp.h.
> > +        * These reset fields will not be changed since they adhere to
> > +        * RFC 8684. So do not touch them. I'm going to list each defin=
ition
> > +        * of them respectively.
> > +        */
>
> Thanks to you, I found another similar point where I smell something
> wrong as in the above code. I'm going to replace '/**' with '/*' since
> it's only a comment, not a kdoc.
>
> Thanks,
> Jason

