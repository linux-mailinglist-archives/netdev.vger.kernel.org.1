Return-Path: <netdev+bounces-144994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C98AA9C9012
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 17:47:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0665AB2C0D2
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 16:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387C318E76E;
	Thu, 14 Nov 2024 16:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="j6NCY/KT"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F9918E35F
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 16:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731601365; cv=none; b=fQetV+YVJDNkQ2lVRc17Y9YSKlIHQCebhDT8LbnEYBA3ysDSy7SH/c3xCQX66OJTPbdMAJ/6lYfL4Et8yRHYFf/DoZH8KpylBH7dresxmDg8/iNkBPgJ1WkW8JW9gJMw+dSEhL6Jo9lN6Qdeu5P99Po19pQrErIGpGIpd+a805Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731601365; c=relaxed/simple;
	bh=4IaftXbYv4ECqmAKi3NVHvW3JcYdgjCYd1WWAg7JXGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eiuIHTQqSc1nd412UOYg9fVF/AfSK9aRxqXqKUq/coGAtEVjjtozz6eTKTcXjQ6z6sL6yUoCSCF8y6kZrInCf1qWhi+1fj3vEMB48Ru98iUSJoHaTrNM/sfAoTYjlGE+TUWJDLhbqiR561dbjd6A512HF/3vZLbNkSMyyX1XIfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=j6NCY/KT; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ff83386c-2102-4497-be0a-772bd7e6c30c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731601361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DqdEH8rro5M5kS6x2oldYslYOefPTgI3z8afbFzgGqg=;
	b=j6NCY/KTIIvjFZzsmBe0iAVHfZphGsXie23Yjxxs3grnNzaVvrX23xtllfC3CDIKHs5+Nb
	koxTPVuxjMOyXW0mRue8N7tzOyuIRC7DOvS0w11uo8Z1YQDzToi7QNhcyAqJ1OZYym3DAi
	WQvgxbk/tWpmup2bdGu9LumeEdsqe/8=
Date: Thu, 14 Nov 2024 16:22:37 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4 2/7] enic: Make MSI-X I/O interrupts come
 after the other required ones
To: Nelson Escobar <neescoba@cisco.com>, John Daley <johndale@cisco.com>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Christian Benvenuti <benve@cisco.com>,
 Satish Kharat <satishkh@cisco.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Simon Horman <horms@kernel.org>
References: <20241113-remove_vic_resource_limits-v4-0-a34cf8570c67@cisco.com>
 <20241113-remove_vic_resource_limits-v4-2-a34cf8570c67@cisco.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20241113-remove_vic_resource_limits-v4-2-a34cf8570c67@cisco.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 13/11/2024 23:56, Nelson Escobar wrote:
> The VIC hardware has a constraint that the MSIX interrupt used for errors
> be specified as a 7 bit number.  Before this patch, it was allocated after
> the I/O interrupts, which would cause a problem if 128 or more I/O
> interrupts are in use.
> 
> So make the required interrupts come before the I/O interrupts to
> guarantee the error interrupt offset never exceeds 7 bits.
> 
> Co-developed-by: John Daley <johndale@cisco.com>
> Signed-off-by: John Daley <johndale@cisco.com>
> Co-developed-by: Satish Kharat <satishkh@cisco.com>
> Signed-off-by: Satish Kharat <satishkh@cisco.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Nelson Escobar <neescoba@cisco.com>

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>


