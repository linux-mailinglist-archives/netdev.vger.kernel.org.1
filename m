Return-Path: <netdev+bounces-208307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC902B0AE17
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 07:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 241CA1AA16B8
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 05:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6628C17BED0;
	Sat, 19 Jul 2025 05:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIt+2CWX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A442D613
	for <netdev@vger.kernel.org>; Sat, 19 Jul 2025 05:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752902817; cv=none; b=kTg1/fi0kvWjUZVciHfcM126JnxCC9qzzaZ2aLD575lKh+ysHPQcvSh5zcDMcdxbvc7v0Gf6ypbHudv0yem+OI4U2K7uT8i/ZhlYW+WJFWHpeSBDH6uWjwEvjTyqL/I9WTzO2PtXrvfE4Yd3qcJ/Y8A9PSdTEtB/W1RjaXhZG44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752902817; c=relaxed/simple;
	bh=s1sYdC31x8d3/EdpQVvZKihX6rX2qh3nddpatp3CFJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mRNKXSILZT9sXGFE/nTQJY8nVwfhDggzUJkFkFFCjkhSmbuc93fc+7nFtO8BRrvgnbp6H8MMU4wmzDVzStPgwdw5JMJQFjROABRlHsUlg5C/6EEgqZIIYtFqu7fH3hK5XrrLNYqsDJWciNRkvGPHWohWKR9AxL221BfgfXZ/Pww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MIt+2CWX; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3df210930f7so12962515ab.1
        for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 22:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752902815; x=1753507615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ooeLQ4zGTNne86A0UA5I+phnmQ0cuyVzXhSfouJGCk=;
        b=MIt+2CWXP2kAH9iueov1tevnZF/hQ0lhWEWrIJTFyWccWa9fnk7tyVKboTNp6jZXtt
         +TQ8hLvrwgR2URC6yppuWddZ3YnIoA0Gpn97mpX97Te5l1fv1QtDualKEtsLkrie797i
         zhZmaC6BXGvPv1c68LvsqLjeG2g7ckwteE/xqyEtlfLPemrprWeBWbmoDT2O6pWsbH73
         coOWZunQLR7iitHtbu9z99Huvv9sIfoGKGz4EVIy5PnebmWUiHE9DUVPImQbr1u02Cgz
         7LyOd8KepPcMsEFPBi3h5b2V7V8z4P3h0T7XEDTQWzlidYlNsLWWemYUcxA6FTRXmIw7
         +QWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752902815; x=1753507615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ooeLQ4zGTNne86A0UA5I+phnmQ0cuyVzXhSfouJGCk=;
        b=e8PLiFKP8oxP3JNH7Ji8HEVGgYg8l/UqocIgr/1VIZkHrhTxDsM+wjuN4YoM+YL1Rd
         rN9Hu4tdVViG5yweaXwiMVS5DozcY9BKLWeKvabQKqICZhhR2b2P0CROQ5YnyEg8cLX9
         mGDgcj9phW9xVVUr5eJfjmBbJBciaCL158WBTgliocd1r97NpyirRLiyySHqBCLyDmbV
         ssMcWD2x4doP7o1JMm6SXpdZpy+DoM60DJnrCMlonGjS1G89jJvDXKblNjgfggWLh0K+
         dTZqUW211ZYEcTsLZiEZOxPBbnHBrHXH1qFkjvrMu2jaKn3Sa+y8dcfFYX3zuURnomWk
         Xp3A==
X-Forwarded-Encrypted: i=1; AJvYcCV5NcMT8nrwHrsOCxitl4buCePsnleAWM7vUFpmzNZR+T9LT5RE/RsL1vpIZ1EmiXMJ5184cpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeWYFcbriuIjPbAUatmrWyMmxEw6cbLsYfCQKMxy5NXUE5Yrez
	e+Q+KGfG8ZiZhea1f3hb3XxzQtTsUqPxuuiS/JYAwWm1tDH9mbToDNXn4U5liv4Qh4Iksisqzo4
	pAXv9AeAoVvIYpY8MwaudNLmY+aQvWWU=
X-Gm-Gg: ASbGncvSkhneSYqtvZPXmEoOdQjCgKb2RC8dQzHtxKn9LKMcctnl03LcW9XZVOabUuz
	hmK8g7A4tBxbEODfT33H6QJfd4bJlP6noELoak/MDqNI3ozm7oMn8fK7kpvCPaCYRgMHrK4MDB3
	NeRS9wLtweT6aCR6qZtFlDnavQr0dTsmkSP+IfxrnKKb+P0+3rE/JH7JPQnPJkNjEKNuESoyMtb
	j8Yp7I=
X-Google-Smtp-Source: AGHT+IHd5v0jT6NG2kgqyG4EeeCtSp7LmOVQY2GbX6PDeBeo69dTItMmMe8E6wuAAaeJbQp2XUYa5BmkfaBjO0diLX0=
X-Received: by 2002:a05:6e02:4513:b0:3dd:bb43:1fc0 with SMTP id
 e9e14a558f8ab-3e295a89951mr35283525ab.11.1752902814490; Fri, 18 Jul 2025
 22:26:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL+tcoCTHTptwmok9vhp7GEwQgMhNsBJxT3PStJDeVOLR_-Q3g@mail.gmail.com>
 <aHohbwWCF0ccpmtj@soc-5CG4396X81.clients.intel.com>
In-Reply-To: <aHohbwWCF0ccpmtj@soc-5CG4396X81.clients.intel.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 19 Jul 2025 13:26:18 +0800
X-Gm-Features: Ac12FXwvfdEfdJ8HKmQX2AmC9Tuh52YC6mQkso_YplQU3aLWryMOSoSsL89nCp8
Message-ID: <CAL+tcoCJ9ghWVQ1afD_WJmx-3n+80Th7jPw-N-k9Z6ZjJErSkw@mail.gmail.com>
Subject: Re: ixgbe driver stops sending normal data when using xsk
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, przemyslaw.kitszel@intel.com, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, intel-wired-lan@lists.osuosl.org, 
	netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 6:27=E2=80=AFPM Larysa Zaremba <larysa.zaremba@inte=
l.com> wrote:
>
> On Wed, Jul 16, 2025 at 11:41:42AM +0800, Jason Xing wrote:
> > Hi all,
> >
> > I'm currently faced with one tough issue caused by zero copy mode in
> > xsk with ixgbe driver loaded. The case is that if we use xdpsock to
> > send descs, nearly at the same time normal packets from other tx
> > queues cannot be transmitted/completed at all.
> >
> > Here is how I try:
> > 1. run iperf or ping to see if the transmission is successful.
> > 2. then run "timeout 5 ./xdpsock -i enp2s0f0 -t  -z -s 64"
> >
> > You will obviously find the whole machine loses connection. It can
> > only recover as soon as the xdpsock is stopped due to timeout.
> >
> > I tried a lot and then traced down to this line in ixgbe driver:
> > ixgbe_clean_tx_irq()
> >     -> if (!(eop_desc->wb.status & cpu_to_le32(IXGBE_TXD_STAT_DD)))
> >             break;
> > The above line always 'breaks' the sending process.
> >
> > I also managed to make the external ixgbe 6.15 work and it turned out
> > to be the same issue as before.
> >
> > I have no idea on how to analyze further in this driver. Could someone
> > point out a direction that I can take? Is it a known issue?
> >
> > Thanks,
> > Jason
> >
>
> I was able to reproduce the described behaviour, xdpsock does break the I=
P
> communication. However, in my case this was not because of ixgbe not bein=
g able
> to send, but because of queue 0 RX packets being dropped, which is the in=
dended
> outcome in xdpsock, even in Tx only mode.

Thanks for your feedback. It would be great if you could elaborate
more on this. How did you spot that it's queue 0 that causes the
problem? Why is xdpsock breaking IP communication intended?

When you try i40e, you will find the connection behaves normally. Ping
can work as usual. As I depicted before, with ixgbe driver, ping even
doesn't work at all.

iperf is the one that I should not list... Because I find iperf always
doesn't work with either of them loaded.

>
> When I run `tcpdump -nn -e -p -i <ifname>` on the link partner, I see tha=
t the
> ixgbe host spams ARP packets just fine.

Interesting. I managed to see the same phenomenon.

I debugged the ixgbe and saw the following code breaks the whole
sending process:
ixgbe_clean_tx_irq()
     -> if (!(eop_desc->wb.status & cpu_to_le32(IXGBE_TXD_STAT_DD)))
             break;

Do you have any idea why?

>
> When debugging low-level stuff such as XDP, I advise you to send packets =
at the
> lower level, e.g. with scapy's sendp().
>
> In case you have a different problem, please provide lspci card descripti=
on and
> some truncated output of the commands that you are running and the result=
ing
> dmesg.

I'm not that sure if they are the same.

One of ixgbe machines that I manipulate looks like this:
# lspci -vv | grep -i ether
02:00.0 Ethernet controller: Intel Corporation Ethernet Controller
10-Gigabit X540-AT2 (rev 01)
02:00.1 Ethernet controller: Intel Corporation Ethernet Controller
10-Gigabit X540-AT2 (rev 01)

# dmesg -T|grep -i ixgbe
[Fri Jul 18 16:20:29 2025] ixgbe: Intel(R) 10 Gigabit PCI Express Network D=
river
[Fri Jul 18 16:20:29 2025] ixgbe: Copyright (c) 1999-2016 Intel Corporation=
.
[Fri Jul 18 16:20:29 2025] ixgbe 0000:02:00.0: Multiqueue Enabled: Rx
Queue count =3D 48, Tx Queue count =3D 48 XDP Queue count =3D 0
[Fri Jul 18 16:20:29 2025] ixgbe 0000:02:00.0: 32.000 Gb/s available
PCIe bandwidth (5.0 GT/s PCIe x8 link)
[Fri Jul 18 16:20:29 2025] ixgbe 0000:02:00.0: MAC: 3, PHY: 0, PBA No:
000000-000
[Fri Jul 18 16:20:29 2025] ixgbe 0000:02:00.0: f0:98:38:1a:5d:4e
[Fri Jul 18 16:20:29 2025] ixgbe 0000:02:00.0: Intel(R) 10 Gigabit
Network Connection
[Fri Jul 18 16:20:30 2025] ixgbe 0000:02:00.1: Multiqueue Enabled: Rx
Queue count =3D 48, Tx Queue count =3D 48 XDP Queue count =3D 0
[Fri Jul 18 16:20:30 2025] ixgbe 0000:02:00.1: 32.000 Gb/s available
PCIe bandwidth (5.0 GT/s PCIe x8 link)
[Fri Jul 18 16:20:30 2025] ixgbe 0000:02:00.1: MAC: 3, PHY: 0, PBA No:
000000-000
[Fri Jul 18 16:20:30 2025] ixgbe 0000:02:00.1: f0:98:38:1a:5d:4f
[Fri Jul 18 16:20:30 2025] ixgbe 0000:02:00.1: Intel(R) 10 Gigabit
Network Connection
[Fri Jul 18 16:20:30 2025] ixgbe 0000:02:00.0 enp2s0f0np0: renamed from eth=
0
[Fri Jul 18 16:20:30 2025] ixgbe 0000:02:00.1 enp2s0f1np1: renamed from eth=
1
[Fri Jul 18 16:20:38 2025] ixgbe 0000:02:00.0: registered PHC device
on enp2s0f0np0
[Fri Jul 18 16:20:38 2025] ixgbe 0000:02:00.0 enp2s0f0np0: NIC Link is
Up 1 Gbps, Flow Control: None
[Fri Jul 18 16:20:38 2025] ixgbe 0000:02:00.1: registered PHC device
on enp2s0f1np1
[Sat Jul 19 13:11:30 2025] ixgbe 0000:02:00.0: removed PHC on enp2s0f0np0
[Sat Jul 19 13:11:31 2025] ixgbe 0000:02:00.0: Multiqueue Enabled: Rx
Queue count =3D 48, Tx Queue count =3D 48 XDP Queue count =3D 48
[Sat Jul 19 13:11:31 2025] ixgbe 0000:02:00.0: registered PHC device
on enp2s0f0np0
[Sat Jul 19 13:11:31 2025] ixgbe 0000:02:00.0 enp2s0f0np0: NIC Link is
Up 1 Gbps, Flow Control: None
[Sat Jul 19 13:11:34 2025] ixgbe 0000:02:00.0: removed PHC on enp2s0f0np0
[Sat Jul 19 13:11:34 2025] ixgbe 0000:02:00.0: Multiqueue Enabled: Rx
Queue count =3D 48, Tx Queue count =3D 48 XDP Queue count =3D 0
[Sat Jul 19 13:11:35 2025] ixgbe 0000:02:00.0: registered PHC device
on enp2s0f0np0
[Sat Jul 19 13:11:35 2025] ixgbe 0000:02:00.0 enp2s0f0np0: NIC Link is
Up 1 Gbps, Flow Control: None

reproduce process:
1. timeout 3 ./xdpsock -i enp2s0f0np0 -t  -z -s 64
2. ping <another IP address>

Thanks,
Jason

