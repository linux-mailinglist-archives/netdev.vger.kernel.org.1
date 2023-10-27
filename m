Return-Path: <netdev+bounces-44717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D01D7D9591
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 12:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90AA9B21271
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 10:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97882FC04;
	Fri, 27 Oct 2023 10:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDkfIXfa"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B46479CC;
	Fri, 27 Oct 2023 10:50:34 +0000 (UTC)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E881A5;
	Fri, 27 Oct 2023 03:50:33 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id 5614622812f47-3b3f6dd612cso1162369b6e.3;
        Fri, 27 Oct 2023 03:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698403833; x=1699008633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9MErlHqrJrrDE6AqUxBfN1R9XRrV0hnUbUn1z87Hk1w=;
        b=hDkfIXfagMpxQr7DggTRBPqHFypVWPLBcd5ud0MeSiciiDL5UGEqcC9M+l76Oe+3vV
         IXwDGtwmXD/ZW92Igb8GXkrZBVgDc9yx3ryNs6OCS2rF4I04Uub71VQeKmSgJ+O129xA
         vK15RmvJo/qLb0KlzVCI/yQZCvgKZSbPcEOZ0g9umWmKYgLW3/HgqNyXm1WTtW6qt6iR
         ch3FEWFEPXpeZloA1EqpubDILC/IeptHkHtXWc87iTJaSoFnUta3zMiA0S3kRILK9zW1
         12VdABSYO5LWDBnvVCDRqLmJSkYJdi9qqgZ7xEOJUqzg2GtCOOsqgRYnJzeoFD1SBZ/z
         9FZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698403833; x=1699008633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9MErlHqrJrrDE6AqUxBfN1R9XRrV0hnUbUn1z87Hk1w=;
        b=AkHRNFKoZiRTt6zU2kAo56ZgnXJRuXkBvv48WD2tugG1+c5LkgW8IzuBEGGVu/eMX/
         6lWfF1c29zoLORhByowMlTUdG/qFLN4UgtlKH88BitCUEUVVp/LXzloN5azp781LPaG8
         knq3qbX8qQe7i9QRhScJcnTcgyRvyzONrsQiCYINfrvqloiZnfYNPaMB/oEFpB36ecUC
         ghcnENzvAnTL2spMXPxZ5KEuXX6ZPE1OUiOc818rou+g+EmHeWq+fzqd/PEDgfQtP6+H
         sHJmtk5qmH4EHXOSqeouNKs7RIu6s/ebetnss3D2o47RdP19MX18YQfc/KOsocwzNryk
         kTew==
X-Gm-Message-State: AOJu0YytsnF2j1ytJz/+MN+dsjNaHCtpMJ/U5YVfU1Pk5BWeRLC2h6VY
	NMalKvzp6X9fvKvMSovH0+k7H1U/bb5IxL0NkuB3NelzNGpneQ==
X-Google-Smtp-Source: AGHT+IEw6S8BxHhmhTcOmDsR3kKdPoxjLi4msegMoPZj1z7yZhXh7ei0xgx1Wllv6y74RdJj23gN/h0S6xwk0KfSd4o=
X-Received: by 2002:a05:6808:20d:b0:3ae:5bf5:4ad1 with SMTP id
 l13-20020a056808020d00b003ae5bf54ad1mr2055558oie.33.1698403832872; Fri, 27
 Oct 2023 03:50:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231026001050.1720612-1-fujita.tomonori@gmail.com>
 <20231026001050.1720612-4-fujita.tomonori@gmail.com> <CANiq72n6Cvxydcef03kEo9fy=5Zd7MXYqFUGX1MBaTKF2o63nw@mail.gmail.com>
 <20231026.205434.963307210202715112.fujita.tomonori@gmail.com>
 <CANiq72=QgT2tG3wy5pioTQ9n416kksZrL1791pehwR=1ZGP52w@mail.gmail.com> <feb34b35-e847-43f4-824f-157b1b96c7f0@lunn.ch>
In-Reply-To: <feb34b35-e847-43f4-824f-157b1b96c7f0@lunn.ch>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 27 Oct 2023 12:50:21 +0200
Message-ID: <CANiq72=7Ptwb_Ks+ARUq3=6S4NLxguFM4nNx33fBqL1fjBVL2Q@mail.gmail.com>
Subject: Re: [PATCH net-next v7 3/5] rust: add second `bindgen` pass for enum
 exhaustiveness checking
To: Andrew Lunn <andrew@lunn.ch>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, tmgross@umich.edu, benno.lossin@proton.me, 
	wedsonaf@gmail.com, ojeda@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2023 at 2:07=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> That is not how netdev works. It messes up the patch flow, since the
> machinery expects to commit all or nothing.

Then please simply drop this patch (or improve the machinery :)

> The best way forwards is you create a stable branch with this
> patch. The netdev Maintainer can then pull that branch into netdev,
> and Tomonori can then add his patches using it on top. When everything
> meets up in linux-next, git then recognises it has the same patch
> twice and drops one of them, depending on the order of the merge.

That is only needed if you want to land all this in the next cycle, do
you? Moreover, it also assumes this exhaustiveness check lands -- it
has not been posted/discussed/agreed yet.

Thus, if either of those are false, then this bit (or the entire
series) could just wait one cycle.

> That does not work. Networking patches need to be on net-next.

I have not said the patches should not go through net-next, though.
And what I suggested definitely works.

> The
> stable branch solves that when we have cross subsystem dependencies.

Yes, we are aware of that, thank you. We are even doing it right now
with another subsystem.

Cheers,
Miguel

