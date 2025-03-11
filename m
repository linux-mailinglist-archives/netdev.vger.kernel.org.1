Return-Path: <netdev+bounces-173811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E622A5BCB1
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 10:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37D441884128
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 09:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9466721D59F;
	Tue, 11 Mar 2025 09:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oPr7H1b1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD081E2606
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 09:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741686595; cv=none; b=KtzyArjzBdvIa5H+wRSbWn2Om7S6NZzq8wi6Jnsv7tn3ZOezeMXrMEmoru068jedXdJN5VmO6tyH+GjcD0GLi5jFiJYZ0jBA52RIpYFw4KfNBOesFdQo1mywLwr1r5wzBEtqEpBabktXJ4BA1yxodx60AFidpbxDBhgDw9WxN/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741686595; c=relaxed/simple;
	bh=GqmEfGqxDUrAu7liYoJCYOj2Iq26VSGJlZ7NXce8qmA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XQ2YBXrMIfGnIRIlgHBXD13FI5OzzgOSaHtMSpBfTHftgE1duc48KMa0BSSpEOOyYf9RDIyDWjokCmJuNkkZTekyB7VjkoY3t+z6zO0fN701259bHPhv82XLlEngQGUpWgoqm7xeQ8au4nAYDlZrVTKH6vtWUGeb3PEI84p+EpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oPr7H1b1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2F49C4CEE9;
	Tue, 11 Mar 2025 09:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741686594;
	bh=GqmEfGqxDUrAu7liYoJCYOj2Iq26VSGJlZ7NXce8qmA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oPr7H1b1IZ0QYs/rM5esZuQmefoNbf0Qzpuqa6A7WARb+IxiYNDiOCyCRRzPnQk47
	 GBG93b1JTOhqpAZ3m3uTaPQCoeYN+Ah9X7uWiIqbl9ncGL1tKHOi8TuVy0b6dM+G1Y
	 DmIfJIKHydXfqV8Wk9LBX3B5Kp2Ht0iQfcd90nSH+ftSpOS7Ifo18R/JsQ+prxefSr
	 xQ2y3cYS3hCwZb1syzH5yLq4VUqkKGHpwUdp3MoUpCWujEU/tOlq2x2Gku/hdg5GK4
	 YwF18ojYTEFEYqs+K7MkvJklrYkChifo767Im+vmXz5lFek7EBUEYaKC2GQjNp7Zdv
	 GGTHcwIN/DC6g==
Date: Tue, 11 Mar 2025 10:49:48 +0100
From: Jakub Kicinski <kuba@kernel.org>
To: Jonathan Lennox <jonathan.lennox42@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Jonathan Lennox
 <jonathan.lennox@8x8.com>, David Ahern <dsahern@kernel.org>,
 netdev@vger.kernel.org, Stephen Hemminger <stephen@networkplumber.org>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>, Pedro Tammela <pctammela@mojatatu.com>
Subject: Re: [PATCH net-next] tc-tests: Update tc police action tests for tc
 buffer size rounding fixes.
Message-ID: <20250311104948.7481a995@kernel.org>
In-Reply-To: <952d6b81-6ca9-428c-8d43-1eb28dc04d59@redhat.com>
References: <2d8adcbe-c379-45c3-9ca9-4f50dbe6a6da@mojatatu.com>
	<20250304193813.3225343-1-jonathan.lennox@8x8.com>
	<952d6b81-6ca9-428c-8d43-1eb28dc04d59@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Mar 2025 10:16:14 +0100 Paolo Abeni wrote:
> AFAICS this fix will break the tests when running all version of
> iproute2 except the upcoming one. I think this is not good enough; you
> should detect the tc tool version and update expected output accordingly.
> 
> If that is not possible, I think it would be better to simply revert the
> TC commit.

Alternatively since it's a regex match, maybe we could accept both?

-        "matchPattern": "action order [0-9]*:  police 0x1 rate 7Mbit burst 1024Kb mtu 2Kb action reclassify",
+        "matchPattern": "action order [0-9]*:  police 0x1 rate 7Mbit burst (1Mb|1024Kb) mtu 2Kb action reclassify",

? Not sure which option is most "correct" from TDC's perspective..

