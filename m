Return-Path: <netdev+bounces-173981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AACCA5CC23
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 18:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A169177C6F
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 17:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F08A2620E7;
	Tue, 11 Mar 2025 17:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKWmWt4L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3F725D8EF
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 17:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741714191; cv=none; b=QuCMr+WEBGmXYoVuh1QP875GRMKy6mYXNo0D4yKb4z3HGNOYsvHLB/QRvnLSznYWvhyaGcZAkNwQlUUAYd/IBl6bh2exBvA66LJ2p4OnvoLXdB3CI0s4JJHpRmcryoBorH2yi3ERhxQfoTPVjvCpvI+Yg3i3oAwLhujRIdSrySo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741714191; c=relaxed/simple;
	bh=MCeXPn0FqwyjlBlH6DpqS2Ql/dZf9NWXTEyA5HGntMg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=O6LiyF/f5P0BW4yGnL1qr+k08F5jCMwRhTrJYC4QQDeVUriYoIsYKjNwpp3I6LPpKHD9b1NsCkICehjp9DkoVyHGv90Csx1oYI0ACeQv69N6SyyKwdG1LHui5kbkcsoUhLO906CAr71MSQ2gu54/QO3Ujc+AQybShLZUvK0tNgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iKWmWt4L; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c3bf231660so598053685a.0
        for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 10:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741714189; x=1742318989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tnn7mBc19AwJuhTYqlYalLmUveKUf4Cc28rlupWmI8Y=;
        b=iKWmWt4LltEK+S9DTIaZkHkvDCPGrUIwkcviDKagk8w1VI6vV5n6xPC+78Kx+fot5E
         A+wSxn2bO8C83ZxLjYvqsWk+fXAN8PZyhfdXFCbQATYh1qUdbvvle1it0M8aIdmeMPt4
         oYNcd0oByadYKuWD0T3TCfZT9KO1YDVggrGGAc27LR+Hah/NUiOD0OXfiOCY04SvisGA
         pGVpl5DK/9LIDdkPn2+J73qj6lMfVEMqA2N7PwtGgZYh9uy11K/mNZoMtQwjGoS2iEuA
         y+SnIjnkigxqePtGKpAfSM12R/4mZCfzJhNs7Yz5Z0Y5/PcYZb4VbfoROzJoo7OIhOId
         wWjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741714189; x=1742318989;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tnn7mBc19AwJuhTYqlYalLmUveKUf4Cc28rlupWmI8Y=;
        b=B9+/AwTSHrhTELiQvaM0aoI6oVEm62DFdbQV3gMFX+UWuzy1jYbQ6UXEp0ErRbt7oK
         z3iEpER9fIgNvdF7ZgrsSQl8+3zFfsMYZL0y5vPDOUA74S0drISxanHr3W1aZ0p8YA1P
         jAC8Svscvq04JvIsM8HCbxZjdmzJVr48W6NqNpqzcuckP68kKDTbNO957CBVEwWhVeF6
         jMkbKG6g5pksPKh9PdsaWnvELk/S2lPZ15EOkH6vQd2Ieso/KVaiOLOMpAmT8qEIaA60
         FKcv62nTPZCQOXTODpvAF1XBWM11Llbq2RzJ9YT6U+GtVVB7vSsFlHIoBKg8HC6k+4A1
         IRDg==
X-Forwarded-Encrypted: i=1; AJvYcCWpINPTbHlVxtBhiEqnng9sxlamn+gy1WNFpb5xrjkvj146xFY3yztW6P7P6de9WkO3YhCq3ow=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgZwYNA73SE4AVBfn0TxAUGHHHVij0kX5MiIHadsN8sfipoVkT
	CMwzeESvu88bMd11eJ+picCT3u34uuXbkLsmO1PD2PAS0E41tbna
X-Gm-Gg: ASbGncuTZUToi6kYbkvspRq50I6s9yEhpPkp30jJ94ZSQW7oSgKmkgsLb+jaRDehM1s
	W3514O5miCqLitxhLOdCZC8VSSD1gHD6NT3wQdCeVtgfXgW6ojl+I5LcAItF+p21VRium5qI2M9
	pGSi+EEogK1J0A46SCdfnxoFnh2OJZbKd6cKjszKqvmY+XktEUl2nJ2u4R5Ui//uOP5FwzPHU64
	AXjALUheqJrqmW6E+WcGV80IpjafTpBwIX+xBLjk2j7EOPf+QAn+rEUZhQnUzwwByG6L95iYVo9
	KUWOgq8uviX0jS6BLf3Z/5HsClO5BWRiThOkrpKtFdijgQ8FWDff49iyAsapbRlDklz+lguJZDl
	B+lEhMksDNC5qdpNbbehaUg==
X-Google-Smtp-Source: AGHT+IF3wgrP1LUf7DR8ATE/GFjOMTV/2NMlpTHN1l69Q5noVO8TyrMUYcbnC9mf6hpFGKyhSLRDrA==
X-Received: by 2002:a05:6214:2426:b0:6e8:8d76:f389 with SMTP id 6a1803df08f44-6e9006cad69mr293945916d6.36.1741714188676;
        Tue, 11 Mar 2025 10:29:48 -0700 (PDT)
Received: from localhost (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e8f7090d56sm74555156d6.42.2025.03.11.10.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 10:29:47 -0700 (PDT)
Date: Tue, 11 Mar 2025 13:29:47 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, 
 David Ahern <dsahern@kernel.org>, 
 kuniyu@amazon.com
Message-ID: <67d0730b8bee7_2fa72c29418@willemb.c.googlers.com.notmuch>
In-Reply-To: <7a4c78fa-1eeb-4fa9-9360-269821ff5fdb@redhat.com>
References: <cover.1741632298.git.pabeni@redhat.com>
 <fe46117f2eaf14cf4e89a767d04170a900390fe0.1741632298.git.pabeni@redhat.com>
 <67cfa0c7382ef_28a0b3294dd@willemb.c.googlers.com.notmuch>
 <7a4c78fa-1eeb-4fa9-9360-269821ff5fdb@redhat.com>
Subject: Re: [PATCH v3 net-next 1/2] udp_tunnel: create a fastpath GRO lookup.
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
> On 3/11/25 3:32 AM, Willem de Bruijn wrote:
> > Paolo Abeni wrote:
> >> Most UDP tunnels bind a socket to a local port, with ANY address, no
> >> peer and no interface index specified.
> >> Additionally it's quite common to have a single tunnel device per
> >> namespace.
> >>
> >> Track in each namespace the UDP tunnel socket respecting the above.
> >> When only a single one is present, store a reference in the netns.
> >>
> >> When such reference is not NULL, UDP tunnel GRO lookup just need to
> >> match the incoming packet destination port vs the socket local port.
> >>
> >> The tunnel socket never sets the reuse[port] flag[s]. When bound to no
> >> address and interface, no other socket can exist in the same netns
> >> matching the specified local port.
> > 
> > What about packets with a non-local daddr (e.g., forwarding)?
> 
> I'm unsure if I understand the question. Such incoming packets at the
> GRO stage will match the given tunnel socket, either by full socket
> lookup or by dport only selection.
> 
> If the GSO packet will be forwarded, it will segmented an xmit time.
> 
> Possibly you mean something entirely different?!?

Thanks, no that is exactly what I meant:

Is a false positive possible? So answer is yes.

Is it safe. So, yes again, as further down the stack it just handles
the GSO packet correctly.

Would you mind adding that to commit message explicitly, since you're
respinning anyway?


