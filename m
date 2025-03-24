Return-Path: <netdev+bounces-177223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C79FBA6E55C
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 22:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82ED5188EC9D
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 21:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2301DE3D1;
	Mon, 24 Mar 2025 21:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sdN3syan"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA2D1A08A3
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 21:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742850758; cv=none; b=gfjVKqz7ggaUxTyvSbw7sDAsndAs9iBXESZAiL+jlBCmHNI/6RS2w3TynLelrEglnOn37w9zUWfn4Vsg+rPRX1qE1b3rM+SvW2ofxGjWyqaSqu4l3Gow63Dcblp8O2iR5yVlTehpij8hQPnc7fSoNd6wIJgOp9ddZOkvLT6hio0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742850758; c=relaxed/simple;
	bh=NbRA4HsY5TgS8nhqQ2L1MtkIUJ+pVJnCv/CtI152jxI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r/1s8jcOM0h9rm9QHcZuYrs7wG1WxJVS7EMaChgcnt/fEfDIZUZvEj2JwaglsVYKTR7ioZ/wFmmC1gtiVTmYw3LiNyeR+UlWJWiThGLUs05UsdRrWxf/jVOJ8gJJBzjni/qR+l1mdSJpQcR2EmqD4oEGSWARY1OsvrrsB378ifM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sdN3syan; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85E61C4CEDD;
	Mon, 24 Mar 2025 21:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742850757;
	bh=NbRA4HsY5TgS8nhqQ2L1MtkIUJ+pVJnCv/CtI152jxI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sdN3syan/35F4iZPRJCryY/ncGTruaL1IivPr3YKvDCIzYrwdWEuHiSYHgN3+Vpc+
	 KxbEVEwdNQItM5e/6unhmSxa6Xhfo41obm1t8jD7WZIbb47DZO5orgaK5xIS+fisjg
	 QMq6EIwAhUIucYGJa32BxO5Ul15m0vLqTzuxEQPNZ8/hfKRNChd9hwXZh33sAFdcPs
	 V8zuDZKu20tqe6JeW1gWmgXyV9cLVphaIdeIGTx+8E9KvyIE/+nZ5SJuvyG2jjySaM
	 qB4uCLTGun+sWdC7d9X9DlXrNW78HHaF1qdzpdVidsKmb0NURK1lJRoB7JrsZrzn4O
	 SEykaYrOP7fVw==
Date: Mon, 24 Mar 2025 14:12:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com, osk@google.com, Kalesh AP
 <kalesh-anakkur.purayil@broadcom.com>, Somnath Kotur
 <somnath.kotur@broadcom.com>
Subject: Re: [PATCH net 1/2] bnxt_en: Mask the bd_cnt field in the TX BD
 properly
Message-ID: <20250324141229.153b3adf@kernel.org>
In-Reply-To: <20250321211639.3812992-2-michael.chan@broadcom.com>
References: <20250321211639.3812992-1-michael.chan@broadcom.com>
	<20250321211639.3812992-2-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Mar 2025 14:16:38 -0700 Michael Chan wrote:
> The bd_cnt field in the TX BD specifies the total number of BDs for
> the TX packet.  The bd_cnt field has 5 bits and the maximum number
> supported is 32 with the value 0.
> 
> CONFIG_MAX_SKB_FRAGS can be modified and the total number of SKB
> fragments can approach or exceed the maximum supported by the chip.
> Add a macro to properly mask the bd_cnt field so that the value 32
> will be properly masked and set to 0 in the bd_cnd field.
> 
> Without this patch, the out-of-range bd_cnt value will corrupt the
> TX BD and may cause TX timeout.
> 
> The next patch will check for values exceeding 32.

Could you clarify how this patch improves things, exactly?
Patch 2/2 looks like the real fix, silently truncating 
the number of frags does not seem to make anything correct..
-- 
pw-bot: cr

