Return-Path: <netdev+bounces-201629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C83EFAEA22E
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 17:15:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC30F3AE8E2
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 15:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3682ECD1B;
	Thu, 26 Jun 2025 15:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kBtERjOW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A12A2ECD0B
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 15:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750950377; cv=none; b=YnVNK9D14mEYwLs+jnEOfr13FONgLTksZ9lRWnheDst7zG18foXTnkZ8QYbAsQr17ImAFG2SYJYplxeQ7EIS41nOnxoVSUCMPSQbcgibEcCGiyKWd7tNFvvKWIoaAgOUNc1iBJ9g53o+uymIJnSWnki7xgUpftRrOkACf1ziouQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750950377; c=relaxed/simple;
	bh=LVREvng0rxqkakxocau8Ja1CRAeRCBfnsb1BalgotGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cQ7IdzEKP7qS668cTqNofH4fY9C6BgGIpfMfsNHMSjzS/lLzgUe5Hzl3bYxlqOnAZEitIgqqZvMTZtE3EbQ7MyH6krQXgHl7GJIRI7XRARhdc4vROA6DPj+I8sfWoOOER2XAbCl6l5f+A/V9VNKAWV3LCsOz78bHRHWCc/FvO5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kBtERjOW; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6f2b58f0d09so2446376d6.3
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 08:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750950374; x=1751555174; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U4QxGauz/Qj1iZreTbsJ/LGLMTZaAoRfTwu2zcOintE=;
        b=kBtERjOWMdZuezbTCAip3SU7jqt6kkFneQOFq29kWPkVT1Qyt2UbppEYu9WhKRmA37
         ZFRfiKecru4q6FyJn1l/Fu1prZ5C9oZNv4I1KYiHG0ZUfcC7k3yICLR6FWMlYB3muJbE
         h/8C642F8sX0uolXaVzqavqwuaILagp7nOhUg1rWcJ2r9AHopjY/XjGttZdaUcc65QND
         5hDbTBjdA+q2caCH4KLbTD6IL+xMZANUqf2U78locX4rVscZ7YyvYwS8CdPeE5IgkEVv
         KNQ4xz0IJdd9B8KF9PthWOv/X/gy8N2AP2tT5gcsIrt/L6afV1OpVDwZ27WJVWC05VcU
         harw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750950374; x=1751555174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U4QxGauz/Qj1iZreTbsJ/LGLMTZaAoRfTwu2zcOintE=;
        b=smGSh//30M6bQA+nhStehHy751zlGooBFnCOBOn10FiaASEbuJqINAjSS0C6aiZcR/
         vB7ull0lXlKmty0Tq+Bq0JBEgwZep45VVy5Q3OvKi/F0wPsb59Hg2sXHL+lF3lSUi+or
         BH6qej7wMtktJKrNcdfmNVpbFeF3YF7IdWDzYO4X+Xi6ybakdwlRJ+80/TlmloTfp3Fl
         jWUsVRxG21P030eK1baoWu3D29X6Ltl6hRvl08faOkSE2sdyzUcF8TRB0NWD14OEhCsD
         Cj/TYpObRC69or2cU4gQsK7ckXctui0l/R2N56aPlSSe+uk/sFsuFvQkO/xMj2OLzNd9
         Z47g==
X-Forwarded-Encrypted: i=1; AJvYcCXUZb8QbE0FCTR0jhp9wlwf9uQBUXR1f4rXtzwa32yEWDInuL48F1ez8qWWoaoX4OYgEruUld8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVrG8FxyR7kPQpmShAumHrBJ4EbO15dTeD2wwq7tHo23IW15m5
	5n3MmUG5+u/eh0eLiptUhbZ5rZxQlmVICdzT+A3OVBVSVwpFBwDMx/+/NBQlzbe0TiH3xLdKSFZ
	cRQm1pxvuDSg6FU4fq1QqlJO3efTLnA==
X-Gm-Gg: ASbGncv+6VfOK0XJd3ykj4v68ZBNK8Uh3AkGntxycV7dQ7KP3GRMnItFgikpikghbhm
	SkvP1J//bShYXifXi9zeps71mQvhioM/w61q9kbN8ZAAG57JCeh0jo923NzfyifV+m0/EkAL0uU
	3C28G0KZjRLf7VDMPiJitqgXNKSG+Crk8LDxVzj9HQiJPOh4ApTw==
X-Google-Smtp-Source: AGHT+IG6ghQInplRE0BNMglL2cNZFJ+NmVvTmaXwd4ThmBVaC4pg1+IykS61HgV6z3aRVtuuaar6KnwLZ+NRkV68iiM=
X-Received: by 2002:a05:6214:1d24:b0:6fd:ace:4ceb with SMTP id
 6a1803df08f44-6fd5efa9ademr41179386d6.8.1750950374139; Thu, 26 Jun 2025
 08:06:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625153628.298481-1-guoxin0309@gmail.com> <CANn89iKrwuyN2ixswA-u1AxW=BX8QwWp=WHskCmh_1qye3QvLA@mail.gmail.com>
 <CANn89i+ZVR_qvYE3F+ogyhEKX0KjiW3vQx0R1V9GHNxm+EHt0g@mail.gmail.com>
In-Reply-To: <CANn89i+ZVR_qvYE3F+ogyhEKX0KjiW3vQx0R1V9GHNxm+EHt0g@mail.gmail.com>
From: Xin Guo <guoxin0309@gmail.com>
Date: Thu, 26 Jun 2025 23:06:01 +0800
X-Gm-Features: Ac12FXzflDMfoSPOXhoyQFuoGTgO1w459stbNUttANUPYxq1Tmj8RNI8f1Xi7fI
Message-ID: <CAMaK5_h0pdwbKGcZ-xmVULnxeJ=r0QrDeGepYuar=67n0spuHQ@mail.gmail.com>
Subject: Re: [PATCH net-next v1] tcp: fix tcp_ofo_queue() to avoid including
 too much DUP SACK range
To: Eric Dumazet <edumazet@google.com>
Cc: ncardwell@google.com, davem@davemloft.net, dsahern@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Eric, have a nice day.

Regards
Guo Xin.

On Thu, Jun 26, 2025 at 5:31=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Wed, Jun 25, 2025 at 9:03=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Wed, Jun 25, 2025 at 8:37=E2=80=AFAM xin.guo <guoxin0309@gmail.com> =
wrote:
> > >
> > > If the new coming segment covers more than one skbs in the ofo queue,
> > > and which seq is equal to rcv_nxt , then the sequence range
> > > that is not duplicated will be sent as DUP SACK,  the detail as below=
,
> > > in step6, the {501,2001} range is clearly including too much
> > > DUP SACK range:
> > > 1. client.43629 > server.8080: Flags [.], seq 501:1001, ack 132528852=
9,
> > > win 20000, length 500: HTTP
> > > 2. server.8080 > client.43629: Flags [.], ack 1, win 65535, options
> > > [nop,nop,TS val 269383721 ecr 200,nop,nop,sack 1 {501:1001}], length =
0
> > > 3. Iclient.43629 > server.8080: Flags [.], seq 1501:2001,
> > > ack 1325288529, win 20000, length 500: HTTP
> > > 4. server.8080 > client.43629: Flags [.], ack 1, win 65535, options
> > > [nop,nop,TS val 269383721 ecr 200,nop,nop,sack 2 {1501:2001}
> > > {501:1001}], length 0
> > > 5. client.43629 > server.8080: Flags [.], seq 1:2001,
> > > ack 1325288529, win 20000, length 2000: HTTP
> > > 6. server.8080 > client.43629: Flags [.], ack 2001, win 65535,
> > > options [nop,nop,TS val 269383722 ecr 200,nop,nop,sack 1 {501:2001}],
> > > length 0
> > >
> > > After this fix, the step6 is as below:
> > > 6. server.8080 > client.43629: Flags [.], ack 2001, win 65535,
> > > options [nop,nop,TS val 269383722 ecr 200,nop,nop,sack 1 {501:1001}],
> > > length 0
> >
> > I am not convinced this is the expected output ?
> >
> > If this is a DUP SACK, it should be :
> >
> > Flags [.], ack 2001, win 65535, ... sack 2 {1501:2001} {501:1001} ....
> >
> >
>
> >
> > At a first glance, bug is in tcp_dsack_extend()
>
> After more thoughts and RFC 2883 read, I think your patch is correct.
>
> I will include it in a series with two packetdrill tests, and another fix=
.
> I will add appropriate Fixes: tag
>
> Thanks !

