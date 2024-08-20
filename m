Return-Path: <netdev+bounces-120297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5B4958E01
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 20:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F10BB226FB
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 18:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9225D1C3F37;
	Tue, 20 Aug 2024 18:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="E3wCPhpA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8F81C4602
	for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 18:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724178497; cv=none; b=eD8hm/eT+QSciFwsqcR5ZGutPvX7m6Qgxz0hSdnEGwu3WjfgNXmNM9HDnx2hi88/aRY/zHf9iUj+Fjo9F0Fs5DWwK01zDR/P2oX7XeL+GCZl/FpBW7xzCQxt3Ktr7QshX5yxzxcT1yheTRGwdw2h8TobYKK3dy9ZP8gnHqLphzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724178497; c=relaxed/simple;
	bh=wrgJehL7K/UEQqUfKyycmvnDePuaV82pcns2LiZF2Ns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CjK0eJlLpfAjsv181ZQvKLsEDcs4MLRRoLndtbgU+OVC1JuodueRnLIFRt0Mc59rLeA+qCnCc7kbZBxWJPm7FbQ9r84Y2emLWA3wWyD3KdibH2xcehMP1DI1TNnszFEbLMwTccYJx2hdM5LbjB0n7i6oETmjoUJz2iNn0R8M8eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=E3wCPhpA; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5bebd3b7c22so8117305a12.0
        for <netdev@vger.kernel.org>; Tue, 20 Aug 2024 11:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1724178494; x=1724783294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D+Xo0YDMAM+T8E1WVkO3ND+x0XwQweTpbDnJ+nEADrM=;
        b=E3wCPhpAbeN756Iu9FGTpge7DrolKUmdL2sDP/iAYoAsYptI/nmvlHOBqx/C6E1pax
         GF+ghlwrShm136k9P7F88u0jxarxr0ysJNjpVrwyjKtuXQiT9Krw5cmhvPgEelLVeIjf
         D0zZoZkkx3xP3BbfmtgBxEofZvkBChOA83v+S48LYJybVEoVSSMFwPY28fWdLeq8XsPU
         lmeLaLGubKZlhOf2nd/ebniJdEKru7uCrx/zYZX5GwYTyzIBakhHP0FjesuRvvQ46bmi
         lqmPrnl9sBhXXuzwTghGTceAZATEPWz22Q4HFOO8cxiSJbGukhQao28L18H/4ZL4rG30
         iCBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724178494; x=1724783294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D+Xo0YDMAM+T8E1WVkO3ND+x0XwQweTpbDnJ+nEADrM=;
        b=drQjnVr3RA9jkkwlRr2XNkD9x9HnKlHAdNt2wTLPTS/+bIbbfioeqfxhMUrHZ2/XFC
         yRmgVQnl6sYInKwaxxSsWsJf/5B3O9bXxtxgVEifvd1h65iVeULk6IaUIHfk+meywPjR
         wLvD51SAicjTGbZJ9v4Zd/sy4L6UJmkx4RSI3f7sCqb5BHtOWLYCdOox9Wg984si4izU
         YlTawueBRxgvk9H77UdF258j1NoNGtjkFPh5iDieYikjjly18exa1KQr3xmahJMjh8U8
         vE/BqalfRW/bL+0P03XbkclZ8hsYWHZjnPHSXbA6VNMhlxvs/OUlaif4liVqaVY7u1MA
         pZHw==
X-Forwarded-Encrypted: i=1; AJvYcCXF7lKTRSVt08cfvcNYzNNrthVLelaKK9H+KFcCLqcFxxd582J+FdzBYNyY9cQOFpmXWxecpdg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHxA9RkBtxgJ9W/+p4+2yiD5oy5+rsCAk0uChk/ILDqiI5jNwU
	KXc/bKNdETvYHNGOiyRTF+nu+PIN+c8Nw122lV5X9N0v/EpT3Xm3HR74TyHMTS2PRaX7ouOEUew
	S7iJ3J4gibYJOM4Y4O+EPjQjAGwql2SSaWAvY
X-Google-Smtp-Source: AGHT+IEOotSc/zVOfxzQg4cHOLL0C0esMDYP1c27pR+pn1qoxW9gxDS4IwNYaGzXR9MkME+z0rX8hL9XWTm9qwaOu/E=
X-Received: by 2002:a05:6402:34c4:b0:5b8:eb1d:7fec with SMTP id
 4fb4d7f45d1cf-5bf0ac1caabmr3692055a12.6.1724178493213; Tue, 20 Aug 2024
 11:28:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815214527.2100137-1-tom@herbertland.com> <66bfb4665f930_189fc82943f@willemb.c.googlers.com.notmuch>
In-Reply-To: <66bfb4665f930_189fc82943f@willemb.c.googlers.com.notmuch>
From: Tom Herbert <tom@herbertland.com>
Date: Tue, 20 Aug 2024 11:28:02 -0700
Message-ID: <CALx6S36og1_Q+zj5vY4xn4TzBJgHjHOiO6DjdtDVW5g+xEnujw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 00/12] flow_dissector: Dissect UDP
 encapsulation protocols
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com, 
	netdev@vger.kernel.org, felipe@sipanda.io
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 1:19=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Tom Herbert wrote:
> > Add support in flow_dissector for dissecting into UDP
> > encapsulations like VXLAN. __skb_flow_dissect_udp is called for
> > IPPROTO_UDP. The flag FLOW_DISSECTOR_F_PARSE_UDP_ENCAPS enables parsing
> > of UDP encapsulations. If the flag is set when parsing a UDP packet the=
n
> > a socket lookup is performed. The offset of the base network header,
> > either an IPv4 or IPv6 header, is tracked and passed to
> > __skb_flow_dissect_udp so that it can perform the socket lookup.
> > If a socket is found and it's for a UDP encapsulation (encap_type is
> > set in the UDP socket) then a switch is performed on the encap_type
> > value (cases are UDP_ENCAP_* values)
> >
> > Changes in the patch set:
> >
> > - Unconstantify struct net argument in flowdis functions so we can call
> >   UDP socket lookup functions
> > - Dissect ETH_P_TEB in main flow dissector loop, move ETH_P_TEB check
> >   out of __skb_flow_dissect_gre and process it in main loop
> > - Add UDP_ENCAP constants for tipc, fou, gue, sctp, rxe, pfcp,
> >   wireguard, bareudp, vxlan, vxlan_gpe, geneve, and amt
> > - For the various UDP encapsulation protocols, Instead of just setting
> >   UDP tunnel encap type to 1, set it to the corresponding UDP_ENCAP
> >   constant. This allows identify the encapsulation protocol for a
> >   UDP socket by the encap_type
> > - Add function __skb_flow_dissect_udp in flow_dissector and call it for
> >   UDP packets. If a UDP encapsulation is present then the function
> >   returns either FLOW_DISSECT_RET_PROTO_AGAIN or
> >   FLOW_DISSECT_RET_IPPROTO_AGAIN
> > - Add flag FLOW_DISSECTOR_F_PARSE_UDP_ENCAPS that indicates UDP
> >   encapsulations should be dissected
> > - Add __skb_flow_dissect_vxlan which is called when encap_type is
> >   UDP_ENCAP_VXLAN or UDP_ENCAP_VXLAN_GPE. Dissect VXLAN and return
> >   a next protocol and offset
> > - Add __skb_flow_dissect_fou which is called when encap_type is
> >   UDP_ENCAP_FOU. Dissect FOU and return a next protocol and offset
> > - Add support for ESP, L2TP, and SCTP in UDP in __skb_flow_dissect_udp.
> >   All we need to do is return FLOW_DISSECT_RET_IPPROTO_AGAIN and the
> >   corresponding IP protocol number
> > - Add __skb_flow_dissect_geneve which is called when encap_type is
> >   UDP_ENCAP_GENEVE. Dissect geneve and return a next protocol and offse=
t
> > - Add __skb_flow_dissect_gue which is called when encap_type is
> >   UDP_ENCAP_GUE. Dissect gue and return a next protocol and offset
> > - Add __skb_flow_dissect_gtp which is called when encap_type is
> >   UDP_ENCAP_GTP. Dissect gtp and return a next protocol and offset
> >
> > Tested: Verified fou, gue, vxlan, and geneve are properly dissected for
> > IPv4 and IPv6 cases. This includes testing ETH_P_TEB case
>
> On our conversation in v1 that this is manual:
>
> Would be really nice to have some test coverage for flow dissection.
> We only have this for BPF flow dissection. This seems like a suitable
> candidate for KUNIT. Like gso_test_func. Don't mean to put you on the
> spot per se to add this coverage.

Sure. We'll add a KUNIT test for flow dissector (it sorely needs that!)

Tom

