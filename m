Return-Path: <netdev+bounces-177134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DA0A6E034
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 17:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A9F516B9CB
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 16:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60254261586;
	Mon, 24 Mar 2025 16:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/0jvbJJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4AD3FBA7
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 16:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742835084; cv=none; b=A0ok4w8opdp66Awlq3cuuxHw89LVTHcemH8N0ChjNAeA4QBBLmdpYDdc8cDkTWSk9sXNu3+fZkHM+8pcW0JnK33M1tijpMVv4rAkwNx1761xccsH79gNmRt0rIBuLCV1YhCz5UsERER0r6XvZ95dPdKXttkJnwPAfEUkEkFNIaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742835084; c=relaxed/simple;
	bh=56Ij+6bwVD9kNC69L36fdex+ZlOWDZw5Y0masezcW3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gl58vsLyr6FyTvvOKokXxSJVuCfYi6THp+iol4lh3CcuoptAits2D0Jn8D6Tnznyv43DA2iYE0R6s1VXoy0A4KiKiyydMtNztJKw/Yo9tDadTlMoA1VQf6xUHkkN8kJcTzTZ/oj3M25pmCOdnx/Ioj0NxRaD1pWX0YrVYqwMNME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i/0jvbJJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66720C4CEDD;
	Mon, 24 Mar 2025 16:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742835083;
	bh=56Ij+6bwVD9kNC69L36fdex+ZlOWDZw5Y0masezcW3Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i/0jvbJJ9bGvQpoM5BtZpR0cDseiGnZKp5JOZ2LjaOUCvmSokB9sn271/HX4rIsoC
	 H4v/TfBqsZQjGpC42h9Qc4CsRvbaFmU5bObE3R0jZYfV+EIiAqEMe4x3DB5bSn6tHk
	 5HcaPTm2IILnRtgfRzWtz5hddyi4hMCffA4UxZIkWxrVS8avdE8Reep8oA3CHMJ1UQ
	 MJjViPKiiyxfinsWRGyGrvQsYjjbdNp47qmFBJZmhzy6wzjHwgwgrAYl2rfbGNOg/7
	 qvC/bS2Kn4s1PIvdhnn5ApT4Sr1UANZ8q4VIEqsGqr6RMKnXUwb+RswkIiXDZgf4kG
	 D4Z7+IzdlFkeg==
Date: Mon, 24 Mar 2025 16:51:18 +0000
From: Simon Horman <horms@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com,
	osk@google.com, Somnath Kotur <somnath.kotur@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [PATCH net 2/2] bnxt_en: Linearize TX SKB if the fragments
 exceed the max
Message-ID: <20250324165118.GH892515@horms.kernel.org>
References: <20250321211639.3812992-1-michael.chan@broadcom.com>
 <20250321211639.3812992-3-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250321211639.3812992-3-michael.chan@broadcom.com>

On Fri, Mar 21, 2025 at 02:16:39PM -0700, Michael Chan wrote:
> If skb_shinfo(skb)->nr_frags excceds what the chip can support,
> linearize the SKB and warn once to let the user know.
> net.core.max_skb_frags can be lowered, for example, to avoid the
> issue.
> 
> Fixes: 3948b05950fd ("net: introduce a config option to tweak MAX_SKB_FRAGS")
> Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
> Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>

Reviewed-by: Simon Horman <horms@kernel.org>


