Return-Path: <netdev+bounces-175867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B55BA67CF5
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 20:21:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D6573B260F
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 19:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD931DF240;
	Tue, 18 Mar 2025 19:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMhEFrWW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED621DE884;
	Tue, 18 Mar 2025 19:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742325656; cv=none; b=SgaUstqswr1xUG6oFCPqmgddhmaUl9oCS3dmDCKMfZMtzGkX5oc91cCIonQg4oJ6+ALYp1ZKhe7UopiMmS1aDQzApgPOOZAGvCoJ65egTmyTgsY3qnmz+YUb0wJ3300zxo6TPVzBWtxIHm7C9esm8G3+6D4V04y6t4FdI4j2Lko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742325656; c=relaxed/simple;
	bh=9OC2FU+2eH233QZvpLW9ScpRuttoUg6k96POPffD/zY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BIKUg8ffO1Gb8Wgy8eT8estNH+k7rUwcC+GSRX34LYh0AoJt7zlZbgBSAzqaWpjCxIB8cg8FATqpXFyHgPTxVUF23JrTzbzjrneQ39xQEvwpnNx0kluYCA1dSKr5ywgyZH/pN4E2OlaOt3q1f9+N7xmmCnmSjy/o8ZIbq5CGLNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QMhEFrWW; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30bd21f887aso54904051fa.1;
        Tue, 18 Mar 2025 12:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742325652; x=1742930452; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZDFgjzV0NUl7tGnT0L+/6KvSGvXvxtLHxq+iYc5o+8=;
        b=QMhEFrWWV7n600DFVLqncbOlpm50hsteJQBe31MtQYOXKAEeQ7rimBBC0Me/V+K+SN
         ZMi8oG3YiPHwJ0/12Pc0C/v+aRhwBQLIEiHnVWBSqz3qcv+TRnWr2Z7QVVsU2c4Ii2DM
         7iOgp4cmKCZW+Sogq+HW83TQ+pXFhyCi505dzANBQVa9N7JYMcmQdDHyu1MoYyKMHV8R
         cDlv9RIF4N4ymLGJhpPoEVAVLIoY99m4At4o7hg7uTt3W5PKJ0mwDHhX+QuMAtm7lubJ
         EeSuJwauYFGOIUmyaABV2WYk2H5ypT2RD6QfYzhVDef9IccFDVtYl1r7GT+Vw4GwxGRK
         9yJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742325652; x=1742930452;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qZDFgjzV0NUl7tGnT0L+/6KvSGvXvxtLHxq+iYc5o+8=;
        b=wgiAu+8xMAOXKAUNbQGJi63x8VXomS/K9oE2vqHcIKslo1U8/h2pnIJu/+0x5zqqRu
         rk415OMXRupYNQ0+JKs3iXReKMud9khYq+QOeC4sd+ZRPacpyxpcJ+w/2qPCGnHu52wz
         B6bt4I7jmahsJxEaY7Hb5FHnKeUI1Chovp5HbQGTXiu0KRfcRIgZmpv6fmUTu+6M3rTc
         7mujhvli/UfWwBgdeM30/h8kagK4YWR7y7WWlUCGgEZ1/Sw2/3m/d5ziyi9iswF4p0Rw
         RmpcFOHVmdbMes3VerDLp+X9bJYAtJP9s1FPYjjPxldvb3B9aurCGa/9sOKjL77TWhMN
         pG/g==
X-Forwarded-Encrypted: i=1; AJvYcCUPGWMOXlcEflBQQs7lolkEdUvyHkOy0hQgkmehlfcm45nIILzn8nH0TnsROc73+ScLZ3jCBm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YysHrVuoN2XQzSnmw1ZkSQARlrU6qe5s55JBJEPn8OZGSAyRayZ
	xjT9M9dcQlg2oE0S7H8ka2W2n7Ohk66QO3Yeh0KypS1AGGw74Tsb8SMTMJiEUPcpPuRJqam6Hcb
	s9zvUS45F76a8obeG5IbdPGPfugmojRgN
X-Gm-Gg: ASbGncscv11105d3csTobRPyX6aCvCyPqWnOZnrlmHjuvlVfVA2nAXSimuIsMj6bTm4
	v1JTDjAbKpM7nshLPcO93FoPtih7M3ar7G6fzoHQUsjEwn7HqTiW/MljDSeGft1pu8Wk4Jtnj62
	Phx03KRxF8Ry3ellIAIFCOyN56
X-Google-Smtp-Source: AGHT+IFv2kRuJHWr6e9fwBnmsWkYnMG2H0nGSH43umifttX8FQT1E2C6Qqh+ok/vYdMzVxOAy91ITrxX5543tl1/4bM=
X-Received: by 2002:a2e:3516:0:b0:30c:7a7:e841 with SMTP id
 38308e7fff4ca-30c4a8edceamr104451561fa.34.1742325652173; Tue, 18 Mar 2025
 12:20:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739988644.git.pav@iki.fi> <CAL+tcoAAj0p=4h+MBYaN0v-mKQLNau43Av7crF7CVXFEnVL=LQ@mail.gmail.com>
 <CABBYNZJQc7x-b=_UQDjGbTVnY-iKASNzg=rTFXDRXyn_O+ohNQ@mail.gmail.com> <f18907a858ff6040d53d41dafab9170a06622c1c.camel@iki.fi>
In-Reply-To: <f18907a858ff6040d53d41dafab9170a06622c1c.camel@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 18 Mar 2025 15:20:38 -0400
X-Gm-Features: AQ5f1JqlGKBetDlePqz62uS86P5NsTpaH3EDWs2AR-Ok75n7J2JXgE4EoBvHUR8
Message-ID: <CABBYNZJ2Qmn1rkQ9Gq5j=ggKJ_v6c-rHWXKmOUjtL9pMS_Xi6g@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] net: Bluetooth: add TX timestamping for ISO/L2CAP/SCO
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org, netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Tue, Mar 18, 2025 at 3:19=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> ma, 2025-03-17 kello 13:50 -0400, Luiz Augusto von Dentz kirjoitti:
> > Hi Pauli,
> >
> > On Wed, Feb 19, 2025 at 7:43=E2=80=AFPM Jason Xing <kerneljasonxing@gma=
il.com> wrote:
> > >
> > > On Thu, Feb 20, 2025 at 2:15=E2=80=AFAM Pauli Virtanen <pav@iki.fi> w=
rote:
> > > >
> > > > Add support for TX timestamping in Bluetooth ISO/L2CAP/SCO sockets.
> > > >
> > > > Add new COMPLETION timestamp type, to report a software timestamp w=
hen
> > > > the hardware reports a packet completed. (Cc netdev for this)
> > > >
> > > > Previous discussions:
> > > > https://lore.kernel.org/linux-bluetooth/cover.1739097311.git.pav@ik=
i.fi/
> > > > https://lore.kernel.org/all/6642c7f3427b5_20539c2949a@willemb.c.goo=
glers.com.notmuch/
> > > > https://lore.kernel.org/all/cover.1710440392.git.pav@iki.fi/
> [clip]
> >
> > We are sort of running out of time, if we want to be able to merge by
> > the next merge window then it must be done this week.
>
> It took a bit of time to get back to it, but v5 is sent now.
>
> Note that it does not apply cleanly on bluetooth-next/master, as the
> first commit is based on net-next since there have been some changes
> there that need to be taken into account here:
>
> commit e6116fc605574bb58c2016938ff24a7fbafe6e2a
> Author: Willem de Bruijn <willemb@google.com>
> Date:   Tue Feb 25 04:33:55 2025
>
>     net: skb: free up one bit in tx_flags
>
> commit aa290f93a4af662b8d2d9e9df65798f9f24cecf3
> Author: Jason Xing <kerneljasonxing@gmail.com>
> Date:   Thu Feb 20 09:29:33 2025
>
>     net-timestamp: Prepare for isolating two modes of SO_TIMESTAMPING

Got it, I will rebase to net-next to have these also available in
bluetooth-next.

--=20
Luiz Augusto von Dentz

