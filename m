Return-Path: <netdev+bounces-298006-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ep3MJ65xKmq9pQMAu9opvQ
	(envelope-from <netdev+bounces-298006-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 10:28:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3467B66FDA5
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 10:28:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=pdsT4GDz;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298006-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-298006-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1A2E0303ACC7
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 08:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C369837CD31;
	Thu, 11 Jun 2026 08:28:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C8F379988
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 08:28:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781166492; cv=none; b=bZ1TA88807RgGa2by8vZ3M8/vVC+GdSQDpZ5162RA3VLMA9hfmWeRfaqGvemc10ri3u4GYOfsOBv/q122gk3bKZoPklE77lHloWFJ0R9xdj+uuFNI0usRw6kt0BRJriURDJfpRsRMXIdTZb+5YgqTxMEbjE1aDAA+2l0hjc12IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781166492; c=relaxed/simple;
	bh=rKmUIYcqB8L2Ay6obih3SxSR+kj4AtD1Nc4NV19elSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q+ukSR54BoZe2lSq0cw2GMlWFw6dSN9W9sphJkq3+Gn0ipERVbcXx1GHdNAWtQPGKPnAKi3Fh7MUxhGLSOofOf1LzqFdaK2u8G8bZiBPRrzBaM0QwLBo6WJgCCqX74+95kbQLr+H0DDE7EZ/wyis7RIe+QJJo7G+lVdsRI/cIQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pdsT4GDz; arc=none smtp.client-ip=209.85.216.47
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-36baeec21dcso5031373a91.3
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 01:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781166491; x=1781771291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rKmUIYcqB8L2Ay6obih3SxSR+kj4AtD1Nc4NV19elSI=;
        b=pdsT4GDzxHmsIKSDnVKCkT0O/S9mwn1QD/YOb86I9G5oGR1jGTcu/SD6UIwZZR5ig1
         QEmhu5SgiawK4QvwaVZyVrgOEzAoqelR64oBjM5L2e83nSEzQt/BGIVJYIJ5X2b3OuqZ
         bYqK8K+V1tnRASJo/n4aNbm/sXUmEavnTw5K529ttRMEgRU7NK1yy3TYD0JIcSxew5Ho
         QHnd2NLjrN53GJQc9dROpt9to/bNbjCS9sZMNcwZHGMcax0NInbw8yDVqejZ33ER4XS8
         9I1SRsesCFNDYz11tzOEp2utTj10gKEPaDHfehgjcXmobLP50OwvsfTRIledF4itEnVw
         j0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781166491; x=1781771291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rKmUIYcqB8L2Ay6obih3SxSR+kj4AtD1Nc4NV19elSI=;
        b=WavaLiUFCGAygeRKcmjYVuycB4M9ctKf3pDXzhMtKq4O5mqh0KayrQQpwNEPPMTau/
         6QMgBU3PRA7Hu70w7ECjmjlzCVNx9BeRSb0P3d8nS7jgYYEFN/6OZvcyyvys9fQtF9tE
         GtAqXvyxuCS6vKgB9dJDCHCAOFdSKyzoVeDStlq/LJi3ET7NhqYcMOouEPXdYrfWr1jB
         gklG0RxRxSwAVsot+2G6zVMey1HCG+hXQg2LIcv8UUHrNHH237ZZRzfjRwN0rVz+25Cl
         cy7qe5BUHX6EnRhIV4un2XJbLwgZa34AjyRFdeHr/PptZEblLMiyEec8sNkoRnfEoOlK
         R1nA==
X-Gm-Message-State: AOJu0YylMZRniPFC67FMELpNqIk3+/Xm0gpTvxio2c5OpnwFe2uUb+Zc
	dxyAOGL4fCl/gFzEJBvOPMYQ+3E+QieWVAn42QkrSC0vaPP9tmxT03A=
X-Gm-Gg: Acq92OEtnsDoPnJE75GI0VL4aB0xG78/geFm65/E99Smobb3m2i9aqPLDOzgsZGfAra
	sD7goO2hQWfOkYXk3orbnWb2qlk0DmyAxQ1fLURX5vBUMeOFMpaLO+2M9lt87mv6I25RtqpqdkT
	/QfA0Vy3Cwjjy8VZMDifXovKSmsg9iyiweP3siO4hK6LE9/7YyuQWi58LnO6EzPf0HzarWux9B4
	7hH4uRm4rY6n2cs5FNmlI+9m4t5ANToDQhNogRtEIsDpjx+4EESNVfJPKQK49z7FPbWN4HVNKN4
	gvhACuJt2t+Lfkqhcs4FA/N5BpuUDCZC68cOiOC2MA7Bs1zFAaP0KboUmAhi/0P6T16TGa/xfbe
	CtWfGXjOeuhODZoCmUcbLCIqTlEEKKV5uVWzY26O7Cio/bJ1VxG4kJVHWhsOswFLYd2ylPoiJQ2
	OcUsThmnivwIb0Uj14Y1rgnx34CzAx3bCO2ube1tCBVkem2GB+PWOnNbE+vW1Oi051Z7e5z6M5F
	hcv0Q==
X-Received: by 2002:a17:90b:2f06:b0:36b:9835:cf96 with SMTP id 98e67ed59e1d1-3779cb26174mr2267291a91.2.1781166490819;
        Thu, 11 Jun 2026 01:28:10 -0700 (PDT)
Received: from raf.tailb4a862.ts.net ([153.124.163.116])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84337bd0a19sm1341323b3a.21.2026.06.11.01.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 01:28:10 -0700 (PDT)
From: Raf Dickson <rafdog35@gmail.com>
To: leonardi@redhat.com
Cc: netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	pabeni@redhat.com,
	sgarzare@redhat.com,
	stefanha@redhat.com,
	bryan-bt.tan@broadcom.com,
	vishnu.dasa@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH net-next] vsock/vmci: use sk_acceptq_is_full() helper
Date: Thu, 11 Jun 2026 08:27:58 +0000
Message-ID: <20260611082758.580135-1-rafdog35@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <aippcmlliXpO0BXM@leonardi-redhat>
References: <aippcmlliXpO0BXM@leonardi-redhat>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS(0.00)[m:leonardi@redhat.com,m:netdev@vger.kernel.org,m:virtualization@lists.linux.dev,m:pabeni@redhat.com,m:sgarzare@redhat.com,m:stefanha@redhat.com,m:bryan-bt.tan@broadcom.com,m:vishnu.dasa@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rafdog35@gmail.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-298006-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rafdog35@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3467B66FDA5

On Thu, Jun 11, 2026 at 07:58AM, Luigi Leonardi wrote:
> this blank line should be dropped
>
> note: according to patchwork [1] you forgot to CC some maintainers,
> please be more careful next time :)
>
> Reviewed-by: Luigi Leonardi <leonardi@redhat.com>

Thanks for the review! Fixed the blank line and will add the missing
maintainers (horms, edumazet, kuba) in v2. Will send after the 24h
window. Also tried get_maintainer.pl but it kept refusing to recognize
the sparse checkout as a kernel tree -- lesson learned to check
patchwork next time.

Raf

