Return-Path: <netdev+bounces-245448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3998BCCDB4D
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 22:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 947C03011B2D
	for <lists+netdev@lfdr.de>; Thu, 18 Dec 2025 21:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167B22D7DE3;
	Thu, 18 Dec 2025 21:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NlF+wcxf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52282F3622
	for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 21:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766093720; cv=none; b=IelupeoqGatXocCEMlzdpMnd8djBM6vX6bQiavuOyZbkYZziaXhq2GjmCqRHooABGnDcQ+KjR5LKTybsqMmQSRMgqeur67O2OAvOxfnOc/+s81CLW6tjCKnyFWbj0bmqbcSkWnUnSJrhmdsome/8+QP9wpBiNHHPlW9Dzp9KNpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766093720; c=relaxed/simple;
	bh=GQN+laEnjKV1etZy2XOiYUJmcjexQ5SNBo3MDTPTC0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Az/h189D504NFHr9Bag9JmI6QJNyaGM1ry9ne9Nu+RWdOq6//L1lnM2doBuKgVUx8Ou0Y8O69uTFbnJMsJDi3ZgHn4EK14tqGdfNhG/dzSZWZtY1wJErkxedGXvAAl2AOtdn4uSrd6imvJ/5dcCvdd6rvGHvxjiiVU1kS/hKnaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NlF+wcxf; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-37a2dcc52aeso10482601fa.0
        for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 13:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766093716; x=1766698516; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=LoEaEPqer7trL7hEB1F0pzjRs0IVfQzmh9nvm3m1CgU=;
        b=NlF+wcxfy06kY3K/+3YoIHT6gWNCOzsnDp9ikfk7rk0RfcCSoGbd3vCdvVgHbw2Z/e
         c3PPJOSMsRl0/bqhQPk+ZVS0sF6sHBu1fDLLhGWTD06UbIJ80GiWUDBHRVmS1N/nO1Cf
         mPxD3GcXnAEVAmYwyQ5w8w00jgjEZOR0V/cW4KJzjwB/vOVoEUyKEGdyosJVMWpL+Drq
         Lx3UyvKES9wNpE6cqATuZHPIQr8qCa9FZ4UUql0FD2dYPPSAm25cl5CxI0+EdnGtWQrV
         jmkspkirGDlEwUSOScVqf3sZHQTf6NW4zX0BZ8HNpO+2A5FI/LuYpudlKBncgxvo3LBq
         LwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766093716; x=1766698516;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LoEaEPqer7trL7hEB1F0pzjRs0IVfQzmh9nvm3m1CgU=;
        b=xS+WDXyTgDpDtCP+E8BfEY24dDKF+iikwG2aSbluIt1+RXnelMAv1A8dMR2zq7Z24N
         4gC78gfRZ+hOtRo/YFVxm96R8YYhqt9mdjSpUl5qpfBdKF9r38qZlviKn8qykND2Mkrl
         EoS5brpul8xhT4jTBrc9wYUnjXETTwtS2s/wlgOaxZfzoHZp+O6pltRQiQaZZJ/OgNyX
         06ywT5/A9zRbUJ5CoTWD/eEKWKMUzeEepQr1tLfKL8xZPZaKxTkhs30JsPgPrDiCZEfu
         nLxTh5G0TaED3mJH+djM4V+eAe8ANTNdi6HZCJ/mmcPRtxcb93g/7dw6khH+Wx/vz63P
         DNlw==
X-Forwarded-Encrypted: i=1; AJvYcCWfhBPTrbYYyF4dmYQEFCIOTJtSL6p6wuFSP14NF3JgBK4NZTM+Gb7d7ISo1QnVruvCQz8IC64=@vger.kernel.org
X-Gm-Message-State: AOJu0YybYdUN4q0DMGzS6qOEc5ZhZt9IqW3dTCAUa6T/DQLTj58kNfbj
	8MDcMmGrk/NEPqYqAz0cZSrdoFXvtEQ5SoBrQvLWsSexr5T4xX3hjTqPcj6YcgZJ
X-Gm-Gg: AY/fxX433P9nzzPEAwRnnF1DhWU3Qt7lQt5wfGkrZCidqaARtHfbIwyNF73rqc2ghyU
	0qBgvJ3ha8u2Zc1EEY1NAEBERAOSXxDR0SGmsLPjWDbEI4oUrmwwvLJ6rWDcrjHOTCofYUBGImf
	mOxTAdmJakGnUqdO/IbFn5PMtAT9Qldl5EAHIvam+aiNeX9sUKmJJ6wbbkbz8nqYJevyYabgm+2
	TZS9XiVoMaGZeMvyWH4bH8HbzvdsrQPKLZNp6y+mhxlsBRWgp4lyrnD9qfvaAoHr9I/Mw5wH0ih
	UIYn5Tq17JNlgzJRJAR8NjXRloQBykSI2TJrmOupq76Pr95YRhfgiOPhajuV70DlS2Fh5jiEz/D
	efW5qZ9xs88igA8gGxFmdwYjJ/ziKDfLfujcswT0CyXvTWKlJOLWA3O5qktd3c2ho+u1835sNXh
	M4mvk+3O0CCeRPzajSB45YivXMZHe55VfRzzBiyDrzX14p
X-Google-Smtp-Source: AGHT+IG3cf/+juHMev1aCrHLNdhdXhWEaNe+diRLQkCcLaCevLb5Y5ayIN8a1Ev6mf8ozquz4VLrCA==
X-Received: by 2002:a05:6000:2892:b0:42f:b683:b3ce with SMTP id ffacd0b85a97d-4324e4c70f0mr705017f8f.3.1766087445416;
        Thu, 18 Dec 2025 11:50:45 -0800 (PST)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea82fddsm602195f8f.25.2025.12.18.11.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 11:50:44 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id E6232BE2EE7; Thu, 18 Dec 2025 20:50:43 +0100 (CET)
Date: Thu, 18 Dec 2025 20:50:43 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Roland Schwarzkopf <rschwarzkopf@mathematik.uni-marburg.de>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Cc: debian-kernel@lists.debian.org, Ben Hutchings <benh@debian.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	regressions@lists.linux.dev
Subject: [regression 5.10.y] Libvirt can no longer delete macvtap devices
 after backport of a6cec0bcd342 ("net: rtnetlink: add bulk delete support
 flag") to 5.10.y series (Debian 11)
Message-ID: <176608738558.457059.16166844651150713799@eldamar.lan>
Mail-Followup-To: Roland Schwarzkopf <rschwarzkopf@mathematik.uni-marburg.de>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>, debian-kernel@lists.debian.org,
	Ben Hutchings <benh@debian.org>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	regressions@lists.linux.dev
References: <0b06eb09-b1a9-41f9-8655-67397be72b22@mathematik.uni-marburg.de>
 <aUMEVm1vb7bdhlcK@eldamar.lan>
 <e8bcfe99-5522-4430-9826-ed013f529403@mathematik.uni-marburg.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e8bcfe99-5522-4430-9826-ed013f529403@mathematik.uni-marburg.de>

Hi all,

Roland Schwarzkopf reported to the Debian mailing list a problem which
he encountered once updating in Debian from 5.10.244 to 5.10.247. The
report is quoted below and found in
https://lists.debian.org/debian-kernel/2025/12/msg00223.html

Roland did bisect the changes between 5.10.244 to 5.10.247 and found
that the issue is introduced with 1550f3673972 ("net: rtnetlink: add
bulk delete support flag") which is the backport to the 5.10.y series.

On Thu, Dec 18, 2025 at 02:59:55PM +0100, Roland Schwarzkopf wrote:
> Hi Salvatore,
> 
> On 12/17/25 20:28, Salvatore Bonaccorso wrote:
> > Hi Roland,
> > 
> > I'm CC'ing Ben Hutchings directly as well as he takes care of the
> > Debian LTS kernel updates. Idellly we make this as well a proper bug
> > for easier tracking.
> > 
> > On Wed, Dec 17, 2025 at 01:35:54PM +0100, Roland Schwarzkopf wrote:
> > > Hi there,
> > > 
> > > after upgrading to the latest kernel on Debian 11
> > > (linux-image-5.10.0-37-amd64) I have an issue using libvirt with qemu/kvm
> > > virtual machines and macvtap networking. When a machine is shut down,
> > > libvirt can not delete the corresponding macvtap device. Thus, starting the
> > > machine again is not possible. After manually removing the macvtap device
> > > using `ip link delete` the vm can be started again.
> > > 
> > > In the journal the following message is shown:
> > > 
> > > Dec 17 13:19:27 iblis libvirtd[535]: error destroying network device macvtap0: Operation not supported
> > > 
> > > After downgrading the kernel to linux-image-5.10.0-36-amd64, the problem
> > > disappears. I tested this on a fresh minimal install of Debian 11 - to
> > > exclude that anything else on my production machines is causing this issue.
> > > 
> > > Since the older kernel does not have this issue, I assume this is related to
> > > the kernel and not to libvirt?
> > > 
> > > I tried to check for bug reports of the kernel package, but the bug tracker
> > > finds no reports and even states that the package does not exist (I used the
> > > "Bug reports" link on
> > > https://packages.debian.org/bullseye/linux-image-5.10.0-37-amd64). This left
> > > me a bit puzzled. Since I don't have experience with the debian bug
> > > reporting process, I had no other idea than writing to this list.
> > You would need to search for inhttps://bugs.debian.org/src:linux ,
> > but that said I'm not aware of any bug reports in that direction.
> > 
> > Would you be in the position of bisecting the problem as you can say
> > that 5.10.244 is good and 5.10.247 is bad and regressed? If you can do
> > that that would involve compiling a couple of kernels to narrow down
> > where the problem is introduced:
> > 
> >      git clone --single-branch -b linux-5.10.yhttps://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
> >      cd linux-stable
> >      git checkout v5.10.244
> >      cp /boot/config-$(uname -r) .config
> >      yes '' | make localmodconfig
> >      make savedefconfig
> >      mv defconfig arch/x86/configs/my_defconfig
> > 
> >      # test 5.10.244 to ensure this is "good"
> >      make my_defconfig
> >      make -j $(nproc) bindeb-pkg
> >      ... install the resulting .deb package and confirm it successfully boots / problem does not exist
> > 
> >      # test 5.10.247 to ensure this is "bad"
> >      git checkout v5.10.247
> >      make my_defconfig
> >      make -j $(nproc) bindeb-pkg
> >      ... install the resulting .deb package and confirm it fails to boot / problem exists
> > 
> > With that confirmed, the bisection can start:
> > 
> >      git bisect start
> >      git bisect good v5.10.244
> >      git bisect bad v5.10.247
> > 
> > In each bisection step git checks out a state between the oldest
> > known-bad and the newest known-good commit. In each step test using:
> > 
> >      make my_defconfig
> >      make -j $(nproc) bindeb-pkg
> >      ... install, try to boot / verify if problem exists
> > 
> > and if the problem is hit run:
> > 
> >      git bisect bad
> > 
> > and if the problem doesn't trigger run:
> > 
> >      git bisect good
> > 
> > . Please pay attention to always select the just built kernel for
> > booting, it won't always be the default kernel picked up by grub.
> > 
> > Iterate until git announces to have identified the first bad commit.
> > 
> > Then provide the output of
> > 
> >      git bisect log
> > 
> > In the course of the bisection you might have to uninstall previous
> > kernels again to not exhaust the disk space in /boot. Also in the end
> > uninstall all self-built kernels again.
> 
> I just did my first bisection \o/ (sorry)
> 
> Here are the results:
> 
> git bisect start
> # bad: [f964b940099f9982d723d4c77988d4b0dda9c165] Linux 5.10.247
> git bisect bad f964b940099f9982d723d4c77988d4b0dda9c165
> # good: [863b76df7d1e327979946a2d3893479c3275bfa4] Linux 5.10.244
> git bisect good f52ee6ea810273e527a5d319e5f400be8c8424c1
> # good: [dc9fdb7586b90e33c766eac52b6f3d1c9ec365a1] net: usb: lan78xx: Add error handling to lan78xx_init_mac_address
> git bisect good dc9fdb7586b90e33c766eac52b6f3d1c9ec365a1
> # bad: [2272d5757ce5d3fb416d9f2497b015678eb85c0d] phy: cadence: cdns-dphy: Enable lower resolutions in dphy
> git bisect bad 2272d5757ce5d3fb416d9f2497b015678eb85c0d
> # bad: [547539f08b9e3629ce68479889813e58c8087e70] ALSA: usb-audio: fix control pipe direction
> git bisect bad 547539f08b9e3629ce68479889813e58c8087e70
> # bad: [3509c748e79435d09e730673c8c100b7f0ebc87c] most: usb: hdm_probe: Fix calling put_device() before device initialization
> git bisect bad 3509c748e79435d09e730673c8c100b7f0ebc87c
> # bad: [a6ebcafc2f5ff7f0d1ce0c6dc38ac09a16a56ec0] net: add ndo_fdb_del_bulk
> git bisect bad a6ebcafc2f5ff7f0d1ce0c6dc38ac09a16a56ec0
> # good: [b8a72692aa42b7dcd179a96b90bc2763ac74576a] hfsplus: fix KMSAN uninit-value issue in __hfsplus_ext_cache_extent()
> git bisect good b8a72692aa42b7dcd179a96b90bc2763ac74576a
> # good: [2b42a595863556b394bd702d46f4a9d0d2985aaa] m68k: bitops: Fix find_*_bit() signatures
> git bisect good 2b42a595863556b394bd702d46f4a9d0d2985aaa
> # good: [9d9f7d71d46cff3491a443a3cf452cecf87d51ef] net: rtnetlink: use BIT for flag values
> git bisect good 9d9f7d71d46cff3491a443a3cf452cecf87d51ef
> # bad: [1550f3673972c5cfba714135f8bf26784e6f2b0f] net: rtnetlink: add bulk delete support flag
> git bisect bad 1550f3673972c5cfba714135f8bf26784e6f2b0f
> # good: [c8879afa24169e504f78c9ca43a4d0d7397049eb] net: netlink: add NLM_F_BULK delete request modifier
> git bisect good c8879afa24169e504f78c9ca43a4d0d7397049eb
> # first bad commit: [1550f3673972c5cfba714135f8bf26784e6f2b0f] net: rtnetlink: add bulk delete support flag
> 
> Is there anything else I can do to help?

Is there soemthing missing?

Roland I think it would be helpful if you can test as well more recent
stable series versions to confirm if the issue is present there as
well or not, which might indicate a 5.10.y specific backporting
problem.

#regzbot introduced: 1550f3673972c5cfba714135f8bf26784e6f2b0f

Regards,
Salvatore

