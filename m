Return-Path: <netdev+bounces-258815-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6I0MD9VjkmmhtgEAu9opvQ
	(envelope-from <netdev+bounces-258815-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 01:24:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE91140733
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 01:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 458203009179
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 00:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A83243376;
	Mon, 16 Feb 2026 00:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="J3SVqDYV"
X-Original-To: netdev@vger.kernel.org
Received: from r3-19.sinamail.sina.com.cn (r3-19.sinamail.sina.com.cn [202.108.3.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1911A1A317D
	for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 00:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771201489; cv=none; b=oxy53hG5QW4lFn7H2L4xdLlGlOGfHLYpdH435lyJOn8vF4N4wNUhTy/0RXY9x+qSUJ6rtW895+Y9bJeH2gluNLmKlSdHHun7erUk59b8+GTD6XkEqyWD73y7AqSLt8I07IZMiXcvW1TiEfPVSPzfTyuZzTtZDYbwlShIB8D7ZwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771201489; c=relaxed/simple;
	bh=tjGxmyA1ofYXGJt2E5hGcWP9CvbSQjwK08aV25c16xs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eLvPpvQ4PAnYI3FzHLIt1fHBzZHpMaIPEe+m4p1QS5YK2LY/ulWpYVM3PN7Bo58fbjjJ2wJIAoVZm1fICW+3LNE7ZlkfwO4drn4hR2kjjFdaAMHwjrT3AuE2Sw2V1/lFrK7IepxwQpk53BR5cwY+hqdOYuVlqcWt6TRHCpzUIWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=J3SVqDYV; arc=none smtp.client-ip=202.108.3.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1771201486;
	bh=2d5JqkSKmCl+h/DkDuPedLTA33Petj9L1eNR5vAuIVA=;
	h=From:Subject:Date:Message-ID;
	b=J3SVqDYVf7ZQM/217belDyhgr1LQb+ZGA0A3yXTWmDfCFRE2Q8n5MubStxYe/KbUo
	 dN0IX79j//yBuAYx+A5tYocM5S3+we3VKABmKLH9aohIW8pC1W14AWn3zt35GHwOPu
	 bUdctjbyr6kaJZ6nf9Rtj71XATsAtd5azzhM7ERQ=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.62.144])
	by sina.com (10.54.253.32) with ESMTP
	id 699263C300002AF9; Mon, 16 Feb 2026 08:24:37 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 3763764456638
X-SMAIL-UIID: B619DCA30F1C498090FDE6828E84EE81-20260216-082437-1
From: Hillf Danton <hdanton@sina.com>
To: Shuangpeng <shuangpeng.kernel@gmail.com>
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	linux-kernel@vger.kernel.org,
	Jiayuan Chen <jiayuan.chen@shopee.com>
Subject: Re: [PATCH net v2 1/1] serial: caif: fix remaining ser->tty UAF in TX path
Date: Mon, 16 Feb 2026 08:24:23 +0800
Message-ID: <20260216002425.3101-1-hdanton@sina.com>
In-Reply-To: <2CCEDE30-6BDF-4815-9975-40EF6C982520@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
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
	TAGGED_FROM(0.00)[bounces-258815-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[sina.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hdanton@sina.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DBE91140733
X-Rspamd-Action: no action

On Sun, 15 Feb 2026 14:22:02 -0500 Shuangpeng Bai wrote:
>> On Feb 15, 2026, at 03:55, Hillf Danton <hdanton@sina.com> wrote:
>> On Sat, 14 Feb 2026 21:51:41 -0500 Shuangpeng Bai wrote:
>>> A reproducer exposes a KASAN use-after-free in caif_serial's TX path
>>> (e.g., via tty_write_room() / tty->ops->write()) on top of commit
>>> <308e7e4d0a84> ("serial: caif: fix use-after-free in caif_serial
>>> ldisc_close()").
>>> 
>>> That commit moved tty_kref_put() to ser_release(). There is still a race
>>> because the TX path may fetch ser->tty and use it while ser_release()
>>> drops the last tty reference:
>>> 
>>>    CPU 0 (ser_release worker)         CPU 1 (xmit)
>>>    -------------------------        ------------
>>>                                      caif_xmit()
>>>                                      handle_tx()
>>>                                        tty = ser->tty
>>> 
>>>    ser_release()
>>>      tty = ser->tty
>>>      dev_close(ser->dev)
>>>      unregister_netdevice(ser->dev)
>>>      debugfs_deinit(ser)
>>>      tty_kref_put(tty)        // may drop the last ref
>>>                     <-- race window -->
>>>                                        tty->ops->write(tty, ...)  // UAF
>>> 
>> What is unclear is -- why is the xmit callback still active after
>> unregister_netdevice().
>
> In my understanding, no new ndo_start_xmit should begin after
> unregister_netdevice() has completed, but an in-flight TX still needs
> proper synchronization with teardown.
>
Could you shed some light on that sync Eric? Is it missed?

