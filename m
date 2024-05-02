Return-Path: <netdev+bounces-93037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BE0D8B9C70
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 16:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26D77283A96
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 14:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36B1153565;
	Thu,  2 May 2024 14:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNEdlm16"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E298153562
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 14:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714660589; cv=none; b=Qr/A8L+40OipJGnFRcZR+D2z5iAlumDfAsK9BVY8y8kgdrpz7Gepz/15GWevTTK32wqQP7GNpSuxA+xEIwy7q2FKepeu50p0dq8Scn+eLHWoLRlVmS+enwsMEgCZRaB4bWWnZo6sEoTnjFbjcprHKt+tSCuwpUffzEhtbqgNC3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714660589; c=relaxed/simple;
	bh=HKwVtU8PcGZ9Atf+g2hzi753dwQnyBgYbIm5Uz+Ikhs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jds4/ki7wpF5XpptI67GGov6MxiZlnN6Bycevp9jZJUL+9Co0PLd/d8T9F6eweWyv56aIwBPFaaWkNZfNtlaFVhXaFhKhPWHxBSZ7+VCprjY92CuWjnFjufVukjQ4ZkO3iFz50+7JkayEayKDJsf92pzn24WCAOBtT0GOHTbfJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YNEdlm16; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C40AFC4AF48;
	Thu,  2 May 2024 14:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714660589;
	bh=HKwVtU8PcGZ9Atf+g2hzi753dwQnyBgYbIm5Uz+Ikhs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YNEdlm16ov2GhzW3uQijvzo3DUq13cETfRB3Sti4rmEHmMdrZOw8Coo+ASnfw5DkM
	 uOHYNDKgBZlMAIc0s02gL8LRIClfzpa6WwVxSxyzt7hZJfCnUnTWOK3ADmtOmW8tul
	 aAxhPouj30V0WrLHltF/gAOtTnAsgqdvzSqe75+ZAzDBJpfohMxuBbrj7felkE81za
	 Wn+qJZyGCOHX1YOT/xmNGDSPj361/agbsR4vYtt3bicIntO9c73MygnNI6+Am34Xhg
	 4mJLRfiNfkj/TD8D1sncfkbNWmpkOBNoHVjY9it0yKxYm1ZTWlzugOQRya878GKq9c
	 hmtsMdo4WT9qA==
Date: Thu, 2 May 2024 07:36:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew.gospodarek@broadcom.com, Kalesh AP
 <kalesh-anakkur.purayil@broadcom.com>, Selvin Thyparampil Xavier
 <selvin.xavier@broadcom.com>, Vikas Gupta <vikas.gupta@broadcom.com>, Pavan
 Chebbi <pavan.chebbi@broadcom.com>
Subject: Re: [PATCH net-next v2 5/6] bnxt_en: Optimize recovery path ULP
 locking in the driver
Message-ID: <20240502073627.379d5fd5@kernel.org>
In-Reply-To: <20240501003056.100607-6-michael.chan@broadcom.com>
References: <20240501003056.100607-1-michael.chan@broadcom.com>
	<20240501003056.100607-6-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Apr 2024 17:30:55 -0700 Michael Chan wrote:
> Rely on the new en_dev_lock mutex instead for ULP_STOP and
> ULP_START.  For the most part, we move the ULP_STOP call before
> we take the RTNL lock and move the ULP_START after RTNL unlock.
> Note that SRIOV re-enablement must be done after ULP_START
> or RoCE on the VFs will not resume properly after reset.

The SRIOV locking looks quite questionable, but it seems to be
an existing problem.

