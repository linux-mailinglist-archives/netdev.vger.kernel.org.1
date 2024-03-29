Return-Path: <netdev+bounces-83233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C888916E5
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 11:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADD2E1F2445B
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 10:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEC956455;
	Fri, 29 Mar 2024 10:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dqAG/k1T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AD655E4A
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 10:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711708393; cv=none; b=OZ+aiki6dqquidsHt8W0BwB2bcd7B5FtMlFKelnNz+wczBufD0Fjw4QskeDIVwFRa1WYLXMSES+0AUA/8Pi7lOUnB7IDT9MDblZ33trSvHccUF7BfaA4oOnaOaxtMIfSQYuPdE80GLmR0f2qE/0+kQcKKbsaaueacBXpuVpAGbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711708393; c=relaxed/simple;
	bh=DD6Jah54JvVvy/pv9fBbtNuZFBhf+OamddQ7th7HeoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tnLtR+J0Qn43XGnxgxsOruZ2swvtNXuhOUq6VpgYUfOgAFkE4/oWQnwt9FG6hRYJZo/s/KZP3KQVb04kenFos8nYfrFdHfEcr1aguEl4zTX1M/VevkHoBgyUH87gTQVAPZhDUQ34E0vKK+9RMigtyM+aPD8LOZ2WPu+NQt0j9Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dqAG/k1T; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a46cd9e7fcaso236869666b.1
        for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 03:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1711708389; x=1712313189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NwoDgUONbFIzKdwbbRbTYAlPST0Ig55g88KHArxxc/c=;
        b=dqAG/k1TZGFK4J69GU1sKJ28uJU+FZ/elLKmkiZyngpDgrYgKVxj4yV2jUlZI5ZYFh
         32lgdO1Fw9aOxq1q+Khep/2Ulz0y4+ctNTp/GvPzWdZj8m9vnMcMzo/3MncVQm84XNwl
         CwDkLkCBPpNDsbVWNWhWKcT3161witvdQJvxQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711708389; x=1712313189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NwoDgUONbFIzKdwbbRbTYAlPST0Ig55g88KHArxxc/c=;
        b=JTy1MT4jyHCqGiAa12U5OnpMfzFoumdzCbizOdRtJZG8YmkoOCA6a1tgYWiYSjky1G
         TO9C/xXJNLw+lhjUOD65Sd30abdZGYJZzJDA/wj44g60zK18AP+Dj3HwWQDzu9UyQHdh
         86clmTGTl/rogp4k+JdGYkaj8VBfPNYbQJnurqUCXXdSPNelJ8KHvkKKLwXLSSr4b4+k
         caWJHKbDNwaEJmeO4ZJKzAWf+fgTH4+6LE9fpK5GmYiMcIrkMf3DdFZW90FYNqtHWIRm
         aj5BHjQaIQYBEll2p0VIUZaamtvgdnWya7Ohv+PJMVLrnTLpwGzSk5Up2FB3WpUDYhih
         ukSA==
X-Forwarded-Encrypted: i=1; AJvYcCUvopBzMhN8A83F9SoylC4zx7zUAKeRIJiP2aUV8N/w8KWGCuOkrrnfwukmLYziWnvnnkKFM65vGZlesqdZsVxyMyN4m0yS
X-Gm-Message-State: AOJu0Yw3UmQfJZSprC3RCrSiJXwQgLoBHfvYI1IcTjnT+TFZx6NUaF1b
	dTR2Cpwb1jo9+sZbE3YLS1n2gxfpbFdsgmxGn9HTEOTkei/RSOeXCW1q3tAwOP28sKxsSHfsbhq
	tsDEorkF8BYUPZXfY5GZFsY+QzIyf6SiEwpMs
X-Google-Smtp-Source: AGHT+IGVGcA9bR6UFeCQVCvMVEPcupaxgap9YC4ODdnvUbwCtxUjIvbwg3uzTjmWUTuBUs4WUwHGNMCIfALbUmIQgiA=
X-Received: by 2002:a17:906:f58a:b0:a4e:3c1a:d6c with SMTP id
 cm10-20020a170906f58a00b00a4e3c1a0d6cmr709159ejd.9.1711708388649; Fri, 29 Mar
 2024 03:33:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328123805.3886026-1-srish.srinivasan@broadcom.com> <2024032945-unheated-evacuee-6e0a@gregkh>
In-Reply-To: <2024032945-unheated-evacuee-6e0a@gregkh>
From: Srish Srinivasan <srish.srinivasan@broadcom.com>
Date: Fri, 29 Mar 2024 16:02:57 +0530
Message-ID: <CA+1BbzyCr4sFS8qQ4U6g6mi-sD72y==ubBd2bxXiRLEvvx8-KQ@mail.gmail.com>
Subject: Re: [PATCH 6.1.y] net: tls: handle backlogging of crypto requests
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, borisp@nvidia.com, john.fastabend@gmail.com, 
	kuba@kernel.org, davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	vakul.garg@nxp.com, davejwatson@fb.com, netdev@vger.kernel.org, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Vasavi Sirnapalli <vasavi.sirnapalli@broadcom.com>, Sabrina Dubroca <sd@queasysnail.net>, 
	Simon Horman <horms@kernel.org>, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 2:53=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Thu, Mar 28, 2024 at 06:08:05PM +0530, Srish Srinivasan wrote:
> > From: Jakub Kicinski <kuba@kernel.org>
> >
> > commit 8590541473188741055d27b955db0777569438e3 upstream
> >
> > Since we're setting the CRYPTO_TFM_REQ_MAY_BACKLOG flag on our
> > requests to the crypto API, crypto_aead_{encrypt,decrypt} can return
> >  -EBUSY instead of -EINPROGRESS in valid situations. For example, when
> > the cryptd queue for AESNI is full (easy to trigger with an
> > artificially low cryptd.cryptd_max_cpu_qlen), requests will be enqueued
> > to the backlog but still processed. In that case, the async callback
> > will also be called twice: first with err =3D=3D -EINPROGRESS, which it
> > seems we can just ignore, then with err =3D=3D 0.
> >
> > Compared to Sabrina's original patch this version uses the new
> > tls_*crypt_async_wait() helpers and converts the EBUSY to
> > EINPROGRESS to avoid having to modify all the error handling
> > paths. The handling is identical.
> >
> > Fixes: a54667f6728c ("tls: Add support for encryption using async offlo=
ad accelerator")
> > Fixes: 94524d8fc965 ("net/tls: Add support for async decryption of tls =
records")
> > Co-developed-by: Sabrina Dubroca <sd@queasysnail.net>
> > Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
> > Link: https://lore.kernel.org/netdev/9681d1febfec295449a62300938ed2ae66=
983f28.1694018970.git.sd@queasysnail.net/
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> > Reviewed-by: Simon Horman <horms@kernel.org>
> > Signed-off-by: David S. Miller <davem@davemloft.net>
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > [Srish: fixed merge-conflict in stable branch linux-6.1.y,
> > needs to go on top of https://lore.kernel.org/stable/20240307155930.913=
525-1-lee@kernel.org/]
> > Signed-off-by: Srish Srinivasan <srish.srinivasan@broadcom.com>
> > ---
> >  net/tls/tls_sw.c | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
>
> Now queued up, thanks.
>

Greg, this patch (i.e. v1) has hunk failures.

Just now I have sent v2 for this patch (after resolving hunks).
Requesting you to queue up v2:
https://lore.kernel.org/stable/20240329102540.3888561-1-srish.srinivasan@br=
oadcom.com/T/#m164567a5bd32085931a1b1367ae12e4102870111

Sorry for the inconvenience.

> greg k-h

