Return-Path: <netdev+bounces-208525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C1A6B0BF94
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 11:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25E8F174F75
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 09:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96202853EF;
	Mon, 21 Jul 2025 09:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EHxr95Il"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D1A3C463
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 09:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753088626; cv=none; b=kpIY7emndO26wun/88+Xae+oW04ZYrnWQ+v7ItGJvCK6oUMwigq9adsHGgrnyAnKl/Kmilffy1wHaVRxjVjGhkPG3uEG2vR/qC200eTkeJ6wyfLlUjkpy2GbKihqXcd32JuVe0hDteAqiRZTKZXOVsIoL8ZqdBJZ2DMQIhsEU+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753088626; c=relaxed/simple;
	bh=17Su3QvWce6wG35fbwPtzJkxgDkz5XdexTn5Fv5Cp7I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ma5v/Hyh+GOkVNIP3HJdXZaLdBWnDdKb9GxgKGzMArAjr0hAN2kJrQTCURO6LC6bSE+4Wff897VunHacJTmS6C4P6swisgw7L0dtnX3Dz3SC0QYhtAkzmAUj0PMalJdEvpVE0BV9Tz5OXYgZwf8rEJWggGeEV5bHcB0uz94b/5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EHxr95Il; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3e28058c18cso42786355ab.0
        for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 02:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753088624; x=1753693424; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eGz9tABlj+U/GQqGIPNZErlvt1NjJTBIq6a5O+QSzd0=;
        b=EHxr95IlPvbWHbz4X0QuhuF1Z3ZqLIv4FZwL6XcFJLCEs4hjdc3dMHnzuTrHMxciEm
         Twr8NDd2SYpD73Wi1wGe2i32Y62TcO3s3U27ctBpMLWRSg2KgYhVPQUERv0kuiNMm5XB
         6UBULUF5BBQzUK6a70RGoUHkn6hqATI3suqQPoqJXxTzPEzEZB7+HdRYW0DgmPaKUxzf
         89sciKfuBeDaE6d1ulsKJqRqzJOzzHQYO3ooRETEgpFUy5M4Fj8neWeyHapU1DgibT5b
         JeqGL3sjsNNa++cbnScpZVUpfO7fjEFCFcjt15mVhu9YWcYNFE9wmg1cQQfgYr3OHDI8
         dqvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753088624; x=1753693424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eGz9tABlj+U/GQqGIPNZErlvt1NjJTBIq6a5O+QSzd0=;
        b=cRry0FD+jpyGAXvxdZl/jyIEMI6Ebtzxw+ZVgiJZzE2GmzpPbsdMLkZENnMI7pwzpK
         F5snhL+caYoasbiU7UWcCDfM9v13fzMuG1SIYnALJOeG1ai4ngTwWR33s99ezgbhYKwP
         0u2uVlkx9mUu7DZRVr3DsV+quQ/4RPF6aasWl4ryVxZuhotuAj09EJZR6KFIdkrus36t
         BngoDxep+QVbVX7gQRu3WyY+1VGBcEw4YL38+RSwBLblj6yeNRUuGE13Qncng2eKBANP
         e+ZHvZStPQIuYrEzOAxbPGeaFQXJKlHhkdO+AcRapch5JrLYDqhim45fBTKJfe00G7hB
         yN/g==
X-Forwarded-Encrypted: i=1; AJvYcCXO0q4a6TXl0SOzLTQXX0vJV7zIhDwvFYc/R+H/vkeufPDk/qNy0goIskhYu7DdLGuO4sYNJzY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1+67CWUVEGI1MPh5sJ0lS6uhBw8BW6ji46oqZyzTrnVLjPGw1
	MS8GsooK9JwV1ZV9ARQyYOfnmy7E8NSEV3DS6Hjy0LWnqJGeO0pHyMTl4tv/I9k6E/8VHXqdUE9
	DmqJUtXkbf9PzleQyOicjhwNPHfrb3mww8l9XBbKaUw==
X-Gm-Gg: ASbGnctTQJakN0gGIFGzx1kXeOHRKbH2/zgdJthkufkw48y1vyn+7sjA+VxKv4LbnV7
	bmOyL9+0ESiMcxFt7OclXm7GbDrbNeagXRQ6fHda6Fo9tEIWELVFjUkjUUccwAj7PSqc2rLSBVk
	Zkh7wUwbMLp/qpJo9KGsx0wJZKScEAKWTcakzXtdpqYZO20QZcW1DXjGahwNo3y56/hnJazR6pr
	/Fteg==
X-Google-Smtp-Source: AGHT+IHBmuJ4qV9IXEf74vNoOSu9MKPOXTxuc6Ipnr/G9UnNSNFG1wh2bTO/QVE9Adxi2a/oLhwsvFNKrBvFv1AZ7pE=
X-Received: by 2002:a92:c26f:0:b0:3e2:9b48:4585 with SMTP id
 e9e14a558f8ab-3e29b48537amr120828795ab.3.1753088624175; Mon, 21 Jul 2025
 02:03:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAL+tcoCTHTptwmok9vhp7GEwQgMhNsBJxT3PStJDeVOLR_-Q3g@mail.gmail.com>
 <aHohbwWCF0ccpmtj@soc-5CG4396X81.clients.intel.com> <CAL+tcoCJ9ghWVQ1afD_WJmx-3n+80Th7jPw-N-k9Z6ZjJErSkw@mail.gmail.com>
 <aH3rRHm8rQ35MqMd@soc-5CG4396X81.clients.intel.com>
In-Reply-To: <aH3rRHm8rQ35MqMd@soc-5CG4396X81.clients.intel.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 21 Jul 2025 17:03:07 +0800
X-Gm-Features: Ac12FXzB9cHju70bPo1uCg6BdrKE5YjftjAU7o6wChSg7hKVFMxEiNutyLzNKj8
Message-ID: <CAL+tcoAQF_Aom4dn--RQzowiUO1haNPw=_Rzw2C7MJRF_sSUOw@mail.gmail.com>
Subject: Re: ixgbe driver stops sending normal data when using xsk
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, przemyslaw.kitszel@intel.com, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, intel-wired-lan@lists.osuosl.org, 
	netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 3:25=E2=80=AFPM Larysa Zaremba <larysa.zaremba@inte=
l.com> wrote:
>
> On Sat, Jul 19, 2025 at 01:26:18PM +0800, Jason Xing wrote:
> > On Fri, Jul 18, 2025 at 6:27=E2=80=AFPM Larysa Zaremba <larysa.zaremba@=
intel.com> wrote:
> > >
> > > On Wed, Jul 16, 2025 at 11:41:42AM +0800, Jason Xing wrote:
> > > > Hi all,
> > > >
> > > > I'm currently faced with one tough issue caused by zero copy mode i=
n
> > > > xsk with ixgbe driver loaded. The case is that if we use xdpsock to
> > > > send descs, nearly at the same time normal packets from other tx
> > > > queues cannot be transmitted/completed at all.
> > > >
> > > > Here is how I try:
> > > > 1. run iperf or ping to see if the transmission is successful.
> > > > 2. then run "timeout 5 ./xdpsock -i enp2s0f0 -t  -z -s 64"
> > > >
> > > > You will obviously find the whole machine loses connection. It can
> > > > only recover as soon as the xdpsock is stopped due to timeout.
> > > >
> > > > I tried a lot and then traced down to this line in ixgbe driver:
> > > > ixgbe_clean_tx_irq()
> > > >     -> if (!(eop_desc->wb.status & cpu_to_le32(IXGBE_TXD_STAT_DD)))
> > > >             break;
> > > > The above line always 'breaks' the sending process.
> > > >
> > > > I also managed to make the external ixgbe 6.15 work and it turned o=
ut
> > > > to be the same issue as before.
> > > >
> > > > I have no idea on how to analyze further in this driver. Could some=
one
> > > > point out a direction that I can take? Is it a known issue?
> > > >
> > > > Thanks,
> > > > Jason
> > > >
> > >
> > > I was able to reproduce the described behaviour, xdpsock does break t=
he IP
> > > communication. However, in my case this was not because of ixgbe not =
being able
> > > to send, but because of queue 0 RX packets being dropped, which is th=
e indended
> > > outcome in xdpsock, even in Tx only mode.
> >
> > Thanks for your feedback. It would be great if you could elaborate
> > more on this. How did you spot that it's queue 0 that causes the
> > problem?
>
> If you do not specify -q parameter, xdpsock loads on the queue pair 0.
>
> > Why is xdpsock breaking IP communication intended?
>
> Because when a packet arrives on the AF_XDP-managed queue (0 in this case=
), the
> default xdpsock XDP program provided by libxdp returns XDP_REDIRECT even =
in
> tx-only mode, XDP_PASS for all other queues (1-39). XDP_REDIRECT results =
in a
> packet leaving the kernel network stack, it is now managed by the AF_XDP
> userspace program. I think it is possible to modify libxdp to return XDP_=
PASS
> when the socket is tx-only.
>
> >
> > When you try i40e, you will find the connection behaves normally. Ping
> > can work as usual. As I depicted before, with ixgbe driver, ping even
> > doesn't work at all.
>
> I think this is due to RSS configuration, ping packets on i40e go to anot=
her
> queue.

Thanks so much for your detailed explanation.

But, I still doubt it's not the reason why xdpsock breaks with ixgbe
driver loaded because I tried the following commands:
1. ping <ip>
2. timeout 3 ./xdpsock -i enp2s0f0np0 -t -q 11  -z -s 64
Whatever the queue value I adjusted, ping always fails with
"Destination Host Unreachable" warning.

Thanks,
Jason

