Return-Path: <netdev+bounces-144581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 032349C7D0E
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 21:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8001C1F22850
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 20:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDCD2064E9;
	Wed, 13 Nov 2024 20:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="S5xmz/uf"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADBF2036F2;
	Wed, 13 Nov 2024 20:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731530482; cv=none; b=dlYqoBTUegO/4dei0oplkQcXghvqW+6XKS5SpZbxZ0ECAIl0OSwWaY/EHYnrFfc1fDejyE5F+f8P5zIVihjc46Bte3YEFVNiDY6uPXvbZFPW3YyhaEOwsKiapv1PU+Ws/a6shTcxx+uuvF7fJhYRnQbu52gfci4LJqZfvOm4wdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731530482; c=relaxed/simple;
	bh=UmCPqZHRJKUv6huErNv7ccyP9edlm5rjiZC0/3bMbHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HR5lh7AqeqRNsFTjTLhU56m6Sda1SZeNlmIRI4LuGLZkqoyV3aN3rfwhsj9EqiZSiU8pDLdVEFITOCA++vsmYE9r4gx0HrS+9L1a+Dfk+MjaMFHpO3ufkHv/eN+vRrgZhWHvHRJ5Fpussdmfpom/tHLgYrvdwL47z3BBIPu7fZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=S5xmz/uf; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xyXDXrgpgdM6KcxgvcDZmedbCSrF14uf4voKguMkgic=; b=S5xmz/ufKaSIZhkuFsI0BiYEBt
	R5AOLzH5R3qmpR/US6sZGlVA43e1KeASesF9lD7W3IQc2xpoZzWkQrcWmk01rS84ibn0+a0Zz1B0J
	BRXLT4cN9b+pBJkRjFBlns1lkzO31WVnJo4bCGXy3eBsfzIAVvRaUj/mv+iGK4h9XL7M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tBKAk-00DCZw-Fb; Wed, 13 Nov 2024 21:41:06 +0100
Date: Wed, 13 Nov 2024 21:41:06 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shenjian15@huawei.com, wangpeiyang1@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	sudongming1@huawei.com, xujunsheng@huawei.com,
	shiyongbang@huawei.com, libaihan@huawei.com,
	jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
	salil.mehta@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 net-next 5/7] net: hibmcge: Add pauseparam supported
 in this module
Message-ID: <08bbffc1-3c99-4b4a-a3b3-02707752398b@lunn.ch>
References: <20241111145558.1965325-1-shaojijie@huawei.com>
 <20241111145558.1965325-6-shaojijie@huawei.com>
 <efd481a8-d020-452b-b29b-dfa373017f1f@lunn.ch>
 <98187fe7-23f1-4c52-a62f-c96e720cb491@huawei.com>
 <d22285c6-8286-4db0-86ca-90fff08e3a42@lunn.ch>
 <2d8e467d-b8e0-4728-ac2c-fba70a53bd9f@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d8e467d-b8e0-4728-ac2c-fba70a53bd9f@huawei.com>

> Maybe there is an error in this code.
> If I want to disable auto-neg pause, do I need to set phy_set_asym_pause(phydev, 0, 0)?

You could. It is not actually clear to me what you should tell the
link peer when you decide to not use pause autoneg. By passing 0, 0,
you are telling the peer you don't support pause, when in fact you do,
and the configuration is hard coded. Not using pause autoneg really
only makes sense when you do it to both peers. And then the
negotiation configuration does not matter.

phylink makes this a lot easier, it hides this all away, leaving the
MAC driver to just program the hardware.

	Andrew


