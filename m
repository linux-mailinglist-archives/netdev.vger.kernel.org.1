Return-Path: <netdev+bounces-159136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CBC1A147C1
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 02:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACB073A33BD
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 01:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3B61E0B74;
	Fri, 17 Jan 2025 01:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZdOzU2A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822F625A65B;
	Fri, 17 Jan 2025 01:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737078631; cv=none; b=ZHvK351nroUdTCevvysuE59IxEHFY00mXPWASNI5MQba4fKOKAgM+IJ5vNZtd/jYCOs74roJBA9Ciyt9K1bWFh6dKJKKO5xWGYMOKS911HJUxJJ8WqsJsdWZiIZNvYbLzqJ1BqdecDmKtYcyKdEzWyjox7CnEYLzzmDKwNcM9/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737078631; c=relaxed/simple;
	bh=AkCugV0VzgEMbOp/vUPtU1Zs9R+WfThpyZmsINB4OXE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gTEEDTPiixRya943jD60FQmNymU9OeG1ovDGJ5i6eMAS+IAKqIS2j6/jGJPAheOXz4K/l6VV3L8KvUYcKUmVCviO9YZg9Cs7Bp87ei4rnlmACLb7WwbM/YoSWxm9iAtZYR5oMzSLo8/RquuEUsc+I9rvwdfv1qM9Vt4D5G967Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZdOzU2A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C1E5C4CED6;
	Fri, 17 Jan 2025 01:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737078631;
	bh=AkCugV0VzgEMbOp/vUPtU1Zs9R+WfThpyZmsINB4OXE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LZdOzU2AJZCRx8fnSBT0rM6YsQLDUsRIUo5ouDZBns8Hi+IZxEtYZ3fmhF4U56T0E
	 W829kwYDE1O4WZ23tu9wWga7XfIfO5KbCTRiKOvf8M9MENTXxscSeXbgoVeCQUvu8S
	 GeaJeT3Dvd8HaxRUJMT5Tl1z2xsZEYwYUakSFGux6QWVcGNyF0OZ3Gle+TIJ5LQzHX
	 zyjakYEjcpLOeHyRdgw/1cnQdlQo2PW12BgSZCxxQaViuhLlypIPx1UJwH4IMpJR10
	 Bjs2l11F8SsgTR0THjnKGslpCgt6LzGetED7R/7UtpmlRE5xmlPbyb7ugfJNtnLtwh
	 WRqWAcTxEUd0A==
Date: Thu, 16 Jan 2025 17:50:29 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: io-uring@vger.kernel.org, netdev@vger.kernel.org, Jens Axboe
 <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>, Paolo Abeni
 <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jesper Dangaard Brouer <hawk@kernel.org>, David
 Ahern <dsahern@kernel.org>, Mina Almasry <almasrymina@google.com>,
 Stanislav Fomichev <stfomichev@gmail.com>, Joe Damato <jdamato@fastly.com>,
 Pedro Tammela <pctammela@mojatatu.com>
Subject: Re: [PATCH net-next v11 10/21] net: add helpers for setting a
 memory provider on an rx queue
Message-ID: <20250116175029.3cd03d48@kernel.org>
In-Reply-To: <20250116231704.2402455-11-dw@davidwei.uk>
References: <20250116231704.2402455-1-dw@davidwei.uk>
	<20250116231704.2402455-11-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Jan 2025 15:16:52 -0800 David Wei wrote:
> Add helpers that properly prep or remove a memory provider for an rx
> queue then restart the queue.
> 
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> Signed-off-by: David Wei <dw@davidwei.uk>

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

