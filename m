Return-Path: <netdev+bounces-78673-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8244A87617A
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 11:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 113051F2284D
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 10:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83158537FE;
	Fri,  8 Mar 2024 10:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=x3me.net header.i=@x3me.net header.b="FRTYV9oZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6929535D7
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 10:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709892316; cv=none; b=pudGHz1Gf0Ix1f8K41qiD535dOG1bTydVLcMmVRbX7yC9YlH+nGfRI0eL2I8bzIHHueSIeFJuIGia3dEgweNNqO1NbrWPJYfxSdLHcY8lF3Gb58Jxc4z27eHX+Ul6AETVbaeetXml2R3lyd/vrbzLt+mbZEIe2QEwPjARzYjxWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709892316; c=relaxed/simple;
	bh=+JsC9kVcuoeyBGL06ElRY8q63SHUHJRoVSSWXwFzVxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qAmv+WlLav639naha1NKOMX3HICRHCq/aTzxfrywuQtSJXacNmKH2bNyZx/EtMuAbuON7ROtdRuKWshaOwQ1YkSLLGczoHj13frEw6wgxrUbPMX1l5ipskaCMsL7gykS62k8ND17ru3IZuaIVcS1DXibXyt/996NISXe8nBv/CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=x3me.net; spf=pass smtp.mailfrom=x3me.net; dkim=pass (2048-bit key) header.d=x3me.net header.i=@x3me.net header.b=FRTYV9oZ; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=x3me.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=x3me.net
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5658082d2c4so2403245a12.1
        for <netdev@vger.kernel.org>; Fri, 08 Mar 2024 02:05:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=x3me.net; s=google; t=1709892312; x=1710497112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+UYHIfaM2T8vXde5QmGd/QU0wtuc74f5Nu4OsIp7LrU=;
        b=FRTYV9oZvZu+5vW4CL4OuaGukwiWLqsh1bUQ7Jf68oIj3Z6nlFd6PmbgPdIhjMgDLN
         IbX0r7LM9nYAoyys2ypx+J92ZMK7iSU5m9w3HiTYyIUoLGvkJFQzHJVTmJrr2/u8XX8a
         CsS8PNx9cdhqCLdLhgFjiocDwlAnbiY8HfXJCcMARLJmdxtmB4mi4bmVOadkhBXuanpn
         zk1HZn7cnEZFVQZzlwT/wUvVXJiAvJUgm/M3qbdivgE+PRNR5t+oRXgq0hRQoKfndpNR
         QPUiL0rITCcl0Km63PxGs6rxv+pigeCKRCIIamy7VkAJ4GQqc/ho712KzxDyZqhhT1ku
         jHwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709892312; x=1710497112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+UYHIfaM2T8vXde5QmGd/QU0wtuc74f5Nu4OsIp7LrU=;
        b=A3rqoEC10YVKVSHW05jsDZXQLaHorfrij2aB2MuTiZ48j7yTemZHSX29grp1OaWAea
         gaix2fK1JCUsRJcgMW5fMGuE+MnJnYBUR0mRjZ33NoakrHtARsmMyPBHmJzNn9ebiD4i
         fmbpTErbsD2bb132mEsYryex9KgTiSGdN5DTgNB7edvOU338U4lFF/jWlHZqgWJvuaF9
         5ZZm9UPynOym2WPwLjZQRH8dgmCpHpsLg+TBMg2bQdUhBKUEEz2hY4AiRYNOehuQgpkP
         Z7PyCbeYnYmujbomZGo93UCifH5OaulhWDTlzpL+cfdGpGQzdcntD0ZQvz5Hs9R6C59R
         lENA==
X-Forwarded-Encrypted: i=1; AJvYcCUC/onKobL5zcf/Efyo3ft4yGEigckLQQTlJvbrcMtBIVDIPHjX+94mhfFULnrkqZ/5CEkPK0pLWhwKG+QJIl4Xd2OfAHpE
X-Gm-Message-State: AOJu0Yzi74zPwSbtTZEd23PQtJHiMcSkppInpiqIb/CAlRmgQ7TsOorR
	eT1NTJx+tHbrAMum6SHA3njY8Htqp7I6xFfQSo7zT3nRbdI0Nt6/VuBvr7wtC4rS8q24ft/Z6lL
	1rnMj7svtGkgaYju1T7IRFvYlDOTz0zQbP78JRd5AZQFBfCfi
X-Google-Smtp-Source: AGHT+IE8A86Ms4d0gzTb/ycb8qvPq02+6gtwBsXuNXLicWeYk//TxY9O5OfbtCsjUa/hjTv2KO2nJmxDbSQfD3CK3og=
X-Received: by 2002:a17:907:100a:b0:a44:4e9a:8cc2 with SMTP id
 ox10-20020a170907100a00b00a444e9a8cc2mr14385839ejb.58.1709892312031; Fri, 08
 Mar 2024 02:05:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJEV1ig2Gyqb2MPHU+qN_G7XDVNZffU5HDm5VkoGev_QOe7bXg@mail.gmail.com>
 <87r0hyzxbd.fsf@toke.dk> <CAJ8uoz0bZjeJKJbCOfaogJZg2o5zoWNf3XjAF-4ZubpxDoQhcg@mail.gmail.com>
 <CAJEV1ihnwDxkkeMtAkkkZpP5O-VMxVvJojLs6dMbeMYgsn7sGA@mail.gmail.com>
 <ZcPTNpzGyqQI+DXw@boxer> <CAJEV1ihMuP6Oq+=ubd05DReBXuLwmZLYFwO=ha2C995wBuWeLA@mail.gmail.com>
 <CAJEV1igugU1SjcWnjYgoG0x_stExm0MyxwdFN0xycSb9sadkXw@mail.gmail.com>
 <CAJEV1ijnUrJXOuGW5xnuCvMTtaC1VKhOXQ0_4iJnqR5Vco4yLg@mail.gmail.com>
 <Zc+aN4rYKZKu3vKx@boxer> <CAJEV1ij+fYUhXmscxk_tsgDppHFWZLuP_bc_gUhZPLMdi4qLQA@mail.gmail.com>
 <ZdNsJzWpho81ichG@boxer>
In-Reply-To: <ZdNsJzWpho81ichG@boxer>
From: Pavel Vazharov <pavel@x3me.net>
Date: Fri, 8 Mar 2024 12:05:00 +0200
Message-ID: <CAJEV1ihSfRe3PK60UG1gWezOSMBG4thFcU4KGi+9VxgTfNb9Yg@mail.gmail.com>
Subject: Re: Need of advice for XDP sockets on top of the interfaces behind a
 Linux bonding device
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Magnus Karlsson <magnus.karlsson@gmail.com>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 4:56=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Mon, Feb 19, 2024 at 03:45:24PM +0200, Pavel Vazharov wrote:
>
> [...]
>
> > > > We changed the setup and I did the tests with a single port, no
> > > > bonding involved.
> > > > The port was configured with 16 queues (and 16 XSK sockets bound to=
 them).
> > > > I tested with about 100 Mbps of traffic to not break lots of users.
> > > > During the tests I observed the traffic on the real time graph on t=
he
> > > > remote device port
> > > > connected to the server machine where the application was running i=
n
> > > > L3 forward mode:
> > > > - with zero copy enabled the traffic to the server was about 100 Mb=
ps
> > > > but the traffic
> > > > coming out of the server was about 50 Mbps (i.e. half of it).
> > > > - with no zero copy the traffic in both directions was the same - t=
he
> > > > two graphs matched perfectly
> > > > Nothing else was changed during the both tests, only the ZC option.
> > > > Can I check some stats or something else for this testing scenario
> > > > which could be
> > > > used to reveal more info about the issue?
> > >
> > > FWIW I don't see this on my side. My guess would be that some of the
> > > queues stalled on ZC due to buggy enable/disable ring pair routines t=
hat I
> > > am (fingers crossed :)) fixing, or trying to fix in previous email. Y=
ou
> > > could try something as simple as:
> > >
> > > $ watch -n 1 "ethtool -S eth_ixgbe | grep rx | grep bytes"
> > >
> > > and verify each of the queues that are supposed to receive traffic. D=
o the
> > > same thing with tx, similarly.
> > >
> > > >
> > > > > >
> > Thank you for the help.
> >
> > I tried the given patch on kernel 6.7.5.
> > The bonding issue, that I described in the above e-mails, seems fixed.
> > I can no longer reproduce the issue with the malformed LACP messages.
>
> Awesome! I'll send a fix to lists then.
>
> >
> > However, I tested again with traffic and the issue remains:
> > - when traffic is redirected to the machine and simply forwarded at L3
> > by our application only about 1/2 - 2/3 of it exits the machine
> > - disabling only the Zero Copy (and nothing else in the application)
> > fixes the issue
> > - another thing that I noticed is in the device stats - the Rx bytes
> > looks OK and the counters of every queue increase over the time (with
> > and without ZC)
> > ethtool -S eth4 | grep rx | grep bytes
> >      rx_bytes: 20061532582
> >      rx_bytes_nic: 27823942900
> >      rx_queue_0_bytes: 690230537
> >      rx_queue_1_bytes: 1051217950
> >      rx_queue_2_bytes: 1494877257
> >      rx_queue_3_bytes: 1989628734
> >      rx_queue_4_bytes: 894557655
> >      rx_queue_5_bytes: 1557310636
> >      rx_queue_6_bytes: 1459428265
> >      rx_queue_7_bytes: 1514067682
> >      rx_queue_8_bytes: 432567753
> >      rx_queue_9_bytes: 1251708768
> >      rx_queue_10_bytes: 1091840145
> >      rx_queue_11_bytes: 904127964
> >      rx_queue_12_bytes: 1241335871
> >      rx_queue_13_bytes: 2039939517
> >      rx_queue_14_bytes: 777819814
> >      rx_queue_15_bytes: 1670874034
> >
> > - without ZC the Tx bytes also look OK
> > ethtool -S eth4 | grep tx | grep bytes
> >      tx_bytes: 24411467399
> >      tx_bytes_nic: 29600497994
> >      tx_queue_0_bytes: 1525672312
> >      tx_queue_1_bytes: 1527162996
> >      tx_queue_2_bytes: 1529701681
> >      tx_queue_3_bytes: 1526220338
> >      tx_queue_4_bytes: 1524403501
> >      tx_queue_5_bytes: 1523242084
> >      tx_queue_6_bytes: 1523543868
> >      tx_queue_7_bytes: 1525376190
> >      tx_queue_8_bytes: 1526844278
> >      tx_queue_9_bytes: 1523938842
> >      tx_queue_10_bytes: 1522663364
> >      tx_queue_11_bytes: 1527292259
> >      tx_queue_12_bytes: 1525206246
> >      tx_queue_13_bytes: 1526670255
> >      tx_queue_14_bytes: 1523266153
> >      tx_queue_15_bytes: 1530263032
> >
> > - however with ZC enabled the Tx bytes stats don't look OK (some
> > queues are like doing nothing) - again it's exactly the same
> > application
> > The sum bytes increase much more than the sum of the per queue bytes.
> > ethtool -S eth4 | grep tx | grep bytes ; sleep 1 ; ethtool -S eth4 |
> > grep tx | grep bytes
> >      tx_bytes: 256022649
> >      tx_bytes_nic: 34961074621
> >      tx_queue_0_bytes: 372
> >      tx_queue_1_bytes: 0
> >      tx_queue_2_bytes: 0
> >      tx_queue_3_bytes: 0
> >      tx_queue_4_bytes: 9920
> >      tx_queue_5_bytes: 0
> >      tx_queue_6_bytes: 0
> >      tx_queue_7_bytes: 0
> >      tx_queue_8_bytes: 0
> >      tx_queue_9_bytes: 1364
> >      tx_queue_10_bytes: 0
> >      tx_queue_11_bytes: 0
> >      tx_queue_12_bytes: 1116
> >      tx_queue_13_bytes: 0
> >      tx_queue_14_bytes: 0
> >      tx_queue_15_bytes: 0
>
> Yeah here we are looking at Tx rings, not XDP rings that are used for ZC.
> XDP rings were acting like rings hidden from user, issue has been brought
> several times but currently I am not sure if we have some unified approac=
h
> towards that. FWIW ixgbe currently doesn't expose them, sorry for
> misleading you.
>
> At this point nothing obvious comes to my mind but I can optimize Tx ZC
> path and then let's see where it will take us.
Thank you. I can help with some testing when/if needed.

>
> >
> >      tx_bytes: 257830280
> >      tx_bytes_nic: 34962912861
> >      tx_queue_0_bytes: 372
> >      tx_queue_1_bytes: 0
> >      tx_queue_2_bytes: 0
> >      tx_queue_3_bytes: 0
> >      tx_queue_4_bytes: 10044
> >      tx_queue_5_bytes: 0
> >      tx_queue_6_bytes: 0
> >      tx_queue_7_bytes: 0
> >      tx_queue_8_bytes: 0
> >      tx_queue_9_bytes: 1364
> >      tx_queue_10_bytes: 0
> >      tx_queue_11_bytes: 0
> >      tx_queue_12_bytes: 1116
> >      tx_queue_13_bytes: 0
> >      tx_queue_14_bytes: 0
> >      tx_queue_15_bytes: 0

