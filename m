Return-Path: <netdev+bounces-291188-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAPRJgEGE2rU6AYAu9opvQ
	(envelope-from <netdev+bounces-291188-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 16:06:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4D35C2A86
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 16:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B839B300B604
	for <lists+netdev@lfdr.de>; Sun, 24 May 2026 14:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221543955DE;
	Sun, 24 May 2026 14:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LvZETZ3/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12EC392C52
	for <netdev@vger.kernel.org>; Sun, 24 May 2026 14:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779631600; cv=none; b=AH0kAroZQ5nHjKFS1jYfnhEW7WAbgi1bhVkvgroUIl2ZvSz6mnm7bY8Egc8kxucLhloJNh46lje4L2RKT+SYHeBaNh9BWCrjvrG7fMtH//Gl3FY1WgOvQkD5HduQXt+wzEnL6aUmxA1uxnhZ+Tr8yqqmmIdu+OPL8V7dhwh0Ujw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779631600; c=relaxed/simple;
	bh=Qz2+zOV25iTx3zbmTy6kuZTWbglGpfcZeFRXbQSmvZw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=vCPtgolJ8FW6QZ14iHjukMnwQRigqB18yC3hlhjJ8mr4VPT/bb9VVVCdpWWnLqFndSXlZmru/zdP2KxMPKU46vIssaGhgyVAjKjBy7XZhK1Ay1qBdxLKe2zNTi3IDP+Zw7lMjjv3IZIgOltERVTGkyXqiKO1JT1jczo2LnRs+kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LvZETZ3/; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7b6ae2ea4a1so89418087b3.2
        for <netdev@vger.kernel.org>; Sun, 24 May 2026 07:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779631598; x=1780236398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9CJjJKgtWoyZSysUUsYp4qOxs7/XAlSGmIv7oaAgT08=;
        b=LvZETZ3/p3MiybOdsZoT9LC4Q5BQyZ/wjr3jbOX0BGh4GwBHBGZfsEYeTu2mKVtWzO
         asHOcA7L43xWeDlw543bcIXzwRblNTvwErx050fQh+kbtjyBPvpNcWvzDzp8SSFzMg1Y
         w7B2ExS+6ugPGbkEjKPjG0rbRGOfYCS568dq1gmIX033cxixBI6S2V5s4UgORVSd2vnq
         3bfs6LZCJ7sWH7bK0lptkmmSh6evY9anQgx559x3UoAqrnLs78Z4n2bWfD6NjXTUp206
         W2dhEO+LJJwEI7exoXP/OuTkh/SPDh1NeaZc9nDLDcGN2uA2RmuVfb/aBP22gm4lr15N
         3tjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779631598; x=1780236398;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9CJjJKgtWoyZSysUUsYp4qOxs7/XAlSGmIv7oaAgT08=;
        b=gSMaA8AVcsIbCaEXUIQzjU83dAcFWYTsKL96J4d/BcKEOhLtlpthgH/u5KNWk78bvg
         Zl3biGBkOKqCeVCICTlHGglxgH4+QPRyCk+NjKKhOwy8QPx30MzfpysiH1i/ucdK0eCT
         uFqSu4i7VrFVg3m+5Rpd75p770RTy0SIH2wQWHjbXKtyvxrkUilfekq4EA3Zd4r0E0gX
         bF2ESQufVnboKBmoy1RYc//8qn4GIf/iuQ6m1XdcgzIBOoP9jSpEVHTYlbkTK3IeFTjZ
         PkMqM7u9C5ujAMNlgxszt19hRkHoAv0lCOc/xgByOivSanLpafJtHkd7UOpbZBnZygpv
         gdmg==
X-Forwarded-Encrypted: i=1; AFNElJ/E/0eoLcDLNMQxoTE6lqvG9+gUmCyj2ZuZsRiD9z58ESY/Z0z6W3Ouiq3LGX+t5IDtvZS1hhE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxoNl1BuLet6e6PkaUtE/wfdm37HJdnuJ4Fvm8nLj6XSGguptJ
	k3xBVcBiRhTbQuBVYmBSP0a1FGkQOLJqSaVZ3Vb+i0K7ZJkviWVFSS9r
X-Gm-Gg: Acq92OEcJ85D89KOid+O6KddL0OrqSPmZwv4vX5mtK0gsmSjDneOLIXxb8uHwukROw3
	RDuLEs5j09mJJM6Yzn5WhL+kKmCFV3jmyhUHon9d0VHVBCHIPcab9ZDdS1Rc2ArYA2wWtbQYYTY
	uV+cOwHV3dww8MzVfhjgL527ExrDX38fXP6zoyzBKO2gGjDNyAQXux+aGaKWCBnfGQcD9uVrZdN
	dMs/pMXB40WXTgzDrsCAS/8Q3hcWQDfVqG+5fg7e6vClKJTi82Uf8LRZID8QX4Vo78QaX9+PDQ+
	vnoD4CnKjbpne65eZZXSQ42K8OJe0rwiwSvlMnvSE/vupae91LHB2zcWbW9eGfBhPQSQ18BAMEs
	SXz0Cq+hYj7cIcJyXi+AC73kmYhsvv/3Zaaralphji6Vx2CijpnTipdkWorOR6/oz9NX1W+Y7LJ
	/GCSA1zy+qDD7k3RxRplJKhE+pwG2vicm6tFkAxyOMR4/bntgn0K6Pim3aFwPiVoiyLj7t494+X
	68el3E=
X-Received: by 2002:a05:690c:4906:b0:7c5:4c4e:a8a5 with SMTP id 00721157ae682-7d336ab0731mr125169907b3.46.1779631597750;
        Sun, 24 May 2026 07:06:37 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7d38bf2f84esm32902807b3.31.2026.05.24.07.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 07:06:37 -0700 (PDT)
Date: Sun, 24 May 2026 10:06:36 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 lazyming <minhnguyen.080505@gmail.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 w@1wt.eu, 
 security@kernel.org, 
 linux-kernel@vger.kernel.org, 
 lazyming <minhnguyen.080505@gmail.com>, 
 stable@vger.kernel.org, 
 asml.silence@gmail.com, 
 achender@kernel.org
Message-ID: <willemdebruijn.kernel.27d7990b24613@gmail.com>
In-Reply-To: <willemdebruijn.kernel.10f46164d2a79@gmail.com>
References: <20260521121628.309924-1-minhnguyen.080505@gmail.com>
 <willemdebruijn.kernel.10f46164d2a79@gmail.com>
Subject: Re: [PATCH net] net: skbuff: fix missing zerocopy reference in
 pskb_carve helpers
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291188-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,1wt.eu,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
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
	NEURAL_HAM(-0.00)[-0.495];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3F4D35C2A86
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Willem de Bruijn wrote:
> lazyming wrote:
> > pskb_carve_inside_header() and pskb_carve_inside_nonlinear() both copy
> > the old skb_shared_info header into a new buffer via memcpy(), which
> > includes the destructor_arg pointer (uarg) for MSG_ZEROCOPY skbs.
> 
> These functions are not supposed to maintain zerocopy frags.
> 
> Both call skb_orphan_frags.
> 
> I think what may need to happen is to invert the order of that call
> and the memcpy. Current code:
> 
>         memcpy((struct skb_shared_info *)(data + size),
>                skb_shinfo(skb), offsetof(struct skb_shared_info, frags[0]));
>         if (skb_orphan_frags(skb, gfp_mask)) {
>                 skb_kfree_head(data);
>                 return -ENOMEM;
>         }

Never mind. This actually corresponds to the first Sashiko report you
mentioned: if zerocopy skbs are converted, then the memcpy prior to
that call will have stale state.

For skbs where skb_orphan_frags does not do a deep copy, we do need to
take this extra reference.

Reviewed-by: Willem de Bruijn <willemb@google.com>

