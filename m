Return-Path: <netdev+bounces-292567-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aAm9K2fgF2rxTggAu9opvQ
	(envelope-from <netdev+bounces-292567-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 08:27:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5745ED46B
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 08:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA04F30015BB
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 06:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074E832C923;
	Thu, 28 May 2026 06:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N/22HH52";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6N+IcKdl"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657BC33121F
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 06:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779949667; cv=none; b=gw5Ng3je7qwY+W8o4YjxxMPQ2h20JHbpx6YiRUserI78YjC02DuLJt41EyJPkV6DYwTd2kND6eNQ+QI1vs+fbae5qwlhZMzW82QWE2k7qxodfocD/MWHYpqh/cNuFoUpVnGSIaIF8r/UAwSUHJ4zK3FvvbyFkp6jgS1Gp4WZRpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779949667; c=relaxed/simple;
	bh=rrIpuPhtFOkBtiPO8Uyy1YE1r7l+QH3qO4N1e8wuBEg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZYq9CquTQmmqyJKWGLHIsJ8BUzj8WXgeYdMvhK1dqK8iOy75xIK/y4bN3Cyce3aujgyp8ebKBTRVAkOu9QVaGf7AoS8WIKKHlmZMyoLcHNpidK0Xg114/TRuuvsd3Rx0rgbfCuecTIvqY5obVEBADMJW+tYgKIvGbyBiYiqwrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N/22HH52; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6N+IcKdl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 28 May 2026 08:27:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779949663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mwOaY4RNQyDX3FN8D+3gMoORx5Ors6iRbe/5nQOLE0g=;
	b=N/22HH523c7G3uFErene4NCyMSRk0DIweaYEWlOeL4O2UGBp1qQGRHJGalLXhXFJtmkN87
	DvqXS4hnozc3RgkAAQXxa3BQVGGoJ4QU/m37I9/Ke/5Z/ld8ibaRNcPJGQt76BmsFXyUUG
	QxB8FpMmG+RyGeNSH/L2DOPrsNOWAkvpUnbFUkD7lBvHC6/xWxgauIBOQxzStAQ2wgifF/
	5Sc/yge7ftXdJTpsSqc3FpbS8hBlERaqLqTaPtYYR513BDNaNhOPfbwOVRzLsBnC//kZjA
	yWf9YGscVLjuA2syvyRESFyhnzuA01MQJPjqP6H9giRNcCT1CEUshwdJGYem9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779949663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mwOaY4RNQyDX3FN8D+3gMoORx5Ors6iRbe/5nQOLE0g=;
	b=6N+IcKdl7y3ZlKSNkTneUwCE0X8A9a3zA79+QpXWtRDin+G0j9kjxIq4qcEQCdYSJF1vPr
	fv51KpPFqAJ6RMBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	Chintan Vankar <c-vankar@ti.com>, Danish Anwar <danishanwar@ti.com>,
	Daolin Qiu <d-qiu@ti.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Felix Maurer <fmaurer@redhat.com>,
	Neelima Muralidharan <neelima@ti.com>,
	Paolo Abeni <pabeni@redhat.com>, Praneeth Bajjuri <praneeth@ti.com>,
	Pratheesh Gangadhar TK <pratheesh@ti.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net-next v5 8/8] selftests: hsr: Add test for the inline
 PTP header on HSR
Message-ID: <20260528062742.453G-OkS@linutronix.de>
References: <20260527-hsr_ptp-v5-0-158a7633eac0@linutronix.de>
 <20260527-hsr_ptp-v5-8-158a7633eac0@linutronix.de>
 <20260527121227.40bf085c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260527121227.40bf085c@kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292567-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,ti.com,davemloft.net,google.com,redhat.com,gmail.com,kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,link_faults.sh:url,linutronix.de:mid,linutronix.de:dkim]
X-Rspamd-Queue-Id: 2B5745ED46B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-05-27 12:12:27 [-0700], Jakub Kicinski wrote:
> On Wed, 27 May 2026 17:08:58 +0200 Sebastian Andrzej Siewior wrote:
> > Requested-by: Felix Maurer <fmaurer@redhat.com>
> 
> Please don't invent tags? If you want to say that Felix asked for this
> just say it in English.

okay.

> > --- a/tools/testing/selftests/net/hsr/Makefile
> > +++ b/tools/testing/selftests/net/hsr/Makefile
> > @@ -7,8 +7,11 @@ TEST_PROGS := \
> >  	hsr_redbox.sh \
> >  	link_faults.sh \
> >  	prp_ping.sh \
> > +	hsr_ptp.sh \
> >  # end of TEST_PROGS
> >  
> >  TEST_FILES += hsr_common.sh
> >  
> > +TEST_GEN_PROGS := hsr_ptp_test
> 
> TEST_GET_FILES otherwise kselftest thinks its a test and tries to run
> it (which of course fails on
> 
> +	if (!slaveA || !slaveB || !hsr_dev) {
> +		fprintf(stderr, "Missing network devices\n");
> +		exit(EXIT_FAILURE);
> +	}
> 
> given there are no arguments passed in)

Oh. I did replace it with TEST_GEN_FILES.

Sebastian

