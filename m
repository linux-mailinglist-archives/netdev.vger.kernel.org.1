Return-Path: <netdev+bounces-261918-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOI7EBzMoWniwQQAu9opvQ
	(envelope-from <netdev+bounces-261918-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 17:53:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 975C41BB0DA
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 17:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F7DA319B8FA
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 16:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6CC349B16;
	Fri, 27 Feb 2026 16:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMGK66Il"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76685349B00;
	Fri, 27 Feb 2026 16:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772210961; cv=none; b=IHrByAQ9YlQBECX90eyE5/3iuC9ZR+ThrmXL29kag6GCFcVUep/S2a4J5oWGSwEV9IlcIpBGuCakYZ5j4QJWbIusWmqy/rjWDd+qvJ9ZYPBU11eYVJZqmH3Ze7PKtimdMDDx27KC9LXUbePBUT8wcBxnTnsoLHVwqANCTUpuGqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772210961; c=relaxed/simple;
	bh=jznU9LDSkQYILvcSIV46IxA3CrI9OTrcodpcP2KE/Rk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=b5pzeMzdmK0zQD76DVYwWcjX55sKDcpwS3oTsBjdGQLIjy4OKCcd8iwI4sjY+RSA2TzXnc8odm5YS87rKq67v+klimKpNuzSchsCOSVjGhkCYoPcsMbzMhMzdhxVcTJZ403cV7Q4q5LHJMPL8NOcU6CEwr0NIOZxSHK5uRGInmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BMGK66Il; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3011C116C6;
	Fri, 27 Feb 2026 16:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772210961;
	bh=jznU9LDSkQYILvcSIV46IxA3CrI9OTrcodpcP2KE/Rk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=BMGK66IlpUYHanCwORkjV1r5gD4tZdmf3FdgQyvpYqd87OnPE/XYM3XTkW4Ksw/Y2
	 Y3jxv1rvP5tPMlEvJt5tjaSTDHFbZ6E0cmQiJ4sJ1nQ4Fa0ouKncl5VoVtiCuVxIzZ
	 wWKIJt52O1sSUx08jbmlf8//snPIjiC+zltv0lkdOUs2BhGHuFA3bE4uAUcyVVBSxy
	 qaQx337ysm56rZiMRyNkrrziyLzOmk1FheLkVIlnP9JOrOh9Vg2yq723loCPFce4ld
	 PQ+fWhfMBe0FBUqcD3yCDZF4bHUCb4tFZLXFqqmmZy1DAO7HVlmZIQO39PRRlHaFGU
	 +2b9qvGprKjDg==
Date: Fri, 27 Feb 2026 10:49:19 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vivian Wang <wangruikang@iscas.ac.cn>,
	Thomas Gleixner <tglx@kernel.org>
Cc: Mark Bloch <mbloch@nvidia.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Brett Creeley <brett.creeley@amd.com>, Han Gao <gaohan@iscas.ac.cn>,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-sound@vger.kernel.org, linux-riscv@lists.infradead.org,
	sophgo@lists.linux.dev, Takashi Iwai <tiwai@suse.de>,
	Maor Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH v4 1/4] PCI/MSI: Conservatively generalize no_64bit_msi
 into msi_addr_mask
Message-ID: <20260227164919.GA3897300@bhelgaas>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9329ae2-721d-4127-9380-b1ea454bd8f2@iscas.ac.cn>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261918-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[nvidia.com,linux.ibm.com,ellerman.id.au,gmail.com,kernel.org,amd.com,ffwll.ch,lunn.ch,davemloft.net,google.com,redhat.com,perex.cz,suse.com,iscas.ac.cn,lists.ozlabs.org,vger.kernel.org,lists.freedesktop.org,lists.infradead.org,lists.linux.dev,suse.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[helgaas@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 975C41BB0DA
X-Rspamd-Action: no action

On Fri, Feb 27, 2026 at 01:25:03PM +0800, Vivian Wang wrote:
> On 2/27/26 02:25, Mark Bloch wrote:
> > On 29/01/2026 3:56, Vivian Wang wrote:
> >> Some PCI devices have PCI_MSI_FLAGS_64BIT in the MSI capability, but
> >> implement less than 64 address bits. This breaks on platforms where such
> >> a device is assigned an MSI address higher than what's reachable.
> >>
> >> Currently, the no_64bit_msi bit is set for these devices, meaning that
> >> only 32-bit MSI addresses are allowed for them. However, on some
> >> platforms the MSI doorbell address is above the 32-bit limit but within
> >> the addressable range of the device.
> >>
> >> As a first step to enabling MSI on those combinations of devices and
> >> platforms, conservatively generalize the single-bit flag no_64bit_msi
> >> into msi_addr_mask. (The name msi_addr_mask is chosen to avoid confusion
> >> with msi_mask.)
> >>
> >> The translation is essentially:
> >>
> >> - no_64bit_msi = 1    ->    msi_addr_mask = DMA_BIT_MASK(32)
> >> - no_64bit_msi = 0    ->    msi_addr_mask = DMA_BIT_MASK(64)
> >> - if (no_64bit_msi)   ->    if (msi_addr_mask < DMA_BIT_MASK(64))
> >>
> > Hey Vivian,
> >
> > We are seeing issues while reloading mlx5 on a PPC64 platform.
> 
> Mea culpa. There's a fix on the list [1] since last Friday. I'm not sure
> why it hasn't moved yet, but please take a look.
> 
> [1]: https://lore.kernel.org/all/20260220070239.1693303-1-nilay@linux.ibm.com/

We needed testing on powerpc and sparc, which has now been done,
thanks to Han Gao (SPARC Enterprise T5220), Nathaniel Roach (SPARC
T5-2), and Venkat Rao Bagalkote (IBM Power System LPAR (pseries)).

It would be ideal to have acks from the powerpc and sparc maintainers,
so I just solicited those.

Thomas merged 386ced19e9a3 ("PCI/MSI: Convert the boolean no_64bit_msi
flag to a DMA address mask"), and could merge the fixes.  Otherwise I
can merge via PCI.

Bjorn

