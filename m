Return-Path: <netdev+bounces-232360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12AA3C049C3
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 09:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA2FD3B22FE
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 07:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D54D028D8DA;
	Fri, 24 Oct 2025 07:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QVwZjAHF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1953C28C874
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 07:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761289545; cv=none; b=SuzOZdCRy82WV7F8hB4ortmstAOO+pynTwaQMyrXsyMUR5vKPp8EeVb1nFUW5Ga6D3KVtGeUEtCV7PyLMtryCeYlP01CMZMYushK9RQuuem5rcporikfOsfwWWAW4Gz9bm0d76N9qxI2GCP8MNuLFwHqPz6PiSeLDLdcwfxup7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761289545; c=relaxed/simple;
	bh=JYRh6d35m688v18Niywoi4gb4bSrnVYUZ1a60rTqaQc=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sug1DZGtde8w830DBcZbAzfWgVHBu/c2go9w0SmwEGLePOEoIQrr5kJEze1dB5dH+JaY0PbtaBM3aUgBjHQh80efXvvvCPfnzKPe20koXZ0dq8LqhrmNUHCqLEfs34XaHWmITpB9TgvnNETr/bmmcNlLyBOZ8SH/PtBrzvklVYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QVwZjAHF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761289543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0FZBgj/9w9plr3ZN5/JPijL+YiLK2lWHoHpXfJ+sPrw=;
	b=QVwZjAHFH41h7+iYJxib1MfqRXs9oh6x+T81/yKSbg4pubCWlzzl56C87RIWpf9r2+szPE
	x89sFAOExADf5nEQASc1KCXGhw3zsVcUsdYv3vRQEKBoNgh4zTX3xw5Gri0sTsVXeGvHYo
	uyiYw4E+G+0MHOy0HQDwvIvb3m8ies8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-iRXdoqn8OVKw9CYoOFZEQQ-1; Fri, 24 Oct 2025 03:05:41 -0400
X-MC-Unique: iRXdoqn8OVKw9CYoOFZEQQ-1
X-Mimecast-MFC-AGG-ID: iRXdoqn8OVKw9CYoOFZEQQ_1761289540
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b6d4279f147so180735566b.0
        for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 00:05:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761289540; x=1761894340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0FZBgj/9w9plr3ZN5/JPijL+YiLK2lWHoHpXfJ+sPrw=;
        b=f0LfC8bTSfmI/UoB81M7ZpvtR2FCAP3CBgzecCZ7tIo8cuEuogjdjrlDmwGqqNrFxT
         2YcYnUrqGSZrQWOVnQQXYHK8H4SDF8kUPKIlUhBWHvCTOPu5dGph4Pmua5chWGObPWtM
         JxqO1LHFHVMetUKBEaiMHmZFNSZmwMHs43iin8s0XsNle5Zl4/uRYziItprVCEOze9h9
         3zxH/EyMvF1fxaStT+3JqU04DvCQQEglOuX2KbbvDREHUDQw0E4vZj3uY5+Z4WY5m0E4
         Kd5TIxdg55Ciz/TiSr7e5CsOLo0z+3bnXxyyIdLtzG6JC0/UJHi41pVPzX8JkETGM3eq
         yHCg==
X-Gm-Message-State: AOJu0YwYXaMFh8G8MShnkpTpC9+KnhCuytIYI/qpMEd5dRbh2DKcwOPo
	zz8V9wnEgTXljmZI1rh2Ce4KEZndTeSQRnEVSWAHG5IEFTuk5uDctFIhwn/hwrcY3OuPZARB/ra
	03u28g9kXMQvssEH/zCAeHS68wQQF3Jzfxa8tBzowfTyUYq7STVx56fR53aajZafNgBnR4knNPE
	U4bSlPLl8Dc4bJd+Bm7S8xMW7LCqtMRunA
X-Gm-Gg: ASbGncuaj9KnFv0gKeCgCEmXF2h+FzfeNJ7vQ9pOSBee5oYLRhZEsVMScuyKSCbwf0+
	lKBdxmS3v39W0OmSMzfKIaSxiCRqWRt1V2IqZgQG8b6ZatWZ6yEKTNgX2q7e3HDrXqLchVNiNmt
	YtVCLFGv6C9w3es8hlEM4Vf7Q9uLdBxLZHeJE70Va1Nzu1+CV2DBF9dO0cnQ==
X-Received: by 2002:a17:907:86a2:b0:b40:6d68:34a4 with SMTP id a640c23a62f3a-b6472b5f80fmr3238324666b.2.1761289540144;
        Fri, 24 Oct 2025 00:05:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuB4wvFcvRtGcIlauvG3S3/KsjSx2Fi6dYn1JgimHrydTNVwTkvmnni4iqjLYwg/MuRLZePszZyatZXoZqyxQ=
X-Received: by 2002:a17:907:86a2:b0:b40:6d68:34a4 with SMTP id
 a640c23a62f3a-b6472b5f80fmr3238322866b.2.1761289539770; Fri, 24 Oct 2025
 00:05:39 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 24 Oct 2025 02:05:38 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 24 Oct 2025 02:05:38 -0500
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20251023083450.1215111-1-amorenoz@redhat.com> <6a2072e1-43be-49a3-b612-d6e2714ec63e@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <6a2072e1-43be-49a3-b612-d6e2714ec63e@6wind.com>
Date: Fri, 24 Oct 2025 02:05:38 -0500
X-Gm-Features: AS18NWBithWB09Icf3xAiWn1GXXbmzEgZpGPuUfsraurx7GlZ0ka3mXgdSaqBxU
Message-ID: <CAG=2xmNBZ1V7kh7Y0425NPTLJCVyhLB82zNC6GpUN6cXJoyBMw@mail.gmail.com>
Subject: Re: [PATCH net-next] rtnetlink: honor RTEXT_FILTER_SKIP_STATS in IFLA_STATS
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: netdev@vger.kernel.org, toke@redhat.com, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Stanislav Fomichev <sdf@fomichev.me>, Xiao Liang <shaw.leon@gmail.com>, 
	Cong Wang <cong.wang@bytedance.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 05:39:09PM +0200, Nicolas Dichtel wrote:
> Le 23/10/2025 =C3=A0 10:34, Adrian Moreno a =C3=A9crit=C2=A0:
> > Gathering interface statistics can be a relatively expensive operation
> > on certain systems as it requires iterating over all the cpus.
> >
> > RTEXT_FILTER_SKIP_STATS was first introduced [1] to skip AF_INET6
> > statistics from interface dumps and it was then extended [2] to
> > also exclude IFLA_VF_INFO.
> >
> > The semantics of the flag does not seem to be limited to AF_INET
> > or VF statistics and having a way to query the interface status
> > (e.g: carrier, address) without retrieving its statistics seems
> > reasonable. So this patch extends the use RTEXT_FILTER_SKIP_STATS
> > to also affect IFLA_STATS.
> >
> > [1] https://lore.kernel.org/all/20150911204848.GC9687@oracle.com/
> > [2] https://lore.kernel.org/all/20230611105108.122586-1-gal@nvidia.com/
> >
> > Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> > ---
> >  net/core/rtnetlink.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> > index 8040ff7c356e..88d52157ef1c 100644
> > --- a/net/core/rtnetlink.c
> > +++ b/net/core/rtnetlink.c
> > @@ -2123,7 +2123,8 @@ static int rtnl_fill_ifinfo(struct sk_buff *skb,
> >  	if (rtnl_phys_switch_id_fill(skb, dev))
> >  		goto nla_put_failure;
> >
> > -	if (rtnl_fill_stats(skb, dev))
> > +	if (~ext_filter_mask & RTEXT_FILTER_SKIP_STATS &&
> Maybe parentheses around this first condition?
>
> The size could be adjusted accordingly in if_nlmsg_size().

Good point! I'll adjust the size. Regarding the parentheses, I can wait
a bit to see if someone else weights in. I don't have a very strong
opinion about it.

Thanks.
Adri=C3=A1n

>
> > +	    rtnl_fill_stats(skb, dev))
> >  		goto nla_put_failure;
> >
> >  	if (rtnl_fill_vf(skb, dev, ext_filter_mask))
>


