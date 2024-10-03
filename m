Return-Path: <netdev+bounces-131734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5943098F610
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 20:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C75F3B2207B
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 18:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E2A1AB52C;
	Thu,  3 Oct 2024 18:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knTvzU/l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6C51AAE11;
	Thu,  3 Oct 2024 18:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727980110; cv=none; b=O1V5VByJNWSb7D71Z+oF1mceVhdaHYnWASnhmdRvSmSD0Nad+Tc2NCrmMDH3AWTzV/I/dneeLa+T6wovPnB49s/xBm2ZxpbdPh4u//HEnngUVBAj3LlUygtiRHSYQrGHjDNWh3PC8YeJM1F6d+m8tRd/IqY658GDJsEBCBCTgso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727980110; c=relaxed/simple;
	bh=93gHCxkl+5Tkj032Uj3AzSyRM3GNWPMhtlpnWJX5M3k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cwM2N4xNIuz9ukLUfL266EAVKKhD1WEIMH9hnb4itfGpXaDRFU84+ELY9E9AltujC20Mb8rF9MKi5iyvAzWAPktm0UxBQLNwjktyifa07gYL+IsOzH3fB8DvhTKoeq9fXSi8hPJvRnuK9TphmdXxikaU8WkI4aawLJHa/0rqr0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=knTvzU/l; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c881aa669fso1396789a12.0;
        Thu, 03 Oct 2024 11:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727980107; x=1728584907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=93gHCxkl+5Tkj032Uj3AzSyRM3GNWPMhtlpnWJX5M3k=;
        b=knTvzU/lNC97y7694aZniHD3T6Q0wgpIP7ll21VwF10s7DpcFWcJUGOel5p1ob86mj
         SBtNLyTs6y32qP6qnirpLIN61A8sV6YVgErz6EsM9Dxz9a9Er+fNVhVY1CQUK+mvhAhf
         VUjVjvrazRGQS33HwecrLubp+L+A/8CKOcARWs3GCP+2sar/JoD8bpf3waEtt4R4r9TG
         PsflzBMA3L1v7jD2oM5dnYFT8eA6S15eeGZltdk+TrSF1NIv43Q6eG4errHV6xgGxsgZ
         D/sAPboRzakZ5vEEPRknCJ+AtNio7u1pSNw/482Bxi2OCXqIJ4Ei9PkhMwPAjQM7fOtE
         20bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727980107; x=1728584907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=93gHCxkl+5Tkj032Uj3AzSyRM3GNWPMhtlpnWJX5M3k=;
        b=U1HeHmaYC2CqMxnecIBpU/pZxo1jQcDpBosiHskuM9p0qGCQfDQLrYyN/uGPUaTq63
         yBDinqeorCJtkdG0MDyMoZ6m/sOIKIdpygUbOXYC/OldDlgBy+F3Qde9jDqY7l472Q4i
         EZmySZPhM0nBfmKfxCZrBmeRpGeFut0/vn1BbptUGFLsYHqcqXEWCDpOZzFWgva4qZUh
         zGyG6cmP2AbWIeRrlOXJ/wjRbWWVaZiXL4XSu94acseoa4VKLPimzO3d0NLRSvDhie6b
         pXjDWeOmFZrw09vKpB7EWEFQAZ8HyOsrUcNDkKGc7O3Emmgzb5qpyOGF/t3JV0nnSAx1
         2YjA==
X-Forwarded-Encrypted: i=1; AJvYcCWOcbfQEXNGli47eI0VEylGYW5d2Q4AVQ6mK+syKCu8av8QJnJNEREKMZbyadOpsxBTDp/dXdESRHM=@vger.kernel.org, AJvYcCWuzdcRNXL3dGX/g1jPT+Gq77E2ReM/u/zpKu5NkBVLMC2pxeS6RvVlKeZ2zL/0ZkhlsUo9Twcj@vger.kernel.org
X-Gm-Message-State: AOJu0YxaRrdJdR1/Uk+iXOHRM1ade/ACdoC4yo6k/1q15SiUbOFX9Y3h
	D8AThGhq5voAT2t7zZ/319T3BiatwqSFcrKCaS2DFUx80CKTrY1nQHS4Sb91Rg3d3DfvpdywK5m
	kCPiHdAW8hnocIblVrZfttgqjUQs=
X-Google-Smtp-Source: AGHT+IHLYrDB0pyXjD+bcr+w1znL/3qm3+qdXqnGkAWncTQ5TvMnVAj3QEzAWF8DVCGqT+wsdUDccW20eEFUMFqa1OA=
X-Received: by 2002:a05:6402:401a:b0:5c8:861c:28c with SMTP id
 4fb4d7f45d1cf-5c8d2e736e2mr88997a12.23.1727980107325; Thu, 03 Oct 2024
 11:28:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241003160620.1521626-1-ap420073@gmail.com> <20241003160620.1521626-2-ap420073@gmail.com>
 <CACKFLi=1h=GBq5bN7L1pq9w8cSiHA16CZz0p8HJoGdO+_5OqFw@mail.gmail.com>
 <CAMArcTXUjb5XuzvKx03_xGrEcA4OEP6aXW2P0eCpjk9_WaUS8Q@mail.gmail.com> <CACKFLikCqgxTuV1wV4m-kdDvXhiFE7P=G_4Va_FmPsui9v2t4g@mail.gmail.com>
In-Reply-To: <CACKFLikCqgxTuV1wV4m-kdDvXhiFE7P=G_4Va_FmPsui9v2t4g@mail.gmail.com>
From: Taehee Yoo <ap420073@gmail.com>
Date: Fri, 4 Oct 2024 03:28:15 +0900
Message-ID: <CAMArcTUG-KaqMfixSDEvkGL7PJ9J40y-T38Gtu0q-ZmCjUk2QA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/7] bnxt_en: add support for rx-copybreak
 ethtool command
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, almasrymina@google.com, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org, donald.hunter@gmail.com, corbet@lwn.net, 
	kory.maincent@bootlin.com, andrew@lunn.ch, maxime.chevallier@bootlin.com, 
	danieller@nvidia.com, hengqi@linux.alibaba.com, ecree.xilinx@gmail.com, 
	przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, ahmed.zaki@intel.com, 
	paul.greenwalt@intel.com, rrameshbabu@nvidia.com, idosch@nvidia.com, 
	asml.silence@gmail.com, kaiyuanz@google.com, willemb@google.com, 
	aleksander.lobakin@intel.com, dw@davidwei.uk, sridhar.samudrala@intel.com, 
	bcreeley@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 2:43=E2=80=AFAM Michael Chan <michael.chan@broadcom.=
com> wrote:
>
> On Thu, Oct 3, 2024 at 10:23=E2=80=AFAM Taehee Yoo <ap420073@gmail.com> w=
rote:
> >
> > On Fri, Oct 4, 2024 at 2:14=E2=80=AFAM Michael Chan <michael.chan@broad=
com.com> wrote:
> > >
> >
> > Hi Michael,
> > Thanks a lot for the review!
> >
> > > On Thu, Oct 3, 2024 at 9:06=E2=80=AFAM Taehee Yoo <ap420073@gmail.com=
> wrote:
> > > >
> > > > The bnxt_en driver supports rx-copybreak, but it couldn't be set by
> > > > userspace. Only the default value(256) has worked.
> > > > This patch makes the bnxt_en driver support following command.
> > > > `ethtool --set-tunable <devname> rx-copybreak <value> ` and
> > > > `ethtool --get-tunable <devname> rx-copybreak`.
> > > >
> > > > Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> > > > ---
> > > >
> > > > v3:
> > > > - Update copybreak value before closing nic.
> > > >
> > > > v2:
> > > > - Define max/vim rx_copybreak value.
> > > >
> > > > drivers/net/ethernet/broadcom/bnxt/bnxt.c | 24 +++++----
> > > > drivers/net/ethernet/broadcom/bnxt/bnxt.h | 6 ++-
> > > > .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 49 ++++++++++++++++=
++-
> > > > 3 files changed, 68 insertions(+), 11 deletions(-)
> > > >
> > >
> > > > diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/ne=
t/ethernet/broadcom/bnxt/bnxt.h
> > > > index 69231e85140b..cff031993223 100644
> > > > --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> > > > +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
> > > > @@ -34,6 +34,10 @@
> > > > #include <linux/firmware/broadcom/tee_bnxt_fw.h>
> > > > #endif
> > > >
> > > > +#define BNXT_DEFAULT_RX_COPYBREAK 256
> > > > +#define BNXT_MIN_RX_COPYBREAK 65
> > > > +#define BNXT_MAX_RX_COPYBREAK 1024
> > > > +
> > >
> > > Sorry for the late review. Perhaps we should also support a value of
> > > zero which means to disable RX copybreak.
> >
> > I agree that we need to support disabling rx-copybreak.
> > What about 0 ~ 64 means to disable rx-copybreak?
> > Or should only 0 be allowed to disable rx-copybreak?
> >
>
> I think a single value of 0 that means disable RX copybreak is more
> clear and intuitive. Also, I think we can allow 64 to be a valid
> value.
>
> So, 0 means to disable. 1 to 63 are -EINVAL and 64 to 1024 are valid. Tha=
nks.

Thanks for that, It's clear to me.
I will change it as you suggested.

Thanks a lot!
Taehee

