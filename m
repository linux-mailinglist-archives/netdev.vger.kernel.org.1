Return-Path: <netdev+bounces-203823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B96AF75A5
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 15:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9F7A3AB3AF
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 13:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D97E17A2E8;
	Thu,  3 Jul 2025 13:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YXOo3IXP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D71814D70E;
	Thu,  3 Jul 2025 13:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751549380; cv=none; b=LVbmJaGDPp3+I/yxNX8FLY+stMgtkPqxRYKfs2Uww9oD9B78OU+djL5B88dX9gMy7fnVN5nxr907kjS6lHzXeE0Z0wZUvqEXnjQ+OxkDU9c+pOMbPbc5qYMHvljQf/NRULNSf1w8xpijdDCI7YZwKoAuAtZirizS3BCYV5iF7Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751549380; c=relaxed/simple;
	bh=2yrMG4mTG4wLrrSnSlp53BTqKdOqd5g+PQkDz9o/9+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NsK5dIpwsv0GHTfoFqRvbHJnyvQvBAgQB3RDxYVuFUKuKzQ9wWFr1p/uc6MFoen49qXLxnP5G3/d9GPomlRVnzEHWOJ2FmHD6fpmWfvwX+l1MA7LazmMMphdHwozT5f/qIeBRqjcH7CDZhdEPxhUPTtsm3p1GUeKen9kH0ezWjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YXOo3IXP; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-32b5226e6beso52202911fa.2;
        Thu, 03 Jul 2025 06:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751549375; x=1752154175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hr2JJ8+95d/X3z/DM36+FeJ8rmhTTPOs3yJyKAnbaIw=;
        b=YXOo3IXP7IFFLBL63i52taifOuJhireiHRPmpunydmdqtRqI4CdU3IxAOe+diOshK9
         598l3VLe56CUwG0cMzW1DM1wvWY6czjKBoh9IbkreltnnetSt915KRiV4L56kmtnZfvJ
         +BZO2KizuHZ1luXZP8Xrk48JF0Qr2wqeRSHh4Q3PTv+ldX66jt8bg7VeNOx4rd7ZWNHX
         yenPJth61qYRmR+HgzyA6LWVXTqsliR1QuWeMyihZgecRslSOZUFLnJKuki3zcZbEmn1
         /gbV6SlHt6poeQDM6m9PI0I+3KQ89Dim/d1oBiKWeZQFsnIZshcp0jp+qaKlL/nAh6rb
         06Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751549375; x=1752154175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hr2JJ8+95d/X3z/DM36+FeJ8rmhTTPOs3yJyKAnbaIw=;
        b=Z+kbUr69XiUJIJksKSrqL+WCTALKKqnRM5Fl4GfA3ifcOeJ+98n/7eZBlbMEXW/nH2
         akO194xAPVgiA9XcUJZmhFq6SclQBFB6q2zoqgHzcSR6L3u5DQRiwHo95B6znJQDOqxu
         62ZWNJRVRPblvbErA8MC5V0Kk9KnO+dwNW3Y2y5RI3CM9TDqqf1L5IlmpllCW0TUBE+9
         2gEuHReuhpLRvaz8gggGV3rIWQIss+MR6apq12/aklef2vXkb2zNX7nEiXH3brDKip1K
         pXba2+9dvr0tI6bbLg99hilhFu60m+2nae8fO8qFXulF4n6a9FIKyT6r+1T2OUV/H2dp
         fvMg==
X-Forwarded-Encrypted: i=1; AJvYcCUBLV63Fqq8+waKxNg3YwW2mVGIu8A7+6wn2eI+72IDTuW7ryyJqGT8+iEhhwN9XHwD6O9zUn80@vger.kernel.org, AJvYcCUfywgYOP8oGR+dLP11oV95jyMu/3SyuneJaSrHy0gsRdAiWdkeCJrfP+OPkG0EUbjaV7fY+UdoouSjY4infaA=@vger.kernel.org, AJvYcCVyUu5qQ6fFtnozH+ZbIshJTiODFCG0VmJjRQxF5OrrdwS8UaPniPdmp7uwFI8BGTZBDQlgdz/PhRxFJXY1@vger.kernel.org
X-Gm-Message-State: AOJu0YxVJSJ4nQylNZRQEZIz+Y7dN7WyCsAJGUHu2NN+7PizZInh5lmA
	ceoO2HpLfsbNxSRyrM3CFhbk0N1SZwQsCo+rNEw6nUYcpJPo0Mb5B8Yj1qC2UrjRLULCZ2lqbzv
	/qkPWZWfIuM02fdonO0g5bEevx89sgFA=
X-Gm-Gg: ASbGncvul0QKEM+IlRE02oQzzZZcq/pzoRJX9RkOBGKEM+6+pUstRKUrOE3KbbMyumx
	yUQXprLBMkBpfqe8He3JHX0McfovF0pVfNjXD1MKfZWnrpni9Lo/tCDUfsVRO42G0m4FCKwXoCr
	P+JpsZmmHiDdECzbjcZE55pU6LKWUrA9gplkv0hsyLHg==
X-Google-Smtp-Source: AGHT+IHIV0P7Nn3SUJt9yUQ044AuPK2Is0zqwwkXDInXhGwneSaDho01yglbJWw4LnJdPhNxeVl4P0hcWtSVkSvFJx4=
X-Received: by 2002:a2e:888e:0:b0:32c:e253:20cc with SMTP id
 38308e7fff4ca-32dfff74fc9mr20480581fa.11.1751549374442; Thu, 03 Jul 2025
 06:29:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702-pa_sync-v1-1-7a96f5c2d012@amlogic.com>
 <CABBYNZJCsiKVD4F0WkRmES4RXANNSPK1jvfRs-r9J-15fhN7Gg@mail.gmail.com> <6bed0cff-c2be-4111-a1d3-14ce0e3309db@amlogic.com>
In-Reply-To: <6bed0cff-c2be-4111-a1d3-14ce0e3309db@amlogic.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 3 Jul 2025 09:29:21 -0400
X-Gm-Features: Ac12FXyFwqjQHQUNcwF1A2b4PHIVgosz8Mra4Xp18msAp3yZkAH15eRyoPey6XE
Message-ID: <CABBYNZ+mB+rb+6hG9s7fmvqwti8oSoQ27+_Cz56_ZD7C5t3cQA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_core: lookup pa sync need check BIG sync state
To: Yang Li <yang.li@amlogic.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 3, 2025 at 5:19=E2=80=AFAM Yang Li <yang.li@amlogic.com> wrote:
>
> Hi luiz,
>
> > [ EXTERNAL EMAIL ]
> >
> > Hi,
> >
> > On Tue, Jul 1, 2025 at 9:18=E2=80=AFPM Yang Li via B4 Relay
> > <devnull+yang.li.amlogic.com@kernel.org> wrote:
> >> From: Yang Li <yang.li@amlogic.com>
> >>
> >> Ignore the big sync connections, we are looking for the PA
> >> sync connection that was created as a result of the PA sync
> >> established event.
> > Were you seeing an issue with this, if you do please describe it and
> > add the traces, debug logs, etc.
>
> connect list:
>
> [   61.826679][2 T1974  d.] list conn: conn 00000000a6e8ac83 handle
> 0x0f01 state 1, flags 0x40000220
>
> pa_sync_conn.flags =3D HCI_CONN_PA_SYNC
>
> [   61.827155][2 T1974  d.] list conn: conn 0000000073b03cb6 handle
> 0x0100 state 1, flags 0x48000220
> [   61.828254][2 T1974  d.] list conn: conn 00000000a7e091c9 handle
> 0x0101 state 1, flags 0x48000220
>
> big_sync_conn.flags =3D HCI_CONN_PA_SYNC | HCI_CONN_BIG_SYNC

This is a bug then, it should have both PA_SYNC and BIG_SYNC together,
also I think we should probably disambiguate this by not using
BIS_LINK for PA_SYNC, byt introducing PA_LINK as conn->type.

>
> If the PA sync connection is deleted, then when hci_le_big_sync_lost_evt
> is executed, hci_conn_hash_lookup_pa_sync_handle should return NULL,
> However, it currently returns the BIS1 connection instead, because bis
> conn also has HCI_CONN_PA_SYNC set.
>
> Therefore, I added an HCI_CONN_BIG_SYNC check in
> hci_conn_hash_lookup_pa_sync_handle to filter out BIS connections.
>
> >
> >> Signed-off-by: Yang Li <yang.li@amlogic.com>
> >> ---
> >>   include/net/bluetooth/hci_core.h | 7 +++++++
> >>   1 file changed, 7 insertions(+)
> >>
> >> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/=
hci_core.h
> >> index 3ce1fb6f5822..646b0c5fd7a5 100644
> >> --- a/include/net/bluetooth/hci_core.h
> >> +++ b/include/net/bluetooth/hci_core.h
> >> @@ -1400,6 +1400,13 @@ hci_conn_hash_lookup_pa_sync_handle(struct hci_=
dev *hdev, __u16 sync_handle)
> >>                  if (c->type !=3D BIS_LINK)
> >>                          continue;
> >>
> >> +               /* Ignore the big sync connections, we are looking
> >> +                * for the PA sync connection that was created as
> >> +                * a result of the PA sync established event.
> >> +                */
> >> +               if (test_bit(HCI_CONN_BIG_SYNC, &c->flags))
> >> +                       continue;
> >> +
> > hci_conn_hash_lookup_pa_sync_big_handle does:
> >
> >          if (c->type !=3D BIS_LINK ||
> >              !test_bit(HCI_CONN_PA_SYNC, &c->flags))
>
>
> Please forgive my misunderstanding.
>
> >
> >>                  /* Ignore the listen hcon, we are looking
> >>                   * for the child hcon that was created as
> >>                   * a result of the PA sync established event.
> >>
> >> ---
> >> base-commit: 3bc46213b81278f3a9df0324768e152de71eb9fe
> >> change-id: 20250701-pa_sync-2fc7fc9f592c
> >>
> >> Best regards,
> >> --
> >> Yang Li <yang.li@amlogic.com>
> >>
> >>
> >
> > --
> > Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz

