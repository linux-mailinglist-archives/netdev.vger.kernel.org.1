Return-Path: <netdev+bounces-229617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EFE6BDEE77
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 16:04:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 10C7A357ACE
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 14:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEA33288C86;
	Wed, 15 Oct 2025 14:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="mNpSdK7Q"
X-Original-To: netdev@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0BB76026;
	Wed, 15 Oct 2025 14:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760536946; cv=none; b=MY8pDFQblWEDIwz8LRpb4bImqzQuLGZrIqBGFlQhE2oPLYgcSF/XwxLFX4HIf6IWCcZtzNh4fUNZ+dDGbV+gxZ2r4aQ5caZ3932Wvw5fnfZFDXTnNVhKSzk3g0KNgLDOG1fMwuwWT/hDnvq01rGp8tgnhtbOtSZ6tQhmqLKriWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760536946; c=relaxed/simple;
	bh=6nvpRL+w3yMGwSCxrLlHi6Jp9XUA2RlHNIJiHeRHwsQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EbvFOhD4sVgPAADn4PjWCGcTPqoBs3YSrfh0SOaM3JGpQV9T/mkG0A0EOM7uFhOlZ7ddec7/cjoak/7XPDF1MghuRWOchpEcAN+Yxjgdo2F8jm3VussImtyh7mgML+Sg7uM1hnpBAVeYH2L1QG49Y5Rfp+PMzwYyQRPKUEJ8c0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=mNpSdK7Q; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 8E925A0D06;
	Wed, 15 Oct 2025 16:02:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:content-type:content-type:date:from:from:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=mail;
	 bh=6nvpRL+w3yMGwSCxrLlHi6Jp9XUA2RlHNIJiHeRHwsQ=; b=mNpSdK7QZuNc
	k/Wymn9abrPlG/o8jt1BE6i36xozmG0hgxwwbSFA5PzA5DCr79idbsORw+7m8BIU
	3HB4yTVOlzR/5/HX4gtPBNIHGmbDGHc3yl09T07IhqdzFdlk2T9T5NHy2ukL896a
	25KCxxCx2dOZQUCZ7Sk2gEaGc2iRIHYEgdOuZbGRLTsRzAKcUn80s9cGV0+jmOR/
	BH0oG4w1TnenlAzKXjG6PiO/F25M8oJ6A0YCVn8bypoKZqHESpyFOIRK4tvzAQCB
	g5ugfzcsjSmLwI9G40xKzVGOXOJutfExw0ufspu3XJGpi69q3XUY68fPIXkXHLqo
	isNMC8P2heHm7/kwYFsHI3AR91XIxI0JUdoIfoxrbFw/Wu/yO0uDRBn2IStk/B11
	9LiIP8sYQ+o7bC51svWH7iVtCGJ+Z3ZZTZjCjyi62UlN0Gt/fAq8NQDgQYdBHYbV
	2WXXvZGBAz9CbFnJfggAWq82uU+jrY7diXBKGm1/qw11F/CqP3LLv30SQ/0xFWjB
	q1kx5IQFLd0qn9HBdYJsUYDjeFDFimd5vxtTy+bWs0YLsJAR36wXX7jRl7A787RF
	8M+HTat2Zafze9tEUxnKZAmMERfZPKUeblpX0yIk18UwY8g+YD0oW7BMtbPSdcze
	hubWQw9wOFtfLtVb1+n6upoGKyXVpfo=
Date: Wed, 15 Oct 2025 16:02:21 +0200
From: Buday Csaba <buday.csaba@prolan.hu>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] net: mdio: common handling of phy reset properties
Message-ID: <aO-pbUEzbNGFwNHT@debianbuilder>
References: <20251015134503.107925-1-buday.csaba@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251015134503.107925-1-buday.csaba@prolan.hu>
X-ESET-AS: R=OK;S=0;OP=CALC;TIME=1760536941;VERSION=8000;MC=3282358105;ID=541937;TRN=0;CRV=0;IPC=;SP=0;SIPS=0;PI=3;F=0
X-ESET-Antispam: OK
X-EsetResult: clean, is OK
X-EsetId: 37303A2998FD515F64756A

This is the refined v2 patchset of my previous patches, addressing the
issues found in them.

See the previous thread here:
https://lore.kernel.org/lkml/20251015134503.107925-1-buday.csaba@prolan.hu/


