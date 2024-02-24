Return-Path: <netdev+bounces-74644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5FC8620F8
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 01:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F1FE1C22BB4
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 00:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0947619A;
	Sat, 24 Feb 2024 00:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0IY4xha"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FE4182
	for <netdev@vger.kernel.org>; Sat, 24 Feb 2024 00:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708733207; cv=none; b=JnSlRPF8pz7jqDhqDvbQxBDeRgx8nMLU/m2FxZJfmazaH/pti9o4jQ7Wfl7rxriYI802PEsRsE/IPcRc+vkZHt+HcstwgthC0wI6DoHLxzNc8mVqTOUgqUzbo1srqdI3tdjCRXL7ujS8McjT/WS5TJrNST/qAxRA6vNDSnA6p/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708733207; c=relaxed/simple;
	bh=Hahn0RBepfcRbTqqvqsgbwragekkHtk0sD2deHeUs5c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T7XKWeuf9vkUcDN2sbdUNx+m8PVkZhH3zt21FQXLAQeA8pDHJdT6tTfRPsIZkzBV8gxEo07SCSfW+Q0ea1BwqC/oFJrWRRhzyBVImz8PCL2IchPudpf2cqM0SWXMIOwyvuMPjtZzdHK5FLtX7/dHcU22yAadJqzqhKBrIEizlAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0IY4xha; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EAFBC433C7;
	Sat, 24 Feb 2024 00:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708733207;
	bh=Hahn0RBepfcRbTqqvqsgbwragekkHtk0sD2deHeUs5c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h0IY4xhaPvNSonGjrKeaX9rYhTBksReEPBlqtgPr+U/wVRyGF8s67jQr8/AB2C77h
	 XIXxL2aDX8PWWrhnVR4/yxiONwBzMqtJDlbOgBw+qags06ooQ76tdheJHzo1UAyv42
	 bb3FIlIMpHbPbDyVZbJKtojYl7KyGtHoKaxvEJ6qy7iOYagAhyICF/ueXH+ZLDkXiS
	 b1v/DK5lu6QXu3ZQ3A0F4thi0vdd2SGxmGJZzuyzQQQdXSoJoMbCzYDQ0N9R8g1LxP
	 x3MjLSst00gLPKQgUzYKqLHzNO89dk1GsDcIjif9JPxFB33C9WyezqkBafPx8UQX7l
	 cmKdsoeFAPA+g==
Date: Fri, 23 Feb 2024 16:06:46 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Miao Wang <shankerwangmiao@gmail.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, "David S. Miller"
 <davem@davemloft.net>
Subject: Re: [Bug report] veth cannot be created, reporting page allocation
 failure
Message-ID: <20240223160646.78ec190d@kernel.org>
In-Reply-To: <78C6CA8F-3634-418A-8A50-71753B5DB0C8@gmail.com>
References: <5F52CAE2-2FB7-4712-95F1-3312FBBFA8DD@gmail.com>
	<20240221164942.5af086c5@kernel.org>
	<36F1F1E8-6BD7-44ED-95EB-F0F47E78EC9B@gmail.com>
	<78C6CA8F-3634-418A-8A50-71753B5DB0C8@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 24 Feb 2024 06:37:18 +0800 Miao Wang wrote:
> > I directly applied this patch to the veth module on 6.1.0 stable kernel since no
> > reboot would be required. No problem had occurred in the previous try on
> > reverting the patch in question, which lasted for about 76 hours before I replaced
> > the veth module with this patch applied. I'll monitor and report after 24 hours if
> > the problem does not occur.
> 
> It's now about 30 hours since the patch is applied, and the problem has not occurred. 

Great, thank you! Fix posted, if everything goes smoothly it should
make it to 6.8-rc7, and.. whatever stable releases come out after that
:)

