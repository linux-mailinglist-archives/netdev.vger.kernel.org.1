Return-Path: <netdev+bounces-275332-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LkFFmbS0GlBAwcAu9opvQ
	(envelope-from <netdev+bounces-275332-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 10:57:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id AADB239A7AC
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 10:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D0C133006453
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 08:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4BA3A5459;
	Sat,  4 Apr 2026 08:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c0aJmhKE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084702E6CA8;
	Sat,  4 Apr 2026 08:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775293024; cv=none; b=VU7KXfij8M3LHR71g3tghhTVe+pbGbYA34eXch7fvGqHIwsR3FFE/5RbHd1hkIKnHHBFiFJKTot9gaiOiB1C3mUWb0aNCmvu4/qSguaMWv4+5VbOlFmUPKwUfw87NU3CSEX2NltKYJUJpIK8AsIdpOSlBe0ErcEGpFb+rXcbfUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775293024; c=relaxed/simple;
	bh=zrOG8L1Di6K8R3FaT/IvaAB6s1o1yqHxlWXzZh7Jowc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bXC6fvCZuFtpKQVRac9P7tPeR2hrHDXBRgB2mw9iMOPL8SOPeezoNhhas0xghDVDwTo9xD+tSkY4ym9kL6QvTachP87fsvRG+CSSYknJrmQPctgZiGrghyKM04FqZcASaOT5EQHAEDQEgRbmewHeTkZWVoIpDXWvzEmYbT3zzWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c0aJmhKE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59594C19421;
	Sat,  4 Apr 2026 08:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775293023;
	bh=zrOG8L1Di6K8R3FaT/IvaAB6s1o1yqHxlWXzZh7Jowc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c0aJmhKENLyWzGLOgzrtraR700NOAwAPig1FF/5UNW0fIpo8oZdc2uNfon+TsQmKD
	 ueTBZfWdy2iGj4CgFCCeb67vgOYdJ/kJXSVZlHyXTnLBIybHFEalG8AZayLgqqdF+Q
	 +UqqrVEf55GDG8iFQyyeM1tYm2SYJH81cnhaLpMEZqhPT2N45FClNSUk5cDr10kGbC
	 ye0kb5Kz9rqPjiuKBCUMBqQAm6U/vJXJrNbMT5n3YmvQOi+EUBhC3v3B0BbxwQVwhI
	 5gb1JQgMzPectrItlR0HGqMJe5WtBGKq+mUbKb17EbweUM4Vb/oBS2FOcr/HUX0Ord
	 87EuD2a170sWQ==
Date: Sat, 4 Apr 2026 09:56:58 +0100
From: Simon Horman <horms@kernel.org>
To: Mashiro Chen <mashiro.chen@mailbox.org>
Cc: ajk@comnets.uni-bremen.de, netdev@vger.kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-hams@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+ecdb8c9878a81eb21e54@syzkaller.appspotmail.com
Subject: Re: [PATCH net] net: hamradio: 6pack: fix uninit-value in
 sixpack_receive_buf
Message-ID: <20260404085658.GR113102@horms.kernel.org>
References: <20260402164525.134244-1-mashiro.chen@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402164525.134244-1-mashiro.chen@mailbox.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275332-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev,ecdb8c9878a81eb21e54];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,mailbox.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AADB239A7AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 12:45:25AM +0800, Mashiro Chen wrote:
> sixpack_receive_buf() does not properly skip bytes with TTY error flags.
> The while loop iterates through the flags buffer but never advances the
> data pointer (cp), and passes the original count including error bytes
> to sixpack_decode(). This causes sixpack_decode() to process bytes that
> should have been skipped due to TTY errors.
> 
> Fix this by processing bytes one at a time, advancing cp on each
> iteration, and only passing non-error bytes to sixpack_decode().
> This matches the pattern used by slip_receive_buf() and
> mkiss_receive_buf() for the same purpose.
> 
> Reported-by: syzbot+ecdb8c9878a81eb21e54@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=ecdb8c9878a81eb21e54
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Mashiro Chen <mashiro.chen@mailbox.org>
> ---
>  drivers/net/hamradio/6pack.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/hamradio/6pack.c b/drivers/net/hamradio/6pack.c
> index 885992951e8a6..c8b2dc5c1becc 100644
> --- a/drivers/net/hamradio/6pack.c
> +++ b/drivers/net/hamradio/6pack.c

...

> @@ -401,16 +400,16 @@ static void sixpack_receive_buf(struct tty_struct *tty, const u8 *cp,
>  		return;
>  
>  	/* Read the characters out of the buffer */
> -	count1 = count;
> -	while (count) {
> -		count--;
> +	while (count--) {
>  		if (fp && *fp++) {
>  			if (!test_and_set_bit(SIXPF_ERROR, &sp->flags))
>  				sp->dev->stats.rx_errors++;
> +			cp++;
>  			continue;
>  		}
> +		sixpack_decode(sp, cp, 1);
> +		cp++;
>  	}
> -	sixpack_decode(sp, cp, count1);
>  
>  	tty_unthrottle(tty);
>  }

Hi,

I am wondering if this could be expressed more succinctly by
placing the cp++ in a common branch of execution.

Something like this (completely untested!)

@@ -401,16 +400,15 @@ static void sixpack_receive_buf(struct tty_struct *tty, const u8 *cp,
 		return;
 
 	/* Read the characters out of the buffer */
-	count1 = count;
-	while (count) {
-		count--;
+	while (count--) {
 		if (fp && *fp++) {
 			if (!test_and_set_bit(SIXPF_ERROR, &sp->flags))
 				sp->dev->stats.rx_errors++;
-			continue;
+		} else {
+			sixpack_decode(sp, cp, 1);
 		}
+		cp++;
 	}
-	sixpack_decode(sp, cp, count1);
 
 	tty_unthrottle(tty);
 }

Also, while I don't think it is appropriate to be included in a fix.
As a follow-up sixpack_decode() could be simplified by removing the count
parameter, which is now always passed the value 1.

