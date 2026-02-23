Return-Path: <netdev+bounces-260260-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GGY/OG/inGnCLwQAu9opvQ
	(envelope-from <netdev+bounces-260260-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 00:27:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B1A17F654
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 00:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 45A47300D4E8
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 23:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66A037F734;
	Mon, 23 Feb 2026 23:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ezEyhpN0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C475534D917
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 23:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771889259; cv=none; b=FosCfMGU5wr5miVIg0dJV5j3uFnrRPLj4964P1SSuvOjWazdnkc9O0cmelM99A0btjF49bRQUaAHCzzmDvsAfxiGFOyXzk0ZuT7rWcsVLhFB8ZHoND0mr8qKwCX8XG8KBnA9obs/88Th6Y3i4B+u3BXNQYEZ90YamsYN7U0up2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771889259; c=relaxed/simple;
	bh=1jTI8SOlf7Q5n7j/hJQpB39usPB33zAqIEiHeYrDQB0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FReCztOeWATxx9pUOEzuqYXrrm6oXjvZUWjJDFdhK3Ke4fyAfnGI1ZgX0VUEYpqIL7GLtUcHtHnrmeky+jR1EMiVcR+yV+B0bTL/eymwjX0zPOXTu4eZ/8vJ9Te06bfvxcGi5w8ZSukkzAJt6RI7BDwhJvpnHYgItTS5lPahe/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ezEyhpN0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 159C7C116C6;
	Mon, 23 Feb 2026 23:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771889259;
	bh=1jTI8SOlf7Q5n7j/hJQpB39usPB33zAqIEiHeYrDQB0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ezEyhpN0W3JmZ02NHuCG8ksF8L31Dq2I+UOqZNI/JZL55cW9VnGvvqcmKxEF/Bg3O
	 b0GGyrZVrPJw/PQAOH6k8H6Kz1UeCwU7hwWXl/xVDd13JK/bzUhHe4tiXnUCrEWFAA
	 5RxqN0CxlopyAIw/o2OuaoWC0+Ywg8SxWoM+GFB4HAB6+vIw/rwequa431BpTotUhJ
	 75FPGzH79ml4VXERDXpNWWvL1leUKGUpIAy3r6l6ERc2IBIbuyMhPi5HrCAaMYf6MR
	 2i92bb2Q9Zj78KKnFOtfd+LSpX6RnktktkP/s8jOyYJyCMsu46ELtlaeInL3advqVO
	 65cL3fnRS5JjA==
Date: Mon, 23 Feb 2026 15:27:38 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Paolo Abeni
 <pabeni@redhat.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Kurt Kanzenbach <kurt@linutronix.de>, Simon
 Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net v2] net: Drop the lock in skb_may_tx_timestamp()
Message-ID: <20260223152738.7e8e95fb@kernel.org>
In-Reply-To: <20260223170750.q5nhbkSe@linutronix.de>
References: <20260220183858.N4ERjFW6@linutronix.de>
	<20260220132932.1ed45656@kernel.org>
	<willemdebruijn.kernel.85c1623c5d65@gmail.com>
	<20260220140241.51be1e30@kernel.org>
	<20260223170750.q5nhbkSe@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,davemloft.net,google.com,linutronix.de,kernel.org];
	TAGGED_FROM(0.00)[bounces-260260-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 89B1A17F654
X-Rspamd-Action: no action

On Mon, 23 Feb 2026 18:07:50 +0100 Sebastian Andrzej Siewior wrote:
> How do we move forward? Merge this, backport stable and then convert
> in-tree user away from IRQ delivery _or_ fix the driver one by one and
> backport them stable? Or=E2=80=A6

If we plan to convert in-tree users away from IRQ delivery I'd do that
directly, without applying this patch. But I'll let Paolo have the final
word. Eric's review tag seems to indicate to me that he disagrees.

