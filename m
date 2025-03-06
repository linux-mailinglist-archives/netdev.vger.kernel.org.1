Return-Path: <netdev+bounces-172465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 955BEA54C84
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 14:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 675E21754DE
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 13:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF321E4AE;
	Thu,  6 Mar 2025 13:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qqN3q+bF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B845B3D6F
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 13:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741268742; cv=none; b=gH2kxizB3lEYsCxvlD/mhDzwjjXRVrpw4APXQPKbGPPbiN9KJpvCJOWqEQGTiJySTP7+luxmS3bj480FCuv2Kns1MUtcA0FA4lwhJ7YCNfN2OlJvFZeF7g9XauUhXUesdGbseiAeRsjjRahPWGYMjZ2T4uzDeD7AgNkdiwUEMGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741268742; c=relaxed/simple;
	bh=1rhlOmynIroBiU8qPJN1DXy3TIZbKMdeGJ1EcGypq4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TgvKr0gH+tTw9pP1FQl1B8w1B3ZV8QqAS5Qqrlkhu3raCLJlhfBrAxHqcYrHcSzVDnt6qLAoxpKWJU1MfH8dDDaS9lY0YbJsLA7Ltn/B8ECHAKgLbpPr8NcakdKWYa+gdqJThygN/fjZI4JXK7IkkSbKerDk/j6MJj2PC6z41iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qqN3q+bF; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-85b018062a5so55505639f.3
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 05:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741268740; x=1741873540; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E59oMEtj335+l2wMYU8hCdtjAzBa/oipZERLi/IQVEw=;
        b=qqN3q+bF+IWPjyVY371s8O7feG1ocVtUmLLOZbkM0GlO634FCdkllyd4kBosnhqkQA
         qa5WeEtLAvJLw3GqiRBLuIUN9S0Dii3xCkE5MRrM1FoMzVKYkHzDnqQj8ZIbQijCGnO4
         DH0oEPqP7/U7UxHgrI+wjWKo5VhMQQUH5eXTjpz2k6Y1GKPHIEJAnkgWRF/N1cMU3nVp
         bZOym9EBMzv/ttidqu9NvmnmyaZlIVGMSjb3LuhQTNZR0vj4O2xRYGJhFamIxrZbePoN
         J+0xu5QBe7k791COMsGdYh768PmPdNIdXtaxJUQ0KCMAMt0kv+NR/b98KEtn3ttoB/8T
         ZnVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741268740; x=1741873540;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E59oMEtj335+l2wMYU8hCdtjAzBa/oipZERLi/IQVEw=;
        b=AUvrPLhnV8OKInGYh3IjD+tBaq7hbJMG/taMSiA9J+A6r87riEGJEpO5SGyifNHROf
         TwgArmYuPzpqDkuK9eeYm5jEasP8YYT8kTWiBpctW9EnuKnjj9W2L+qM3Xpl1jDNWdg0
         WWUwe6Z80N//W1N0lvlwVHT5kYEI0KAMPSORx0ghCQY/KNec9R6/AWY+kLLl1au8mU5H
         6ZtoKBuTS46HF3janMeBlDSDsrtidksnQsA2j8aUZgJYAoYDF3ESRQvFnaJTqMbcvOGE
         ncbHA5xhYJgbnihvxk11I+7gqDj1ROgMYXdCdIU5/Z8fLeLoXH2b/Jp4hNcU0Dot3wb/
         07+A==
X-Gm-Message-State: AOJu0YywUHy+jwhDjgLDZr02pNGD3UvrF30LHbH2Br5sdkUl7XhTtXZL
	awrK3vYrv/xqHsj0U69HpTJrSRiWHb+Edx3l2c+PrLlZO1lyv1+BDb9leqAwL1E4u8pHbxAWdLT
	v/sGgYc2DlrdcgbLmzdW/DGoNvUVeX66XdkMbE8Jh8KO8O0r44SM7+FY=
X-Gm-Gg: ASbGncvjMKSijldNAf7EZ8ljX7iamiriFXonv1g4EJ6doji3QM6zXwMJVUl4YTrRnNZ
	yfOuivHV7OoBFqweZeuVe0joEwdn5ZiEycPdbmrTHc3tbnvQz9jzBbBkLiQVQh8rJxNxvJrNjTO
	QTC50zD496nGLxGcGZbYQvWWqXM8Q=
X-Google-Smtp-Source: AGHT+IFdoE08tItQa+60nBuZW1MTGsn57maA+jp9cAGLyYJebifdcbLzcBjtIM0wPReAP2cmRNPxnIIJNHEGPga7Yas=
X-Received: by 2002:ac8:7f8a:0:b0:475:5f2:d44f with SMTP id
 d75a77b69052e-4750b23df0amr86339301cf.8.1741268727738; Thu, 06 Mar 2025
 05:45:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306122413.GBZ8mT7Z61Tmgnh5Y9@fat_crate.local>
In-Reply-To: <20250306122413.GBZ8mT7Z61Tmgnh5Y9@fat_crate.local>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 6 Mar 2025 14:45:16 +0100
X-Gm-Features: AQ5f1JrTz5ucwy8cHjxZJ9UK9qrZcJq51lB6mxsvLcElpOYLRLQjTiAfx4i4D7E
Message-ID: <CANn89iJeHhGQaeRp01HP-KqA65aML+P5ppHjYT_oHSdXbcuzoQ@mail.gmail.com>
Subject: Re: request_irq() with local bh disabled
To: Borislav Petkov <bp@alien8.de>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, linux-kernel@vger.kernel.org, x86-ml <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 6, 2025 at 1:24=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrote=
:
>
> Hi,
>
> this is latest Linus/master + tip/master on a 32-bit x86:
>
> tglx says one cannot request_irq() with local bh disabled.
>
> [   17.354927] cfg80211: Loading compiled-in X.509 certificates for regul=
atory database
> [   17.906996] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
> [   17.950874] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248d=
b18c600'
> [   18.034884] platform regulatory.0: Direct firmware load for regulatory=
.db failed with error -2
> [   18.038920] cfg80211: failed to load regulatory.db
>
> [   18.726638] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   18.726638] [ BUG: Invalid wait context ]
> [   18.726638] 6.14.0-rc5+ #1 Not tainted
> [   18.726638] -----------------------------
> [   18.726638] ip/991 is trying to lock:
> [   18.726638] c36a2d64 (&desc->request_mutex){+.+.}-{4:4}, at: __setup_i=
rq+0x98/0x6cc
> [   18.726638] other info that might help us debug this:
> [   18.746793] context-{5:5}
> [   18.746793] 2 locks held by ip/991:
> [   18.746793]  #0: c261f920 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0=
x336/0x9fc
> [   18.746793]  #1: c1f56ea0 (local_bh){.+.+}-{1:3}, at: dev_set_rx_mode+=
0x5/0x80

Hmmm.. not sure why local_bh is considered held..

void dev_set_rx_mode(struct net_device *dev)
{
    netif_addr_lock_bh(dev);
    __dev_set_rx_mode(dev);  // does not call ndo_open() (rtl_open in
your trace)
    netif_addr_unlock_bh(dev);
}


Note that netif_addr_lock_bh() is using:

local_bh_disable();
spin_lock_nested(&dev->addr_list_lock, nest_level);

Would the following "debug" patch change anything for your tree ?
I know this looks strange, but I do not have anything more sensible to sugg=
est.

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index ab550a89b9bfaa5682e65f1dcc7f5f99ce90eb94..52e10d738bf0e35296a87601182=
8cd0b40580678
100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4751,7 +4751,8 @@ static inline void netif_addr_unlock(struct
net_device *dev)

 static inline void netif_addr_unlock_bh(struct net_device *dev)
 {
-       spin_unlock_bh(&dev->addr_list_lock);
+       spin_unlock(&dev->addr_list_lock);
+       local_bh_enable();
 }

 /*



> [   18.746793] stack backtrace:
> [   18.746793] CPU: 1 UID: 0 PID: 991 Comm: ip Not tainted 6.14.0-rc5+ #1
> [   18.746793] Hardware name: Acer AOA150/, BIOS v0.3309 10/06/2008
> [   18.746793] Call Trace:
> [   18.746793]  dump_stack_lvl+0x94/0x10c
> [   18.746793]  dump_stack+0x13/0x18
> [   18.746793]  __lock_acquire+0xa1c/0x2500
> [   18.746793]  lock_acquire+0xc3/0x2ac
> [   18.746793]  ? __setup_irq+0x98/0x6cc
> [   18.746793]  ? debug_smp_processor_id+0x12/0x14
> [   18.746793]  ? __mutex_lock+0x54/0xcb8
> [   18.746793]  ? __mutex_lock+0x54/0xcb8
> [   18.746793]  ? trace_preempt_off+0x2e/0xb4
> [   18.746793]  ? __might_sleep+0x35/0x6c
> [   18.746793]  ? __mutex_lock+0x54/0xcb8
> [   18.746793]  ? preempt_count_add+0x6c/0xd4
> [   18.746793]  __mutex_lock+0x82/0xcb8
> [   18.746793]  ? __setup_irq+0x98/0x6cc
> [   18.746793]  mutex_lock_nested+0x27/0x2c
> [   18.746793]  ? __setup_irq+0x98/0x6cc
> [   18.746793]  __setup_irq+0x98/0x6cc
> [   18.746793]  ? __kmalloc_cache_noprof+0x1b1/0x2d0
> [   18.746793]  ? request_threaded_irq+0x84/0x188
> [   18.746793]  request_threaded_irq+0xc2/0x188
> [   18.746793]  rtl_open+0x33b/0x5e4 [r8169]
> [   18.746793]  ? raw_notifier_call_chain+0x20/0x24
> [   18.746793]  __dev_open+0xce/0x17c
> [   18.746793]  ? dev_set_rx_mode+0x74/0x80
> [   18.746793]  __dev_change_flags+0x176/0x1cc
> [   18.746793]  dev_change_flags+0x29/0x6c
> [   18.746793]  do_setlink.isra.0+0x28f/0x1180
> [   18.746793]  ? __mutex_lock+0x107/0xcb8
> [   18.746793]  ? __mutex_lock+0x107/0xcb8
> [   18.746793]  ? trace_preempt_on+0x2e/0xac
> [   18.746793]  ? __mutex_lock+0x107/0xcb8
> [   18.746793]  ? preempt_count_sub+0xb1/0x100
> [   18.746793]  ? debug_smp_processor_id+0x12/0x14
> [   18.746793]  ? __mutex_lock+0x107/0xcb8
> [   18.746793]  ? rtnl_newlink+0x336/0x9fc
> [   18.746793]  ? __kmalloc_cache_noprof+0x1b1/0x2d0
> [   18.746793]  ? do_alloc_pages+0x64/0xbc
> [   18.746793]  rtnl_newlink+0x762/0x9fc
> [   18.746793]  ? __this_cpu_preempt_check+0xf/0x20
> [   18.746793]  ? do_alloc_pages+0x64/0xbc
> [   18.746793]  ? do_setlink.isra.0+0x1180/0x1180
> [   18.746793]  rtnetlink_rcv_msg+0x3fd/0x584
> [   18.746793]  ? rtnetlink_rcv_msg+0x58/0x584
> [   18.746793]  ? netlink_deliver_tap.constprop.0+0xe5/0x4ac
> [   18.746793]  ? local_clock_noinstr+0x68/0x1c0
> [   18.746793]  ? rtnl_fdb_dump+0x370/0x370
> [   18.746793]  netlink_rcv_skb+0x42/0xdc
> [   18.746793]  ? do_alloc_pages+0x64/0xbc
> [   18.746793]  rtnetlink_rcv+0x12/0x14
> [   18.746793]  netlink_unicast+0x198/0x2a8
> [   18.746793]  netlink_sendmsg+0x1bb/0x3ec
> [   18.746793]  ? netlink_unicast+0x2a8/0x2a8
> [   18.746793]  ____sys_sendmsg+0x233/0x280
> [   18.746793]  ? netlink_unicast+0x2a8/0x2a8
> [   18.746793]  ? do_alloc_pages+0x64/0xbc
> [   18.746793]  ___sys_sendmsg+0x66/0x9c
> [   18.746793]  ? __might_fault+0x3b/0x84
> [   18.746793]  ? __might_fault+0x3b/0x84
> [   18.746793]  ? local_clock_noinstr+0x68/0x1c0
> [   18.746793]  ? do_alloc_pages+0x64/0xbc
> [   18.746793]  __sys_sendmsg+0x52/0x88
> [   18.746793]  ? _copy_from_user+0x51/0x60
> [   18.746793]  __ia32_sys_socketcall+0x30b/0x320
> [   18.746793]  ? __might_fault+0x7d/0x84
> [   18.746793]  ia32_sys_call+0x2695/0x284c
> [   18.746793]  __do_fast_syscall_32+0x67/0xf0
> [   18.746793]  do_fast_syscall_32+0x29/0x5c
> [   18.746793]  do_SYSENTER_32+0x15/0x18
> [   18.746793]  entry_SYSENTER_32+0x98/0xf9
> [   18.746793] EIP: 0xb7edd579
> [   18.746793] Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 7=
4 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <=
5d> 5a 59 c3 90 90 90 90 8d 76 00 58 b8 77 00 00 00 cd 80 90 8d 76
> [   18.746793] EAX: ffffffda EBX: 00000010 ECX: bff4ab70 EDX: 00000000
> [   18.746793] ESI: b7e5f000 EDI: 005692a0 EBP: 00000010 ESP: bff4ab60
> [   18.746793] DS: 007b ES: 007b FS: 0000 GS: 0033 SS: 007b EFLAGS: 00000=
282
> [   18.874284] hpet: Lost 9 RTC interrupts
> [   18.874867] RTL8201CP Ethernet r8169-0-200:00: attached PHY driver (mi=
i_bus:phy_addr=3Dr8169-0-200:00, irq=3DMAC)
> [   18.932445] r8169 0000:02:00.0 eth0: Link is Down
> [   19.264574] ath5k 0000:03:00.0: can't disable ASPM; OS doesn't have AS=
PM control
> [   19.269295] ath5k 0000:03:00.0: registered as 'phy0'
> [   19.827560] ath: EEPROM regdomain: 0x65
> [   19.829929] ath: EEPROM indicates we should expect a direct regpair ma=
p
> [   19.832273] ath: Country alpha2 being used: 00
> [   19.834396] ath: Regpair used: 0x65
> [   19.837790] ieee80211 phy0: Selected rate control algorithm 'minstrel_=
ht'
> [   19.854976] ath5k: phy0: Atheros AR2425 chip found (MAC: 0xe2, PHY: 0x=
70)
> [   20.566012] r8169 0000:02:00.0 eth0: Link is Up - 100Mbps/Full - flow =
control rx/tx
> [   20.966578] NET: Registered PF_INET6 protocol family
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette

