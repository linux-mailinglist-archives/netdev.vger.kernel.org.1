Return-Path: <netdev+bounces-280546-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEwHKEQv6WkFVgIAu9opvQ
	(envelope-from <netdev+bounces-280546-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 22:27:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4100444A95D
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 22:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9821F300DF6A
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 20:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667333750A7;
	Wed, 22 Apr 2026 20:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p9yB3agN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3FB372692
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 20:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776889666; cv=none; b=o00I2Kmmiyurgm6vQNyBlILOPo4+GcQ47w0TQcHES+yZV+OIdQlOaL6plZDd2gStTvxBYZPwhDnLi2ndH71cHjMtigSh6HlOifvuOkPhu+6lm6g6vV+sOR9OQIR5G5dXGAG0JIoEGlR+emaAF393nyDtNHHEg18dmKKI+exvHxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776889666; c=relaxed/simple;
	bh=Z2pD7SzCnfwOR5N0cjRioBufHqwxBlEZjSb7T01ucEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X+b1sfZQNQkBEheyJcX7s/Hf2Mo68BcmoNHeu3o+vYZRNuWXp23nolD2T2jaLRqGI4ZClFZwSPG+Qqf3l1LW2sE2daG1YpFHRiwRvJzc5fyvHxNAFQCnf0TYr2Cy/+UYc+7rnFI8JYbOApTqlRLKQ2LO0tzDMkS7IqsIUtGL4oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p9yB3agN; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488d2079582so69277015e9.2
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 13:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776889663; x=1777494463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ICar/pXdHGmmlf+IZ7pyC9kCaI/pqNFA9o2Llqb73rk=;
        b=p9yB3agN9WcRdyXtijq7/Oz7JBrE2jzsQQ7ymtY43U+ie8uoJw0xTCclXS1OPhK92u
         Z6qdAQ3YH4us6+Iqrqp65vMUP3hNy3Qj+MhzMFvtYRslcElzNBRy+MVK1sTDlbz9Zwl4
         W9MKtci//R/tsvv4fAyrqiN6yzYSDnXkwsT3k0DJWNB7OjtEurP3kVRNyfAKP2FBCwtr
         3EVzbPy0KxjZcWsbZ8f02AuQumTQ83pxmYB2dpNeS2dCmWa0Sn+GbCS3mvTB71c3ApSr
         6QkEkELj9SJrMEjvIlFdXPIm43WbIdGNZFsvlV6CcOxokb965F+thFY+TmdnZmpVTU0r
         bmXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776889663; x=1777494463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ICar/pXdHGmmlf+IZ7pyC9kCaI/pqNFA9o2Llqb73rk=;
        b=oOhvOyYaRPfKM7OBnI9ear4xlHuqHCZaNNdEY7xPNZgfTLuWKaJCKn6FVCwyx5aoJB
         cgJS7XHAnuSekGB0G0nGrBqCFZ9uLCeb1kkYltKHPyrMOBtbkLdBw9lFPFhavuijHbgK
         DdCgRsU2EKCQEGR3YNbg8kryHZqUhpmCENUuuqU6GMoWiFRwBrveGLr5QmYcUacn2zXP
         5mVH5KL3ihwM2fG+jIlfqqRVY7e50M+V39n/gh2VgC1U1vz/P5r5ZZZ2BhhGUb4bZu9I
         o1JSDFYay6Pc57UyK1DYCJxE2IeFZHiLdF0VqGhVRBne/Yrfhb6HydbVcYN4awMSu9/q
         yhRA==
X-Forwarded-Encrypted: i=1; AFNElJ8QLv+LGSxKBob3HJz+vz2fwyqUBCblAu3csBZHvMqBuKuhxnHACaxMSSOAnjG3ng9joifYOZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrG1hgGNl7SN3GiM+NnkYq++ZhD34i2WKLKYJLnhWV6Ih+Mi2x
	AXMoEJA31226dEZSVRX4j9aYIRsl/hTLTbOdhtVZtGPI2LUSO4RWUM/6
X-Gm-Gg: AeBDievHLlA3pKopIMQMM41VZw/LAVsSfk2DlB3VYeQd3RB6mz0oXUvsu77iVcC+mWN
	b0l/7NYcYwUuNaYImoxN2zAg5uqZeb2hNAhE/9R9Dzu45gutADWAuJhJ4y7g1gYJtQ7ipWoSlzw
	sISOFDlSl1NR0mJQvmcq5Vnlr1kjS6pvRaharG9bh2DrWT0aWU6mLnYilW5tmobrf/BDZrjWZ1o
	m3GNi3hLp2vmlPAZzffQEuGi8iEcMs1W8Ju2YxU7c6ODSzDnOnH9yZemZfl1dvpZNsqOrdtJAJQ
	h8oegKRDUcpHEchor6bZzVjFfctIvPLtEqQPbZQk+EBRghUtja139ux06d2N0zyXB4mEAfEQq4A
	zZQwgT6kGdZO31jkbWYav+YP3as71ftsYfCQl+m6Xv7c2AydheedqGG1Y45Ggz9IL+0cvYL+sJs
	swc5yQbqcjGN4m6UMK3GEZMM0QrPKi7e7mGyqylwNuqh2+789Ng/nt/IlqQ3Mry8vuk+VWUzb01
	n8=
X-Received: by 2002:a05:600c:3490:b0:48a:5970:2005 with SMTP id 5b1f17b1804b1-48a597021c6mr75710255e9.2.1776889662899;
        Wed, 22 Apr 2026 13:27:42 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb74c68asm147278435e9.3.2026.04.22.13.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 13:27:42 -0700 (PDT)
Date: Wed, 22 Apr 2026 21:27:41 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com,
 maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net v3 8/8] xsk: don't support AF_XDP on 32-bit
 architectures
Message-ID: <20260422212741.50deeb06@pumpkin>
In-Reply-To: <20260422033650.68457-9-kerneljasonxing@gmail.com>
References: <20260422033650.68457-1-kerneljasonxing@gmail.com>
	<20260422033650.68457-9-kerneljasonxing@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280546-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,vger.kernel.org,tencent.com];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,tencent.com:email]
X-Rspamd-Queue-Id: 4100444A95D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 22 Apr 2026 11:36:50 +0800
Jason Xing <kerneljasonxing@gmail.com> wrote:

> From: Jason Xing <kernelxing@tencent.com>
> 
> In copy mode TX, xsk_skb_destructor_set_addr() stores the 64-bit
> descriptor address into skb_shinfo(skb)->destructor_arg (void *) via a
> uintptr_t cast:
> 
>     skb_shinfo(skb)->destructor_arg = (void *)((uintptr_t)addr | 0x1UL);
> 
> On 32-bit architectures uintptr_t is 32 bits, so the upper 32 bits of
> the descriptor address are silently dropped. In XDP_ZEROCOPY unaligned
> mode the chunk offset is encoded in bits 48-63 of the descriptor
> address (XSK_UNALIGNED_BUF_OFFSET_SHIFT = 48), meaning the offset is
> lost entirely. The completion queue then returns a truncated address to
> userspace, making buffer recycling impossible.

I had a look at how this is used.

I suspect that XSK_UNALIGNED_BUF_OFFSET_SHIFT can just be made smaller.
The 'addr' isn't really a normal address of any kind, it is a really
and offset into an array made up of pages of memory.
The actual address (kernel virtual of dma) is generated by:
	ptr->array[addr >> PAGE_SHIFT] + addr & ~PAGE_MASK
(after removing the unaligned chunk offset from 'addr').

It is actually quite likely that there are enough free high bits
even in 32bit mode.

	David

> 
> Since we hear no one is using AF_XDP on 32-bit arch, we decided to
> strictly stop supporting it at compile time.
> 
> Closes: https://lore.kernel.org/all/20260419045824.D9E5EC2BCAF@smtp.kernel.org/
> Fixes: 0ebc27a4c67d ("xsk: avoid data corruption on cq descriptor number")
> Suggested-by: Stanislav Fomichev <sdf@fomichev.me>
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  net/xdp/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/xdp/Kconfig b/net/xdp/Kconfig
> index 71af2febe72a..819aa5795f50 100644
> --- a/net/xdp/Kconfig
> +++ b/net/xdp/Kconfig
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config XDP_SOCKETS
>  	bool "XDP sockets"
> -	depends on BPF_SYSCALL
> +	depends on BPF_SYSCALL && 64BIT
>  	default n
>  	help
>  	  XDP sockets allows a channel between XDP programs and


