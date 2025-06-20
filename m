Return-Path: <netdev+bounces-199753-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDCDAE1B53
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 14:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA2C44A7EF5
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 12:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A7128C5BA;
	Fri, 20 Jun 2025 12:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="LZt2itCt"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC4028B4FA;
	Fri, 20 Jun 2025 12:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750424279; cv=none; b=naOFwu7KEJSGX6322xGLewBa1p8DBBXbZjFyHEAnp+s4+bZ8q5ccwj2QCaq7NgEqILNz2qRzmE2yLKJfrmjyc8znKay3Bd8rsJ59h621XgNjAReRMS/P/9rkFZ1aSbmw4aQIljxyMIwZjzH7vogoNx0KJZHouPw+A/+GjNMttCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750424279; c=relaxed/simple;
	bh=EGdmSkbyYDyeIUSuUVtgaqaMcFrbNqCr0h3vtKs9RI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uGDq7Aw3n69KafABWRXp8lo9wS8zB/A3wHE5FJulTsTVnf9OCtqDYksICQsojvVsioNTzMONYCEDZQzDRqHgApdLNRrjDDafFio812jn+nS41eLr3dn4y0B0cYuBwO78P/2U3hrHUImEMD2UQxQbjzTtYigHUhYCAoAXKLBMqzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=LZt2itCt; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1uSbJM-00HLGE-1M; Fri, 20 Jun 2025 14:57:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=2J6Y8XwOM/mssKlqoVlql2Rx7ivwP4hQKu407pGnyyM=; b=LZt2itCtZ/pHOnO/0BksE377e1
	sE2vCeVqEOkTyXeW8eCaR/FbbeAIUScmVcpH+75PuSiovTecUMmwUlXT97ZMq+dfjsISOsaicUTOB
	vIkjPwHysPErm1zTGbTKOTiq35PHxVS5fTXa2T6CnhEx6jKRynoNWYWVeX9AuHcNr5lev1Zr8Makt
	W8QSRdMQfVVS6ptdrHpVMxyPgH+lyil7aqdul+O2aU6iMuzVNlQADbYvYnX1gj0zhEY1SFFeTvHIy
	kVsYiu/Wf8opqDRb3EoB92QSc9/E843aC6IQJ4AY02PNdG2REs4fGWgmLiwkWGzPLiaxh0wfja6gh
	0EBKahpQ==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1uSbJL-0003DV-6z; Fri, 20 Jun 2025 14:57:39 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1uSbJG-00AXhy-7c; Fri, 20 Jun 2025 14:57:34 +0200
Message-ID: <f96fb2fc-53ca-4e47-ab94-81c2f7b7c61a@rbox.co>
Date: Fri, 20 Jun 2025 14:57:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/3] vsock: Fix transport_* TOCTOU
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250618-vsock-transports-toctou-v1-0-dd2d2ede9052@rbox.co>
 <20250618-vsock-transports-toctou-v1-3-dd2d2ede9052@rbox.co>
 <qvdeycblu6lsk7me77wsgoi3b5fyspz4gnrvl3m5lrqobveqwv@fhuhssggsxtk>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <qvdeycblu6lsk7me77wsgoi3b5fyspz4gnrvl3m5lrqobveqwv@fhuhssggsxtk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/20/25 10:37, Stefano Garzarella wrote:
>> -	if (!new_transport || !try_module_get(new_transport->module))
>> -		return -ENODEV;
>> +	if (!new_transport || !try_module_get(new_transport->module)) {
>> +		ret = -ENODEV;
>> +		goto unlock;
>> +	}
>> +
> 
> I'd add a comment here to explain that we can release it since we
> successfully increased the `new_transport` refcnt.

Sure, will do.

>> +	mutex_unlock(&vsock_register_mutex);
>>
>> 	if (sk->sk_type == SOCK_SEQPACKET) {
>> 		if (!new_transport->seqpacket_allow ||
>> @@ -528,6 +539,9 @@ int vsock_assign_transport(struct vsock_sock *vsk, struct vsock_sock *psk)
>> 	vsk->transport = new_transport;
>>
>> 	return 0;
>> +unlock:
> 
> I'd call it `err:` so it's clear is the error path.

Right, that makes sense.

Thanks!
Michal


