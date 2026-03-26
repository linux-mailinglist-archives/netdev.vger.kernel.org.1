Return-Path: <netdev+bounces-272132-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qHGuKD9fxWlM9wQAu9opvQ
	(envelope-from <netdev+bounces-272132-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 17:30:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 410F5338690
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 17:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 28459308957D
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 16:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A115407589;
	Thu, 26 Mar 2026 16:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WYcdWqzO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0E040823E
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 16:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774542333; cv=none; b=U0Jc6iYMtXWHg7vY1AZg5mBygxKHW7WsfPY7SAw7ekWHrpM3IlJP20UoMBodsz4CQ+8XEGHboM1o1ALAbIpTZE3lkHiS8acEO7KfNGbFsAtkuh9PyxYweh28NN89Um89E2wa4QMntckhzlePNJYiBaBCtdnbiS/OJn/slOL+1vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774542333; c=relaxed/simple;
	bh=OJV4r54TUgZjKJYr0AZBvlSqNRio4vTAjPSQiQmGMkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cA13CesFJmasGr1QhMXIsVAUviOxDbtCtrHP51JwuIRF/VkPKhEoYGH+ZUEQXipjWcHiHigsUlYnjcrSF1k9aRa9ecJQKM2ZjuW/WdGbc3+kre1HzAvvat9kEoojf7TbUXMTrhFdWcwo6Xb+ZjxHqCAwfxhuMKDEnrLugAzU9rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WYcdWqzO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774542328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=brOmXSIgnQFr3Pv0TFj65RZKeuN3RnDr2xC7FmtYMGU=;
	b=WYcdWqzOlW6MYgy1+08nZUs2QEjQ/oaYqm0vKsf53Qzmy+xFBuoK7YSFE3YTtxa6UaLB2Z
	D4CbQZiFMocJXah4GzbPp/2Pr7INZAjIlYZsDXfG3czuJmkiAKIq7Uj/CNuDo8VU3a/qKy
	OAu8CmUFn90nFsocy+L9IiMFmzWPDx4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-189-AN-F8yReMxmgvwHRSDAFyw-1; Thu,
 26 Mar 2026 12:25:25 -0400
X-MC-Unique: AN-F8yReMxmgvwHRSDAFyw-1
X-Mimecast-MFC-AGG-ID: AN-F8yReMxmgvwHRSDAFyw_1774542323
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2973C18005BE;
	Thu, 26 Mar 2026 16:25:23 +0000 (UTC)
Received: from thinkpad (dhcp-64-111.muc.redhat.com [10.32.64.111])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 05C3C1800361;
	Thu, 26 Mar 2026 16:25:19 +0000 (UTC)
Date: Thu, 26 Mar 2026 17:25:16 +0100
From: Felix Maurer <fmaurer@redhat.com>
To: luka.gejak@linux.dev
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org, horms@kernel.org,
	liuhangbin@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v1 0/7] net: hsr: subsystem cleanups and
 modernization
Message-ID: <acVd7J79vqs1Rzaa@thinkpad>
References: <20260324144630.189094-1-luka.gejak@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324144630.189094-1-luka.gejak@linux.dev>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272132-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmaurer@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 410F5338690
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 03:46:23PM +0100, luka.gejak@linux.dev wrote:
> From: Luka Gejak <luka.gejak@linux.dev>
>
> This patch series performs a general cleanup and modernization of the
> HSR(High-availability Seamless Redundancy) protocol driver. Since the
> HSR subsystem is currently orphaned, these changes aim to bring the
> code up to modern kernel standards and improve overall maintainability.

I appreciate that you are working on hsr and want to improve its code
quality. I agree that there is quite some room for improvement here.
However, I have a few general remarks before commenting on the
individual patches:
- Please consider the netdev policy for simple clean-up patches outside
  the context of larger work [1] (esp. patches 5, 6).
- Please attribute the use of AI coding assistants [2].

Thanks,
   Felix


[1]: https://docs.kernel.org/process/maintainer-netdev.html#clean-up-patches
[2]: https://docs.kernel.org/process/coding-assistants.html

> Luka Gejak (7):
>   net: hsr: constify hsr_ops and prp_ops protocol operation structures
>   net: hsr: replace fallthrough comments with fallthrough macro
>   net: hsr: remove unnecessary void function return statement
>   net: hsr: use __func__ instead of hardcoded function name
>   net: hsr: remove unnecessary braces for single statement block
>   net: hsr: add missing blank lines after function declarations
>   net: hsr: use BIT() macro for bit shift constant


