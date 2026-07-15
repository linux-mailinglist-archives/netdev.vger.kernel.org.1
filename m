Return-Path: <netdev+bounces-307717-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RkGmKhtSV2r2JAEAu9opvQ
	(envelope-from <netdev+bounces-307717-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 11:25:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D94B75C742
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 11:25:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=uniroma2.it header.s=ed201904 header.b=dMaDKKWr;
	dkim=pass header.d=uniroma2.it header.s=rsa201904 header.b=xbfU6vi2;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307717-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307717-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=uniroma2.it;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 588EB30F66E6
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 09:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D444B41CB23;
	Wed, 15 Jul 2026 09:16:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88753F0743;
	Wed, 15 Jul 2026 09:16:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784106991; cv=none; b=uxqmABbwp3bsCgBoeu8g2q9uzuTEYgdU5Dps+DuO0fKg9wwGAXWor0BSzjIAAO45c/kcWlquWkbXu1F49LQeBFPDO9nWkpPNyisEgdMRsSSnNX79SVnjzEF7XVmfPdAYI+BMCKSUd1yqSpjga2nFyDrN4qazC9rM3QE8nJ2baEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784106991; c=relaxed/simple;
	bh=it0O+ZF2QyzbqdhO80kfLC0oTrX0i9Ft1KXBQyLlJ0U=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=VhZV37q9zjlB8lZcOhN6tuRfrYcCngvI44H+MuxJVhoIyJUnUPDHZa47bDXUpKZICEJcJOAXM5O1iUPm0C6iWm+IXWUZFrtujLq+gWe1rOqOzdRvut6TasNwsHgJ7Na2cmZtaofeekRb5twdzGsdyzjKaALyU0lvrTwgmgX4ays=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=dMaDKKWr; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=xbfU6vi2; arc=none smtp.client-ip=160.80.4.37
Received: from smtpauth-2019-1.uniroma2.it (smtpauth.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 66F9FhS5019396;
	Wed, 15 Jul 2026 11:15:48 +0200
Received: from lubuntu-18.04 (unknown [193.205.142.15])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id 7E461121DD4;
	Wed, 15 Jul 2026 11:15:38 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1784106938; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bKaYzjAFT65TNNuzhNUDk0YMB60ddOLXXUlPIbwHf74=;
	b=dMaDKKWrCc1wSAoVOH6ehHOnV4SYminjJHLBER49iUO8q/QbHrn8Czvju4zmc8uxpj8PEe
	8jjPv6S+6ZCsATCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1784106938; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bKaYzjAFT65TNNuzhNUDk0YMB60ddOLXXUlPIbwHf74=;
	b=xbfU6vi23nhtei0F29Dte9Bz5wJWCeb20FgUXKCPAAHBp5hMuUZLL4Oy2C3+/Vsvqqk/xV
	uLm+XfqWnDrbP09I+l1t3Sk+WsWowr+Xw6e1GpfNhEqrWUf/guNOl9n58H/LJaWC5A1AaW
	HVfqR1DP2Lj/4HKJPN7YeJhvOVGXdruW2i7Y0Vb5ke9LlYMpINeUJzpqPsufcRI5h0j6n3
	tP0WeQl0Y7OxR9zGzhBRaoEyS+j7tHsa+qsYo1bTaqpOmG6cHh4HvhRz9qt3R3971CvEcj
	OPjMKB4ycy/J3LGUzcRdvj08gdqSxAfpLVmUYukMEu1tjzgPozE7jAuRrylijw==
Date: Wed, 15 Jul 2026 11:15:30 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: Alessio Faina <alessio.faina@canonical.com>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Po-Hsu Lin
 <po-hsu.lin@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Shuah Khan
 <shuah@kernel.org>,
        Andrea Mayer <andrea.mayer@uniroma2.it>, stefano.salsano@uniroma2.it
Subject: Re: [PATCH net-next v2] selftests/net: Skip
 srv6_end_dt46_l3vpn_test::host_vpn_tests if iproute2 too old
Message-Id: <20260715111530.fc982bdd10eb499cef8e9196@uniroma2.it>
In-Reply-To: <20260713095750.2671173-1-alessio.faina@canonical.com>
References: <20260713095750.2671173-1-alessio.faina@canonical.com>
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
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[uniroma2.it,none];
	R_DKIM_ALLOW(-0.20)[uniroma2.it:s=ed201904,uniroma2.it:s=rsa201904];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307717-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:alessio.faina@canonical.com,m:netdev@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:po-hsu.lin@canonical.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:andrea.mayer@uniroma2.it,m:stefano.salsano@uniroma2.it,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[andrea.mayer@uniroma2.it,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[uniroma2.it:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrea.mayer@uniroma2.it,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	REDIRECTOR_URL(0.00)[urldefense.com];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,uniroma2.it:from_mime,uniroma2.it:dkim,uniroma2.it:mid,canonical.com:email,srv6_end_dt46_l3vpn_test.sh:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0D94B75C742

On Mon, 13 Jul 2026 11:57:50 +0200
Alessio Faina <alessio.faina@canonical.com> wrote:

> In case iproute2 is older than version 5.14.0, released ~Sept 1, 2021,
> the End.DT46 support is not available and the host_vpn_tests test contained
> in the srv6_end_dt46_l3vpn_test.sh file is failing in some kernel backports.
> This is the result of those tests:
> 
> ################################################################################
> TEST SECTION: SRv6 VPN connectivity test among hosts in the same tenant
> ################################################################################
> 
>     TEST: IPv6 Hosts connectivity: hs-t100-1 -> hs-t100-2 (tenant 100)  [ FAIL ]
> 
>     TEST: IPv4 Hosts connectivity: hs-t100-1 -> hs-t100-2 (tenant 100)  [ FAIL ]
> 
>     TEST: IPv6 Hosts connectivity: hs-t100-2 -> hs-t100-1 (tenant 100)  [ FAIL ]
> 
>     TEST: IPv4 Hosts connectivity: hs-t100-2 -> hs-t100-1 (tenant 100)  [ FAIL ]
> 
>     TEST: IPv6 Hosts connectivity: hs-t200-3 -> hs-t200-4 (tenant 200)  [ FAIL ]
> 
>     TEST: IPv4 Hosts connectivity: hs-t200-3 -> hs-t200-4 (tenant 200)  [ FAIL ]
> 
>     TEST: IPv6 Hosts connectivity: hs-t200-4 -> hs-t200-3 (tenant 200)  [ FAIL ]
> 
>     TEST: IPv4 Hosts connectivity: hs-t200-4 -> hs-t200-3 (tenant 200)  [ FAIL ]
> 
> To amend this, check the current running iproute2 supports the required
> feature and, if not, just skip the test to avoid a failure.
> 
> 
> Signed-off-by: Alessio Faina <alessio.faina@canonical.com>


Hi Alessio,

Thanks for the v2, the code looks good to me.

One question: since the check now exits the entire script before setup(),
should the subject drop the "::host_vpn_tests" part?

just a nit: test_iproute2_supp_or_ksft_skip() uses spaces, but most of this
file uses tabs.

Ciao
Andrea

> ---
> v2: 
> 	- skip entire test suite if iproute2 is too old
> v1: https://urldefense.com/v3/__https://lore.kernel.org/netdev/20260708152745.2430714-1-alessio.faina@canonical.com/__;!!O5Bi4QcV!CGb1HmTUSZ4JwCff0mVcoY_KnoHJmrGDAdGnPOEYWRVFi-J05H-ZtpLVZBNK12kwLaNmhzw7mrQw4M_eY5uuSft8PRuFHqU$ 
> 
>  .../testing/selftests/net/srv6_end_dt46_l3vpn_test.sh  | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/srv6_end_dt46_l3vpn_test.sh b/tools/testing/selftests/net/srv6_end_dt46_l3vpn_test.sh
> index a5e959a080bb..cd7ac03e3907 100755
> --- a/tools/testing/selftests/net/srv6_end_dt46_l3vpn_test.sh
> +++ b/tools/testing/selftests/net/srv6_end_dt46_l3vpn_test.sh
> @@ -536,6 +536,14 @@ host_vpn_isolation_tests()
>  	done
>  }
>  
> +test_iproute2_supp_or_ksft_skip()
> +{
> +        if ! ip route add help 2>&1 | grep -qo "End.DT46"; then
> +                echo "SKIP: Missing SRv6 End.DT46 support in iproute2"
> +                exit "${ksft_skip}"
> +        fi
> +}
> +
>  if [ "$(id -u)" -ne 0 ];then
>  	echo "SKIP: Need root privileges"
>  	exit $ksft_skip
> @@ -546,6 +554,8 @@ if [ ! -x "$(command -v ip)" ]; then
>  	exit $ksft_skip
>  fi
>  
> +test_iproute2_supp_or_ksft_skip
> +
>  modprobe vrf &>/dev/null
>  if [ ! -e /proc/sys/net/vrf/strict_mode ]; then
>          echo "SKIP: vrf sysctl does not exist"
> -- 
> 2.43.0
> 

