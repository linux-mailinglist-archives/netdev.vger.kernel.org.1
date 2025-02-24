Return-Path: <netdev+bounces-169220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D037A42FEE
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 23:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 067E917AABC
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 22:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD9241FFC7F;
	Mon, 24 Feb 2025 22:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sJN2lbHG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85EB1FC0E0
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 22:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740435666; cv=none; b=YKqwEDE4etItsWlBPJAk4iJaThJGTJDULAC7qCe1buewEVvPBVqE4eIGWCWAs6/dCY06Yn4eTAug39Wh0sp9jZ5dYbDIUIJoBNeWMtEaOCDfd2O//fFYrGAIsCpdOn4HLQiPoI1a1WhYbSKTmeAWzB1nOXfkQrkC9vJc8jMSxQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740435666; c=relaxed/simple;
	bh=vCBtutVOiqBw8zPVXIXZiaY8om9WDbsJ/tcVLA6Nx6g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ojn5cANIT+vLe2OJf8ZzMqDNJ6ALD8043IAEZ5xibuRaNc2pOJ+9vUujRyqQVXB4FUuy3oo3vevAyzztLFGRUPaLe2JHtmC1tKMMv3vAimCkdbqJs4uPFJcIjZB9H5J6sryMTjW8ixrbVFPlkr9v2vXmE5Tla+/WcDfCX57z1FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sJN2lbHG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 138E0C4CED6;
	Mon, 24 Feb 2025 22:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740435665;
	bh=vCBtutVOiqBw8zPVXIXZiaY8om9WDbsJ/tcVLA6Nx6g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sJN2lbHGx5xNFtmm2PNLy9iF+o/DBWaR5ZlXkgOMaGhU+i1j23ErY2B5hwtE0PHVp
	 x/MQWRlShyJwPVHf5nQx6iHLzAEq5Hp+A4nOhJyU4UQKjG1V3TgjIiznzlCWqi1vl6
	 A6X6l9psarWMTWOqPS26szZgEl+I4TXITnQnAsc02wJBl/RKAYFR0/ct+dPVJMjMGt
	 yhZZemiQxsV04roZb56FO7pcolnHQ9Z7V57sh5+xWUH1oDonQCeRMuB3C6l//IMXPn
	 logbQMOfpUYdLIOKppBxyZn/ctp/WzHyFSHVJbvcqlnRAXSRda9aB8aM6QJFJwWye1
	 2f7HoiojvII1g==
Date: Mon, 24 Feb 2025 14:21:04 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, kerneljasonxing@gmail.com, pav@iki.fi,
 gerhard@engleder-embedded.com, vinicius.gomes@intel.com,
 anthony.l.nguyen@intel.com, Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net-next] net: skb: free up one bit in tx_flags
Message-ID: <20250224142104.14f44a27@kernel.org>
In-Reply-To: <20250221035938.2891898-1-willemdebruijn.kernel@gmail.com>
References: <20250221035938.2891898-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Feb 2025 22:58:20 -0500 Willem de Bruijn wrote:
> The linked series wants to add skb tx completion timestamps.
> That needs a bit in skb_shared_info.tx_flags, but all are in use.
> 
> A per-skb bit is only needed for features that are configured on a
> per packet basis. Per socket features can be read from sk->sk_tsflags.
> 
> Per packet tsflags can be set in sendmsg using cmsg, but only those in
> SOF_TIMESTAMPING_TX_RECORD_MASK.
> 
> Per packet tsflags can also be set without cmsg by sandwiching a
> send inbetween two setsockopts:
> 
>     val |= SOF_TIMESTAMPING_$FEATURE;
>     setsockopt(fd, SOL_SOCKET, SO_TIMESTAMPING, &val, sizeof(val));
>     write(fd, buf, sz);
>     val &= ~SOF_TIMESTAMPING_$FEATURE;
>     setsockopt(fd, SOL_SOCKET, SO_TIMESTAMPING, &val, sizeof(val));
> 
> Changing a datapath test from skb_shinfo(skb)->tx_flags to
> skb->sk->sk_tsflags can change behavior in that case, as the tx_flags
> is written before the second setsockopt updates sk_tsflags.
> 
> Therefore, only bits can be reclaimed that cannot be set by cmsg and
> are also highly unlikely to be used to target individual packets
> otherwise.
> 
> Free up the bit currently used for SKBTX_HW_TSTAMP_USE_CYCLES. This
> selects between clock and free running counter source for HW TX
> timestamps. It is probable that all packets of the same socket will
> always use the same source.

This needs a respin, presumably because Jason's series reached net-next
already.
-- 
pw-bot: cr

