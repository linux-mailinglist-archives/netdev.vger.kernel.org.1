Return-Path: <netdev+bounces-231024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 02593BF4015
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 01:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AC7EE4E8728
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 23:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFCD2F60CA;
	Mon, 20 Oct 2025 23:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1YMBSQK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736352DEA67;
	Mon, 20 Oct 2025 23:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761002367; cv=none; b=qgNy0X2mEBFxdUd/y+INWGXFdUg1DCSeW/f7+TtGhU6m08WUJgUGEVG8XDB3yDhNRv+KswmLaYZMigFlQMdNzn9/bnG3fIvRaqXaL3RYSLHInWAFDmFaBS7oKgkM2iOrDf0oohAIwJArxgiPfMuPfnrRei2AVMgcDM07xqWGyyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761002367; c=relaxed/simple;
	bh=47iUVnVTA5ZGhV3twmEBR28xX7HOCLjv7lUlTiBUNfo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cyyizrKvxVN/CEPYOW8C80zvkd+MNAra+Ivmmi1YiJHprT1qElftMXy5PeleTdhAYXcS6bxncPixD/wJLVIcH9EEmryM05UYib0Pmy+NyjAaNPqP5jQ4DxAIFjNzmjxCy2+7KSPACiogkXS9EaXxMVzE0P2AyUfYh1mR94X1OTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I1YMBSQK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F4E1C4CEFB;
	Mon, 20 Oct 2025 23:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761002367;
	bh=47iUVnVTA5ZGhV3twmEBR28xX7HOCLjv7lUlTiBUNfo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I1YMBSQKftGZVXV1Sqd0JcFYZW6BVdruLcuffOAQ8dXFAIAOz8LH61S6oSZVyxqsW
	 J7qthJ+dHU8iKlLeZxc/DPLm6VrPTyZc92FlD1NA5EyIpmp3crmUDOe3Bm1bcAwU2J
	 qCKWZD1WV/kpemIwLvreL31jRP2p0w/hnGjPFQukmU7MEk87/EiObSytqqd+5AYrlv
	 ZQ7NnX9ZU1SvW9lGiN1jvBcf8Y3q2FiQhA/z+b7S7n69wBo2p/ho9zfKYoBBv4qa9t
	 Qefo4098d99y7AUcOa6rGB1xYswb6QKCNkB+aw+zhqx4qTwmzNFdN3aHNP85FNChHv
	 Wvbk41/R/y22A==
Date: Mon, 20 Oct 2025 16:19:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Zahari Doychev <zahari.doychev@linux.com>
Cc: donald.hunter@gmail.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, jacob.e.keller@intel.com,
 ast@fiberby.net, matttbe@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, johannes@sipsolutions.net
Subject: Re: [PATCH 3/4] tools: ynl: call nested attribute free function for
 indexed arrays
Message-ID: <20251020161925.0eea67e5@kernel.org>
In-Reply-To: <20251018151737.365485-4-zahari.doychev@linux.com>
References: <20251018151737.365485-1-zahari.doychev@linux.com>
	<20251018151737.365485-4-zahari.doychev@linux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 18 Oct 2025 17:17:36 +0200 Zahari Doychev wrote:
> When freeing indexed arrays, the corresponding free function should
> be called for each entry of the indexed array. For example, for
> for 'struct tc_act_attrs' 'tc_act_attrs_free(...)' needs to be called
> for each entry.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

