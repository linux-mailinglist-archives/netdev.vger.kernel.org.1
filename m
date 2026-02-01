Return-Path: <netdev+bounces-255554-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ESjhGBSbfmnGbQIAu9opvQ
	(envelope-from <netdev+bounces-255554-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 01:15:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B11C4773
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 01:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6A15301809A
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 00:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769BB128395;
	Sun,  1 Feb 2026 00:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pCdW+qZH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EBE42A96;
	Sun,  1 Feb 2026 00:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769904913; cv=none; b=e7farMWts6DRLHApX0cXKrakdgPtyqN/3xnvUdRy/5Sb3Gv6APs0oklbH9u/U6xv/Wn6I5AnbK+Ah50JVyOe6WE9fcSdZ9k0hINQHZDkBmhdWc5aZeXd91RR8nSjf4lxifxg8zYQ1+I3OnUXrKpPsxGHHMyIzNQ2lRPY30U7/AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769904913; c=relaxed/simple;
	bh=wEAG5cQJYsMtMKBffWah69PxcKiQma54Qp0iq2RAkLw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WROnF/TsHK6OGud5GNbVaJa1p7pnPJYi+Sj4PVLgsfXF2iJjAab4v2EYOCVCmokSeQPM5RRpFiZpTBqy1DlQ1tInOnCeJh1O4TolqMek1HpCnc2lSHH7yCKQDdrMcxDNK//SmisLhCWt/aPHmqK/YF9bpbi+hfYYKVwXa0cOXmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pCdW+qZH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BD76C4CEF1;
	Sun,  1 Feb 2026 00:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769904912;
	bh=wEAG5cQJYsMtMKBffWah69PxcKiQma54Qp0iq2RAkLw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pCdW+qZHtItmSFDryuny3xKYYgEIq/L+In9erAbAscD8/0hbIPWbuXUNX3myxW5Hy
	 dOu0Lc98gLUQqKTH/zoDuDCMwB4ISsnLyZP4zaj9cWRt1ANRcUfit2/MCC7xxyiDJ7
	 Y8zxO0bLd1xbXxjTdkIfM328qVJxFCHd1MMosQcD9IUUz1zpuOv3MycIyKdzN9cg6k
	 F0IdzjZx4FuD0WC1SK/HmVd1wJk7HoGaY5twi/zW+mOkpdSP2WPOwlYnJeexUrfWxL
	 wDChh2e0jaSWxnDiYxZ1ITxgvqA4CAbIUzHLToJtNCswRtYblYHiKuiEQMbksAtmNT
	 tx6RP1H8cSv+w==
Date: Sat, 31 Jan 2026 16:15:11 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com,
 sdf@fomichev.me, john.fastabend@gmail.com, martin.lau@kernel.org,
 jordan@jrife.io, maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
 dw@davidwei.uk, toke@redhat.com, yangzhenze@bytedance.com,
 wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v8 03/16] net: Add lease info to queue-get
 response
Message-ID: <20260131161511.10f3cade@kernel.org>
In-Reply-To: <20260129222830.439687-4-daniel@iogearbox.net>
References: <20260129222830.439687-1-daniel@iogearbox.net>
	<20260129222830.439687-4-daniel@iogearbox.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255554-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,blackwall.org,redhat.com,google.com,fomichev.me,gmail.com,kernel.org,jrife.io,intel.com,davidwei.uk,bytedance.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 74B11C4773
X-Rspamd-Action: no action

On Thu, 29 Jan 2026 23:28:17 +0100 Daniel Borkmann wrote:
>   # ip netns exec foo ls /sys/class/net/nk/queues/
>   rx-0  rx-1  tx-0
> 
>   # ip netns exec foo ./pyynl/cli.py \
>       --spec ~/netlink/specs/netdev.yaml \
>       --do queue-get \
>       --json '{"ifindex": 8, "id": 1, "type": "rx"}'
>   {'id': 1, 'ifindex': 8, 'type': 'rx'}

I think the memory provider is going to be missing here?
We want the container to see its memory provider but IIUC the mp_priv
ends up on the lessor's queue.

I started wondering if we don't need extra checks for XDP (MPs and XDP
don't currently mix) but IIUC the mp ends up on the "real" queue, so
XDP should be fine. So either we need to follow down here, or pop the
mp pointers onto both queues?

