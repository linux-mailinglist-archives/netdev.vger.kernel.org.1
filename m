Return-Path: <netdev+bounces-120307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC66958E4E
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 20:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 213C6B2291E
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 18:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470EB1537C7;
	Tue, 20 Aug 2024 18:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1UB/WKBa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DD1130499
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 18:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724179960; cv=none; b=iV9hJKVA7b++h27CdgSqWwWruzHvr4Snc8mW5nU5itjCWxx/SB2cMOTOEmkRe2sRztTriaUgxE1UzTUHpKXOVlyFXH/UEakbpW6dN9Fdd8esrg3nBf+EBQnLnQvlwa95w5PFIPG55jYlWEvA0ju0toyru28+j2rlMOpafauqMEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724179960; c=relaxed/simple;
	bh=QDgHftprLEbyAagP+9tD9LXCAP4ZoqlTSpN8OAlO+A0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RUaJXsw+MtEZiFtvPsPVmxOQky12ZMxbg/9OyTYwuyTi8FPaL6IWUow2CwnF48d1V53MFx7NbFvKhxXFQPO5/AH7Ane5Kj9Dt6DZHDfTK8qVEHyxcw9Y6HZ3b8qH29HpLpBRyyIJR7W79P4zzYWI6xgIomiUB/jShd590Ir0uwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1UB/WKBa; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a7d26c2297eso669632966b.2
        for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 11:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724179957; x=1724784757; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bt9yHYNeM460PfDzTwuaVKqN87p2jchKeryLrqdp3EI=;
        b=1UB/WKBaWZx1haTXWw9k+7xYKY6j4o+XKKcQMlbohlF8EXjqV4G84U7rGWhZ2UsPvo
         4He4zdphGqSXGEQXnrlzMqY+jWo7gUgne6c+iGfeO+wpJX82t9RI1tZ8KwylEQksP3ZT
         9TCld6WSEXgSxomvHcnV0CNpZuoTDJHre68ywF7FoVREPntFOAuT8fuMrsVRmVSqZexX
         mK8k2uUHVQKyX0GPQskAMDWGZKClfDWMPCOpaZGr+RGLdvte9JwKCI4qaPeFnXCmke6k
         B42VRnxsH5yV1+n6XedL9VUBxCLMtByqbxCpQtFDF1vwxsO1lh9uKIm3b7FEsLt62MJB
         m+CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724179957; x=1724784757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bt9yHYNeM460PfDzTwuaVKqN87p2jchKeryLrqdp3EI=;
        b=tAo+kd1XXdYlLwRTy0j13Vm/MWyav5t7lkZ1ICCNG6BG6I9WyqMJcvyWxh5aKyFrIn
         FX8+RGgTJ57huNl7Cb6T1thvuSBla7C0mJd+zws8lABkAhAoWMTcN0XrEhBTqD69vNf6
         deorP3rVrBen5BTzPTZOno7ulWodk5RZMIBkYy8HCaTVYvaDTLIf96PcPmZxY2HYATUl
         sfqmeNX/UD6Dwwj+fUo1Al8pWFGP2k4rxrlYCUAQteHyaMy6CHQBfVHVw3rqD5XJyjwO
         pCkJ8/zMJjDBH1bgRyt0Fvb9/5L2h/kzddKo0LC6vh8MfezShyhK+qtatAwBLE3oP2tt
         C1hg==
X-Forwarded-Encrypted: i=1; AJvYcCUCwfIfKVfEg4WU53tIIaBXBZ6zEmVXfszCOrO3QrAwWXFureD9lG7bOHtIgCl0QPU/pk23kL8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUOEhlawSIS+nOQScTRraE2cVUWgotqbgU7cRSaxXRL9Aj0gp5
	+bBZY983E9xNJ0p5PDqqU7xSvJT5Km6faKjHMUBpYNdR9e2jFCpOXAPZfEXs5132OEkScVjMn2S
	f31RmVDO4+4udXvrVX0s24IHruvF1M3s1anft
X-Google-Smtp-Source: AGHT+IEGQM5whJ3Od7eV8UeQbStQvqbfA5b47vgZXnDfkzksNO4vzPX1nrfWO1BE3rrETNjEb15DG//fso2XDvVMtJk=
X-Received: by 2002:a17:907:f1de:b0:a80:f358:5d55 with SMTP id
 a640c23a62f3a-a8392953a55mr1123092866b.33.1724179956277; Tue, 20 Aug 2024
 11:52:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815214527.2100137-1-tom@herbertland.com> <20240815214527.2100137-5-tom@herbertland.com>
In-Reply-To: <20240815214527.2100137-5-tom@herbertland.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 20 Aug 2024 20:52:22 +0200
Message-ID: <CANn89iJqv_5Qg-EAZsqmTnu9Jv15Tg1SvALhscvmdquuSmJhog@mail.gmail.com>
Subject: Re: [PATCH net-next v2 04/12] flow_dissector: UDP encap infrastructure
To: Tom Herbert <tom@herbertland.com>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org, 
	felipe@sipanda.io, willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 11:46=E2=80=AFPM Tom Herbert <tom@herbertland.com> =
wrote:
>
> Add infrastructure for parsing into UDP encapsulations
>
> Add function __skb_flow_dissect_udp that is called for IPPROTO_UDP.
> The flag FLOW_DISSECTOR_F_PARSE_UDP_ENCAPS enables parsing of UDP
> encapsulations. If the flag is set when parsing a UDP packet then
> a socket lookup is performed. The offset of the base network header,
> either an IPv4 or IPv6 header, is tracked and passed to
> __skb_flow_dissect_udp so that it can perform the socket lookup
>
> If a socket is found and it's for a UDP encapsulation (encap_type is
> set in the UDP socket) then a switch is performed on the encap_type
> value (cases are UDP_ENCAP_* values)
>
> An encapsulated packet in UDP can either be indicated by an
> EtherType or IP protocol. The processing for dissecting a UDP encap
> protocol returns a flow dissector return code. If
> FLOW_DISSECT_RET_PROTO_AGAIN or FLOW_DISSECT_RET_IPPROTO_AGAIN is
> returned then the corresponding  encapsulated protocol is dissected.
> The nhoff is set to point to the header to process.  In the case
> FLOW_DISSECT_RET_PROTO_AGAIN the EtherType protocol is returned and
> the IP protocol is set to zero. In the case of
> FLOW_DISSECT_RET_IPPROTO_AGAIN, the IP protocol is returned and
> the EtherType protocol is returned unchanged
>
> Signed-off-by: Tom Herbert <tom@herbertland.com>

I am a bit confused.

How is this series netns ready ?

tunnel decap devices can be in different netns from the lower device.

socket lookups need the correct net pointer.

