Return-Path: <netdev+bounces-297237-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4jxECA1fKGp3CwMAu9opvQ
	(envelope-from <netdev+bounces-297237-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 20:44:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6A5663653
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 20:44:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=pssxr77f;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297237-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-297237-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7EBD8302959B
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 18:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 416914C8FFC;
	Tue,  9 Jun 2026 18:44:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C4E48A2A8
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 18:44:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781030660; cv=none; b=BTMGmMzV7L4i0TKjEhBhPxV+fMmBsLrFoWTJe3GgQF+rV/+t2RnaoxAhaSTSEmauVuUN31BbJLqf/BWfkEVJdekaH0h+qzRKG1V43ErxlWvznBHMSqdSqDUtjYf7a6rXuVEhWSZ7c4YYKWTT3E+EtpswsSN4X1qdwAYH4Bq35fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781030660; c=relaxed/simple;
	bh=TxWuM5zJJiZ2uEQfXLV6/pZYHuuTsUQmZkx96ddDz9k=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=dL7eNIOd8gh0bmV3TPdAC8XGxzfWBLWb+XMEnCVgfTq93N1+jFokRhR+wNRT7MvK1++mQOdEgNJU1P3CuDEaCko4n1B0WWDjJt+Ntg5aLNo3YVPykqsmVyQsGNGutZPrbkcV9RCIM6+R35rcxpWWLQB7J2hU/hWFWF/sbi54N2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pssxr77f; arc=none smtp.client-ip=209.85.128.170
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7dc73a56b5aso40764297b3.1
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 11:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781030658; x=1781635458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L/2s4b/3r4lMpUo88wN71Ucwh7h+lI3cMN2Z1OcYoBE=;
        b=pssxr77fC3yDqae0VK+i59A3yXg+SJP3oLGPMUbRiiFJK/M9ImCbmlJJNwXFETUBTT
         520lRAgWG+ob0SgTcznXVM0+dgVb7wdnpnMmva82brRJvni7rCv29WM3kQUW3oUHOVlS
         64oAgLPC1gPDJJuWZ/oPV8j3Ixk0EXJ5gfol3iTD/matbs18G54C5kTQqeQOPQpnixdb
         8jB11/VduJ8KLr42ZgC4mpUjXZHejxGUEX0sWaknX1Ior4rWhPb8QXwXp9oQ/o4OEUvx
         ekqUhOtLmqhSYWjbwnm+oZ+N4Z8bJiHRDQRzbCz5I+UhrUInxYeSf7dbYYKibbCQPb3q
         jbyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781030658; x=1781635458;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L/2s4b/3r4lMpUo88wN71Ucwh7h+lI3cMN2Z1OcYoBE=;
        b=Zu6BE5FyfejJg47EDOSlj2MkzIqRfWJfBYSVOOo3Qi0OmT51gtRYppk2YZXSV6eAxP
         Z4PpEnkL+eyUFKgDZ7AQxb08OptM0CgvMQ7cLaqxuIE4WeqDOQ1hKaQJifHZuZTVgmJz
         Nb7/ruBr+WDK2G2KUBIjyAm6khCnQqtONrt5DsrHj0u0QiwfGS8bIpRDi57MvFtn/bcu
         Ijtz2pCMCl3UUBnCkKPoc7bjv7MnxQam+GroMYGfNOp3dVHbp7la1EM9TFEs8Vg0slqc
         9CZ1qj0r0z/0TkRYgnladrmqr+laAQV4AG9Ha5TaBqiWn3l87rinPAcwZjt1nj/s5ADo
         MAig==
X-Gm-Message-State: AOJu0Yy4B1dsczci52RyUc5WUhwhF5bVyGqhoxn28O+wUfWPqRGfXpbd
	958pXz4ZeYuPiMSLfIbv782nE29nObWfHK582VzuweSEL7/24V11KwM4
X-Gm-Gg: Acq92OGDtf/DDasFKkPxrUlXQrDPMZVpCRC9tnE7IaArLiDDjbJPZTKKLxkw7HHGjqH
	CgHWR52fmknae0AJcxVK66jjZjbvVKhbcaYlWx1EAX7FVnr5a/JYCSYqEHXXjCkfIhdOkTSPByf
	4sI8zJHUyH8c6fqUPHGWXq5GQ7U51xlujlTKEuRMcld3AyR9h2R+3nWWhItiFW/SSfilWw6cQ+Y
	rIjKKvxbUweLR06Wpx7SdKmYodL674L9zu9Z3ge/Eami73nPk2C+Wnw9hQqvEdbnZAFPXxU2azv
	okj3UBL8rngmU+LHdKRsjR0SD2XRRXQPDI9NE8kQg85MLRtrUCAV2xGkDKFjBvkWrlgLmRP4Tm+
	KRAffJLi38K+ZZ0EVKEw/uuTSDGIquRUFwOWsvElb+oaZtDOlp48LvNjsRns8wj6vsl0BdLcaTH
	d4VwgKwZDEcPqkcNWcCZ04+ThEYpEuAJ1zvwEoy6dk4krQ7iOrovUlJJpNXi8rVNAN/RKl8mASE
	3/dMvkDHj0w+8fEs/N5ZNmv2DvC
X-Received: by 2002:a05:690c:4b81:b0:7d1:cd93:c8e0 with SMTP id 00721157ae682-7ed0a9db095mr202375437b3.11.1781030657700;
        Tue, 09 Jun 2026 11:44:17 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea20ea8191sm100312127b3.8.2026.06.09.11.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 11:44:16 -0700 (PDT)
Date: Tue, 09 Jun 2026 14:44:15 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <willemdebruijn.kernel.2888ce77104d1@gmail.com>
In-Reply-To: <20260609180803.1093428-1-kuba@kernel.org>
References: <20260609180803.1093428-1-kuba@kernel.org>
Subject: Re: [PATCH net-next v2 0/2] selftests: drv-net: so_txtime: trivial
 fixes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297237-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EE6A5663653

Jakub Kicinski wrote:
> I noticed that so_txtime is only passing on NIPA setups which are
> looped within a single host. The cross-machine cases just flat out
> fail. The initial bug is obvious - the test does not deploy the binary.
> But even with that I think more work would be needed to sync the
> time / adjust the expectations for a dual-machine test.
> 
> Willem promised to follow up on the fundamental issues with 2-host
> setups :)

Yep.

> v2:
>  - rebase & add cfg.require_ipver(ipver) to the new case
> v1: https://lore.kernel.org/20260608173305.372987-1-kuba@kernel.org

Thanks for the rebase. I was just doing the same.
Still has my tags, but to leave no doubt:

Reviewed-by: Willem de Bruijn <willemb@google.com>

