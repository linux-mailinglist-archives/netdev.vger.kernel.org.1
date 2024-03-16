Return-Path: <netdev+bounces-80225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 885F487DA98
	for <lists+netdev@lfdr.de>; Sat, 16 Mar 2024 16:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11B49B21B78
	for <lists+netdev@lfdr.de>; Sat, 16 Mar 2024 15:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F261B80F;
	Sat, 16 Mar 2024 15:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JnlmXnS4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F269918E1E
	for <netdev@vger.kernel.org>; Sat, 16 Mar 2024 15:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710603809; cv=none; b=KhPjy9STsbsIxTZaSnTgwmw3xHQwgKyvPOzzJnuj1n1SUoX3b4IRVI0W/72ourZD3HVMfRDkKu1W5oUmByBiOH6CJGqLYq3hPSiX8GRodh0EjYKcVYmHnyTKhJ8Zfp6MfS6vuVaDLjWywE8/BBb90EXjZhIjkvz6QC9fR/B70Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710603809; c=relaxed/simple;
	bh=C1nq3JjT7lwyfV8pQfPCFQWausfDPfaJV94KYkDFrGg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=LBCHlmx62VR7JzG1DQnYKeQAbD5HLRu8scYImmsSgfOjhC+kOrZ0AI/+3JRlZw+Bc/wcx1/R0LOyVJtMVJaDngnPjEPfGO2zPayZNzDPwTw9zJXMrapq1tidctBqP31U3qX2s1S/jFszG6UrNS9NUA8EBrqEHfT1CVuKBw9Gdm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JnlmXnS4; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-690d054fff2so19754026d6.3
        for <netdev@vger.kernel.org>; Sat, 16 Mar 2024 08:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710603807; x=1711208607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hJwZnLL46yVM+T1d42ncaz6tuDayxW6b6dVWUGdAMY4=;
        b=JnlmXnS43jNz29eHAa+OG+tEzyH7QwSXchUFVcRJYzcn1XkO3SJfRUKCGJiZbmBvZA
         FPaK8JOVU1Cl0v2Lke+taYk00pjcbpyprLmNZ8zVUIz4m8/kFASi9aH6a127+VDPzZDd
         ybIzlnOPChB1PF+XLE50eM10xNJpDfZGa3QR5S032iHqJk2mx1ac8K8cCeUzZWT8t661
         7XqNeBtQDyqxBdK2gsEOUthU5SCgLhPuPpzPfysnhjW3sJqm9kUEAq3geopgmLucqvb/
         mVWIxksaS1mFxXWWOn/6+0I7vQfV0C1NXLQrY5k/tppODg31hPAalS86oCu6TEM4g7cu
         btug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710603807; x=1711208607;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hJwZnLL46yVM+T1d42ncaz6tuDayxW6b6dVWUGdAMY4=;
        b=vkK/8TFjZEVRFYOR/67u+oM2M2aqHMPfwMDAmPlaeSLe8fUcPpf8EpDQ98oqd+QNoo
         QxTVopymiWjtqWFlLPCr5HKMHIS1IdW1rrQRYNKBD5TiSU1UKK2pkj3h9iA/pK5cR2Cl
         5vU6JTXbxzVzdc/jgn3dl4sqvRt150kVSb7MGIoxKH9k1PMtALsGtaa7Wqo78bQaji4o
         /oI6I/DBPs70HTuRuwyhaRUWm0FgTMdO9aNwk1z1XOe1kz12/X5qGSNaT+wpePO6ENZz
         RUXYnXADTO0PZHZDx5YWyqyU4t9kcXnzIwib3zp8sjJ+5Qj9TE7KSrM/Hbo+DK75TdTm
         TZTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLRMx/jaQnXfKEsJoRx1zZcxawDq4cEnZ6stLPB7PMnWSEteLZHw46Y+TJ2Me56fu//biiixy4ZDhDOZL8/S8WBpVU5Fhg
X-Gm-Message-State: AOJu0YzakX18wsh5RrzhoV84sXUl8jBH+fsPHDrbVorwm1aEZHL23waW
	6HFBP2Gl82rZQVmkQgsJuT4duITf+HAEpvYjTQzTS0ICPRR0QZcv
X-Google-Smtp-Source: AGHT+IFOVLt3wG/zpKhwGKU5ktFRe0osxY83nToZ7Yg5HmuytUStxh8fcgF/MCCnXa5wfiibXrsYkw==
X-Received: by 2002:a0c:fb4b:0:b0:691:388d:23ef with SMTP id b11-20020a0cfb4b000000b00691388d23efmr9142710qvq.22.1710603806747;
        Sat, 16 Mar 2024 08:43:26 -0700 (PDT)
Received: from localhost (55.87.194.35.bc.googleusercontent.com. [35.194.87.55])
        by smtp.gmail.com with ESMTPSA id z10-20020a056214040a00b00690d951b7d9sm3242467qvx.6.2024.03.16.08.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Mar 2024 08:43:26 -0700 (PDT)
Date: Sat, 16 Mar 2024 11:43:26 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Antoine Tenart <atenart@kernel.org>, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 edumazet@google.com
Cc: Antoine Tenart <atenart@kernel.org>, 
 steffen.klassert@secunet.com, 
 netdev@vger.kernel.org
Message-ID: <65f5be1e42018_6ef3e29485@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240315151722.119628-5-atenart@kernel.org>
References: <20240315151722.119628-1-atenart@kernel.org>
 <20240315151722.119628-5-atenart@kernel.org>
Subject: Re: [PATCH net 4/4] udp: prevent local UDP tunnel packets from being
 GROed
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
> GRO has a fundamental issue with UDP tunnel packets as it can't detect
> those in a foolproof way and GRO could happen before they reach the
> tunnel endpoint. Previous commits have fixed issues when UDP tunnel
> packets come from a remote host, but if those packets are issued locally
> they could run into checksum issues.
> 
> If the inner packet has a partial checksum the information will be lost
> in the GRO logic, either in udp4/6_gro_complete or in
> udp_gro_complete_segment and packets will have an invalid checksum when
> leaving the host.

Before the previous patch, the tunnel code would convert ip_summed to
CHECKSUM_UNNECESSARY. After that patch CHECKSUM_PARTIAL is preserved.
Are the tunneled packets still corrupted once forwarded to the egress
path? In principle CHECKSUM partial with tunnel and GSO should work,
whether built as such or arrived at through GRO.

> Prevent local UDP tunnel packets from ever being GROed at the outer UDP
> level.
> 
> Due to skb->encapsulation being wrongly used in some drivers this is
> actually only preventing UDP tunnel packets with a partial checksum to
> be GROed (see iptunnel_handle_offloads) but those were also the packets
> triggering issues so in practice this should be sufficient.

Because of this in iptunnel_handle_offloads: 

        if (skb->ip_summed != CHECKSUM_PARTIAL) {
                skb->ip_summed = CHECKSUM_NONE;
                /* We clear encapsulation here to prevent badly-written
                 * drivers potentially deciding to offload an inner checksum
                 * if we set CHECKSUM_PARTIAL on the outer header.
                 * This should go away when the drivers are all fixed.
                 */
                skb->encapsulation = 0;
        }
 
> Fixes: 9fd1ff5d2ac7 ("udp: Support UDP fraglist GRO/GSO.")
> Fixes: 36707061d6ba ("udp: allow forwarding of plain (non-fraglisted) UDP GRO packets")
> Suggested-by: Paolo Abeni <pabeni@redhat.com>
> Signed-off-by: Antoine Tenart <atenart@kernel.org>

Choosing not to coalesce certain edge case packets that cause problems
is safe and reasonable.

Reviewed-by: Willem de Bruijn <willemb@google.com>

