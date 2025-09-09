Return-Path: <netdev+bounces-221276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9CEDB4FFC6
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 16:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A6544E23AA
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 14:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A894352061;
	Tue,  9 Sep 2025 14:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="gysOtnPK"
X-Original-To: netdev@vger.kernel.org
Received: from sonic317-32.consmr.mail.ne1.yahoo.com (sonic317-32.consmr.mail.ne1.yahoo.com [66.163.184.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B75350D72
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 14:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757429002; cv=none; b=sGR65onEA0f/AmZwutBn0YnXWrGCkBx/vopo4szG9vQFvZVLIJ7xgd/el5L52TkERzwhGdFn11C1zM222Aw0R5wMDj7KMct1cnZ7h4TrKRUSNjDtSDHmAF1mfXCkA2mZnDoaFB2PyRsfb+RN0TxHF8lgr8Zq+m3azaHw6LDJaeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757429002; c=relaxed/simple;
	bh=9WYX3uSX9Qt+NV3Blx/DD3lMXZoLSVR13auJnUlq8OU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XFRS924rqleDqa5KQvVx229O+5JC8iY2X59g4soCEOEumR+7MFXky1ihHs+FPt4qxYI5kPVTVMAjCnbfRBRcXYbDfYS2F1/NrjRcCZAQh6J4nOnIYWT9fs0jRrPz2apNQuhBuAvqFECjyFlfC1NMkVo5zpKDrtUuxKRLWvwZwbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=gysOtnPK; arc=none smtp.client-ip=66.163.184.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1757428994; bh=bIo/xtK0GLVGpYOU5YItN+BO/RErUhraoRx9OEgQ5Ak=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=gysOtnPKbatwkqEkjmFABhtOAjuURBN61MzAuFGinRWAfJKiBP4gvWNYKUR2Sp/WgyDlZ/CqG42QXoAL99T76i0i3UFRGA/v4a29V7IxaSNxTuxh5KI5y7CIyVMMUMpMVDScgED/HPvYQdwZtt+UfdbPAs6J00fYeIGcVVXn+7i1cc7km4rT9sZ1i/dDSqvT9FnAWRI1sv9F49LPCuOp5rL95jOAWucnYmvINVGoX7G+yMIX1cCZAJHLAxMS41bt6nOPyaHyP8qJwfSYZXh/zFRuOEmvskZUKrbIMJEOs1wMHRrCScl7K5LqC99tnGVQXylBb4NNNAPKoQoelfnp+A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1757428994; bh=5srDkvvedXalpCi5ez0jjcwVpt7LTdUXvdrs4ZmBT8J=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=W+1cBRSgFm8K2UCx6pcTuKtodRff7cPkxOOHnFahSlWTS1JhojUFy6o6hqIFV+AU5WxRE9j6SeFpZM71d9tWGmjPPM0ah4NnjDeDMwmwNcp3levK9MYDmB87ueR1lC8YYMu7YMp6S8V0wZ4MgkNepLas1EujLrOYei4TipdeS8WXusad/nlLVUd+4TCcYg7NrlsdvKGf+JhsaLSQPDwVxcL/SlroGpIo00lYW8FWKI5oh9P7ZgxUIDVD2kBEh1FqxUoVjtswxwa1JIAvAVMabElpNeN+av9Z0A+NsKmx3TvFsjjFp3huaPESE7hQ26cOdLLgwm7SdIA9W8E5rlzJ+g==
X-YMail-OSG: i0U98Z4VM1lF8oTREPRkWH0wHtJIaDUu_VWhrkNmR7.dBUVtxqM6x0EP0f4dPLe
 e52Po86aYhawU9d7FkkpKMomqXEecv1p83PPOhNeZwVnUWyTUaCSW28WUj3BeMFWU4HIqXfPssro
 6T5kYsex1PuX.K..xaQCxbs0o5_s6Rj7S8sV1H49p1RDD77p4V16aAGM4B.whu5sJGVq3BnxMm2X
 3IMrIBcIhtyhTzcBe7wpPDapTZXtdMk2YEQYcetOGnsuoE2Ob2r0eywb0MK4PrJxixfoR0_OUPWA
 vdnlVtDT_oTIM9aC.Ev3GxoWb9GOIwJimsEhe3PfNihcIPpDHt9pcKjSHI4twpghKqixiBQY8FLs
 IMmcm6icUjDsizUHQhux0J.feTlTPWQ.9Nb5jqEOq.J0fkoZm6bYj7AFvLw4I2ZNx5CnAwGuEBdx
 AYYBTl0lxqTtS2Qgr27t1A7KEj7bVItfSVEUWTOUxb8ChqTWsj6fUNHa1AK3txZ_L4MpWD4SAvet
 yvficqokQUir_KAhonDxhTZ_OuLo3W6vTutta7pIo.nnvIoY7isTyaDJ2cxvkJ7tE_77Uh89v_N1
 d4cGDbalMXRYfG4ZDF7l0CPXrmh0V7UvrcWi7Hnst6mMcZjFLRDvUOTS3J9q3MyJblXH3MaIW9ID
 PWPWjGMBxjLlPOboa39YrSlOU5jn7TfORKxZgBGmgneA3mqiRF8a1MLGLCAsaYWEzUwCStFmXmHg
 YlG53UfvoRal0GmqI21VHdOQgdYbFo5Ma1hw73zO4CiBwxUOZqlRfpHkhWqEaRRhNHfhCHUmq6yd
 L1JkEMTL.IAQv5oophe0l80WZl64GMl93tuwUKYSfWgVkKCBXA1ONHhPU.i43s7mmz0BQVGpxXxU
 rP1qGdC5_sQLNy6HtZhtxCvHYegVg2nIkMABb3U9Dzo29ub1FMb691.vdtu1n10zXFSnZt7b_YLa
 Xja.gVIaxpr_UTD7CFfxb2xO7yeoAaLxYPmbxlCmQB2IaFyJb9g33Q01SHFEX2UT.4yPKGtxXuv3
 xvc6NA9PMM4RoTeAI3jH9lii2EgJOqe51hm6xq6pCuBiqNQgd4pnWAoMYfMEFm7CrUgS.14qyOnD
 IbphskiAeFNMPFi_dKhhyvUyEcB0O06GC0lOiAl0u.xI1AYzwN6reSwuvsX8oghyqllF6zdCtknU
 EGyPNVzRS_f0cEeLPQlBWGQIesZsh4rrETDjsx9f83eJuXSuuXmqQzAWzbmkm_GqtD.Aev0jS9kh
 nB2DEXIuQxXAGtqMOJ0rF6tHrfgtVWi9tlucYewf5tb48PfMT995diSlekGFHlUYcswva86m9dod
 _KCpkj9nepr40kr.hr04aYu2tCwndTzuF8pzYJRWlDkQNN52fdNsvurbg6UrW3KwzkWVHh4gz7Q.
 1bHtDg7rT9rs9TdNooX0Xeh4msqA7qbyyDhCE3BZvULQia.UJKt.5oByAQgAphHeJB2BnSk0c7nI
 691wLWrqX.nmQNCW4a1TXJCMk8wYyQGvFpZpl7KdNtye1ZTtezViLFlZA3sUtePSN1ubScXpIX2x
 GXU25KQdOMDxboLONG6_JA8qijrB5Nz2n1r9mSGw6lKSHhv9pVK3Raczp4kQwon5xSxc0FRmGpfF
 BbDZHUTx3ENM_IUC_MyJf_nBAt7apt9eDiq0iMKMHs7CVqMDZOy_3AwTX_fN8I8zzQtDfrXrFrTJ
 2b5twszvM3TMj8tTWf5Kn3VOAGDZac0HRNxsQbEbhkrQQkjKIxaDXBE_dZKr_RRuBNKlPUYAaGzK
 1xVg655Fj9iepuTGujNtbzgIkvXa2lDe1C.LeCNxQrDHbuafyZvU56VEpLFw86HACulVkOh8naub
 LBVXdAuggcHia3BI0GsDpXIKTb6Dkn58IFK715r1m0hDJmFOGbB_dFFCWSvH01MW2ErBQjD7svQu
 4z7efBMm9MPv_w70URJQmcfyVDVWZQzSL8028xkVH0p7r2kbaFGIIw4cvo2dmH51tIW4B_TXnPYV
 YjrWR_ws6JxczgBg4hxQqbw6O8dfXSDf8AY2TohgbbMCAAC3cxLiRGcRys3Kpp0qHZFUYcRf9tfU
 eGnFhDHRFe2hEf9fJ28P9j1_EsXDm85YuHrYT3K6HtNh9Do6jrVarN5oqGQ9xLuN4khOrVCDlak6
 0u_745t6jfsanBdYJ3or3wrbZhN24d00zupVGpnf.O3.kwKPWku4aAjOl5lkJ4dguUGPzuv3F0CO
 JB1UV_Q--
X-Sonic-MF: <mmietus97@yahoo.com>
X-Sonic-ID: 425600e8-c256-40d6-8a39-bc05b483182b
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Tue, 9 Sep 2025 14:43:14 +0000
Received: by hermes--production-ir2-7d8c9489f-tdhws (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 2b182c3425909ab5019943dcbda5eb00;
          Tue, 09 Sep 2025 14:43:09 +0000 (UTC)
Message-ID: <8e6b83b3-c986-4d6e-b61a-363e13bf1ddc@yahoo.com>
Date: Tue, 9 Sep 2025 16:43:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/3] net: tunnel: introduce noref xmit flows for
 tunnels
To: Antonio Quartulli <antonio@openvpn.net>, netdev@vger.kernel.org
Cc: openvpn-devel@lists.sourceforge.net
References: <20250909054333.12572-1-mmietus97.ref@yahoo.com>
 <20250909054333.12572-1-mmietus97@yahoo.com>
 <b8b604f7-c5c3-4257-93da-8f6881e96fe4@openvpn.net>
Content-Language: en-US
From: Marek Mietus <mmietus97@yahoo.com>
In-Reply-To: <b8b604f7-c5c3-4257-93da-8f6881e96fe4@openvpn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.24425 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

W dniu 9/9/25 o 13:17, Antonio Quartulli pisze:
> On 09/09/2025 07:43, Marek Mietus wrote:
>> Currently, all xmit flows use dst_cache in a way that references
>> its dst_entry for each xmitted packet. These atomic operations
>> are redundant in some flows.
> 
> Can you elaborate on the current limits/drawbacks and explain what we gain with this new approach?
> 
> It may be obvious for some, but it's not for me.
> 

The only difference with the new approach is that we avoid taking an unnecessary
reference on dst_entry. This is possible since the entire flow is protected by RCU.
This change reduces an atomic write operation on every xmit, resulting in a performance
improvement.

There are other flows in the kernel where a similar approach is used (e.g. __ip_queue_xmit
uses skb_dst_set_noref).

> Also it sounded as if more tunnels were affected, but in the end only ovpn is being changed.
> Does it mean all other tunnels don't need this?
> 

More tunneling code can be updated to utilize these new helpers. I only worked
on OpenVPN, as I am more familiar with it. It was very easy to implement the
changes in OpenVPN because it doesn't use the udp_tunnel_dst_lookup helper
that adds some complexity.

I hope to incorporate these changes in more tunnels in the future.

> 
> Regards,
> 
>>
>> This patchset introduces new noref xmit helpers, and incorporates
>> them in the OpenVPN driver.
> 


