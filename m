Return-Path: <netdev+bounces-217753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9630B39BBF
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 13:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEC161BA5831
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 11:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B601930E0E0;
	Thu, 28 Aug 2025 11:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e78luegL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04157260592;
	Thu, 28 Aug 2025 11:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756381160; cv=none; b=k9VkoZpvuv/UqMrQ1ew7FSFaJfiqWvzYfNC7ieqPkouPno5Vg8U7BOU7GHjoWF05mqbau1GuVUFBIhmYe8t11OG6pewbb/nv5TA990tna9yQAf08M9hvoI8AiTh5mo7b8K1zw2Ovgx7hCAApxcUg3awOgFPKGhDcBAJ0//UtXpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756381160; c=relaxed/simple;
	bh=32lnGp4lkPiIQG16uYgv0iwb9z8QnRiBWgi+huwiq98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uqhaPcA1gCJBZUzJ9HQa+7isQOJTeiTynRBfubTDqi3XRzYqg0IooZimN0UuqU/xeQj+SiQu3/X5311T1GO/TShL3UpYdnZGrAjo1HtmXhK0b5Dt63jjvQFfZP4oqzkQIP2obJDHYRDbTEdsq2MWXWvhLzJL6KfPrL8vY3I4Vi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e78luegL; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afee6037847so92517566b.1;
        Thu, 28 Aug 2025 04:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756381157; x=1756985957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=32lnGp4lkPiIQG16uYgv0iwb9z8QnRiBWgi+huwiq98=;
        b=e78luegLdrj9pfHxygrpFvGyapuVeoJ1fOZLDrNrdMxgIayxvMkrx7MPBpSXdq62+p
         veDrW9nznfHjtk3KO+XLxJDgI39i4QfwlPksWzksdsjV7Vpm5bBdBiSXzW8Uo0p8NyId
         KjvTT/FM1XkmGsCBRou2dfJ4UoNGIBpk4ThJZRoQdquPPZ2BnBnnppbrXCDaGgMiAOZ4
         6y9CfV/2h5+h/2xAoRldWpIgp+OoZNqZmrgx8bAfY/0+uDkY/ri9hG8l1O5sqNgHh9H+
         cCv6ioyx/Ll5gsM1hAjVYSti2sLO9e0E/+cqPKpRsWtVw1ZL4f5yZhl3YHkOh2z/cXYU
         8YvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756381157; x=1756985957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=32lnGp4lkPiIQG16uYgv0iwb9z8QnRiBWgi+huwiq98=;
        b=L1xk/aIknRdYZzdGx4lhfYJsg3cpHZn3SVnsz5WScJfmGkeXwLwJRZWyoFhh44C64j
         M6svIWENOOdjWG7lXcfzf5CgpvDssKFbWbdPjCd4X6uACIn38TfQbC4VvU0AmSBSOIg1
         tGOJbyJPU9SBog3YiOmW1ZF8+m4mYcaodzigdSquytF7k27fdghz7scEPh3HUPClb9no
         I+bPjbBQhJ0I1gd+q3c+nUa1O9aFQPwQoOtjpa1DiIrnAV7b06IjUesLR3BssDA4sWg4
         Qa297BGH9S26c7FDsgyTUrC1Tl5salKT1wrvXWQ0HERWwp+ZLFFzm0i9b13GaU4/Jkz1
         KrjA==
X-Forwarded-Encrypted: i=1; AJvYcCW1ig1SAn0JBV/hHMXF2+7+bqBWV+SZuHCYFdvexcw/hg3xp0aFGC6zGiRyXACTz/g9+PwR0WbH75L0NlY=@vger.kernel.org, AJvYcCWXi5ie7fYpjqGAcxIiuq3Ncm3/jEaIXHrkA3K/PzJ5WaRvQYqAMvD3gZ3p2ZDSzKOgsWNAXMqf@vger.kernel.org
X-Gm-Message-State: AOJu0YwFHaaFFDxhkM6Gr2+RjG8BOoSTGB2WUjmq8X89pwGIDO1V6B8F
	xwWopeqB86YwA1f1NdFtQUA5Tj1a6R++WCgsLbnJb/QfJEcC01jBZ+O9/ASlFXdJYkU1Z01o78a
	YOsq5gHwxHP/RX+fhAn2rz1Qc0p2Kyrg=
X-Gm-Gg: ASbGnctp44UQKqLb+pf/cZnCUOkDo3FfWJupDHuwqbZX+YVHrqfcjDvDstFR6KRsmaK
	MJEKv1JS+XcLGYW650Qa+QqnQzkzsjWwobjizPOKw0x2usIyH+S5xAvB4g/o8qAzM0yieev0l+P
	1E4jmHq4MPRwjF+0qRA5uHe4DcOt0pQEMPWNMzFElR5OIAKBDqHKWYyR2yHSDggFep+Bo029hG+
	mTQi1lteGvw7KloKe7+Q0QGUVq/lw==
X-Google-Smtp-Source: AGHT+IGZH/o3/ZWnUowQ1BIqtmwigFCWIn3F2IS+uL3bqn93Wy1CKlPLan+sf2rvYLelRLO9nIF8Muv/3x7fpKZTGp0=
X-Received: by 2002:a17:907:7ea9:b0:afe:11:2141 with SMTP id
 a640c23a62f3a-afe2953815amr2412568666b.31.1756381156530; Thu, 28 Aug 2025
 04:39:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANypQFbECe10JE9MKzdU3X7kehVDoHr0kGnQpK1CVMJrg+qJwA@mail.gmail.com>
 <CACT4Y+YLTF0bG6yJABOXg7zZt+1nV6ajHLJxSWzazSk2sH=tfA@mail.gmail.com>
In-Reply-To: <CACT4Y+YLTF0bG6yJABOXg7zZt+1nV6ajHLJxSWzazSk2sH=tfA@mail.gmail.com>
From: Jiaming Zhang <r772577952@gmail.com>
Date: Thu, 28 Aug 2025 19:38:34 +0800
X-Gm-Features: Ac12FXxtJpZJlZSZbFMYLNM5iLVnyn4qxfZp5SpXlursZxc9iOqGDqNUTLhd0dc
Message-ID: <CANypQFYzTMwpWHgn3sPwpP7nF3js-Q4gt7rFBBsFy494uEnB0g@mail.gmail.com>
Subject: Re: [Linux Kernle Bug] INFO: rcu detected stall in e1000_watchdog
To: Dmitry Vyukov <dvyukov@google.com>
Cc: "anthony.l.nguyen@intel.com" <anthony.l.nguyen@intel.com>, davem@davemloft.net, 
	intel-wired-lan@lists.osuosl.org, jesse.brandeburg@intel.com, kuba@kernel.org, 
	netdev@vger.kernel.org, security@kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

Got it. Thank you for the heads-up.

Dmitry Vyukov <dvyukov@google.com> =E4=BA=8E2025=E5=B9=B48=E6=9C=8828=E6=97=
=A5=E5=91=A8=E5=9B=9B 19:05=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, 28 Aug 2025 at 12:40, Jiaming Zhang <r772577952@gmail.com> wrote:
> >
> > Dear Linux kernel developers and maintainers:
> >
> > We are writing to report a kernel bug discovered with our modified
> > version of syzkaller.
> >
> > The bug was initially found in Linux kernel v5.15.189 (commit
> > c79648372d02944bf4a54d87e3901db05d0ac82e). We have attached the
> > .config file and symbolized crash report for your reference.
> >
> > Unfortunately, we do not have a reliable reproducer at this time. We
> > are actively analyzing the root cause and working to create a
> > consistent reproducer, which we will share as soon as it is available.
> >
> > Please let us know if you need any further information.
> >
> > Best regards,
> > Jiaming Zhang
>
> Hi Jiaming,
>
> This is likely to be a false positive. We found the default kernel
> timeouts are not really suitable for fuzzing. Consider using the
> official syzkaller-recommended configs with proper tuning for fuzzing.
>
> Additionally, v5.15 is extremely old. Check out:
> https://github.com/google/syzkaller/blob/master/docs/linux/reporting_kern=
el_bugs.md

