Return-Path: <netdev+bounces-85212-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAE7899CCA
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 14:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 039D51F219E5
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 12:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C47B16C86A;
	Fri,  5 Apr 2024 12:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="vmXyK3TO"
X-Original-To: netdev@vger.kernel.org
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B90218E1D
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 12:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712319678; cv=pass; b=k/YPUVSrmhR35KSOnvI9BE/oF1vnWzJ3PgI0zxNL/LRZlcSWN1a0SeF88GoG0FaOa96LqIuZ/gb795ylAUKoMySvPB23nniWqiPuLFyEzrw/KvR29bv/X6feNsnCp0AOvOE0bRFtNjotwhk9aze0GkZIMKNtAeqonbr7vV3PQpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712319678; c=relaxed/simple;
	bh=uD/SKuVfYJgw+kJuYQY7jFjVTw2oMeT7wcpeNTunZEk=;
	h=MIME-Version:Content-Type:Message-ID:Date:From:To:Cc:Subject:
	 In-Reply-To:References; b=ZkR0CcFYRRp6Lur27eY4zjW8MgQgurgiW5UcWQ5lQivkDO7gojG0BWIrQd2MgpfBpX5Ru/zKo6HHZtnduG7eZrWQ5ffXLmYFtGn3Nn0bXwljgO9wq1+CGdDEPpGzGoAO0XDOskpFQMT5bQTaxalsDCLkH/v1AQdPeu0TQHx+ftg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=vmXyK3TO; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from fireball.acr.fi (fireball.kivinen.iki.fi [IPv6:2001:1bc8:100d::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kivinen@iki.fi)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4V9yJN1GYYzySQ;
	Fri,  5 Apr 2024 15:21:07 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1712319672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MrY/soyaq/0y7Bfjqa1EJNVyzv6CBBv0YeY/UjE6c54=;
	b=vmXyK3TOAW9M1cUNdneeudH5C0DEWhVOMKgd4cnEOzPx3PdXlic0va9P+vEmdPPn09pAFr
	DOKbzl31+q4X5LpxCrkfhYTxpH/IdQZNpj9YAWSLAHn79Ng5eNO0hhAdLFTqng+oN1XIDN
	AZxUKFdvY2JsVCtMb8hgNProaa2wnSE=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1712319672; a=rsa-sha256; cv=none;
	b=WoGDUSxAJ2d91Dc5Pg1rZt6Fej7nqf8B5VkQfYgMs3PyK3ZeUkz8COIhOp+h1poPAa7cCV
	C4uekOUup9UxzH5qnYwyphKG6QRjcnID+4zx2GdszcuhoJflJICxDLwCrNU76EFQ9emdZz
	/M34L1zD2opleD+aGXImcKDaHbh2UG0=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=kivinen@iki.fi smtp.mailfrom=kivinen@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1712319672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MrY/soyaq/0y7Bfjqa1EJNVyzv6CBBv0YeY/UjE6c54=;
	b=ONVLXueROSCox27zjxRM2vD7cDj9i0JeW0b0q2rFMuT2y/RE8Jlgm2XZqWn1ppP66XK6IU
	Hjmo+wQAghcaeIxMWktOdbtW+Y/g4CA6Nf6ipcqoWT2+7CaD04lV6EKSMHXZsDtpcAn/Jl
	nfwVCLMiqBti2Y6FTdT/TZRAZvrXFXw=
Received: by fireball.acr.fi (Postfix, from userid 15204)
	id A45E725C108E; Fri,  5 Apr 2024 15:21:06 +0300 (EEST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <26127.60594.628257.929728@fireball.acr.fi>
Date: Fri, 5 Apr 2024 15:21:06 +0300
From: Tero Kivinen <kivinen@iki.fi>
To: Michael Richardson <mcr@sandelman.ca>
Cc: Antony Antony <antony@phenome.org>,
    Herbert Xu <herbert@gondor.apana.org.au>,
    netdev@vger.kernel.org,
    David Ahern <dsahern@kernel.org>,
    devel@linux-ipsec.org,
    Eric Dumazet <edumazet@google.com>,
    Jakub Kicinski <kuba@kernel.org>,
    Paolo Abeni <pabeni@redhat.com>,
    "David S. Miller" <davem@davemloft.net>
Subject: Re: [devel-ipsec] [PATCH net 1/1] xfrm: fix source address in icmp
 error generation from IPsec gateway
In-Reply-To: <7748.1712241557@obiwan.sandelman.ca>
References: <cover.1712226175.git.antony.antony@secunet.com>
	<20ea2ab0472ecf2d1625dadb7ca0df39cf4fe0f5.1712226175.git.antony.antony@secunet.com>
	<28050.1712230684@obiwan.sandelman.ca>
	<Zg6aIbUV-oj4wPMq@Antony2201.local>
	<7748.1712241557@obiwan.sandelman.ca>
X-Mailer: VM 8.2.0b under 26.3 (x86_64--netbsd)
X-Edit-Time: 3 min
X-Total-Time: 2 min

Michael Richardson via Devel writes:
> 
> Antony Antony <antony@phenome.org> wrote:
>     > Indeed, 10.1.3.2 does not match the policy. However, notice the "flag
>     > icmp" in the above line. That means the policy lookup will use the
>     > inner payload for policy lookup as specified in RFC 4301, Section 6,
>     > which will match. The inner payload 10.1.4.1 <=> 10.1.4.3 will match
>     > the policy.
> 
> How is "flag icmp" communicated via IKEv2?
> Won't the other gateway just drop this packet?

It is not specified in IKE, it is mandated by the RFC4301 section 6.2: 
----------------------------------------------------------------------
6.2.  Processing Protected, Transit ICMP Error Messages
...
   If no SA exists that would carry the outbound ICMP message in
   question, and if no SPD entry would allow carriage of this outbound
   ICMP error message, then an IPsec implementation MUST map the message
   to the SA that would carry the return traffic associated with the
   packet that triggered the ICMP error message.  This requires an IPsec
   implementation to detect outbound ICMP error messages that map to no
   extant SA or SPD entry, and treat them specially with regard to SA
   creation and lookup.  The implementation extracts the header for the
   packet that triggered the error (from the ICMP message payload),
   reverses the source and destination IP address fields, extracts the
   protocol field, and reverses the port fields (if accessible).  It
   then uses this extracted information to locate an appropriate, active
   outbound SA, and transmits the error message via this SA.  If no such
   SA exists, no SA will be created, and this is an auditable event.

   If an IPsec implementation receives an inbound ICMP error message on
   an SA, and the IP and ICMP headers of the message do not match the
   traffic selectors for the SA, the receiver MUST process the received
   message in a special fashion.  Specifically, the receiver must
   extract the header of the triggering packet from the ICMP payload,
   and reverse fields as described above to determine if the packet is
   consistent with the selectors for the SA via which the ICMP error
   message was received.  If the packet fails this check, the IPsec
   implementation MUST NOT forwarded the ICMP message to the
   destination.  This is an auditable event.
-- 
kivinen@iki.fi

