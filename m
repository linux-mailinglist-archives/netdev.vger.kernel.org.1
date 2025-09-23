Return-Path: <netdev+bounces-225729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53AE4B97CB2
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 01:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 651963B47BE
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 23:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8603530EF88;
	Tue, 23 Sep 2025 23:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/b+eHPV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF00A30C35F
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 23:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758669649; cv=none; b=nV45NvxFTQD9PjsADMmhR4Xx9sj9uB3zK8/AJbFXuKOmqqZ2mQmSym2e1xyk3LkcewulNrkH8mEhD2yHWc2fOn5rmaDjcitYZ7eW6scLh7zMispv61gmd6sThyIPhfBKOPdb4Nw4ZpnBJDNZyIMkxs29ksvWYNo8FRnKueD8tiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758669649; c=relaxed/simple;
	bh=vkZtgaI8+DwA2vFDCXnyuKa4Ewv+3A6r93k8zDXNbj8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kUrjHj7K1OoK4gjj8Udugi+2X/iXQmU4UuiQgWRMlBLkbh/ha7hqZ1c+Y/X1k1mAnKTRjMblBcbWVfZ/F8Le4GHZHAjkjWC+C5kG2DvXre8VXC8jCjr/XxdR/4Zng8r+oCKmXOeB+VSbbHbcpakg13u89U01+REzFvbdycrMajg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/b+eHPV; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-57bd482dfd2so4219320e87.2
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 16:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758669646; x=1759274446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7kc5MQmgIpaNTBaT8ZNBy5t4B5Vp5p3q0VgcMo06yqw=;
        b=a/b+eHPVxSEVzqwuiPJ8CzT3NtkU2uTRGYOVBG0a85NIM/V7LIgduFX43z4mfyuCTH
         ztSwhGWtWXxbDlU4zJducKmaLowbqaDsVN7yHTA775POKH8ETdQg9Qs/pKLk2aWpHUi+
         95f24pkm3Iq/CnoCiYkT+Rc0zku8deULAW9BkTGSic+lQ7Bv90Wo0lKkfzhJHmSUTg4J
         0hTRj8exXcj0/AU+Dhus3unbM9hY9vN9AZ19M+sX1kq7dGnoy8WOCITzI+S+fk1CaZ12
         u27xn34EmKwEeUHniWGYSuGyddyOBn/phkHsSRpWQzoP3UvU+w+O5EExE/aY+eX61E/t
         6PxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758669646; x=1759274446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7kc5MQmgIpaNTBaT8ZNBy5t4B5Vp5p3q0VgcMo06yqw=;
        b=p2VdVrMvE3zu/SAhSlFPWfoKshXU/AXmFAfcIUee5tOVO8DHkz4d4PlyirvlO+cLIM
         LCXSo4/ToIvimuxPBawpcdTVotIUVB7+J92/MVtnX8Og/YE8w+IpVKLrXj130YQjSGr0
         f3cjY0WM2bdbzYYjB5JA7fM5pOJKPXfUInxtoYDgjGKFVJJAGAVh4Fh//lnuIImORQcz
         XsoRr1q+RySB1MxLPa52EAurGz3ip/jT23zDMAQ5oZw1+3TnCSyYQgRLldoJha1FT4pF
         BtwhhoRieK4rY5v7ICzBcqCBh3WDgqUogd71JcVLq+iwKiRQpDajwsiPxLgyucb9lsoh
         8oQA==
X-Forwarded-Encrypted: i=1; AJvYcCVJHfEujMDlr3CcCTs8aQSnrdNBUJVGl0Zhg2/UBTwGzwlQMgjBjTyjHQ6uHN3mfinwpKiJaKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLYtud45/uoDsg41dmG9UGGaIV0stHbFDjMI9BcH1quwLeaOaG
	eZ0TGGfspZ/Oye1y8D3XxG4Yzv+1np6XMiflErR+1jWn5+c8PeOddOYn1s90K1JO
X-Gm-Gg: ASbGncujmXVkl+yeNGl2GXucxK5xAmhaRIBRrfEBDnumdKVl1DlCHZB2voGSmIQlsrW
	6ZoBg7oi7sOQA1RiHxDb4P/bqf5QQPUcJs+YDl3/xgfFJ5SdjZOM3go5TgipKKFXUVMwgISFRUS
	TS45+r6mIozn5Tisr1GX5MiAznf6dKorJXert24W+zecNvNsn0fro/cuUlVJCTqynrDGszNe3WN
	/yzBlmxgZ3TbppH466Lv0car1q8U5MsycA3rF15RXzfitKCjT2uTtUsWf7EELdL6I+G7sLfDv+3
	+h5gWMALlf37MNsnyH38Ca/sKrMMIxx7ON7tQNpcG6cRNQHP0whg/dHbYADSxMEimTmFcNu7XeZ
	1Eh5F7OzoFJTkilAxmuSLkCuoECl7gzn4tLc=
X-Google-Smtp-Source: AGHT+IFVMR2s4ilEdfP5c3p3+7X515B1QLyMWkcy/0fTuDiMsgwVqSp4AmW8TfIdg0R7IgmgC3jp6A==
X-Received: by 2002:a05:6512:6314:b0:560:9702:4fe6 with SMTP id 2adb3069b0e04-5807190a878mr1402555e87.24.1758669645455;
        Tue, 23 Sep 2025 16:20:45 -0700 (PDT)
Received: from foxbook (bfe191.neoplus.adsl.tpnet.pl. [83.28.42.191])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-57b43ff413asm3101295e87.144.2025.09.23.16.20.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 23 Sep 2025 16:20:45 -0700 (PDT)
Date: Wed, 24 Sep 2025 01:20:39 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: I Viswanath <viswanathiyyappan@gmail.com>, andrew@lunn.ch,
 andrew+netdev@lunn.ch, davem@davemloft.net, david.hunter.linux@gmail.com,
 edumazet@google.com, linux-kernel-mentees@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, petkan@nucleusys.com,
 skhan@linuxfoundation.org,
 syzbot+78cae3f37c62ad092caa@syzkaller.appspotmail.com
Subject: Re: [PATCH net v2] net: usb: Remove disruptive netif_wake_queue in
 rtl8150_set_multicast
Message-ID: <20250924012039.66a2411c.michal.pecio@gmail.com>
In-Reply-To: <20250923072809.1a58edaf@kernel.org>
References: <83171a57-cb40-4c97-b736-0e62930b9e5c@lunn.ch>
	<20250920181852.18164-1-viswanathiyyappan@gmail.com>
	<20250922180742.6ef6e2d5@kernel.org>
	<20250923094711.200b96f1.michal.pecio@gmail.com>
	<20250923072809.1a58edaf@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Sep 2025 07:28:09 -0700, Jakub Kicinski wrote:
> Excellent, could you check if there is any adverse effect of
> repeatedly writing the RCR register under heavy Tx traffic (without
> stopping/waking the Tx queue)? The driver seems to pause Tx when RCR
> is written, seems like an odd thing to do without a reason, but
> driver authors do the darndest things.

I don't know what's the point of this, because it doesn't prevent the
async "set RCR" control request racing with an async TX URB submitted
before the queue was stopped or after it was restarted.

Such races could be prevented by net core not calling this while TX
is outstanding and not issuing TX until the control request completes,
but it doesn't look like any of that is the case?


I sucessfully reproduced the double submit bug as follows:

ifconfig eth1 10.9.9.9
arp -s 10.9.8.7 87:87:87:87:87:87	# doesn't actually exist
ping -f 10.9.8.7
while :; do ifconfig eth1 allmulti; ifconfig eth1 -allmulti; done

For some reason I had to use two instances of 'ping -f', not sure why.
Then the double submission warning appears in a few seconds and also
some refcount issues, probably on skbs (dev->tx_skb gets mixed up).

With the patch, it all goes away and doesn't show up even after a few
minutes. I also tried with two TCP streams to a real machine and only
observed a 20KB/s decrease in throughput while the ifconfig allmulti
loop is running, probably due to USB bandwidth. So it looks OK.


But one annoying problem is that those control requests are posted
asynchronously and under my test they seem to accumulate faster than
they drain. I get brief or not so brief lockups when USB core cleans
this up on sudden disconnection. And rtl8150_disconnect() should kill
them, but it doesn't.

Not sure how this is supposed to work in a well-behaved net driver? Is
this callback expected to return without sleeping and have an immediate
effect? I can't see this working with USB.

Regards,
Michal

