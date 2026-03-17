Return-Path: <netdev+bounces-268562-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPE7LDM3uWnVvQEAu9opvQ
	(envelope-from <netdev+bounces-268562-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 12:12:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5F82A88B6
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 12:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 552DA30731A5
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 11:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29E23AA500;
	Tue, 17 Mar 2026 11:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="Dd7Ijeec";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="ncNau07p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CE235B642
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 11:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773745847; cv=none; b=gjSzz/ncTCZop+13I++bEDZuGlh6/Q2Xq/oEyR6TGKu13v3sPHfXjcCEla3EXvcdDjGNDLPX/RcPjikA7gbRhqS/FtJ5XoV5w69hmjaVwsAa/haxMUZKviYnwTH5K6H/dZBtvoUOOECtpNrpzPMRZkegE6Jmvp9hXlNrQ++uCGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773745847; c=relaxed/simple;
	bh=15pb94WOI6FWMiEO2Z7j7pLfTFvDLwTiDqfEYeMsBuQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=m1VpeCXgfEoc935QogT7KIg/Yukqtg4rlD84mrUYthdu55oiIBGGYGc0p1hjryuqc8vQ/aSf3WDRoPxItmUuDc4ILVIBKjoLMRBSmBsNUvrXknEHVvnH/0O9wkMDdbCk/eQl9Iqv+/Ijg4PX8nGZmIJ5dcibbazAUi2eOzGYwtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=Dd7Ijeec; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=ncNau07p; arc=none smtp.client-ip=160.80.4.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Received: from smtpauth-2019-1.uniroma2.it (smtpauth.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 62HBAIwd024784;
	Tue, 17 Mar 2026 12:10:26 +0100
Received: from lubuntu-18.04 (unknown [160.80.103.126])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id 7C1FE1207BB;
	Tue, 17 Mar 2026 12:10:26 +0100 (CET)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1773745827; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9ZJWhJQloZF459T+VwATwa/K/JueR4qHu0QY4Yl+320=;
	b=Dd7Ijeec3lwT+4s3sSNkqBb0CXMtS0ul8P+//5xgtqjrfKV839y/Nxq8KfVrixgayA+f5u
	3hZdx7bBd5qhAACw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1773745827; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9ZJWhJQloZF459T+VwATwa/K/JueR4qHu0QY4Yl+320=;
	b=ncNau07pC77wgw89tR6nctB28bSne7ABAPeNWsDqTZrv0pkckA2UlRJQkrJd5YUNIEFEcu
	XKZW0Zk4VNUXCfw71xvGd11ioarvRyofwotHgwjYGA+N8jrOAK2zGm3B/guAkDINJmIUXT
	deGLac3nq2sd6NWCGJJZ0z1qXofP3XqIMv/2AIoYdxRVjbqOuyGL+uO4gUk/BJWRLhBnd4
	6aFbMPPirKnodDyj59EKxKqMlE0lJHN/la/EuxL6/i5QCi2AlAdlx0leDPa1ncjgT3oHjO
	/B3YOVQsKlCPnEmXYUfDbI66UDF7ro3RX6PudD4vhqdUfyMmdVBAWNf7Mf5DTQ==
Date: Tue, 17 Mar 2026 12:10:23 +0100
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: Justin Iurman <justin.iurman@6wind.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, stephen@networkplumber.org,
        justin.iurman@gmail.com, nicolas.dichtel@6wind.com,
        stefano.salsano@uniroma2.it, paolo.lungaroni@uniroma2.it,
        ahabdels@cisco.com, Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: Re: [PATCH iproute2-next 1/2] seg6: add tunsrc support in
 iproute_lwtunnel
Message-Id: <20260317121023.5f3035b3b8a51e10c4e0408e@uniroma2.it>
In-Reply-To: <20260316164907.1255510-2-justin.iurman@6wind.com>
References: <20260316164907.1255510-1-justin.iurman@6wind.com>
	<20260316164907.1255510-2-justin.iurman@6wind.com>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[uniroma2.it,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[uniroma2.it:s=ed201904,uniroma2.it:s=rsa201904];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,networkplumber.org,gmail.com,6wind.com,uniroma2.it,cisco.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-268562-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[uniroma2.it:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrea.mayer@uniroma2.it,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[6wind.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,uniroma2.it:dkim,uniroma2.it:mid]
X-Rspamd-Queue-Id: 2F5F82A88B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 16 Mar 2026 17:49:06 +0100
Justin Iurman <justin.iurman@6wind.com> wrote:

> Add support for the new optional "tunsrc" parameter. Now, a tunnel
> source address can be configured per route and has priority over the
> configured per-netns source address (if any).
> 
> Example:
> ip -6 r a 2001:db8:1::/64 encap seg6 mode encap tunsrc 2001:db8:ab::
>     segs 2001:db8:42::1,2001:db8:ffff::2 dev eth0
> 
> Signed-off-by: Justin Iurman <justin.iurman@6wind.com>
> ---
>  ip/iproute_lwtunnel.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/ip/iproute_lwtunnel.c b/ip/iproute_lwtunnel.c
> index a7885dba28c1..00b4f7565be6 100644
> --- a/ip/iproute_lwtunnel.c
> +++ b/ip/iproute_lwtunnel.c
> @@ -266,6 +266,13 @@ static void print_encap_seg6(FILE *fp, struct rtattr *encap)
>  	print_string(PRINT_ANY, "mode",
>  		     "mode %s ", format_seg6mode_type(tuninfo->mode));
>  
> +	if (tb[SEG6_IPTUNNEL_SRC]) {
> +		print_color_string(PRINT_ANY, COLOR_INET6,
> +				   "tunsrc", "tunsrc %s ",
> +				   rt_addr_n2a_rta(AF_INET6,
> +						   tb[SEG6_IPTUNNEL_SRC]));
> +	}
> +
>  	print_srh(fp, tuninfo->srh);
>  }
>  

Hi Justin,

This doesn't build: SEG6_IPTUNNEL_SRC is used in iproute_lwtunnel.c
but the UAPI header sync for include/uapi/linux/seg6_iptunnel.h is
missing from this patch. Please include it.

Thanks,
Andrea

