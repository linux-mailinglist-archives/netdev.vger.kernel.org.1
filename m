Return-Path: <netdev+bounces-160017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01645A17C84
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 11:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7521318840AE
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 10:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8585B1F12FD;
	Tue, 21 Jan 2025 10:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNxdEDFn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49451F0E4E;
	Tue, 21 Jan 2025 10:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737457003; cv=none; b=mKUFxfbjeezUpIxcE2G0xxpqxf5f9UVb5P9t49eF5epSI5LlE8BsO76l/jcxsW1HdPaQY/tn+TzPHS+OKYcbhH+aIqrTG1L6voZFhB4fOOFXsBO5pf0vMGMOeoqAtNV3dPOTGC/Bke8JpgMfqtlaRg5zNNFHs3CqZDSGqHk+Sno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737457003; c=relaxed/simple;
	bh=KuuY5pVb5eGjmHEbfnPTfZRlH4RQvSPVNOzGzVS6nfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fp9+GAkgDkwoBcVyujnv8K4PKB1wVPkk4z4l2sl1eTFF4iJwf8lmM5MYcXOA73mTeXc/oCU9kPjw9zvtnpdu7gM6iM+85rqw+CQ8SgyMu9VnCnFjI2Oh21+09nN/NXtDn9AeHhr1YQv99NtWogiAGHcngt++5/Q4LCr8MoZO1Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WNxdEDFn; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-84a012f7232so206445539f.0;
        Tue, 21 Jan 2025 02:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737457000; x=1738061800; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vh9vdl6b+Wwdbd8t2MqPBQqSVRZoOP68YbEuju1wfEA=;
        b=WNxdEDFns0/K4hHSMpbBq7iQXcx/4qijENh+Ja0O+O/6m35FxEBEcQ0M+eFJxy5dOi
         xR0BdGlAhfiKgcvAYEwClHj1Hn9qH/rsY+WEFPLhrObDoIvtl5JzRa6ICG9vOErNCYzR
         DqrhQdaFnOVzjj5lpuw2l/lNVgBgaCUV6LDRfLSxvuqmuKJubY0ZbSjZ5T1n874sW2Q8
         X25BtVRPTteftw8BBzAvcewye8JfS0jRgYKDrH2FJ5sKS/6NlS353oVqAEid/zXjFUU/
         Z+GDgGM4pUdPJCilcW640dFTQGM/k8WvEI9AHx8PgOZCTeTIQFUXVS/QZf4u/c8NGvcO
         1k6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737457000; x=1738061800;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vh9vdl6b+Wwdbd8t2MqPBQqSVRZoOP68YbEuju1wfEA=;
        b=tvn+Aruz0Ayt8+d0SZ+VCimt2zz3d4sHEClzkxKIvTJqW9xWjyiz6bNQgyk9fNRsu7
         6dyn6DKnkonjCxrDtQI2oo8btGp7gxNuU1a9Je3Rggr2qw2ToV1ZcZ0KWgiIMhYV7MnL
         ihLldJAKU8lq6hU9lhyTFkyWEG7LmnS4sLgIqLvMOQjn8L03aqNP1UOLYQ1w8Xwsg+BC
         ARI4ovog/xYvL6IxUrkrn4VGYLl/D79GWrodFp0BaCrJ5drm7cLrtxpuODXd0FL6xeVF
         6IwHZ/XV+QWGC0qdlhrLBR2bFbeCgjt6noufyMGMdQyt7vmgFXGt2J2HaEiNKdqgGgfc
         grEA==
X-Forwarded-Encrypted: i=1; AJvYcCWVNJg2lttglBlcthM7SsAE8n9telW+rSJ05ufJPQXm0aDkzppBMM0c/Gid7OktAP6kGdNOTjgmNLY8tJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeH8llNFly0roQ8YIBese5VCjFqtJEFiazGPDLu6u7xyDc+7RI
	0DcqZpDa5BIxsP0Fi7fY+kq/tH2OYdXyBFezj4hOH31FiwcXnE373Mh7gXBb/UoOVU5UtnMrNXw
	1Phs5rpxeSMIzsfruE9ML/LsROMQ=
X-Gm-Gg: ASbGncsLHXhbPnIJXveTOBpbtAvJV/bgvu6pK8MkKNFnSQ/BO807p6k7S7InPOkeKgw
	kYChWUUT+HbbSg5MbcXPH82vYC62FcUNq237q0JXaK8/LSFUIbw==
X-Google-Smtp-Source: AGHT+IEbAh91FukIr8yf8Eo9A8Hrdjt5Wkpd/TP+/u/bKuT2W/46gk0fit1nfnnLGtnQ6nlUtI4yagtnYzgi8a7/ZZg=
X-Received: by 2002:a05:6e02:1a0c:b0:3ce:7faa:3d3f with SMTP id
 e9e14a558f8ab-3cf747c7ad2mr117784465ab.3.1737456999869; Tue, 21 Jan 2025
 02:56:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250119134254.19250-1-kirjanov@gmail.com> <CAL+tcoDVTJ8vA_6wBd6ZDh2pq__fwJ9vzm3Kx5qpMNvaxpObjA@mail.gmail.com>
 <CAHj3AV=wkJnX5rW4jdFycf6vtm1vW2a+gVNAcTnnaR7JqsPEeg@mail.gmail.com>
In-Reply-To: <CAHj3AV=wkJnX5rW4jdFycf6vtm1vW2a+gVNAcTnnaR7JqsPEeg@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 21 Jan 2025 18:56:03 +0800
X-Gm-Features: AbW1kvZvsHcdCwYOnedppUbxs6Gzq34cjXYlw2ZKRcu71wK6DhqvLmlspYRbmog
Message-ID: <CAL+tcoAw+KvJuhvjrdVEBD8EieSB0trJ72+YZvzb5YYCt6TAqA@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] sysctl net: Remove macro checks for CONFIG_SYSCTL
To: Denis Kirjanov <kirjanov@gmail.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2025 at 5:17=E2=80=AFPM Denis Kirjanov <kirjanov@gmail.com>=
 wrote:
>
> > Please take a look at the commit:
> > commit b144fcaf46d43b1471ad6e4de66235b8cebb3c87
> > Author: Kuniyuki Iwashima <kuniyu@amazon.com>
> > Date:   Wed Jun 14 12:47:05 2023 -0700
> >
> >     dccp: Print deprecation notice.
> >
> >     DCCP was marked as Orphan in the MAINTAINERS entry 2 years ago in c=
ommit
> >     054c4610bd05 ("MAINTAINERS: dccp: move Gerrit Renker to CREDITS"). =
 It says
> >     we haven't heard from the maintainer for five years, so DCCP is not=
 well
> >     maintained for 7 years now.
>
> Yes, but on another hand I see that it's evolving, like MP-DCCP and
> the according ietf draft
> here: https://datatracker.ietf.org/doc/draft-ietf-tsvwg-multipath-dccp/20=
/
>
> Also there is a out-of-the tree repo available with the implementation
> of mp-dccp:
> https://github.com/telekom/mp-dccp

Interesting. Thanks for letting me know. It seems that we have to
remove the deprecation warning...

Thanks,
Jason

