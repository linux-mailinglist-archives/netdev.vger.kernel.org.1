Return-Path: <netdev+bounces-269642-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIJeASFavGlxxQIAu9opvQ
	(envelope-from <netdev+bounces-269642-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 21:18:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C622D2020
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 21:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 190EC30093A0
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 20:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42ED937AA72;
	Thu, 19 Mar 2026 20:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kb5dOFeR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08749346A11
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 20:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773951515; cv=none; b=ChbHgnbjVxw2UPssvAhuc9WCmvlG5eCAhem+5tbFBAVG4dbjMVuKvXUt8BLFiJrilLNBrGr46qzRtbPTd31LVkGlwefrJpXMBso38ck/UAoYpiDXsHYTfzH+/0mbN7EonlLLoF21vIGKjCxCBDliEfVsJ0E5BcmD3BuiLD1rwUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773951515; c=relaxed/simple;
	bh=M2Hg43+0UC0N92knxeYW6oG/657XwdIe3fZE60y67TY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=AiVVv0Pf/AyPItojuJD0eqoKX5YxPqZX9WSfexluLa5uz8aPvXAQJqGwuvYalAD45nxJOcZSZQmxxwfUNaMUmctUW9dZPr34Ewv06NF9E1WRJL5NQEjBSONXONK4Q/PJr43/m53vqt7xv/ec9dU2gHc6G2hVTOy5epbrwgw4mMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kb5dOFeR; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-64ae2ce2fe1so1649941d50.1
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 13:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773951513; x=1774556313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kC0ujPM3fG+KAGL7Vh/MpD+wtFdgO0dnfE2PhOjTt0A=;
        b=Kb5dOFeRk6PsyZpgNAUREkV9HKzprUU/BjV44vtKZn9P2tAt3Re0TKAXrKS4hc9A/l
         FCc1T9P7g8Au2pQtnNJuAsMSZS10Gxb9BhN3+LnTIq2EBH93lNt76gdGtSo8xzKUjW18
         AwzFSgX19h5qXoSOuZWbLWrPCMtxzgLHWySutn9d7UQvFlAQDoqViMngmp1pW29AJ11k
         ujggqemW5/0HAuq6Qbrbjg1I88sGQMYd7IS9FtHZJzLU536OTqW9KY3kBLvESsklU+EO
         cHQajAvoUqpzomdIcQAEEuDyzbfPrc8h0KgOcB0KzvCqVj6Sx+2RCB+3Co9iJpqIDgh/
         11Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773951513; x=1774556313;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kC0ujPM3fG+KAGL7Vh/MpD+wtFdgO0dnfE2PhOjTt0A=;
        b=L709LHAXrqD91IWhEzIgxy2oTxOnQpWzZ7Px7GHQbSanu6bH2OxUzHcepskdrFBAB/
         Du4F+c/M9wnCPgWtZMOvxg9UMZ6q9zgIgPYWK8TziSfBMpf6UEgfBDNyTeD8VHvsXAjV
         6LWNMzqbm184xNXUNFzmEAMHeu6+fxbrAiO8bvMCM+z8se6qlfFhr8uRctOOlTV6UTFD
         O6epiEZtOClyALizBLRufsggmGzPMbvshJB9fALVqLDbE9EtBFIDeSPl1KhdJ+mYCOKl
         wyCeLxfrzL6JeWL7HhVZOUs6UZVj6vYl/69yqkRHAiffVbkhtEuA4Vp8eNe/xZMUPeJi
         3ZkA==
X-Forwarded-Encrypted: i=1; AJvYcCUOSrXXdoQ0895a8ZBD3RDzLKw8/VWgqKHg74ZS6PbNhheucflLQkgPoY0I6UoPCkWSqdBZlZM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6xM1X/sLUUPMa4X2NB7ipEOxO4746LaCjxFbfeDrTrHGG3aUQ
	Tr0/KattpIcZvIL6GnogjXmYjvzxx2u81Apg1obFy6fogvru5tXg/IbRK+CZAQ==
X-Gm-Gg: ATEYQzxRO65wHPu9OVTqCGLTiR1hTknbIhlmZSBTy0cyvKcWAJaW8HiD6FcO0Sqk7Cp
	6b+sMskG1YX9PYXd1i0nQs1Gr1DjBR9Zfqf9T/ASOZ/DETYCV0ekePRZIs6T3EuV4wZdA0NBcQ7
	/eX344tKQI8lA26i0N263NvaMjfDSkAshuq90S91hQHgzC5a+PsX8m30N5yjgtjCHcu0vhJuM2a
	NtnIioVe0AqJWU+UdmyGt3ulFnrHCevEv7Ud+yeEplxYX93ip584fFgNvQeS3yLCWu+8LpCPNAw
	+zWw9Jy2DRkj/rMOMbQBY9wi3M77z2d7XXl00ConA9G2p+6B79nBkt1DwkiCd5Pbe+RgFOWECj4
	yb+sN8ncLSQDzLgAAvMzjprPRMylPg9SfAtqqKfilQEac869rfnvK4J5Urq6YRpnyq8sDSY2PfW
	Kex5hpFB91bJ6WYT7lWVlHFoQy19iKh+SHCgFnSXWqz3F6eYCSFcih7ngl4cfilZJ90N0lSXWoe
	cvx
X-Received: by 2002:a53:bdd0:0:b0:64e:9dc7:90b3 with SMTP id 956f58d0204a3-64eaa7ab875mr759150d50.39.1773951512938;
        Thu, 19 Mar 2026 13:18:32 -0700 (PDT)
Received: from gmail.com (180.134.85.34.bc.googleusercontent.com. [34.85.134.180])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-64eabecdbd3sm72212d50.18.2026.03.19.13.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 13:18:32 -0700 (PDT)
Date: Thu, 19 Mar 2026 16:18:31 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Yochai Eisenrich <echelonh@gmail.com>, 
 willemdebruijn.kernel@gmail.com
Cc: Yochai Eisenrich <echelonh@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org
Message-ID: <willemdebruijn.kernel.2ccb41b9933ea@gmail.com>
In-Reply-To: <20260319200610.25101-1-echelonh@gmail.com>
References: <20260319200610.25101-1-echelonh@gmail.com>
Subject: Re: [PATCH] net: fix fanout UAF in packet_release() via NETDEV_UP
 race
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269642-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	NEURAL_SPAM(0.00)[0.213];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,calif.io:url]
X-Rspamd-Queue-Id: 08C622D2020
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Yochai Eisenrich wrote:
> `packet_release()` has a race window where `NETDEV_UP` can re-register a
> socket into a fanout group's `arr[]` array. The re-registration is not
> cleaned up by `fanout_release()`, leaving a dangling pointer in the fanout
> array. 
> `packet_release()` does NOT zero `po->num` in its `bind_lock` section.
> After releasing `bind_lock`, `po->num` is still non-zero and `po->ifindex`
> still matches the bound device. A concurrent `packet_notifier(NETDEV_UP)`
> that already found the socket in `sklist` can re-register the hook.
> For fanout sockets, this re-registration calls `__fanout_link(sk, po)`
> which adds the socket back into `f->arr[]` and increments `f->num_members`,
> but does NOT increment `f->sk_ref`.
> 
> The fix sets `po->num` to zero in `packet_release` while `bind_lock` is
> held to prevent NETDEV_UP from linking, preventing the race window.
> 
> This bug was found following an additional audit with Claude Code based on
> CVE-2025-38617.
> Link: https://blog.calif.io/p/a-race-within-a-race-exploiting-cve
> 
> Fixes: ce06b03e60fc ("packet: Add helpers to register/unregister ->prot_hook")
> 
> Signed-off-by: Yochai Eisenrich <echelonh@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

