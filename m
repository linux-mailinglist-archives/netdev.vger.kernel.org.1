Return-Path: <netdev+bounces-119404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F21695577E
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 13:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFD9D282368
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 11:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E86150994;
	Sat, 17 Aug 2024 11:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHzUCme4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f195.google.com (mail-yb1-f195.google.com [209.85.219.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964DA14D70B;
	Sat, 17 Aug 2024 11:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723894604; cv=none; b=NzZMgt0mQvo8FHm5BXZ2LoaGr+q54Sint9hDsDb/etlAsTirRtiXIm5wBSaw9HCXvBsdi1yqpx7Rxl43iJTdV7uCKh7kgLRmNTyJTZqswBfLo91K5e6uw10ZswhXGAmM5kFWCiMaFYMthTyJc6UUontoDHpkw3NhNECkpKC7LnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723894604; c=relaxed/simple;
	bh=zkZT8VZZft9eg4VK7YiFBpd65xUOib8cc9JrtLJddBg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ce9/XObAHvZ0184/o+n6b5lsHizRjUay7sJMVIkG65PNF7m7Jc6+pFY3gUjOqI1CF7TfDOWil8JpnlxmG6bM+cKsrjmZAnlgWtuWGM/8AJ/KgDOocwJ8UjUacdaC5AC/kM0iqh4kZqkpsq+pTVmNU/CEhS4uPEKVfJYR9pT7Rt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bHzUCme4; arc=none smtp.client-ip=209.85.219.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f195.google.com with SMTP id 3f1490d57ef6-e11693fbebaso3276168276.3;
        Sat, 17 Aug 2024 04:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723894601; x=1724499401; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zkZT8VZZft9eg4VK7YiFBpd65xUOib8cc9JrtLJddBg=;
        b=bHzUCme4+N98BKe6+jy+9tdxs3XKs7yFoAp4RLeoH91FdQalcP75DI20Vd6SoyP+kn
         BWzDALxm2EHyxwKxjic/Kjz6/XonUViewc9VTp4aGwW/L6GurwXJEMRdPdjxv46DPEGN
         X6HddLVzb1cCe/EFDdzha/RICOhDK9L6MJZWq/ZgVdRdrYE1bZr3jjFkybQaX4Qnr4s5
         LYTXaEV5Y9ZjtktpZQ4R1D1GXM4RkDFiM+5VmGdAxGHZtLMpdMZp5Fc/+pze0T12k/pw
         ugdVU1GIwuR4Ioonsm0QNGTJvpu+lbBmAmeSpQrZJCuPtqa3C1Fch7EGye67oeKUIQxk
         AhSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723894601; x=1724499401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zkZT8VZZft9eg4VK7YiFBpd65xUOib8cc9JrtLJddBg=;
        b=a8+3ISgW5n8A3wcmQym7mBLeetsb6yTfxnIr3X+Thio25g527X3WpwZmx1dAEk+vz7
         jd1TrxrBkeb9YM+LxytacbOgZ5lRLV1vEy9FV2AaZdtcYipK6mvF95mlL8auCLQIycjs
         PhPFc2jYAWXqfGDXA5m0L32ay5a7gGcS69rou9TpvyK/l5Dy+F9RxefPHUeSNxZHC1Qy
         WGeRJF1n4OU1vHRwiFj8TxMRb+whUYRTQ6qYItlroN13DrEmfmh6yfABIoRtPJqR+rSH
         VEYz6yK06EzocTn7mJxP93ECe+8goaXfWKn97kB7vTMw5jLDK1BeHEw2xQ8FnZ9/hsto
         xLYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJn9WFRAUhpo0Pum68IJNDWuzpjVVioWENz8UOhsNqFOhEBrDsLv3Et82DcZHqtn+1X9AS4Q/7Z9DDx8Xd0GMrryXYm/cFEZfZUNaNfAOeo99mXwbQMhIiT/HUHyam4MZLFrV0
X-Gm-Message-State: AOJu0YyMzMRVXfjYfMQfyuMCnjYddSK+T8a9VB20A1CN7bKzdJusWdKF
	caiEf2okXYmwsh/aud18oPFc9PiTDa1XNkfkAbel0U7+b/kwiwMlMS+H4Y6HuESA1CqJ4whXbNy
	VNUUglGxJq5nCk2bOPRrV8JQh1Ec=
X-Google-Smtp-Source: AGHT+IFPd7FvnLAxxdKLMPFiWeMxJJneT4UuXKWccUv0IemSV7CT3I9vIS35azlwWUt6HKej84iSJN8IhoO+OjAiwuY=
X-Received: by 2002:a25:8389:0:b0:e13:c773:68c2 with SMTP id
 3f1490d57ef6-e13c77372f1mr4100933276.51.1723894601357; Sat, 17 Aug 2024
 04:36:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815122245.975440-1-dongml2@chinatelecom.cn> <20240816180104.3b843e93@kernel.org>
In-Reply-To: <20240816180104.3b843e93@kernel.org>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Sat, 17 Aug 2024 19:36:43 +0800
Message-ID: <CADxym3b-cNL5KpyKFJeiW1Su7rCok5rXqMY+qg2R6MLW8O4qXg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: ovs: fix ovs_drop_reasons error
To: Jakub Kicinski <kuba@kernel.org>
Cc: pshelar@ovn.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, amorenoz@redhat.com, netdev@vger.kernel.org, 
	dev@openvswitch.org, linux-kernel@vger.kernel.org, 
	Menglong Dong <dongml2@chinatelecom.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 17, 2024 at 9:01=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Thu, 15 Aug 2024 20:22:45 +0800 Menglong Dong wrote:
> > I'm sure if I understand it correctly, but it seems that there is
> > something wrong with ovs_drop_reasons.
> >
> > ovs_drop_reasons[0] is "OVS_DROP_LAST_ACTION", but
> > OVS_DROP_LAST_ACTION =3D=3D __OVS_DROP_REASON + 1, which means that
> > ovs_drop_reasons[1] should be "OVS_DROP_LAST_ACTION".
> >
> > Fix this by initializing ovs_drop_reasons with index.
> >
> > Fixes: 9d802da40b7c ("net: openvswitch: add last-action drop reason")
> > Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
>
> Could you include output? Presumably from drop monitor?
> I think it should go to net rather than net-next.

I have not tested it yet. I just copy all the code for drop reason
subsystem from openvswitch to vxlan, and this happens in
the vxlan code.

I'm on vacation right now, and I'll test it out next Monday.

Thanks!
Menglong Dong

> --
> pw-bot: cr

