Return-Path: <netdev+bounces-256610-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOfTDLwDg2njggMAu9opvQ
	(envelope-from <netdev+bounces-256610-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 09:30:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F14E3292
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 09:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0F0B630059BC
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 08:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33DF285068;
	Wed,  4 Feb 2026 08:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HolZxPob"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D157117BA2;
	Wed,  4 Feb 2026 08:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770193849; cv=none; b=Mn8j3F/j1TPxnZUTToPNm+Bdd6y8O/jYOoDjwcZGNf3IM193pV8TN6gzO1i5xVXi9aRbUTqY2dPBNtvYcBh+qX2aUXXle27GNwk8QbBQ9mjte15pKX+vWOUGZw5gXlm1sG2qkh8/o/UegRxLOfQLfE497TKVYIJtyuFw8u3psHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770193849; c=relaxed/simple;
	bh=f1XOyGEW8HF9NuhA6WUV2MZlh7pgL/NfCcbszF3+/P4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J6jxZkbRypCIzR5RR/AnXS01XP5fY7H+qGRS//f3E1saYNcsHvh9VoLTZ8ekXtIo6URg2HyfRa/BL45Dc2LbaMTynbtE+juY4jNJjs+FhW7lXN1cPMbp7KSbotQjkNqvD3/yhIv2xGASPS9/biHN2IGQqy5aVFWHNzzeY1sPw28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HolZxPob; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A34F2C4CEF7;
	Wed,  4 Feb 2026 08:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770193849;
	bh=f1XOyGEW8HF9NuhA6WUV2MZlh7pgL/NfCcbszF3+/P4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HolZxPobqtpIPTJcgyVh8sDCjrgIv5JEasbc73jtfH70FjI3aJ+hltATU/tfFmyA9
	 PauRhZfHriZzXTFMEJq1kkAwsTfOQBKO2QU9Q+mHEG30VObqEKLBHddvDhbLmR1hhA
	 G1DPHIFpkJVYXs7Go3UlF+qONh00tjxW0MCioxRM=
Date: Wed, 4 Feb 2026 09:30:45 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Jiayuan Chen <jiayuan.chen@shopee.com>,
	syzbot+827272712bd6d12c79a4@syzkaller.appspotmail.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Sjur Braendeland <sjur.brandeland@stericsson.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v1] serial: caif: fix use-after-free in caif_serial
 ldisc_close()
Message-ID: <2026020421-wrist-cupbearer-2a2b@gregkh>
References: <20260204081939.237738-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204081939.237738-1-jiayuan.chen@linux.dev>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256610-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[netdev,827272712bd6d12c79a4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,shopee.com:email,linux.dev:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B0F14E3292
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 04:19:33PM +0800, Jiayuan Chen wrote:
> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> 
> There is a use-after-free bug in caif_serial where handle_tx() may
> access ser->tty after the tty has been freed.
> 
> The race condition occurs between ldisc_close() and packet transmission:
> 
>     CPU 0 (close)                     CPU 1 (xmit)
>     -------------                     ------------
>     ldisc_close()
>       tty_kref_put(ser->tty)
>       [tty may be freed here]
>                      <-- race window -->
>                                       caif_xmit()
>                                         handle_tx()
>                                           tty = ser->tty  // dangling ptr
>                                           tty->ops->write() // UAF!
>       schedule_work()
>         ser_release()
>           unregister_netdevice()
> 
> The root cause is that tty_kref_put() is called in ldisc_close() while
> the network device is still active and can receive packets.
> 
> Since ser and tty have a 1:1 binding relationship with consistent
> lifecycles (ser is created/destroyed in ldisc_open/close, and each ser
> binds exactly one tty), we can safely defer the tty reference release
> to ser_release() where the network device is unregistered.
> 
> Fix this by moving tty_kref_put() from ldisc_close() to ser_release(),
> after unregister_netdevice(). This ensures the tty reference is held
> as long as the network device exists, preventing the UAF.
> 
> Note: We save ser->tty before unregister_netdevice() because ser is
> embedded in netdev's private data and will be freed along with netdev
> (needs_free_netdev = true).
> 
> How to reproduce: Add mdelay(500) at the beginning of ldisc_close()
> to widen the race window, then run the reproducer program [1].
> 
> Note: There is a separate deadloop issue in handle_tx() when using
> PORT_UNKNOWN serial ports (e.g., /dev/ttyS3 in QEMU without proper
> serial backend). This deadloop exists even without this patch,
> and is caused by an independent bug: inconsistency between
> uart_write_room() and uart_write() in serial core. It has been
> addressed in a separate patch [2].
> 
> KASAN report:
> 
> ==================================================================
> BUG: KASAN: slab-use-after-free in handle_tx+0x5d1/0x620
> Read of size 1 at addr ffff8881131e1490 by task caif_uaf_trigge/9929
> 
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x10e/0x1f0
>  print_report+0xd0/0x630
>  kasan_report+0xe4/0x120
>  handle_tx+0x5d1/0x620
>  dev_hard_start_xmit+0x9d/0x6c0
>  __dev_queue_xmit+0x6e2/0x4410
>  packet_xmit+0x243/0x360
>  packet_sendmsg+0x26cf/0x5500
>  __sys_sendto+0x4a3/0x520
>  __x64_sys_sendto+0xe0/0x1c0
>  do_syscall_64+0xc9/0xf80
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f615df2c0d7
> 
> Allocated by task 9930:
> 
> Freed by task 64:
> 
> Last potentially related work creation:
> 
> The buggy address belongs to the object at ffff8881131e1000
>  which belongs to the cache kmalloc-cg-2k of size 2048
> The buggy address is located 1168 bytes inside of
>  freed 2048-byte region [ffff8881131e1000, ffff8881131e1800)
> 
> The buggy address belongs to the physical page:
> page_owner tracks the page as allocated
> page last free pid 9778 tgid 9778 stack trace:
> 
> Memory state around the buggy address:
>  ffff8881131e1380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff8881131e1400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >ffff8881131e1480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                          ^
>  ffff8881131e1500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff8881131e1580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ==================================================================
> [1]: https://gist.github.com/mrpre/f683f244544f7b11e7fa87df9e6c2eeb
> [2]: https://lore.kernel.org/linux-serial/20260204074327.226165-1-jiayuan.chen@linux.dev/T/#u
> 
> Reported-by: syzbot+827272712bd6d12c79a4@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/000000000000a4a7550611e234f5@google.com/T/
> Fixes: 9b27105b4a44 ("net-caif-driver: add CAIF serial driver (ldisc)")
> Signed-off-by: Jiayuan Chen <jiayuan.chen@shopee.com>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  drivers/net/caif/caif_serial.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/caif/caif_serial.c b/drivers/net/caif/caif_serial.c
> index c398ac42eae9..b90890030751 100644
> --- a/drivers/net/caif/caif_serial.c
> +++ b/drivers/net/caif/caif_serial.c
> @@ -284,6 +284,7 @@ static void ser_release(struct work_struct *work)
>  {
>  	struct list_head list;
>  	struct ser_device *ser, *tmp;
> +	struct tty_struct *tty;
>  
>  	spin_lock(&ser_lock);
>  	list_replace_init(&ser_release_list, &list);
> @@ -292,9 +293,11 @@ static void ser_release(struct work_struct *work)
>  	if (!list_empty(&list)) {
>  		rtnl_lock();
>  		list_for_each_entry_safe(ser, tmp, &list, node) {
> +			tty = ser->tty;
>  			dev_close(ser->dev);
>  			unregister_netdevice(ser->dev);
>  			debugfs_deinit(ser);
> +			tty_kref_put(tty);
>  		}
>  		rtnl_unlock();
>  	}
> @@ -355,8 +358,6 @@ static void ldisc_close(struct tty_struct *tty)
>  {
>  	struct ser_device *ser = tty->disc_data;
>  
> -	tty_kref_put(ser->tty);
> -

Good catch!

While I don't have this hardware to test, this looks sane to me.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

