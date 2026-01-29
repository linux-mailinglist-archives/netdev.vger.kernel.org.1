Return-Path: <netdev+bounces-254918-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sBooCJ3Xe2l3IwIAu9opvQ
	(envelope-from <netdev+bounces-254918-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 22:56:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D34AB51E6
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 22:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD8903018D64
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 21:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3AD366834;
	Thu, 29 Jan 2026 21:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FaqBH9Q4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66ACF311C21;
	Thu, 29 Jan 2026 21:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769723476; cv=none; b=uYj41XNItOgzBOxza98eIVYd4qGLqZz98SUb5a2T/a+LvxAiadD6tlz/DS2E/h8W3hW1BaM0rtF5HJFiz6uRrv1Un53MG7ADBl1uaVZrdnZAm0KhribhPwIxX/GKJ+uaIuzgUW1K0y0kRlxROS0iiPDgFhHYKNcBAXeDcMW6YcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769723476; c=relaxed/simple;
	bh=Q3zSRrovWIg3qmOPSQjV0l/EKEt3ItdS6bxMEwS5hy8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OOjhpMNfh1J+RYR/aa5Opgu8eLxR5l7+v78qG+kIGQBocWMQQpJS5OvpRaGKe246EltU8rmWhMMag21oOCH3psY0fBTU095OtjLxUwZUMGUjPJsAR3yQ20Kiho33YZEqAhKwqBKL5NKbolnR3wWBHStWw9IUbHghsGG5c4T8/Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FaqBH9Q4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41EC8C4CEF7;
	Thu, 29 Jan 2026 21:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769723476;
	bh=Q3zSRrovWIg3qmOPSQjV0l/EKEt3ItdS6bxMEwS5hy8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=FaqBH9Q4U7OFys5R54AL4OyCg9MohsuSenTOYbfovDHiAFJImhToOKL8cibZML05A
	 pLzDda4TwEdLJuUvW2ZVAPUGm+zZZEHs+G3NKafjtHBZqzrzBoSrN/3URg9JtalS3K
	 4tG+stzA4gyXCw+UAjlhzlPMt+pYWNs48CoaJMMAhQgj4KjmtIpsH3Du60NoD/xx7K
	 Z8R0skKUd6D2YIfUeagvZ/7G1xyhK2QCemCyGnyCai3m29eeQtqEt08Q796miVEWbk
	 uOAZS0dsfhwZ9hF4Kud/pB3ZbnDobW+SsvkA1/uRkVRBECfwr7FM5H25AyySQUsQJg
	 2XmxC14tZ94kw==
From: Thomas Gleixner <tglx@kernel.org>
To: Vivian Wang <wangruikang@iscas.ac.cn>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas
 Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>, Alex Deucher <alexander.deucher@amd.com>, Christian
 =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie
 <airlied@gmail.com>, Simona
 Vetter <simona@ffwll.ch>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
 <tiwai@suse.com>, Brett Creeley <brett.creeley@amd.com>
Cc: Han Gao <gaohan@iscas.ac.cn>, Vivian Wang <wangruikang@iscas.ac.cn>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-riscv@lists.infradead.org,
 sophgo@lists.linux.dev, Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH v4 0/4] PCI/MSI: Generalize no_64bit_msi into msi_addr_mask
In-Reply-To: <20260129-pci-msi-addr-mask-v4-0-70da998f2750@iscas.ac.cn>
References: <20260129-pci-msi-addr-mask-v4-0-70da998f2750@iscas.ac.cn>
Date: Thu, 29 Jan 2026 22:51:12 +0100
Message-ID: <87ecn8m6jz.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254918-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[30];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	GREYLIST(0.00)[pass,body];
	FREEMAIL_TO(0.00)[iscas.ac.cn,linux.ibm.com,ellerman.id.au,gmail.com,kernel.org,amd.com,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,perex.cz,suse.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6D34AB51E6
X-Rspamd-Action: no action

On Thu, Jan 29 2026 at 09:56, Vivian Wang wrote:
> I would appreciate if driver maintainers can take a look and see whether
> the masks I've set makes sense, although I believe they shouldn't cause
> problems on existing platforms. I'm also not familiar with PPC enough to
> touch the arch/powerpc firmware calls further - help would be
> appreciated.
>
> My intention is that the first two patches are taken up by PCI
> maintainers, and the rest go through the maintainers of individual
> drivers since they could use more device-specific testing and review. If
> this is not convenient I'll be happy to split it up or something.

I'm happy to take the first two right away.

I can pick up the driver specific ones as well if there are no
objections; they both have been looked at by the relevant maintainers
and they obviously depend on the first ones so they have either to go
together or postponed for the next window, which doesn't make a lot of
sense.

If nobody complains I pick up the lot tomorrow morning.

Thanks,

        tglx

