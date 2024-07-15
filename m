Return-Path: <netdev+bounces-111495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB2C93161F
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 15:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD29D1F222A5
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 13:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48F218E754;
	Mon, 15 Jul 2024 13:52:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay161.nicmail.ru (relay161.nicmail.ru [91.189.117.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E0918E75C;
	Mon, 15 Jul 2024 13:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.117.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721051570; cv=none; b=MDWTps5rD0B5RsagdPnmR1vl3tFLg+u5cko5FxXCw0Iz0u8flT97f9/LeMBy8b6eqJWDa/GBn0EdqomAGWgd6e2j3LxGj2RrYPfu58DBSNdZDiKHfzG+ArISphO9dm1381zar0wJ/JWkNg+K8xflCkGklQ92E83eA4LcD/6DieY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721051570; c=relaxed/simple;
	bh=osfn9HAZVILDhdNA00M1fL4qkv+AXJEC23upnh8fPMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NsAzMwVFC4IfxvGSWPYEnkprcld1oce816/8IYw0sEHILg88V9pnzRulaky8a/vTGfcpqCymE5MgoSR1Pip5a5hIOwfIjKyhSjPtpn+QS0sAl6LrKggWexpPYb+vRGVPVek212o0ZgdUICM7qS2/SsGpL3PY1YZKgfINBQUd6pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru; spf=pass smtp.mailfrom=ancud.ru; arc=none smtp.client-ip=91.189.117.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ancud.ru
Received: from [10.28.138.152] (port=18678 helo=[192.168.95.111])
	by relay.hosting.mail.nic.ru with esmtp (Exim 5.55)
	(envelope-from <kiryushin@ancud.ru>)
	id 1sTM8A-0007ra-3Z;
	Mon, 15 Jul 2024 16:52:42 +0300
Received: from [87.245.155.195] (account kiryushin@ancud.ru HELO [192.168.95.111])
	by incarp1104.mail.hosting.nic.ru (Exim 5.55)
	with id 1sTM8A-008z0j-03;
	Mon, 15 Jul 2024 16:52:42 +0300
Message-ID: <11e7b443-c84d-48ff-b7d7-12b4381585df@ancud.ru>
Date: Mon, 15 Jul 2024 16:52:40 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] bnx2x: remove redundant NULL-pointer check
To: Simon Horman <horms@kernel.org>
Cc: Sudarsana Kalluru <skalluru@marvell.com>,
 Manish Chopra <manishc@marvell.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <20240712185431.81805-1-kiryushin@ancud.ru>
 <20240713182928.GA8432@kernel.org>
Content-Language: en-US
From: Nikita Kiryushin <kiryushin@ancud.ru>
In-Reply-To: <20240713182928.GA8432@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MS-Exchange-Organization-SCL: -1

I agree, I guess I was meaning to state, that bnx2x_vf_op_prep()
already contains all the needed checks


On 7/13/24 21:29, Simon Horman wrote:
> But, FWIIW, I don't think the test on the two lines above is relevant.
>
> bnx2x_vf_op_prep does, conditionally, check that (vf)->vfqs is not NULL.
> But if (vf)->vfqs was null in the code you are updating
> (and I'm not saying it can be, just if it was),
> then neither mac_obj nor vlan_obj would be NULL due to the
> layout of struct bnx2x_vf_queue.
>

