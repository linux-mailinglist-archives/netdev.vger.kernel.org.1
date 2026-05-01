Return-Path: <netdev+bounces-283187-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGXcJsew9GmmDgIAu9opvQ
	(envelope-from <netdev+bounces-283187-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 15:55:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 094F44ACEB0
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 15:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85E5B30063B4
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 13:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0142A3B8D4F;
	Fri,  1 May 2026 13:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIfmWqJ2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DD63A6EFF
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 13:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777643607; cv=none; b=dq+MZBl0KRx3g5bfyWQDQ+4/Ckk2Y0arDk1V+mAWcG9zMYuwOLyKHJ8V8LRT2Um1KvWeX3il7g6m6fNdf9T0IjWjeSQ5u/o6aasB3UPnmHK4o8yLACihzm4M/bMxdUFyIJ9Ra74T9kbdcSgb/UCCKuus+rqumV6LpKrLhCFtluE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777643607; c=relaxed/simple;
	bh=MefHtGDr3veSG4g4fudZER9OlKLeoj41zMvLE0mmBWg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=pvsgbBs8hFXU0eoBnMkW59UjJpOL2PM3cI5V6vxeGpzYp20FtvemTZfcXaelCkGMWoImlSrU2NIjcAO+yzo5p6YmSHnx2tJ6I84MdMqO+kwcTieG3YMkjEWkQmfmyT1Ui+WuD962VFhPM4FZTTWsqFTbxjkzeZht0lIcnF4PucM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SIfmWqJ2; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-65c24be9e4bso1407469d50.1
        for <netdev@vger.kernel.org>; Fri, 01 May 2026 06:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777643606; x=1778248406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B26lq8ihVexFKRPs2ffz6ggzVLhTsTx6fPgR3cmx4JI=;
        b=SIfmWqJ2kaG5UiCP7MnGKCMbaqM/E+vAqQuO9imPzSIoGx6vZoC9tBolwZurpnvnXj
         /CRrsW6pSChxkw6FsYtKqyTAfABgwFtlw+ZQBAcaIjrb3YMtZ4+qRJvCBlObW/tWiSuV
         ohFm2qmi2ecyah3cESY3e2gjggwn0ylGCPZ7jby3us1GhecxrbwlMf2FY8uh0a/0Vj7k
         zIUAj6AkZhy8SmaGQRJ0C/JG7SpXNaGl+DZJhJuo6P9XtlG24aWxoB1D0w+u7dEtzUjc
         kS9g0+ye41hHrCDpCxqTHwi4wq1Yy/V1t3ljlOBusx5oNHcT3zlMOAvrEkblLuHIH3+n
         KSGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777643606; x=1778248406;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B26lq8ihVexFKRPs2ffz6ggzVLhTsTx6fPgR3cmx4JI=;
        b=KvL+BmWnjfZwXYNuXtKXGGk30M/U8U88PBbTiPQ6MuU16hftYKx++zFIWTCcDJm1QK
         O4Q+Yz+uyrZyEUIvn8FiaW8IwScAnynUs2ujH29sOVBsWrAHAXvBv9I7qSVP/hwkXyKo
         ITzcXTnq/R4WklCctobbuuT3CIqt5TXDRVUuctkrhm2xrAMJFk8WD5zdJcuz2/7l76lN
         39xHY7BNXb8JCKqeNpzViD27f7O04C0Y1RU5K1fCFleZNyrf/Sv7EeWqK0rfoZQwibmu
         UdhIi3Tp0s8lVEtteRQG9PId/XixytDMCw/jHpdyQ36/vA55F/drHA1NLADckG4Vsps1
         3TCA==
X-Forwarded-Encrypted: i=1; AFNElJ8HDw+PLGsjAkSeVluQ7ZNSrHj6hplEcUOLgLz5tRf8euTQNAfHR5NVxjXBXo//Lh6k5VEqSV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxTNEEFWIaTCkUo4og9loB1N4JWUH+O7rUAT+srBZkQNZOSRb7
	mJJx1gAzvcyB+CoUHGCe0uiH87m5xf18AkwFG3QMdOD1X19cYUghPAO7
X-Gm-Gg: AeBDiesNHIkujvLrjwq0xrmE4kdQcQnqAPvwaqVK+088m01HwyXcw4ghPgBWWFWrMOs
	yCA0voIQcqRv12zELABScpk+j5ywH2EuKusp0t5s8AD9x9nZhE/IfEeebsrMGHP1tZcIqtGzkSY
	oY82155g7tsTl7MtPrZYUP9/28kDetscW3pIaU12/OFf1nmRMUq7XulTkEixHR0YyH6N4KGUIUM
	Uuqv1NXQrFCnw8c0rP3ygbS79svxG+7qP3BD6fsaX+ctivpSnBlBzLhZzkxvP9Qpjex2OSp1Zq4
	hSvkcEpC1pxBDLH3Jij1D0sCFN4zVPtfbPyiloAUSxc80f3ySZhxF/TNR8fEFMmXoTPt6YMVIHQ
	ig6Dl9dhaK5ZB9OpYLG0b5RRonNGkaENo0o0bSYQqB/6Zo2XUWaF5rBCKdeGsWdUlSdeiDcV32N
	U404i74sJsge/lfNmG3wukrp7selUE8DodHLpXd7eC0K9mtOQZVCv5kSPzZB/2zBKX5rDG6tIev
	uWBjQFByF56eNU=
X-Received: by 2002:a53:d14b:0:b0:657:a1d0:992b with SMTP id 956f58d0204a3-65c18f36c6bmr4396849d50.43.1777643605682;
        Fri, 01 May 2026 06:53:25 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65c2e1d95a8sm1192890d50.9.2026.05.01.06.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 06:53:24 -0700 (PDT)
Date: Fri, 01 May 2026 09:53:24 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: David Carlier <devnexen@gmail.com>, 
 daniel.zahka@gmail.com, 
 kuba@kernel.org
Cc: willemdebruijn.kernel@gmail.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 raeds@nvidia.com, 
 kees@kernel.org, 
 cratiu@nvidia.com, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 David Carlier <devnexen@gmail.com>, 
 stable@vger.kernel.org
Message-ID: <willemdebruijn.kernel.f160423d0db@gmail.com>
In-Reply-To: <20260501130046.16008-1-devnexen@gmail.com>
References: <20260430062033.20428-1-devnexen@gmail.com>
 <20260501130046.16008-1-devnexen@gmail.com>
Subject: Re: [PATCH net v2] psp: strip variable-length PSP header in
 psp_dev_rcv()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 094F44ACEB0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283187-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,redhat.com,kernel.org,nvidia.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

David Carlier wrote:
> psp_dev_rcv() unconditionally removes a fixed PSP_ENCAP_HLEN, even
> when psph->hdrlen indicates that the PSP header carries optional
> fields. A frame whose PSP header advertises a non-zero VC or any
> extension would therefore be silently mis-decapsulated: option bytes
> would spill into the inner packet head and downstream parsing would
> fail on a corrupted skb.
> 
> Compute the full PSP header length from psph->hdrlen, pull the
> optional bytes into the linear region, and strip the whole header
> when decapsulating. Optional fields (VC, ...) are still ignored,
> just discarded with the rest of the header instead of leaking.
> crypt_offset and the VIRT flag are intentionally not validated here
> - callers know their device's PSP implementation and can decide.
> 
> Both in-tree callers gate on hardware-validated PSP, so this is a
> correctness fix rather than a reachable corruption path under
> current configurations.
> 
> Fixes: 0eddb8023cee ("psp: provide decapsulation and receive helper for drivers")
> Suggested-by: Daniel Zahka <daniel.zahka@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: David Carlier <devnexen@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>



