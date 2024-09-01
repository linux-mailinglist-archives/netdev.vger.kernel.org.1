Return-Path: <netdev+bounces-124048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CF096768C
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 15:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 994FC1F21A1F
	for <lists+netdev@lfdr.de>; Sun,  1 Sep 2024 13:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41244156F33;
	Sun,  1 Sep 2024 13:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mypsq01o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC9B37708;
	Sun,  1 Sep 2024 13:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725195761; cv=none; b=kjSuPaEOmhj6xd0S2vYcLyu9pvpckVGnxkn8Jo2Z9M8bS+pixxMjkCWhDc3E8WO+DYiO/EBmHZbrgPqe5LFx2jhlvtOQqGyKTfwhabwo3xoKkjVOvVGLcjznYDRjNK5by6O0tn7BTBstO3k55cV/I0A9asqefUYDkkoc1DPN3Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725195761; c=relaxed/simple;
	bh=TSer0PPtn+1Va9BxG0qrecOWmXfeBUQ/kOnt/gzKu9w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mEygzm/osZ2i/ICOsVTaE9iqgACPkRvXjHflBljxfL825DTs4OrW5Q+OIystOJorg0oVjfPOXtECVJFDn0ptFHo0gz6V4LdI6IaqoyPGgqcf/yDy4FUz5Si2k3PGiw1pWU9T6vB+NzKinBAXdn2mWZbV29FuAAWkYTg6HKL7JDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mypsq01o; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-6d61adccd3dso3534897b3.0;
        Sun, 01 Sep 2024 06:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725195758; x=1725800558; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jDr6VTNkdZ3YHtJBs0x+xHV2UkyJ4karV0Eza8NagFg=;
        b=mypsq01o/bwNwUstKDJ9u3IvAlF1lfT19xftsh7BvPKu4+3+iVfsjKpkQAYdZjTE4e
         5BYPBXCdfhx3bKKcV7BfxdREboxwUBWqaVpvnsDYYyz3Hu23GOClImOUzvRbK+zFcliP
         bGUDCLtW1oRYoudNJ5jlk3oytN5QRN3A4WXo8+FHVoHezShkv2DV8RNF+lpPKmkR6tGH
         XZVxk1XC/v+ucsHyO51gu3vw075vmAbGcPw5DhkDdYjxZBrzeW1dLU4k0S6CvtNziqEL
         bJrWYqWOcJydskJkY498G+SjszCbowUBt70XxLp5phEFArS4ulu2RAuPWzQeg//ayeJr
         1imQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725195758; x=1725800558;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jDr6VTNkdZ3YHtJBs0x+xHV2UkyJ4karV0Eza8NagFg=;
        b=VN4OhpCl1PvR9Reg+qKkWe+nMAPk1vGLP2qbiA5b+TI5KWmF7JnqQkOgewSf/jS87E
         bnxMX/fnUIRLoHcRb+rQV5Q+LNTTqGTYSklBzKXGV4Ht7uUaTZSIAjZMsfBG1yPlMNpl
         jf2J99/+lFnVNue+bhP/LE4f+ZpybcKQQIE3J2og0Xp99nNs/prmFTg7aHf4At1QsAZw
         3URF3quRG+/Eft4QyI3hvSjQKjBAXsh12kjCtKZrwF0GiUxyrBbBnKVBGUQBKEy0a05/
         xRxQZChl0so/7R2bvKo0yi61ZhtPDS8H/u5gEWVlT7sxolkf0DPQ9XD1tdnH4SYgMNbj
         vs/Q==
X-Forwarded-Encrypted: i=1; AJvYcCU6z/fsmoH9K1Vft30T672QQ6w0cs9RUUIZXN3pEiQ/z7HXXYLMg9LNZ2M1kZAgRDIupwcuQ6DsYODXHbg=@vger.kernel.org, AJvYcCXAqKbOtz5pM8iND3CqNhP+hcsUE3TkvO3IgEdmYKNeUaK8LtIS2D8KmQOeLa0g0FtT0uSL6X5j@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9KH5lSNHzxTDGzhoH5BX8RaDPQCpdCks79+/jcA0A+Y6TARgh
	K3ZtbNioTmcoL85aIYvbO+mp2Icsc0fH2LMBCxIjcAf/LdJycpca4ruVecxE/SxP/KfrLfUpvI7
	dzUQVzG+FWZe5OsdfyplzDJbIdvI=
X-Google-Smtp-Source: AGHT+IH2Dbgl2tRy53adjNclUXSMehb8Dpum6U+2jAsLFni3eiOtHNhqhA/yWJX6UTExWDj3dHTv96D2SWE8gCCaTq8=
X-Received: by 2002:a05:690c:3503:b0:6d5:bde:d7f7 with SMTP id
 00721157ae682-6d50bdedb18mr37725847b3.9.1725195758468; Sun, 01 Sep 2024
 06:02:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240830020001.79377-1-dongml2@chinatelecom.cn>
 <20240830020001.79377-9-dongml2@chinatelecom.cn> <20240830153413.GQ1368797@kernel.org>
In-Reply-To: <20240830153413.GQ1368797@kernel.org>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Sun, 1 Sep 2024 21:02:39 +0800
Message-ID: <CADxym3Y98rvrS4NuUASG-K=CZ-uhXpNkgHDW27tX6vxGbsbY5Q@mail.gmail.com>
Subject: Re: [PATCH net-next v2 08/12] net: vxlan: use vxlan_kfree_skb() in vxlan_xmit()
To: Simon Horman <horms@kernel.org>
Cc: idosch@nvidia.com, kuba@kernel.org, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, dsahern@kernel.org, 
	dongml2@chinatelecom.cn, amcohen@nvidia.com, gnault@redhat.com, 
	bpoirier@nvidia.com, b.galvani@gmail.com, razor@blackwall.org, 
	petrm@nvidia.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 30, 2024 at 11:34=E2=80=AFPM Simon Horman <horms@kernel.org> wr=
ote:
>
> On Fri, Aug 30, 2024 at 09:59:57AM +0800, Menglong Dong wrote:
> > Replace kfree_skb() with vxlan_kfree_skb() in vxlan_xmit(). Following
> > new skb drop reasons are introduced for vxlan:
> >
> > /* no remote found */
> > VXLAN_DROP_NO_REMOTE
> >
> > And following drop reason is introduced to dropreason-core:
> >
> > /* txinfo is missed in "external" mode */
> > SKB_DROP_REASON_TUNNEL_TXINFO
> >
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> > ---
> > v2:
> > - move the drop reason "TXINFO" from vxlan to core
> > - rename VXLAN_DROP_REMOTE to VXLAN_DROP_NO_REMOTE
> > ---
> >  drivers/net/vxlan/drop.h       | 3 +++
> >  drivers/net/vxlan/vxlan_core.c | 6 +++---
> >  include/net/dropreason-core.h  | 3 +++
> >  3 files changed, 9 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/vxlan/drop.h b/drivers/net/vxlan/drop.h
> > index 416532633881..a8ad96e0a502 100644
> > --- a/drivers/net/vxlan/drop.h
> > +++ b/drivers/net/vxlan/drop.h
> > @@ -13,6 +13,7 @@
> >       R(VXLAN_DROP_ENTRY_EXISTS)              \
> >       R(VXLAN_DROP_INVALID_HDR)               \
> >       R(VXLAN_DROP_VNI_NOT_FOUND)             \
> > +     R(VXLAN_DROP_NO_REMOTE)                 \
> >       /* deliberate comment for trailing \ */
> >
> >  enum vxlan_drop_reason {
> > @@ -33,6 +34,8 @@ enum vxlan_drop_reason {
> >       VXLAN_DROP_INVALID_HDR,
> >       /** @VXLAN_DROP_VNI_NOT_FOUND: no vxlan device found for the vni =
*/
> >       VXLAN_DROP_VNI_NOT_FOUND,
> > +     /** @VXLAN_DROP_NO_REMOTE: no remote found to transmit the packet=
 */
>
> Maybe: no remote found for transmit
>    or: no remote found for xmit
>

Okay!

> > +     VXLAN_DROP_NO_REMOTE,
> >  };
> >
> >  static inline void
>
> ...

