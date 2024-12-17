Return-Path: <netdev+bounces-152705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 421D89F5795
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 21:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DE4216E1B4
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 20:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 123381F9416;
	Tue, 17 Dec 2024 20:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NiO/Pjvu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31DC14885B;
	Tue, 17 Dec 2024 20:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734467104; cv=none; b=Ci4ysOPb4kaLk928w+O4OhVG+AB3eBpRLB7L/9DRSTBJsHE9iLfqjDXuFJAGxhpLUkvAT7kEUQtvbbnbJtUH1isgeVzoBp+Rbk3/jvj/x8ICE0CiG45Pfdyml2q/kdx6rZD5hbxisFu3DmbyLSfKZrPmW1wLeqsAVZUFNqTVQ/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734467104; c=relaxed/simple;
	bh=Maiyc6QF7xPjVR/GvWmkIlFnB5azzCmzgzErzNX0Odk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XAiblktS+mBygjwT8+Ho9gnqCNpMDB83bJQFkcvMCy+HyfzlUmsDsKUVpBp9CxwDsLP7vMOfPBA2/7cWXKmvCjk95F6KDZx6+Q8znmLUv3Yv3ZcUHRnRRLbQMjsoF7yruUC1R3kv/nClk+TaQw4O/h18SoAQmR4RvLCUpIfzejQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NiO/Pjvu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C3D4C4CED3;
	Tue, 17 Dec 2024 20:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734467104;
	bh=Maiyc6QF7xPjVR/GvWmkIlFnB5azzCmzgzErzNX0Odk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NiO/PjvuLZCXCjT+n+Jwff8N7u2Dp9GcRYMMAkR5oopgvUny7vHFlSUcxqLc3RW+P
	 C5fU8PFL+aUuONctTnIFM1Nhsc7Lc36Ssg7NGIIvdnr2Dpi8rnZ03k/yVGHgb87zqz
	 RB/pzUXmv7C3mFIL/yFyxszLHf6bc5RrrvNbKkFxB9TIWxOw9hN8pcoxt92hHIsB1w
	 gBdiAT3EVlI3QVWecR89bLA1qmJVmJudSucSLnIn72JLILBRWMpJbYnjiP0JxWbtx/
	 Wsqa2a0rtGCQH9d+reLDT01FtqZ1hFVSwh44EdUI88p1abKjsy5k0Fo2TMdiCIE6cs
	 uMwx/4k6G8gww==
Date: Tue, 17 Dec 2024 12:25:00 -0800
From: Kees Cook <kees@kernel.org>
To: Christopher Ferris <cferris@google.com>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] UAPI: net/sched: Open-code __struct_group() in flex
 struct tc_u32_sel
Message-ID: <202412171223.FDDEA0A2@keescook>
References: <20241217025950.work.601-kees@kernel.org>
 <f4947447-aa66-470c-a48d-06ed77be58da@intel.com>
 <bbed49c7-56c0-4642-afec-e47b14425f76@embeddedor.com>
 <c49d316d-ce8f-43d4-8116-80c760e38a6b@intel.com>
 <ff680866-b81f-48c1-8a59-1107b4ce14ff@embeddedor.com>
 <b9a20b9e-c871-451d-8b16-0704eec27329@intel.com>
 <49add42f-42d9-4f34-b4ad-cff31e473f40@embeddedor.com>
 <CANtHk4nhH9XJi5+9BAu3kFoL14+4YAZTH7t6QApEvEAeMxdXgw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANtHk4nhH9XJi5+9BAu3kFoL14+4YAZTH7t6QApEvEAeMxdXgw@mail.gmail.com>

On Tue, Dec 17, 2024 at 11:10:41AM -0800, Christopher Ferris wrote:
> I verified that this does fix the compilation problem on Android. Thanks
> for working on this.

Thanks! Yeah, let's use Alexander's solution instead of my proposed patch.

> > [0]
> > https://github.com/alobakin/linux/commit/2a065c7bae821f5fa85fff6f97fbbd460f4aa0f3

-Kees

-- 
Kees Cook

