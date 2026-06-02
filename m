Return-Path: <netdev+bounces-294361-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QvCFFhYpH2oniQAAu9opvQ
	(envelope-from <netdev+bounces-294361-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 21:03:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB35631468
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 21:03:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=HEEd3VwM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294361-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-294361-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4409B30298E7
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 19:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51253A453B;
	Tue,  2 Jun 2026 19:03:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF173A542F
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 19:03:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780427017; cv=none; b=l9LANnQUE9H3SJgM2k6TZ6JE8MPi0FvquWT15duRCk70h2fu6jQTe8O15pqBUv3+uhwF/PdXqW8ig8R7wo9/uE58m9Ua+UD4TuFPDRQMDS51i3OE2Q/qPXnu0eC01OkOLPdMD4ZtXELBnW7BJjQW/0JopAeQg1B1wkVc1ApRDn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780427017; c=relaxed/simple;
	bh=cYlfNW7XzyH6xBDOdLScxyRx9aBQ8gBtony+PSxywmY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bUTUBIexTsTFU6JSfZOgS1a0JyiC70NaJTDKqTAfwsldNP4dKS3Z5+E11SWSjxADVYC1U3pTI7cdSxD2wIJgAZrabB4/MuxzNs3SHganqhVzRNw5VqV4fTvuK2XRaoXUAq6aQL9+UcysRpThCSb1/nZQz+MXFUyRyhqD4FG48X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HEEd3VwM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3047A1F00899;
	Tue,  2 Jun 2026 19:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780427016;
	bh=WkBxYL/1WCijcAl7FpxfTWqyyCe4SUimT2QqCh/7RNU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HEEd3VwMncO8OxIUAkA19YZSCWwklI5YGAr/XuyXxmmv2Q5QA1M1yibnokURIXPTL
	 e+YCeDlWfiPzykgadk9P+DhuhxgQE4qQA699of+fzMhBGgj/MEIh5Yn128EGqSwEME
	 eFEPlKRbGtrYkiGVa3FgQc+sunqM1zg/+gVVyjfTIxvj/s3ZHt9tc6dwf+DkmMeuWz
	 O3ntJeNHBAkfkhUqaOSyvpmtdkNSdRUzPGfBhl1Y7xgo6lLZ49JoHwGjYpMVe5E34p
	 ZVtOZ5JIB9HKDpzSvLMa1Ldw4Y1H7MWWPbcuJknDMexbpMtowad7YgJhSjIIGPZ4TL
	 1lIGrcjxwWdVQ==
Date: Tue, 2 Jun 2026 12:03:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Caio Morais <caiomorais@usp.br>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] mpls: refactor mpls_dev_notify() to use guard(mutex)
Message-ID: <20260602120335.715c19b7@kernel.org>
In-Reply-To: <20260601143827.3087733-1-caiomorais@usp.br>
References: <20260601143827.3087733-1-caiomorais@usp.br>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-294361-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:caiomorais@usp.br,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ECB35631468

On Mon,  1 Jun 2026 11:38:23 -0300 Caio Morais wrote:
> Replace explicit mutex_lock() and mutex_unlock() calls with the
> guard(mutex) auto-cleanup helper from <linux/cleanup.h>. 

Quoting documentation:

  Using device-managed and cleanup.h constructs
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  
  Netdev remains skeptical about promises of all "auto-cleanup" APIs,
  including even ``devm_`` helpers, historically. They are not the preferred
  style of implementation, merely an acceptable one.
  
  Use of ``guard()`` is discouraged within any function longer than 20 lines,
  ``scoped_guard()`` is considered more readable. Using normal lock/unlock is
  still (weakly) preferred.
  
  Low level cleanup constructs (such as ``__free()``) can be used when building
  APIs and helpers, especially scoped iterators. However, direct use of
  ``__free()`` within networking core and drivers is discouraged.
  Similar guidance applies to declaring variables mid-function.
  
See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#using-device-managed-and-cleanup-h-constructs


In general please don't send us arbitrary code cleanup patches
if you're not actively working on real changes to the code.
-- 
pw-bot: reject

