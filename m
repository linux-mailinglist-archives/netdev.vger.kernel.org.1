Return-Path: <netdev+bounces-254064-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPfzHnRweWmIxAEAu9opvQ
	(envelope-from <netdev+bounces-254064-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 03:12:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DB95C9C2CE
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 03:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B57163017384
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 02:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B5B2882DB;
	Wed, 28 Jan 2026 02:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUHYdpeR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f67.google.com (mail-qv1-f67.google.com [209.85.219.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33C228725A
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 02:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769566319; cv=pass; b=QtKbgeKZMIvovwIK0fVd632lJAlGwIEpKBTTHLVgSiZ6TxoKHz2UP2xX0OGW8XD4LSlB0T5xUnTsS3/mUrMwZ3uVkAuALrsoEG/1YYTtAKzVZ2Dzn3XemcwiHExeOP3R/ANqvrg+MsuF1TLMVdw4g7pEtkLsUdzPE9aGcLqRZns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769566319; c=relaxed/simple;
	bh=cZ8gI/vk8ySTLE077sMXqPrf0qF7EtSUOgT302c+2uA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kfXuDU9Bd5+2ffZf1Gdj2dofCZodrZmkSh653Zu+HyAjrfrO34KoO8D+Vxgw1KUBJPnVrKzHQWXOWIte+RF8FLv2yEq8JjZ33rIHTVx+zU0m5oB9SWd2jiHeo8wLhpyBiVI8NAPDYHJvVmWXTQ4oVe/HptwNy5yxyASxatkcVgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kUHYdpeR; arc=pass smtp.client-ip=209.85.219.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f67.google.com with SMTP id 6a1803df08f44-894674a4c4aso122097376d6.3
        for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 18:11:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769566317; cv=none;
        d=google.com; s=arc-20240605;
        b=bKk210xQX6KgEkuZqWjpWz3l2oR5pg/fGlwSh4PP5Jhu8yG+nxcsLj53PoRPoFBczS
         6z+hG3FYnsw1uTCg2nyaT3QmLhktbWMhvCoW+L9Z9Is3KQDOB5Q3M5hsZ9czWOGixYzP
         9mkSt0yTnxk8vt9fr3xbC8g6J6oYqR9O6KkVNM2oRucS7+JBDYTQBJwMv3ldnCaClANP
         I/smZH95qDilVjelyp53Gd1YrgTsoFpFgk2hmtwlIa1PTybPchTOHtClOe520/rZVHhv
         h6VVz0e/hqJ93AHfBh52vywEw+EZ0SgLwyNF7DMp2sybKxOX2BSPOv4+c/zFj03nya7j
         v2Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cZ8gI/vk8ySTLE077sMXqPrf0qF7EtSUOgT302c+2uA=;
        fh=eJ2Vv9/sDxFwEuihA7pmDpvYOVJ2QPz64XPULQEb+M8=;
        b=FWcPEJnTWJv3JzW/uBhQkhdu2gZv6KWuQIoMJ33r8u3d9TU+k35kSN54mwfirHRH3R
         8cMGgdtQexN5Yzg6+J+J6wfpREnpVr35m9fW4kIx+DPl6U4jh5caPl60rLMtHMztoD7Z
         dXjROIZcLer3Q7ESbf3EnrSThdrVzclXWmGm16XvoyMThkUq13ogL8j9mA0xKuqCHoYS
         fTHGRtBVW5hzHm5m7iJG1BANPZL/icSbqJxZbc7MQYO4vyfhZHd9zKXixTlbE61GV0f/
         J7YXo2aCDbR+Now5GIv9LVPi+SMVGKL7LjRSudO3B3Zjl+lcBrjwb5DKEDHGdotOjjbD
         YLqg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769566317; x=1770171117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cZ8gI/vk8ySTLE077sMXqPrf0qF7EtSUOgT302c+2uA=;
        b=kUHYdpeRkljQycEUfVM0IkobmO53GG/kKIqm9MtBCqFoqkKT+mhhJy+iBRY/V2HfMv
         qsD+w3F+F2yOL4GJgiJ2pO0fkTqOhE9H/CMZK8Bq6YJ8sgSOCtOV7TIC7JiMz6p+RIal
         r6Slxb6sTaTvMcctBIx+caTLsvui5nst6x2DVPE9dEIDfczlwkDXoncFltb2Oh9ZKpNr
         EsJwzGNfV248T1k5XkV1gmWqlfjAi7f2pJtbh4p4O+CnD5xPE+ihSGqEZ0Zl0wHvrhM7
         nnFtw4gjbVYKRMLsvGllzR5md+U4QYaqz5ugp2bqtu+ReTjixuiFpwq6RaTnP0fRo2JD
         r12A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769566317; x=1770171117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cZ8gI/vk8ySTLE077sMXqPrf0qF7EtSUOgT302c+2uA=;
        b=P25GGVsHUr+orI45tDyHqx/lQzwKcA30EVXw9Nvj4bp12+OSLzDVWf7X+pRQj1Asxs
         6BnCChTbljdz2Ikua122OrbTc0pZn12/z++ZJ7v1K/jndeBG55hXd9rf3E/6AwUKingl
         Qo8xzLB9p8zX/LdBWZNhZpqN+59MY4UTk0LHwDY0tj8KiggxJqxOmCufUgPpzojWKU0F
         QEUQg5muDYjc1PG2SohBX4nQfXCYCDXHYmJlQdClIUYGIY4BUToCL5KHZSuuTLptY5Rm
         zrN2iRuCd517luGxH3/cYNjJopOpt9qkCQviXE/qR7AMoWqAd14MRdWWUaeuqIZsS5Cq
         RTbQ==
X-Gm-Message-State: AOJu0YygdbvH6Z3oTcMws8aEN7Y4yP1d6RFbavBRM0vRf8A1El3v6NoP
	5MMVVPTz+ahGe61R1h5Fx9EOkvy+gwNOzGP2+obrQ3ETT24twnL4GUNvRJJNSusF/n/eS2iNKYw
	imt63X63qIbGGRw8zYGoOHf4X2g6zuNY=
X-Gm-Gg: AZuq6aL+eoP66ZUOzCOp5F7C7CDzk2JO8kB3hEYBZhE0wunaZzFTMwiiFcncQsX3WgF
	JlQhcQT8d8jvbkDRde6Vl07nv4p8pcb5FVLNYswvOnkPBanY9zBioat7QuSZoLFVNsZY4q4vSsn
	o/tIAODoWg5x7ywwmwwKfB6OTD+pBn/L0lHhkXlwSZIEt/3NBA6or6Lb2uxqr9oEerb5sCDNQ+m
	98nYb6p3JcaWPeFAzPiG9QY4/CL13s1AJO8Rhq3X6eqbCIZnscr6lp3UpQGNF8IlKvg5Goca4Zq
	R0Nqnm9Bv23j/CUx0TcaeNJdsfFyf4AsoDHKWk2Ej/iEgehKXNbi1fQ7wbhcrw==
X-Received: by 2002:a05:6214:dc4:b0:894:6f12:af5c with SMTP id
 6a1803df08f44-894cc808849mr58895776d6.24.1769566316752; Tue, 27 Jan 2026
 18:11:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126070618.53758-1-enelsonmoore@gmail.com> <20260127180109.357a45f7@kernel.org>
In-Reply-To: <20260127180109.357a45f7@kernel.org>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Tue, 27 Jan 2026 18:11:45 -0800
X-Gm-Features: AZwV_QgjZTW_BbRB2T_UU5KIX0NToBkw5Wtci67vMTErK3csBgCoWjuX5zhMF94
Message-ID: <CADkSEUj9Rs8LaJ6NjqPE3M2+2b_Yt9vif4Lr+hFObaykcdNF=w@mail.gmail.com>
Subject: Re: [PATCH net-next] net: usb: int51x1: remove unused includes
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254064-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DB95C9C2CE
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 6:01=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
> $ git grep 'struct usb_driver {'
> include/linux/usb.h:struct usb_driver {
Good point. I'll try to avoid introducing indirect header dependencies
in the future.

> Please do not send v2 of this one.
Understandable. This kind of trivial cleanup isn't really necessary
anyway; I just happened to notice the unused includes.

Ethan

