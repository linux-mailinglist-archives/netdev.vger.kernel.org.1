Return-Path: <netdev+bounces-176502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBEC1A6A910
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 15:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0367816DFC7
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 14:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1271DE4E9;
	Thu, 20 Mar 2025 14:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zrwn+tGM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664C91D5CCD;
	Thu, 20 Mar 2025 14:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742482197; cv=none; b=rCa/tqcD9dODZc5T7yP6vdO6zVtIS1AC+UAj95Do8EOaclieosI3cLEPNufmIEBKjwe0asRwoHfPNWg/Awair1oPebZMPZr5icJrm3OhzqDxbAisDinYeLuhjUZALswmy8n5zeYH7+StpcdvZWDhSQF6b1pQnUypwqDnhwNfGXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742482197; c=relaxed/simple;
	bh=g+zzHx89ZVOsZ1+j0S/ETcKko5Sah4yuDyoEtdyMynM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=epVDZaH9zArCwYILUe2kbCCZouJ06IIUPP7qphNpPvb9aIFHaIW4/WllAZHflXXYLnthElbS0kF2FC18Z9ZKTalZb80Zvc2VzTE/d216LHfftE3YyIwP3tBxZuHYfoeMxHlCw2v6KXdox5AQb8Jt+VlnHZ0eC7LS0hKoVtZKsV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zrwn+tGM; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4769f3e19a9so5474621cf.0;
        Thu, 20 Mar 2025 07:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742482194; x=1743086994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lTxdgXG9b8klrJS1MbOgXiJ35hJw0juxUhnYlYWpU2c=;
        b=Zrwn+tGM5HLvdm69lKx3kWSQhTMjlskLmWWLGl4n/oo9B5Tx8uAdIAYy0fH3shMwlW
         QXc9USoEVMdcFiCOoKBvP2Ia75U/yN2Vgo9Z33JNDXXjpy6Y18JpcD5hBX/GE5Fg+lQp
         bJe9AEYaLHr7nUltn8mBqTmODfMU66VmMSwQ8zPczALjFk3tgpd97jN9N10l/xh4BvZ0
         4bxKcHRe8MEJisXG7MyEDARj5z3V8oAdDtZgaiT7hKD7IL+H+jCDWw1YFdpkyfsPxPXZ
         gNxPZUGVZQkW2MY+BUYVtQh5BNdLbEwq2QK250LYObgrXrkrJJ0HlC8rNSD2DC36k7hn
         wlPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742482194; x=1743086994;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lTxdgXG9b8klrJS1MbOgXiJ35hJw0juxUhnYlYWpU2c=;
        b=Ufver8uMd8T37cqKX3ZAqTyuJwMHRazB0W+h8DUSBXzcG72aW6vYDZyOj3wvBkc6lw
         AVCDhQJKpUQQShyjcZwrz4M5q7dHkVp8cv5MUU4HWFNPP86n6tPAODjTn2Y6FCYV6Xe7
         QhlHhbTzsnduZ8M8NvPjn5lAuq9kVI0G0Z2BUI+q51dDRpMzpYnbWMZwllkDQ6uur6ax
         euQogwmxkMZnAkOUx4b6ogcUS4GIqxl7O4EXMG1gz1KwbBojJ76wrq8dtq0PqmMhx/mj
         xmJmw2Kb+cV2XQFzooZ4IGX+JUN+BwtI7YF5VMBjiCcdrU4raqHQVhtkFmAluBG2E9oY
         RykA==
X-Forwarded-Encrypted: i=1; AJvYcCXYmnPc+AgZ+RAGA0sIyju0uL2nYBoRvVCY3bOE1ufigv+AyntYkBu4yauigJPrF+np6BXb4IC6@vger.kernel.org, AJvYcCXtOf5brDExFZiNtalcql/qR2ZBcBTH6IejJw35LWgSVNjy22Sus9Cd2fqIlTsT1doo1Obfcl/nbcyLCR+scDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVHKR2bzcX3+nJl3B02I9A26GKd4I2Ary2Y9v/WNNHvoWmCsUH
	Ql1GRmdwv2NomaVTLA/vypJaOAVnltjomLAFaioArWWVkOalOUXL
X-Gm-Gg: ASbGnct5HCNR1ElK91ovNfR5Z0CnSDt7KF3Y54eD4oUSyU1DNPdtsLYCXR8FCFnKJey
	UCtVhSmfr/gywZP5K5/9SqUGgsjaccxidW50lh8LG86uAE3CxNJH7LnLma2mZmp1M94Dk9XZnQA
	04nafgh+NUK709gZNkbompeQxDU7HKYccvGzY/f9R3wqcYf3zz7ONLBcl1KcKnyZfM+rdnEtpQ0
	8XaJ0+Jja+Cpo9ODpsga7kkENlJKuAxpmB75dbML82ESj58HpGXVBlztZXewgwGMUhzMDUACpwC
	XY5QmgFpCuqLgvmbtqUpOQg5zQvKcHztMfzUD6AM0UngDzRtaBgxbCOzUNcOEkuEURz4xVsV4J2
	X9DN4cKdnkiJ6x5LfhqqNOA==
X-Google-Smtp-Source: AGHT+IFtT0hSw7HraNbw576jDJbpoIeXcmG2BCJkM4+BmItxY4vf6/QI2fZfsREyRD5o2pRrk5pFGg==
X-Received: by 2002:a05:622a:230a:b0:476:a895:7e82 with SMTP id d75a77b69052e-47710dd04c0mr70818741cf.50.1742482194174;
        Thu, 20 Mar 2025 07:49:54 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4771d179ea2sm27451cf.27.2025.03.20.07.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 07:49:53 -0700 (PDT)
Date: Thu, 20 Mar 2025 10:49:53 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
 Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Pauli Virtanen <pav@iki.fi>, 
 linux-bluetooth@vger.kernel.org, 
 netdev@vger.kernel.org, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 willemdebruijn.kernel@gmail.com
Message-ID: <67dc2b111b3cf_a8274294af@willemb.c.googlers.com.notmuch>
In-Reply-To: <CABBYNZJk2QjUaJCurAocMAJdOTfFHCjKO_S2rcxWLwTv8K9VDw@mail.gmail.com>
References: <cover.1742324341.git.pav@iki.fi>
 <0dfb22ec3c9d9ed796ba8edc919a690ca2fb1fdd.1742324341.git.pav@iki.fi>
 <6cf69a7e-da5d-49da-ab05-4523f2914254@molgen.mpg.de>
 <CABBYNZJk2QjUaJCurAocMAJdOTfFHCjKO_S2rcxWLwTv8K9VDw@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] net-timestamp: COMPLETION timestamp on packet tx
 completion
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Luiz Augusto von Dentz wrote:
> Hi Pauli, Willem, Jason,
> =

> On Wed, Mar 19, 2025 at 11:48=E2=80=AFAM Paul Menzel <pmenzel@molgen.mp=
g.de> wrote:
> >
> > Dear Pauli,
> >
> >
> > Thank you for your patch. Two minor comments, should you resend.
> >
> > You could make the summary/title a statement:
> >
> > Add COMPLETION timestamp on packet tx completion
> >
> > Am 18.03.25 um 20:06 schrieb Pauli Virtanen:
> > > Add SOF_TIMESTAMPING_TX_COMPLETION, for requesting a software times=
tamp
> > > when hardware reports a packet completed.
> > >
> > > Completion tstamp is useful for Bluetooth, as hardware timestamps d=
o not
> > > exist in the HCI specification except for ISO packets, and the hard=
ware
> > > has a queue where packets may wait.  In this case the software SND
> > > timestamp only reflects the kernel-side part of the total latency
> > > (usually small) and queue length (usually 0 unless HW buffers
> > > congested), whereas the completion report time is more informative =
of
> > > the true latency.
> > >
> > > It may also be useful in other cases where HW TX timestamps cannot =
be
> > > obtained and user wants to estimate an upper bound to when the TX
> > > probably happened.
> > >
> > > Signed-off-by: Pauli Virtanen <pav@iki.fi>
> > > ---
> > >
> > > Notes:
> > >      v5:
> > >      - back to decoupled COMPLETION & SND, like in v3
> > >      - BPF reporting not implemented here
> > >
> > >   Documentation/networking/timestamping.rst | 8 ++++++++
> > >   include/linux/skbuff.h                    | 7 ++++---
> > >   include/uapi/linux/errqueue.h             | 1 +
> > >   include/uapi/linux/net_tstamp.h           | 6 ++++--
> > >   net/core/skbuff.c                         | 2 ++
> > >   net/ethtool/common.c                      | 1 +
> > >   net/socket.c                              | 3 +++
> > >   7 files changed, 23 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/Documentation/networking/timestamping.rst b/Documentat=
ion/networking/timestamping.rst
> > > index 61ef9da10e28..b8fef8101176 100644
> > > --- a/Documentation/networking/timestamping.rst
> > > +++ b/Documentation/networking/timestamping.rst
> > > @@ -140,6 +140,14 @@ SOF_TIMESTAMPING_TX_ACK:
> > >     cumulative acknowledgment. The mechanism ignores SACK and FACK.=

> > >     This flag can be enabled via both socket options and control me=
ssages.
> > >
> > > +SOF_TIMESTAMPING_TX_COMPLETION:
> > > +  Request tx timestamps on packet tx completion.  The completion
> > > +  timestamp is generated by the kernel when it receives packet a
> > > +  completion report from the hardware. Hardware may report multipl=
e
> >
> > =E2=80=A6 receives packate a completion =E2=80=A6 sounds strange to m=
e, but I am a
> > non-native speaker.
> >
> > [=E2=80=A6]
> >
> >
> > Kind regards,
> >
> > Paul
> =

> Is v5 considered good enough to be merged into bluetooth-next and can
> this be send to in this merge window or you think it is best to leave
> for the next? In my opinion it could go in so we use the RC period to
> stabilize it.

I'm fine with merging as is.

Most of my comments were design points for consideration. If Pauli
prefers as is, no objections from me.

For the series:

Reviewed-by: Willem de Bruijn <willemb@google.com>


