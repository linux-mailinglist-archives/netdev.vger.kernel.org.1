Return-Path: <netdev+bounces-258165-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8Mm1K5DAi2m1aQAAu9opvQ
	(envelope-from <netdev+bounces-258165-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 00:34:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A60B1200AF
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 00:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A4C083051FFC
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 23:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6970C330B2B;
	Tue, 10 Feb 2026 23:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W+kIDCET"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FA63164DF;
	Tue, 10 Feb 2026 23:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770766475; cv=none; b=LyuSNGlk88LhqEEONOOJfUlOqw94iRbcLaL7pHon6z00KWpuAU1Gk+53XWozQuLCnxJh7w1CzSp6P/VI0JVREdmlw4Gev7gtNfVSoMhvdx9d09Qy6fbaLcEOBa4KpEx1icGmUJfkOABXhg/14fuKJIyWp8ET/nJFcXS2Z0zpxMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770766475; c=relaxed/simple;
	bh=WL3AiKr6GV94bmAe/MsgjLprAEoI+6+DxMhvOsSny0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LyfNjN1eFj4xmds8aU9a8q70MpDZwvoXJ1oQeg/oJcyn5tfQH9vNZTQUOPMCz7pVxhUtWjrZdusZCodHJcCG2sKm2gyoO3jIf4HVh4L6oURN9arTj6NbupXvPvjxeLYNcuyDTP7BB24q+khwIaQ8pWoklKF0BUp5mtxtBY2nzMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W+kIDCET; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EF38C116C6;
	Tue, 10 Feb 2026 23:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770766475;
	bh=WL3AiKr6GV94bmAe/MsgjLprAEoI+6+DxMhvOsSny0Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W+kIDCETdcR57Gdq6oPgbCzQ/OZIL8IPm8cCz3+4fVw8eB1YwvVfwxr7s9VxqUoKn
	 lfgGjCJRU8NX/mpI6MOPYW4tBTosqEvUnJsTZbVDmUurrT2pLXQIaN7qE2eQ5enEaJ
	 +YoqDve7sdI3tFC5+6UVIWWcZ+ILo7OC1Hr7C0OwY4WluZBZB+FWQtHZojL+QwqqyW
	 fh88zr70rv/R6LZrV0wLyr9XPFgBCz8DV1b/6Y1Y/Y+TVI5fnpNUxLPex8G6wzEZ80
	 XoXgnYzckOqsiY0UhBorg6Yreuw1SPIR/xKNvDJCccmo/3Bvj1CWg8KqerocSulZIi
	 E9ODU0hNcjMEA==
Date: Tue, 10 Feb 2026 15:34:33 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Aleksei Oladko <aleksey.oladko@virtuozzo.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, Petr Machata
 <petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, Amit Cohen
 <amcohen@nvidia.com>, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] selftests: forwarding: fix pedit tests failure with
 br_netfilter enabled
Message-ID: <20260210153433.0b282662@kernel.org>
In-Reply-To: <20260210185129.480015-4-aleksey.oladko@virtuozzo.com>
References: <20260210185129.480015-1-aleksey.oladko@virtuozzo.com>
	<20260210185129.480015-4-aleksey.oladko@virtuozzo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258165-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 2A60B1200AF
X-Rspamd-Action: no action

On Tue, 10 Feb 2026 18:51:29 +0000 Aleksei Oladko wrote:
> The tests use the tc pedit action to modify the IPv4 source address
> ("pedit ex munge ip src set"), but the IP header checksum is not
> recalculated after the modification. As a result, the modified packet
> fails sanity checks in br_netfilter after bridging and is dropped,
> which causes the test to fail.
>=20
> Fix this by adding an explicit checksum recalculation using the
> "csum ip" action, so the modified packet contains a valid IPv4
> checksum.
>=20
> Note on IPv6:
>   The tests in pedit_ip.sh also cover IPv6 (test_ip6_src, test_ip6_dst).
>   The csum ip action is harmless for IPv6 packets since IPv6 has no
>   header checksum =E2=80=94 it will be a no-op.

I think this makes the test fail for us:

make: Entering directory '/srv/vmksft/testing/wt-3/tools/testing/selftests'
make[1]: Nothing to be done for 'all'.
TAP version 13
1..1
# timeout set to 10800
# selftests: net/forwarding: pedit_ip.sh
# 6.13 [+6.13] TEST: ping                                                  =
        [ OK ]
# 7.09 [+0.97] TEST: ping6                                                 =
        [ OK ]
# 7.12 [+0.02] Error: Failed to load TC action module.
# 7.12 [+0.00] We have an error talking to the kernel
# 8.36 [+1.24] TEST: dev veth1 ingress pedit ip src set 198.51.100.1       =
        [FAIL]
# 8.36 [+0.01] Expected to get 10 packets, but got 0.
# 8.37 [+0.01] Error: Cannot find specified filter chain.
# 8.38 [+0.00] We have an error talking to the kernel
# 8.39 [+0.01] Error: Failed to load TC action module.
# 8.39 [+0.00] We have an error talking to the kernel
# 9.63 [+1.24] TEST: dev veth2 egress pedit ip src set 198.51.100.1        =
        [FAIL]
# 9.63 [+0.01] Expected to get 10 packets, but got 0.
# 9.64 [+0.00] Error: Cannot find specified filter chain.
# 9.64 [+0.00] We have an error talking to the kernel
# 9.65 [+0.01] Error: Failed to load TC action module.
# 9.65 [+0.00] We have an error talking to the kernel
# 10.89 [+1.24] TEST: dev veth1 ingress pedit ip dst set 198.51.100.1      =
         [FAIL]
# 10.89 [+0.00] Expected to get 10 packets, but got 0.
# 10.90 [+0.01] Error: Cannot find specified filter chain.
# 10.91 [+0.00] We have an error talking to the kernel
# 10.91 [+0.01] Error: Failed to load TC action module.
# 10.91 [+0.00] We have an error talking to the kernel
# 12.14 [+1.23] TEST: dev veth2 egress pedit ip dst set 198.51.100.1       =
         [FAIL]
# 12.15 [+0.01] Expected to get 10 packets, but got 0.
# 12.15 [+0.00] Error: Cannot find specified filter chain.
# 12.16 [+0.00] We have an error talking to the kernel
# 12.17 [+0.01] Error: Failed to load TC action module.
# 12.17 [+0.00] We have an error talking to the kernel
# 13.42 [+1.24] TEST: dev veth1 ingress pedit ip6 src set 2001:db8:2::1    =
         [FAIL]
# 13.42 [+0.00] Expected to get 10 packets, but got 0.
# 13.43 [+0.01] Error: Cannot find specified filter chain.
# 13.43 [+0.00] We have an error talking to the kernel
# 13.45 [+0.01] Error: Failed to load TC action module.
# 13.45 [+0.00] We have an error talking to the kernel
# 14.69 [+1.24] TEST: dev veth2 egress pedit ip6 src set 2001:db8:2::1     =
         [FAIL]
# 14.69 [+0.00] Expected to get 10 packets, but got 0.
# 14.70 [+0.00] Error: Cannot find specified filter chain.
# 14.70 [+0.00] We have an error talking to the kernel
# 14.71 [+0.01] Error: Failed to load TC action module.
# 14.72 [+0.00] We have an error talking to the kernel
# 15.96 [+1.24] TEST: dev veth1 ingress pedit ip6 dst set 2001:db8:2::1    =
         [FAIL]
# 15.96 [+0.00] Expected to get 10 packets, but got 0.
# 15.97 [+0.01] Error: Cannot find specified filter chain.
# 15.97 [+0.00] We have an error talking to the kernel
# 15.99 [+0.01] Error: Failed to load TC action module.
# 15.99 [+0.00] We have an error talking to the kernel
# 17.23 [+1.24] TEST: dev veth2 egress pedit ip6 dst set 2001:db8:2::1     =
         [FAIL]
# 17.23 [+0.01] Expected to get 10 packets, but got 0.
# 17.24 [+0.00] Error: Cannot find specified filter chain.
# 17.24 [+0.00] We have an error talking to the kernel
not ok 1 selftests: net/forwarding: pedit_ip.sh # exit=3D1


https://netdev-ctrl.bots.linux.dev/logs/vmksft/forwarding/results/512621/80=
-pedit-ip-sh/stdout

I could be wrong, kernel.org is having a DNS outage so our CI is a bit
unstable.
--=20
pw-bot: cr

