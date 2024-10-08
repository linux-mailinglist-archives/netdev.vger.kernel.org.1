Return-Path: <netdev+bounces-133117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC28C994ED8
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 15:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E364D1C255C8
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 13:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D9D1DF726;
	Tue,  8 Oct 2024 13:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pTbQpztb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDA81DEFE0;
	Tue,  8 Oct 2024 13:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728393683; cv=none; b=OKzpSk/a1BOXHbCh9+oIO8pPAJZ8DKwbj8YbSHS24W8tVMO0i8UP14gzfL5bpAZV2UaFyjS3mmWXJcKFKIGZFjOvC3JlOhsUyI4CINd68vaXWLjbPIGaSBXJ7XriVUbQVRKLrCPJJs7EHZoa38KAmvyLv555EL3aoL6BOrTimhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728393683; c=relaxed/simple;
	bh=fHWToQELpDEgW8v19NG8I1j6iaPLXJJtXtkOQ9SROYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fm6zTsOmZHzx0pi3hlq8wrdFp11HL319zkHvXbrevbnrelFzKBSJaeYL1iIsVmvw81cb+kcM1Eywj+CFScTMGTZ31dJKQf3L3ENCOha28k7JG4XtB03h3KrO++Wqd1+6trGE3s1EKQ2wuEtUhJ8DGmSvZYi2dck1GW4LWl59XWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pTbQpztb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE1A7C4CEC7;
	Tue,  8 Oct 2024 13:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728393683;
	bh=fHWToQELpDEgW8v19NG8I1j6iaPLXJJtXtkOQ9SROYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pTbQpztbfbpq1kB04BKl2yyWsojxzx5QuQhBjvO4v1aesoCmkIC+gJY6mM4pYzgZl
	 CHI+c7GWcHrzsWls5MphmcyNX7xDLSzf3HFV2TmMoLIMHfZWn4rx/YkYzMS1pxXssp
	 5EkEzY6IvgGZuBXmfkZ8e6nL31G8gS5UyBK9JGsjOF2Fh/RL2FrAum1VvlEiCaVxsT
	 75+w3N+zhB6/RQL2YbiyU9AgtwoyrGOz1lWKEeTghoNOrmVnFQ6nlHKx4LduPoScnu
	 MYOTu7s7B8EJAzdFfa6D5SoayVIRIuS4rKQ4Wwyz/4iLw/ZmcHiU0ijsroAHIwyQlL
	 h5ld8Idz6LnRg==
Date: Tue, 8 Oct 2024 14:21:18 +0100
From: Simon Horman <horms@kernel.org>
To: Dipendra Khadka <kdipendra88@gmail.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, maxime.chevallier@bootlin.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 1/6] octeontx2-pf: handle otx2_mbox_get_rsp errors
 in otx2_common.c
Message-ID: <20241008132118.GQ32733@kernel.org>
References: <20241006164018.1820-1-kdipendra88@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241006164018.1820-1-kdipendra88@gmail.com>

On Sun, Oct 06, 2024 at 04:40:17PM +0000, Dipendra Khadka wrote:
> Add error pointer check after calling otx2_mbox_get_rsp().
> 
> Fixes: ab58a416c93f ("octeontx2-pf: cn10k: Get max mtu supported from admin function")
> Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>


