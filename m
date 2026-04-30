Return-Path: <netdev+bounces-282951-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8K+oID2J82mS4wEAu9opvQ
	(envelope-from <netdev+bounces-282951-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 18:54:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC1C4A60FF
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 18:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 16ECC3014419
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 16:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F8E34E771;
	Thu, 30 Apr 2026 16:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="H/pXgYit"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02150342CB0;
	Thu, 30 Apr 2026 16:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777567795; cv=none; b=Rpjy1mAOA2VFnY2M1waKOEyWtn8Ba0KrDdv2PBRp5DRrWET3vfo/fkDwfWpAjtX9qrN0Pznsb5nT2KNo4b9ZI4pDRxezKHKLSaYNWRSaVTaLOYhGX5qe3y8N8UkokewsAuTBm5kjER/dVlhAm9I++yrCC0C81KddHoGpgrqNj8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777567795; c=relaxed/simple;
	bh=AZrYJpsI5IZysmnS1mIgID7zFnntH31nIKO+gMHOww8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YJSowX2ULIT0jwVucjbl2n34GMwogv6GCd/J4gykA6s0Y4LeeqvTWrZgJzQZtohRfzt7g9zf7qSOPd6hOXBsYvpirv8dcnkGMWfGvN+4ZTs8WgzU9vFZFz6tnSsFhW9+7TlO95Lk66moJihtT2+pj6TjGhOf9IbrtVYVlzdIJvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=H/pXgYit; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AFACC2BCB3;
	Thu, 30 Apr 2026 16:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777567794;
	bh=AZrYJpsI5IZysmnS1mIgID7zFnntH31nIKO+gMHOww8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H/pXgYitdltpWHo2Y6XpPts4ou8LFVR4GVW2kOySZR+ZFQDztF1a01j4ns4bzwsua
	 g0lKvdQUoWLBzl0gg0zVzX4UfVqw2O3bVRq//unKcveDudJyQO46a9MGtG8/eRLkkW
	 DtPctyXWF39eaUAoN3j8WspR6MfOCllCHZWyPAhQ=
Date: Thu, 30 Apr 2026 18:49:43 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jann Horn <jannh@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>, kasan-dev@googlegroups.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Potapenko <glider@google.com>,
	Valentina Manea <valentina.manea.m@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Hongren Zheng <i@zenithal.me>, linux-usb@vger.kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kcov: refactor common handle ID into
 kcov_common_handle_id
Message-ID: <2026043033-crop-reforest-59f5@gregkh>
References: <20260430-kcov-refactor-common-handle-v1-1-23a0c7a0ba38@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430-kcov-refactor-common-handle-v1-1-23a0c7a0ba38@google.com>
X-Rspamd-Queue-Id: EFC1C4A60FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282951-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_CC(0.00)[google.com,gmail.com,googlegroups.com,linux-foundation.org,kernel.org,linuxfoundation.org,zenithal.me,vger.kernel.org,redhat.com,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email]

On Thu, Apr 30, 2026 at 04:15:33PM +0200, Jann Horn wrote:
> Store common handle IDs in "struct kcov_common_handle_id", which consumes
> no space in non-KCOV builds.
> This cleanup removes #ifdef boilerplate code from subsystems that
> integrate with KCOV (in particular in usbip_common.h and skbuff.h, see the
> diffstat).
> This should also make it easier to add KCOV remote coverage to more
> subsystems in the future.
> 
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
>  drivers/usb/usbip/usbip_common.h | 29 +----------------------------
>  drivers/usb/usbip/vhci_rx.c      |  4 ++--
>  drivers/usb/usbip/vhci_sysfs.c   |  2 +-
>  drivers/vhost/vhost.h            |  2 +-
>  include/linux/kcov.h             | 12 ++++++------
>  include/linux/skbuff.h           | 14 +++-----------
>  include/linux/types.h            |  6 ++++++
>  kernel/kcov.c                    |  6 +++---
>  8 files changed, 23 insertions(+), 52 deletions(-)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

