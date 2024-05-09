Return-Path: <netdev+bounces-95059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECEDB8C159D
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 21:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A9F81C21239
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 19:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438627FBAE;
	Thu,  9 May 2024 19:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zDthsi/u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9132E80639
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 19:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284031; cv=none; b=aS4xwjx3lDgmjjoLzVynd3JkoJeBpuijC7a72nDrQxpP9KjqtY3NEQNnIyFuHriQpR4s8QI9hi6choa2LJ3A1vIYIbp7dCU/bEO3WAuqi2xIifPIRe6I57Huk9tcCp+3dhSqhkvFEJRddPSgKBfpba5IWIM8eCXwBepi6jyXGmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284031; c=relaxed/simple;
	bh=ZiH1zPLlQKa/SRZ6lleNveigp7s/byE/uEd8dR3ontI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nB/kN7nDAdz7r5ZbAEINJ6GBe15pC0TsTZqvKFE7A93sRxdQKB0l8Zs8EGF2XIOIpng5xTOgsIRh6F6JTsmv9kxzReEVKyY+aMHUCvemcsEiyn3EV8K9n6enj/NuqYCdUEfjj0zrbN/LasmASN9LJhlhbTXkzrYZNUWmxHQiR9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zDthsi/u; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-572f6c56cdaso4162a12.0
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 12:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715284028; x=1715888828; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZiH1zPLlQKa/SRZ6lleNveigp7s/byE/uEd8dR3ontI=;
        b=zDthsi/uFefA3vU0zxVyd5oD3GKW6tIz5q8mQOFUIpQdKMOB5Pcu0Gra4nQhXPkbfp
         /ei+P+KKk2LKTC19suROWTPO9XPgrHDMV1XYgjFgNXKYm3MTnS0G3E+gXQAEtHK+SyBL
         J37l3WgYwKpXqcYQOJr2SUc/zgPP+K4WNljPGf9AdXYhwm6sQFPDRJf3Oxa0hFrnHPrR
         dl1JyQRjzTIbcNb7+SLMfZwVJm1ZDytTF+iPtSxYBJXov9WZsaenclUD8S04AkEsifK3
         +prBETPCmvQDf9g6afiY5DJuO1xK+lAnPmQ/FdFORIyfuoNFfiElEkAuIg2InBcVXr5G
         cA4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284028; x=1715888828;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZiH1zPLlQKa/SRZ6lleNveigp7s/byE/uEd8dR3ontI=;
        b=bLicvfnoPcLFZFh7nV21kviXp39Beo/1C2QbScuxx0CPLqldAYV+S+YTIA2ZgXhh3g
         D9t13mA9oIdIv/nnH22VLLkPoaFVTYJjxoL3kHMucabQEZEQ1Km830KVCatQUGTbIxF7
         r+yii8sVvJh8ADfCjREbbEsDdwnZecNDXjs+ZOEBNwGFS4H9iqzXOelVgZbuJh3N4In3
         5RbB2WSJvISiRW7C4lBt3n0LOrbj6sjLWGQiAW5mHlKnpDqGnHqXBKDtE5FzsEB6VcGY
         dAfblSnkGPveyco9S8W3HylGW4pi+5xQkkjDCc5dW+E4sLy1/XS0ks1aT9xLcoyveaGa
         MM4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWbCrkLvIEJBmPCqXg14iDucPVCDHMovLMrZeVxwUYA+TqqopQpCoXwhPJFNXUP5GGWT2BVf8308BsD2LOHcMDzJoCrsvoV
X-Gm-Message-State: AOJu0YxjPv3te37DErlvWMmwdFo7p8t4q8Kv03o5SJaIEVSlwm2oj2yx
	4F0ibXOUKkvGT1q+E42MKIzdB7UD8BRa99r5q0cvufErC/W+n3JAY8Zokc7RA22LRYFWTTuI1Zs
	2QqX/itLaiqEWmM/uoEwgIL1PFzDsZGz56wqW
X-Google-Smtp-Source: AGHT+IEZCDgbWkHGbZwcPCGwWduTsdt6r5RS+/glnkO4xpsrY20S5rSV2bbITuAGJGCPUGiYgD9i4gF1ZL/L0ggFKWU=
X-Received: by 2002:a05:6402:2267:b0:572:57d8:4516 with SMTP id
 4fb4d7f45d1cf-5734f603ae7mr39067a12.2.1715284027577; Thu, 09 May 2024
 12:47:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240509044323.247606-1-yf768672249@gmail.com>
 <DS0PR10MB6056248B2DFFC393E31B4A1B8FE62@DS0PR10MB6056.namprd10.prod.outlook.com>
 <9aafe0de-7e46-4255-915e-2cf2969377d0@davidwei.uk>
In-Reply-To: <9aafe0de-7e46-4255-915e-2cf2969377d0@davidwei.uk>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 9 May 2024 21:46:54 +0200
Message-ID: <CANn89iLfj3fPmCC+3-ZfAAvCMVh=E3j3xTAu6At2wdK2MK0-=A@mail.gmail.com>
Subject: Re: [External] : [PATCH 1/2] tcp: fix get_tcp4_sock() output error info
To: David Wei <dw@davidwei.uk>
Cc: Mohith Kumar Thummaluru <mohith.k.kumar.thummaluru@oracle.com>, Yuan Fang <yf768672249@gmail.com>, 
	"davem@davemloft.net" <davem@davemloft.net>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 9, 2024 at 8:09=E2=80=AFPM David Wei <dw@davidwei.uk> wrote:
>
> On 2024-05-09 10:29, Mohith Kumar Thummaluru wrote:
> > Good catch! Thanks for this fix.
>
> If this is a fix, can you please add a Fixes tag? And in general some
> surrounding context in a cover letter? Thanks.


I do not think it is a fix, and I am not sure we want this patch anyway.

/proc interface is legacy, we do not change it.

Please use TCP_INFO or inet_diag, because
commit 5ee3afba88f5 "[TCP]: Return useful listenq info in tcp_info and
INET_DIAG_INFO."
took care of this in 2007.

Already in 2007 we were considering /proc/net/tcp as a legacy.

