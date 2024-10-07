Return-Path: <netdev+bounces-132900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0A3993B2B
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 01:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 417521C20AF4
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 23:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8357A191F8C;
	Mon,  7 Oct 2024 23:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ql2xxEjU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B03218C93E
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 23:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728343572; cv=none; b=VPwIbKY5Ueuce3wU5KhypZjvkSOCSX22dbzjiJpUH4SATBTLi8PNyuXCg223J/65l9ns1YH1GxgFLTf4LsQ8R0070iHoLfEV2FLm5UaMg3hQgI9oFTiAilFTgfFHpBsB8kTSnezVitDveCr486nzElPUGeFEuiQ+hagL45D1rhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728343572; c=relaxed/simple;
	bh=W9TfgAWLhSryhFx+nTjEVJ7xbp8NIcynnlh7wAVidvc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gXq4nlQDQSSQto0W+EAOl32pyJ5jLKLrUWxAxoELsWiG/bUX+F2nREIiruna11cAHSEg/AktlCkv+KR1+qoHf0YMEIes7fnVHy8t58NLv1WZwyWzJLPAXXG8JtozPxHB0ZXHQESDwJ7kWt8XhBASdOTxdNWGgwCPJNzm9PZQTgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ql2xxEjU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 866D4C4CEC6;
	Mon,  7 Oct 2024 23:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728343571;
	bh=W9TfgAWLhSryhFx+nTjEVJ7xbp8NIcynnlh7wAVidvc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ql2xxEjU0nFqm5BTcRhE7vxO4aPKYv7oQEURCEKecSenLIIJB60Henmnrzpynidmd
	 gIv/0IKoA6RoKp+F/Q/C73kboEbI78+zksGBerqB9DmoLiGT14FGWkv5tbTnH+GMI1
	 FupSrhDxnNZ75bKJ4RCxrAqduO+G0XtEbsLLu49dQDD1BkttUSbFZAZIK/C9PwTP5J
	 EYGoZii1KHaXLRVnAv4jPiVo1x7bA+iSmCWDlCxkXmRTvm7Pu/XTw/Azc4D1HBPwnh
	 dmyMDiGUcPt68ezSaOsH+OI/D4cgmtDkGpljJaE1oKDbrpm5AwduP+YaIKQqgNkh9N
	 pwEmP+l0Ymr/A==
Date: Mon, 7 Oct 2024 16:26:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, David Ahern
 <dsahern@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, Kuniyuki
 Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH v1 net] tcp/dccp: Don't use timer_pending() in
 reqsk_queue_unlink().
Message-ID: <20241007162610.7d9482dc@kernel.org>
In-Reply-To: <20241007141557.14424-1-kuniyu@amazon.com>
References: <20241007141557.14424-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 7 Oct 2024 07:15:57 -0700 Kuniyuki Iwashima wrote:
> Martin KaFai Lau reported use-after-free [0] in reqsk_timer_handler().
> 
>   """
>   We are seeing a use-after-free from a bpf prog attached to
>   trace_tcp_retransmit_synack. The program passes the req->sk to the
>   bpf_sk_storage_get_tracing kernel helper which does check for null
>   before using it.
>   """

I think this crashes a bunch of selftests, example:

https://netdev-3.bots.linux.dev/vmksft-nf-dbg/results/805581/8-nft-queue-sh/stderr
-- 
pw-bot: cr

