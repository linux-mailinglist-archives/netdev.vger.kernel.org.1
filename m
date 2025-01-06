Return-Path: <netdev+bounces-155504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5959A0289E
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 15:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F858188292F
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 14:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758D8132103;
	Mon,  6 Jan 2025 14:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WHPspUrx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F66D78F23
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 14:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736175389; cv=none; b=h3qsL9z0pEGYiaSeOWoXvJracA5jdKYBqehcuhOsgB/J/bxkEmiBKX2cUSaYBtVb1qAMs3PbDkM9KXpOtGfuHKMkBZ5u3hwDgnIikLtPwm97oTfpqfRrGdYd0tNsfdTnwoAYz0dlCLekPASbWboR1zNlY4FBXPRK/FwbGqidNUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736175389; c=relaxed/simple;
	bh=Br1f3FaJPQtbxsnom8W2i+mI7A2is8rJOAtpLBKrIxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mkihzix/7iK1DN5KE4NOe5pJsl0lGJiIVrwY+w2rrVl8rZKD+Nf713SXUptR69RppSiPyitzBP0afj4CJ6aVyn1JFhLuNGB7CJInV3CoFIr5NXU4txM0njbVixNZj+rkoQtNdvGa6V9w3k86yKpyWIwFUJ9m6cQyK56K7uVQS8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WHPspUrx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ABB4C4CED2;
	Mon,  6 Jan 2025 14:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736175387;
	bh=Br1f3FaJPQtbxsnom8W2i+mI7A2is8rJOAtpLBKrIxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WHPspUrxepZp6KyM9cmzPZgmg/cwntlpbeUzqtxsfV5HmcXG4/KTbL3VEmlbZBDbM
	 83UShifqaeYd07d1nohyScqGq1g+SsgVOi/waIXWoWWCAEagl7r6uazengajcaiW5v
	 yitCtRXHMtTOx3sricSWajbuobOb8eNrrlh1RrpPYYy42VZ+tXI21jQSVVEf2gOETx
	 my1ncshZV4IhIvPosmrCsumWywM7aUWIsAgblzHMe0qVZhDRSUMQdV7oJfXJ8eoc01
	 iXUZuGLrZulghG2WRbw4gngtgg/No+Pi4QQAHF8xGcHr1gTXHF67nBJq5zYa9gwt+0
	 +1HVKJQKzQN5A==
Date: Mon, 6 Jan 2025 14:56:24 +0000
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] net: hsr: remove one synchronize_rcu() from
 hsr_del_port()
Message-ID: <20250106145624.GB33144@kernel.org>
References: <20250103101148.3594545-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250103101148.3594545-1-edumazet@google.com>

On Fri, Jan 03, 2025 at 10:11:48AM +0000, Eric Dumazet wrote:
> Use kfree_rcu() instead of synchronize_rcu()+kfree().
> 
> This might allow syzbot to fuzz HSR a bit faster...
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


