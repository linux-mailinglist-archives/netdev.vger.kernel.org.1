Return-Path: <netdev+bounces-303924-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cTGKLwXWRWq1FwsAu9opvQ
	(envelope-from <netdev+bounces-303924-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 05:07:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 399BC6F32A0
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 05:07:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=L8k4QDoj;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303924-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303924-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9FF3A3046EC8
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 03:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE65930E0EE;
	Thu,  2 Jul 2026 03:06:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDB3305664;
	Thu,  2 Jul 2026 03:06:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782961606; cv=none; b=ud3dVlxB+AtWunrVhrnDR7p5M5QxhtPrRQeVaxC4GhcCKIjQPJm6y3Umu730Q7in8LQ+Ljxz4OR/GMChRCxaStLFL6xTHE0uWkTYp6FuywyHMi4frxbxyxDuPCw1qB4wYrFvj2z4J2mvT+R6KjUS27Wq425UMkTYMRBnEHdIKYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782961606; c=relaxed/simple;
	bh=2m77gO09Rh6LkNCbW3gVNexMJYzr4UQsWjPtXffs2Mg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=naMa45g2Ef8szsYq/jrwadRBDfpbAn7f0ONEaPmyTEYMlrhJ4qSou+8iI1Vi0qYr1jTNlsAkkdTnwNMR6PyBitPBjKynCJIxyPVSuL1wQIREAkV87Ui7gvOL4JSP2aK9oZCEQd9kvWjzutozDGxwbByrv+TK7bhtDEHoRJBi/Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L8k4QDoj; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E0851F000E9;
	Thu,  2 Jul 2026 03:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782961605;
	bh=g4ufrb1H9XwSdoFmaoTbnMnS9Qdl5FV0n+ui0fmlGdM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=L8k4QDoj4iyqBHASzsLr23rMk6msePs0lQkj1ePt37LlQEhDhXW83DZ7uXYn693D1
	 ZTJY8n/GNkLaNvJM/baH+HM13ETIZg8S8LkcJWK1TpZNJt2bJmELMgCd9Mnq6MQ2zD
	 GN3XHc0nK4dDAbSeMOE7n3kUztQFeRf7u/9Q+VTmZPWbUQpG/kp/2+3Mtbzy0ieH7i
	 kCLai+O268P1fJ7Vn3R43adBWLGryJWN2crW3w5GYPJXsLJiavTr1ufR/9G6MzzkC4
	 A2p6+Lz2IY4UOEFwd0UEJWyYjSo2mY/IK/8Jqn0Urz7YCB7MiKpGbGEiMcNvcwzlrF
	 vEWzUIHdZChnw==
Message-ID: <8ac216a4fbdfe35b6cbd2a2e9373495cbc009ee7.camel@kernel.org>
Subject: Re: [PATCH] selftests: mptcp: mptcp_diag: fix stack buffer overflow
 in get_subflow_info()
From: Geliang Tang <geliang@kernel.org>
To: Jiangshan Yi <yijiangshan@kylinos.cn>, martineau@kernel.org, 
	matttbe@kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com,  horms@kernel.org, shuah@kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 13667453960@163.com
Date: Thu, 02 Jul 2026 11:06:35 +0800
In-Reply-To: <20260701103809.4051377-1-yijiangshan@kylinos.cn>
References: <20260701103809.4051377-1-yijiangshan@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303924-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:yijiangshan@kylinos.cn,m:martineau@kernel.org,m:matttbe@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:netdev@vger.kernel.org,m:mptcp@lists.linux.dev,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:13667453960@163.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[geliang@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,lists.linux.dev,163.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geliang@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 399BC6F32A0

Hi Jiangshan,

On Wed, 2026-07-01 at 18:38 +0800, Jiangshan Yi wrote:
> get_subflow_info() parses the subflow address string with:
> 
> 	char saddr[64], daddr[64];
> 
> 	ret = sscanf(subflow_addrs, "%[^:]:%d %[^:]:%d",
> 		     saddr, &sport, daddr, &dport);
> 
> The subflow_addrs buffer holds up to 1024 bytes and is taken directly
> from the command line ("-c" argument). The "%[^:]" conversions have
> no
> maximum field width, so if the address substring before the ':'
> exceeds
> 63 bytes, sscanf() writes past the end of the 64-byte saddr/daddr
> stack
> buffers. This overflows the stack, corrupting adjacent stack data
> such
> as the saved return address, and can crash the tool or lead to
> out-of-bounds writes controlled by user-supplied input.
> 
> Bound both string conversions to the destination buffer size by
> adding
> an explicit maximum field width of 63 (leaving room for the
> terminating
> NUL), so at most 63 bytes are written into each 64-byte buffer:
> 
> 	ret = sscanf(subflow_addrs, "%63[^:]:%d %63[^:]:%d",
> 		     saddr, &sport, daddr, &dport);
> 
> Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
> ---
>  tools/testing/selftests/net/mptcp/mptcp_diag.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/mptcp/mptcp_diag.c
> b/tools/testing/selftests/net/mptcp/mptcp_diag.c
> index 5e222ba977e4..02ac93f794fe 100644
> --- a/tools/testing/selftests/net/mptcp/mptcp_diag.c
> +++ b/tools/testing/selftests/net/mptcp/mptcp_diag.c
> @@ -377,7 +377,7 @@ static void get_subflow_info(char *subflow_addrs)
>  	int ret;
>  	int fd;
>  
> -	ret = sscanf(subflow_addrs, "%[^:]:%d %[^:]:%d", saddr,
> &sport, daddr, &dport);
> +	ret = sscanf(subflow_addrs, "%63[^:]:%d %63[^:]:%d", saddr,
> &sport, daddr, &dport);

Thanks for this patch. MPTCP CI complains:

WARNING: line length of 91 exceeds 80 columns
#44: FILE: tools/testing/selftests/net/mptcp/mptcp_diag.c:380:

Also, for the subject prefix, we usually use "selftests: mptcp: diag:"
instead of "selftests: mptcp: mptcp_diag:". Please consider updating it
if you spin a v2.

Thanks,
-Geliang

>  	if (ret != 4)
>  		die_perror("IP PORT Pairs has style problems!");
>  


