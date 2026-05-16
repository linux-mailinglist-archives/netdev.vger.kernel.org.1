Return-Path: <netdev+bounces-288525-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id pXLaCYDAB2p1GwMAu9opvQ
	(envelope-from <netdev+bounces-288525-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 02:55:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8AC559A74
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 02:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D216301AF77
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 00:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247B22701CB;
	Sat, 16 May 2026 00:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hfahysaj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C7325228D;
	Sat, 16 May 2026 00:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778892924; cv=none; b=rRRMWEsssZgsR/XhVJDJE+51j6A5cgGY9J+Y3F7KcJQDITbYbLoICPLH07asE9I5nKtK4EyDHlV12tfMCzSBJUBxL847mpE5L+VKFT4c/HrbiTXZ+MkZAGv5S49GAPKYbfHW8M/XnkrfHRWSppbFgB2Q4pKuQQ9aZ2PRmU56fSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778892924; c=relaxed/simple;
	bh=BpRlgKfOs+fayhbrrJ9bk8JyvcFA2jfCWLmuW7VLOZY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n0oJ5EW128iaMEuftCp3qs1y1qzbbYoGz5wGBppIk7RUhg0joPia69xvcd96zbidQUYcJ++7jb/4vf4L/8mvPWigcB6chF+WpeeGih3rdbgkgxnR7gQ40eTZ8Sw0rwDKnhCsseyvxImtr1GksFLUCP1gPnSDmokTHurcSMboKNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hfahysaj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F3D9C2BCB0;
	Sat, 16 May 2026 00:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778892923;
	bh=BpRlgKfOs+fayhbrrJ9bk8JyvcFA2jfCWLmuW7VLOZY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hfahysajm7AzMe0B6HeQtH5K5dWB8rGkaUY5PTfnG5IgT/prTNyTJt9H8egv9FQl1
	 +xiOxbsMBe8uB89LJbKIyBDRs/rbysmvT18ERmsP22V+wy1VPiivlmxhQtubm+1rDe
	 4sLtOSqHeYW2c4y/IbALw6hMXWVxHJmmIdOGDSgKKdRN3zhDJA5KDgUphhrGR3zcmQ
	 3yhhisXxnIWsk2KhIxvjA/p3JZb0X5z3MSMa1yKQqDQdkmj9x83OdCwX5yuwQqUeoI
	 97nqwvF4stkhKRA7iUCirLFwgqb4VWhE9WscDCZW6ZGOpeXFsCapRzu6Rsx/kZBaaV
	 +sAyQlTXdL6NA==
Date: Fri, 15 May 2026 17:55:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Qi Tang <tpluszz77@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4] ipv6: validate extension header length before
 copying to cmsg
Message-ID: <20260515175522.0aafbfb4@kernel.org>
In-Reply-To: <20260514035802.1540395-1-tpluszz77@gmail.com>
References: <20260514035802.1540395-1-tpluszz77@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9E8AC559A74
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-288525-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, 14 May 2026 11:58:02 +0800 Qi Tang wrote:
> +	return (ptr + len <= skb_tail_pointer(skb)) ? len : 0;

This is probably better written as:

	return (len <= skb_tail_pointer(skb) - ptr) ? len : 0;

? len can't be too large so unlikely to matter in practice
but technically ptr + len may overflow and wrap on 32b?
-- 
pw-bot: cr

