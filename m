Return-Path: <netdev+bounces-280119-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJlVClJ352nf9AEAu9opvQ
	(envelope-from <netdev+bounces-280119-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 15:10:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2B543B271
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 15:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EED8E3096F9F
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 13:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254DE3D6469;
	Tue, 21 Apr 2026 13:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="q87ZlKNF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PVk+tpZm"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B773D565E
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 13:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776776647; cv=none; b=QhFpVYDQOrliNZKpzC8pRr4dU28WhtUCgNyDsIB5z/KrhpLBHpv6MzsxzHRIPFDBHQmhM2SmiZd3pvoH+EXwao8LGzUyIS74EcP03N1nLCxP2zVtJ1Tz3Jk/Nl/4ePxeqRM5VoggATsq2o+y89dWSNZDY4D2aAE0sYcJtbCVUf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776776647; c=relaxed/simple;
	bh=rQ/BRBEsXi0bHqOHBtrs1Jx+3fQW3yP7liPQ4hPHDSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i7gDMK+B+ptR75oFi86h/X+7fLZX72C+osWtXGp92gzz63/QMaAmoKdOdE/fZGeqNM4jsQWwd1gED6HRxi95HZNar7KPYneclRWfGxv4KDPCkGd3xmMwaESI4U42W5C9hk2XFrYCvbtG9uemde0hOV9tQHjaaVd4281aE6l3zkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=q87ZlKNF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PVk+tpZm; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 231F0EC01ED;
	Tue, 21 Apr 2026 09:04:03 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 21 Apr 2026 09:04:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1776776643; x=
	1776863043; bh=6lyv7vM+l0ugpljwjkwCV1PNwvXzdBDgeadIDyXoYZU=; b=q
	87ZlKNFx5iYCUILIJSw6BxGyBHEkNTd0rB77FmDJCiNtrpBcQCwAn59sqQvdZTLA
	BsP+AYCc0JUrxwjQwladEvNA61sjXNkU2zAgzGS8zlKSJf7MJMshmjkNw3Hgfpvd
	WDXuvcJBCYUOz5eDdTapMiMi8YkUC+wRxx7IHmZfjcDxfQ944PklZFqKRGUhqkIu
	0b5XI8d7CYhBIoUsNbir355VwhZuxBzPkFljvwfGw+IUlaqouzSPUxgONTgMfLIM
	XqSI2fH79ae1qCWCue0iLjHiV+dtenmWBJ5pEetP/w98cj4rLfE7IUcfOrXpp4uz
	zClgbb3WCel7dXP1eeh3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776776643; x=1776863043; bh=6lyv7vM+l0ugpljwjkwCV1PNwvXzdBDgead
	IDyXoYZU=; b=PVk+tpZmkFi1xdrOiZT2XvyoFOqI/dFCIUnH9g5mggcj3+S/N96
	bRLKARCi5UkT/EqNLXGNev4v1OecPMCATkgxjG5BSzeBH80mP6LWyGekRn/Ub7p/
	5lgdMLbOurZO/P5tPkXT2QzTDbnc9Q+qsPWvpH6DKpWFDBbo5cEpzg9zNMhghooT
	xKt5kMJIibFR+awbTD9DAEBvUvQylIWAZHUvqytwZfVJSnlv8vlnCXLYKXbga4Q7
	e7LW8CJMinYA23IP8ZkY64zwhH9ZyZ1mNumBV0lt4gasOddy9D9ywDPyZ6fEDqRr
	HjnLvjFG8f6ReUBJd4p+pDGy3WkY4ZVnhQg==
X-ME-Sender: <xms:wnXnaWcn2471R1PauQZj0ESGr8CQRZqOd8J3qS1ZNpvO7YJYgX7iqA>
    <xme:wnXnaWPwPTZbRXSS79Atz7HZ_O4JzqM9NGp8qfBlwSgDNbY48pBMQHvsAcmC7Es4H
    Br-sL7L9SKFqeBKTU1tT2DnxhqUBEnxe7FOostBTEpV0V8X-jgdk5M>
X-ME-Received: <xmr:wnXnaVJC5WcQ1NYuWkVmGYnIUvFrTCNSGxBykTE3x9-SWzCMnOop6NCw_FLa>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeiudegiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpefurggsrhhinhgr
    ucffuhgsrhhotggruceoshgusehquhgvrghshihsnhgrihhlrdhnvghtqeenucggtffrrg
    htthgvrhhnpeeuhffhfffgfffhfeeuiedugedtfefhkeegteehgeehieffgfeuvdeuffef
    gfduffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsugesqhhuvggrshihshhnrghilhdrnhgvthdpnhgspghrtghpthhtohepvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhholhdrghgrjhguohhssehnohhkihgrrd
    gtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:wnXnafExpZ2XaHOTcIyfozPBOY2WlIeuPDXdkZOfhMMtO59vamBxFw>
    <xmx:wnXnaVRHJ3x9S7iZi98SqJN2khlnJ-hToPohjbbGLX7Zqq2pfwiuFA>
    <xmx:wnXnaTHC1l31Vas8Gl-e8_MoOfsNErAbOgCmhWIFhL5brJpu_YFtyg>
    <xmx:wnXnaZ9nqUVlaC0TWzfeUA8ssqrqzy2sf0IC4AOiFWhUD0ZwCaXsag>
    <xmx:w3XnacD-l2U3SnXb6p5QVIZcF_d5QD_eDsqls0hO9vr2MDnKDm_w8v1K>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Apr 2026 09:04:02 -0400 (EDT)
Date: Tue, 21 Apr 2026 15:04:00 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: "Karol Gajdos (Nokia)" <karol.gajdos@nokia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: a bug in drivers/net/macsec.c ? (ssci endianness)
Message-ID: <aed1wCDC2Oh4eZ1h@krikkit>
References: <AS5PR07MB9837EA10B11F76A167FD20A896202@AS5PR07MB9837.eurprd07.prod.outlook.com>
 <VI1PR07MB9850B2C9119357C3B254F83F962C2@VI1PR07MB9850.eurprd07.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <VI1PR07MB9850B2C9119357C3B254F83F962C2@VI1PR07MB9850.eurprd07.prod.outlook.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm3,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[queasysnail.net:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim];
	DMARC_NA(0.00)[queasysnail.net];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-280119-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Queue-Id: 8B2B543B271
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-04-21, 11:37:53 +0000, Karol Gajdos (Nokia) wrote:
> Hi,
> 
> there seems to be a bug in the function filling IV for the XPN case.
> Can you confirm please ?

We expect userspace to provide the SSCI in network byte order via the
netlink API (same as SCI). As long as we're handling it that way
consistently, which I think is the case, there is no bug.

-- 
Sabrina

