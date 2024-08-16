Return-Path: <netdev+bounces-119302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA0F9551C8
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 22:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1CDC1C222C1
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 20:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266E61C2325;
	Fri, 16 Aug 2024 20:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQwEg/An"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AEB137747
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 20:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723839594; cv=none; b=TQvIX2U7qGOLB0tnHp+Uj8MQ0TGGh87fmkHUe66EBy1NvbWGYOtYKgsAhS31b1LVmAiw7D8DjukmuoxQXU+YI3Qc6o5xxeSHhpPc3AhfQBH17/ie4SPxQcW1Py3857wiygd0AAa0y2boTAF6Hii/rATsUsksVm2HhnEht4Ldj6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723839594; c=relaxed/simple;
	bh=0xMHdK0FaZUj18ZbQGMQyrX+CSIGmalQycagJEUGKhc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=RwuBARRwpLbF7alvlS84qk02okuiXnkGLA7B6jhpmebVyTk9gQIlwIg7gZLYl5gijnWDDNwW8RzJ2NU0gWiH7JnOutF6ewMu0McDrTChGFWYaHtQIKQA3fktxKz42oYGWGVjIlrHGcCv/gCqpc6d27z9kNAvgenBXQAmIjHCDS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQwEg/An; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6bf8a662467so306156d6.3
        for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 13:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723839591; x=1724444391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z37q86JQECF4rjl1GpfzT2CFZTibw25QGDQWckB1asI=;
        b=eQwEg/AnzfmF8uVEE/mdd+39tEC5bfIgbU2m3+rxkVfIJ49aCPk6AOs0PryRdL38Uq
         IbvtGO56OPkMmetkxfgbeQbIs1QqAZ/46N1jlwCK9wKklF6FihlEBhcxBuFh9g5PvQ9E
         3cb/M6awSUqS4AQjFYQz/kl7sv2nZ2V6mR27hCX9r4eMmEmUstWemvsNC8XjiYMcTXYf
         /xy6cAUMIPeUiLo5o7ZbEiX5PbbYeraNdmhUVYq2If9Vq9xm8rDcF8Py1S82TlBb+NMJ
         TcKD8rO1wAByXKgvPZZ8A4N5pGZQIc3AStwHEiFPC9dk5FAZg1if2XTEtmiJezhqrduL
         01xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723839591; x=1724444391;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z37q86JQECF4rjl1GpfzT2CFZTibw25QGDQWckB1asI=;
        b=TOka3JUgODYhKOVtF1UVjlNCB7lftOAbvV9znvJDX3+UEqVj6lPXoQeR1qYkQrBKzG
         NOFayv6XzCPBdEEH52XDc9DLE633yvq1b+EqPQETTxBBoZXUCZCeXzVU6G1OFWTNBtTA
         kSk5SVGPFjeW7yKgApzcnYS/klFVhWFtwklQcx1KIv9Na1djjklE/xv5qIxVpDAn9hok
         9OOwjRc2jyR/JlyZ9ZIKXyqy0vicil24VTL3cjT13wLo70mJKSLK4DbgzNicHpYr4EIP
         WxzKRunCYUw3dDxBpccDseyml91QMhka1N/F9DvptJZpE4WNZWaBGWq5O78KxSnEeitj
         0wOA==
X-Forwarded-Encrypted: i=1; AJvYcCXQsAk2Ha7EnkEmtBE54g9pEwKPo8zwsL3vpAcbP4HufYZQH2pUNHUWDDhpw1nmBQL65Ex0UBCpRiHpSq1Vu0MOqf18yjH9
X-Gm-Message-State: AOJu0YzSVyaa0wX8NB4VRd6/u8VU9/KqNd4FY4Zkz2u+xLMDWY1QrUZd
	oueto5qex5vruS1f4hr5/eKGFfb+Bw8hjL5jXvibw9jvaZFI3lSowERBsg==
X-Google-Smtp-Source: AGHT+IEn6hkutqN4xPSigzr4xwgN03A3fP296ZcNOA139m7Nu7wKy3JJKH2ndyRwjD0z9wRo7SheLA==
X-Received: by 2002:a05:6214:3bc2:b0:6b2:9d0b:6148 with SMTP id 6a1803df08f44-6bf7ce954b4mr37569396d6.53.1723839591195;
        Fri, 16 Aug 2024 13:19:51 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6fec5e6asm21265456d6.79.2024.08.16.13.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 13:19:50 -0700 (PDT)
Date: Fri, 16 Aug 2024 16:19:50 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Tom Herbert <tom@herbertland.com>, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 netdev@vger.kernel.org, 
 felipe@sipanda.io, 
 willemdebruijn.kernel@gmail.com
Cc: Tom Herbert <tom@herbertland.com>
Message-ID: <66bfb4665f930_189fc82943f@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240815214527.2100137-1-tom@herbertland.com>
References: <20240815214527.2100137-1-tom@herbertland.com>
Subject: Re: [PATCH net-next v2 00/12] flow_dissector: Dissect UDP
 encapsulation protocols
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Tom Herbert wrote:
> Add support in flow_dissector for dissecting into UDP
> encapsulations like VXLAN. __skb_flow_dissect_udp is called for
> IPPROTO_UDP. The flag FLOW_DISSECTOR_F_PARSE_UDP_ENCAPS enables parsing
> of UDP encapsulations. If the flag is set when parsing a UDP packet then
> a socket lookup is performed. The offset of the base network header,
> either an IPv4 or IPv6 header, is tracked and passed to
> __skb_flow_dissect_udp so that it can perform the socket lookup.
> If a socket is found and it's for a UDP encapsulation (encap_type is
> set in the UDP socket) then a switch is performed on the encap_type
> value (cases are UDP_ENCAP_* values)
> 
> Changes in the patch set:
> 
> - Unconstantify struct net argument in flowdis functions so we can call
>   UDP socket lookup functions
> - Dissect ETH_P_TEB in main flow dissector loop, move ETH_P_TEB check
>   out of __skb_flow_dissect_gre and process it in main loop
> - Add UDP_ENCAP constants for tipc, fou, gue, sctp, rxe, pfcp,
>   wireguard, bareudp, vxlan, vxlan_gpe, geneve, and amt
> - For the various UDP encapsulation protocols, Instead of just setting
>   UDP tunnel encap type to 1, set it to the corresponding UDP_ENCAP
>   constant. This allows identify the encapsulation protocol for a
>   UDP socket by the encap_type
> - Add function __skb_flow_dissect_udp in flow_dissector and call it for
>   UDP packets. If a UDP encapsulation is present then the function
>   returns either FLOW_DISSECT_RET_PROTO_AGAIN or
>   FLOW_DISSECT_RET_IPPROTO_AGAIN
> - Add flag FLOW_DISSECTOR_F_PARSE_UDP_ENCAPS that indicates UDP
>   encapsulations should be dissected
> - Add __skb_flow_dissect_vxlan which is called when encap_type is
>   UDP_ENCAP_VXLAN or UDP_ENCAP_VXLAN_GPE. Dissect VXLAN and return
>   a next protocol and offset
> - Add __skb_flow_dissect_fou which is called when encap_type is
>   UDP_ENCAP_FOU. Dissect FOU and return a next protocol and offset
> - Add support for ESP, L2TP, and SCTP in UDP in __skb_flow_dissect_udp.
>   All we need to do is return FLOW_DISSECT_RET_IPPROTO_AGAIN and the
>   corresponding IP protocol number
> - Add __skb_flow_dissect_geneve which is called when encap_type is
>   UDP_ENCAP_GENEVE. Dissect geneve and return a next protocol and offset
> - Add __skb_flow_dissect_gue which is called when encap_type is
>   UDP_ENCAP_GUE. Dissect gue and return a next protocol and offset
> - Add __skb_flow_dissect_gtp which is called when encap_type is
>   UDP_ENCAP_GTP. Dissect gtp and return a next protocol and offset
> 
> Tested: Verified fou, gue, vxlan, and geneve are properly dissected for
> IPv4 and IPv6 cases. This includes testing ETH_P_TEB case

On our conversation in v1 that this is manual:

Would be really nice to have some test coverage for flow dissection.
We only have this for BPF flow dissection. This seems like a suitable
candidate for KUNIT. Like gso_test_func. Don't mean to put you on the
spot per se to add this coverage.

