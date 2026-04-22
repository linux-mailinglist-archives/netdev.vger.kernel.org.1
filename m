Return-Path: <netdev+bounces-280510-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +ElcFrn86Gl5SgIAu9opvQ
	(envelope-from <netdev+bounces-280510-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:52:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FC0448EF3
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 18:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D88ED3006B3C
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 16:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A58D34FF5A;
	Wed, 22 Apr 2026 16:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2ka1xva"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05559365A0F
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 16:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776876274; cv=none; b=rgQ2JNEVSvQsLJCyPqnZwGPPSjUgVzlD/8LRbJJsPtEBvj4qqzOWs7m4jhC0IHFq1dyzH+jpPlePQXMMGyBTBxxkpQ3dgAIEV9w4Ow76OZPEjW9QQMkF+vRskKZNDO0vowIJCQwmRRv55zeMFMcazTlrmE1tq4s87pM95B9kPbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776876274; c=relaxed/simple;
	bh=BgDSI4zVHjeTWCZJNObGDJ3ff3QHrWTr1HQJxLLBgTI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eO+6IFscRFHi6gNjJLBWlhJP9QQKOZbiRiOkEEasRfnAbnhVuKW3dFjKzzycT1u7eP9QyNJxYMU+qmMROoJKBmxYwWdpYmfpR+fDcJKJgrQWhS1Y2Q/Pl+BSQgRhNIQmgWit9MeY/5n/AKITF3POS343dR47bn3ehqYR07uQf/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y2ka1xva; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-79a46260385so57912067b3.3
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 09:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776876272; x=1777481072; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BgDSI4zVHjeTWCZJNObGDJ3ff3QHrWTr1HQJxLLBgTI=;
        b=Y2ka1xvaixMM2lKUvM+DIAd94fZ4dEVS28LV11KyKHlLwHYLJaHH8Oe28caX1CIN3t
         L1+bmY0U+9NIq3WkhGsP9FBx8EMzRbNAleg/vxC5Ug5+rxFFDU61MPZ2CCFdvcqDqFz4
         94hUTS8ptEIOmHpYTXaqRm5jE9rTA8buHllgDyLjP+Y+dpplC6n2rw6XxtFXkAr028HD
         XP6ug+80JxTjOqv1z+PfDPkkJB7S+nbcQGViudy7UtpsQSuKMxHtCIN2Cnnn+w8i93xZ
         UWIBrQgGwJ0vsLVxw89MYPnKBN828TA0OSwcI2uZ4OGFF/3O9wzIHvs5YELvdnxmo2P7
         3dyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776876272; x=1777481072;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BgDSI4zVHjeTWCZJNObGDJ3ff3QHrWTr1HQJxLLBgTI=;
        b=NPC5TJvy8FMKuxPEe09QG/VdXHbdGPHZFTiNiB2SkigiLaRuPgb5x0dB65Xc6BfSJ5
         vQA/gosvLCB96LYVEbcHTwIFLBHh8O01CnUqh4Lz0qxLU3IK1vZJUv6PfbgkL+TxwHy0
         Gq74ki1dLUjpW3DF997gjPD7xAka4q3RStnLFaxW/72Yy7xcl4UJo/mVxBr+mebPoA2V
         eFNQuGFsYmgewFGVZ0lunkDheGKCBaJgEl3vteuuh4r6uR0RSMrxTwuWzycIHTE6wWop
         6lzKOqgcdXmtTdg6KXm434MIt032V8u6ai707KNzA0N8EKX9YTZdgytst0bZVcvxQ/Bq
         zkJg==
X-Forwarded-Encrypted: i=1; AFNElJ/JClcDZOBqlovrwKZsbxx/I+BGguaF4CXo7CEyAvJH3i+YeRTwUnaDDbY3Mr3Qd81NJZ9/Y/o=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywoo6SPGH6XMqdw6qcd0zR4ebO9RgClLLPA+WyhtsC3asnmnNIr
	FGm6VcWYDi39x2TdLFVd4SIikS3xwp+f0EvLef8yUdCaWqDP8wEwa2Qw
X-Gm-Gg: AeBDiesMfN4AelrlT8nYhscvFb0UoZEf7/xMxXhgVe8OwnBaV9YlgZbpd42doUQv3dj
	HdWZzRqp6CAUxp5xNTvSH5WWCI1oTH213am9GWVcO0olnURWaynPHevk97FSWRY66hL5GXtrVk+
	yT1vqmDIqE3qwAEkkfSeWrkrnhQsoh6Iy1kUDaEbzV6TlCOSC5a/ax5dYi8PawRB9Gr++nMYFkv
	znxU9xkb6Q2f/gl4Bp+DWRcOcRlHCG8VPT61dsPbkFEgbCnqcUMo7QD1tE2I0dKl8zNy5zIf+Jp
	vMBhk0274atpXeBREVT0k423IvM743Wyj/T032ycQdDOfoAINjGrpD7djwJjc+Ux0f794wcFiLX
	Q08IOTu6mVsbKGXNNIJeW8Ho9M7OS4RPAjM0BViwDldGwQYgeCgco6k+b58VU8eurdXWeR/jWyk
	6M7/GnayT0Kt3NDys22Sr+FMV/904FDyrXWOZ/PWw4obu2x3o=
X-Received: by 2002:a05:690c:4:b0:7a0:4146:6eaf with SMTP id 00721157ae682-7b9ececb2admr263566677b3.16.1776876271986;
        Wed, 22 Apr 2026 09:44:31 -0700 (PDT)
Received: from home.paul.comp (paulfertser.info. [2001:470:26:54b:226:9eff:fe70:80c2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b9ee9b5254sm69514347b3.41.2026.04.22.09.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 09:44:31 -0700 (PDT)
Received: from home.paul.comp (home.paul.comp [IPv6:0:0:0:0:0:0:0:1])
	by home.paul.comp (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTP id 63MGiRaZ018350;
	Wed, 22 Apr 2026 19:44:28 +0300
Received: (from paul@localhost)
	by home.paul.comp (8.15.2/8.15.2/Submit) id 63MGiPLn018349;
	Wed, 22 Apr 2026 19:44:25 +0300
Date: Wed, 22 Apr 2026 19:44:25 +0300
From: Paul Fertser <fercerpav@gmail.com>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Samuel Mendoza-Jonas <sam@mendozajonas.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/6] net/ncsi: harden packet parsing against
 malformed BMC replies
Message-ID: <aej66UTWzQ74dven@home.paul.comp>
References: <20260422160342.1975093-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422160342.1975093-1-michael.bommarito@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280510-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,home.paul.comp:mid];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fercerpav@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A0FC0448EF3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Michael,

On Wed, Apr 22, 2026 at 12:03:36PM -0400, Michael Bommarito wrote:
> NC-SI treats the management controller as privileged, but the Linux
...
> The threat model here is a compromised BMC or management-channel MITM
> on the NC-SI link.

The subject of the cover letter and the quoted fragment suggest that
you have a wrong impression of where NC-SI links exist and what they
carry, let me try to clarify.

On motherboards with BMC (the management controller) there often is a
way for the BMC (dedicated SoC these days) to talk to the
host-controlled NIC via NC-SI which is basically RMII (normally used
to talk to Ethernet PHY but here it's used to talk to a whole big NIC)
on hardware level plus special kind of frames sent in-band for
(partial) control and monitoring of the NIC. And regular frames are
transmitted over the same set of signals, there's no dedicated channel
for any kind of management inside NC-SI.

The code your patches modify always runs only on the BMC itself, the
packets parsed are generated by a NIC directly.

So if anything, the threat model here is compromised NIC
firmware. MITMing sounds unlikely as that would require tricky
hardware modifications and if you can do that it's easier to put a
modified NIC instead.

The idea to not trust anything coming from a NIC too much is good in
general but please take the correct context into account when
reasoning about the patches.

