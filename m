Return-Path: <netdev+bounces-182547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F25E7A890DC
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 02:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48D281883844
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 00:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397693CF58;
	Tue, 15 Apr 2025 00:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gg782Aq1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146E622EE5
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 00:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744678006; cv=none; b=KYpkHwvUdAWsEvnONFRVVCC2JrjvR3JPkoyflVvW5MEan7kKKKcmcTPaOh4pUwML6PtpHg872o6gS2/PLh5oxrYrcbAnHlV6eHuIjB3H2gzzKB94VqaAkY9s5/7FLfXjkGyXsP4PkfItB2+RKuIgxQymwh966yVvHX6uyZom010=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744678006; c=relaxed/simple;
	bh=AkNw6W7QtoaV+nS/6mx+L3iqATZcU6e9X2zeIQLVlSk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UA1Z1EDyR8nWsHQ1SKGINixKnE9UsVA/9n6FweG8s6mvML1zG+QwOfaNPylidGr3rvEB3NlP7NiTTEzQead4kDGLAcRuM6CTdUNCmCjz5FNDlxoqcBaXTdXk664LwVnqj9EITmFVTxKQbY4nZogvusz/dglYrWAfN9X7wDlGM+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gg782Aq1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67CD6C4CEE2;
	Tue, 15 Apr 2025 00:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744678004;
	bh=AkNw6W7QtoaV+nS/6mx+L3iqATZcU6e9X2zeIQLVlSk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gg782Aq1vCMGd24PbaE9I05W5LhUi1sCO1BSiNo5HoHmNQUwbIcutkSy/pwUmqWR0
	 1M60jDcPAT2Y2qhMq6NxZ3GbcP2H75b17XMYJuaGj0jTKVofy9DYMQPcUVnlkEgWwP
	 /A9hpwb3/lQYHRLFELwyqpRNhRA9Q36wrQSmnvNNktVK1To9aSBYdiNWQrwyLXrdm/
	 OaBqOefjBu59OBg83VE5fkQlvl+lT5BIi6zXPvMPA2OvLiRx4DBXrDyvqx1X422gnP
	 +ksw43tndMWEApfL1Ps2BEzmtCoz7gHPZaE4n/T/jKEdNba9ViVsFiJqQC8NWLELWA
	 6vdA+/ADEfAbw==
Date: Mon, 14 Apr 2025 17:46:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: allison.henderson@oracle.com
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH v2 2/8] net/rds: Introduce a pool of worker threads for
 connection management
Message-ID: <20250414174643.1447bbe7@kernel.org>
In-Reply-To: <20250411180207.450312-3-allison.henderson@oracle.com>
References: <20250411180207.450312-1-allison.henderson@oracle.com>
	<20250411180207.450312-3-allison.henderson@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Apr 2025 11:02:01 -0700 allison.henderson@oracle.com wrote:
> RDS uses a single threaded work queue for connection management. This
> involves creation and deletion of QPs and CQs. On certain HCAs, such
> as CX-3, these operations are para-virtualized and some part of the
> work has to be conducted by the Physical Function (PF) driver.
> 
> In fail-over and fail-back situations, there might be 1000s of
> connections to tear down and re-establish. Hence, expand the number
> work queues.

sparse warnings here (C=1):

net/rds/connection.c:174:55: warning: incorrect type in argument 1 (different base types)
net/rds/connection.c:174:55:    expected unsigned int [usertype] a
net/rds/connection.c:174:55:    got restricted __be32 const
net/rds/connection.c:175:55: warning: incorrect type in argument 2 (different base types)
net/rds/connection.c:175:55:    expected unsigned int [usertype] b
net/rds/connection.c:175:55:    got restricted __be32 const
-- 
pw-bot: cr

