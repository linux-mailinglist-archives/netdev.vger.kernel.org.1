Return-Path: <netdev+bounces-267272-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOxGAJJ0s2k7WgAAu9opvQ
	(envelope-from <netdev+bounces-267272-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 03:21:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8009B27CA55
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 03:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D5778303727A
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 02:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 180363090F5;
	Fri, 13 Mar 2026 02:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAQMYHmn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B0C2FE07D
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 02:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773368457; cv=none; b=YKZvNtoMm4VSYod1uX8q9sbxqcxvJLMtaCW+bqo18/1A3Q2uPLknN6yejF5lEnDqRS9wuuUFwyGAGkyDXLbZTLMcKisdHrXZz3PF9evT8A44JY4ataIacuewDMoXp2HseITgvyveHvP4fMVPAxRumriTazI9K+txOF3i3ds6zXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773368457; c=relaxed/simple;
	bh=qbDmf7zIJOAQUpItzNpTlj9NfQ6ptyWW+Upm5xAut3k=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ghvZ9Vq8tkoS9vkmFucPLUGgkqQP3Ah4u024Snj0EL3EzZOy2qMwYr8sEs3unN2U/EGsbEhn1HRBHytlF30mxRxYkCKbYUIqDbi7iybimalbo3oOzGjEqElZjeJk0ZKNaZXQrWWFQhDbFzTl57X2ilxKPkRQZDAAYdIrGyq+quM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dAQMYHmn; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-50902b1006cso14524991cf.3
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 19:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773368455; x=1773973255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=//VljFbNIl/c4QUY13kH9t3ieZj9jbA4O4nh8AcWsvs=;
        b=dAQMYHmno+BvkHKoat4pHXrZ9/+OYa8lCk9HtvFBPhcSGNy0UWBuOnTLPdP0FHKjrH
         WrE7RJWuMNSWc2/vh4Bi9ZlE8Wfs1mhmAZUo6bqezVU0C94nVR+MFX+ak7R1czUKzDKW
         VBE7HZoNtwdWZ06aei0w1dXJgdhR3sGrOrZ6XhNPMIgxWKJJqsYkurYmGn4pAGwAIxWN
         dc0Xo7xyMIs6eROEgAJWz7qrHwT6RN2J7YKYDw7vNATnlyL7GUCEYSR6SuUvKJz8pb5l
         RiKHAo/YYtoRq5+77gcSYS6Njt7jFSf08oQFvQB8K4pzs3C3nrZa5bgmmCHEcsTyWDsy
         g5WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773368455; x=1773973255;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=//VljFbNIl/c4QUY13kH9t3ieZj9jbA4O4nh8AcWsvs=;
        b=qVrLmwGYqz22VTFHJgzan/PYVBmzXHb417AL12MMyvJffrdaR5cPHEmAQx+ecRCpVQ
         zBagNRSMiKWwb3x0vIynOP7yi42hmrnYyW6xAjwh88PJdtiX/5js8F39hdenkdsmDCaq
         +EVIiObrdFmc4KjK/p04fLtx/Iazr1/iyC7qTNm8dwVMn3Dyx0MaasUPmq+56dfIdpDe
         wo+HGjzXFGmGVtWlVKqNQIG2rb4Cw5Vh1zL5h/efUHg1TKVNTfXlZL8O4aknIMKc5rOa
         TZxtlckuCddfNW0VC7P5vi5c5Y8kmIt5C2mvozRJ/xyDuPUul6UvWHw8J7QLWEvx+koM
         BqAg==
X-Forwarded-Encrypted: i=1; AJvYcCVwFu3+w5cI79xZVQVsjSG+2bmgy3jCbiwPGl5dbo/ZPDcV/wkeP1hn9VeE7orChM8C46JdbrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR/ZAgxpZtA6vvvfGNm8yDtPfju9HJYlKfL/D//1yDpJ0mS02S
	tsiuLjbboKRZ9UYEfmB1iNXX04Kz+mx8eDJ3yG7z+Fllu/ZL/9DXgCLP
X-Gm-Gg: ATEYQzyFSnUUQLzwvUoeMXRdjMjMUjCNmSsu44blU2yK3k3PcEbvs/Kd7NGhH03ANtL
	0N96bdrZw/OX28L9Yb12eq5gLnwSaKFoR1scJvQ5Xv5V2VosbbHGXk92XIpdXuAiRJWpvzgp8QO
	UEMnt+H9p2grHmw+vAiTHXT8hsUMj3SoE7pngkqMrK6e9TJ96A57ddbYbvSnZ0mD8kNDzszg7wl
	Vzcifo1lmzJisbgpMswVyDzw9ckc1Fod5tQ9oHAt90NfHJBGMFTZod2r2KovCcDeYy6v99Rdc4h
	heP7aYWcw0aJQMRGW4FIM3src8eiunp5pRLS2QhuQZFTFc06EmAkif7qHD/2vWDacm72JzDDIBX
	zUfd8aUnNvoc6hdc7FEYTRu+qr4BPwvuheOvpxRRUjxKCGJHV9yGVttKNm95G8wWvpAmnGfz14Q
	gzHlBhlAhaW9ihbMjcVDY0QYdX7qp5mMdePSx+DPu3thxBADcye4xX96Nca9L1GV23aghjutclN
	3uu
X-Received: by 2002:a05:622a:244:b0:509:3141:312c with SMTP id d75a77b69052e-50957e11044mr22356631cf.40.1773368454774;
        Thu, 12 Mar 2026 19:20:54 -0700 (PDT)
Received: from gmail.com (180.134.85.34.bc.googleusercontent.com. [34.85.134.180])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-89a65beb4b3sm46632586d6.14.2026.03.12.19.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 19:20:54 -0700 (PDT)
Date: Thu, 12 Mar 2026 22:20:53 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 David Ahern <dsahern@kernel.org>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 Florian Westphal <fw@strlen.de>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Kuniyuki Iwashima <kuni1840@gmail.com>, 
 netdev@vger.kernel.org
Message-ID: <willemdebruijn.kernel.2a1f71cccc0e5@gmail.com>
In-Reply-To: <20260311052020.1213705-8-kuniyu@google.com>
References: <20260311052020.1213705-1-kuniyu@google.com>
 <20260311052020.1213705-8-kuniyu@google.com>
Subject: Re: [PATCH v3 net-next 07/15] udp: Remove partial csum code in RX.
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267272-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,strlen.de,google.com,gmail.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[google.com,gmail.com,kernel.org,davemloft.net,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8009B27CA55
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Kuniyuki Iwashima wrote:
> UDP-Lite supports the partial checksum and the coverage is
> stored in the position of the length field of struct udphdr.
> 
> In RX paths, udp4_csum_init() / udp6_csum_init() save the value
> in UDP_SKB_CB(skb)->cscov and set UDP_SKB_CB(skb)->partial_cov
> to 1 if the coverage is not full.
> 
> The subsequent processing diverges depending on the value,
> but such paths are now dead.
> 
> Also, these functions have some code guarded for UDP:
> 
>   * udp_unicast_rcv_skb / udp6_unicast_rcv_skb
>   * __udp4_lib_rcv() and __udp6_lib_rcv().
> 
> Let's remove the partial csum code and the unnecessary
> guard for UDP-Lite in RX.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
> v3: Correct ulen < skb->len case in __udp4_lib_rcv()

Reviewed-by: Willem de Bruijn <willemb@google.com>

