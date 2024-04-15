Return-Path: <netdev+bounces-88000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B01498A52C6
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 16:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B8FB286D16
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 14:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3B1574439;
	Mon, 15 Apr 2024 14:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2F/Pc/6k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9949674BE1
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 14:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713190305; cv=none; b=Ze758GVOi8WW9Iz4hPLiLAxiyXznrSYVRo0UtL+6GFnI8Xgflvn4vYnRZLiSf4TjaVuMkGirKWHBGh7hJOSGTkJoc00osfqyNFfgtLEQWY3p2b6zlla7cMzs1thULwm0jIL0mL8tMNrPA6+eopJPlBupHWT+kGEHU0VSiQVP4Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713190305; c=relaxed/simple;
	bh=N4NAaQUq5rreDG/VXcqdZ2Ipy2Gfrn8C9b0I3KMxu7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QXvA89thTlNT5kJupeWsfPVFFG1fP8w/Von8Ul8QMlgU1dhW2Imr4tTWeAekzGyOJRgmDPBC7EytNpQhG5Ab8n2wl8P990qEMji9cIKOPZzlO8/4JFIpWKaSTrM6ObJBkfJUIoAwj8pwcGY2BFNAmZ7GeCoqe/yBNyMtLRohH1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2F/Pc/6k; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56fd95160e5so12709a12.0
        for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 07:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713190302; x=1713795102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N4NAaQUq5rreDG/VXcqdZ2Ipy2Gfrn8C9b0I3KMxu7c=;
        b=2F/Pc/6kgHi7z8pVRAIpCxgNW1H8ANLqjZD23hdQsRQLcpX+Bi+GnHmvAfJ5zWLRmO
         e14TTWqQK/Vaw1YOWTzzMd/EeDCvK1uKSXFB9VtvODM2hseyGRfAlfhEHZVdnlbte7ff
         urtrbc5VP6LqKDjpOJyT9v2TO6j6Sn2VbtmRf7guEy2lfjemMjDjNhp3YimvabcPQdms
         YsA+oYv3UnIFOyTN8oOHh7f69FaS8ihMR7zF9E/BOX0jDlHQPUmDdHaYYIMw6QKj/fzv
         zCZVY1ArVg5aV6CD1/0AdWvvr0W2s3XpcUM/FEZOxZEMOX4CmxuCGLQ1DMVsfzmdh+Jq
         uR3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713190302; x=1713795102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N4NAaQUq5rreDG/VXcqdZ2Ipy2Gfrn8C9b0I3KMxu7c=;
        b=AbAvKM145FlLpY94Dqu35H3c/K9O1Iv21P8Q1VGURmcdSR1NX2DtAQuSnNCl3w2tvD
         18RAKnxMumH/NzuRu5rZLYGpggu0tb8tN3XpjDKFdzKAHhLIS1qPqEQDF0IKs8RBkFmD
         JiMnGaiAdDCf4po86ZY66fVIw81Jz4Cb5wbakX5EuAqnbh2aN6gYdbHTgUb3KHwYOCSo
         Q7faC6FBlzjmAptaCd2nS1nc1qY65miEI9hoZDb0G+6eeLXNOBQ3yMkHWKFE9loH5B8i
         S94d3EpBCOTqWlwRMkD+cJkH6hJ8JFrG+uFUa4FFCHwdHb+YT7/FVD+8CEgYvBvjJGn5
         hRkQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrc8xFzWYDM8E8wHoq8WvpJVwfpw61BoHoTMF/nqHzGGUf0IeYK/zRg0m2iwjK/uMAsh66AzapU+4ZkFbTRa+SX53RMkQv
X-Gm-Message-State: AOJu0YzZwS75V4F57txbZuSuDSijzGmjY6FIj6OFlxRqfdPWBlRnty54
	xx5uCLG5Xbq4ZzgrXjlpGBwBe+x6Gl45xrbzEd7FAwGlas215y2Ghghf0vkfV7TYqFO/prS0eha
	3x6X4bUhHXnP7W6pbC0yW6jf9A/OvX30F1xI5
X-Google-Smtp-Source: AGHT+IFiIsjJEZ9aHbBjdQlYE0Xqy6Mh8baYB1jP8c2v5v4NK5HpXDTX0t+sDjQmxAqWYJmHzCeD1n5a4SL30nB4Rpo=
X-Received: by 2002:a05:6402:5243:b0:570:2cb5:af32 with SMTP id
 t3-20020a056402524300b005702cb5af32mr152517edd.5.1713190301588; Mon, 15 Apr
 2024 07:11:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326230319.190117-1-jhs@mojatatu.com> <CANn89iLhd4iD-pDVJHzKqWbf16u9KyNtgV41X3sd=iy15jDQtQ@mail.gmail.com>
 <CAM0EoMmQHsucU6n1O3XEd50zUB4TENkEH0+J-cZ=5Bbv9298mA@mail.gmail.com>
 <CANn89iKaMKeY7pR7=RH1NMBpYiYFmBRfAWmbZ61PdJ2VYoUJ9g@mail.gmail.com>
 <CAM0EoM=s_MvUa32kUyt=VfeiAwxOm2OUJ3H=i0ARO1xupM2_Xg@mail.gmail.com>
 <CAM0EoMk33ga5dh12ViZz8QeFwjwNQBvykM53VQo1B3BdfAZtaQ@mail.gmail.com>
 <CANn89iLmhaC8fuu4UpPdELOAapBzLv0+S50gr0Rs+J+=4+9j=g@mail.gmail.com>
 <CAM0EoMm+cqkY9tQC6+jpvLJrRxw43Gzffgw85Q3Fe2tBgA7k2Q@mail.gmail.com> <CAM0EoMmdp_ik6EA2q8vhr+gGh=OcxUkvBOsxPHFWjn1eDX_33Q@mail.gmail.com>
In-Reply-To: <CAM0EoMmdp_ik6EA2q8vhr+gGh=OcxUkvBOsxPHFWjn1eDX_33Q@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 15 Apr 2024 16:11:27 +0200
Message-ID: <CANn89iLsV8sj1cJJ8VJmBwZvsD5PoV_NXfXYSCXTjaYCRm6gmA@mail.gmail.com>
Subject: Re: [PATCH RFC net 1/1] net/sched: Fix mirred to self recursion
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us, 
	xiyou.wangcong@gmail.com, netdev@vger.kernel.org, renmingshuai@huawei.com, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 4:01=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>

> Sorry - shows Victor's name but this is your patch, so feel free if
> you send to add your name as author.

Sure go ahead, but I would rather put the sch->owner init in
qdisc_alloc() so that qdisc_create_dflt() is covered.

