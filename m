Return-Path: <netdev+bounces-258957-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDtaGq6vk2nV7gEAu9opvQ
	(envelope-from <netdev+bounces-258957-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 01:00:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E31D8148294
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 01:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B3E47300888E
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 00:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D015C433AD;
	Tue, 17 Feb 2026 00:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="PjxqYSIi"
X-Original-To: netdev@vger.kernel.org
Received: from r3-11.sinamail.sina.com.cn (r3-11.sinamail.sina.com.cn [202.108.3.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF86D1A285
	for <netdev@vger.kernel.org>; Tue, 17 Feb 2026 00:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771286443; cv=none; b=Jigt8FbPEL1pWjTtUngTdy5QC3L5o05uHrQSJd9h0IrxvPDVXQ0AZuH0LZgImR8GQqlFw27KQJF+t9c8vhRAdyCEhWwFE0oE0CjGv5385DFqV4bc4cu3KzTmon6Z10EZCfj0pAx7Qvx1LU03afa+AYw13mSTRjAK4w1qYzyyHeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771286443; c=relaxed/simple;
	bh=ZPScBGlH+YhvzeHK/qDaYZPWySLexkj6mj+sQx6QuZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rLbMOPtdYU7kZg73XSjgom5B3PmNJ4RXPvLm8yPnAwaKbYnwb+qPiSbibXeRT17GyE/5BFeRlmN29TsonCVvpMOpu9I2FeTbpLZaLosc1tuEeWwRqlu9hL27aG1Cir42lu9DXbe1/r3YRjt7jnAlGqnO8lzLMHxa4edCU9tg9Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=PjxqYSIi; arc=none smtp.client-ip=202.108.3.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1771286441;
	bh=mOAMk3ZHywajhbdBeCXYW3iBJGag5uKMzd/2eHh/unI=;
	h=From:Subject:Date:Message-ID;
	b=PjxqYSIi5+57xlNikYo6zUp6dwWVGwl/X+zIPPH3XvMtTja76hTuN5NXIdjpNhnFF
	 k27sFeMQ69uhBPY5pE6EPZItCcSaZO0MvKaJnOnO5z2hC1r7lv8u4qemKZUl3puVrE
	 6fswPc33J7teKFGq3+BkO3jHoA5KrhGtnEu8iZog=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.62.144])
	by sina.com (10.54.253.34) with ESMTP
	id 6993AF7900001FBB; Mon, 17 Feb 2026 07:59:55 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 4670536292010
X-SMAIL-UIID: 40A822055A1B42F6AEC58703146F2440-20260217-075955-1
From: Hillf Danton <hdanton@sina.com>
To: Shuangpeng <shuangpeng.kernel@gmail.com>
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	linux-kernel@vger.kernel.org,
	Jiayuan Chen <jiayuan.chen@shopee.com>
Subject: Re: [PATCH net v2 1/1] serial: caif: fix remaining ser->tty UAF in TX path
Date: Tue, 17 Feb 2026 07:59:36 +0800
Message-ID: <20260216235944.3212-1-hdanton@sina.com>
In-Reply-To: <20260216002425.3101-1-hdanton@sina.com>
References: 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[sina.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[sina.com:s=201208];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[sina.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-258957-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[sina.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hdanton@sina.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sina.com:mid,sina.com:dkim,sina.com:email]
X-Rspamd-Queue-Id: E31D8148294
X-Rspamd-Action: no action

On Mon, 16 Feb 2026 08:24:23 +0800 Hillf Danton wrote:
>On Sun, 15 Feb 2026 14:22:02 -0500 Shuangpeng Bai wrote:
>>> On Feb 15, 2026, at 03:55, Hillf Danton <hdanton@sina.com> wrote:
>>> On Sat, 14 Feb 2026 21:51:41 -0500 Shuangpeng Bai wrote:
>>>> A reproducer exposes a KASAN use-after-free in caif_serial's TX path
>>>> (e.g., via tty_write_room() / tty->ops->write()) on top of commit
>>>> <308e7e4d0a84> ("serial: caif: fix use-after-free in caif_serial
>>>> ldisc_close()").
>>>> 
>>>> That commit moved tty_kref_put() to ser_release(). There is still a race
>>>> because the TX path may fetch ser->tty and use it while ser_release()
>>>> drops the last tty reference:
>>>> 
>>>>    CPU 0 (ser_release worker)         CPU 1 (xmit)
>>>>    -------------------------        ------------
>>>>                                      caif_xmit()
>>>>                                      handle_tx()
>>>>                                        tty = ser->tty
>>>> 
>>>>    ser_release()
>>>>      tty = ser->tty
>>>>      dev_close(ser->dev)
>>>>      unregister_netdevice(ser->dev)
>>>>      debugfs_deinit(ser)
>>>>      tty_kref_put(tty)        // may drop the last ref
>>>>                     <-- race window -->
>>>>                                        tty->ops->write(tty, ...)  // UAF
>>>> 
>>> What is unclear is -- why is the xmit callback still active after
>>> unregister_netdevice().
>>
>> In my understanding, no new ndo_start_xmit should begin after
>> unregister_netdevice() has completed, but an in-flight TX still needs
>> proper synchronization with teardown.
>>
> Could you shed some light on that sync Eric? Is it missed?
>
So far I found a syzbot report [1] where ser->dev can not be closed with an
active xmit cb.

[1] Subject: [syzbot] [net?] BUG: soft lockup in ser_release (4)
https://lore.kernel.org/lkml/6758196a.050a0220.a30f1.01c9.GAE@google.com/

