Return-Path: <netdev+bounces-252935-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEBdAxbNc2kCywAAu9opvQ
	(envelope-from <netdev+bounces-252935-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 20:33:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 693747A2AB
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 20:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E06F5300250D
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 19:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A017F21FF5F;
	Fri, 23 Jan 2026 19:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iLyGvDVA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB973EBF07
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 19:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769196816; cv=none; b=mtMOkWtUTClBH562wS80l1TRv6VH0eEDHQaGP2bxSvycBwBv9//0P6w2KpY02G/vnOg3LuFAJ1++I6JtYJgqnWvg8efYrUTSy+qw1P53EGyKfVoT2/Nc0ygEBvGjzrjmzoGk7CEYzZv8O+DGKxgzPIYc+VAielmuyOwr2RIr0IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769196816; c=relaxed/simple;
	bh=vnT+0FalYOUmIF0Tv6nYXylTie/vZmQs5r3VKPyfLzc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZXYEkfHiqg+zwEOeTrKekmMyjkMa5Wliw650QnjSNjRPfGTtTopu1rD8GCy0fNLTFMZIgD+oP8hSJoDCjlobqsbrn4jBXsbH0w4H7b/vV4APrCGpvPEJykaabWXmDolLiqykR6I3xzz1zi7RrYNDmh6hV0cD9SvKvNetE+aOv+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iLyGvDVA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EA43C4CEF1;
	Fri, 23 Jan 2026 19:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769196816;
	bh=vnT+0FalYOUmIF0Tv6nYXylTie/vZmQs5r3VKPyfLzc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iLyGvDVAsaJ+uzb++RiNPQrK5s99j1skeBTlDUMaXMgsdSQ3pAuvnzWmvvN0ZNWun
	 HKuJ7sIgx2g770qniMubfJ6CvEoKjtqPeZw6L+3yulf9LcTApUj3w/JpdayD98l3/A
	 oik9gg1kaSHKMHaog+aP/b3UCcOigwojtCAE/fr7Y6M6oRG+OO5anv2kHbibviFN+q
	 aeInkDa7r3UWNRlrYSkjd5ifsDDVV52k9O/pNGMe/8ViJsi+aCNU/+0hf9n3BCLsg9
	 42VxubRGR+pXzAp3bNijc98hMJvAomaTJ0v6Vmb98XfqUS8i3MjzhqRXmzm2TSzNFN
	 YcKVqXVjJ78Hg==
Date: Fri, 23 Jan 2026 11:33:34 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, Donald
 Hunter <donald.hunter@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Shuah Khan <shuah@kernel.org>, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, sdf@fomichev.me, petrm@nvidia.com,
 razor@blackwall.org, idosch@nvidia.com
Subject: Re: [PATCH v5 net-next 00/10] geneve: introduce double tunnel
 GSO/GRO support
Message-ID: <20260123113334.1dea13d3@kernel.org>
In-Reply-To: <cover.1769011015.git.pabeni@redhat.com>
References: <cover.1769011015.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252935-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,gmail.com,lunn.ch,fomichev.me,nvidia.com,blackwall.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 693747A2AB
X-Rspamd-Action: no action

On Wed, 21 Jan 2026 17:11:26 +0100 Paolo Abeni wrote:
> This is the [belated] incarnation of topic discussed in the last Neconf
> [1].

In case you find yourself with spare cycles or an intern -- adding a
test case to tools/testing/selftests/drivers/net/hw/tso.py could save
us some driver surprises?

