Return-Path: <netdev+bounces-251796-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEZxC/KLcGkEYQAAu9opvQ
	(envelope-from <netdev+bounces-251796-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 09:18:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6B353624
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 09:18:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DB8EF4EA8FA
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 08:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E575477E32;
	Wed, 21 Jan 2026 08:15:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C021543C06D
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 08:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768983315; cv=none; b=hn4ht9TOMZ5uSqPvTEBFQphKphimQyQUxS7tHDw3UsbCPYuCxdvXeLTwqnOUlOrBUuKlzhPmOyH+Q/4fEEQ4xNqr2lWn2ChmE41f1GNsg08QPVxa2UtnZt/7djV/sg5yMoQjptMKlTOi4SYvqs3k+QS/HhopN6BjCWZBDbU7tXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768983315; c=relaxed/simple;
	bh=pU4aApN+W+Q2oftkBig1imZGm/hVUTq4yYFgQ7KJORA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uJr/U7Wm/A/J/4RMoxg3h6ozWbmd8lupDPXBC/3MMiMJDvnFFpra8vCrZUaKx79D1GbpCym7LR2g2QSZ8NJ0m2dPoK4FHQtyi82e1DCzR93fU3lNUtvLQLZdlXz+oj/bzCoot3SmyOZBNgJ7w722neDfLZAMtJ6e0P6PAXQA+yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0B0ED5BCCA;
	Wed, 21 Jan 2026 08:15:11 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5AF593EA63;
	Wed, 21 Jan 2026 08:15:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XS7yFA6LcGn7cAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 21 Jan 2026 08:15:10 +0000
Date: Wed, 21 Jan 2026 09:15:09 +0100
Message-ID: <878qdrs7oy.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,	Michael Ellerman
 <mpe@ellerman.id.au>,	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,	Alex Deucher
 <alexander.deucher@amd.com>,	Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>,	David Airlie <airlied@gmail.com>,	Simona Vetter
 <simona@ffwll.ch>,	"Creeley, Brett" <bcreeley@amd.com>,	Andrew Lunn
 <andrew+netdev@lunn.ch>,	"David S. Miller" <davem@davemloft.net>,	Eric
 Dumazet <edumazet@google.com>,	Jakub Kicinski <kuba@kernel.org>,	Paolo
 Abeni <pabeni@redhat.com>,	Bjorn Helgaas <bhelgaas@google.com>,	Jaroslav
 Kysela <perex@perex.cz>,	Takashi Iwai <tiwai@suse.com>,	Han Gao
 <gaohan@iscas.ac.cn>,	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org,	linux-sound@vger.kernel.org,
	linux-riscv@lists.infradead.org,	sophgo@lists.linux.dev
Subject: Re: [PATCH v2 4/4] ALSA: hda/intel: Raise msi_addr_mask to dma_bits
In-Reply-To: <20260121-pci-msi-addr-mask-v2-4-f42593168989@iscas.ac.cn>
References: <20260121-pci-msi-addr-mask-v2-0-f42593168989@iscas.ac.cn>
	<20260121-pci-msi-addr-mask-v2-4-f42593168989@iscas.ac.cn>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.1 Mule/6.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Score: -4.00
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[suse.de : No valid SPF, No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[28];
	FREEMAIL_CC(0.00)[linux.ibm.com,ellerman.id.au,gmail.com,kernel.org,amd.com,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,perex.cz,suse.com,iscas.ac.cn,lists.ozlabs.org,vger.kernel.org,lists.freedesktop.org,lists.infradead.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-251796-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,iscas.ac.cn:email]
X-Rspamd-Queue-Id: BE6B353624
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 21 Jan 2026 04:49:40 +0100,
Vivian Wang wrote:
> 
> The code was originally written using no_64bit_msi, which restricts the
> device to 32-bit MSI addresses.
> 
> Since msi_addr_mask is introduced, use DMA_BIT_MASK(dma_bits) instead of
> DMA_BIT_MASK(32) here for msi_addr_mask, describing the restriction more
> precisely and allowing these devices to work on platforms with MSI
> doorbell address above 32-bit space, as long as it is within the
> hardware's addressable space.
> 
> Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
> 
> ---
> v2: No changes
> 
> hda/intel maintainers: I don't know if this is the correct restriction.
> Please help with checking. Thanks.

The quirk is used only for AMD graphics chips, so this should
(hopefully) work.

Acked-by: Takashi Iwai <tiwai@suse.de>


thanks,

Takashi

