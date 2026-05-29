Return-Path: <netdev+bounces-293135-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yHcPBmiiGWptyAgAu9opvQ
	(envelope-from <netdev+bounces-293135-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 16:27:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3FB6038E6
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 16:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A7BE300AC06
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 14:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00343E5594;
	Fri, 29 May 2026 14:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUCS4WzI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB023438A0;
	Fri, 29 May 2026 14:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780064462; cv=none; b=EyUvnjWThgHb5PSphogiSOP9HVzINrI3FNn5rNvQbOXYqg3wnZXCIj0UqasBRn1dN5mYooh+0ONztndEiWoNxUjyy71h/AQGfDfP2F6oMQI9Km50W7I2tSoGCnB4A39TEnfOlPguqrS1bWHDkCNOq/qAP5QSDfOUduIg9LAvg78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780064462; c=relaxed/simple;
	bh=BCsTmNrxNi59z8cWp0b6erGAdytuLXtwGco7mM/HcWw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eHVWZ1s1oYtZ+68PY8zQhpbB48vOrL+P/tAwOHfijqrWE3RN6P8aRS2cJ1ZKBILQQJXKVgA+FHDtLsJhmiysinPLE/jaLlSC8U1qWyjUxeLBHGXGzqtNcY2XWNx0UdhlctSppArWkYP4pWoW0z/RB71PsSj7m7OcOiy1+fLchbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUCS4WzI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD9991F00893;
	Fri, 29 May 2026 14:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780064461;
	bh=wLE9+XAPG4f46HyNwpGtUdLJDwiw2m2vPxaZCmY7ZCs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kUCS4WzItv2nQMqEyJDBOP9ufttGz6xM6Eqjxxm92DkT/9TlS98Qz7KVt/CVrL5md
	 NrsAHK8Jo7Cai97MJrm1+KJDrUTtUVlJYe9v3m2yhzUA8nwMhRAMTZkNSZIdaTQLcJ
	 +sAUxG2RlVkKZZZlEyLxewXUljvLQqTgA9ymP4+QA+nzC1qlnzlmU15KaW8clvq9JZ
	 m++Mw9t2z5HNH843AOqC55Nak/xrq54r+jo6Lacy/912vZ57vB7SU7lvscWtks03+y
	 M1IHtkox/Ra9y9DaeyVYBaP4AqWQRVbJexiP/ztxroci/cv2tPfgEn9vOz1P+mNToF
	 THsdk7zxjcG1A==
Message-ID: <4df03cad08088fba7fb49beaeb6513cef5b87c2b.camel@kernel.org>
Subject: Re: [PATCH 02/11] nvmet-tcp: implement accept mptcp proto
From: Geliang Tang <geliang@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>, Matthieu Baerts <matttbe@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
 <kch@nvidia.com>,  Matthieu Baerts <matttbe@kernel.org>, Mat Martineau
 <martineau@kernel.org>, "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>,  Shuah Khan <shuah@kernel.org>, Geliang Tang
 <tanggeliang@kylinos.cn>, linux-nvme@lists.infradead.org, 
	netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kselftest@vger.kernel.org,  Hannes Reinecke	 <hare@suse.de>, John
 Meneghini <jmeneghi@redhat.com>, Randy Jennings	 <randyj@purestorage.com>,
 Nilay Shroff <nilay@linux.ibm.com>, zhenwei pi	 <zhenwei.pi@linux.dev>, Hui
 Zhu <zhuhui@kylinos.cn>, Gang Yan <yangang@kylinos.cn>
Date: Fri, 29 May 2026 22:20:51 +0800
In-Reply-To: <20260528082344.7e4cd1a1@kernel.org>
References: <cover.1779934709.git.tanggeliang@kylinos.cn>
		<a1fa5dd3ebb0cafe1bf7948bf2a96436e9452e19.1779934709.git.tanggeliang@kylinos.cn>
	 <20260528082344.7e4cd1a1@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293135-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geliang@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8A3FB6038E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Jakub,

On Thu, 2026-05-28 at 08:23 -0700, Jakub Kicinski wrote:
> On Thu, 28 May 2026 11:10:36 +0800 Geliang Tang wrote:
> > Dedicated MPTCP helpers are introduced for setting accept socket
> > options.
> > These helpers (no_linger, set_priority, set_tos) set the values on
> > all
> > existing subflows using mptcp_for_each_subflow(). The values are
> > then
> > synchronized to other newly created subflows in
> > sync_socket_options().
> 
> These are not protocol specific options, why do we have to export
> MPTCP-specific functions for them?

Thank you for reading the code. In addition to the three MPTCP-specific
functions implemented in this patch, I have implemented and exported
the following six MPTCP-specific functions throughout the series:

    void mptcp_sock_set_nodelay(struct sock *sk)
    int mptcp_sock_set_syncnt(struct sock *sk, int val)
    void mptcp_sock_set_tos(struct sock *sk, int val)
    void mptcp_sock_no_linger(struct sock *sk)
    void mptcp_sock_set_priority(struct sock *sk, u32 priority)
    void mptcp_sock_set_reuseaddr(struct sock *sk)

These correspond to the following six functions originally used for
TCP:

    tcp_sock_set_nodelay()
    tcp_sock_set_syncnt()
    ip_sock_set_tos()
    sock_no_linger()
    sock_set_priority()
    sock_set_reuseaddr()

The first two functions - tcp_sock_set_nodelay() and
tcp_sock_set_syncnt() - cannot be directly used with an MPTCP socket.
In fact, passing an MPTCP socket to tcp_sock_set_nodelay() even causes
a crash. Therefore I implemented these two MPTCP-specific functions.
Actually, a better approach would be to add protocol-independent
sock_set_nodelay() and sock_set_syncnt() in net/core/sock.c.

The third function, ip_sock_set_tos(), takes different arguments for
TCP vs. MPTCP. For MPTCP, it needs to pass inet_sk(msk->first)-
>rcv_tos, so I implemented an MPTCP-specific function.

The last three functions - sock_no_linger(), sock_set_priority(), and
sock_set_reuseaddr() - are not protocol-specific, but attributes set on
the MPTCP socket cannot be synchronized to its subflows because
mptcp_sockopt_sync_locked() checks msk->setsockopt_seq. Thus I
implemented these three MPTCP-specific functions, explicitly calling
sockopt_seq_inc(msk) inside them to increment msk->setsockopt_seq, so
that mptcp_sockopt_sync_locked() can properly synchronize the
attributes to all subflows. There should be a better solution for this,
and I will discuss it with @Matt.

Please give me some advice.

Thanks,
-Geliang

