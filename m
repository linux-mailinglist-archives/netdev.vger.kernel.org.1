Return-Path: <netdev+bounces-275333-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EB+QBIbS0Gm3AwcAu9opvQ
	(envelope-from <netdev+bounces-275333-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 10:57:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC7F39A7D0
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 10:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D84D0300608E
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 08:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C1A30F819;
	Sat,  4 Apr 2026 08:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UyAcNIOU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AF12DB79C;
	Sat,  4 Apr 2026 08:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775293046; cv=none; b=pqVFJDt3FXSPwxF+6NYl1lLZggihbuuBBupWMIisvVy0f7/+bMP1mSYgD2zGJSIAL+WO3Y+cbVHdW4RJ8UP9YkOm7Qxsoo2AW1vgW0+MQKx3M3RoT7DDpnG8UluwAnRSzOZ+5sONpv9ySEeTvf+YwcUGyfwiXSphypN7ESYh1Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775293046; c=relaxed/simple;
	bh=kJyIeyK1oN6o7W5CGnDkKD1WeHBbFvIKSvB1gfGy7Yg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rD0gFAllcnsVIaqWdXXcf60Jm/OS76pIoSCQxT7kyMPNBL8cUC5RAmzFVsXTysYOL2HD2c3opgvr6ZsUvBX7ESbKs7xLHGfV0DYYOuRan3k6A/QhwwRvQB/Fqa/CketmCtxg9fealqq2U3r7dQMiotJuqIsKJantN2ptXgWulVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UyAcNIOU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B657C19421;
	Sat,  4 Apr 2026 08:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775293046;
	bh=kJyIeyK1oN6o7W5CGnDkKD1WeHBbFvIKSvB1gfGy7Yg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UyAcNIOUkgseqxnEckpH8Op17MX9t1XeNFiElAfONv09eAiVukKB8AWofftefnHMT
	 hjP0izs4XgC5aZ+W8LgRMklfbuseNYb13K3JEj3LFOuWh28t4sKMaa0/Q8+bnBgHvW
	 nh21r0HTEqI0IPP505nheheHSGO7ADzNI5TmE5GFOhlOZw5wxoZdc/vPP/iPgAJ2e+
	 GifNjM6+n6K9vyk+h+1c8eQxtx5+FMq1Htw0NJ/rh8EXy9JSvyvzGz7vhfFfDTtmLm
	 XPn5FZkYB0O/zFTtaprAogDunO4LeFLuiQ1N/Pc5nHt1apTRTyH9gokrZzBdmD9a5z
	 MDSyZ+DKBW6cw==
From: Simon Horman <horms@kernel.org>
To: mashiro.chen@mailbox.org
Cc: Simon Horman <horms@kernel.org>,
	syzbot+ecdb8c9878a81eb21e54@syzkaller.appspotmail.com,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	ajk@comnets.uni-bremen.de,
	davem@davemloft.net,
	linux-hams@vger.kernel.org,
	andrew+netdev@lunn.ch
Subject: Re: [PATCH net] net: hamradio: 6pack: fix uninit-value in sixpack_receive_buf
Date: Sat,  4 Apr 2026 09:57:11 +0100
Message-ID: <20260404085711.225665-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402164525.134244-1-mashiro.chen@mailbox.org>
References: <20260402164525.134244-1-mashiro.chen@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-275333-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,ecdb8c9878a81eb21e54];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0DC7F39A7D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: hamradio: 6pack: fix uninit-value in sixpack_receive_buf

This commit fixes sixpack_receive_buf() to properly skip bytes with TTY
error flags by processing bytes one at a time and only passing non-error
bytes to sixpack_decode(). This matches the pattern used in slip_receive_buf()
and mkiss_receive_buf().

Closes: https://syzkaller.appspot.com/bug?extid=ecdb8c9878a81eb21e54

> diff --git a/drivers/net/hamradio/6pack.c b/drivers/net/hamradio/6pack.c
> --- a/drivers/net/hamradio/6pack.c
> +++ b/drivers/net/hamradio/6pack.c
> @@ -391,7 +391,6 @@ static void sixpack_receive_buf(struct tty_struct *tty, const u8 *cp,
>  				const u8 *fp, size_t count)
>  {
>  	struct sixpack *sp;
> -	size_t count1;
>
>  	if (!count)
>  		return;
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

The commit title states this fixes "uninit-value in sixpack_receive_buf", but
is this the exact cause of the KMSAN report?

The syzbot report confirms KMSAN detected uninit-value in sixpack_decode when
reading pre_rbuff[count1]. The uninit memory originated from tty_buffer_alloc
via kmalloc_flex (GFP_ATOMIC | __GFP_NOWARN, not zeroed).

However, bytes in the tty buffer should be initialized after being written by
serial8250_read_char -> uart_insert_char -> tty_insert_flip_char, which writes
both the character (from inb() I/O port read) and the flag. KMSAN's
__msan_instrument_asm_store() should unpoison inline asm outputs including
inb results.

The code fix addresses a genuine logic error where error-flagged bytes were
not skipped (claims 1-5 are verified true). But the connection between this
bug and the specific KMSAN uninit-value report is unclear, since the tty
bytes should be initialized after UART driver processing.

Could the KMSAN trigger involve subtle shadow tracking through tty buffer
allocation and inline asm instrumentation rather than the described code bug?
The syzbot report notes "Unfortunately, I don't have any reproducer for this
issue yet," which makes verification difficult.

The fix is correct regardless - it matches the established pattern in
slip_receive_buf() and mkiss_receive_buf() for handling error-flagged bytes.
Should the commit title more accurately describe what the fix addresses?

