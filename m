Return-Path: <netdev+bounces-175983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B07A7A68303
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 03:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C8E31897F14
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 02:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC7120CCDF;
	Wed, 19 Mar 2025 02:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ywsqw3sn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F5185626;
	Wed, 19 Mar 2025 02:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742350132; cv=none; b=sa1E1o4iyryaVjiodVFt466VuE2GtIHh35+bFSJ7Jcx/0AfQmnVNtupwHLQu/JcH7JzVqGqLstlk5COUHVEqW/z6voW8C7znZcDWdbaQ95oiV7HYWc2Pjap7cew+9nKKHLSIqJFjT+TWfgSKBgMoG5P2dcWtYmOyfMRaia8BCJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742350132; c=relaxed/simple;
	bh=cDziYvmW2mLbrw0ZPswXeZcjuNrMUpHD10f7WBd5At8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IUgZ4jcApfRY0V8TBiukPU1H6xC57JwDi26pdB7xZqXJm6XGkQ1DiaHAGBpD6RzyApL6bNv4aKMzaVEHAJB5ywG9XCoeVmfpXaJQ345Emy5RuSM1yRBOtKKbYrYckk+6t09g2tYju6P+mY/RBn/2xrIYT3qz0FXnpeQzoZ1U89Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ywsqw3sn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E92C4CEDD;
	Wed, 19 Mar 2025 02:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742350131;
	bh=cDziYvmW2mLbrw0ZPswXeZcjuNrMUpHD10f7WBd5At8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ywsqw3snI5l+Z4y2+cCrRSwsAgaWDwaYcV72OMsT+I89xYZtXeGLRsfHR72BBX7bV
	 G/w8iudewnQcMKMRtlZsPqq1xjzOtig/Of7o0LGaehg2F/YO584stAeMbAasGsPODU
	 QP3hN5VD4iA0p8XonhSA/SMeT7yuKdoHhSh1nUy/yI1BLuxKtYIylLrumcCsC8EstC
	 qEkjee5f378HEphkdJmr/ybBbwsc6v+hNxk6MdMN1e3bSfO9NLfeU7W1wBs4P2You6
	 bkzTBM3RniTN3iZ5KmTGzH9TmfKxIhld8AYoajXj6pi9IHzEOVHCR6Py4Morh5hSHP
	 cAPoERu9OfuJA==
Message-ID: <fe5947e2-8a91-48f5-9037-f3a48b55fbd6@kernel.org>
Date: Tue, 18 Mar 2025 20:08:50 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: fix NULL pointer dereference in l3mdev_l3_rcv
Content-Language: en-US
To: Wang Liang <wangliang74@huawei.com>, Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, fw@strlen.de, daniel@iogearbox.net,
 yuehaibing@huawei.com, zhangchangzhong@huawei.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250313012713.748006-1-wangliang74@huawei.com>
 <20250318143800.GA688833@kernel.org>
 <e8da7ce4-c76c-488e-80cb-dff95bf00fe0@kernel.org>
 <94a34aa3-a823-4550-b16a-179e6f6d6292@huawei.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <94a34aa3-a823-4550-b16a-179e6f6d6292@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/18/25 3:07 AM, Wang Liang wrote:
>>> It seems to me that checking master->l3mdev_ops like this is racy.
>> vrf device leaves the l3mdev ops set; that is probably the better way
>> to go.
> 
> Thanks.
> 
> Only l3s ipvlan set the dev->l3mdev_ops to NULL at present, I will delete
> 'dev->l3mdev_ops = NULL' in ipvlan_l3s_unregister(), is that ok?
> 

I think that avoids the race you saw. vrf has had the ops for 9 years or
so and not seen that problem.

