Return-Path: <netdev+bounces-278122-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MVdLNkQ3WkOZQkAu9opvQ
	(envelope-from <netdev+bounces-278122-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 17:50:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F003EE307
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 17:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D5B6C30247E8
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 15:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4F73BAD9F;
	Mon, 13 Apr 2026 15:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="C5Tveq/d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mUnTItxC"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1262333BBC0
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 15:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776095052; cv=none; b=AzSCq+QU3XpvqV19J4KCJWd4gkdn21x9Y+PBWhmjugsBq+zNHzx6+/84lUZHFixeH5fX1bWI2+aNLWFGTdN+cSIbjJ1e8DBRLlU1c57/pPTHA7gvYPhJ4r40uZ3PO6cHrKVHxRZpLVNizA0PEObAv3PzFFf4VTk8ekL0YSARDHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776095052; c=relaxed/simple;
	bh=9EMtwqos+FIiIgC/F3GXYF1cGB/vfxsxJwMIKMhr0LU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fne/BeNld0JVo6aUgBEavDoEe9OPDFjhlKR6m/00azJgoO8o1XLCkR7TUIyYhdMTGUR6JY6mTiZ28mIdyYF9uGJz8Wfccl9dYubtvYpgrptidY5D9iTddYGVCFsogfArWhYZ6EkOqmoPcnuSxl2Q2QupK6UsWq6fwMeNlGEEjcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=C5Tveq/d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mUnTItxC; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 57CA8EC04C8;
	Mon, 13 Apr 2026 11:44:10 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 13 Apr 2026 11:44:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1776095050; x=1776181450; bh=ZHx7TCAl/W
	LLIv8TtRiCidOASw4KzjcYT43W+XCaG6c=; b=C5Tveq/dbRJ4dHRT0uP2vEFMAg
	oRG7zRIUOanlJaQuuy1uh9n8KBAXlNB9A1d8KmQ3f2ojgYO7f/rzJaqHavxNOUfT
	0x3q4OwkmYLI+T55TAoibeSeWuMplU+bsi5azaAZTauQ80RUOSnnaeDS/G4vjIjc
	upYr/UDK0OLGMS3+YdWm2D3znSM8Th4+HxFcrSpRAyIu9DVJBDiOq9O3wmDL+zwx
	aUC1VjL+ZznrinpMtJK1lXTYfduDWO2XLkAP39RwUllQfX9lGmXQ3l91xDOhaO9k
	MqH93a8c+JnMj2pEneMmttfWrCeSWMJ//x29ee8tPGjX++Zh/J/p0zM5Zlzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776095050; x=1776181450; bh=ZHx7TCAl/WLLIv8TtRiCidOASw4KzjcYT43
	W+XCaG6c=; b=mUnTItxCrWfIlbF/NVaZgV8GQBFWCknqrYP3R3cG4NEuTv9C1cr
	rJjf5ueN/5sBweEreiP+OxwlWgBG8rceWHid2Fdk4yff+ihQebIqnk3x7V6gYmJa
	AUZW4b/ewi1nF3iyjPNGMJPHsK7U6Mv+N4nQlf0yWOW/76974WveGCviBc3GQ99q
	z8PnSCHtDpcED/g72mHmrrE8XX9feSrDeadAGAReP4bTL2chcOvRNQxYSksRIt8z
	pCNqgiWSLmzwHiKrJ4tAqQkLFuGlohPwjDGmM6IFUTDNCfeG9Pb75DsYd5j41IXK
	C2V/+62Cl7vGdLHRncfMPE76fv/DdZSPAfA==
X-ME-Sender: <xms:Sg_dacdcjGGCX1GBT5aY3LLi4VIcPeH8SIglsyK0ydB63k1NjNHYig>
    <xme:Sg_daUPqJZYS-kse5jGfMnGRtFEdbG03Y2-WZItAeb6VqxjxhvF-8VNyjKRPaW_GY
    XQXVKvmIQ4vcsEEfgusVmt-zZxgkM3ruAIoKECJEL5LUxqsH8TFRg>
X-ME-Received: <xmr:Sg_dabLmqUIo2K9vyEJWGsNZmpYF8mwYm3xC-bRL4vjR8OFtDOu2v_2tgWxVn7EomFDkoIMAnV79v39M_GSt0DYOssulUsA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefkeeivdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefluhgrnhhluhcu
    jfgvrhhrvghrohcuoehjuhgrnhhluhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeeifeekhfeihedtgfeufeeivdelkeektedthfetgffhvdejgefhheduvdeu
    gfevtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hjuhgrnhhluhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegufiesuggrvhhiugifvghirdhukhdprhgtph
    htthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Sg_dadFujTcSGWXL0_X-bAZneqeeZIUfMXd4DxmZtLWWgq-AX4iZfw>
    <xmx:Sg_dabRyOgmuztJSqhHFVdvc2G_cBQ-tA1qx4UG_XhRYGHNXX_U5PA>
    <xmx:Sg_daRF6eOQJ_Zjx_YBvyZ-DTzrcpUUSnQiuGKIbi0MghU_t5k4VuQ>
    <xmx:Sg_daf_xN6YiNZocrg4GOqVMl_7gjBDle8R6sb08UNUxGhcr-O6nIw>
    <xmx:Sg_daTOMBU8f2KnfYf2M_5VAll28yuwCHxzMCZO5rPJ7U3IAL8rsWbN1>
Feedback-ID: i80b64ba7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Apr 2026 11:44:09 -0400 (EDT)
Date: Mon, 13 Apr 2026 10:44:09 -0500
From: Juanlu Herrero <juanlu@fastmail.com>
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH 2/5] selftests: net: add multithread client support to
 iou-zcrx
Message-ID: <ad0O629ZM3E036Z7@jlhe0197-mac>
References: <20260408163816.2760-1-juanlu@fastmail.com>
 <20260408163816.2760-3-juanlu@fastmail.com>
 <8fa08d73-28a3-4521-bcfb-ec81869c24f3@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8fa08d73-28a3-4521-bcfb-ec81869c24f3@davidwei.uk>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[fastmail.com,none];
	R_DKIM_ALLOW(-0.20)[fastmail.com:s=fm2,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278122-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[fastmail.com:+,messagingengine.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[fastmail.com];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[juanlu@fastmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,fastmail.com:dkim,fastmail.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 32F003EE307
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 09, 2026 at 08:51:11AM -0600, David Wei wrote:
> On 2026-04-08 09:38, Juanlu Herrero wrote:
> > Add pthreads to the iou-zcrx client so that multiple connections can be
> > established simultaneously. Each client thread connects to the server
> > and sends its payload independently.
> > 
> > Introduce struct thread_ctx and the -t option to control the number of
> > threads (default 1), preserving backwards compatibility with existing
> > tests.
> > 
> > Signed-off-by: Juanlu Herrero <juanlu@fastmail.com>
> > ---
> >   .../testing/selftests/drivers/net/hw/Makefile |  2 +-
> >   .../selftests/drivers/net/hw/iou-zcrx.c       | 46 +++++++++++++++++--
> >   2 files changed, 44 insertions(+), 4 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
> > index deeca3f8d080..227adfec706c 100644
> > --- a/tools/testing/selftests/drivers/net/hw/Makefile
> > +++ b/tools/testing/selftests/drivers/net/hw/Makefile
> > @@ -80,5 +80,5 @@ include ../../../net/ynl.mk
> >   include ../../../net/bpf.mk
> >   ifeq ($(HAS_IOURING_ZCRX),y)
> > -$(OUTPUT)/iou-zcrx: LDLIBS += -luring
> > +$(OUTPUT)/iou-zcrx: LDLIBS += -luring -lpthread
> >   endif
> > diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
> > index 334985083f61..de2eea78a5b6 100644
> > --- a/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
> > +++ b/tools/testing/selftests/drivers/net/hw/iou-zcrx.c
> > @@ -4,6 +4,7 @@
> >   #include <error.h>
> >   #include <fcntl.h>
> >   #include <limits.h>
> > +#include <pthread.h>
> >   #include <stdbool.h>
> >   #include <stdint.h>
> >   #include <stdio.h>
> > @@ -85,8 +86,14 @@ static int cfg_send_size = SEND_SIZE;
> >   static struct sockaddr_in6 cfg_addr;
> >   static unsigned int cfg_rx_buf_len;
> >   static bool cfg_dry_run;
> > +static int cfg_num_threads = 1;
> >   static char *payload;
> > +
> > +struct thread_ctx {
> > +	int			thread_id;
> 
> This is set here and in patch 4 but I don't see it being used.

Makes sense, will remove in v2.

