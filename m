Return-Path: <netdev+bounces-177996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C58AA73E41
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 19:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 380D77A6129
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 18:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7347218E91;
	Thu, 27 Mar 2025 18:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="egPas8/W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D1E18A6DB
	for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 18:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743101963; cv=none; b=HLlL9N//1SsUAloIDW8Nd9jFgaCqDRu5bdhQshqlSV5p4o4U2ZbLPr4yCz+xjYlENtkSbJ4L4Wf3lRPl5xTEgtH2mHmToVRx9wADJK9Kq7MFObjyjuhBOgQnVzU5WaWwHz4SLyV1gb/xy8v/54Cvrh6VvX5Pn98MKFPRzpZjsPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743101963; c=relaxed/simple;
	bh=IURctLb6cpRQ0Jy9VvV7vZ6fJOLDukGBD6n4WIorsaE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NFI9jl1YZx4/mQhaW7Psb1ugv+TMGxWpohS3qUiPcQ3aKoMJSzcVKp8RAxRAXqcFztQb4jNfEOk5949mgVx0usfipdq3NV3K/nTeF9TzIOJUKhM76qmWPnRRNltNEhCaATHfgIWiTwW8xZdU68KcLKihjMk5KbbHHG6cK4ajvXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=egPas8/W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABEE3C4CEDD;
	Thu, 27 Mar 2025 18:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743101963;
	bh=IURctLb6cpRQ0Jy9VvV7vZ6fJOLDukGBD6n4WIorsaE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=egPas8/WjsL1LyZg1U3fujBhdmsH/6YpTU55kk5K4EuBrsGoeNOTNuf006tqcvxvK
	 N3p/rFypzetRM8TTBr885YisU7GMcMzsSEn8Tum0CIiOnJqBaEeFW3ghrlPct6VNR5
	 I09mE0t+IbpLgYshqTeWDTRz9aTUxRqcwfOr/QNqNyrkvfgP0quF6DlYvyho5imVRg
	 jUtSblDo2m6FxBR2bLIrMui5nVNhkSmBm76zT5cUrUHdfY5//+WT5AlcnTxYh3KTJv
	 Tk2vpJETrXq3EdsQykaKo3fbTwOd8gFe+5j+rnX5IXKdhMBE5TYRBgzfZNazZ1d5Uk
	 dZ2+PImM6JauA==
Date: Thu, 27 Mar 2025 11:59:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, Cosmin Ratiu <cratiu@nvidia.com>
Subject: Re: [PATCH net v2 01/11] net: switch to netif_disable_lro in
 inetdev_init
Message-ID: <20250327115921.3b16010a@kernel.org>
In-Reply-To: <20250327135659.2057487-2-sdf@fomichev.me>
References: <20250327135659.2057487-1-sdf@fomichev.me>
	<20250327135659.2057487-2-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Mar 2025 06:56:49 -0700 Stanislav Fomichev wrote:
> +EXPORT_SYMBOL(netif_disable_lro);

Actually EXPORT_IPV6_MOD() would do here, no?
We only need this export for V6?

