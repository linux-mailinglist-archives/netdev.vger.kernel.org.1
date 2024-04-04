Return-Path: <netdev+bounces-84975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 294CD898D79
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 19:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB4561F29299
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 17:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DBC12FB1E;
	Thu,  4 Apr 2024 17:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R0W/VEvA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AE912F387
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 17:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712252861; cv=none; b=mVMedqKGfPO99ZPpPab2g4BdiFKKQTZ+aw4/KkkDGaQqARG4GnMeFwTLHqClEyzZQ95lx72IELcNa3Gi2w1Nlh/pNokjGrHdgeIPQTxCsZ+k9KLT7fbvcODIPtXW6ZvUUYNKaT/OaSoB4uIFhQrW7r4Vfp2KXHHDdDLNFOwrUTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712252861; c=relaxed/simple;
	bh=eaePR4BVugpDhJkhCWR2pXdnXQi34rPxdpd3lI4KEhE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HNuUNO6DLnLRQFmAZZBrfjBAWeO5v5lY0EX8SVzn2O+6AKspponkegU98WFkyYvRhmNxGX6KR1qKoQQR9VbFDmg/eQ1Rdez3TIjBzD772gxDzhUf7iNEA5trxypEX5emeZFupIM7FkarbnDU6ZpX95mbX7AA7tQKsfME5/gaYns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R0W/VEvA; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41549a13fabso9825e9.1
        for <netdev@vger.kernel.org>; Thu, 04 Apr 2024 10:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712252858; x=1712857658; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hqErmvNLu/r9csWP4Xtsl2S2nXEJL4SwYijybP8vh10=;
        b=R0W/VEvASC1PSFWmbIVKyCG5klg1D1y1OXWBB+n6VLOm2jstR4rr3WhP9TzC+gWxde
         wmcRl8LabK/WfIZN4BWmCFH8hkgfr/qWrl7SGmq3itTAHm+SRYny/5S55aL7/QwOWYAr
         B0PtqH1aJMg3897oC0R5N/+HN+9WobUgFy735t+F1MRKr8+70C9cIrSrXQESxba+Tyw6
         KR1FQS1chmSM2EwCQmVWnwWp977gSEmQPPwVbS+CSkbUsHOQTXDqPWZ/R0F01KxOyuzb
         +HaZFEY4nIhqM3u+7zbAzuTaQBRR9SW8AAVMgFkSip5GuFYVciG2+IrN2EMNtSzasH+f
         ksWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712252858; x=1712857658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hqErmvNLu/r9csWP4Xtsl2S2nXEJL4SwYijybP8vh10=;
        b=qzElYjs+OtHFb89kEFIEq/KF3sp4u29ApyhA9CkYCAvWcbt0lKb+BH8hNkJ5svquB8
         i1rjfBw0io7fKPp9u4swyu6kJ1vsVAlLh4lhz5yFjB6WD0z5as+BXXOPcKarhbnICmc5
         fS0C0Gw8thAKiVyMs3bpl7lOrQrRAoYtIakBiKIx/0KNjHNjdztDGXiFK1VLlDrCNKpW
         mBxfQ0Md/O9arIoI5wMw4Brx+xU7ppDNSRPv+hUts67ICmtoy5y/+4loejvdIpiaGoSw
         seYekluawX5IjtU58AmklVXZh+xIQS1cH4RHMcrzMimV5xFgUKoec02a50nyqmDatxUq
         COOg==
X-Forwarded-Encrypted: i=1; AJvYcCUEdCvbxBt//03RxRrZWOQEky3S7E3xLEPM8v3o6SBwXF7O0rqYJBGIqCktG0vnEi5CZHLnxf1n1XhK5rsRWREempyVISmb
X-Gm-Message-State: AOJu0Yxwbq3+eqpgKu7LeBFjBZWIpGZ+8OO3XR8oHCmguxumcFh3kS7L
	RmEFy86Am1kvrZxGOn8KBdk/lFOJPwI7OG7gZOdpcUy3NMYDHS+DisuS/yleeV/GD4W3WBI8lBB
	wzishGYFyf+y1RS07gRFkiDRm0ZxdwczjpkKo
X-Google-Smtp-Source: AGHT+IFsCfKS09FM07GxIp1Hd2dX0c5LH/TqfCtOYUOn2vYemVUefQBK6ybZa8phmwFNIG5E1O8HWH0CLxBDKz+Q42g=
X-Received: by 2002:a05:600c:1e06:b0:415:6dd0:bfaf with SMTP id
 ay6-20020a05600c1e0600b004156dd0bfafmr167210wmb.4.1712252857631; Thu, 04 Apr
 2024 10:47:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404131126.2534400-1-edumazet@google.com> <20240404100035.3270a7d5@kernel.org>
 <CANn89iJxsJBj6tG7BQ2rDibcXnb-PSHREY_zKSAFcNXQacQO3A@mail.gmail.com>
In-Reply-To: <CANn89iJxsJBj6tG7BQ2rDibcXnb-PSHREY_zKSAFcNXQacQO3A@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 4 Apr 2024 19:47:24 +0200
Message-ID: <CANn89iKCBEdgu2Mc7UNrVVp6Cn4Tved2ZT_qWPPfJ44bcECJng@mail.gmail.com>
Subject: Re: [PATCH net] geneve: fix header validation in geneve[6]_xmit_skb
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, syzbot+9ee20ec1de7b3168db09@syzkaller.appspotmail.com, 
	Phillip Potter <phil@philpotter.co.uk>, Sabrina Dubroca <sd@queasysnail.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 7:09=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Thu, Apr 4, 2024 at 7:00=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
> >
> > On Thu,  4 Apr 2024 13:11:26 +0000 Eric Dumazet wrote:
> > > syzbot is able to trigger an uninit-value in geneve_xmit() [1]
> > >
> > > Problem : While most ip tunnel helpers (like ip_tunnel_get_dsfield())
> > > uses skb_protocol(skb, true), pskb_inet_may_pull() is only using
> > > skb->protocol.
> > >
> > > If anything else than ETH_P_IPV6 or ETH_P_IP is found in skb->protoco=
l,
> > > pskb_inet_may_pull() does nothing at all.
> > >
> > > If a vlan tag was provided by the caller (af_packet in the syzbot cas=
e),
> > > the network header might not point to the correct location, and skb
> > > linear part could be smaller than expected.
> > >
> > > Add skb_vlan_inet_prepare() to perform a complete mac validation.
> > >
> > > Use this in geneve for the moment, I suspect we need to adopt this
> > > more broadly.
> >
> > Something is cause the ttl test do break:
> >
> > # =E2=94=82 geneve =E2=94=82     4 =E2=94=82     4 =E2=94=82 inherit 0x=
3c =E2=94=82    inherit 8 =E2=94=82 false =E2=94=82./l2_tos_ttl_inherit.sh:=
 line 350: printf: 0xeaECT0: invalid hex number
> > ok 1 selftests: net: l2_tos_ttl_inherit.sh # SKIP
> >
> > https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/537382/6-l2-tos-=
ttl-inherit-sh/stdout
> >
> > Is is possibly this change?
>
> Let me check this, thanks !

Apparently __vlan_get_protocol() depends on skb->mac_len.

This field is not usually set, unless skb_reset_mac_len() has been called.

