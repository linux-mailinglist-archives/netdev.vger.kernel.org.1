Return-Path: <netdev+bounces-301885-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +m0/F2DdPGootggAu9opvQ
	(envelope-from <netdev+bounces-301885-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 09:48:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D716C37BE
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 09:48:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Su3Fye9N;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301885-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-301885-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AFBFE309FEED
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 07:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEA2344D92;
	Thu, 25 Jun 2026 07:45:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A0735DA5B
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 07:45:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782373505; cv=none; b=tW0wUYQ8CORI31pGkRd3elEjMQPZsFt/9IxSi6atTCrD5zFjnSnetJl7N/Xn/gIFu9h7drgyBehq+cCs1XC2zBydhgWfu5AAtR8GXTiF+moSurvHvHGUl9pxWRWmB3/Gg2P3YvBOEKWIhgWvKuRkKnYn4TST5llig6k+Tmys6mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782373505; c=relaxed/simple;
	bh=YeJXzriIDfluh0Ye+Z0A3XrygBXFzdp3e/NMJXQULuA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CUpKo4IFyKX8d6uDjgdbymxwBN1JfDPPMxBG9N5IO4F0XNp7bbs3J3BUvP6IIfaBuuVcxBz8kAXdE6DFQL5vMKiMMlcNyE8QVe4fqdRG5yDB0539aDGdZPuJ6ueFrQNp7ujnsFwvP4wflIe1KQt7F1rQ8SarPJnm3g1gwH5Wn5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Su3Fye9N; arc=none smtp.client-ip=209.85.221.44
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-460166910e6so1178180f8f.2
        for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 00:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782373502; x=1782978302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L8xoSSuA8UVVk90oX5gPPxTiv5/TluVnjfAU4xzudUI=;
        b=Su3Fye9N2hW28SG1LG8SuUuE7kAw8X895/arFkNUDwVE3q6GWXMIQNKUYQ2jOYk2Ac
         OsDhXNTQp7fz3LLU/8pV+U16ZSFwVj4ic3+E+1Fgm7aQm8gm8ZBU/AHi88st9cMdXEFQ
         4aI4Rre7Or0DJOkSSYL1vBHC/IxIO5nZErh26kgw19NGjoFQciNUcvB+uAoBhLeqpdpG
         X0MBkxj7I0obIgLm0AEk4U8Uw0NA5db1IO9Bwbd0kGDMNQPYXZXv4ISq/rTGp8Z4nsAe
         68NJhgF1GJCNoNFAiWLV159E6RluLHfL5agDXxkHuKWVQUVMGAZKN4BRtete0tUAixwG
         f30g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782373502; x=1782978302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L8xoSSuA8UVVk90oX5gPPxTiv5/TluVnjfAU4xzudUI=;
        b=GwvnktnTUJH1SyZJu+y7zy8o1t6GWDLZ4X16lSiSx2xAgq5fFmiHkfW8SbYd7OY0dy
         BMMNDSMwqlA4LTIZKJGeKh/brLBY63PSBYKn0LmPvSC2mQclr3guEBYENMQw92bm0EHI
         6qch9C7a/QO5xiYSLi2S4lSlJEwW/fzg3M+uos3Hyso762V8EDMeaFqbtL9EuB48VcTS
         wStc5S1gm9VU3PquB+GNsR1KA3tw95/6SSIpdGCHY0ccSMQsc2rz4aOiZDj0UfJWT3oJ
         LOgHiLL2PH+Zqsui4PS5/hzfFbXk9zfzyfMAUYAi/P3FkXfcAqyIHjtAjmlzmLH3aArD
         Ce3w==
X-Forwarded-Encrypted: i=1; AHgh+RpDveMqnxsZTkQOqgVkTcruym1zvJlCfIJnMUM0AOhVBgcWEVQnDIA2QF38388gkhcBv9g5Pmc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn9JohnJb3NC+YtT6Eex5JtCzyhZyxNF52PWSVm18XtjKIYTCU
	unAMDWFxCB9o0vmuN4eGQg3aHjdtqz9KnJNKWz8qaRXiExIa19QEvK3b
X-Gm-Gg: AfdE7cn4cvXuV+zxrsZhYl670bKeOVJegqi0Xie9ZlF3sQnpkhPrVo9LhIu/OsJVlHF
	jxa2wUemT5HMrDaE8h+mgZGElZxY75y0qyN1B+dPO85qzN1VNUW6BU17yu7RSoXK3PpTdg8/sEx
	IX6S6xDNax1JRkDkYq1iCsL/mnlSwVUaS1dInqCLyenHcWOEwuyO1QZWCuBYaKjQwUFwK7ViDlz
	2R93Fvp9AACq4An70govb4YuKk+baA2X/XxhDQFilo1QT3b1wRqzBc9+V1kdrD4F4EUN2guXgwS
	8DeCnhI5q6xpeYz1+Evf3MqFt6TjcgV2QzyEjoyP1Rm85ZrEPFLqhY8yqsl/8L20lBAab/Y1dpH
	1/kQI5EhtJNr5A7aHqq/1mJHFGdAkDcHmwT6gRvrgRl/FcSqO0lT1mcM8EgAhY2/VHrhCllkHwW
	MtZrOV8254ZfnQq1ADHbWHbvS4p91qqUVYTT/6iS9GG05pcuCMjg==
X-Received: by 2002:a05:6000:428a:b0:465:1c33:1494 with SMTP id ffacd0b85a97d-46dc04610damr2026412f8f.2.1782373502207;
        Thu, 25 Jun 2026 00:45:02 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46caad603b3sm10957157f8f.7.2026.06.25.00.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 00:45:01 -0700 (PDT)
Date: Thu, 25 Jun 2026 08:44:59 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: dsa: mxl862xx: avoid unaligned 16-bit
 access in api_wrap
Message-ID: <20260625084459.7393409f@pumpkin>
In-Reply-To: <20260624175239.1b97aaa6@kernel.org>
References: <599327521db465a534d277de53ab9b6cac01928b.1781702256.git.daniel@makrotopia.org>
	<20260619100154.794168e5@pumpkin>
	<20260624175239.1b97aaa6@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301885-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[makrotopia.org,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:daniel@makrotopia.org,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B0D716C37BE

On Wed, 24 Jun 2026 17:52:39 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Fri, 19 Jun 2026 10:01:54 +0100 David Laight wrote:
> > > The MXL862XX_API_* macros pass the address of a stack-allocated, __packed
> > > firmware-ABI struct to mxl862xx_api_wrap() as a void *. The struct has an
> > > alignment of 1, so the compiler is free to place it at an odd address.
> > > 
> > > mxl862xx_api_wrap() reinterprets that buffer as a __le16 * and accesses it
> > > with data[i], for which the compiler assumes the natural 2-byte alignment
> > > of __le16 and emits aligned 16-bit loads/stores (e.g. lhu/sh on MIPS).
> > > When the buffer lands on an odd address these fault on architectures that
> > > do not support unaligned access, such as MIPS32.    
> > 
> > Isn't the correct fix to not pack the structure?
> > (or probably any of the associated structures??)  
> 
> Agreed, this is very silly:
> 
> struct mxl862xx_register_mod {
> 	__le16 addr;
> 	__le16 data;
> 	__le16 mask;
> } __packed;
> 
> But some structs won't get aligned:
> 
> struct mxl862xx_mac_table_clear {
> 	u8 type;
> 	u8 port_id;
> } __packed;

Does that one need an aligned(2) ?

> So I guess the "just don't pack" will have some corner cases, too.

The main problem is the original 32bit arm abi which 32bit aligns
all structures.
But that is pretty much dead and would want a packed_if_arm_oabi
define.
Unlikely to be relevant for this code.

	David


