Return-Path: <netdev+bounces-259885-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJHhGC0rm2nfuQMAu9opvQ
	(envelope-from <netdev+bounces-259885-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 17:13:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B27D016F995
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 17:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E412300C007
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 16:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E603502B5;
	Sun, 22 Feb 2026 16:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Swzw9aeL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1FD34FF41
	for <netdev@vger.kernel.org>; Sun, 22 Feb 2026 16:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771776810; cv=none; b=qptzKPLxW36h2Dr4qfvrzZ2H4lzVK5+mxbOzPfKhKZoBbdq7XKrTVnqk7P9Bc9vZidCbklFRHpAtISm57CBeY44Fx4azTHEGMTVIyPGAl4KgebtgFaRJhu6C50kM5eB3O+k+8Hznd+juJLTQSzBYfk0dZlveNmTN75B3n5J+HU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771776810; c=relaxed/simple;
	bh=v/6hFuSO8PJHKsZtPakfmI7341eYHwTYsiJnuIJ7aEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D5THQYNnfI95NEC+wPVq1acflDJTZvU44H+foj16mZD6AjOFMw6K46qcoDJNO3cs5dp4Y297rbWF3oxtqZW/FjHNi0c1htxoXEGEure8Q8Dn18m+1P415+xYFu51jsm3cv7IU0Z4MX+vEf1fBqB0dDD3fb9r4IrRS+xpWqSaE5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Swzw9aeL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C78DBC116D0;
	Sun, 22 Feb 2026 16:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771776810;
	bh=v/6hFuSO8PJHKsZtPakfmI7341eYHwTYsiJnuIJ7aEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Swzw9aeL/fPjVDloXgfcmXciuhkPrtRCexdsaTuogDoS5wxaPU7uz6WITTo1OwFdR
	 VVxzjT4xKHGVhcVQ9DmXrNkI3keyvx9QyscXuXhygL45XQoYZeGipx5Wrdwn03JEKT
	 XY415XS3jpwK1CknjC3nKFXTzbKVVTYulBQE/QD2zSMNbtI736IVM8c1K0pLqwKCVD
	 +UxmJycvbqRJd1BJr8xoEydhOPFOndXMrBFLp7fZCjIvV/JxWepdCzZgDaY5l2v7Db
	 0WzEaYbvl3Ttb9c3C9dNJe9QgV9nbDpOLjIrIsuP7x1X5uy1fJezOfxZPtqVg4qR/k
	 26/HL5EDoY7Fw==
Date: Sun, 22 Feb 2026 16:13:19 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, leitao@debian.org
Subject: Re: [PATCH net] netconsole: avoid OOB reads, msg is not
 nul-terminated
Message-ID: <aZsrH23rOB0Z4_fz@horms.kernel.org>
References: <20260219195021.2099699-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219195021.2099699-1-kuba@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259885-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B27D016F995
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 11:50:21AM -0800, Jakub Kicinski wrote:
> msg passed to netconsole from the console subsystem is not guaranteed
> to be nul-terminated. Before recent
> commit 7eab73b18630 ("netconsole: convert to NBCON console infrastructure")
> the message would be placed in printk_shared_pbufs, a static global
> buffer, so KASAN had harder time catching OOB accesses. Now we see:
> 
>     printk: console [netcon_ext0] enabled
>     BUG: KASAN: slab-out-of-bounds in string+0x1f7/0x240
>     Read of size 1 at addr ffff88813b6d4c00 by task pr/netcon_ext0/594
> 
>     CPU: 65 UID: 0 PID: 594 Comm: pr/netcon_ext0 Not tainted 6.19.0-11754-g4246fd6547c9
>     Call Trace:
>      kasan_report+0xe4/0x120
>      string+0x1f7/0x240
>      vsnprintf+0x655/0xba0
>      scnprintf+0xba/0x120
>      netconsole_write+0x3fe/0xa10
>      nbcon_emit_next_record+0x46e/0x860
>      nbcon_kthread_func+0x623/0x750
> 
>     Allocated by task 1:
>      nbcon_alloc+0x1ea/0x450
>      register_console+0x26b/0xe10
>      init_netconsole+0xbb0/0xda0
> 
>     The buggy address belongs to the object at ffff88813b6d4000
>                 which belongs to the cache kmalloc-4k of size 4096
>     The buggy address is located 0 bytes to the right of
>                 allocated 3072-byte region [ffff88813b6d4000, ffff88813b6d4c00)
> 
> Fixes: c62c0a17f9b7 ("netconsole: Append kernel version to message")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


