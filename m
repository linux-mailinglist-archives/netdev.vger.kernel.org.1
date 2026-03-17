Return-Path: <netdev+bounces-268605-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JW7C2pYuWnYAgIAu9opvQ
	(envelope-from <netdev+bounces-268605-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 14:34:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EE32AAF25
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 14:34:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F152A3030B91
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 13:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2073CC9F9;
	Tue, 17 Mar 2026 13:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fykOq1YD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3B03AE1AE
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 13:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773754061; cv=none; b=jRZx8O/dARnvLu2cQXu7vmozNqBvR9Y1wibEAaJNC/4f1TYYR0zGVrClQWxPAv4weLoUf3gmI5/h+on2ZvolDM5Og2RnbXzDkToPrd8E8MOh/kpqj6tmJ2d1rP/NkrXWubvRiF9Y7s7RnOtN0lt5bOc41g5KbzUy62b9dy8f6hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773754061; c=relaxed/simple;
	bh=ikDInS/569fx0TmBO5b0XgY/qVS6a9yIqKr7YcNt69M=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Ho91EAzpheB+3P+9dKLb6TgiG9nzHXCKf44w8wdWY4ebAL/r1wfU+Xz7fLMK0nRxy4/N3HDcjfc38Vr7POzK/vGqOFq2OYX4Oe3A8jnWidMmkTVR/TjEIfQdSizCimVqKFsC3s9sMAgIP399Gj/SdIukYTDELAAwpDPmtFtYTn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fykOq1YD; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-79a40fb9890so23845947b3.1
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 06:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773754058; x=1774358858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fMzTHu1aP/+ryEaVbORN4NuS7FAdq73GkOmHjCB3Qz8=;
        b=fykOq1YDsCuzQExBmRkeWYHLL/uMsCji1tf9a+zwioGt9b0OM0HkagM97OZvVHcfk7
         QXLPpwjw1hEdyd28aSyiu5dszi3dvR9y2lC344HGjlrPU8tM7hkVxD6V1DHUqZFzMBz+
         LHhIHn9JUKklJcI66cVaOhEVY1vzGGLapvbQb7pBdVErWIcN3LDA0PohhFthRnAb3Mg0
         9PrtXMbQLwKDwlBDMbB3FBWb/JDgaB8SkqJsbpkFtNwody8FfD9Wi+HQ6IUc9XBnU/LN
         2POBe7FY1fQwHxhq+A0bmUE0JesbmxzPT2uu0yjTBMLz6hHxe9dIJOgBTUxHBXLcrX5h
         tTUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773754058; x=1774358858;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fMzTHu1aP/+ryEaVbORN4NuS7FAdq73GkOmHjCB3Qz8=;
        b=OgDhrB3kWst1U4QY+8Ikjfr4pMd6PaeJME7CmTQQ/89nLvv/0g6XKWOyNLn/r3uBPn
         6stytK2dlAtDItBx3Ggh9+1ZbRA34sWNyN+96iZINCLgtZSs1WCRBa6dECmIsAxhu0gj
         rq6srae7ByErADZRoe1M/4IORDgutz4HC8AytYpjq2gVZ0surmNO+YkPDkTw3JVShiah
         uBFD3nGwQp27hLwzhCWrkv92J3+CHIf3PlkRVOndtBuueVKhmJFMgYSaKaF4IGkTLkTd
         wszvEDxL1aIMzOUGkQjxpV0TZKrUQ4sSDMn7wpuq3T4CWDd8jzdX+SmIFLZDMPvIDe+s
         ilrw==
X-Forwarded-Encrypted: i=1; AJvYcCXGVJczEq9ip7x+Mele9CL7uvqsIL+r20W0pUaiBDYYkd6RZddn0Ys1xK4/c0EpSga0S+PW4UI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzk9s8dxX1os6pgPuCyPGNIQaPh6ET7pdRhSAxqjgql2pkGW8lt
	cxDY8MvO2xmXyuy8FSRFq6X/8mnCya0dwns3sDWm/jJeWZif9Y/67Zt8
X-Gm-Gg: ATEYQzxnZggOB3tp7jJipBNdQvFWuPfRDEVP9dLmujr1CznD8woeKGX4dQFfoodpX9F
	uJHAFaThHw3nKxERlz3F2yEo2WBwCZQtuk98F0QuJ5nSdDy0dsmm7PllYyVkeX0iR+Ac3YzNvuB
	jBHiz+zMftF4Vd9Y7zxuQNUPYgMkxG3q7Va/ufxgONpOQvdkUbYrp9x8R+F/TakI5pklAwQ0o0v
	Yr2mnNq2czHeCu3qZaZ5u7WqQEzWTMxraa+nCxhLDq3wVZu1l6AX+0cpQXr9AaKDCz3bJKGNgU6
	asrm0mkLU6/79nzCl1+BRcysrUD2ABOzMI7TnbVxxiIQ/PKvxj1BZ1PYnG8Binl4Hk/CTA+3eFR
	q3FDI0/++MdkA06C2hkAis2N/lFILvW61hvFRvxDy7gTy5qwFRR5oaFfVKNz7O3IqcM+CGSVoY9
	bH77G1CUa/Rl5T1/ER1m1Sgi6iR9cbm0Xkx4PHuliE3/XCKxHqEUaaL4UFtpBXgZP8aaoadpIrQ
	s7q
X-Received: by 2002:a05:690c:698f:b0:798:613a:2efa with SMTP id 00721157ae682-79a1c1a7074mr176740827b3.40.1773754058231;
        Tue, 17 Mar 2026 06:27:38 -0700 (PDT)
Received: from gmail.com (180.134.85.34.bc.googleusercontent.com. [34.85.134.180])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-79a51b4676esm28742607b3.40.2026.03.17.06.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 06:27:37 -0700 (PDT)
Date: Tue, 17 Mar 2026 09:27:36 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Nick Hudson <nhudson@akamai.com>, 
 bpf@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Nick Hudson <nhudson@akamai.com>, 
 Max Tottenham <mtottenh@akamai.com>, 
 Anna Glasgall <aglasgal@akamai.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.3102df56d5f64@gmail.com>
In-Reply-To: <20260317121429.2399539-4-nhudson@akamai.com>
References: <20260317121429.2399539-1-nhudson@akamai.com>
 <20260317121429.2399539-4-nhudson@akamai.com>
Subject: Re: [PATCH v1 3/5] bpf: add helper masks for ADJ_ROOM decap flags
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
	TAGGED_FROM(0.00)[bounces-268605-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,akamai.com,kernel.org,iogearbox.net,linux.dev,davemloft.net,google.com,redhat.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,akamai.com:email]
X-Rspamd-Queue-Id: 47EE32AAF25
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Nick Hudson wrote:
> Introduce helper masks for bpf_skb_adjust_room() decapsulation flags
> to simplify validation and keep flag handling readable:
> 
> - BPF_F_ADJ_ROOM_DECAP_L4_MASK
> - BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK
> - BPF_F_ADJ_ROOM_ENCAP_MASK
> - BPF_F_ADJ_ROOM_DECAP_MASK
> 
> Also fold these masks into BPF_F_ADJ_ROOM_MASK and per-path flag
> validation checks.
> 
> This is a refactoring/plumbing change; functional decapsulation and
> GSO behavior updates are handled in later patches.
> 
> Co-developed-by: Max Tottenham <mtottenh@akamai.com>
> Signed-off-by: Max Tottenham <mtottenh@akamai.com>
> Co-developed-by: Anna Glasgall <aglasgal@akamai.com>
> Signed-off-by: Anna Glasgall <aglasgal@akamai.com>
> Signed-off-by: Nick Hudson <nhudson@akamai.com>

Only patches 3 through 5 were sent to the netdev list.

Please resubmit the entire series (after the customary 24 hr min) to
the full list.

