Return-Path: <netdev+bounces-277908-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAH2EoIJ3GkTLgkAu9opvQ
	(envelope-from <netdev+bounces-277908-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 23:07:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A08D63E603F
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 23:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F8A030097C1
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 21:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF7720D4E9;
	Sun, 12 Apr 2026 21:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zcki0jIW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3152837FF5A
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 21:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776027955; cv=none; b=JZLAbnydrnAGQVCyFbZdz4zC1n1eGbXgmHa3/RmfeewFkFCQ68/vTk0R3VBwn94+oC3EV5MylgeMve+B+Rgzhy9FnkC51tUTjcV4DQDDkNDb0rPW56upGsfO6q6Nf0R8pOW+2mPL5dHx6oGrHwvOUNfoIZb5GxMl2SJZ6NHCJ6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776027955; c=relaxed/simple;
	bh=k5ZKS5bxKy4MgmVAc+GCJ3Tk+4qPTOxySr1pCRVb4IA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WbE4Haesi8HaFzk2xv3MchWL9h+SfFnDrydjkor1qDKHoWExN0hcXye137nBgfbpW/EcX9BpqB2kxI/XYdgl5PAs6WZB4PV9UCZ8W/XrczSkLHu/C+NAM9y8WRoygOwZVGm2ORnDPPFDUS/HmXzKVE91odiAGCFVHpYazhicrco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zcki0jIW; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43d70b3e159so262145f8f.0
        for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 14:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776027952; x=1776632752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+2bXvfxILkSU7t31zekepUZRWIgQtvcFV4bhds98FtQ=;
        b=Zcki0jIWnM3Oldv+0xSuR5YAW6sqEYNvJ2X1JQf9GlbGTgE92x623+1Nt9qpNjxzVC
         XsHXmZQTuKB/hw2IkdMl++vBXAbQKoyh3n/3zG2nOFPgfySO0ehtVLfEIi3AIVEiXw7l
         Oquo2DFRegVWy4our8UXdp9EWLjjJwxxL2lqt6xLdvJ9FPO0srKfAKH7Leacp6p86SK5
         7T/TfeED55laDtg6eQkkVBjW51lTE/9A6gQESk7NsPP1uraMXLoBT7kIoJNGarS45qtc
         +oyMmu6IeB3nvGqa7Kek7n4FbFIZUq5bnEzITrHYt2wo6QynKrCklK4ZdYHJe/ljRoOq
         i19Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776027952; x=1776632752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+2bXvfxILkSU7t31zekepUZRWIgQtvcFV4bhds98FtQ=;
        b=OJA1ZUqhullkcSmtGitpVxOXOwANjYJG/6Mi9fsZfOTzbER8ZwX6MkCgw4HlQiZXRW
         5o2ocT107eOb5Po1B/5EgkD59dBt1OdEtSM8g5T2VM5Ka3Swcr7zrlct3pUO0JyhVxGI
         bFYng/oQw3XTD9r6P1GkLmmpZXSEEBQqjwwm/4j934XlFzQPH1/4QcLBzmaE9oeEepmy
         O7PvubNk/hlTU8Enp98UIBM1k+37IcSv96/11x+GsFyab6JgstMkm5kH3AkP/naNcesG
         2PfuGf1hAlKwBCZz1nPNNvdoxlKRL/BaakWu4QRVPS6YNnvtrqzvgmcFDIBdFrvAOhjy
         MYcw==
X-Forwarded-Encrypted: i=1; AFNElJ9+76ltu+0El+KfJusIInV4HIDDWTYzG/wyFa2lY2sFh1C4hCFPzWcqdk9w+Nj0QaR20WjlK44=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP3urdp3XRcqsxJztsfWyMHq8CXaLrpaMyVjJa/pmpsE4poxyn
	D0PewtHPUA2VN7d3Pdmm/AMRCRaEVllnSxpaqoxYLqcHql/RxS/V3ZFH
X-Gm-Gg: AeBDieupmiUj6S50QtW1P+eICdnkvaDmJz7QinYVaXRkZ21Jnyr3K8ll6GF029SODBl
	BwDtOxhiJ+9/PeMDkz5b4OSCyT54fPtVQotOK+yhzZJZuFGZsa1yME4AF11jIW+iuzekmRNsgT0
	mXxip+gwkA8Si0UQIF4D6zfby0z32Tr/Gc2OTC5GBIKRtDbliWXosmzxuFaXbWJFT/vB1yYEjxW
	Qgt3QCZP/N1r14OKmuL6juTRQ4coI/GhvOIhH6ue4pbpxVe9XIxO9dlvOWw1RCYbUbgGdWwD9e7
	M/rijhb+HkpgVIzdHYGhOJqFOnvTX07rQiGLRXC5/sQz5xgPHP4LMam1OGscRyTHaxRGYVgIYFI
	i3QWxaisOT8ebVaFuOqSKxPylKocklkpOXYtfMeFb+tufK8Yr7o3jjKQygsoekNG8yQrJZ3sJtq
	4gPv2k7mrGG3nSWRfKW5aJ1atblNBdH11z87IWpRhizxvW90QxuMqcOZJvKO98XyK/Ncz3MdXHi
	Cs=
X-Received: by 2002:a05:6000:184b:b0:43b:62fa:e3f0 with SMTP id ffacd0b85a97d-43d642c9415mr16793813f8f.48.1776027952273;
        Sun, 12 Apr 2026 14:05:52 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63dec27fsm26564853f8f.11.2026.04.12.14.05.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 14:05:51 -0700 (PDT)
Date: Sun, 12 Apr 2026 22:05:50 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Mashiro Chen <mashiro.chen@mailbox.org>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, jreuter@yaina.de, linux-hams@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 net] net: ax25: fix integer overflow in
 ax25_rx_fragment()
Message-ID: <20260412220550.0f35f5ef@pumpkin>
In-Reply-To: <20260412131751.0e90a053@kernel.org>
References: <20260409025026.24575-1-mashiro.chen@mailbox.org>
	<20260412131751.0e90a053@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277908-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: A08D63E603F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 12 Apr 2026 13:17:51 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Thu,  9 Apr 2026 10:50:26 +0800 Mashiro Chen wrote:
> > Fix mirrors the identical bug fixed in NET/ROM (nr_in.c): check for
> > overflow before adding skb->len to fraglen, and abort fragment
> > reassembly cleanly if the limit would be exceeded.  
> 
> Same problem as reported by Simon on the netrom patch applies here.
> 
> nit: I don't think you need to cast ax25->fraglen to unsigned int
> in the comparison. since it's added with skb->len it should get
> auto-prompted to unsigned int.

It wouldn't matter if that comparison were signed.

Or change the type of ax25->fraglen to be 32bits and do the
sanity check for overlong packets later in the code.
I had a quick look at the header and the structure hasn't
been size-optimised...

	David

