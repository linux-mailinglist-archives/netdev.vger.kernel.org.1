Return-Path: <netdev+bounces-132316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF6499133E
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 01:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E871A1F242AA
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 23:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1688B1547C8;
	Fri,  4 Oct 2024 23:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksFxmUkx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A041514D299;
	Fri,  4 Oct 2024 23:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728085442; cv=none; b=pzrUwHrOa0klHmu4KK5aI0OCFAgYxqmICjo1ahAWBgEEtehvjT4IfeM58eQRjtgWQDOseO7R1X+Hy5uaGJe3cXE4Rwz/AFv65g16ZS9uGNYLntzT7P3hLtO0RVX8IuUScrlJwHeHUPsFFVMyo2tpSTDHcQqzxg2zIMe80uoHH30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728085442; c=relaxed/simple;
	bh=OUxaZuY8ic7WGFEDvWFfvjip/QopsHOu/8/nlWZQbAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XE68G1tJmzLQXvgQvC6whXURnY6Y2LGkhU7SPuewAeqwwZ1IX5rc9EfNGCnhaBNx9zsMgOK1J+Ktb1uotJsaxD7DghGeurKKEvwz5kcZ+3KdCK5uVOvPlGGXHOkWpeM/uC4FhPgKwhy9RLtkXVXBp2O8bx+vgvhFqO56n1zxpP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ksFxmUkx; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6dbc75acbfaso23458287b3.3;
        Fri, 04 Oct 2024 16:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728085439; x=1728690239; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Wk5bK0hzjw1W2+MwCw9cbBC7uwCJBJPCY/t6d3ZGjs=;
        b=ksFxmUkxtDJ3n2ZpmQXIB4MAdovVPowbcflAsuY7gKTfdbQCrDznxDEMgPt6abaAxB
         n5DFlyPlgRHxgqO0LJGs81rioGxLTjI+Xc/yh+wauufC+TFLIA++fC543K/73l5cGMgw
         R0oNEFzR4CXd+z9U9Q8AEekODVUgLk5EcFdQyGNySrVfVnTO0sLTrKjMFyaIVwdLt1BV
         /QTTLY0HU0PYQ6XdPtgz4KAT3pJHAlGS0bfQtpaZh9r5F0AIdZzZegRYltOXeBa/XG9Z
         l2Ak8h+sodOc7AeTOWD/3TYLNrlFpobNB6ltltH03qytWylblbUPa8AUYGD05vWwY8+t
         4D4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728085439; x=1728690239;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Wk5bK0hzjw1W2+MwCw9cbBC7uwCJBJPCY/t6d3ZGjs=;
        b=E+Ve/q3Fr7edon1BFORivIBPW57DKC52Whb1cX4E37NIQ6++hUeWt3XYmmdmCFDswF
         HND/eCfeYJfuINaGGw6bgCM6C7BuO+rG85UlXK31ITcAJ6JVhrb4zw539xZ2z9w2Tv+p
         yo0qNbxP/tkiSF0JQUx5HDpNzCHKGMLjWOb9WUlxyHY6vqV2+XFIHxuWj37DrC2nbx+d
         LcVJZt9JPXKQLjixsQ6u7FXyRDfWwepHYPgqXIltTZF2bIZaTXpNkiaIqEO4EKm1w0+3
         SVGWfe9vr2Cp2Bi0CdZQ8xfY/z1tFz2YeZEfZZtzhrSFWECpPWDeOyzraDEmuXvB3IPa
         i3gg==
X-Forwarded-Encrypted: i=1; AJvYcCUifeIYkLzHJgeysbWIIOuUmXF6ee7VPB32M5hYcZm1O2sIVCz0OkrkOp4H0CEIBjpzmj/J7PN7trB/G6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxenatMbApVdItg1RkH5/M24T47/NgYwmpXrW3NgghhHt5xoFO
	8aGja/A748LYBLxJv5rqlF1YCNiBLumNMBG/EXyD//ZSehCs6rWtFgFdNFcI21SXI0nMe6gBNv+
	0cdzEX/fMFxE3AGPtj52gtvrrWno=
X-Google-Smtp-Source: AGHT+IFN/LbcP41zeoX4ForAz3NmGr56y19ZxkRmueBkfL1nSRWhqccBGXSCxG/reAk+YFciHUnV3OHvte3MB119vcU=
X-Received: by 2002:a05:690c:26c2:b0:6be:3601:7189 with SMTP id
 00721157ae682-6e2c7014e8amr44820367b3.10.1728085439656; Fri, 04 Oct 2024
 16:43:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003021135.1952928-1-rosenp@gmail.com> <20241003021135.1952928-18-rosenp@gmail.com>
 <20241004163613.553b8abe@kernel.org>
In-Reply-To: <20241004163613.553b8abe@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Fri, 4 Oct 2024 16:43:48 -0700
Message-ID: <CAKxU2N-F+Gcv_LVvH5uB+x5gGABwzFsvxZOg+ApQ-DAHaFz3iw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 17/17] net: ibm: emac: mal: move dcr map down
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, linux-kernel@vger.kernel.org, 
	jacob.e.keller@intel.com, horms@kernel.org, sd@queasysnail.net, 
	chunkeey@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 4:36=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Wed,  2 Oct 2024 19:11:35 -0700 Rosen Penev wrote:
> > There's actually a bug above where it returns instead of calling goto.
> > Instead of calling goto, move dcr_map and friends down as they're used
> > right after the spinlock in mal_reset.
>
> Not a fix?
It's a fix for a prior commit, yes. 6d3ba097ee81d if I'm using git
blame correctly.

