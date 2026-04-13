Return-Path: <netdev+bounces-278117-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDhxDoMK3WkZZAkAu9opvQ
	(envelope-from <netdev+bounces-278117-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 17:23:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B053EDE10
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 17:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B27A23034643
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 15:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DA53B0AC2;
	Mon, 13 Apr 2026 15:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="AgSbnkVQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j1st82to"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CAC118BBAE
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 15:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776093547; cv=none; b=L+cgPTDUVG4lkYzW48DDxh7YBnxuProC85p5qaQ3aqBDAOJwRPy5apnGwXIqkL0LAVgxjpbhOrp1v+4CfAJgbNsEno1cezP4zt7urk2zSOEMmi4WFaac9xX5MN+o1lwPxkiw3TSiwr9BesxY0eCVt6W/mRz5gtVtz5xgOaBMaLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776093547; c=relaxed/simple;
	bh=lRIbd2puX2Xuc7fn3NAe+LxWkJXncYFfffg0gBzQDG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qs//+elJND3G84uihHvOBMiKJkCKd2USiHu9o0gTQ+ho+nC/vMlwjxl4K5YG4wvn+TVDgJLphACk45uh6UXqg53i3FWcuRzzeZglBgH09pGFEtbXrcIgrEjl66npwW85U0CFCPuqpEv7FBOZwWlFHcDUimW9c5PmW0A+R/pzDcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=AgSbnkVQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j1st82to; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B778614001B2;
	Mon, 13 Apr 2026 11:19:04 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 13 Apr 2026 11:19:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1776093544; x=1776179944; bh=/WqfHvblM1
	y635/VbSb5sAKg1ea+rwbeWWMFPMSkBUY=; b=AgSbnkVQCa0EjDAzYyM3ZforCB
	8rkgy26edPkw4V9MthnkgOY6xq+un+c9Fz8gXdmngPiZsktYBeAJVIVulbgD/BZ/
	p5AfSQmmhB8/qIXEbytrnJx4E0sg8N/IdS1nU+lfQpUB2JnE3mRC5mkQ7UGqVe8P
	XMRr3xrDV50IlUfcZ540zeACR4h28MVhWDSO9TOlZRHllcqi0fipzvideQdhQ2bL
	250JNr/oEcK3GvGC8lhA5iewRGznl5R03aA2KGoVKQnrIUc6+TFUaFdeMnpX+LD1
	r4+HxA99c2/nhT54uaG38mWJS9rEDbMGyf1opcW+pQEtnTYvYV40Zlj5K6Mg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776093544; x=1776179944; bh=/WqfHvblM1y635/VbSb5sAKg1ea+rwbeWWM
	FPMSkBUY=; b=j1st82togRCAgkfHrId8hOhS2KVNvwY0xHaYSOCKXSZRJpCCcXy
	E2d8Cqe3upOSYMwV7NURgDnkILqTy0c06y6C5Y7Z8ZlSSkNQ7lGS8RCIbK+godOd
	lej+BiomS53cB7tkBs0g+eeV/F616YZfL9Fm1BQ2ILTEdZCxWdZw0tR+6f3O6c3q
	XlNvxoNJVh3+opslvggo3E2bCToUwLv3gl2s3WmOfEJhpd+NKO1kSG6G7pzzGh2k
	FpRhDjk+fLzRMSrmIq6tHdZpZ+qEsmsr43gkGg4w26oLGhNyuRpbbjZ2FPYIyLMQ
	/UgK8KHahEq2V8oCyM9aR/XGOhBdj5jkSMw==
X-ME-Sender: <xms:aAndadoDj3jnjSamgHZnz8B8DLEpJZK2rffgI7EhnFK862LRy9ygYA>
    <xme:aAndaVof5kMTarBjGhDcJyRvzHLFgbqQ8A9Dp1S7zM9pg_xGXL94t0R6_tjCdV2HB
    5QONNzSsEUBc01qcRE5qdRQX_UX6kJYoTcsgZNgmklUumSuc9ABvZw>
X-ME-Received: <xmr:aAndaX0rZ9BAv6ON2XlqkNt1HRoZ4KC-lG4G6eMiQLusGlEzl46rGWbOGDZbGq0EkOhY1U8qkfXnbD2Bs2imwhLxsoHHwAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefkeehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefluhgrnhhluhcu
    jfgvrhhrvghrohcuoehjuhgrnhhluhesfhgrshhtmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeeifeekhfeihedtgfeufeeivdelkeektedthfetgffhvdejgefhheduvdeu
    gfevtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hjuhgrnhhluhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegufiesuggrvhhiugifvghirdhukhdprhgtph
    htthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:aAndaUAbFhJUemEKibqyb8YyPPXQGPLJqblknaPxxOekTnopkRGsng>
    <xmx:aAndafeXqxjh2f55yqnyI50BzgiY9eMm3LTTE-8d-OFULpiVzkUF0A>
    <xmx:aAndaZiJ45LPxLoVwffOrgeMixBiVtIejxyiwqF3LAp4MoIbn52amQ>
    <xmx:aAndaXrYNHy-TzAEd4fjKzmcFsPVK6D-ZZ0nfzePKPN5OyqGFll0_A>
    <xmx:aAndaXYsucFFSpSLQf9HihBrlhAC1cCDUgmCv11qQoB1QyMdx0kVGlHS>
Feedback-ID: i80b64ba7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Apr 2026 11:19:04 -0400 (EDT)
Date: Mon, 13 Apr 2026 10:19:03 -0500
From: Juanlu Herrero <juanlu@fastmail.com>
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH 2/5] selftests: net: add multithread client support to
 iou-zcrx
Message-ID: <ad0JU1eb6zsLc3EA@jlhe0197-mac>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278117-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fastmail.com:dkim,fastmail.com:email]
X-Rspamd-Queue-Id: 78B053EDE10
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

Makes sense, will remove from v2.

