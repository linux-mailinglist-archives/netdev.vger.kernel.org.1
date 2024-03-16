Return-Path: <netdev+bounces-80220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C38E287DA67
	for <lists+netdev@lfdr.de>; Sat, 16 Mar 2024 15:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE4BEB212B0
	for <lists+netdev@lfdr.de>; Sat, 16 Mar 2024 14:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1783018E1D;
	Sat, 16 Mar 2024 14:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENUIwmla"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6338E18EA1
	for <netdev@vger.kernel.org>; Sat, 16 Mar 2024 14:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710597938; cv=none; b=UxILPbCWboGuFCJrrRfn1KX5MZrmTLmh2Thmwtamgnuwk93AN3zXF4W6j9YggKHddrubh79LEW8WaJ0GFcGOpNVHuTMau+PQ93dAcV6XMwVA65BfSlob0slDPl64PXU1c2aDztf2gXPEAIoOi8oFoQ0XrOR2xQQjJk+KTuktkD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710597938; c=relaxed/simple;
	bh=/aGAD7ikSKrkpqsj+diS1JvPiiFj/VlFkOeCvZ8K/MQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Y12AkFrkyVJ4BYq/b/DYWt+SybreDlpGnHGk9Em4AauMKixtrkXneIznnwxin7Ll5nRLVVKEupJy6PSXC19TvmUN2i3/keGcXvB6evQ84iIIagQVTvrsJ2i5Sc7Tlk9xH+H35Dw7t47NSN9YP4hrokcqUuvBdftYQE5sRO9cwAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ENUIwmla; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-430baec7bb5so6082541cf.0
        for <netdev@vger.kernel.org>; Sat, 16 Mar 2024 07:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710597935; x=1711202735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v4P7olAMucucDgbtxfuItSbvDs8THVNvrbg360YPOWc=;
        b=ENUIwmlarpdCLCas2QB79ouG5EkhaYVXy822u/xZT503fLwLwA/8xcyEZvQ/AA49J1
         crdRZ10p5UxNH1LaJo80fSkUXi/OelIs98wzDjI/1VKfc9nfpoRDvj++ZsXhtT91xeKl
         a5S4c6AND5gywbjXU04fQW7drKoJ/LEoOQ2osc/TNeS5e2I+lBCu1DSV0MJ0oI1GF5ct
         ou1VBwDfKTtZTZnsq1eRQRX8rVHcoNh+aSrE9AxqIAIRkb0jxW7PToKO/BjyhHeFuF+Q
         hbKzet0kjmxZ+/FdXGu1IvvsDU30WWRejYnsY52Ho09VI8+Jtge2y+ZeX8ECtG8sZoJD
         wurg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710597935; x=1711202735;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=v4P7olAMucucDgbtxfuItSbvDs8THVNvrbg360YPOWc=;
        b=wQhKW5GToUcDiLF1zTjxeGoSZaE6nWAuw1YEVxga3T2bFl9dKfZKSJV0/W50sGKpmL
         p170uHGJ93T6pvfnQrut3evayIHmnqbFjxhJbbwUBMlsHUW54NRLGtd/IZn9FW/hpPIz
         Pf6uEdk1BiyUlYESgzdtLkwY07mX9D7LrvLGqRUXY5y38saEQMuEXN37tbUJKaGpM6A8
         oRfiSeeMKSzOW1fRf0uqtyD+ZU/pGDaAZcypT/eVJTiQU+8cd/iPxtkSQ3l23/M68TM6
         aXtzMg8wl4DXS1o+LbrljqbcYzxDqVpDBdeb2qu7uQ/iazwoFYEChSAtkSN0yiWR0dcl
         cqow==
X-Forwarded-Encrypted: i=1; AJvYcCWeNz8RKbfoE5QF7wRsB/Aeyumx6yfuXe06uCdZ2m39EyRuOvSxdJSS2MhQ8qdrP3MprwKEcll8cnv/KozsrF6mspYKmhLM
X-Gm-Message-State: AOJu0YyiyrxcUiFrkW4pNfmZ7J3DDGP5OGpsyyw3o881AGkhbJRc3XwA
	ACi64qTUjRaea5iB6RWLOI33I2MCieMzQe6HzvgxLbSaUhmxYgBC
X-Google-Smtp-Source: AGHT+IFbUzMY6d+M9UufUHsUJSnfi6bUz/X5r6WCCzpa5/5QR//FK4XwNmwFsncLH6nsOgymZ4g84Q==
X-Received: by 2002:ac8:5cc5:0:b0:42f:205f:d20f with SMTP id s5-20020ac85cc5000000b0042f205fd20fmr12736604qta.23.1710597935129;
        Sat, 16 Mar 2024 07:05:35 -0700 (PDT)
Received: from localhost (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id hg1-20020a05622a610100b00430b5dcac34sm1346818qtb.8.2024.03.16.07.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Mar 2024 07:05:34 -0700 (PDT)
Date: Sat, 16 Mar 2024 10:05:34 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Antoine Tenart <atenart@kernel.org>, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 edumazet@google.com
Cc: Antoine Tenart <atenart@kernel.org>, 
 steffen.klassert@secunet.com, 
 netdev@vger.kernel.org
Message-ID: <65f5a72e62658_6ef3e294dd@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240315151722.119628-2-atenart@kernel.org>
References: <20240315151722.119628-1-atenart@kernel.org>
 <20240315151722.119628-2-atenart@kernel.org>
Subject: Re: [PATCH net 1/4] udp: do not accept non-tunnel GSO skbs landing in
 a tunnel
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Antoine Tenart wrote:
> When rx-udp-gro-forwarding is enabled UDP packets might be GROed when
> being forwarded. If such packets might land in a tunnel this can cause
> various issues and udp_gro_receive makes sure this isn't the case by
> looking for a matching socket. This is performed in
> udp4/6_gro_lookup_skb but only in the current netns. This is an issue
> with tunneled packets when the endpoint is in another netns. In such
> cases the packets will be GROed at the UDP level, which leads to various
> issues later on. The same thing can happen with rx-gro-list.
> 
> We saw this with geneve packets being GROed at the UDP level. In such
> case gso_size is set; later the packet goes through the geneve rx path,
> the geneve header is pulled, the offset are adjusted and frag_list skbs
> are not adjusted with regard to geneve. When those skbs hit
> skb_fragment, it will misbehave. Different outcomes are possible
> depending on what the GROed skbs look like; from corrupted packets to
> kernel crashes.
> 
> One example is a BUG_ON[1] triggered in skb_segment while processing the
> frag_list. Because gso_size is wrong (geneve header was pulled)
> skb_segment thinks there is "geneve header size" of data in frag_list,
> although it's in fact the next packet. The BUG_ON itself has nothing to
> do with the issue. This is only one of the potential issues.
> 
> Looking up for a matching socket in udp_gro_receive is fragile: the
> lookup could be extended to all netns (not speaking about performances)
> but nothing prevents those packets from being modified in between and we
> could still not find a matching socket. It's OK to keep the current
> logic there as it should cover most cases but we also need to make sure
> we handle tunnel packets being GROed too early.
> 
> This is done by extending the checks in udp_unexpected_gso: GSO packets
> lacking the SKB_GSO_UDP_TUNNEL/_CUSM bits and landing in a tunnel must
> be segmented.
> 
> [1] kernel BUG at net/core/skbuff.c:4408!
>     RIP: 0010:skb_segment+0xd2a/0xf70
>     __udp_gso_segment+0xaa/0x560
> 
> Fixes: 9fd1ff5d2ac7 ("udp: Support UDP fraglist GRO/GSO.")
> Fixes: 36707061d6ba ("udp: allow forwarding of plain (non-fraglisted) UDP GRO packets")
> Signed-off-by: Antoine Tenart <atenart@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

