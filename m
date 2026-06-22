Return-Path: <netdev+bounces-301195-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZG9TEHOPOWp7vAcAu9opvQ
	(envelope-from <netdev+bounces-301195-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 21:39:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 656D06B2195
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 21:39:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=uniroma2.it header.s=ed201904 header.b=+lPOqnqy;
	dkim=pass header.d=uniroma2.it header.s=rsa201904 header.b=nQIS70fJ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301195-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301195-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=uniroma2.it;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3364302A2ED
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 19:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06B9349CF1;
	Mon, 22 Jun 2026 19:39:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F4C349B1F;
	Mon, 22 Jun 2026 19:39:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782157165; cv=none; b=LMLSE3yqgidCo14m2N/HGpw5B+7/d+V+opsy2CreZEON4kohiJXuEw25v/rt/WlnEOF1vJ9zQOeTxo5d5hY/3U7JEU18lJkDrBMWzMkkHbY2mR3X667jPExBmbOZvsv6rlEAUcxwEE0xPEZ8Guv+tBThGzyvkLbSqopnfo20Haw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782157165; c=relaxed/simple;
	bh=KXzvtIZAttyKcEUFWqV4fPB6Epwr2+B3Qzu2JEI8KjQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Ae/peinlq398Mhrw4x4z+ELk1NLAXeGIEi7FomdEz8JssB+8fj16J18WbEG6qFe1p+DYlxqEKs1eOrVUdHfVsrMkBAUvyGxaYINjjOFkqm6T4aOCX3O5vIsdqvgNWKRoX5UxCmHTbKZPprSY85Df9mIxTtaHVo7wyHi0LeqgGcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=+lPOqnqy; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=nQIS70fJ; arc=none smtp.client-ip=160.80.4.38
Received: from smtpauth-2019-1.uniroma2.it (smtpauth-2019-1.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 65MJXMAD014072;
	Mon, 22 Jun 2026 21:33:28 +0200
Received: from lubuntu-18.04 (host-87-20-62-86.retail.telecomitalia.it [87.20.62.86])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id AB73F1208DB;
	Mon, 22 Jun 2026 21:33:17 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1782156797; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pr3an2wgYQSi7AarT7nB9dLtZRX7n36XJpJJA0kYbMc=;
	b=+lPOqnqyi6sNTSbMQKHyMI1M0rIsuWQreXimUpWyPbGjoMhnI45ZrYwzzHYbzPhkXfMSmq
	jFEvP5Ualuppa6Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1782156797; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pr3an2wgYQSi7AarT7nB9dLtZRX7n36XJpJJA0kYbMc=;
	b=nQIS70fJfKpaWaRqc7xgLUGfyfUV2CIEP/Ob52JQk6iBGdTLuUKFsy+qdeO/O4wUJ+vkAI
	ojfU0I9PlW0JUceTAQNNc4xsMswPgmMhyWctAuxoZbb/PbDE7xnT5P/uuvII/Gof7v53b5
	k8v+Gok0dqHWKoPO4IqJfkp1w+qGlG1kUP9lv03EalJQ20P9pR1vS3STtIFlfz+9D8Hu8i
	CV+xXNLp+EG3NVE0XUzTWJccWBWyn18V7s9EB4rTFZI5pD6zVeOenRbxHeS8il2b2trh79
	XTPQLUD8d+mCB+ds+Ua5gw2hyack7jcaiShMTcQUeKbwCPa2aRk0RigLPfF4BA==
Date: Mon, 22 Jun 2026 21:33:17 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Cc: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, stefano.salsano@uniroma2.it,
        Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: Re: [PATCH net] seg6: validate SRH length before reading fixed
 fields
Message-Id: <20260622213317.52c8b5a38b88d4ccc3849e22@uniroma2.it>
In-Reply-To: <20260620-f01-17-seg6-srh-len-v1-1-36cbb29c12f1@mails.tsinghua.edu.cn>
References: <20260620-f01-17-seg6-srh-len-v1-1-36cbb29c12f1@mails.tsinghua.edu.cn>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[uniroma2.it,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[uniroma2.it:s=ed201904,uniroma2.it:s=rsa201904];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[uniroma2.it:+];
	TAGGED_FROM(0.00)[bounces-301195-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[andrea.mayer@uniroma2.it,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:gnq25@mails.tsinghua.edu.cn,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stefano.salsano@uniroma2.it,m:andrea.mayer@uniroma2.it,s:lists@lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrea.mayer@uniroma2.it,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tsinghua.edu.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 656D06B2195

On Sat, 20 Jun 2026 23:55:51 +0800
Nuoqi Gui <gnq25@mails.tsinghua.edu.cn> wrote:

Hi Nuoqi,
Thanks for the patch.

> seg6_validate_srh() reads fixed SRH fields such as srh->type and
> srh->hdrlen before checking that the supplied length covers the fixed
> struct ipv6_sr_hdr fields.  Callers that pass a length smaller than
> sizeof(struct ipv6_sr_hdr) therefore expose those reads to memory
> outside the validated range.
>
> The BPF SEG6 encap path (bpf_lwt_push_encap() -> bpf_push_seg6_encap())
> is one such caller: it forwards a BPF program-supplied pointer and
> length straight to seg6_validate_srh() with no minimum-size guard, so a
> 2-byte SEG6 encap header lets the validator read srh->type at offset 2
> beyond the caller-supplied buffer.

Besides the BPF use case, is there a caller that can reach it with
len < sizeof(*srh)? The ones I found all pass at least the fixed header.

>
> Reject lengths shorter than the fixed SRH at the top of
> seg6_validate_srh(), before any field is read.  This fixes the BPF helper
> path and hardens the common validator for any other caller that reaches it
> with a too-short SRH.
>
> Fixes: fe94cc290f53 ("bpf: Add IPv6 Segment Routing helpers")
> Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
> ---
>  net/ipv6/seg6.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/ipv6/seg6.c b/net/ipv6/seg6.c
> index 1c3ad25700c4c..d2cb32a1058af 100644
> --- a/net/ipv6/seg6.c
> +++ b/net/ipv6/seg6.c
> @@ -29,6 +29,9 @@ bool seg6_validate_srh(struct ipv6_sr_hdr *srh, int len, bool reduced)
>       int max_last_entry;
>       int trailing;
>
> +     if (len < (int)sizeof(*srh))
> +             return false;
> +

The (int) cast only changes the result when len < 0, which is not a meaningful
byte length. Plain "len < sizeof(*srh)" would be enough.

>       if (srh->type != IPV6_SRCRT_TYPE_4)
>               return false;
>
>
> ---
> base-commit: 96e7f9122aae0ed000ee321f324b812a447906d9
> change-id: 20260619-f01-17-seg6-srh-len-a85f35427e0b
>
> Best regards,
> --
> Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
>

Regards,
Andrea

