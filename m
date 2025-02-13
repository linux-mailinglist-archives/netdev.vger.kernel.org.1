Return-Path: <netdev+bounces-165919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 371A8A33B5A
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 10:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1FE01889692
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 09:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E99C20DD5B;
	Thu, 13 Feb 2025 09:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rL0LeyXh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8NdOEr5s"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E81C20CCE3
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 09:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739439571; cv=none; b=G0UelsAeANWpefWcaRAfDmKTY5+MzokPcsxqc3fPNPiqivqq9SCk2oLvS21M4Mwcdb0V0uxzTVkAN2pAyientKV2v8I8XsWDvX2mEy++1lE9a2GgbvPsWED0qK93qerwxeS81wNSAVomJD+4LPqLGniGyEo7RNFrYEJSxQlvgjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739439571; c=relaxed/simple;
	bh=nNd3q68v/HYYjRreAZmGPiasWmVbEA0PgSlNMdUITrk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fFS7M+pQmfT5H2ibyIdqmqWR5R8Khcr3WFGBwDgL2C3NhvBUkszb64KwPYk1qXJGhLjkioVIJj4J3EE3vLnKEHll/nDRi9P7sw8ztOUQKteKFgCkPGqtnePPw8NC3m1cR+TtYLj9O/RVUb40s5b+V7zGBZPdBFrYSyX+k6cAYfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rL0LeyXh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8NdOEr5s; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 13 Feb 2025 10:39:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739439567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=nNd3q68v/HYYjRreAZmGPiasWmVbEA0PgSlNMdUITrk=;
	b=rL0LeyXhsMiKDFT5i9huPe30YKGpxz1XQpG1iZmYIBl4aV8YXl/k/z9aht0IZSTJYj84CT
	GRhoa2idIIKwzDBcWCd/km/+ltJBTY7CrHp5a5BiOhv8JreXkvoEAPUeD5lVXZgfwFT3MN
	E1pFflAGSLK1mW+rPW3KVE+i7qpyvBUr8Wut0uCGrkYKM++eXI7VuDRDuZmWbXTPXnnrse
	Jz4SxpccSRlxpB9da2OMpKAFDCJEiMzSBO2eC6gnK2MZo3BjjcD89icjHt0vf9eDBMuGTS
	WrBToetLkGC8EuO4cr2Rh9eInJJqvg6MoePEKmpojrOc0olPI5XPhFTiKgqDBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739439567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=nNd3q68v/HYYjRreAZmGPiasWmVbEA0PgSlNMdUITrk=;
	b=8NdOEr5si67aWYmwGi3i4cqFNYFgBkmMEwf3C69c1un8/+zc2OKJnHw/z43JFhao4Op4gK
	Z3Va2i3TvUDNoaDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: netdev@vger.kernel.org
Cc: Joe Damato <jdamato@fastly.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [Q] page_pool stats and 32bit architectures.
Message-ID: <20250213093925.x_ggH1aj@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi,

The statistics counter (page_pool_{alloc|recycle}_stats) use u64 and
this_cpu_inc() + regular read.
This is okay on 64bit architectures but on 32bit architectures inc +
read is split into two operations. So the 32bit arch might observe a
wrong value if the lower 32bit part of the counter overflows before the
upper part is updated.
We can ignore this or switch to u64_stats_t.
Suggestions?

Sebastian

