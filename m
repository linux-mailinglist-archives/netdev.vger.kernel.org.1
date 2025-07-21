Return-Path: <netdev+bounces-208539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8BADB0C0C7
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 11:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C8E53ABB74
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 09:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D30E28C2D3;
	Mon, 21 Jul 2025 09:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xs44hc6W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FB028C868
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 09:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753091837; cv=none; b=Bpe1mc9WXPHtZIZb/e2NrCZfmkV0xbqvIrx/wIlmD2XLA0/dPBFbtqkPgDdxEKntbuHOGa97ew/htehn5udnlQMD5f9KhLEdSP6+3b3NL5XuDhDeM1YDec+3qfw9sV3ck47Ru4nFLwGN1qxDoOfuJJNR+mVLHxv7RQ9jbRIADc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753091837; c=relaxed/simple;
	bh=RRhAqAMWrY4jec+/viIq2qenHB1vWUeWGKk97GFlOB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ni6U3j4XbhNVhuW8rKW/O/nRt15xGI4SYE0JtqbFWar7BfEFDfyHmpQKnX3QQJLRWdWkZwA6ntKeqq/qbBNILxjFR/CZw3md3S97cuEzs0BTtKARMCb8VZge5iM4dXgZB7ShtEpu88SxjkvPYvvNmaI+sh7ii8g714KcCwd/yxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xs44hc6W; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3df2dbe85d1so31480625ab.0
        for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 02:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753091835; x=1753696635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=taMZo6pydQCRBGSIZbvIqFAt83MtbeZxKyy642DFWnc=;
        b=Xs44hc6WNP/NvmKuMPFzBzYqfIOzjkbJVqiTKUPsUWi9yjx7IS1wfiYLeHVmoYDDDd
         Rieqx24QFUAd5DWNOA4Da+rpamhoFfsbvwGM6UCu/8v2DirwLK2MgYYr/gJwdqEpSnVX
         DTlm+equNfNH586PhROqD1lTh5FdXDSs3nSNQE1ILKRBZdXr3AgoOqtjqMctC0t/vsYg
         72z5F+36rCO/Hy3m9yL5KlN4hdbqoDW6H/8NxNXCcLmH6FxNJzmLY+Zlqvzzkjv+607L
         SihUBZCimrl4Jl/5ZTUyysZyXFLofzIRxv0FNrZZ9CCYXejF2+5qnqKy8l3kYxl7gcVI
         eg+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753091835; x=1753696635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=taMZo6pydQCRBGSIZbvIqFAt83MtbeZxKyy642DFWnc=;
        b=UJwk+zptgOtHixlWf1Zulto4rbMYpa7Qeg+YeL5oZoJnnpWIV6mCXyVJlownLIa4/5
         VAfOzOEwc6wrxyOK5FzEBVEZmGx7KNeIcBRD3+HhU0LVYfiR1f7HhqiuRt1dATHDELvl
         pcbBrr5pFMtbDFaHYh7W+hIAsXlAdlbh4mAfUuNbeCsaMpvMLu48WLYH4e1MrG0Bkoxm
         gd0gyhS0rWrDN5XxHD97c79yB6r/4A9ceQsUV+W+FV62UlEmQPA8/TRBC/9m6fh4mOws
         Z6MFEw8fKNL6QvuGvJ6Tj7/NwDkCBmSXx8g0g+HkGZmHpXZUMnocVCYAUn6Jyq0ZIT1G
         LxOg==
X-Forwarded-Encrypted: i=1; AJvYcCXIx1aKgcSPgnbKPgfOv8jTKMi3iXxAN+e/1BIf5MVQqByg5AIQZPBvvHKdr4yOe/Lj1HMN8pc=@vger.kernel.org
X-Gm-Message-State: AOJu0YypSHVZNrIXJt5WXPFKiYFmAfPvh/66Uymc0m8x6+pkzcnFIaK4
	tyDRLJ7fq7RGSSLwOawHyFC/v6NvVi4HX3C/zTalcCNKRugKwQT+yIWIK/ag4Si0TzrBkpBwDCy
	Mc1nNkL02uPiJ9GOojRxC/+ICy0pgeko=
X-Gm-Gg: ASbGnctTfEA0VtSp0wUIvxBEdZmpYBElOJ6VbQBeB9yXPegkRv946XzcTr5/DAKZyhJ
	2o4HOAJWblz4NBA2rgwaFDJwkmid+9jtEnKgyInjdm3taOFGJpTMhXd5uw9t0bQd/vOMxqeIotP
	kmOw7GVibNvbvryK3AEwonLpmgrQiZJAOyYtV37pdC3xOxV1gPMESSMFC585isjyRczKvSTo84e
	cRzHRw=
X-Google-Smtp-Source: AGHT+IEG1c4ENZShiBcMx7qrd4GO3hFaW/XXSsh5bk87LrmKPlFClSSZh6HzoCdHRp3T9nQzDSFchD+yKv2fPGQZjZk=
X-Received: by 2002:a05:6e02:3b0a:b0:3df:4234:df7b with SMTP id
 e9e14a558f8ab-3e282d62ac7mr241573455ab.3.1753091834502; Mon, 21 Jul 2025
 02:57:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL+tcoCTHTptwmok9vhp7GEwQgMhNsBJxT3PStJDeVOLR_-Q3g@mail.gmail.com>
 <aHohbwWCF0ccpmtj@soc-5CG4396X81.clients.intel.com> <CAL+tcoCJ9ghWVQ1afD_WJmx-3n+80Th7jPw-N-k9Z6ZjJErSkw@mail.gmail.com>
 <aH3rRHm8rQ35MqMd@soc-5CG4396X81.clients.intel.com> <CAL+tcoAQF_Aom4dn--RQzowiUO1haNPw=_Rzw2C7MJRF_sSUOw@mail.gmail.com>
 <aH4HNquLzjagCLeX@soc-5CG4396X81.clients.intel.com>
In-Reply-To: <aH4HNquLzjagCLeX@soc-5CG4396X81.clients.intel.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 21 Jul 2025 17:56:37 +0800
X-Gm-Features: Ac12FXwgh7Zd0MIstUca3D9v28GZp5nOp_WVPhOBZecXwtWxy0lla-HwnACjXlU
Message-ID: <CAL+tcoANWC5h2FdRkB470qmWYk9-f-SVbRmwiNqfXRXJn8JZBQ@mail.gmail.com>
Subject: Re: ixgbe driver stops sending normal data when using xsk
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, przemyslaw.kitszel@intel.com, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, intel-wired-lan@lists.osuosl.org, 
	netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 5:25=E2=80=AFPM Larysa Zaremba <larysa.zaremba@inte=
l.com> wrote:
>
> On Mon, Jul 21, 2025 at 05:03:07PM +0800, Jason Xing wrote:
> > On Mon, Jul 21, 2025 at 3:25=E2=80=AFPM Larysa Zaremba <larysa.zaremba@=
intel.com> wrote:
> > >
> > > On Sat, Jul 19, 2025 at 01:26:18PM +0800, Jason Xing wrote:
> > > > On Fri, Jul 18, 2025 at 6:27=E2=80=AFPM Larysa Zaremba <larysa.zare=
mba@intel.com> wrote:
> > > > >
> > > > > On Wed, Jul 16, 2025 at 11:41:42AM +0800, Jason Xing wrote:
> > > > > > Hi all,
> > > > > >
> > > > > > I'm currently faced with one tough issue caused by zero copy mo=
de in
> > > > > > xsk with ixgbe driver loaded. The case is that if we use xdpsoc=
k to
> > > > > > send descs, nearly at the same time normal packets from other t=
x
> > > > > > queues cannot be transmitted/completed at all.
> > > > > >
> > > > > > Here is how I try:
> > > > > > 1. run iperf or ping to see if the transmission is successful.
> > > > > > 2. then run "timeout 5 ./xdpsock -i enp2s0f0 -t  -z -s 64"
> > > > > >
> > > > > > You will obviously find the whole machine loses connection. It =
can
> > > > > > only recover as soon as the xdpsock is stopped due to timeout.
> > > > > >
> > > > > > I tried a lot and then traced down to this line in ixgbe driver=
:
> > > > > > ixgbe_clean_tx_irq()
> > > > > >     -> if (!(eop_desc->wb.status & cpu_to_le32(IXGBE_TXD_STAT_D=
D)))
> > > > > >             break;
> > > > > > The above line always 'breaks' the sending process.
> > > > > >
> > > > > > I also managed to make the external ixgbe 6.15 work and it turn=
ed out
> > > > > > to be the same issue as before.
> > > > > >
> > > > > > I have no idea on how to analyze further in this driver. Could =
someone
> > > > > > point out a direction that I can take? Is it a known issue?
> > > > > >
> > > > > > Thanks,
> > > > > > Jason
> > > > > >
> > > > >
> > > > > I was able to reproduce the described behaviour, xdpsock does bre=
ak the IP
> > > > > communication. However, in my case this was not because of ixgbe =
not being able
> > > > > to send, but because of queue 0 RX packets being dropped, which i=
s the indended
> > > > > outcome in xdpsock, even in Tx only mode.
> > > >
> > > > Thanks for your feedback. It would be great if you could elaborate
> > > > more on this. How did you spot that it's queue 0 that causes the
> > > > problem?
> > >
> > > If you do not specify -q parameter, xdpsock loads on the queue pair 0=
.
> > >
> > > > Why is xdpsock breaking IP communication intended?
> > >
> > > Because when a packet arrives on the AF_XDP-managed queue (0 in this =
case), the
> > > default xdpsock XDP program provided by libxdp returns XDP_REDIRECT e=
ven in
> > > tx-only mode, XDP_PASS for all other queues (1-39). XDP_REDIRECT resu=
lts in a
> > > packet leaving the kernel network stack, it is now managed by the AF_=
XDP
> > > userspace program. I think it is possible to modify libxdp to return =
XDP_PASS
> > > when the socket is tx-only.
> > >
> > > >
> > > > When you try i40e, you will find the connection behaves normally. P=
ing
> > > > can work as usual. As I depicted before, with ixgbe driver, ping ev=
en
> > > > doesn't work at all.
> > >
> > > I think this is due to RSS configuration, ping packets on i40e go to =
another
> > > queue.
> >
> > Thanks so much for your detailed explanation.
> >
> > But, I still doubt it's not the reason why xdpsock breaks with ixgbe
> > driver loaded because I tried the following commands:
> > 1. ping <ip>
> > 2. timeout 3 ./xdpsock -i enp2s0f0np0 -t -q 11  -z -s 64
> > Whatever the queue value I adjusted, ping always fails with
> > "Destination Host Unreachable" warning.
>
> First I would make sure, if the problem is from Rx or Tx. This is hard to=
 do

I ran tcpdump xxx & on the other machine (receiver) to see if there
were any incoming icmp packets first. It turned out to be no incoming
data at all. So I presume the problem happens on the tx side.

> with IP-level applications, because they fail if any of those does not wo=
rk.
>
> Please, try sending MAC packet with scapy using a following command:
> sendp(Ether(src=3D"<src MAC>", dst=3D"<dst MAC>")/IP(src=3D"<any IP>", ds=
t=3D"<another IP>")/UDP(sport=3D2000, dport=3D9091)/Raw(load=3D"xdp"), ifac=
e=3D"<src ifname>")
>
> First, send this from host to link partner while running `tcpdump -nn -e =
-p -i
> <ifname>` on link partner.
>
> Then send this from LK to host while running tcpdump on host.
>
> In both cases, note whether the packet shows up in tcpdump with and witho=
ut
> xdpsock loaded on the host.

Thanks for your guidance. But it probably takes me more time than
expected due to the whole connection being totally broken while
xdpsock is running :(

I ran tcpdump xxx > log & while running xdpsock. Later, I found that
there are as many packets as w/o xdpscok.

Thanks,
Jason

