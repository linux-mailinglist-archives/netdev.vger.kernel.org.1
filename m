Return-Path: <netdev+bounces-286817-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKJXBLM4AmrmpAEAu9opvQ
	(envelope-from <netdev+bounces-286817-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 22:14:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FAC51594A
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 22:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51DFD30779E1
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 20:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B764537F8D0;
	Mon, 11 May 2026 20:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgGSqse1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05BB327BFB
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 20:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778530223; cv=none; b=n7GmWu7ryDCk7DarnnQo92ZDzpSSP9jqgUpCPWTTdm3hrovRnCi1eglI4SYaKn6KHz4FYgpZFf3UXxDHXMWJ5z8u39LzpyGg+UxFP1Bb/4gwLCACZWE6zInXOnZnRScWw/6mqUqLUDWNHoof3QMmYwTxXzG7bPICR0hxnKxm7oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778530223; c=relaxed/simple;
	bh=uYq/dpi/2BJmZtXi1gUWp5R7/kwACFoTdOLXb8cBS08=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=F2w79lMepIpjaRvJTkv9ulsureLSg5PX856XC7DksxH4DYeAJHVIdJpe8tdGsBbhVoMLTwTsbNv3bOZqYltJXIN38x8/CPKqv7WtNY2fiJHU+rwWXLLIu/XnJjoQ6TjzsB6RxmshKW2y+nb2BQY6cdA8H+mqKCsJl80QWywvS7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fgGSqse1; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7b4ee3a88e1so47998817b3.1
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 13:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778530220; x=1779135020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Co/G8UytdXIIVZ3/F5Gw7AG62mkjDUcPKCAHzzQ7WEY=;
        b=fgGSqse1vxwrThvIrAfjp8eIydZW2pxMvg+xW8EIbRrs4eUdnMNuqdNwf8ppyjuU2I
         6cP/7taDOTVNnneCT/0hTEbb05qc2CfmoaMuulLOH0OlyCyY2Jup6Qgbeoq5vpcFOmrE
         onDKi1JZ70QlO803RjX97853e2IdEuxwRjhCS5vgiAwfElInRlXhcWUZxtp64uvyS/rC
         mNM5aISMhwjreeoxUnv1Tjh21ui6cJtvMi5mkmkBQ6YR0ixlSwONOGHVkD+akL03CPWr
         SP0fJr+d5XZ+LPMGFsg8PHH6plvX5bz7Z1FJAv+qdgfVL0caVX2VEXl0qGv6MGuEwOjf
         OgbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778530220; x=1779135020;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Co/G8UytdXIIVZ3/F5Gw7AG62mkjDUcPKCAHzzQ7WEY=;
        b=RAxgl+1Cpn0aIfo0IW6PB0qqu5GdOxO4na1m7KQUCV71Xi65Ig1cVQyZ6kWqLDXS7e
         o0OV+hr5w5C142tm2smvbrLPZdnf31MV7t987BbeSUIoWPtj/npbj6ugdQiN4UnpgeUs
         gjbuHOwF2aRTWQNZXcGqkr+qdhng4AOMcDOT9D2Z5aLWgT9f7r5xI2afFT33DsL6AMC/
         HfKYM4JdAHkvKiyvo29MTogNWpeNDuAaiskj2hsuuepS5olMYsYqHJJwFi9o5/CzlAM7
         N9YpLqSFReKsGkmt5c/3YgYP5NeR06xdyp6RFhIwPaQFPBggeTo+xUKhdBtzhs5j9WIU
         D26Q==
X-Gm-Message-State: AOJu0YzoUanoCqX4Ae93WDKvXldud+m+hG36ctUub2jXr6HBj2UAP5mZ
	9IQLiu+jU2hstEW/oV4TKVJGHc+FzX6ZmgOy0v6JKnAKXD5VWDwSnJ0D
X-Gm-Gg: Acq92OEwgqo4LZk6ZAOwLgi222u42296BY90wtB4OQhDWKzgx/rH93M4EZojdB3sZsR
	jlzk9oydEsikekk+GV5Mv0mAgS7AfvNdIDF7seFtobNw7TbWhvJd6/Qag1iWgoyKlhXw+fgdD49
	jhLI7dCdRP529CCwvzkuhylbpdvBqm5QVpAP4hi1H/LyT3+iVpNTGmw8iA9cBWVQTa/k4Gz9dg6
	QJsLbH7a4K/eVvRL7N++AK5UaY7TDIfcSJagenBULaWr4dy4W35kldkEw9KgRDo25Z/5DH2JR/d
	Uu4S8cT46yuEH5BNx3YxF9PTWB+aEN7oXjF0YdO7Jaq1dkB5RfIzI0szNPEArmPuYWijq7TUJKw
	WuShGbM6QZ3yZGRgL9zVvPmaTWFaVyM/sKYyFcGCQcdXwmehBw1VR2JJrca+S47/k06AOfmXmVU
	3+dxWIIU63UoKqVjHaW42laufDqnt7YS0OzOUE/tn0pTo4x05HpoVPcFo7EUmGdWful/r8C+eZR
	tvWpDa30T5emNA=
X-Received: by 2002:a05:690c:6e85:b0:7bd:d4f4:262a with SMTP id 00721157ae682-7bdf5efb218mr252790807b3.37.1778530219834;
        Mon, 11 May 2026 13:10:19 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd66837e34sm151681247b3.28.2026.05.11.13.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 13:10:19 -0700 (PDT)
Date: Mon, 11 May 2026 16:10:18 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Daniel Zahka <daniel.zahka@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.306465ff30e6b@gmail.com>
In-Reply-To: <20260508-nsim-psp-crypto-v1-5-4b50ed09b794@gmail.com>
References: <20260508-nsim-psp-crypto-v1-0-4b50ed09b794@gmail.com>
 <20260508-nsim-psp-crypto-v1-5-4b50ed09b794@gmail.com>
Subject: Re: [PATCH net-next 5/6] netdevsim: psp: add real aes-gcm encryption
 and decryption
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 70FAC51594A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286817-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.996];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Daniel Zahka wrote:
> Implement real AES-GCM-128/256 encryption and decryption for PSP
> packets in the netdevsim driver, and remove gmac from supported
> versions.
> 
> We now have to add and remove the PSP ICV trailer from packets. We
> linearize skb's because the aesgcm crypto library does not work on
> non-linear buffers.
> 
> Assisted-by: Claude:claude-opus-4.6
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

