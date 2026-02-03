Return-Path: <netdev+bounces-256335-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oG6kJGcPgmkKOwMAu9opvQ
	(envelope-from <netdev+bounces-256335-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 16:08:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D09DB151
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 16:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 92F623019F1E
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 15:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 265C130FF27;
	Tue,  3 Feb 2026 15:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a3yqyyBY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36C42147E6
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 15:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770131301; cv=none; b=VYJvvNAijz1pD2QydfQzUDw+4GpT42OZf1zD1Un/NISpiDlynZxSiU+kMtshxsKd5uOYdSCBweapRIg67LLO43kU1FP8BAIAYLffTst5jpYFu8+I/vMPb+2hhLf2fQcU9XzybGZkYLN15Uv4zvV3aUBsf7XneBtggXz6gH/T7MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770131301; c=relaxed/simple;
	bh=qKzgIWKsYKNukmhNk6GnZboTAiTFcNTU+F8OB14+/No=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RgsuYPZ+Lbwox+KYeyMuFQlBrlkmMRmlJv8uI2E/IGyr+QSyndrz+ai/pEPttG+jhmipfpUwsQDjUB0XmGYBqKXVfnONPirHbBMQvo+ZFyPtDWLMtY79tReTbMymBqsS8VSGyWsj3lF4SjvIMmCjmGgxj/nU/oqHuuu3wAgRvPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a3yqyyBY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770131298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MhVT0AmRqqX2Yxr+f/yEtCutN/QRbLaIOLKLa9VB798=;
	b=a3yqyyBYaFvcy2/6scBXonHgFyIv8+7rXBsd64XUmgQy4HKN+T4y3sqvBkeTRApRDQM3Qj
	9+ZRFVoUCNwRRMnfg0bBNXjCsWRJBrElqSK2ikloxeofZTLbE61faBj6gCT8ROyc2R5A+d
	kq1808sr/h4UF/xTR+EmdB5zkJrKGIw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-393-ckfXhc3eOCiRj2dGld9YNA-1; Tue,
 03 Feb 2026 10:08:15 -0500
X-MC-Unique: ckfXhc3eOCiRj2dGld9YNA-1
X-Mimecast-MFC-AGG-ID: ckfXhc3eOCiRj2dGld9YNA_1770131294
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9BCBA18DA5D2;
	Tue,  3 Feb 2026 15:07:57 +0000 (UTC)
Received: from thinkpad (unknown [10.44.34.184])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D071D30001A7;
	Tue,  3 Feb 2026 15:07:53 +0000 (UTC)
Date: Tue, 3 Feb 2026 16:07:50 +0100
From: Felix Maurer <fmaurer@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	jkarrenpalo@gmail.com, tglx@linutronix.de, mingo@kernel.org,
	allison.henderson@oracle.com, petrm@nvidia.com, antonio@openvpn.net
Subject: Re: [PATCH net-next v2 1/9] selftests: hsr: Add ping test for PRP
Message-ID: <aYIPRqJMTRbvkF3s@thinkpad>
References: <20260129110500.l2jOMEYp@linutronix.de>
 <aXthMlr6Hpas1LBt@thinkpad>
 <20260129152149.dKwN1yGM@linutronix.de>
 <aXucj8L-cBUVIYHX@thinkpad>
 <aYCPsDZeJvCrJYRH@thinkpad>
 <20260202155510.C1zpsxnk@linutronix.de>
 <aYHJ9KHdiBEGfjwA@thinkpad>
 <20260203115526._PRE3nvY@linutronix.de>
 <aYHo1uEK2e8Vg4WM@thinkpad>
 <20260203134712.Q1vJp5UQ@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203134712.Q1vJp5UQ@linutronix.de>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256335-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,linutronix.de,oracle.com,nvidia.com,openvpn.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmaurer@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E5D09DB151
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 02:47:12PM +0100, Sebastian Andrzej Siewior wrote:
> On 2026-02-03 13:23:50 [+0100], Felix Maurer wrote:
> > But like you, I'm uncertain what would be the right thing to do and
> > which port should control the MAC for all the others.
>
> At the very least I need the same MAC on both ends for PTP.
> Now that check the spec, 5.2.1.1 "HSR handling of multicast frames",
> bottom below Figure 10, says it sends the frame over frame A and frame B
> oder the ports. The "src-MAC + sequence number" uniquely identify the
> same frame.
> Now I am certain that the two different MACs are wrong. Let deal with
> this later and then decide what to do about the testsuite.

Alright, I lean towards same MAC on both ports as well. But yeah, let's
fix this in the future, including the test suite.

Thanks,
   Felix


