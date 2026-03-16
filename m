Return-Path: <netdev+bounces-268348-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMHtOtyZuGmsgQEAu9opvQ
	(envelope-from <netdev+bounces-268348-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 01:01:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD692A226D
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 01:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0C9C306E878
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 23:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF9237AA75;
	Mon, 16 Mar 2026 23:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVqbBT6x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8D4374744;
	Mon, 16 Mar 2026 23:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773705587; cv=none; b=nJSsxk1j+pneyitORlbDgV+XacVshhYnOKRPcmHWSd4v6QzUbEz39E9+HyNdwNDEsaty0Zi5n7Js24rmiaYQX0tkNKB/AW/MHFMU2VWYAQjLYUBdmlRp5Il7t5wZlPikz9zO9TZg3g7HlVZkTQn720KNAlrwgZgOtIaODl3/jmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773705587; c=relaxed/simple;
	bh=/cU6l1SLbK1eG9HM8mpKY65YoaywDtrWJFQHXZNR88k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j/UyF7v2a8tW6ha55RFvXTwe1y7+vmIaEn3ng/9bqrJNBXwLr/4e990S9sBWoiVWCOUuVXvDTZsRhGHhxLSze75Oqhy3HTpo9oGSQa/QS6ZuOg3k0u2auD8cPydwFoEETBFMd6OFeLqUkwei64QYdw5TI8WO/jbjGgaixzUV82Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVqbBT6x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C767C19421;
	Mon, 16 Mar 2026 23:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773705587;
	bh=/cU6l1SLbK1eG9HM8mpKY65YoaywDtrWJFQHXZNR88k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GVqbBT6xhMDag998hOgPW6NP38RnSwQP8knsE/75ljC0a9Y10A9vUedC97+BP4ic5
	 x00YVEsfDLIjM6M6n2QH7dNiB7PJ7dF3gw+aA/u2SGoTVayG5fr/LkRr1Drc09JOXj
	 8KBCW/HJif3fPCatI4NW7tY664fidaZgw8vU6CmhKG3ZxKHVypr+5+ClFGNQn6w0bz
	 bym1+q+UTiviDKOgLc5SGjJLFfBJurhJybOBEUCxZSEnFJVLYBvDw8eOq93dWWzaxo
	 Tn40dtOKIzQnDKnO+VEjqMw7HyAqhY52i8j0MEri1FE6IcpEjowD9NCSh7YqJAMULx
	 5cTUUcWrYwLwQ==
Date: Mon, 16 Mar 2026 16:59:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, edumazet@google.com, Jiayuan Chen
 <jiayuan.chen@shopee.com>, Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Paolo
 Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v1] selftests: bonding: add test for stacked bond
 header_parse recursion
Message-ID: <20260316165946.46e9f8f7@kernel.org>
In-Reply-To: <8f118476-ca9b-45f3-b59e-e4cff341ef0f@linux.dev>
References: <20260314134211.33405-1-jiayuan.chen@linux.dev>
	<20260314103833.36698c29@kernel.org>
	<8f118476-ca9b-45f3-b59e-e4cff341ef0f@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268348-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4BD692A226D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 15 Mar 2026 18:40:51 +0800 Jiayuan Chen wrote:
> # Send a GRE packet so it arrives via gre -> bond0 -> bond1
> python3 -c "
> from scapy.all import *
> send(IP(src='10.0.0.2', dst='10.0.0.1')/GRE()/IP()/UDP(), verbose=0)
> "
> 
> But I wasn't sure if scapy is an acceptable dependency for selftests,
> and I also wasn't confident that tcpdump will always use AF_PACKET
> SOCK_DGRAM internally. So I ended up writing the Python script to
> handle both the SOCK_DGRAM listener and packet construction myself.
> 
> Is it fine to just inline a few lines like the scapy approach above,
> or would you prefer keeping it as a separate script?

The scapy two-liner format is fine to keep inline.

I personally don't really like scapy so we stayed away from it until
now. But for cases like this it seems like much lower maintenance
burden than separate tools so let's go ahead.

