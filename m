Return-Path: <netdev+bounces-227284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B26F2BABCCF
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 09:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 635231C82CF
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 07:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37CF25C6E2;
	Tue, 30 Sep 2025 07:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7aK9JOT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DBF277CA8
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 07:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759216963; cv=none; b=evB4yymgtHKUU9TbMoSGF6+VRkhAjkk1HSO0Sn0FSOJT4t4D+lhdUbOoRcO6VzcysWEjl0oDOpMqzWbyFbeFylSqWcxAdj+J6ETZAAIuyR75rUtx6ZvXWcvWagKTxXIeC3TkbkAQEYFl2FJbdql6b425ck8zhAxEuqi+gtLbcVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759216963; c=relaxed/simple;
	bh=4+J6DAmgVeDiDH7AQd4ZzIWmmBy63eSJyLwXO0xd564=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J6uDp6OSte5w5Y56JAYeUtA3LTa+XpMNNLmMcUcmnq17q9IOoi9UtivSVE4ZSxD2sEzr4nyH2sQE0+1Dkkkb+5leM8Bi3AD7CGEENH/AZJxMc6I3h3E/SDUl4gj2dHUwiMc+oEtIramz6qpUqvwGfGZh2eB8gBe+NPCWlS32hAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j7aK9JOT; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3ee12807d97so4840659f8f.0
        for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 00:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759216960; x=1759821760; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mPS2J05zy1FwzOLEXW/VwsbtdbwJ0d4YPVdkTHC55KM=;
        b=j7aK9JOT3DXwtLFrPglhG3tdDM8j2HFa5TqgfV/Jhz04S2KbGKEEX3/UAFxJ5Jup9n
         wZknAC/ElYv03F3Y5BxqEhWWhbaM9Ic7f2XO4UQIciRJDSgOXbxnb4CMndUGP2yQ1GY6
         +FV4wNL4Qva3dPINEc7L+80XFtj4kb9Bd73nTRzwjDTR1U53oUFaT8tph9nB3eRx82ds
         QmgTZbg7+MMOrnMX4TRf35xIvmTtly8XfMpTkOGC/B+BJH45QtWeS91q1qhjhpJKMDKA
         tfMAitg0VU/srgWvfVbQ0n/HnucmiTIgjwsi6QogGp+0zZTJdhT8QLwKTDKfjWtTUzxt
         vU/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759216960; x=1759821760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mPS2J05zy1FwzOLEXW/VwsbtdbwJ0d4YPVdkTHC55KM=;
        b=T0FRCymmAZ70cVM/sseYsgnE+LBoKJ8d3XqmvQ9S4Nc0wh2nRCSI5L9VhKWiJDhoZQ
         X2QBg9+0ttWBc7LGVubOBRxQiTDBDN9mxrY7sQuRaIyWFWxdUdnfiomppQL+1cU1W3yi
         NQidZIJVx412HhllUsrOwlmefpNkjypgLNi+/W8OfTEComrG/Y5J1yVvU6WMgxCDeyL6
         rdQc+kOvqWynDrQagyncKf8/jwCcAAI1rGRFBFkMD8AFOMvkJR++d1sycOKldlBg44YN
         WsHCKTXGXXhSVPJvcfIY7LSEohsDrO4PjGSklt7kADX+n+oDjr8L7xIh+To+fM3kErh0
         Hflg==
X-Forwarded-Encrypted: i=1; AJvYcCWqFVpQo3XWXW/ajy1nSQN2r02WjFKsZynhiF4gVSCF8QYO1AZHD7pksKkJLgZvRlWOVyqswQE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/hB5aDsEHQaXIuQvaZg8KEwei7A1uSfXG+Pc+nniNlGTGrjeW
	w2WbiQ5SaytrW7SLCNpUo5JxKseLxuJInVr9XlI7YtPyjLAt4yHy2Z41mUpTK0S4ilzhfsXkY3h
	iAG1KtP9KrxHESBtrAYb1XnRvJhZahHA=
X-Gm-Gg: ASbGncstWcPEPhMUAWHDvxbSonrIDEVPV5QNZCcqfaa1pji1p68XFH+oL1tyfZFk/Bg
	1VlXGUg2bc//4lz8rO4Cv0L+h5Psk9iZ56rKFMj/klvqjF7Xzvo+aruS+BaH6KFaVOfq8AUlHRi
	HYc33pzF+M0FD/26ZP3jeeEX2te2ql0L/itGKCbo4e3OTgyJy+oOVFtmQWwr2HViVwe/cdnoAab
	HXN6KHmxNtkDFi/qYHdVU35FpH1EtozDKCftz4=
X-Google-Smtp-Source: AGHT+IFdJfHOwZ1S1niYEb77rqlQtLyXMq4N4eWPriFzC0/mQ4E4Sepzu/0N45x68nG5z1SVq9bh1GpS+8LSNamkP+o=
X-Received: by 2002:a05:6000:1884:b0:3eb:4e88:585 with SMTP id
 ffacd0b85a97d-40e4bb2f61dmr17721810f8f.29.1759216959532; Tue, 30 Sep 2025
 00:22:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250624213801.31702-1-ryazanov.s.a@gmail.com>
 <CAFEp6-08JX1gDDn2-hP5AjXHCGsPYHe05FscQoyiP_OaSQfzqQ@mail.gmail.com>
 <fc1f5d15-163c-49d7-ab94-90e0522b0e57@gmail.com> <CAFEp6-1xoFW6xpQHPN4_XNtbjwvW=TUdFrOkFKwM+-rEH7WqMg@mail.gmail.com>
 <e8d7bab.2987.19936a78b86.Coremail.slark_xiao@163.com> <19a5c6e0-fd2a-4cba-92ed-b5c09d68e90c@gmail.com>
 <317b6512.6a9b.1995168196c.Coremail.slark_xiao@163.com> <CAFEp6-0jAV9XV-v5X_iwR+DzyC-qytnDFaRubT2KEQav1KzTew@mail.gmail.com>
 <CAGRyCJG-JvPu5Gizn8qEZy0QNYgw6yVxz6_KW0K0HUfhZsrmbw@mail.gmail.com>
In-Reply-To: <CAGRyCJG-JvPu5Gizn8qEZy0QNYgw6yVxz6_KW0K0HUfhZsrmbw@mail.gmail.com>
From: Daniele Palmas <dnlplm@gmail.com>
Date: Tue, 30 Sep 2025 09:10:28 +0200
X-Gm-Features: AS18NWDEbjUMYctvdnTLHwUgmVdb3TDvWale_FqBdOM3uKVYUUcIS-1FBqRSIZg
Message-ID: <CAGRyCJE28yf-rrfkFbzu44ygLEvoUM7fecK1vnrghjG_e9UaRA@mail.gmail.com>
Subject: Re: Re: [RFC PATCH v2 0/6] net: wwan: add NMEA port type support
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Slark Xiao <slark_xiao@163.com>, Sergey Ryazanov <ryazanov.s.a@gmail.com>, 
	Muhammad Nuzaihan <zaihan@unrealasia.net>, Johannes Berg <johannes@sipsolutions.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, Qiang Yu <quic_qianyu@quicinc.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Johan Hovold <johan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Loic and Sergey,

Il giorno lun 22 set 2025 alle ore 22:19 Daniele Palmas
<dnlplm@gmail.com> ha scritto:
>
> Hi Loic,
>
> Il giorno lun 22 set 2025 alle ore 10:03 Loic Poulain
> <loic.poulain@oss.qualcomm.com> ha scritto:
> >
> > Adding Daniele,
> >
> > On Tue, Sep 16, 2025 at 9:23=E2=80=AFAM Slark Xiao <slark_xiao@163.com>=
 wrote:
> > >
> > >
> > > At 2025-09-15 00:43:05, "Sergey Ryazanov" <ryazanov.s.a@gmail.com> wr=
ote:
> > > >Hi Slark,
> > > >
> > > >On 9/11/25 05:42, Slark Xiao wrote:
> > > >> At 2025-06-30 15:30:14, "Loic Poulain" <loic.poulain@oss.qualcomm.=
com> wrote:
> > > >>> On Sun, Jun 29, 2025 at 12:07=E2=80=AFPM Sergey Ryazanov <ryazano=
v.s.a@gmail.com> wrote:
> > > >>>> On 6/29/25 05:50, Loic Poulain wrote:
> > > >>>>> On Tue, Jun 24, 2025 at 11:39=E2=80=AFPM Sergey Ryazanov <ryaza=
nov.s.a@gmail.com> wrote:
> > > >>>>>> The series introduces a long discussed NMEA port type support =
for the
> > > >>>>>> WWAN subsystem. There are two goals. From the WWAN driver pers=
pective,
> > > >>>>>> NMEA exported as any other port type (e.g. AT, MBIM, QMI, etc.=
). From
> > > >>>>>> user space software perspective, the exported chardev belongs =
to the
> > > >>>>>> GNSS class what makes it easy to distinguish desired port and =
the WWAN
> > > >>>>>> device common to both NMEA and control (AT, MBIM, etc.) ports =
makes it
> > > >>>>>> easy to locate a control port for the GNSS receiver activation=
.
> > > >>>>>>
> > > >>>>>> Done by exporting the NMEA port via the GNSS subsystem with th=
e WWAN
> > > >>>>>> core acting as proxy between the WWAN modem driver and the GNS=
S
> > > >>>>>> subsystem.
> > > >>>>>>
> > > >>>>>> The series starts from a cleanup patch. Then two patches prepa=
res the
> > > >>>>>> WWAN core for the proxy style operation. Followed by a patch i=
ntroding a
> > > >>>>>> new WWNA port type, integration with the GNSS subsystem and de=
mux. The
> > > >>>>>> series ends with a couple of patches that introduce emulated E=
MEA port
> > > >>>>>> to the WWAN HW simulator.
> > > >>>>>>
> > > >>>>>> The series is the product of the discussion with Loic about th=
e pros and
> > > >>>>>> cons of possible models and implementation. Also Muhammad and =
Slark did
> > > >>>>>> a great job defining the problem, sharing the code and pushing=
 me to
> > > >>>>>> finish the implementation. Many thanks.
> > > >>>>>>
> > > >>>>>> Comments are welcomed.
> >
> > Daniele, do you think this feature could be relevant for Telit
> > modules, assuming any of them expose an NMEA channel?
> > Is that something you could test?
> >
>
> yeah, I think this is something I can test, not completely sure about whe=
n.
>
> But I'll try to have a look at this at worst in the next week.
>

I've finally found the time to have a try and after adding basic
support for the NMEA channels to mhi_pci_generic and mhi_wwan_ctrl,
besides a small build problem when applying the patches to net-next,
solved by changing:

diff --git a/drivers/net/wwan/wwan_hwsim.c b/drivers/net/wwan/wwan_hwsim.c
index a748b3ea1602..e4b1bbff9af2 100644
--- a/drivers/net/wwan/wwan_hwsim.c
+++ b/drivers/net/wwan/wwan_hwsim.c
@@ -236,7 +236,7 @@ static void wwan_hwsim_nmea_emul_timer(struct timer_lis=
t *t)
        /* 43.74754722298909 N 11.25759835922875 E in DMM format */
        static const unsigned int coord[4 * 2] =3D { 43, 44, 8528, 0,
                                                   11, 15, 4559, 0 };
-       struct wwan_hwsim_port *port =3D from_timer(port, t, nmea_emul.time=
r);
+       struct wwan_hwsim_port *port =3D timer_container_of(port, t,
nmea_emul.timer);

it's basically working fine in operative mode though there's an issue
at the host shutdown, not able to properly terminate.

Unfortunately I was not able to gather useful text logs besides the picture=
 at

https://drive.google.com/file/d/13ObWikuiMMUENl2aZerzxFBg57OB1KNj/view?usp=
=3Dsharing

showing an oops with the following call stack:

__simple_recursive_removal
preempt_count_add
__pfx_remove_one
wwan_remove_port
mhi_wwan_ctrl_remove
mhi_driver_remove
device_remove
device_del

but the issue is systematic. Any idea?

At the moment I don't have the time to debug this deeper, I don't even
exclude the chance that it could be somehow related to the modem. I
would like to further look at this, but I'm not sure exactly when I
can....

Thanks,
Daniele

> Regards,
> Daniele
>
> > Regards,
> > Loic

