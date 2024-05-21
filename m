Return-Path: <netdev+bounces-97352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DC28CAF63
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 15:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81F531F213A4
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 13:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D3B7C080;
	Tue, 21 May 2024 13:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jg5XynX0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC1474402;
	Tue, 21 May 2024 13:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716298088; cv=none; b=Up7gVaXwOnY8d48y9ZC4+VHL+fSLlnL0c/Cd3w7i10WvuCwqKkKVAKS2hMpPD+/4piM5NJdEpg9oHE0d8b3FLC4e0HxFcU2i11LPvMsCpntG3PxEgCVMD3Q1z9pzK2hJl6FoHwWMroyHM+u0XzPPyS74agUOAiu6iLU2LnWqzkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716298088; c=relaxed/simple;
	bh=8Y0BGJQoG0sFHIfWN88ngXGGt52PHzd+2ZY6ElIjqko=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=fRZGLV9/DiAv+4EubArwnf51tD2O48T7IlvGt6P/yUv591WbylJb6S89ocwlp/9M2y/LW4Vcu13mnQ/Y+os1oIGJaQXWSmxgKLzl6hvrP0Id1rhGNxnBc2tVC1bTMlRJNtA8oQeQEUnC+IesCwxn2CFuEbFaMVEdgWKOAmAy1hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jg5XynX0; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6f0f0494459so1870072a34.0;
        Tue, 21 May 2024 06:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716298086; x=1716902886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bbIgOLpzG4vXxc22KYrE2SrHl7lK44oErsKTjleZKcw=;
        b=jg5XynX0NlltK3Syj94ccmahJttCqv16OU1svAol3Iaoe4uO8PMRUwBeGsE9m+VxJh
         iKywOZBbbMOJ9xxaWrojq/0pJiFXTPvF58zyAq/YoOHVSfXTg6FUUqLffAZWLKn4NXqm
         Ij3/xKz6yTYUcArGSvDUyhSgXS8TXhajniu2whOXwK6+sV3xD1+OZhb6hHn/ndWwSxhf
         sHqA15AjSZ0lI3RGsWEOJZr7yp+imf7FEcyh4DvJ5TgLZ48O9TMFQ99nLn0bNdL4vshq
         tAzUYrfOSxVUhGQq/SDRfUOvkoUz+cAHY/eTuCg5DvuyFw6TpaOdi3va8LQaep1CW6Qa
         UMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716298086; x=1716902886;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bbIgOLpzG4vXxc22KYrE2SrHl7lK44oErsKTjleZKcw=;
        b=KP5qKLnxhS8Jr7MuznppVC28j2MHZoBxJTt1yXSOOKNRwIWdKosfTSusWnRzopHZf5
         iv6JuczzFKcU7sfspz8iemIZ3wix4QGp6rgIkd3Fs0+zGPwWRRsxwV56soxBHTzZkwtm
         Gna2LSm+zE7OqzLnGLUgu0tuTu7W2ScQfyVPnlmow0DffbscRv7CkFZK5i+ftAFEFlHM
         x7bQHA0fbt9AQNgQ3mz+E47UFqsfBkUxKyYDsUgXMnBGco76VU7FlikLJEdgtpYMm2jE
         TuTfzIphIYra4baB67ZkzKyELcS2cTxP6SURUWppMsfCc8Jbbl2NtFimPNrZSkp5cEX0
         O3mA==
X-Forwarded-Encrypted: i=1; AJvYcCVjVeyaKcks2YatsLtFlYYeh01Zd/AaI20kq8jOGoH9su2cA6kfe5s1oqvv6rylWG467hu9RUXtf2Nq+AS7rcmTdi/2ICasiNO4aLoD3fEJzQz1Zi/4dMEm8EumUp++/1lpyre3
X-Gm-Message-State: AOJu0Yxpky62HXhpn26xEpXqN2dxPEVR0VsOka4QGREkgay4Il/6DDGU
	2ZDUzSyMLMLB64w0LO7P/voLccd3tYFnqs9VF1kE0bFbK7NWMNMv
X-Google-Smtp-Source: AGHT+IFaYm+C6rOe4i0VM7G01zBuNZaRoCmqj106+wmUzanWOMOwdbHFV5j3m6Eu+twRIEy4C2csDQ==
X-Received: by 2002:a9d:73c4:0:b0:6f0:3804:4839 with SMTP id 46e09a7af769-6f0e9111461mr31510403a34.13.1716298085630;
        Tue, 21 May 2024 06:28:05 -0700 (PDT)
Received: from localhost (112.49.199.35.bc.googleusercontent.com. [35.199.49.112])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79312697702sm445272985a.12.2024.05.21.06.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 06:28:05 -0700 (PDT)
Date: Tue, 21 May 2024 09:28:05 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, 
 Chengen Du <chengen.du@canonical.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <664ca1651b66_14f7a8294cb@willemb.c.googlers.com.notmuch>
In-Reply-To: <eaf33ba66cbdc639b0209b232f892ec8a52a1f21.camel@redhat.com>
References: <20240520070348.26725-1-chengen.du@canonical.com>
 <664b97e8abe7a_12b4762946f@willemb.c.googlers.com.notmuch>
 <CAPza5qcGyfcUYOoznci4e=1eaScVTgkzAhXfKSG3bTzC=aOwew@mail.gmail.com>
 <eaf33ba66cbdc639b0209b232f892ec8a52a1f21.camel@redhat.com>
Subject: Re: [PATCH] af_packet: Handle outgoing VLAN packets without hardware
 offloading
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Paolo Abeni wrote:
> On Tue, 2024-05-21 at 11:31 +0800, Chengen Du wrote:
> > I would appreciate any suggestions you could offer, as I am not as
> > familiar with this area as you are.
> > 
> > I encountered an issue while capturing packets using tcpdump, which
> > leverages the libpcap library for sniffing functionalities.
> > Specifically, when I use "tcpdump -i any" to capture packets and
> > hardware VLAN offloading is unavailable, some bogus packets appear.

Bogus how exactly?

> > In this scenario, Linux uses cooked-mode capture (SLL) for the "any"
> > device, reading from a PF_PACKET/SOCK_DGRAM socket instead of the
> > usual PF_PACKET/SOCK_RAW socket.

Trying to extract L2 or VLAN information from the any device may be
the real issue here.

> > 
> > Using SOCK_DGRAM instead of SOCK_RAW means that the Linux socket code
> > does not supply the packet's link-layer header.
> > Based on the code in af_packet.c, SOCK_DGRAM strips L2 headers from
> > the original packets and provides SLL for some L2 information.
> 
> > From the receiver's perspective, the VLAN information can only be
> > parsed from SLL, which causes issues if the kernel stores VLAN
> > information in the payload.

ETH_HLEN is pulled, but the VLAN tag is still present, right?

> > 
> > As you mentioned, this modification affects existing PF_PACKET receivers.
> > For example, libpcap needs to change how it parses VLAN packets with
> > the PF_PACKET/SOCK_RAW socket.
> > The lack of VLAN information in SLL may prevent the receiver from
> > properly decoding the L3 frame in cooked mode.
> > 
> > I am new to this area and would appreciate it if you could kindly
> > correct any misunderstandings I might have about the mechanism.
> > I would also be grateful for any insights you could share on this issue.
> > Additionally, I am passionate about contributing to resolving this
> > issue and am willing to work on patches based on your suggestions.
> 
> One possible way to address the above in a less invasive manner, could
> be allocating a new TP_STATUS_VLAN_HEADER_IS_PRESENT bit, set it for
> SLL when the vlan is not stripped by H/W and patch tcpdump to interpret
> such info.

Any change must indeed not break existing users. It's not sufficient
to change pcap/tcpdump. There are lots of other PF_PACKET users out
there. Related, it is helpful to verify that tcpdump agrees to a patch
before we change the ABI for it.

