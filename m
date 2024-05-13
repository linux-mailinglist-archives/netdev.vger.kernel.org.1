Return-Path: <netdev+bounces-96178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62ABE8C497F
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 00:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA0C81F21B85
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 22:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7216A78285;
	Mon, 13 May 2024 22:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RHlsxZRL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4B12119;
	Mon, 13 May 2024 22:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715638187; cv=none; b=DSg+brfS8ZnmKKS+NrPdjV5IE5CSII1NcQqclhcaNGy6mAngn92Dgih7oeY8osTOfkuqrhlM4D5wQ7/9TNlMz3HfQwmhGiPBwrPngsXDnD4wO1z9Ul+5Izh49E+xRH/XgRWkZ9rgY3IfHK2W/3+BRkDavKHYzT95kjDbPOu9/VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715638187; c=relaxed/simple;
	bh=KgLLBqp3cuJxKACzy4sN1Q3Z0Z7Ey7fyY3vJR+VRmuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H3znNfooUxMN5k9i+YAebEMtwIw4bO11UJycOXRqrTv3k+WK04X6WMXJH8++XAb3Vrps0YQ/sazypBMC9226JZPM7SMFTpRe3uzPrMzDCsVxJcn+OP5aWSoFDCJDm9wzTXULVPfR514+Mz3bX2bJezi3qVjs0njBHn91fLotNUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RHlsxZRL; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2e4939c5323so61831041fa.2;
        Mon, 13 May 2024 15:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715638184; x=1716242984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=snkDChq8Qi7plQQXnc8M+8yvrUlNpWweMVToZD8bXc8=;
        b=RHlsxZRLHo9Mv2vFyssenaCFi4Si7lZsWb8eyz527pmtkkb/c5lxH1MsyZijQWJNpW
         vjJ5szeiHFqoRWeZ8qjOSmcXSQLVPfKPiLwlYWlljkvV+SOBKsE4lK5kWqhY2CxImlCQ
         DODmzlfZZ9KWxrUOnWtbLfRueigVUjjG3lc19IeYLdvbhmwSNkJB62D7wVWNMxZu4F19
         tFRtPx64NoJOAylHe+T977TMxdZZc5h+9q3VmyAdCFQiSGb58Y2guilY1i93uK6YC/Bz
         yWu3Msof1Ns1HmbtBCzYkxifPmR/+uHBUpj4VZmCiidn6xUY5tF+8fYVfN5Jrh9JW97G
         4XUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715638184; x=1716242984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=snkDChq8Qi7plQQXnc8M+8yvrUlNpWweMVToZD8bXc8=;
        b=AljTpcl8tJkrB3pe3zP46Pu/2SZphrBA2DMIoJhAeEuGY83g+N0egpVKqAujZSpUwr
         SDmiwxmRSPuS6JBmUvsTBcH1eNEvd+Ub5BxwIFJnNpJ729TVDS9m7FliPGIKAgSFNGab
         F+hsl8UgtCzDw2jUOdJuHhj0zXNYk2+pZLzURwV9yAjmm0PtL3W92WRYOjmSq3DHB9yF
         sidmYeacr2T+TO4UrlidDGkPd+2AnmQdTMftxkPAXXYNs59ZA81Q5utwqEXl9Kp3+hvq
         ipYLW1mwLz2qzSdMUir8VI5SIhuuPs2Z5UOoKnQ2JwYHPiehH9L2PWXEASXPImICuUx+
         D9iA==
X-Forwarded-Encrypted: i=1; AJvYcCWqkXrWBe9qonw8KQzNozB1IQdfTGe87QzbTnSphNDQg2t+uloSMrxGWOBNhVusES3wONXsYBQVAOyhTU4xGovtdZnx5qeq0N5+bIOLLt4fNJtOlD4k6OyGPRdrUcz578Vr94L4wkQ1
X-Gm-Message-State: AOJu0Yxfc34N0j/6/mzR22wX+fmsxlNwt3oSBkKCvGRTowiHVCJ5zwoL
	LvcrW0WYGDkij8Jf32pPgfXfrUKT6LI3ojRWPf7pfPVkZ6brSU1pje3lCLPxzTra2KwQgTu56x/
	ttf/qY0DkZUe15Lzl5pmQku6kBUk=
X-Google-Smtp-Source: AGHT+IFOWH89XWA1ZBb0ZzMIrcB16rm7Kn/F7Q/aWT+PsPht5wNSKSbQev1+tS5lJDfMmLs5PY99V9z7u60vuivLMeQ=
X-Received: by 2002:a2e:9894:0:b0:2da:36be:1b4a with SMTP id
 38308e7fff4ca-2e51fe531e0mr99375891fa.19.1715638183496; Mon, 13 May 2024
 15:09:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510211431.1728667-1-luiz.dentz@gmail.com> <20240513142641.0d721b18@kernel.org>
In-Reply-To: <20240513142641.0d721b18@kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 13 May 2024 18:09:31 -0400
Message-ID: <CABBYNZKn5YBRjj+RT_TVDtjOBS6V_H7BQmFMufQj-cOTC=RXDA@mail.gmail.com>
Subject: Re: pull request: bluetooth-next 2024-05-10
To: Jakub Kicinski <kuba@kernel.org>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, davem@davemloft.net, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	Pauli Virtanen <pav@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

On Mon, May 13, 2024 at 5:26=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 10 May 2024 17:14:28 -0400 Luiz Augusto von Dentz wrote:
> > The following changes since commit f8beae078c82abde57fed4a5be0bbc3579b5=
9ad0:
> >
> >   Merge tag 'gtp-24-05-07' of git://git.kernel.org/pub/scm/linux/kernel=
/git/pablo/gtp Pablo neira Ayuso says: (2024-05-10 13:59:27 +0100)
> >
> > are available in the Git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-nex=
t.git tags/for-net-next-2024-05-10
> >
> > for you to fetch changes up to 75f819bdf9cafb0f1458e24c05d24eec17b2f597=
:
> >
> >   Bluetooth: btintel: Fix compiler warning for multi_v7_defconfig confi=
g (2024-05-10 17:04:15 -0400)
> >
> > ----------------------------------------------------------------
> > bluetooth-next pull request for net-next:
> >
> >  - Add support MediaTek MT7921S SDIO
> >  - Various fixes for -Wflex-array-member-not-at-end and -Wfamnae
> >  - Add USB HW IDs for MT7921/MT7922/MT7925
> >  - Add support for Intel BlazarI and Filmore Peak2 (BE201)
> >  - Add initial support for Intel PCIe driver
> >  - Remove HCI_AMP support
> >  - Add TX timestamping support
>
> There is one more warning in the Intel driver:
>
> drivers/bluetooth/btintel_pcie.c:673:33: warning: symbol 'causes_list'
> was not declared. Should it be static?

We have a fix for that but I was hoping to have it in before the merge
window and then have the fix merged later.

> It'd also be great to get an ACK from someone familiar with the socket
> time stamping (Willem?) I'm not sure there's sufficient detail in the
> commit message to explain the choices to:
>  - change the definition of SCHED / SEND to mean queued / completed,
>    while for Ethernet they mean queued to qdisc, queued to HW.

hmm I thought this was hardware specific, it obviously won't work
exactly as Ethernet since it is a completely different protocol stack,
or are you suggesting we need other definitions for things like TX
completed?

>    How does it compare to stamping in the driver in terms of accuracy?

@Pauli any input here?

>  - the "experimental" BT_POLL_ERRQUEUE, how does the user space look?

There are test cases in BlueZ:

https://github.com/bluez/bluez/commit/141f66411ca488e26bdd64e6f858ffa190395=
d23

>    What is the "upper layer"? What does it mean for kernel uAPI to be
>    "experimental"? When does the "upper layer" get to run and how does
>    it know that there are time stamps on the error queue?

The socketopt only gets enabled with use of MGMT Set Experimental
Feature Command:

https://github.com/bluez/bluez/blob/master/doc/mgmt-api.txt#L3205

Anyway you can see on the tests how we are using it.

> Would be great to get more info and/or second opinion, because it's not
> sufficiently "obviously right" to me to pull right away :(

Well I assumed sockopt starting with SO_ sort of means it applies that
all socket families, in fact SO_TIMESTAMP already seem to work without
these changes they just don't generate anything, so in a way we are
just implementing a missing feature.

--=20
Luiz Augusto von Dentz

