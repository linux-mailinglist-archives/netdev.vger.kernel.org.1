Return-Path: <netdev+bounces-289645-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EP3yLBzqDGq9pwUAu9opvQ
	(envelope-from <netdev+bounces-289645-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 00:54:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7257585DA2
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 00:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 42B7730095E1
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 22:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB3739EF11;
	Tue, 19 May 2026 22:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/pb68Dw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EAC39282C;
	Tue, 19 May 2026 22:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779231253; cv=none; b=ddg9eI9DXm27NGA0kGM8lCGXsc0pW5jd9mKqPVjSV7NNhDsWRXvtfjUrn8EgpH5kANPCBYrkrIvBYFFj9ZqPAtOthL2ElzD+tctauIvXq9ghnZ40djm9ihikNSU2pijtLzvTmjq9PlG+//zDBFtEmxRJ6jNgVzgZVwGCCNvAgz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779231253; c=relaxed/simple;
	bh=aZmV0I+58HhCvhM3HZ7Fc5/N8EIbKC/scPluMlK+U+U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GEl1H23UhsJsGOxmOKpezSgjEsgOdhWGidYvoi4hnX1xmm7u+S+fUmswnETFMbkhWEFPIEdXYvBh/NSiGQCWqakgj2lBXEvKTwP8xnKu4Fi5DeAfgPoIUY8KpQr3kSSOWgC7sqEDctLuXFUZEIrpJzFE0vZ+YZ3jdR2D+SHFQds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/pb68Dw; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 171BE1F000E9;
	Tue, 19 May 2026 22:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779231251;
	bh=aZmV0I+58HhCvhM3HZ7Fc5/N8EIbKC/scPluMlK+U+U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=i/pb68Dw1sO06PqCRhfVMB7Yehl0gCcwxW1qOIw+qNHqkLZ8ZLh0U7bzo95WT999v
	 mzpxMjnk0huiH/nem4AUeGBdKI7giwEa+EOvKtoN0/z+ws9estm2bbyJtpfByM/Sa9
	 uHyFQ78/TOQ5+GvsQq1fkmvAN0NWrMbB2YJTeJkF6TpHbxVfOZroadWWI1ipyfhl9b
	 7i9/Mofuk/mtAyo6hwqCSyhhmICmo0JP2a0MIlO8rYmLA85mKyV1Jc+axyNCwi83rM
	 V6DbgZD/FnzHVYZ4t7s30arldO2CtYCIyT0tZM/NqwjwaS36qKj1qtciKRLy2xSO1N
	 hcTqNdt7eBQ4Q==
Date: Tue, 19 May 2026 15:54:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Zijing yin <yzjaurora@gmail.com>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, Jakub Sitnicki
 <jakub@cloudflare.com>, Stanislav Fomichev <sdf@fomichev.me>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Qingfang Deng
 <qingfang.deng@linux.dev>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dev_addr_lists: don't WARN on GFP_ATOMIC
 kmalloc failure in netif_rx_mode_run
Message-ID: <20260519155410.0526f104@kernel.org>
In-Reply-To: <8f25efa5-bd29-49d5-a260-e0ed0ab9ea75@gmail.com>
References: <20260519095557.3749407-1-yzjaurora@gmail.com>
	<878q9fod8m.fsf@cloudflare.com>
	<d864aff0-d9e9-42c9-87e8-0074dc35e857@gmail.com>
	<ewjfjqocrhwmdoa6mgz3mibtuepp7c3mr5c6zixz26lzfa3g5r@4qfqvbesfv5n>
	<8f25efa5-bd29-49d5-a260-e0ed0ab9ea75@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-289645-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B7257585DA2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 19 May 2026 14:26:55 +0200 Zijing yin wrote:
> Thanks! I will attach it accordingly.=20

Please don't top post. Please wait for Stanislav to chime in.
=46rom maintainer's perspective it'd really be preferable if the author
of the code had been given a day or two to fix the bug, rather than
(forgive me) random people (forgive me) feeding the syzbot report=20
into an LLM.

My recollection is that we added this WARN to convert the whole thing
into pre-allocation / GFP_KERNEL if it actually hits on real systems.

