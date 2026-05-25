Return-Path: <netdev+bounces-291392-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id /vknBfyMFGpcOQcAu9opvQ
	(envelope-from <netdev+bounces-291392-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 19:55:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE675CD792
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 19:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6B4A3011F1A
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 17:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2842F7EF7;
	Mon, 25 May 2026 17:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HdXstT5G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAC432B128;
	Mon, 25 May 2026 17:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779731702; cv=none; b=BzOZM2Xwj6JePFPK6dWzEDZKRIO4u8O9N3esqli2LrQ1NGqhpzvzBlnXPVt9Zu7bFNG82DUTALLRXaSwvhA7Nh6o72yqo/uach/umX4KAxsSKutPf6swzwZl+/Jgzm/MeNOeYGjKwM1BF6sGuCTv3uIB5lAirSB1w0eNpq3Ndjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779731702; c=relaxed/simple;
	bh=dSxlyObc+C0UptMww3e1YvrtNpTonTJ4UTyos4bl4pg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uhUSI8y9iiXjwX8v73WygNiDfuiGoLA3o3T4cJgNs4RV4m1hybc7AIlzftjoeYrPE4AkCsPW/ZgajIgTTwB+BPOrrW26pDpNvadDLEnlFJYTWe/4UpkN0cAixVYp+o0t1ChiTeu/dp20JDn9iBUad1g2ab5tqgSV0L7lyjM4Als=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HdXstT5G; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F6451F000E9;
	Mon, 25 May 2026 17:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779731701;
	bh=i3awmoKb3g0un6o2OqMNnbAwu1xN9Id/3mZAgRhVXds=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HdXstT5G4xedlaNW4Qkr+Imx0xeT8ldZmtqwX2u5G0Lzi7409/tibkTUkY7ziTDLp
	 L9JUpvSeDrsspQkkEp6WV6YiJN9EPFshjYPelaUEOYfLwksAd90qRqfu/CtPK4/TSe
	 Yz+vKpke0m0h8YLfJvbSHLfsoQ6UET2L4LHBge+zHpPJP+ja+eko88aaCIIIIX4Vmm
	 dyyaciNfHXSCNHpiCRC6aTdgvUjTWMdLQoCaGjQV/yZ/Uae4XTQmIatBnHV0k1Vi1d
	 sUhHd++mTFzgk2BRl9JCUSkyxNFms3rl/mPqatXzikhgR2fHY93Elmv703jMRb70W4
	 QV3WaaBc9ojDw==
Date: Mon, 25 May 2026 10:54:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Yeonju Bae <iwasbaeyz@gmail.com>, netdev@vger.kernel.org,
 gregkh@linuxfoundation.org, security@kernel.org, john.fastabend@gmail.com,
 sd@queasysnail.net, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH net] tls: avoid zc receive for file-backed pages
Message-ID: <20260525105459.5ae73c2b@kernel.org>
In-Reply-To: <20260521165328.16112-1-iwasbaeyz@gmail.com>
References: <2026052150-stylus-germicide-780e@gregkh>
	<20260521165328.16112-1-iwasbaeyz@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291392-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,linuxfoundation.org,kernel.org,queasysnail.net,davemloft.net,google.com,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 5BE675CD792
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 22 May 2026 01:53:28 +0900 Yeonju Bae wrote:
> kTLS RX zc decrypt writes unauthenticated AEAD output directly into
> pages pinned from the recvmsg iterator via tls_setup_from_iter().
> For MAP_SHARED, PROT_WRITE file-backed destinations, those pages are
> live page-cache pages rather than anonymous copies: MAP_SHARED does not
> trigger copy-on-write, so FOLL_WRITE returns the actual page-cache page.
> 
> crypto_aead_decrypt() writes CTR-mode decryption output into the
> scatter-gather list before the authentication tag is verified.  If the
> tag check fails (-EBADMSG), the plaintext-like output is already
> resident in the page-cache page.  exit_free_pages() calls put_page()
> without any content cleanup, so the modification persists through the
> backing file.  An independent open(O_RDONLY)/read() of the same file
> returns different content and its SHA-256 changes.  MAP_PRIVATE is safe
> via COW; PROT_READ-only destinations fail at iov_iter_get_pages2()
> before any decryption occurs.
> 
> Avoid zc receive for file-backed destination pages.  In
> tls_setup_from_iter(), after iov_iter_get_pages2() pins pages, check
> each page with folio_mapping(page_folio(page)).  If any pinned page is
> file-backed (mapping != NULL), release the pinned pages and return
> -EOPNOTSUPP.  Handle -EOPNOTSUPP in tls_decrypt_sw() by clearing
> darg->zc and retrying, which causes tls_decrypt_sg() to allocate a
> kernel bounce buffer instead.  Decryption output never reaches the
> file-backed page; on tag failure the bounce buffer is discarded.
> 
> This follows the existing opportunistic zc retry pattern already used
> for TLS 1.3 record type mismatches in tls_decrypt_sw().
> 
> Verified on linux-7.0-rc3 QEMU (x86-64), four destination types:
>   MAP_SHARED+RW:   file_changed=0  (was 4077/4096 bytes before patch)
>   MAP_PRIVATE+RW:  file_changed=0  (COW isolation; unchanged)
>   anonymous heap:  no file backing  (unchanged)
>   PROT_READ only:  file_changed=0  (EFAULT before decrypt; unchanged)

I'm not seeing anything unusual here from high level API use size. 
We feed the iov_iter constructed by recvmsg in socket code into 
iov_iter_get_pages2(). Either:
 - the way we construct the iov_iter is wrong; or
 - iov_iter_get_pages2() should be return an error; or
 - we should use a different iov_* API; or
 - the current behavior you describe is expected / correct.

I don't think that TLS open-coding page checks is the right move.

Al, would you mind glancing over this?
I have no idea what's the expect page cache behavior in this scenario.

> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index a977b0434..c312a83b4 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
> @@ -36,6 +36,7 @@
>   */
>  
>  #include <linux/bug.h>
> +#include <linux/pagemap.h>
>  #include <linux/sched/signal.h>
>  #include <linux/module.h>
>  #include <linux/kernel.h>
> @@ -1443,6 +1444,34 @@ static int tls_setup_from_iter(struct iov_iter *from,
>  
>  		length -= copied;
>  		size += copied;
> +		/* Reject file-backed destination pages.  Writing unauthenticated
> +		 * AEAD output into a page-cache page before tag verification
> +		 * leaves the backing file modified even when recvmsg() returns
> +		 * -EBADMSG.  Return -EOPNOTSUPP so the caller retries via the
> +		 * non-ZC bounce-buffer path.
> +		 */
> +		{
> +			ssize_t remain = copied;
> +			size_t  off    = offset;
> +			int     np = 0, j;
> +
> +			while (remain > 0) {
> +				remain -= min_t(ssize_t, remain,
> +						(ssize_t)(PAGE_SIZE - off));
> +				off = 0;
> +				np++;
> +			}
> +			for (j = 0; j < np; j++) {
> +				if (folio_mapping(page_folio(pages[j]))) {
> +					int k;
> +
> +					for (k = 0; k < np; k++)
> +						put_page(pages[k]);
> +					rc = -EOPNOTSUPP;
> +					goto out;
> +				}
> +			}
> +		}
>  		while (copied) {
>  			use = min_t(int, copied, PAGE_SIZE - offset);
>  
> @@ -1699,6 +1728,14 @@ tls_decrypt_sw(struct sock *sk, struct tls_context *tls_ctx,
>  	if (err < 0) {
>  		if (err == -EBADMSG)
>  			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSDECRYPTERROR);
> +		if (err == -EOPNOTSUPP && darg->zc) {
> +			/* tls_setup_from_iter detected file-backed destination
> +			 * pages; retry without ZC via the bounce-buffer path.
> +			 */
> +			darg->zc = false;
> +			TLS_INC_STATS(sock_net(sk), LINUX_MIB_TLSDECRYPTRETRY);
> +			return tls_decrypt_sw(sk, tls_ctx, msg, darg);
> +		}
>  		return err;
>  	}
>  	/* keep going even for ->async, the code below is TLS 1.3 */


