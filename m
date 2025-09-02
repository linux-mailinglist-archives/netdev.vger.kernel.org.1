Return-Path: <netdev+bounces-219045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E034B3F8CF
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 10:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E02E0480FF4
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 08:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5663A2EAD0B;
	Tue,  2 Sep 2025 08:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G9DJ1kZ4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3C82EAD1B
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 08:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756802185; cv=none; b=FxL9XCDGvcOjayc1ZI5oCfPm+3M7P+Jpy+x83PkZOmeit22A9XQ9yuNYCLEpJllY92j0SD45c1Wcdg5ZaHhsn8+Jg9ooiGlAO+qJiieXCG1R0tlpxnubb57iJwhvQi6vFUeayhU5yS6UkI0kgG40wy9z8G4t8w6omX4pZ4km77g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756802185; c=relaxed/simple;
	bh=DjKt8UNzaYiXX1wbg6hcu32U0WJE+vcx7RIjaEDBBxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t4DCk8gpsQRnduyOUgQpt9TJT7MNuG8qrTGMqAasWjDr+WIfZRn7kRePiwa/rtbx8HYd1DurEhlpo7DYhCGZpZNL5a5WPsbX8TB1rsW292iB4C/csgEt1Nihezdsto0fICASanBnsoHiPlqzVT94A1kNP651Cl1krgsc9uTFsZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G9DJ1kZ4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756802181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cPlpyJtfF/5pmu8TR1GvHY68fM+j55CwwknTKQNY7Uk=;
	b=G9DJ1kZ4q3kaUGwHtMyy5qkLjRSTm/Nak2L0Z85m5For2tV0G7BgGx9qXLVyzP538ETCEe
	JAQTQt8kNSXFt3na6g9755UyZGPy3O1F14qCpSpJ06d4fxnn2yBgQXkTbHa6tgNA0QgPqX
	WufYcBpHpD5+2UxmsTf4pNR7PDJVzBE=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-tjhhvEXMN_WmrGOASFYN9w-1; Tue, 02 Sep 2025 04:36:19 -0400
X-MC-Unique: tjhhvEXMN_WmrGOASFYN9w-1
X-Mimecast-MFC-AGG-ID: tjhhvEXMN_WmrGOASFYN9w_1756802179
Received: by mail-yb1-f198.google.com with SMTP id 3f1490d57ef6-e96d57eb1d0so6983158276.3
        for <netdev@vger.kernel.org>; Tue, 02 Sep 2025 01:36:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756802179; x=1757406979;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cPlpyJtfF/5pmu8TR1GvHY68fM+j55CwwknTKQNY7Uk=;
        b=OClHlsT2iIKG70dD79aaQQOcEgWo/FbvEmOhwcM9jOPXUgW3IWtZfI71t22E9F2krG
         Rcu6QJfgTt5JzycEyoW28/h7z7B3MvORXS7/jnwrXnD+DD0tp9m9c7Pbdv28twU6FUuC
         VKX+9raa7xwwxDiOA8nkr4t9uZwAR5jcOVPkTxC7dUduhlvTCFIKC4mxZdv5PmZw7YzQ
         lGwALE7jSsWaK7+N8NHu7N9gUNMU1RiVO/8R/YpQYhv/Vsh/f4Ef0UQgpD0tBSsMlQIG
         wO9DQ7+wgKi2gAsgXES7iJlA7RfTUwBxCjbeJIbplhwp9RO7mKqPYFbmVLHtCzcjYGKE
         K0QQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVMRTZPk/bASEo4YF+iPPfhRz+A3u5M7AFQFQni/Krafu1NdO0iq34Iw5QK9DmvkoF1AV3anI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywnlm7pQnFd45J5PSVeCxldPaFvCTOiaV4VXEArJ3AiJuN1hs0q
	a9a1dvkQi5sUSI9DrxplUUE/6y0KhTOeDbYPdHMBG5xql9hhBVp9u7Bwl862qumWM8TQdFM56U7
	xgoeMn7URuT3nvn0+Dv4y+Cy2/p0cj5VEm+zBNQzuM4CMCYLOYLDVnB5yqA==
X-Gm-Gg: ASbGnctVqasg9o18YI9EU8JFHo4KE1uXb4W3vv54A2ZUA/2o0m4pebihy7xzKWi7s7P
	4au6tYQl/pzZ99AnGorEzi50/ykGStYr4MH+kwSRD65ejs46O4dl0cwqs1XLC6N3mcsYs60omLK
	NWkZ5eCPR3Xsf5m+cg4PeVvA29HBrZGMjN5gMYuoUvHHk1WPiNcbdlLopHd1zk8S8tOI8gUkLeU
	ZSy66SY4V8sLu5XnfD2weyhspUN9E3tjmiu+Oa+dl6K7bRM79B6DKZIZuhfmPkhhzHtq4Ir/vlQ
	u0e+FWpimDsJjuZcByt4WPQJ0FIODMpv8/TXikoJh2L3ZNSkyV6lwRcXi90sft0koZyvopGKvIE
	EUR7wbZHufnw=
X-Received: by 2002:a05:6902:4187:b0:e95:3636:fec7 with SMTP id 3f1490d57ef6-e98a575d3f7mr9810598276.3.1756802179013;
        Tue, 02 Sep 2025 01:36:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHN1rW921wMnlhkrowJD62Ue2sE0nnUiq8xQvdxYpOwafskgnuVzhDNETsAfUG/ascbcpgGRw==
X-Received: by 2002:a05:6902:4187:b0:e95:3636:fec7 with SMTP id 3f1490d57ef6-e98a575d3f7mr9810577276.3.1756802178465;
        Tue, 02 Sep 2025 01:36:18 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e00:6083:48d1:630a:25ae? ([2a0d:3344:2712:7e00:6083:48d1:630a:25ae])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e9bbdf4bfccsm409044276.10.2025.09.02.01.36.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 01:36:18 -0700 (PDT)
Message-ID: <13903eae-7a61-44d6-8e54-1d3f85799f58@redhat.com>
Date: Tue, 2 Sep 2025 10:36:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: net: usb: r8152: resume-reset deadlock
To: Sergey Senozhatsky <senozhatsky@chromium.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Takashi Iwai <tiwai@suse.de>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <a4pjgee3vncuqw5364ajocuipnfudkjnguwmmvjzz3ee3yjxzs@zxldhr5x7dkk>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <a4pjgee3vncuqw5364ajocuipnfudkjnguwmmvjzz3ee3yjxzs@zxldhr5x7dkk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/26/25 11:55 AM, Sergey Senozhatsky wrote:
> I'm looking into the following deadlock
> 
> <4>[ 1596.492101] schedule_preempt_disabled+0x15/0x30
> <4>[ 1596.492170] __mutex_lock_common+0x256/0x490
> <4>[ 1596.492209] __mutex_lock_slowpath+0x18/0x30
> <4>[ 1596.492249] __rtl8152_set_mac_address+0x80/0x1f0 [r8152 (HASH:ce6f 4)]
> <4>[ 1596.492327] dev_set_mac_address+0x7d/0x150
> <4>[ 1596.492395] rtl8152_post_reset+0x72/0x150 [r8152 (HASH:ce6f 4)]
> <4>[ 1596.492438] usb_reset_device+0x1ce/0x220
> <4>[ 1596.492507] rtl8152_resume+0x99/0xc0 [r8152 (HASH:ce6f 4)]
> <4>[ 1596.492550] usb_resume_interface+0x3c/0xc0
> <4>[ 1596.492619] usb_resume_both+0x104/0x150
> <4>[ 1596.492657] ? usb_dev_suspend+0x20/0x20
> <4>[ 1596.492725] usb_resume+0x22/0x110
> <4>[ 1596.492763] ? usb_dev_suspend+0x20/0x20
> <4>[ 1596.492800] dpm_run_callback+0x83/0x1d0
> <4>[ 1596.492873] device_resume+0x35f/0x3d0
> <4>[ 1596.492912] ? pm_verb+0xa0/0xa0
> <4>[ 1596.492951] async_resume+0x1d/0x30
> <4>[ 1596.493019] async_run_entry_fn+0x2b/0xd0
> <4>[ 1596.493060] worker_thread+0x2ce/0xef0
> <4>[ 1596.493101] ? cancel_delayed_work+0x2d0/0x2d0
> <4>[ 1596.493170] kthread+0x16d/0x190
> <4>[ 1596.493209] ? cancel_delayed_work+0x2d0/0x2d0
> <4>[ 1596.493247] ? kthread_associate_blkcg+0x80/0x80
> <4>[ 1596.493316] ret_from_fork+0x1f/0x30
> 
> rtl8152_resume() seems to be tricky, because it's under tp->control
> mutex, when it can see RTL8152_INACCESSIBLE and initiate a full
> device reset via usb_reset_device(), which eventually re-enters rtl8152,
> at which point it calls __rtl8152_set_mac_address() and deadlocks on
> tp->control (I assume) mutex.

Decoding the above stack trace will tell for sure.

> __rtl8152_set_mac_address() has in_resume flag (added by Takashi in
> 776ac63a986d), which is set only in "reset_resume" case, wheres what
> we have is "resume_reset".  Moreover in_resume flag is not for tp->control
> mutex, as far as I can tell, but for PM lock.  When we set_mac_address
> from resume_reset, we lose in_resume flat, so not only we deadlock on
> tp->control mutex, but also we may (I guess) deadlock on the PM lock.
> 
> Also, we still call rtl8152_resume() even in reset_resume, which I
> assume still can end up resetting device and hence in set_mac_address()
> in non-in_resume mode, potentially triggering the same deadlock that
> Takashi fixed.  Well, unless I'm missing something.
> 
> So I don't think I want to add another flag to mark "current owns tp->control
> mutex" so that we can handle re-entry.  How about moving usb reset
> outside of tp->control scope?  Is there any harm in doing that?

According to commit 4933b066fefbee4f1d2d708de53c4ab7f09026ad, the
usb_reset_device() call is intentionally under tp->control protection to
vs double reset.

At very least the proposed code here could end-up causing an unexpected
reset when SELECTIVE_SUSPEND is set.

I *guess* you should track the current status explicitly to restrict the
reset at in the !test_bit(SELECTIVE_SUSPEND) scenario and explicitly
avoid delayed reset during resume.

Ad very least you should add a fixes tag, a proper Sob and use canonical
commit references.

Thanks,

Paolo


