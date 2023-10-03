Return-Path: <netdev+bounces-37648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 463547B6739
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 13:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id F2BC928159B
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 11:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BEA221100;
	Tue,  3 Oct 2023 11:07:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087E31FBA
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 11:07:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4B01C433C7;
	Tue,  3 Oct 2023 11:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696331274;
	bh=TKTRuzbZsAq7tIREecfAg4xCUdtaJQmSFDV+y5mv320=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NXcJOda5aQVaKB8JPkmr685VZQx3u8jEYb2yWvI+dJrpiHuCs9sMlJbQgZ0sROc0W
	 M5MhlSBxigyQLIISmMrHuRCFPPoZGSXjp4ir9b0VjOTxnpqXdLlzxgG43T0MGL/HD5
	 7MomRAQEbuOvZjDRwVvQHRNDw1cs2eW3hIeogH0TjuQSLYsXOwUGUX5n2klFVdCXbt
	 WNFyobDIxZ32L90aYOeewFD1h2vVx/aym62FAYzNEfQS4LCow243rKaS4UFfj6hKPm
	 ICxrieF2rLJT4UC/gb4uaURo6H99HXknZFkhrODddKmCfl5PdAEpJNvZX7GHJREldT
	 B4COIW97Upuaw==
Date: Tue, 3 Oct 2023 13:07:50 +0200
From: Simon Horman <horms@kernel.org>
To: Xin Long <lucien.xin@gmail.com>
Cc: network dev <netdev@vger.kernel.org>, linux-sctp@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Subject: Re: [PATCH net] sctp: update transport state when processing a
 dupcook packet
Message-ID: <ZRv2BhAVBcR36Ilm@kernel.org>
References: <fd17356abe49713ded425250cc1ae51e9f5846c6.1696172325.git.lucien.xin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd17356abe49713ded425250cc1ae51e9f5846c6.1696172325.git.lucien.xin@gmail.com>

On Sun, Oct 01, 2023 at 10:58:45AM -0400, Xin Long wrote:
> During the 4-way handshake, the transport's state is set to ACTIVE in
> sctp_process_init() when processing INIT_ACK chunk on client or
> COOKIE_ECHO chunk on server.
> 
> In the collision scenario below:
> 
>   192.168.1.2 > 192.168.1.1: sctp (1) [INIT] [init tag: 3922216408]
>     192.168.1.1 > 192.168.1.2: sctp (1) [INIT] [init tag: 144230885]
>     192.168.1.2 > 192.168.1.1: sctp (1) [INIT ACK] [init tag: 3922216408]
>     192.168.1.1 > 192.168.1.2: sctp (1) [COOKIE ECHO]
>     192.168.1.2 > 192.168.1.1: sctp (1) [COOKIE ACK]
>   192.168.1.1 > 192.168.1.2: sctp (1) [INIT ACK] [init tag: 3914796021]
> 
> when processing COOKIE_ECHO on 192.168.1.2, as it's in COOKIE_WAIT state,
> sctp_sf_do_dupcook_b() is called by sctp_sf_do_5_2_4_dupcook() where it
> creates a new association and sets its transport to ACTIVE then updates
> to the old association in sctp_assoc_update().
> 
> However, in sctp_assoc_update(), it will skip the transport update if it
> finds a transport with the same ipaddr already existing in the old asoc,
> and this causes the old asoc's transport state not to move to ACTIVE
> after the handshake.
> 
> This means if DATA retransmission happens at this moment, it won't be able
> to enter PF state because of the check 'transport->state == SCTP_ACTIVE'
> in sctp_do_8_2_transport_strike().
> 
> This patch fixes it by updating the transport in sctp_assoc_update() with
> sctp_assoc_add_peer() where it updates the transport state if there is
> already a transport with the same ipaddr exists in the old asoc.

Hi Xin Long,

I wonder if this warrants a fixes tag, and if so, perhaps:

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")


> Signed-off-by: Xin Long <lucien.xin@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>

