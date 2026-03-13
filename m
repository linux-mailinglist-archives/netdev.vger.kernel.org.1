Return-Path: <netdev+bounces-267617-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UG1yIJOKtGkKpgAAu9opvQ
	(envelope-from <netdev+bounces-267617-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 23:07:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0023928A42D
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 23:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F08B330234EE
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 22:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76D436C9E9;
	Fri, 13 Mar 2026 22:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nuuEtUCl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48CF33689D
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 22:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773439631; cv=none; b=GfDKD1LTn4TOxb5xv4vqOyd2KkEVZ+TYE69TBFjhiWzClSIqAgY9D/9n99VpbWOlpd5JAcZblzvCDDzIjYWuuU9hlJD+jSL2ouiAM5vFzLLn7AdKbtOLR3H0Bn6rtS7XcWOzDfe+l3RME/b+mRQBNcxPZz9rPzRBGG5PyV3UdDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773439631; c=relaxed/simple;
	bh=36xZjDqxgbQRJoF9T+tfKZC50MAytjkKOe8z2qmQNKc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K7uT51/1Iq0T1GqpvvATPGui8SXQAV8tEuUDqCsxaIumpAnI3EoB3yw8tru7HdgqkBJQiB3N841kPWPPUfnOU0zI3irppXjJKBvf3Bvss2mqOcpKMx71MJJA7h4pvOqTuXMC11PfasjQtwIShZsRxyixc8s/vLFvOwzNz5ifqvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nuuEtUCl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B6FC19421;
	Fri, 13 Mar 2026 22:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773439631;
	bh=36xZjDqxgbQRJoF9T+tfKZC50MAytjkKOe8z2qmQNKc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nuuEtUClOYvgi5pB/X9IddMd+8PbTcMzUabvZCtelt0Lwkk4jZKg19JPArphJMQHO
	 85fz/0waIL/PD1pH83U7D3KS0JphaCLKwA5tNClr1IK/9rpo9mgv+aIIgQL7HVAR02
	 TTzut8L4b5NH9uD5UYYcK8QXSxdWGINPUL0He+2qWq4nM557O7vOcfqPLrGjx8gpDU
	 +szE6/myLqrpegd8LAJk5tCcpgMkxcv6Z04QxxdxVALCWpXpaINd0wz5r1NQmY+Hzb
	 l36rsHwAdAZYCGHzFtiQcjXHEbnKSAIKGgPZPG7hZukrEDMxQKjy+fPKP9Sm5mg9tQ
	 Tdaw7mFW16Zsw==
Date: Fri, 13 Mar 2026 15:07:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Neal Cardwell
 <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] tcp: add cwnd_event_tx_start to
 tcp_congestion_ops
Message-ID: <20260313150710.0edaa6b9@kernel.org>
In-Reply-To: <20260313202802.1201129-1-edumazet@google.com>
References: <20260313202802.1201129-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-267617-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0023928A42D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 13 Mar 2026 20:28:02 +0000 Eric Dumazet wrote:
> (tcp_congestion_ops)->cwnd_event() is called very often, with
> @event oscillating between CA_EVENT_TX_START and other values.
> 
> This is not branch prediction friendly.
> 
> Provide a new cwnd_event_tx_start pointer dedicated for CA_EVENT_TX_START.
> 
> Both BBR and CUBIC benefit from this change, since they only care
> about CA_EVENT_TX_START.

BPF selftest are not happy:
857
  progs/tcp_ca_kfunc.c:121:33: error: use of undeclared identifier 'cwnd_event_tx_start'
    121 |         .cwnd_event_tx_start = (void *)cwnd_event_tx_start,
        |                                        ^~~~~~~~~~~~~~~~~~~
-- 
pw-bot: cr

