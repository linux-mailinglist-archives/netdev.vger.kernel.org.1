Return-Path: <netdev+bounces-92317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F718B6894
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 05:27:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 560081F23E9E
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 03:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB589FC01;
	Tue, 30 Apr 2024 03:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I4u6Yxbc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B802810A0D
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 03:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714447636; cv=none; b=gOul2MEPPqmpaF6/eNO5UIhhxchyI+Mm5U3Y9lDws7SKq2hp8raoF1DvOXjX8liBhTfkOuLiCgqM82Kugd4uNLci9EBGKmf7ursTiWOufwvJ7uq6SM87GwKIAb0bXUzPmqS4TMKyDqM3FTkCD8ych/c5VRt7rZdI2ViCAUMlw24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714447636; c=relaxed/simple;
	bh=ayQRvCkXMGW1/jhyibTN+oB6feJlnFRRusHwmKNRN8M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DfmWkLkDyeWfsrUdEjS01ZsYGfwnGVr5s2bQW8ghE7+LqzU3WkfmODUo8pGYthmlZXZj/SB1mlzixhweLXhkeMIkwF/Jzy4ZKPkxANAajJ8p3Lh8xO6gsGCh96OSljQ1UVwqXoShMGcTb+GG7+ym1/rP/yFxkfnvRMxWraHAXv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I4u6Yxbc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F232C4AF19;
	Tue, 30 Apr 2024 03:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714447636;
	bh=ayQRvCkXMGW1/jhyibTN+oB6feJlnFRRusHwmKNRN8M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I4u6YxbccumHWtZx5QqpPKieKPsYctM1lt9lk9uJJnHHn+fDxrnvQreQ6PdRQyq7i
	 qzCSBQ6I6Y/gGvAOcwZA6xnz40/LT4N0pLp792Q+w7PH8IgSCEdBr7LFyjAclB7sKU
	 YtA+g+TiEaanCy3aUo101xKrxm/UgMlJ2bRgz0Fx1gwZ2vBvGer8riSgD8zKDZwrSx
	 nNtUSnuqfJIw187qoe8imLHQ9WN0gLqmYSP27gHrmV/hOWzgnTe8/jeTLZn+GlT2nm
	 SfEZDmFtoSiNPfM74XmloGSpXYRqmXWwZYP1pCzN20hZVKBlf7ul01tdQSs+mei6sm
	 bTUxnq+zvYzEw==
Date: Mon, 29 Apr 2024 20:27:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, jiri@resnulli.us,
 horms@kernel.org
Subject: Re: [PATCH net-next v3 4/6] net: tn40xx: add basic Rx handling
Message-ID: <20240429202713.05a1d8fc@kernel.org>
In-Reply-To: <20240429043827.44407-5-fujita.tomonori@gmail.com>
References: <20240429043827.44407-1-fujita.tomonori@gmail.com>
	<20240429043827.44407-5-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Apr 2024 13:38:25 +0900 FUJITA Tomonori wrote:
> This patch adds basic Rx handling. The Rx logic uses three major data
> structures; two ring buffers with NIC and one database. One ring
> buffer is used to send information to NIC about memory to be stored
> packets to be received. The other is used to get information from NIC
> about received packets. The database is used to keep the information
> about DMA mapping. After a packet arrived, the db is used to pass the
> packet to the network stack.

32b platforms are not on board:

drivers/net/ethernet/tehuti/tn40.c:318:37: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
  318 |                            dm->off, (void *)dm->dma);
      |                                     ^
-- 
pw-bot: cr

