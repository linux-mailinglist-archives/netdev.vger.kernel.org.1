Return-Path: <netdev+bounces-198322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6382ADBD81
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 01:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D11DB7A8DFF
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 23:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E192264A6;
	Mon, 16 Jun 2025 23:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I74uuWpT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D0021FF5E;
	Mon, 16 Jun 2025 23:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750116076; cv=none; b=JSOMzM3DMmHgjHyJPInEkJL8RbPLabRrB+/3YTarjF6oB1HidwJQ6Jc49Gb6JXv9EaUxnVou54bE5OJacerTG68zYDBzfhqEDX2Y5kjRgNQR2EgR/uZl72i5sqkows5cXIlSzMVLY+A/4NXwJnvZWJQFrBCnggVfnycF3lBSoS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750116076; c=relaxed/simple;
	bh=1U/vk/hToZB9yNutoVROj8CF01FsOu5fy9gSVKG5Hyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IKhxLlBJ53GZA8g/bNkNLn/GEchpn4fJUS8W0jeVvP4eJ4nPH+Wfi0i1c1feKGUyNWBqFXPaJRuC7PYpSx1WtNXIuV0NY4tFBaMd3nzw0qaqABKvCxpxoVhCT3wy6hqGkLipytfE6tiEaomwVaFLXzVAFQeVSY+DOt+lwyTkUsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I74uuWpT; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-747e41d5469so5471791b3a.3;
        Mon, 16 Jun 2025 16:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750116074; x=1750720874; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6IqNHmz6GBQs1riK/mAoEi1wkyO1+RbMYiTYYA+9LAc=;
        b=I74uuWpTfYi/SJGGhQRa4RrJyqkh1IjGbEJDYT75NAflxlJUCLpHVH2WAPHMbIIQgx
         1772Dwp+hxaVwOKSrNCfll+B/ppjyvMhO867QkHveDuRKOuoEEns36X4P7nvtTrNM+iZ
         hl98rGuFcrn93k4UUdn95hzDMlni2v8JI9ZN4mA01q87i+4oalXfv7JaJ8RW9GI0Nk/r
         pwn/HVtcZxTPg59vSfBt0qbCp22JEGhwsFvs6jZsbsBWDaFC3WLR8QjmRiQeYji83AYn
         SdY7IKv3/IY8b02RFgHCzS0PAIOX6sLtQ3fPHF0XejfPBDl02bn9OX7UGjhvQH8B736o
         sTKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750116074; x=1750720874;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6IqNHmz6GBQs1riK/mAoEi1wkyO1+RbMYiTYYA+9LAc=;
        b=Ly+0C4VdTJ6i+n7FNE8M43yT5dPUSMJbhzRQtdnBH5zKyNuR6Z2EHkaR0vO4g5ukGl
         tY5XdlMSM2NT11vuAJR6NYe1G1mtNwRf8cy6BtXGNgIa8x7fQDeHKDeAHVhBsEcFUm1l
         c3WSuuwKuOhj6pXO/3pqDOnBTvWnbIJbPDEHB2TUgWFK12vZYHlaMAwFwujGEUzoYNYC
         syjdLDctk4nabtusapOkDFitNoI6+CGURxhxuv41/BD6/sth2LhlFMEfpTEME5A6yCB+
         lqcGO9k83Qiumf6yhr/HYxxyJifsUevXZGaQUeO9iTD418ujkEk0QYsxtjfBKsMnp1Zu
         UIgw==
X-Forwarded-Encrypted: i=1; AJvYcCWIVbyQ+Co0paAv8E7TSll/tYS63F26PG+0s7gc726JsttBGoSB9JiH4wd3dgog3CWhuS7SRe3wTQJbk/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjdO7oU4TBYAUkf5+XO4cdpADz5wB01vtRgw5ACznYFTKWzF8r
	pyA0hkM1F5zh2wRDjOub8IEbM4zsHfO2g3p5237hBR4g4gPXEpMNs4o=
X-Gm-Gg: ASbGncssxQi0XpFDXOQ8eCRDZCD3ros/CT8jDVvETbNYF08smsqKGYz4EWFGbWCjIG1
	gnco76sg9jykTISWxIripiAE3WG3Or49p17CnO6C+S2mOemuBu8674fXsROO5wz25rGQrPUtl0M
	khaOd1/fDkrFX+fFmxnZXVnFRafRQ1da8tBqJAQipS+SNxTwFUmlZ7Z/m7nmHH93CmMcM/s9b1g
	CVsNE2I4J95nBj9uB9bbKkaeKPYdX03e9pjx2voBLwXUpRAT5wsZOMZGaRg8z1vGSSR4i7WfNqN
	85gbNUuTtNHH2QfzQXWzlXtleA42unMFID9J2/Sq8qBlKrlajf7mlCJ9nXhuOICxJfdY3Iys4im
	I5SaeWglpx4uBDHkx4rPmu8E=
X-Google-Smtp-Source: AGHT+IGM8cCk/sYANsFsOLgKO/7O5wrU1+7vPfxQLYsZdlHZ3CBtISb4TBCWVP0aNDz/CZJ58Ooyiw==
X-Received: by 2002:a05:6a00:b8b:b0:73f:f816:dd78 with SMTP id d2e1a72fcca58-7489cfcb325mr13794495b3a.15.1750116074469;
        Mon, 16 Jun 2025 16:21:14 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-748900ac001sm7624361b3a.108.2025.06.16.16.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 16:21:14 -0700 (PDT)
Date: Mon, 16 Jun 2025 16:21:13 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
	sdf@fomichev.me, liuhangbin@gmail.com, linux-kernel@vger.kernel.org,
	syzbot+b8c48ea38ca27d150063@syzkaller.appspotmail.com
Subject: Re: [PATCH net] bonding: switch bond_miimon_inspect to rtnl lock
Message-ID: <aFCm6TuOAr5cokFw@mini-arch>
References: <20250616172213.475764-1-stfomichev@gmail.com>
 <1912679.1750099002@famine>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1912679.1750099002@famine>

On 06/16, Jay Vosburgh wrote:
> Stanislav Fomichev <stfomichev@gmail.com> wrote:
> 
> >Syzkaller reports the following issue:
> >
> > RTNL: assertion failed at ./include/net/netdev_lock.h (72)
> > WARNING: CPU: 0 PID: 1141 at ./include/net/netdev_lock.h:72 netdev_ops_assert_locked include/net/netdev_lock.h:72 [inline]
> > WARNING: CPU: 0 PID: 1141 at ./include/net/netdev_lock.h:72 __linkwatch_sync_dev+0x1ed/0x230 net/core/link_watch.c:279
> >
> > ethtool_op_get_link+0x1d/0x70 net/ethtool/ioctl.c:63
> > bond_check_dev_link+0x3f9/0x710 drivers/net/bonding/bond_main.c:863
> > bond_miimon_inspect drivers/net/bonding/bond_main.c:2745 [inline]
> > bond_mii_monitor+0x3c0/0x2dc0 drivers/net/bonding/bond_main.c:2967
> > process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3238
> > process_scheduled_works kernel/workqueue.c:3321 [inline]
> > worker_thread+0x6c8/0xf10 kernel/workqueue.c:3402
> > kthread+0x3c5/0x780 kernel/kthread.c:464
> > ret_from_fork+0x5d4/0x6f0 arch/x86/kernel/process.c:148
> > ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> >
> >As discussed in [0], the report is a bit bogus, but it exposes
> >the fact that bond_miimon_inspect might sleep while its being
> >called under RCU read lock. Convert bond_miimon_inspect callers
> >(bond_mii_monitor) to rtnl lock.
> 
> 	Sorry, I missed the discussion on this last week.  This is on
> me, last year this came up and the correct fix is to remove all of the
> obsolete use_carrier logic in bonding.  A round trip on RTNL for every
> miimon pass is not realistic.
> 
> 	I've got the following patch building as we speak, if it doesn't
> blow up I'll post it for real.
> 
> 	Actually, reading the patch now as I write, I need to tweak the
> option setting logic, it should permit setting use_carrier to "on" or 1,
> but nothing else.  I had originally planned to permit setting it to
> anything and ignore the value, but decided later that turning it off
> should fail, as the behavior change implied by "off" won't happen.

That's even better, thanks, will take a look!

