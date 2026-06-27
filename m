Return-Path: <netdev+bounces-302305-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id z3knMtZfP2pWSQkAu9opvQ
	(envelope-from <netdev+bounces-302305-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 07:29:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2242A6D12DE
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 07:29:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=i-love.sakura.ne.jp (policy=none);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302305-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302305-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8F7B303277C
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 05:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D3E3101CE;
	Sat, 27 Jun 2026 05:29:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAC3288530
	for <netdev@vger.kernel.org>; Sat, 27 Jun 2026 05:29:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782538196; cv=none; b=fvlK+Ao3YIk9fMk5ZbwP3ZwY0sItcsElQDkvXNgnTGiJlL/tRznz6WrgYLCUv0HtRWb9e51Gh0Api+HFzu8dRMgZJX1l0uEcRjtFUC0try38xELoFNvvUO1aGTK7n4CpGBq+FUL3djesifi6WpXVxhQOtj+ha+hFzxKgM2uvc0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782538196; c=relaxed/simple;
	bh=D5s3R3niZVIUOGDu7mziXizVg0cziH2fG1zX+NAS5Vk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ra18ihyDMNhg1ofii3eEbz3BT5Ktn4f+ypvP5J32dioFdvSmwISUgG1hxlLU/Q/Kh7t2HwWB7D9a5pbmTqBS4v04H7DvzfEogF7QxZCe3b7Mw/3Nq9lVYUCXbnUN/E0ozCHqPcs1jXycnbww72pHm2oD5A4sh2Mwqgtd9kQyOIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 65R5SwGv004925;
	Sat, 27 Jun 2026 14:28:58 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 65R5Svq0004920
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sat, 27 Jun 2026 14:28:57 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <2951101e-d503-4a48-91b8-d6f041f0b1b6@I-love.SAKURA.ne.jp>
Date: Sat, 27 Jun 2026 14:28:57 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tomoyo: Enforce connect policy in TCP Fast Open
To: Matthieu Buffet <matthieu@buffet.re>
Cc: Bryam Vargas <hexlabsecurity@proton.me>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8?=
 =?UTF-8?Q?n?= <mic@digikod.net>,
        =?UTF-8?Q?G=C3=BCnther_Noack?=
 <gnoack@google.com>,
        linux-security-module@vger.kernel.org,
        Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
        Paul Moore <paul@paul-moore.com>, Yuchung Cheng <ycheng@google.com>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        Kentaro Takeda <takedakn@nttdata.co.jp>
References: <20260619002207.61104-1-matthieu@buffet.re>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20260619002207.61104-1-matthieu@buffet.re>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav301.rs.sakura.ne.jp
X-Virus-Status: clean
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[i-love.sakura.ne.jp : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302305-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[penguin-kernel@I-love.SAKURA.ne.jp,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:matthieu@buffet.re,m:hexlabsecurity@proton.me,m:mic@digikod.net,m:gnoack@google.com,m:linux-security-module@vger.kernel.org,m:ivanov.mikhail1@huawei-partners.com,m:paul@paul-moore.com,m:ycheng@google.com,m:edumazet@google.com,m:netdev@vger.kernel.org,m:takedakn@nttdata.co.jp,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[penguin-kernel@I-love.SAKURA.ne.jp,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,buffet.re:email,I-love.SAKURA.ne.jp:mid,I-love.SAKURA.ne.jp:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2242A6D12DE

On 2026/06/19 9:22, Matthieu Buffet wrote:
> Tomoyo restricted TCP connections in 2011 in commit
> 059d84dbb389 ("TOMOYO: Add socket operation restriction support.")
> using the socket_connect() LSM hook.
> 
> However, the MSG_FASTOPEN sendmsg() flag was added in 2012 to allow
> combining connect() and the first sendmsg(). Tomoyo was not updated to
> take this into account in its send hook.
> 
> This resulted in a TCP connect policy bypass similar to that reported in
> Landlock in 2024 (see Link below), with the difference that Tomoyo was
> fine when originally merged, and the problem got introduced when adding
> fastopen support, possibly due to lack of synchronization between lsm
> and netdev worlds.
> 
> Add MSG_FASTOPEN handling in Tomoyo's existing send hook.
> 
> Link: https://github.com/landlock-lsm/linux/issues/41
> Link: https://lore.kernel.org/all/20260616201615.275032-1-hexlabsecurity@proton.me/
> Fixes: cf60af03ca4e ("net-tcp: Fast Open client - sendmsg(MSG_FASTOPEN)")
> Cc: stable@kernel.org
> Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
> ---
>  security/tomoyo/network.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 

Thank you for finding this problem and making a patch.
I updated your patch like below in order to exclude kernel threads from this check.
If we are OK to go with modifying individual LSM, I'll apply this change.

 security/tomoyo/network.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/security/tomoyo/network.c b/security/tomoyo/network.c
index cfc2a019de1e..50d27c773b10 100644
--- a/security/tomoyo/network.c
+++ b/security/tomoyo/network.c
@@ -765,6 +765,15 @@ int tomoyo_socket_sendmsg_permission(struct socket *sock, struct msghdr *msg,
 	const u8 family = tomoyo_sock_family(sock->sk);
 	const unsigned int type = sock->type;
 
+	if ((msg->msg_flags & MSG_FASTOPEN) && msg->msg_name && type == SOCK_STREAM &&
+	    (family == PF_INET || family == PF_INET6) &&
+	    (sock->sk->sk_protocol == IPPROTO_TCP || sock->sk->sk_protocol == IPPROTO_MPTCP)) {
+		address.protocol = SOCK_STREAM;
+		address.operation = TOMOYO_NETWORK_CONNECT;
+		return tomoyo_check_inet_address((struct sockaddr *)msg->msg_name,
+						 msg->msg_namelen, 0, &address);
+	}
+
 	if (!msg->msg_name || !family ||
 	    (type != SOCK_DGRAM && type != SOCK_RAW))
 		return 0;
-- 
2.54.0



