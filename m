Return-Path: <netdev+bounces-201368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFDAAE9331
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 02:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 577913A3C68
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 00:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4D6171C9;
	Thu, 26 Jun 2025 00:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+wA+VCV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5590FEED8
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 00:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750896381; cv=none; b=pNO6gUVcWASOLQHCwh31izs2dSEqPdY3fCqjYY3+P5u1P2dBFLac7hsc+eodqVqYh78p3VNK03H7u8l7h99GHq0W2Hfxtq959tekFSiQDs3M57wwzKOELf4mcNYKqYXD675xuM49OBLNAm6NsbFJH6JVLOGDu6zNGb2siwnF4Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750896381; c=relaxed/simple;
	bh=jNJZ1o5yQiHLdkdDaMegq5uSIuL9AmBrHKR7ns8YCBM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=snF4r+bFpyXYHTMb7Zc+gXmy8dMApa0IMt7NRqH4oGQtxnmlK9bsdrFVGOtSVeAIz+HBY/1lIUxLN/MaqEa0pl8mT37k50Bqk39lKW0Z/VlVyS17Z1qu0dPNSFRpkwGTmEhf2KzdOfFm4qm1xF3/yKBd4BOOF4bQC1HGDTQRhkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T+wA+VCV; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-711a3dda147so5207357b3.2
        for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 17:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750896376; x=1751501176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGcAIT+vQp6AZQmasqqBsxcJqnSBN/0qxuv9TKXgAHU=;
        b=T+wA+VCVaiQRmydbDp/0a73SXW6+0IDZDrWVS+I3eK7Tk2G56/SXew6ehZ2F5Us9au
         2urEC0keERs4td+E+XkeTAeoVJqjnpxf92a+o5e4G+pbuEEHDSfMj+wgd642bIGTG+vN
         MxsYuGxssKePdcpKO0dAXtX0EM7wM7YeJsaiB3qCAkgsIVaLtDLx8GhT1+w6wVMNRhk7
         i+4FzXoDTab+NY4PYhTkrB3qm6bb41EJ7oym4KU6ksu9tJzbFNh88hZ1JpmPcwlClwRO
         AGs2da/htJ9eRrisdOfSa3h61Uwhk9cQbjmE3dGV0qluiN3VzQPr69mQfxW3YJ1h9dHo
         onJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750896376; x=1751501176;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kGcAIT+vQp6AZQmasqqBsxcJqnSBN/0qxuv9TKXgAHU=;
        b=uKIuTQZSv94ZIDDNhAXrCHigVAg+JlJflm6V8Rbd0uz4pVmaAJBvXATVIvTi7dALFC
         h8mAUJWo99wMiBXLRdhwIFtV7lWMohtp81gx1H8tWIt67lHonGOmJt/Y2+IhFZByg+bT
         GC/fTJmsNDVXYIY2LEfgj0ovDAZQtR9w1YutcGWfPVtO78ffQxi75v7WONnN2+uXnLtt
         l/fCaHJASlwwBC/CFvHYYTnQBR93EcfVPDlhc8MZHck6kCqgbh5loCuj4yBGbTVpuHFU
         KI/8lLGI1DwJa6eiHOA+lQ40ftt4y4H3pS7Mg2zXKceAEsv+/TPl1RsmDtW2ARRPiW2I
         qpsg==
X-Forwarded-Encrypted: i=1; AJvYcCWdEF2SajHGDDE9axoBipZ1tBJsSK+nB5pzP6Gcnyg89QPUGDN/EpJ/FzQyBl055WJWUX1ZI5g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyir7GeRsLSFnwE1SE83I+miuV0kMNbWM2zRYezgzdmjPu4G765
	OISi/0mvDXvkJ3faUW/EhJWOwsLWgWSqeb4EAlGmOXeCismsTG2IUPtL
X-Gm-Gg: ASbGncvFO4F0p8YE5pnbls6/72/kWN+NIE9PMVJZJdqJIkM2qcfpKI3rwds829xF8Ps
	dUpTEDihPnRvS5BiENqs9QbXicey8S4n/eq2S6ZIS7FMj2wa/PauRted9D3t9Sx1GgHkdnnSBw4
	guy2pJcUEQypLklcQlfym8/hGQFMSLQASw+KT0hZlcn5y1p5Ymit4pA8No19405jCZzid3KdlD2
	1hZDvSGCsBMnjcfsWuzHvTnfvV45xAIZxtmLb93RVFbIMWyZhx7Cg9B67h6l/DWsGyLYMxeKedf
	ACkzryRs2B9gGXYhcoqggx9sVYpnqRMrrH5wOC+8FdhixQQZFsAbyu1gN4itA2Fx2M7mE0B79EO
	Ke3iT1Jveb7bZPsDhj2fWn741S2nuePSgK/2ZMycYYQ==
X-Google-Smtp-Source: AGHT+IFTZsrEdbbxo8bbPClNZe/68IhYC6HH7AWvNEM4BFSeN+6RvVCRLnkpKq7eFoWNQifZJek69Q==
X-Received: by 2002:a05:690c:311:b0:711:406f:7735 with SMTP id 00721157ae682-71406ca3168mr72454167b3.13.1750896376238;
        Wed, 25 Jun 2025 17:06:16 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-712c4ba6a94sm26791377b3.76.2025.06.25.17.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 17:06:15 -0700 (PDT)
Date: Wed, 25 Jun 2025 20:06:15 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Daniel Zahka <daniel.zahka@gmail.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Saeed Mahameed <saeedm@nvidia.com>, 
 Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, 
 Boris Pismenny <borisp@nvidia.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, 
 David Ahern <dsahern@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, 
 Patrisious Haddad <phaddad@nvidia.com>, 
 Raed Salem <raeds@nvidia.com>, 
 Jianbo Liu <jianbol@nvidia.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 netdev@vger.kernel.org
Message-ID: <685c8ef72e61f_2a5da429434@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250625135210.2975231-5-daniel.zahka@gmail.com>
References: <20250625135210.2975231-1-daniel.zahka@gmail.com>
 <20250625135210.2975231-5-daniel.zahka@gmail.com>
Subject: Re: [PATCH v2 04/17] tcp: add datapath logic for PSP with inline key
 exchange
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Daniel Zahka wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> 
> Add validation points and state propagation to support PSP key
> exchange inline, on TCP connections. The expectation is that
> application will use some well established mechanism like TLS
> handshake to establish a secure channel over the connection and
> if both endpoints are PSP-capable - exchange and install PSP keys.
> Because the connection can existing in PSP-unsecured and PSP-secured
> state we need to make sure that there are no race conditions or
> retransmission leaks.
> 
> On Tx - mark packets with the skb->decrypted bit when PSP key
> is at the enqueue time. Drivers should only encrypt packets with
> this bit set. This prevents retransmissions getting encrypted when
> original transmission was not. Similarly to TLS, we'll use
> sk->sk_validate_xmit_skb to make sure PSP skbs can't "escape"
> via a PSP-unaware device without being encrypted.
> 
> On Rx - validation is done under socket lock. This moves the validation
> point later than xfrm, for example. Please see the documentation patch
> for more details on the flow of securing a connection, but for
> the purpose of this patch what's important is that we want to
> enforce the invariant that once connection is secured any skb
> in the receive queue has been encrypted with PSP.
> 
> Add trivialities like GRO and coalescing checks.
> 
> This change only adds the validation points, for ease of review.
> Subsequent change will add the ability to install keys, and flesh
> the enforcement logic out
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
> Co-developed-by: Daniel Zahka <daniel.zahka@gmail.com>

> @@ -2068,7 +2074,8 @@ bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb,
>  	     (TCPHDR_ECE | TCPHDR_CWR | TCPHDR_AE)) ||
>  	    !tcp_skb_can_collapse_rx(tail, skb) ||
>  	    thtail->doff != th->doff ||
> -	    memcmp(thtail + 1, th + 1, hdrlen - sizeof(*th)))
> +	    memcmp(thtail + 1, th + 1, hdrlen - sizeof(*th)) ||
> +	    psp_skb_coalesce_diff(tail, skb))
>  		goto no_coalesce;

Since this is a "can these skbs be coalesced" condition check, move it
inside tcp_skb_can_collapse_rx?

