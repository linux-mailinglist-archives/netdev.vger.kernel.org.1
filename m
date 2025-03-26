Return-Path: <netdev+bounces-177792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 803EEA71C0D
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 17:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F4F616CA28
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 16:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FCA51F463C;
	Wed, 26 Mar 2025 16:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQgO1hAO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7391F426F
	for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 16:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743007367; cv=none; b=eicqfpu4cSseOyWLME2mZiyRp3nfS55uEECAbVoS4e6kzyMuxjrtm/BnkvdmmijTk4IvXpXTGyyVo5PKEM/3TwsNa+4J17cWpk6PQxbxAzuIFo8wCEnQeygKU0QcbOj7Z0ZFjaOyxRDfxdolI11DU/EajEsf7DqGRweARz4trg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743007367; c=relaxed/simple;
	bh=0iPdTV36K0a4yHrOAo1Vxyt5AzKv3PHvB/uV5BtwYzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Acy4rGrCjr/AtFiq2ESxbleC+kUoH0zNkmxh87Azs7mugOBAu+5TjttC0WikLwqGaKmIG1TLwInGXF4p/02Annzk/WRBGvSA6rYFbmUVooBH9ve28CwpbDwge0+6UQ4clHHxet0JmLq9NPoZy+u1mfM+CGqurbwiGzZwn3Copfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQgO1hAO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 775B9C4CEE2;
	Wed, 26 Mar 2025 16:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743007366;
	bh=0iPdTV36K0a4yHrOAo1Vxyt5AzKv3PHvB/uV5BtwYzQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XQgO1hAOejkpN3i3F/m3lMPjVrUClDC5jvp4F67YQnPhpe+AILFxscEh7yad3/LF6
	 +jiC2U0+t4N3sa2sYPDVG2/AEdP9p/Psi9KJf3HGV83NG91TJouS8QgUd0V6SUJ7N7
	 QUZ8TgUKyjIS19QIh7eGvDeDC+lY2NTVKyKOTU8cCMASbevxqoH2Uy78JJidFMPTRD
	 5VV/VCU1Ieojf6NYyJ4mnOYzWou1kfOlCN7amg0jzCwHTvC+t8YmInPXdRhZUL3dhy
	 4sTKyhcaJIkUj7ZAWVvBengtPhuRg7CI+Orrsdb6yat0Fwu3gmSdJKjDRTv7kIn9tK
	 lvFLOG9rDAQiA==
Date: Wed, 26 Mar 2025 09:42:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Allison Henderson <allison.henderson@oracle.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH 1/6] net/rds: Avoid queuing superfluous send and recv
 work
Message-ID: <20250326094245.094cef0d@kernel.org>
In-Reply-To: <3b02c34d2a15b4529b384ab91b27e5be0f941130.camel@oracle.com>
References: <20250227042638.82553-1-allison.henderson@oracle.com>
	<20250227042638.82553-2-allison.henderson@oracle.com>
	<20250228161908.3d7c997c@kernel.org>
	<b3f771fbc3cb987cd2bd476b845fdd1f901c7730.camel@oracle.com>
	<20250304164412.24f4f23a@kernel.org>
	<ba0b69633769cd45fccf5715b9be9d869bc802ae.camel@oracle.com>
	<20250306101823.416efa9d@kernel.org>
	<01576402efe6a5a76d895eca367aa01e7f169d3d.camel@oracle.com>
	<20250307185323.74b80549@kernel.org>
	<3b02c34d2a15b4529b384ab91b27e5be0f941130.camel@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Mar 2025 07:50:11 +0000 Allison Henderson wrote:
> Thread A:					Thread B:
> -----------------------------------		-----------------------------------
> 						Calls rds_sendmsg()
> 						   Calls rds_send_xmit()
> 						      Calls rds_cond_queue_send_work()   
> Calls rds_send_worker()					
>   calls rds_clear_queued_send_work_bit()		   
>     clears RDS_SEND_WORK_QUEUED in cp->cp_flags		
>       						         checks RDS_SEND_WORK_QUEUED in cp->cp_flags

But if the two threads run in parallel what prevents this check 
to happen fully before the previous line on the "Thread A" side?

Please take a look at netif_txq_try_stop() for an example of 
a memory-barrier based algo.

>       						         Queues work on on cp->cp_send_w
>     Calls rds_send_xmit()
>        Calls rds_cond_queue_send_work()
>           skips queueing work on cp->cp_send_w

