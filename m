Return-Path: <netdev+bounces-258761-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aRdtFwyKkWnkjgEAu9opvQ
	(envelope-from <netdev+bounces-258761-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 09:55:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9380A13E550
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 09:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 51B3B300B86E
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 08:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D84125C704;
	Sun, 15 Feb 2026 08:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="BUHT7Gkz"
X-Original-To: netdev@vger.kernel.org
Received: from r3-22.sinamail.sina.com.cn (r3-22.sinamail.sina.com.cn [202.108.3.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495C817C69
	for <netdev@vger.kernel.org>; Sun, 15 Feb 2026 08:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771145731; cv=none; b=gRpOeWxmMtcOfUMG14xWrfxfwyezyKOIHiO+5s2AMiiwHKZt/7nIczS3d0m/aa5JJpkyFcJYNoP0tg9p1FLwKmQvzzOjH3WEiJQQVC7VwKuwW7+VVr5DUGd47nW9i8bwZ4zUxwoNhLnqN+2J1FFrcH6ZwI8yWaaW+IvfOcitsgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771145731; c=relaxed/simple;
	bh=+YKfAsN1shltS4gZF1P/OdcfDpj38qDhhn6RJWOcw4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IE6ckmfIHelmZ2puEsC95D2hrBxWTMlP3milW8/o2NXE9cy1JRAGzM8lvow02Hpd7geR5z1MXPSesEzy9ty98sgH+gB0LuD9ocQYmt8X6Bsyoz3Bv2pVOsIW0xTzZvXp8xOKcFmg0puVL/yP6OWu62igkAEfVZyJwjk7E3DZYhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=BUHT7Gkz; arc=none smtp.client-ip=202.108.3.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1771145728;
	bh=KBSUM04KzyVvFZil1ohZX3MuQI4AoMuVt2ux4kLo3pY=;
	h=From:Subject:Date:Message-ID;
	b=BUHT7GkzaCyBZUTy48F4Fc7rKZ3rSL2lLD/iucKCRk3nY2LQ1L65KHm/NpjFAOMU2
	 CR2m8DBTvhMsoyQ/1jazSOIxW3q/4jzYwysK/zsha1OglcAgXo8LXX5y0r4w4fLJUC
	 eESyP2IYfwDV+DTtz0yQjHrs0U4lh8YmpY1cT8DU=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.62.144])
	by sina.com (10.54.253.33) with ESMTP
	id 699189F6000010F7; Sun, 15 Feb 2026 16:55:19 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 7946796685282
X-SMAIL-UIID: 8F20B84913E44431A0A159B29BA09261-20260215-165519-1
From: Hillf Danton <hdanton@sina.com>
To: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	linux-kernel@vger.kernel.org,
	Jiayuan Chen <jiayuan.chen@shopee.com>
Subject: Re: [PATCH net v2 1/1] serial: caif: fix remaining ser->tty UAF in TX path
Date: Sun, 15 Feb 2026 16:55:08 +0800
Message-ID: <20260215085510.3081-1-hdanton@sina.com>
In-Reply-To: <20260215025141.1106576-2-shuangpeng.kernel@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-258761-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[sina.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hdanton@sina.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sina.com:mid,sina.com:dkim]
X-Rspamd-Queue-Id: 9380A13E550
X-Rspamd-Action: no action

On Sat, 14 Feb 2026 21:51:41 -0500 Shuangpeng Bai wrote:
> A reproducer exposes a KASAN use-after-free in caif_serial's TX path
> (e.g., via tty_write_room() / tty->ops->write()) on top of commit
> <308e7e4d0a84> ("serial: caif: fix use-after-free in caif_serial
> ldisc_close()").
> 
> That commit moved tty_kref_put() to ser_release(). There is still a race
> because the TX path may fetch ser->tty and use it while ser_release()
> drops the last tty reference:
> 
>     CPU 0 (ser_release worker)         CPU 1 (xmit)
>     -------------------------        ------------
>                                       caif_xmit()
>                                       handle_tx()
>                                         tty = ser->tty
> 
>     ser_release()
>       tty = ser->tty
>       dev_close(ser->dev)
>       unregister_netdevice(ser->dev)
>       debugfs_deinit(ser)
>       tty_kref_put(tty)        // may drop the last ref
>                      <-- race window -->
>                                         tty->ops->write(tty, ...)  // UAF
> 
What is unclear is -- why is the xmit callback still active after
unregister_netdevice().

