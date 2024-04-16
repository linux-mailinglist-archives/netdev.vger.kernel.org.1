Return-Path: <netdev+bounces-88524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 171D98A78C6
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 01:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48C851C213AF
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 23:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCC013AA5C;
	Tue, 16 Apr 2024 23:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HdUWc1kL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C61213AA4D
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 23:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713310875; cv=none; b=r7GMpB9/qo8f9ztWBKxIDVYVFCXRHEltjijDpSSwb1Ms0f56gSdsKb6QVNUMIuyiLukSCG2s3TTmENjcl5H14VNyNzcmG+RVdlEgtnjt6g7ZMfyaVa3g6EacyOlCQ2oqRyE04Kzm60/Ypwr018aRetJbgSbJluky6o4ivJN3VX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713310875; c=relaxed/simple;
	bh=Qbe1BouiZKFU+bzBDw+cmHkZZieGo7eWvpfgZne9VbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mK/kXrtoLmuES3ho5Qxrlsg8LslCYgLIreez43iWB/2AsV32BPYZEGRvob60GLyOGlgWOhqcGyj8h4S/UIUtD88ZnIYnbiSTScuuhcKaRYlvBsaJxXR1baNMKoBZE1D4mLjm4AROSNsIPs/J98VNt0A4GzgHjrT9h1cRfp1WsRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HdUWc1kL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A73E2C3277B;
	Tue, 16 Apr 2024 23:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713310875;
	bh=Qbe1BouiZKFU+bzBDw+cmHkZZieGo7eWvpfgZne9VbQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HdUWc1kLf2CQiHkGrMpxqBpnNF5zWvghUwtjKyaC0Tp9vqQJ28fSpPPpK1ycd2TZb
	 OzKxBP/LGwvC1ntksvh246cWFk5S9fYhHebABxmPf5kU6O99loLqbeY0+ByPu9hjVT
	 9Sm01nC9xlHNdpj0rC6rhiov8T5gjhdWJuBedIh+E99/JKsviZWljEnCTnlkYw6pl4
	 8+Z7sDlofuQAEfItjEEwy0rOATDPzF1PZWoy5ePnjLrdGthxEd9EyfiWK7dycB82MB
	 20b67TwSWFyqaNVZTP1huM5sU4OJAPP9dt07QhKgr7otybfWfqvv4t0WrkA5s3SOE3
	 jdxqEA/K4JWWA==
Date: Tue, 16 Apr 2024 16:41:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net] r8169: fix LED-related deadlock on module removal
Message-ID: <20240416164113.3ada12c7@kernel.org>
In-Reply-To: <ZhzqB9_xvEKSkMB7@wunner.de>
References: <6b6b07f5-250c-415e-bdc4-bd08ac69b24d@gmail.com>
	<ZhzqB9_xvEKSkMB7@wunner.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Apr 2024 10:49:11 +0200 Lukas Wunner wrote:
> >  struct rtl8169_private;
> > +struct r8169_led_classdev;  
> 
> Normally these forward declarations are not needed if you're just
> referencing the struct name in a pointer.  Usage of the struct name
> in a pointer implies a forward declaration.

Unless something changed recently that only works for struct members,
function args need an explicit forward declaration.

