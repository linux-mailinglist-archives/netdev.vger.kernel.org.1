Return-Path: <netdev+bounces-133129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8EC995121
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 16:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B8F7B2B726
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 14:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BBF1E00A5;
	Tue,  8 Oct 2024 14:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Idx/PBi5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f196.google.com (mail-yb1-f196.google.com [209.85.219.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252B11E0B7B;
	Tue,  8 Oct 2024 14:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728396411; cv=none; b=UByPb3TZcrc0v3GuDc6+JgqNNVuCqArlg37T7Vl56vnJ8y0fRPLVJDUHtwjdNHI/UXj5ydUS9qZp6bS4RhNTrMyajrmlcfTsyRjry7FjapGLlaR0iIpZc+g5LUNyVBR2oglLai9uzxDV30m4coq5kVDU0GBwCOJ4Q965nCydOK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728396411; c=relaxed/simple;
	bh=M1/Sjq3NcDepOzCF9wITVLr3J5m3rG69mFkBGOp6egg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MKhip2CAWzPW5UYkM7rap01ydde9EWUkuTerdRiwcjYGq0cnMQ1PyfWSWcB0UGSnjnRH4TOywPSBcZ2Y7OD+orVLz5yRghPiba5nFpei1w6y6UzOBmFbQbp+Fg21FMcQZcXELZ0cvUZ6Z+icRa7pOenUiYh3nI1ev1ErhSeXams=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Idx/PBi5; arc=none smtp.client-ip=209.85.219.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f196.google.com with SMTP id 3f1490d57ef6-e026a2238d8so5062020276.0;
        Tue, 08 Oct 2024 07:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728396409; x=1729001209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DFh9FYDjJJWN00wYCTddg6rfe9TPYl9D/R6XfDxh2j8=;
        b=Idx/PBi5bTfTVcFEpD3a7w9DrJ+8QZYcQcVHouOW4gM3gS8l1IFAYNMpgPw8cgEeKM
         05Tb3IqxLtKct8UWKzBAeD8xnUOF9Rz5kmGJM4tOmHc7U6GPrS8k1Gw1r2I9Wbw6BvbS
         ps28qOqHUvqu1wLfQPzUbzXksgVl17J+Nwjn0MdgdZ9qeDHwYHU2C314oSINSCdotaJ3
         l5hzL2qUo+qoLNdpNX1WI8ph4g8lM3bsW5SWBpfVI9+vMg/SKaYLbeQgBATvojac3Sc4
         Ujn1yGFUAcqsZV+U8N/+yONcMNTho1ho0RhLBZAARKB+4czfGt7gdRqDvPQomwvcKzWb
         offQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728396409; x=1729001209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DFh9FYDjJJWN00wYCTddg6rfe9TPYl9D/R6XfDxh2j8=;
        b=Z0pDaB2syOBSZ5XqAF+gl6z0qZCmyePaSjAme7KBRn4vlgiqBsX40kTfPx7HYzfKHo
         OjH4QArGkp/ApD6fOZ1Sp4euC7FZaA3CTFojYfcAj+cIKNnm4D3cUf4h59aASEKQWwvD
         DNmSwB8cfhLbEDv2Z2f4w9p4f7BSVrGk/0ZbzgMIaGaPQWn+xnUDNTFO7SYvcLlVOAwr
         7DIUei8peKRedkcVzR0gx6C3+bULfbp4zJ7mDLh9ADw8Cmwt4HIA9rapQNISGreiej5M
         6N1KQ7/vSildtTLfyAnY716g7dq4kbXVFVDfoxW2WISIzKGuYihG/b9spxomru6PESPo
         zOyw==
X-Forwarded-Encrypted: i=1; AJvYcCUluci8XosAVlbxGzY4EWsUTngaynxZoQcHSFKHal9skUOgvPfvoguyk1VFVcHCSpx/BdUWgMxUw6bBcjA=@vger.kernel.org, AJvYcCX7Vtjo1PpYr4oOn4tgy4GMVHC9swvg2BZivGo94aO//j+wgu65sSWojqP68xGExSjhL3MSfOJD@vger.kernel.org
X-Gm-Message-State: AOJu0YwV6wp3uynXSu4kUj9ADw1IHy4DCPWGuiTF8JkMgveuZeLh/nd7
	aTlYHsdn0H5mNWr0WWU23mCVrWG1d2HvQ4SM4JpiH4rvdt+R7yda7CSvwKCmjGGBq0A9D39ryM0
	aehIT0oXtKsmzFirhshberC7QJa0=
X-Google-Smtp-Source: AGHT+IE0RKvXvWbz8OAl0KUTSbrG71BLL8AIi1KT2+IEAPrUfc2wYCLwDM9oT8ECLh6NAQR2TxyRPi3N+tn52e1jWFo=
X-Received: by 2002:a05:6902:2511:b0:e26:796:e19d with SMTP id
 3f1490d57ef6-e28937e44dfmr12818400276.32.1728396409070; Tue, 08 Oct 2024
 07:06:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241006065616.2563243-1-dongml2@chinatelecom.cn>
 <20241006065616.2563243-9-dongml2@chinatelecom.cn> <20241008122845.GK32733@kernel.org>
In-Reply-To: <20241008122845.GK32733@kernel.org>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Tue, 8 Oct 2024 22:06:44 +0800
Message-ID: <CADxym3YWsVvfp9ygvnGTp8Qi8vMXRzB=FmcoYbafTO7he_eVUw@mail.gmail.com>
Subject: Re: [PATCH net-next v5 08/12] net: vxlan: use kfree_skb_reason() in vxlan_xmit()
To: Simon Horman <horms@kernel.org>
Cc: idosch@nvidia.com, kuba@kernel.org, aleksander.lobakin@intel.com, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	dsahern@kernel.org, dongml2@chinatelecom.cn, amcohen@nvidia.com, 
	gnault@redhat.com, bpoirier@nvidia.com, b.galvani@gmail.com, 
	razor@blackwall.org, petrm@nvidia.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 8, 2024 at 8:28=E2=80=AFPM Simon Horman <horms@kernel.org> wrot=
e:
>
> On Sun, Oct 06, 2024 at 02:56:12PM +0800, Menglong Dong wrote:
> > Replace kfree_skb() with kfree_skb_reason() in vxlan_xmit(). Following
> > new skb drop reasons are introduced for vxlan:
> >
> > /* no remote found for xmit */
> > SKB_DROP_REASON_VXLAN_NO_REMOTE
> > /* packet without necessary metatdata reached a device is in "eternal"
> >  * mode.
> >  */
> > SKB_DROP_REASON_TUNNEL_TXINFO
>
> nit: metadata
>
>      Flagged by checkpatch.pl --codespell
>
> >
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > Reviewed-by: Simon Horman <horms@kernel.org>
>
> ...
>
> > diff --git a/include/net/dropreason-core.h b/include/net/dropreason-cor=
e.h
>
> ...
>
> > @@ -439,11 +441,17 @@ enum skb_drop_reason {
> >        * entry or an entry pointing to a nexthop.
> >        */
> >       SKB_DROP_REASON_VXLAN_ENTRY_EXISTS,
> > +     /** @SKB_DROP_REASON_VXLAN_NO_REMOTE: no remote found for xmit */
> > +     SKB_DROP_REASON_VXLAN_NO_REMOTE,
> >       /**
> >        * @SKB_DROP_REASON_IP_TUNNEL_ECN: skb is dropped according to
> >        * RFC 6040 4.2, see __INET_ECN_decapsulate() for detail.
> >        */
> >       SKB_DROP_REASON_IP_TUNNEL_ECN,
> > +     /** @SKB_DROP_REASON_TUNNEL_TXINFO: packet without necessary meta=
tdata
> > +      * reached a device is in "eternal" mode.
> > +      */
> > +     SKB_DROP_REASON_TUNNEL_TXINFO,
>
> nit: ./scripts/kernel-doc would like this to be formatted as follows.
>      And metadata is misspelt.
>

Hello, thanks for reminding me. It seems that there is no
more comment on this series, and I'll send a V6 now to
fix this problem.

Thanks!
Menglong Dong

>         /**
>          * @SKB_DROP_REASON_TUNNEL_TXINFO: packet without necessary metad=
ata
>          * reached a device is in "eternal" mode.
>          */
>         SKB_DROP_REASON_TUNNEL_TXINFO,
>
> >       /**
> >        * @SKB_DROP_REASON_LOCAL_MAC: the source MAC address is equal to
> >        * the MAC address of the local netdev.
> > --
> > 2.39.5
> >

