Return-Path: <netdev+bounces-213925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E00B2756D
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 04:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A208417B26A
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 02:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B266E292B3E;
	Fri, 15 Aug 2025 02:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="h9LSRNrY"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234CB27455;
	Fri, 15 Aug 2025 02:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755223569; cv=none; b=frvtCRlOEjInosKvN7uwI94J7buEBX1G2gEE+FqmemyWVEGWXSM3XhoUGcAGzzmJY6Kdj0IPZD1BALxCW4iUM6NnBmGwepGKBYp+7pJhFk0ZPTlokGTEj9kYYycZwblgHTG1jl/Nv/CSzeYbuyjmp/KzDXp9EaQoZAWh0RalHio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755223569; c=relaxed/simple;
	bh=aGpCd3qfzc6TUW1R2eLLH+vd05Na6KxmiotUnVwd1qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lZQAlTcCjZpln1r3lqvz/AEX0lr3In9Mluv0Znqeor9MOG+6fPffz6XEcMcGAwTr94MpordderhQFVJa2QKE3LZzc6LIxLU4pRgFNrZ3Oog0hrK93Dc0cMg2FVEeEC2zMoNehJHrRYxNTEduoqlSLGc5F0eSWXIu0q6JvePsPF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=h9LSRNrY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zMmPkIj84ZplNGpxRf3Jy17wwWmbFNxFspAcSDrvS/I=; b=h9LSRNrYmE73ZbCpwdOHrnnEAQ
	87vSHIkikT1Gj/U/+ppI4983t1mibU8LhyQ95C8WZpS8tp5l+diJikrhmHGW4uCsWE+jqXrtRi/Dk
	2kXT8EVbGzLt1j2uhC1rAb7i+0QHiitFPEbKqd1MAaJn6NKhOYxrq9eNETzjwqrdlf6E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1umjoy-004m8W-Nr; Fri, 15 Aug 2025 04:05:32 +0200
Date: Fri, 15 Aug 2025 04:05:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Dong Yibo <dong100@mucse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	corbet@lwn.net, gur.stavi@huawei.com, maddy@linux.ibm.com,
	mpe@ellerman.id.au, danishanwar@ti.com, lee@trager.us,
	gongfan1@huawei.com, lorenzo@kernel.org, geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com, lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/5] net: rnpgbe: Add n500/n210 chip support
Message-ID: <a0553f1d-46dd-470c-aabf-163442449e19@lunn.ch>
References: <20250814073855.1060601-1-dong100@mucse.com>
 <20250814073855.1060601-3-dong100@mucse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814073855.1060601-3-dong100@mucse.com>

> +	hw->driver_version = 0x0002040f;

What does this mean? It is not used anywhere. Such values are usually
useless, because they never change, where as the kernel around the
driver changes all the time, and it is the combination of the driver
and the kernel which matters.

    Andrew

---
pw-bot: cr

