Return-Path: <netdev+bounces-152744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E04139F5B1C
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 01:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CEA6163C78
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 00:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D903C191;
	Wed, 18 Dec 2024 00:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E0Cv2Ygl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086062F2A
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 00:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734480451; cv=none; b=jVpMsfwbU+jnpx+ug4RWoiaLRsJn5VqgM6AGuQN775s7zouI8CtxR0IIEdtiO3hGBZ7EERHCjfXnIu8gDr0Ogiw2KSmnMjFpbACHHFAxb73ARDH/F4iD9+zW8gT20Pbiij/PlL68wnUPFkO3W6UrsVoi44dXfbpJx0Aln9pbHik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734480451; c=relaxed/simple;
	bh=j7uA8fVKMd9CEijahcXeOUavdMw9m+h9aGl/+h5swJU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=c5E9rK+OFNhh3LpHkl/Hopvu0j1jprjrpULyFw791BZSmfID3jHEv6cQFpBvElkZQ9aJFLAYX0CGs7buQHh22DwAGpWervfSIbtbBltLcNoGe6x0vxZ8LOdfFz6QxoQYgKri7aElwCnWo57unGAAfD739xBDOvpXKALy6gvlrYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E0Cv2Ygl; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3862d16b4f5so152912f8f.0
        for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 16:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734480448; x=1735085248; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CqNThULah4PzV7al9vVXXlqGBtf7kZ43w5+oGKHtVU0=;
        b=E0Cv2Ygl8j6CPNQb01KLTj2fHKSaPpx6awbEJQOloTpS5KcISMd0lrqZIu4WG/l0mv
         Q5nIAJF8o3gXOZHTbqySWr1AhQ1jPJnZYt5OGg5m5P2Ov8PC4dgYfxCeGwB7SHKe15O8
         c8bFnEHiCVAs2bEYI2z2DVZdFyh18wrNFtyXwXvX4JIpVdMJlx8Cnx8Mxyg/qJYzydhU
         l/FigRzrxUANNAWbd60iL+p9Rll+kyoSqeJ9nojT7JWEcFewe5EkIiAwaIFIA0Zs1dVE
         uoeR28I4PiLVDMtznqLk8h0TKk8CWQtmOGKieqxlLENFOivgIpejyVssJIBcfdhyod6+
         10YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734480448; x=1735085248;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CqNThULah4PzV7al9vVXXlqGBtf7kZ43w5+oGKHtVU0=;
        b=EFb52d6cfHYznkXMLW7kY4Fiafk4sSZrBubxTY13/q3H0+9wpOFjmOpctUe7ucxZMD
         SOVmIOnsOUdAdXzKQ9fg2jK4jPDE7EWKE8opNgsojtco6DCmOVRuKrPWfNG9FbcNdMq9
         W1yMCBGvZCK9HfRCGVUDGMruT12NKjN/YomTmfQpNy2XqNkoFZAU+/4vNpeDFFXk9qXE
         AONV+f4BjC4ihCX9dmgLT8mPAgRDlZAWQ8/i6ygBZ3Uv7EYrOa2Gh4RYFKb02+Sz0iPs
         XeHi8DHPUDi3IuDIuAzBgPGqoHiunEYF2KsjyhTUw4UDvqNb5Ibm0eKMq77qX81aRI8n
         qJjw==
X-Forwarded-Encrypted: i=1; AJvYcCWp3SS5HzJ7iq1MvO5j5Y4HZLsqfemGrVG2XP36wYYmfgqpKhbem/gq8IFD1GthpIF5Kyg2bKM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh9FokGpOfQECINDzjoeNtm+mC5TTDfBpvqwT+BEBgsEu5YsNF
	4AoPYG2DxWmHVXfCJWATGichBWHSzyNYuVK61El4qG3995zbpGGCCtYzgf6gHLDzno7EJwGtv2Q
	CI31mb3SxZprir0R5EllKK7cGTe+jatD4
X-Gm-Gg: ASbGncupKjOcxjoLSv5vNlc9DZkKEEV56Jl7u8RyqWvhpWWbuVUz+Jd+rDhzVUXv7CE
	6zjd4BlZ3Te9sl5h3wsl9AlLIOaKB8OfS078arxg4TLOgCji/0zC44g==
X-Google-Smtp-Source: AGHT+IFntzPJB8kApDo4bzhZWKogR+xtOyJcajgjC5P1zItdiybBrTxuqTa1veYv7m2j4XUM2BLzJ+gFL1wE9xVIESI=
X-Received: by 2002:a05:6000:2a6:b0:385:f138:97ac with SMTP id
 ffacd0b85a97d-388e4e15136mr391850f8f.1.1734480448109; Tue, 17 Dec 2024
 16:07:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 17 Dec 2024 16:07:16 -0800
Message-ID: <CAADnVQKkCLaj=roayH=Mjiiqz_svdf1tsC3OE4EC0E=mAD+L1A@mail.gmail.com>
Subject: xfrm in RT
To: Sebastian Sewior <bigeasy@linutronix.de>, Network Development <netdev@vger.kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>
Content-Type: text/plain; charset="UTF-8"

Hi,

Looks like xfrm isn't friendly to PREEMPT_RT.
xfrm_input_state_lookup() is doing:

int cpu = get_cpu();
...
spin_lock_bh(&net->xfrm.xfrm_state_lock);

which causes a splat:

[  811.175877] BUG: sleeping function called from invalid context at
kernel/locking/spinlock_rt.c:48
[  811.175884] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid:
13785, name: ping
[  811.175886] preempt_count: 1, expected: 0
[  811.175888] RCU nest depth: 6, expected: 6
[  811.175889] INFO: lockdep is turned off.
[  811.175891] CPU: 9 UID: 0 PID: 13785 Comm: ping Tainted: G        W
 O       6.13.0-rc3-00067-ga3c4183875d5-dirty #2
[  811.175900] Call Trace:
[  811.175901]  <TASK>
[  811.175902]  dump_stack_lvl+0x80/0x90
[  811.175911]  __might_resched+0x2c7/0x480
[  811.175917]  rt_spin_lock+0xbd/0x240
[  811.175922]  ? rtlock_slowlock_locked+0x4cd0/0x4cd0
[  811.175925]  xfrm_input_state_lookup+0x643/0xa10
[  811.175930]  ? skb_ext_add+0x4dd/0x690
[  811.175934]  ? xfrm_state_lookup+0x1d0/0x1d0
[  811.175937]  ? __asan_memset+0x23/0x40
[  811.175940]  xfrm_input+0x78c/0x5820
[  811.175943]  ? reacquire_held_locks+0x4d0/0x4d0
[  811.175948]  ? bpf_prog_1a2cc90c3a1be51f_xfrm_get_state+0x31/0x7d
[  811.175978]  ? fib_multipath_hash+0x1190/0x1190
[  811.175983]  ? cls_bpf_classify+0x4ad/0x12e0
[  811.176001]  ? xfrm_rcv_cb+0x270/0x270
[  811.176001]  ? raw_rcv+0x6c0/0x6c0
[  811.176001]  xfrm4_esp_rcv+0x80/0x190
[  811.176001]  ip_protocol_deliver_rcu+0x82/0x300
[  811.176001]  ip_local_deliver_finish+0x29b/0x420
[  811.176001]  ip_local_deliver+0x17b/0x400
[  811.176001]  ? ip_local_deliver_finish+0x420/0x420
[  811.176001]  ? lock_release+0x464/0x640
[  811.176001]  ? rcu_read_lock_held+0xe/0x50
[  811.176001]  ? ip_rcv_finish_core.isra.0+0x943/0x1f80
[  811.176001]  ip_sublist_rcv_finish+0x84/0x230
[  811.176001]  ip_sublist_rcv+0x3e2/0x780
[  811.176001]  ? ip_rcv_finish_core.isra.0+0x1f80/0x1f80
[  811.176001]  ? do_xdp_generic+0xbf0/0xbf0
[  811.176001]  ? xfrm_state_lookup+0xf5/0x1d0
[  811.176001]  ? ip_sublist_rcv+0x780/0x780
[  811.176001]  ip_list_rcv+0x266/0x360

