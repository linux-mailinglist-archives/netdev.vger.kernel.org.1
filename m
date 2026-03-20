Return-Path: <netdev+bounces-269833-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIpmN64BvWkO5gIAu9opvQ
	(envelope-from <netdev+bounces-269833-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 09:13:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BDC2D7003
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 09:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AFB4E300FB4C
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 08:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C2A36EA95;
	Fri, 20 Mar 2026 08:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c38OZKt1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837EE364E87;
	Fri, 20 Mar 2026 08:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773994400; cv=none; b=FCZ7WMJlzIr8QnNisxb8SUb18zF0TM4dB6xTPzDjTiT2vvQX7/peb2z3rZpjS6OtdpVPMPTq0qXKcVbAKAj7u5mBCt1cpyZeF5dILPsGQMm0V71KBkKx4gaEZKoKNKLHqH/0wbYv+NLalkObogCq9LANRXNt43UWTcX+5foC8NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773994400; c=relaxed/simple;
	bh=b5xDM7DwkSZAXjttSN7ldY3nBQRjJ46emdFic4xKHA4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OKxeIPRs57X+fxl8G0y/PAmrcNEbDMuzavqSQ8etIax/TjyREzUKuFSeYAnDjJ921dZj88bEYI4IhJFOPGb5+kXrL2TJslViGc7YB7xiW0A8iUIRDfYtNw77zZqCh6ZIWJas7minpbUw6avImwQz1dd2WuVCl1wCglgxZicSVpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c38OZKt1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C616FC4CEF7;
	Fri, 20 Mar 2026 08:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773994400;
	bh=b5xDM7DwkSZAXjttSN7ldY3nBQRjJ46emdFic4xKHA4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=c38OZKt1HdfyMO/J9O9SvP1x/LXvgPbUsUO3cMP3+u1Jvqd+xyKnVB8HFz5MLXN/b
	 SxgOty443lhX21IBZrRlveutNxSS5/NnVToaX5wDH6iyj6AoDDNCD8mcHsA4tvFG1V
	 DDkr70Pcg4CbhNUPLgw7N7WRwKnFTgTvvUhienGb0GOW6HB31fS/J+OxaRgGjuPbbK
	 9qWwcjPWyP1ARceHm+dkA9NwbMkxygfPCpAlxNtKcsa0vc1JnWWL5WaF0nJU8w1VwJ
	 yYFk1pVFC2dCGUiEaVu9wKs2Z9C/Olxxhomcfa/1QeLzaLOo9vg8WRDzURKorWLQqu
	 DHGa9NqVETBww==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, magnus.karlsson@intel.com, stfomichev@gmail.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 larysa.zaremba@intel.com, aleksander.lobakin@intel.com, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH v2 net 1/8] xsk: tighten UMEM headroom validation to
 account for tailroom and min frame
In-Reply-To: <20260319175538.479139-2-maciej.fijalkowski@intel.com>
References: <20260319175538.479139-1-maciej.fijalkowski@intel.com>
 <20260319175538.479139-2-maciej.fijalkowski@intel.com>
Date: Fri, 20 Mar 2026 09:13:16 +0100
Message-ID: <878qbmq5pf.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-269833-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bjorn@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.977];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 59BDC2D7003
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

> The current headroom validation in xdp_umem_reg() could leave us with
> insufficient space dedicated to even receive minimum-sized ethernet
> frame. Furthermore if multi-buffer would come to play then
> skb_shared_info stored at the end of XSK frame would be corrupted.
>
> Multi-buffer setting is known later in the configuration process so
> besides accounting for ETH_ZLEN, let us also take care of tailroom space
> upfront.
>
> Fixes: 99e3a236dd43 ("xsk: Add missing check on user supplied headroom si=
ze")
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>

