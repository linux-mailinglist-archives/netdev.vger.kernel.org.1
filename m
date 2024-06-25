Return-Path: <netdev+bounces-106542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D51916B4C
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 16:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EE3728783D
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 14:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8242716EBF4;
	Tue, 25 Jun 2024 14:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLqagAG5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E86116D9D7
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 14:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719327437; cv=none; b=JBMUJJKOZVSVpocT1wpZHF0JZGJROB1oVhCN6xI+ze2MIVAAXqBjuSe9i+YaLeHWf9FPSh4rF6biC8V9HXyq1xCyMIqFc8NG85nUiluDcvqPAIRkF6D96P8GDLqKYr/hpR1ywOT42+HIIF364QK/xJ41XYk5VgCC8oY5FWdgl2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719327437; c=relaxed/simple;
	bh=bKLkhsm5JmoxqjsT4TINkwVU3YXLUeihI0TcK0v+Mfg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PRj8Tw8HZTT1fnQ3uxTUJQnztaBNdT4NxODIKhuKuk3khDfLDFjm/U4rjU9ILRYAhAubwhu62lh6uwXE89e8zkT1VJheURtvLtiIkauSefHRn4FxZHbjilezBr9WTV2ikqKoorEu9qpRkxQsjjmtCSTqtlBbH44p2Rkqc9iVNMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLqagAG5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C25FFC32781;
	Tue, 25 Jun 2024 14:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719327436;
	bh=bKLkhsm5JmoxqjsT4TINkwVU3YXLUeihI0TcK0v+Mfg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jLqagAG5d7QTeMpz0upznbOge/R28hOioed9yLVlQsUylbYAnkyadznmG+ISI75MO
	 wzxwlhf2zu/Jp0TeBClP7zE0o3tnUdyL0Vv/DQ41sz4/aBq8YBVsQqf1s79GY3KvEH
	 1j9Xl+semso8JqXIbWt6tlfyXtekkZMXOAP53GRsHQBxXC8618n5aibzNfGLic88JQ
	 7exdBHIF3CLTQjW5OpjMa9M7RS2x2UOSpoiiCTzcWLj3qa0YXDHaw1Pl7xKaFVfaFT
	 DOXP9T0kJ+VEBxSd1Xm5pObwNAMNeQaTNzyqva0osFuxYc3TPO6VJ/gMcVL9HrGJ4V
	 3O+Z6b2itKXdQ==
Date: Tue, 25 Jun 2024 07:57:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michio Honda <micchie.gml@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next] tls: support send/recv queue read in the
 repair mode
Message-ID: <20240625075715.3f61ab48@kernel.org>
In-Reply-To: <CA+Sc9E2oKba+C2EhBvmyJQ5wVS5=S=ZVzP+Gt_-xsRNtMCm4tQ@mail.gmail.com>
References: <CA+Sc9E2oKba+C2EhBvmyJQ5wVS5=S=ZVzP+Gt_-xsRNtMCm4tQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Jun 2024 12:05:45 +0100 Michio Honda wrote:
> TCP REPAIR needs to read the data in the send or receive queue.
> This patch forwards those to TCP.

TLS doesn't support repair mode. Life is hard enough.
-- 
pw-bot: reject

