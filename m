Return-Path: <netdev+bounces-291882-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLTSFBjtFWogfAcAu9opvQ
	(envelope-from <netdev+bounces-291882-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 20:57:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 051535DBA1D
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 20:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BE16C3036FBA
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E0B63C09E2;
	Tue, 26 May 2026 18:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CwYOinqr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3C83C063B
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 18:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779821814; cv=none; b=pUvVwbyuXzXbjAx/DUhpIVhhG1iqqH7STsVZHNBxnXdNl+S6DmoURv8+HIHsvARpJ6fGhpCnNybB4GGWEHxqjRxHXspgviH5PukiWJx21XSBb6qGO1zNZQADYg0b1tykS4PhFLNx2e+0Unr2kImn96bmDTPRO2ucIvRUagIsd2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779821814; c=relaxed/simple;
	bh=DFEJvy4/kZErZG7uAiAHXJzMGIBUD2dQ9EYHr4sKilg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=G4X+HXwq31dB9xkXTIwg/0hx3IwFHuTRa17o+lep6KhWxT+HmMi9mE8MrOHG/0z4RDidEwQF3B0uQNaN9PJkkvPueS4uhvGhZ7+wW7JT/vAzAEUAYi1nAWWU5Gc0EBSz7XZh8qSdNHJlZ+SSsRdJpYBss76oTAWazF82l8McJFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CwYOinqr; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7c2fa14795aso86463867b3.1
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 11:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779821812; x=1780426612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X06M8fe6ArW+TP7qkYaP7LiibL4twhyfnPdPwC6BYEg=;
        b=CwYOinqrKEDVy+gSpe8fOy9mFf2+BEyLfGn6EM+DyLweZTSdS60/+4+UmzKEAPlBj0
         gSk9t4MUfQewzAC6IvidIPH8npVgY2RQ2SuLk4ufbNp5p2THbRbw3n6uJBmdmfhBnWl8
         kYoQfYWZ+MRIw1B1+UyyiWLpZAjBZNnpec98l+UV2evOj3FH+gqovnUUmgxus5t1M/cJ
         yg9pf+8kbuf4XesQyy0jww745hu2kIwqF3b5kxyx+rwrUTd4U+wpP0dCGkT6sjFMLav2
         tZwrG1ovDxgKx6Px84kb2E6j8tS0kFZl+dnygtNIldqf7ld/s75eL+ftP2CQrvZVR7oh
         gvLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779821812; x=1780426612;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X06M8fe6ArW+TP7qkYaP7LiibL4twhyfnPdPwC6BYEg=;
        b=napzBD03xX82D+PV368MYnF8u0zeuPMgZkaT5Tx6R1VGVFZwpQ9D1F8uZkKjqce5PI
         4TqPPkGBJXT16EYvDPeh93G04N0PLmSu1slsxB6rgysM0pEzR9oWIrQX7MZc90U68Ku0
         V74fBmKuhmIh3XDmxdsk/bhCi+ZZ7g6Hvm7wJeDVRzPmJ8BO/AIVibHbveWY5F8ppefO
         WsUUXQNJOw4RChBu6IEg8pp7rW5WN9WOK7yhveKFhK0rnYetAjS9tLyXivb3nin//I6I
         qClLoktGrIpZM1F/o4rLWVPPVAcuyUogZDLNFSxHyQaG6rXSEo4z7FHsz2/+2RB1gojK
         hKRw==
X-Gm-Message-State: AOJu0YyBepnkO+AxcGgRDOyOUrgLvEimkzU5b8QW04sJTEneRqx7MlkL
	2uUTtjckniX2vAPDLNh/GouDk96eNruwDaJwRIMxdwM6TsmJiVojE3rz
X-Gm-Gg: Acq92OHek4HqmOoL99koJW36G55BaeRWrhTgdF9YqG3KEljs6Ifya0LVsXgO74wmdfS
	hPffF8TVsWQv1e2ua04KteP98khDqcos/Bh50lkjk9XkMQK8EHileXPaMNnginut5flWOsv3s1e
	SfNODhPxj62qUNc5LtpkjWqV3nxh2TvC94Shp/l6siQo8x4zJi21GMoLjAaUrMHgv4HBzESKlXy
	d5cLO6NPabEf47npBwrNN1jr5iYlN71QgNVoBEbeaYM45NXU4Zim9WjNn+jz39NTJ2/1lTe/MCZ
	qTprLQUXrJEsu1BBaXIUbtRrSYILM6xHpYCBAQkesZM3poXv6auQsTaT/IWSwZ7+YUrIQZD3UY5
	mM22pOF/bFQIwDqbIybRjkiVHgX1SXbwaoSCGNI5TJM1a6B0tE/ow9e0O15mk8+0xVeaXT526IW
	rvwGiE3XtSooFTLA8hTuSpxwmitLbjq9uD05cJ7pzGlK2xi7DizW8RDtgeOKFwnBQRt4gAJxS1T
	h8TcasKCzoc0z+ddQ==
X-Received: by 2002:a05:690c:4a05:b0:7bd:8952:1338 with SMTP id 00721157ae682-7d339f5eac4mr210805757b3.25.1779821812504;
        Tue, 26 May 2026 11:56:52 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7d3898167besm64991967b3.1.2026.05.26.11.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 11:56:52 -0700 (PDT)
Date: Tue, 26 May 2026 14:56:51 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 corbet@lwn.net, 
 vladimir.oltean@nxp.com, 
 willemb@google.com, 
 sdf.kernel@gmail.com, 
 ecree.xilinx@gmail.com, 
 jesse.brandeburg@intel.com, 
 linux-doc@vger.kernel.org, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <willemdebruijn.kernel.2e79bc9a2ae8a@gmail.com>
In-Reply-To: <20260526160151.2793354-10-kuba@kernel.org>
References: <20260526160151.2793354-1-kuba@kernel.org>
 <20260526160151.2793354-10-kuba@kernel.org>
Subject: Re: [PATCH net-next 09/10] docs: net: render the checksum comment in
 checksum-offloads.rst
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291882-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,lwn.net,nxp.com,gmail.com,intel.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.760];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 051535DBA1D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Jakub Kicinski wrote:
> checksum-offloads.rst seems like a better place to render
> the checksum comment than skbuff.rst.
> 
> Remove the stale references to sections in that comment
> (it no longer has A, B, C, D, E sections).
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

