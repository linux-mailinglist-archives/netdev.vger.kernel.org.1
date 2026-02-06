Return-Path: <netdev+bounces-257455-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WORoMndhhWnbAwQAu9opvQ
	(envelope-from <netdev+bounces-257455-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 04:35:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFB1F9C6E
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 04:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C6708300CFEE
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 03:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1043E330D50;
	Fri,  6 Feb 2026 03:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mOTDFm7r"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B659265CC2
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 03:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770348915; cv=none; b=pn7bygOZ1CG2gF4aomSiSzyiooD4gOb4IN7533+TKvRkIrDVGU1PkMDwF30dSGIhpo6Wbtk9F7OeS6xgbuFxHjIOFhYFSUX1paQvAQFD4OzK90K6QLt10pqvBuFqbgcEoHY4GOMDbWaycr5wwE1SRmL+THaanOctuucPiuPjJX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770348915; c=relaxed/simple;
	bh=zNLUCn+s3307tWJKOW8nl1ChLfyqc/MhWr0dROO0BDc=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=q5o9eTQ2uMyNMoamwk/arhCez7YdQ3VPZHccKcs9TukxGeKNhPWtHkSdJLyJF/2hz3zYb4iwGLD6BYWivYX3zw1TYWv/pRBqTgVk13pMNfL+yJstMvlzCQqN4m12J7Q4Lw3rtYTpDTMGloVI4aePSvJ+DRNFAgE7m151JtafGhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mOTDFm7r; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770348902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=10F/Sy14y3AMrPVp4lmzCn45jdgBQxQw8Noz3nolNMU=;
	b=mOTDFm7r8J77ILOTBr+4GVl3UEuwlfWSKsB/m9Ey+jpNYNX6jOqi2gaFYKWYuTPQX5Q3ew
	B+4o55IvT26EF7crNQr919/GnuisNTzJqEHDf99sRSO84A+RSv1BHYGDJ2XRnkoXmX79k4
	JI0yUegseByDPSVHD3cdvyMJHDYj2y4=
Date: Fri, 06 Feb 2026 03:34:59 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Message-ID: <26ced687d905dc152cb66660f9cf864b22b4df37@linux.dev>
TLS-Required: No
Subject: Re: [net,v1] serial: caif: fix use-after-free in caif_serial
 ldisc_close()
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: "Jakub Kicinski" <kuba@kernel.org>, andrew+netdev@lunn.ch,
 horms@kernel.org, jiayuan.chen@shopee.com, pabeni@redhat.com,
 jirislaby@kernel.org, sjur.brandeland@stericsson.com,
 gregkh@linuxfoundation.org, netdev@vger.kernel.org,
 syzbot+827272712bd6d12c79a4@syzkaller.appspotmail.com,
 davem@davemloft.net, linux-kernel@vger.kernel.org, edumazet@google.com
In-Reply-To: <20260206022526.3191971-1-kuba@kernel.org>
References: <20260204081939.237738-1-jiayuan.chen@linux.dev>
 <20260206022526.3191971-1-kuba@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257455-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev,827272712bd6d12c79a4];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:url,linux.dev:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4EFB1F9C6E
X-Rspamd-Action: no action

February 6, 2026 at 10:25, "Jakub Kicinski" <kuba@kernel.org mailto:kuba@=
kernel.org?to=3D%22Jakub%20Kicinski%22%20%3Ckuba%40kernel.org%3E > wrote:


Thanks for the review.

>=20
>=20This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
>=20
>=20For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-=
local.html
> ---
> serial: caif: fix use-after-free in caif_serial ldisc_close()
>=20
>=20This commit fixes a use-after-free bug in the CAIF serial driver by
> moving the tty_kref_put() call from ldisc_close() to ser_release(),
> ensuring the tty reference is held as long as the network device exists=
.
>=20
>=20Closes: https://lore.kernel.org/all/000000000000a4a7550611e234f5@goog=
le.com/T/
>=20
>=20>=20
>=20> serial: caif: fix use-after-free in caif_serial ldisc_close()
> >=20
>=20>  There is a use-after-free bug in caif_serial where handle_tx() may
> >  access ser->tty after the tty has been freed.
> >=20
>=20>  The race condition occurs between ldisc_close() and packet transmi=
ssion:
> >=20
>=20>  CPU 0 (close) CPU 1 (xmit)
> >  ------------- ------------
> >  ldisc_close()
> >  tty_kref_put(ser->tty)
> >  [tty may be freed here]
> >  <-- race window -->
> >  caif_xmit()
> >  handle_tx()
> >  tty =3D ser->tty // dangling ptr
> >  tty->ops->write() // UAF!
> >  schedule_work()
> >  ser_release()
> >  unregister_netdevice()
> >=20
>=20>  The root cause is that tty_kref_put() is called in ldisc_close() w=
hile
> >  the network device is still active and can receive packets.
> >=20
>=20>  Since ser and tty have a 1:1 binding relationship with consistent
> >  lifecycles (ser is created/destroyed in ldisc_open/close, and each s=
er
> >  binds exactly one tty), we can safely defer the tty reference releas=
e
> >=20
>=20The statement "ser is created/destroyed in ldisc_open/close" isn't qu=
ite
> accurate. While ser is created in ldisc_open() via alloc_netdev(), it's
> not actually destroyed in ldisc_close(). Instead, ldisc_close() only mo=
ves
> ser to the release list via list_move(&ser->node, &ser_release_list).
> The actual destruction happens in ser_release() when unregister_netdevi=
ce()
> is called, which eventually frees the netdev and embedded ser via
> netdev_run_todo() invoked by rtnl_unlock(). Would it be more accurate t=
o
> say ser is destroyed in ser_release()?

The description of ser's lifecycle is imprecise - ser is indeed not destr=
oyed
in ldisc_close() but rather in ser_release() via unregister_netdevice().

I'll update the commit message to clarify this.


[...]
> >=20
>=20>  Note: There is a separate deadloop issue in handle_tx() when using
> >  PORT_UNKNOWN serial ports (e.g., /dev/ttyS3 in QEMU without proper
> >  serial backend). This deadloop exists even without this patch,
> >  and is caused by an independent bug: inconsistency between
> >  uart_write_room() and uart_write() in serial core. It has been
> >  addressed in a separate patch [2].
> >=20
>=20The claim about the deadloop being caused by inconsistency between
> uart_write_room() and uart_write() couldn't be fully verified without
> examining the referenced patch [2]. While the claim is plausible (if
> uart_write_room() reports available space but uart_write() returns 0
> bytes written, the deadloop would occur in handle_tx()), this appears
> to be presented as fact rather than hypothesis. Could this be clarified
> or softened to indicate it's the suspected cause pending verification?


The deadloop is not a hypothesis - it's a confirmed, independently reprod=
ucible bug.
My reproducer can trigger the use-after-free; after applying this fix (or=
 disabling KASAN), the same
reproducer hits the deadloop, which also reproduces without this patch at=
 all.

The separate fix [2] has been partially confirmed by Greg Kroah-Hartman.

I don't think any change is needed here.

> [ ... ]
>=20
>=20>=20
>=20> Fixes: 9b27105b4a44 ("net-caif-driver: add CAIF serial driver (ldis=
c)")
> >=20
>=20The Fixes: tag appears to reference the wrong commit. The bug was act=
ually
> introduced by commit 56e0ef527b18 ("drivers/net: caif: fix wrong
> rtnl_is_locked() usage"). The original commit 9b27105b4a44 didn't have =
any
> tty_kref operations. Commit e31d5a05948e added tty_kref_get/put, but at
> that time tty_kref_put was called in ldisc_close() which directly
> unregistered the netdevice, so there was no race. Commit 56e0ef527b18
> moved dev_close/unregister_netdevice to a work queue (ser_release) but
> left tty_kref_put in ldisc_close, creating the race window. Should the
> Fixes: tag be updated to:
>=20
>=20Fixes: 56e0ef527b18 ("drivers/net: caif: fix wrong rtnl_is_locked() u=
sage")


You're right about the Fixes tag. I'll update the Fixes tag accordingly.

> >=20
>=20> diff --git a/drivers/net/caif/caif_serial.c b/drivers/net/caif/caif=
_serial.c
> >  --- a/drivers/net/caif/caif_serial.c
> >  +++ b/drivers/net/caif/caif_serial.c
> >  @@ -284,6 +284,7 @@ static void ser_release(struct work_struct *work=
)
> >  {
> >  struct list_head list;
> >  struct ser_device *ser, *tmp;
> >  + struct tty_struct *tty;
> >=20
>=20>  spin_lock(&ser_lock);
> >  list_replace_init(&ser_release_list, &list);
> >  @@ -292,9 +293,11 @@ static void ser_release(struct work_struct *wor=
k)
> >  if (!list_empty(&list)) {
> >  rtnl_lock();
> >  list_for_each_entry_safe(ser, tmp, &list, node) {
> >  + tty =3D ser->tty;
> >  dev_close(ser->dev);
> >  unregister_netdevice(ser->dev);
> >  debugfs_deinit(ser);
> >  + tty_kref_put(tty);
> >  }
> >  rtnl_unlock();
> >  }
> >=20
>=20[ ... ]
>=20
>=20>=20
>=20> @@ -354,8 +357,6 @@ static int ldisc_open(struct tty_struct *tty)
> >  static void ldisc_close(struct tty_struct *tty)
> >  {
> >  struct ser_device *ser =3D tty->disc_data;
> >  -
> >  - tty_kref_put(ser->tty);
> >=20
>=20>  spin_lock(&ser_lock);
> >  list_move(&ser->node, &ser_release_list);
> >=20
>=20--=20
>=20pw-bot: cr
>

