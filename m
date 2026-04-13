Return-Path: <netdev+bounces-277989-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGi6LBKt3GnfVAkAu9opvQ
	(envelope-from <netdev+bounces-277989-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 10:45:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A613E942B
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 10:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D7B93026161
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 08:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1333AC0FC;
	Mon, 13 Apr 2026 08:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N+3qnsP9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CBA344D95
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 08:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776069738; cv=pass; b=rugPt9DiDp94KtDIvf8ReDNJn8O8XEjYrY833+Q7gahT0xP92KBe83stV6AKy0syWQUqcjnEc751GoUlbuBTbd9xbAa2BtOGTwGs47tsdfeRb2GKvW1L7FDu2GOjPEhkr6Vbubii72sVH9MfYIQodY+nlMSi47769le6oaOpteY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776069738; c=relaxed/simple;
	bh=2XcrFRiDqBttAxfvbYLUTUsertowMSWnGf9IuBRJKzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bh3aKp3BZo1ya6OhD7+3Gmfui3XSs43cqA+KQDT1h/0qdvarQzJdE2CISsL8NjIVq19/152FA+WfAkIpLN/S8kv951OKR2tD4tsrit+xmj1xUStiTgzi8nAVekTeRRoZIo4Xuv54y/MZNIfLy4+cKZWuX2rbtgkEDv/7XEknMW0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N+3qnsP9; arc=pass smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-50d876329bbso45516451cf.2
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 01:42:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776069735; cv=none;
        d=google.com; s=arc-20240605;
        b=DctAGHdWxcLQsZ3opjiGIK+wmiPpdKhLodSP5lSyNoOgRzBDKPhDkiDYvpziSIlXUU
         2U45UlKrBpfOeRoT8q9jVQReCcqs4kFhm97OjGy0wDygZgyOLz9dN9v1sThEAkEavaGI
         NWMomkgfi2ppROe5Gc61EZBjx6Z2qEjJN82BqoFUGqo1gPH7m3uLdGJczq7p7RIlFpSe
         Rd2CF1liM8WrnPtf9KhFwuGjFAi9BPfbhrZWLGsnv5T8LotiURQFg2KLuEyOlrNnAGVr
         xHMaXDno2rQycPNCzxRh4ad5fMckpvN7ex4mlfuqZre3SbneAXPh5jP4GhBxY+SemYId
         RfNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2XcrFRiDqBttAxfvbYLUTUsertowMSWnGf9IuBRJKzU=;
        fh=3BNJ8fjbF5uf7sNCMqdlYhka1s8wf3OZU5ztIvJeyyY=;
        b=in40HsQad7hVu23v15UE+xU7GHXe6ZErRvd3JN4HtnRipObGS7/TVOAaXoO1fqzvV1
         EacGlqLUV1PWWUxSqWaXkAk8wzWC8TV75hJwJzo6+arecW64assyFb8lwFjtOD02536k
         8cmWLG/KLBSax4+YQwTZB8H6QKVX5BhBbLVBSN6t7dfsohiIjno7BIVv20VAH3Vve5qU
         oKBDY1mhBAbX1FmqYSi11P6pr5vOPKBUlTe+VPiX/lalFGhkpH7RMMmDShRjkYmW6Kco
         QTikzoUfMn6el8fDw+Ybxk1Nrz/6ubW4GWqxsJKjaUr7BPa+RovKsRTgXudGvpV2CVo+
         peMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776069735; x=1776674535; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2XcrFRiDqBttAxfvbYLUTUsertowMSWnGf9IuBRJKzU=;
        b=N+3qnsP9TfMK6q0cse7PpUSPsPefzn6yDMy2ko9xD//lHjaFm6C7a0CajpAG2kuqig
         sJDdUs2JzaWrWatp8CYBp7C62OP7JCXZ5BqXeMuWemVzQczYdOB8chCogLRNOtSGm3jc
         zfSvgwmHhy8wphnAK3opw6zKr5bFLbL/Z34V30y1zgjJDq8xDiLEHJE3ZtuzWafI7nzA
         XyhX9H1akLspMlgJ5CdrPHlzz3myjY1BU6jmnzhqJNnE4SLVZTZ1wo7y5hTHzePIfyl4
         DY8iWjFoTqZg0M4JwSeo3B+6bFi5vHbHSadFh68Nh9RH9nPO1hT+39NYFaz6XB6IdxeD
         Eo0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776069735; x=1776674535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2XcrFRiDqBttAxfvbYLUTUsertowMSWnGf9IuBRJKzU=;
        b=RbSKs3fnf4XA3wk4jEsGY7RtTEKMqHvpXqX/YYXr9zlnxbuZ5Ow2tXN+wXf+QR71HY
         LTRBvawwvwS0a4UqW08gldCce0dSu0cvrbDR1tUeNBrbP0A+mVUiT+HG1neBYoZ/ABld
         WqQX076gvTnyO8c0wX112IhyGQ6VHMWp/RzbvkZnNW+I7pe3d5RZqONK6fPQhSsGnWqg
         7oq5G7EHsGgFnh/26beppx3pzcBz9nvgKOoFhi6m6Ss/q6qIeKFJybkdRjy6nmMGl6Qu
         uKmK0ngqcn5EXjQxQOoK0fQ47HhHfpjGNp/G5S/7hsRNSX0xRUhlPo77ZXShxySQXJmC
         v4Kw==
X-Forwarded-Encrypted: i=1; AFNElJ8WF89iXeJuuIDTIQg6dmWvEgI8dzbgj5ay/m40wOhGCfh527jVBVb1bFw9M7orwTkFecdJStA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSQxwhPWxT1RnM5ZNbct/s5xec2SteKgeAccY2Deo51EmeD0A+
	u9sejnp5tApOxIG55ndOST+bG9FJOhyuwmaNy4C5BWpa5900IdXv4hfzlr4bXrSEn53wprzBhoS
	AliAtrH8rmkGn8im7KPAe/0wvekRvKgt3ANFKJNMg
X-Gm-Gg: AeBDietqI5mCrxdCHX0K0wTXg7z7iqbsvk6c08Fo7pfgmMT1YEKyh7xgR5qYeQY0+AM
	UDUb6lK2e2ek+6QwsnjK6826NtPzX2X2cUl45LPjK3yVTBikgqCbaqJc59Rj7h4iva4nZw0r32D
	9kYLue6nWIbWf7hf36KPpW+Y18wt2R8s/y5jL2Q7tLAbEiIznlf/V8Lzl58Cd71Ewa8eH0OI/0W
	7YHExJLKdlrqcfNxAUMIYxsdLUeIl69gHS1nncxnsrTNDCwCWUMTLo1eM28pu2rXSL6Sgceance
	pFb2KyzW2o7wTmGelsxFXxWDQKA93Yrr/r3Ao2eJLC6Nk0Y9fRl16wmMJclwOuc0ijCFI8NyI9s
	=
X-Received: by 2002:a05:622a:24c:b0:50b:4c64:4730 with SMTP id
 d75a77b69052e-50dd5abce85mr182329721cf.15.1776069734745; Mon, 13 Apr 2026
 01:42:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413035212.56566-1-qingfang.deng@linux.dev>
In-Reply-To: <20260413035212.56566-1-qingfang.deng@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 13 Apr 2026 01:42:03 -0700
X-Gm-Features: AQROBzBfkFcNn0wLV-xgVF2GweBXqPb3iZg3BCAv9RalTQujVLQJiszzpcmou1A
Message-ID: <CANn89iKmxWiCTt7nVk-DZ4R_KsYDYbPwQ5f7Hp5F8hWmr+zc=g@mail.gmail.com>
Subject: Re: [PATCH net-next] pppoe: optimize hash with word access
To: Qingfang Deng <qingfang.deng@linux.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Guillaume Nault <gnault@redhat.com>, 
	Kees Cook <kees@kernel.org>, Eric Woudstra <ericwouds@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-277989-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,linux.dev:email]
X-Rspamd-Queue-Id: 19A613E942B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Apr 12, 2026 at 8:52=E2=80=AFPM Qingfang Deng <qingfang.deng@linux.=
dev> wrote:
>
> Currently, hash_item() processes the 6-byte Ethernet address and the
> 2-byte session ID byte-wise to compute a hash.
>
> Optimize this by using 16-bit word operations: XOR three 16-bit words
> from the Ethernet address and the 16-bit session ID, then fold the
> result. This reduces the total number of loads and XORs. The Ethernet
> addresses in a skb and struct pppoe_addr are both 2-byte aligned, so the
> u16 pointer cast is safe.
>
> Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>

net-next is closed.

https://lore.kernel.org/netdev/20260412142250.131bf997@kernel.org/

Also I would suggest using hash32(hash, PPPOE_HASH_BITS)

