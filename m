Return-Path: <netdev+bounces-280042-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFdFGog452no5QEAu9opvQ
	(envelope-from <netdev+bounces-280042-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 10:42:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DE73F4384F7
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 10:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1318C300A4E9
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 08:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5AA39E6E4;
	Tue, 21 Apr 2026 08:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUAmSEIM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690733876D5
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 08:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776760922; cv=none; b=CukPijasKnbZRuDnwIr9z7bX20Ezvdzd4Dnf13Ldk66IjJqYqUwsLk0u7Ym+K8tpPOJYcLMeaMcKDSjor83L8P7uztEMsNjlpR7SH0GddYMGrfajBAPpXmmn1ambTjJDg6TcKVGjWfNLSiBACXF3baqQw/4Hzr+3cNY4/NIINys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776760922; c=relaxed/simple;
	bh=jZ5lz8/uZRKsTXv/mUPmQRlRmDWApz84x/Zjh1FsXio=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qx0jFkyoqZdIooeYoxldSmG8T/eEuW9b5ZHGFUvmHruUgHNIJMK4sSXpXt4W7Hje5pOkXiDzhq1CS3cxJsQT3QNpC9jniYaExq8BQvZeqAxydsczOdtlchdlAOfuMxSDRgMqReTWkQH0QDLKQCiLIrKT56q0KswoJmUPThSM8Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WUAmSEIM; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4891d7164ddso11968205e9.3
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 01:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776760920; x=1777365720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UBMY1466HCKMAYG0Hg/+wwmeaNUqKqMxSIOQdf9oTsE=;
        b=WUAmSEIMnHHf+XiS90mxtYEvSVn7Tuo28VFojt2yugqIZrnwi7Sl2Rxx+sAFSq9IoP
         PyhfrCvmwP+M9Yn4u0AR6UYsxXvx4aHWQAHDV4crqz/K1ELei7L0UjGQYRS5wRBArDhn
         Wsm+W6U+5Eo3h3PXVaNp1YUA1A05LPYZO4frTEfD1Mdi6ZZMeiPdTzeQCYS+HjvuY4UL
         pgXcFUx/bkLimscyq4bMJLC0yWfsnmlMQgbknHWbpD2NjbaRmjdScZOTACBbZc00yari
         r9SPXYB24zSypGbJlqhvcIEpp+lW841w0MtxFQCIz/1IKoqzuKDLMxBe+BlpZMVpWBM+
         NX0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776760920; x=1777365720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UBMY1466HCKMAYG0Hg/+wwmeaNUqKqMxSIOQdf9oTsE=;
        b=gQuAhSx57cE8t/Fui7+rAT97aSw93bBESVET2LtwYYjFgshd8G4kqKk2iSthk7bI59
         YKBwg4/rMkPnXkJf+dTC6UgXdaXD1BXVeLfAsJPmUv8CGMmv6l0dCBIc7b99NFyC+owA
         OHOhWLO3pXORiyTsupykmYHXgmZOjx1q56qXAWuqVka9CnzS8THQbUFUVyG8dlYxkyqZ
         Ia+wGWko4qrEWC4Bd0pPtOWC7mzdbrpl9Kg3Gc14NCWdkHbNXmEqCqPM2C9d+DLD4Os3
         3cOgPPGDWBBtZkQjdRXvPV7HYaDVaB5Z8QcuZtdCIYHqBRX0GUzr6sx7gZiRahtC0/e6
         L9OQ==
X-Gm-Message-State: AOJu0YyqOj08BDIyH6wm4nccz7GASPCZPO1seP4Z4aQ3oVCh3cGxMOU+
	HzLZDhlY6gbsbxN29AST/kfz4dqDRN5Y83kf/9sxPPhRmqRin5qPNMw5
X-Gm-Gg: AeBDievSwzvzyrjZaku0lQn/UlR+YRoanKqBr6rkPxHrFeZi9MW0tKrgcJ+moIYRpDJ
	5okrkBNQ/2fLWExalKp2/PnIxvwKiBvJaqPwKM8gEms3217OMRqHAP6CBopuwTWowAGYMPewY03
	ufdpjVH0aw4wjfU0/jiYJvHm3NY16lXWh5WkDB5nMTejq5HUtgU1T6fRX2xwQTjaVBHzZdfCUl5
	+AnY8mETMsMwpSZAJP4MoIXS9KgESP6Qe8BapjXE/Yrg4fHyTxFT+B4J/KtIoXKPCdV1NFYG1L2
	IjVJJE0bt/RpCBvKNkjmpcjPrTX5OQqNqbkhCTvAGhIn8sOlu43kyotF1UvxsSaGNn0Uop8sw6Q
	9QdTvQWeyThp+qrmCBqF8W8YydP9F6+cRah4IwYnRoB0vvaygL5WKguNnNEIt/ok/MCGszsCBts
	aKds2PNXB8QZGCwGxakza1L2SfclRaoPtR8kPMGV2W2UKzAnRvIRC0edKASF/DCbgw3t6u3cNFO
	d4=
X-Received: by 2002:a05:600c:c0c8:b0:471:700:f281 with SMTP id 5b1f17b1804b1-488fb78b8c5mr189038665e9.25.1776760919528;
        Tue, 21 Apr 2026 01:41:59 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc0f8188sm372071945e9.2.2026.04.21.01.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 01:41:59 -0700 (PDT)
Date: Tue, 21 Apr 2026 09:41:56 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Ashutosh Desai <ashutoshdesai993@gmail.com>
Cc: netdev@vger.kernel.org, linux-hams@vger.kernel.org, jreuter@yaina.de,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v5 net] ax25: fix OOB read after address header strip in
 ax25_rcv()
Message-ID: <20260421094156.0fb3499a@pumpkin>
In-Reply-To: <20260421054626.732399-1-ashutoshdesai993@gmail.com>
References: <20260417065407.206499-1-ashutoshdesai993@gmail.com>
	<20260421054626.732399-1-ashutoshdesai993@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280042-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: DE73F4384F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 21 Apr 2026 05:46:26 +0000
Ashutosh Desai <ashutoshdesai993@gmail.com> wrote:

> A crafted AX.25 frame with a valid address header but no control byte
> causes skb->len to reach zero after skb_pull() strips the header.
> The subsequent reads of skb->data[0] (control) and skb->data[1] (PID)
> are then out of bounds.
> 
> Linearize the skb after confirming the device is an AX.25 interface.
> Guard with skb->len < 1 after the pull - one byte suffices for LAPB
> control frames which have no PID byte. Add a separate skb->len < 2
> check inside the UI branch before accessing the PID byte.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ashutosh Desai <ashutoshdesai993@gmail.com>
> ---
> v5:
> - Move skb_linearize() to after ax25_dev_ax25dev() check; avoids
>   unnecessary allocation for frames on non-AX.25 interfaces

Nitpick: 'on interfaces where AX.25 isn't enabled'
They still have to be AX.25 frames and get discarded.
So they won't really be expected and any allocated memory is
immediately freed.
More relevant would be linearizing before the ax25_addr_parse() call.
In any case I suspect this code never sees non-linear packets.
The packets will all be short, I don't know ax25, but X.25 (which I've
implemented most of in the past) originally had an mtu of 128 bytes
(and real links running at 2400 baud).

	David


> - Lower general guard from skb->len < 2 to skb->len < 1; the stricter
>   limit incorrectly dropped valid 1-byte LAPB control frames (SABM,
>   DISC, UA, DM, RR) which carry no PID byte
> - Add explicit skb->len < 2 check inside UI branch before the PID
>   byte (skb->data[1]) access
> v4:
> - Linearize skb at entry to ax25_rcv(); replace pskb_may_pull() with
>   skb->len < 2 check (per David Laight review)
> v3:
> - Remove incorrect Suggested-by; add Fixes:, Cc: stable@
> v2:
> - Replace skb->len check with pskb_may_pull(skb, 2)
> 
> Link to v4: https://lore.kernel.org/netdev/20260417065407.206499-1-ashutoshdesai993@gmail.com/
> Link to v3: https://lore.kernel.org/netdev/20260415063654.3831353-1-ashutoshdesai993@gmail.com/
> Link to v2: https://lore.kernel.org/netdev/20260409152400.2219716-1-ashutoshdesai993@gmail.com/
> Link to v1: https://lore.kernel.org/netdev/20260409012235.2049389-1-ashutoshdesai993@gmail.com/
> 
>  net/ax25/ax25_in.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/net/ax25/ax25_in.c b/net/ax25/ax25_in.c
> index d75b3e9ed93d..c81d6830af48 100644
> --- a/net/ax25/ax25_in.c
> +++ b/net/ax25/ax25_in.c
> @@ -199,6 +199,9 @@ static int ax25_rcv(struct sk_buff *skb, struct net_device *dev,
>  	if ((ax25_dev = ax25_dev_ax25dev(dev)) == NULL)
>  		goto free;
>  
> +	if (skb_linearize(skb))
> +		goto free;
> +
>  	/*
>  	 *	Parse the address header.
>  	 */
> @@ -217,6 +220,9 @@ static int ax25_rcv(struct sk_buff *skb, struct net_device *dev,
>  	 */
>  	skb_pull(skb, ax25_addr_size(&dp));
>  
> +	if (skb->len < 1)
> +		goto free;
> +
>  	/* For our port addresses ? */
>  	if (ax25cmp(&dest, dev_addr) == 0 && dp.lastrepeat + 1 == dp.ndigi)
>  		mine = 1;
> @@ -227,6 +233,9 @@ static int ax25_rcv(struct sk_buff *skb, struct net_device *dev,
>  
>  	/* UI frame - bypass LAPB processing */
>  	if ((*skb->data & ~0x10) == AX25_UI && dp.lastrepeat + 1 == dp.ndigi) {
> +		if (skb->len < 2)
> +			goto free;
> +
>  		skb_set_transport_header(skb, 2); /* skip control and pid */
>  
>  		ax25_send_to_raw(&dest, skb, skb->data[1]);


