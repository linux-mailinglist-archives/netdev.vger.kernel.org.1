Return-Path: <netdev+bounces-153808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA489F9BE2
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 22:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B81F7A5C4B
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 21:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED9A21C9EE;
	Fri, 20 Dec 2024 21:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQof8sAq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E621AA1D5;
	Fri, 20 Dec 2024 21:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734729855; cv=none; b=YCU+4QfnHb65LL37jzSWTOqhS4K1jJlLveaDNI49wgFvbelgtB5cSHHu/5GHXIDmfzs107VJL8MbPmUx2Clf+hw5BFdamnU7+HeEBsxhu/v9RfyBuPU5i6y+5BcFsxaBfWkF/Pd8/t7BJm8fExhRBHfpH7NsZwYndQ4LesTdK9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734729855; c=relaxed/simple;
	bh=iLqXaU0nU0hUYxzbidOYXGgtWu6NeaYinRSbi4JjvA0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZVZx6DlpAs+pln0CIB5G0IBLiwPWbQGmoebu/h+OCz4/hcQ6vJY9AHtol9/MpGZDuCWelSigdQ229a0++UKYTOXUH1qVrkYDHMPVKuMKeRoxZncIi1DamVTFSQYUg0HqYPrFaUAgse9z+piKzhEtKdonzAb00CTDrcBhVl5H5n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQof8sAq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A7BFC4CECD;
	Fri, 20 Dec 2024 21:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734729855;
	bh=iLqXaU0nU0hUYxzbidOYXGgtWu6NeaYinRSbi4JjvA0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NQof8sAqNWwYqt/YesMGWh9WvG0hEPLXSg+BtE5Pa0cA6QgeFhCc3LIW9da5YJi5T
	 8CTpbI+ac6Q4gf63kqR7gFIn5ExHdusnNReEFBRztZNlvd3MXEdBDlWC9ElLYYXJNB
	 Ad674TNq77/Mlz+JitdX7FEVnrj0FM50nAQJawhnIPK+xXUqAJ6ZZ1BnZLq3kM7iEI
	 Cq/wHXuI0icaHU/XS3TVB5KECXQzY0hdtCE+aJxrABE2dvqQhSBDdOLMlUdFpXOA+b
	 R7cxQmve8WMdJXrUt1Z0Fk2cJNFByhrhIt6XiCwQrRD6nPgOH3MFgK58lynsl9ChzB
	 9IszgGEXQ9nkQ==
Date: Fri, 20 Dec 2024 13:24:13 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Gur Stavi <gur.stavi@huawei.com>
Cc: gongfan <gongfan1@huawei.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 <linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Bjorn
 Helgaas <helgaas@kernel.org>, Cai Huoqing <cai.huoqing@linux.dev>, Xin Guo
 <guoxin09@huawei.com>, Shen Chenyang <shenchenyang1@hisilicon.com>, Zhou
 Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
 <shijing34@huawei.com>, Meny Yossefi <meny.yossefi@huawei.com>
Subject: Re: [PATCH net-next v01 1/1] hinic3: module initialization and
 tx/rx logic
Message-ID: <20241220132413.0962ad79@kernel.org>
In-Reply-To: <161ef27561c90b8522bd66e4b278ef8d7496f60b.1734599672.git.gur.stavi@huawei.com>
References: <cover.1734599672.git.gur.stavi@huawei.com>
	<161ef27561c90b8522bd66e4b278ef8d7496f60b.1734599672.git.gur.stavi@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Dec 2024 11:21:55 +0200 Gur Stavi wrote:
> +config HINIC3
> +	tristate "Huawei Intelligent Network Interface Card 3rd"
> +	# Fields of HW and management structures are little endian and will not
> +	# be explicitly converted

This is a PCIe device, users may plug it into any platform.
Please annotate the endian of the data structures and use appropriate
conversion helpers.

> +	depends on 64BIT && !CPU_BIG_ENDIAN
> +	depends on PCI_MSI && (X86 || ARM64)

Also allow COMPILE_TEST

> +	help
> +	  This driver supports HiNIC PCIE Ethernet cards.
> +	  To compile this driver as part of the kernel, choose Y here.
> +	  If unsure, choose N.
> +	  The default is N.
-- 
pw-bot: cr

