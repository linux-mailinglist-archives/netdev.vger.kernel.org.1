Return-Path: <netdev+bounces-119382-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C95B89555B9
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 08:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B4B01F229EE
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 06:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE63484D34;
	Sat, 17 Aug 2024 06:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bIf+LVxj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606C2BA2D;
	Sat, 17 Aug 2024 06:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723875257; cv=none; b=qqjgrNUx/1md6vwytR6pJJGAsPCh5XM+xafkLg6VV44m+IF6CtOhOxHzOZxTySw2hpwvAdrRlGthZo0KZ1Xjfe+2XzO1kjRNesyUjtbP8al+sqUn36zmm1VV9FWyFgJsxWjKwi46Gy6BbnHtk2qW4gSxRzwA1+VoGvE93svASCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723875257; c=relaxed/simple;
	bh=O2+5tW7CY81kBnfqQuKgyEZcV3WxVfoq+0azIEwltY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JdscQbJ3x0MHynXfgefrm9227pdVai5sWjJqThyC8WcaJeIu+6MCnROHOO2S+jwP9l2+m5vUsrhnJD45kgXgDkCMp9h6lE0+uV/aeAvrt/VePLev/tjIYVJJgTmXW982yokp8TJoPH2TRhP+vQC3ACU8K6y859MxHksZLdGw8+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bIf+LVxj; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-66acac24443so28295947b3.1;
        Fri, 16 Aug 2024 23:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723875255; x=1724480055; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O2+5tW7CY81kBnfqQuKgyEZcV3WxVfoq+0azIEwltY8=;
        b=bIf+LVxjH9k83Qv0Pb1XVsnhgx1OtgjUbq6NbKcEvRIGxcnbMOcjsywhADGDa7k3QO
         gBBDB8D5wPh6swk/HM2tnSMPgRx7A+qapVwH/CKDpIctOLS+crouljaH189zxe/AcZSS
         TGAAYUw98eJXRSCY1YZICrImtvHzNlDt87ks5DBFgb4lwQYfWgTaEVFVF2vpY0Rt8RWO
         y71Kf5XwwQHLA9eFbKCuZ81L1ugxPsI0X2HMi5qp7y6wlhyKkI4BKpCSOAvQ7/+9P2ZU
         hmuezFEbal/zVBZWJ62iz8ZhPIUcrhcOqX6h00u6AwERZznH+zL2X6C9xaSIVCCbLQPo
         zrlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723875255; x=1724480055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O2+5tW7CY81kBnfqQuKgyEZcV3WxVfoq+0azIEwltY8=;
        b=DjDM/P+c9ah/sIXDBb73oqyLQmZX6J6E4rrifnafrYsyJAq7McQyONSqL78YyxdsyD
         24Gdpx9UJPkMXPhKdhqwla0vAB9e0HhCtofWgo6CaMw9JsLQXdDDJ9Ogu/FdZXQdVPT+
         /oaxx80Z1WYiycP8NYadxECNdXFzgAiTDUohUHaqVG2HGhPMQY6tvaKoXMh6ZZDC8KKm
         RvI01EKJBoYxbE0nKmwgfEmSC2O4sirNQVsyvTAMFc75OOSxtHVRq5wth5iPMLEVdZbA
         bdow3QWLbYiJ9zPnzPGhPJcdgDpnmapapyBTpLQAZ2JRp9mXBP3g9dAjNr8k1h3qjQNd
         R1tw==
X-Forwarded-Encrypted: i=1; AJvYcCVBjvpnfzqIHeEYBM+7k5EBBxY+jZO8MfRv0NSYBICxS7ZhR9r9VT+5RbcGJ2NtIrxYore8oNAUU9ynwND36PvOI0VogZ1419VscgpZhMwPGH2kKd838uLm0hdfsvIO46vW0ULr
X-Gm-Message-State: AOJu0Yyp9WVTEVniIP6mxkxpvVtIvRC+AzSDL4pOAX/tPpK7UAaYqrsM
	eDYpQ+BuMdG6D0NX/6OA/tBhmdKd4qnK61RgIQ9/dEO213Z7jesYo19aYKbzVxTughlNEdAmlIw
	10p0mLWruazd5y9+Z8T90iy09itg=
X-Google-Smtp-Source: AGHT+IHtCJdxmAZpMq/JDkh0BJ7FbGWPywUODJwNm8pz2t3BxvQAj5nLxbpuaZhQVcQ6ghr9G+S57mEuaZLKPkOggYk=
X-Received: by 2002:a05:690c:7487:b0:6ae:e4b8:6a46 with SMTP id
 00721157ae682-6b1bcf90545mr56471207b3.44.1723875255233; Fri, 16 Aug 2024
 23:14:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816103822.2091922-1-bbhushan2@marvell.com>
 <20240816190349.22632130@kernel.org> <CAAeCc_=C96vKw+Nta-62iQjc-yz-ZJdXvy3WtSByrOb8_A5Fog@mail.gmail.com>
In-Reply-To: <CAAeCc_=C96vKw+Nta-62iQjc-yz-ZJdXvy3WtSByrOb8_A5Fog@mail.gmail.com>
From: Bharat Bhushan <bharatb.linux@gmail.com>
Date: Sat, 17 Aug 2024 11:44:03 +0530
Message-ID: <CAAeCc_nJtR2ryzoaXop8-bbw_0RGciZsniiUqS+NVMg7dHahiQ@mail.gmail.com>
Subject: Re: [net PATCH] octeontx2-af: Fix CPT AF register offset calculation
To: Jakub Kicinski <kuba@kernel.org>
Cc: Bharat Bhushan <bbhushan2@marvell.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sgoutham@marvell.com, gakula@marvell.com, 
	sbhatta@marvell.com, hkelam@marvell.com, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, jerinj@marvell.com, 
	lcherian@marvell.com, ndabilpuram@marvell.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 17, 2024 at 11:33=E2=80=AFAM Bharat Bhushan <bharatb.linux@gmai=
l.com> wrote:
>
> On Sat, Aug 17, 2024 at 7:33=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Fri, 16 Aug 2024 16:08:22 +0530 Bharat Bhushan wrote:
> > > Subject: [net PATCH] octeontx2-af: Fix CPT AF register offset calcula=
tion
> >
> > There should be a v2 or repost marking in the subject tag,
> > and a link to previous version under the ---
> >
> > So that everyone can easily check that you ignored my question
> > and haven't even applied the spelling fixes I suggested.
>
> My mistake, somehow missed your email.
> Will address your comment and send the v2 version.

To answer your question "Does it mean something will not work without
this patch? Or it's just a cleanup of unnecessary code?"

Functionality is broken without this patch.

Thanks
-Bharat

>
> Thanks
> -Bharat
>
> > --
> > pw-bot: cr

