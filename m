Return-Path: <netdev+bounces-146902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D93799D6A8B
	for <lists+netdev@lfdr.de>; Sat, 23 Nov 2024 18:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52471B20B00
	for <lists+netdev@lfdr.de>; Sat, 23 Nov 2024 17:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF128182C5;
	Sat, 23 Nov 2024 17:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HHTi3tde"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AD95195
	for <netdev@vger.kernel.org>; Sat, 23 Nov 2024 17:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732382503; cv=none; b=iOYVDzlnYwkFPvHSuWwh9tULRVWMV9tCGhIHlLUIIHinPvoOxUqR8bWHJD9NtOEAC5XnWELTDnPcnE3VrnX9vjpn3Zrpnl0EgDanreBqjMhxtzxREn9UpR9AsOVaavw0IYn0uC4xgKYrYL0HMMjP4l79warYrNTu0yqePeeRKyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732382503; c=relaxed/simple;
	bh=EAVZseCiear/KPBSNqnlt+XrP1Tlz/L67gdiaITeUqM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=berIWoCgptPi7Vpj62kXEZwpM3UnJBJdIXEU4ZBSflogvfIilFqnZhTWYBjtIvEk/sq82/oYaVMCWwtQ+hlC20eGDk2xQ6bVZSqXx/w0+LPNYBjYwo0Utw68e45r7X5bF+nR8WQlHdQqnUjMGzRHTLzJZLdwHvbzR5sRgYJTdiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HHTi3tde; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sat, 23 Nov 2024 12:21:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732382496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=EAVZseCiear/KPBSNqnlt+XrP1Tlz/L67gdiaITeUqM=;
	b=HHTi3tdepvwQHZXVUHZ6tM2P9H/Yv8GnUHj52rFt1SEBtHied5H/WFHZka3OA+ItWZLOQH
	u4OeTrF18MTUY3VaZ7w55c2oF8a0M/2nplUuCLWqRm4KUPNNIKhePVGppX09J7bV+HRdL/
	t9k03MHy5QmPr/EYdWA2mGWiekSCzyc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Thomas Graf <tgraf@suug.ch>, Herbert Xu <herbert@gondor.apana.org.au>
Cc: netdev@vger.kernel.org
Subject: rhashtable issue - -EBUSY
Message-ID: <i3vf5e63aqbfvoywuftt7h3qd4abdzomdeuvp3ygmzgza4xjdt@qx36kyyxxkfi>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT

I'm seeing an issue where rhashtable inserts sporadically return -EBUSY,
thrown from rhashtable_insert_rehash() when there's already a rehash in
progress, i.e. rehashes aren't keeping up.

This looks like a clear bug, the -EBUSY isn't handled at all, nor is it
documented, and inserts shouldn't randomly fail.

Looking through the history it's hard to tell what the intention of the
code is...

