Return-Path: <netdev+bounces-168351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFEDBA3EA0A
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 02:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FF6A3BE5B4
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 01:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B067192B74;
	Fri, 21 Feb 2025 01:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CL6zrgea"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCD2156CA;
	Fri, 21 Feb 2025 01:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740101444; cv=none; b=U06xXtSU1Qol2e+7uFNe0Cxl5JMuLcCl+xgzNpMUigUduTn0ukBNfeg2GeBNdmrTXnYbk9CbPXeO7W6A/6GszTVDouacEbNxAJdMMZ5X5l+8hfsQxVfzfDNkPx/wbWLincyoGnxJEV+RWTwSc+uso0taOPvo+4upMgr6/QU8xWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740101444; c=relaxed/simple;
	bh=/8UmgPu2wvkSnDmb6bJOb4aHRER+/nqUBeLBnh7XACs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bZ33zKI4J04UCRNqoyWVGKYJqt1RDI7Jkv6zQrHjV9dcV/qnLQP2gLwhck+WB9NtyM1QCwUgYVBH1aGXFKPaOaxNa+UfF+spllb6QTN74tXB98V5DVqShxAN1UIioHjNBuulciSHjZJb316846MuEvhZ8jvDmSUY6avcSl4CRMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CL6zrgea; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27F94C4CEE3;
	Fri, 21 Feb 2025 01:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740101443;
	bh=/8UmgPu2wvkSnDmb6bJOb4aHRER+/nqUBeLBnh7XACs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CL6zrgeavfP91BB8Ugl1ZT1V+qKiCh3g3gfmsHS9bRYmEsvWGjpf6nW9PEcrPmAB9
	 D+92gL5waawA9e3vyHwkEe1Zc9tJ19Y2IuhKsR2J9TWNDBZGKg3Gy5r2jzuQwcZKIh
	 5tqyZukAKAZ7YRxL8dQoPjC4lGHOFTyA5ssa3x2iKtqmW3aGDzpKHIq3ld6IRnGUl2
	 G4u6SwwTupEqP8g5Q+oUnhOhC8Xy40UAbhtPTnK7e9fS7hQeAotD4Q866Ev0IeW/iX
	 TLxSnAujOF/zGJyzV6ho834EB8oQWJU1wdf0mbIUha85ryFFnVaZ8pZDfSrS/Sxm3b
	 Ui07QwB+Tt/eA==
Date: Thu, 20 Feb 2025 17:30:42 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Marcelo Ricardo
 Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>,
 linux-sctp@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] sctp: Replace zero-length array with flexible
 array member
Message-ID: <20250220173042.3b6384ce@kernel.org>
In-Reply-To: <202502191824.74DAF797@keescook>
References: <20250219112637.4319-1-thorsten.blum@linux.dev>
	<202502191824.74DAF797@keescook>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Feb 2025 18:24:36 -0800 Kees Cook wrote:
> On Wed, Feb 19, 2025 at 12:26:36PM +0100, Thorsten Blum wrote:
> > Replace the deprecated zero-length array with a modern flexible array
> > member in the struct sctp_idatahdr.
> > 
> > Link: https://github.com/KSPP/linux/issues/78
> > Reviewed-by: Kees Cook <kees@kernel.org>
> > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>  
> 
> I assume this will be picked up by netdev. I see 2 sctp patches pending
> on patchwork:
> 
> https://patchwork.kernel.org/project/netdevbpf/list/?series=&submitter=&state=&q=sctp&archive=&delegate=

TIL patchwork supports q= 
Thanks! :)

