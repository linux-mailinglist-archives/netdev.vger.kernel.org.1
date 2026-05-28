Return-Path: <netdev+bounces-292642-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIDtCnoTGGrKbggAu9opvQ
	(envelope-from <netdev+bounces-292642-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 12:05:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CED705F02BD
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 12:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2CD9330A2673
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 10:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A8C38E5C4;
	Thu, 28 May 2026 10:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JqlHraAJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HaessMLD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0036E36683D
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 10:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779962594; cv=none; b=JF4Vil0Ct+LvStBuAL2x+Fbh/YPmEbw/zixqiKkAoHo6/CjJut72G/cc/ywv7ENnAkWY+xsaU/J7hm1tiCmPPuwvaYr5hhxhK3tlwdYvjXlxMoOjkJYHX+89k2v9pUUAzjRMT0edXM+rCvnF4kgoGvgXlEHQ6Yxk1iIVhLeWb0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779962594; c=relaxed/simple;
	bh=UQpRENfg3ldv7LSQH0Hhn78OhB9u7r9v6hd/YkeVacA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZLhtabt3pbZH8kuuyxvo0y1CttENajL8F8TxEhySwasSgFv8pTg+azWIp4ZawUjnWiiD6k7UnbfaxNPQnyBmdQg0IHRNzPtTYRL/M0rre7ceKq031IJE7oFzzoLkHsyR0tclqcOtrs2jsZqvhtck8XVsAsTxwJSwOp0Q86LvWlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JqlHraAJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HaessMLD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779962591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XD2Y8H2SIlgkz7KIkHaw+1uyQ8vGfYmWnYbfWvcYOE0=;
	b=JqlHraAJgf9Exnv+wtgcU2D2WNnuC/hZJOCDc4cLDwP+NF83t3Jln0r6qWc3TqbF4SC13r
	Y3AHQ3p3OAE2LmLOa3ziu5qLCjjQocNNpJPkJ1ExVCyRY7X2zmXJPOQW9lZ0wXcDVtX3KL
	kFA8r5WyBJDE6tWirUyD01ZQ8TEAvQw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-HA8YY9nSNnG00G5dLiUkJA-1; Thu, 28 May 2026 06:03:09 -0400
X-MC-Unique: HA8YY9nSNnG00G5dLiUkJA-1
X-Mimecast-MFC-AGG-ID: HA8YY9nSNnG00G5dLiUkJA_1779962588
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-45e81291d62so10618538f8f.1
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 03:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779962588; x=1780567388; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=XD2Y8H2SIlgkz7KIkHaw+1uyQ8vGfYmWnYbfWvcYOE0=;
        b=HaessMLDfbewo4+w+KI8V+UPn8aaHut1xvZBqFddbaEhDc2cuMeKRYmRV7ax/zKq8Q
         BOS3HycFPcTrBaB105uxs7b3/Fd4Uz5/B4T+o0F5yugiOa98g0ETvowrlJ9s/dPmyPny
         NNuemJMqcc4kIngFQPNOkt7gqt8R14sEjQstvcyCm7BWNEONzhjwp+Tw97QiqYjUl5t9
         F1jEOqQidBcSjXqszRBrif5OctdjMylxrRmE0AOA649KpaDr9EPSV0tNSa0b0Aw/30T1
         mklpcI70f+SNb73Cd1m32jOy5fqxxirFtJDMDgTB5fEADNTLmeF0bm/E/TXXokbozsg0
         o1RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779962588; x=1780567388;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XD2Y8H2SIlgkz7KIkHaw+1uyQ8vGfYmWnYbfWvcYOE0=;
        b=lJU8x/Ri7WtNHks6YklAh4RN/12exkrm9g7amM/5qKlvqzHJec8TKmteVvu2Q43IUa
         2fb8iFbs598agX9biJF7XVeQtmVSAWo0mKlR3LPL41sx99Y/Fb/BfP3okvabX5SW3P5C
         divsxoCKOZgezcfc/DROADc9jhBP11bZ4ZKuKFoGTgmjQ/S7+Wnmb2lq06lj+0p1jE0a
         4ivkCoM3WfZJi9W7imvBrjBup57VRNjQqyIdi/x2D1Na37E0tpMpLJeCEWyLulx8aMMJ
         JaH8kYrIxlcLctM/TPDFptNpwIxcHnqzVKhmpgDZAWevZm7cbAJqq5Qu6D/aDosY3IwH
         0l2A==
X-Forwarded-Encrypted: i=1; AFNElJ+oFKTjjQuVvdh0f69wgPuwOoPHWRlr132NQaKJa2zenuZ7AjjPiviErZY4j5Zn9jE9xoHgG+Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL8BlTVg39GbXRblgjMAKibOcUmnVpMn+t9LH1D1R9bbPFJfRk
	ysXYgise/1akRy48t5FZ0ethkPGBS5BMYEnknrW+VGBYe9d0JgBj3OCzKOKdRaSvqR1QVRHTvy9
	pDI3xC9Ejy779OsyHBrpAQ/oCkMB6CcoKyWq1DEVO6/B//U5JFJoEX/B3Sg==
X-Gm-Gg: Acq92OFSGnrdnsQB2FU9FEnoMjR1+K2Eh27Gm5KCtDE9c4AHEq/p15Sd2xOhmFeQ+KC
	bDQxt8JTfI+jnBHnkDAeaZvmM2grcqBSdRbDwIwESmV3FIw7ftQ9l7a60z13fcPn3DZXt8g+Mxc
	Xo0+PsRfO/iFBAzoQxn0FaSSwxCDfyrqX8pR3yvwpxpJDDktwtRWPXVZh/yJCxhK1Xyr1zxRs+V
	5ssODMTSsFRpALTG5MOocHPCKuK4VXy5SKjNZ7qw+Mk+/QsEMaFl2oJNjMtsSbGAuqlC/WCnwgr
	gcqS5r9KAmi/XmXHRoGqJDsRh/N9uvjBe4V/IQcA7UcLvtY2QZ4vWXBxA4x6ndh51BFUCXcaFPu
	gkSLmSMhtLk4uwphBgw21jjVBJd7/Gggry//6nqjKvxVc9iaYMofjXsTu9zE=
X-Received: by 2002:a05:6000:260e:b0:45e:a0ab:8bcb with SMTP id ffacd0b85a97d-45eb3696a9fmr42533865f8f.15.1779962587782;
        Thu, 28 May 2026 03:03:07 -0700 (PDT)
X-Received: by 2002:a05:6000:260e:b0:45e:a0ab:8bcb with SMTP id ffacd0b85a97d-45eb3696a9fmr42533809f8f.15.1779962587354;
        Thu, 28 May 2026 03:03:07 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb54959bsm13517220f8f.1.2026.05.28.03.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 03:03:06 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 1F83F7BA478; Thu, 28 May 2026 12:03:04 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us,
 victor@mojatatu.com, david.laight.linux@gmail.com,
 yimingqian591@gmail.com, keenanat2000@gmail.com, 2045gemini@gmail.com,
 rollkingzzc@gmail.com, dcaratti@redhat.com, security@kernel.org,
 linux-kernel@vger.kernel.org, Rajat Gupta <rajat.gupta@oss.qualcomm.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Re: [PATCH net v3 1/1] net/sched: fix pedit partial COW leading to
 page cache corruption
In-Reply-To: <20260527181731.1166373-1-jhs@mojatatu.com>
References: <20260527181731.1166373-1-jhs@mojatatu.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 28 May 2026 12:03:04 +0200
Message-ID: <87ldd33l7r.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,mojatatu.com,gmail.com,vger.kernel.org,oss.qualcomm.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-292642-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[toke@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu.com:email,qualcomm.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: CED705F02BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Jamal Hadi Salim <jhs@mojatatu.com> writes:

> From: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
>
> tcf_pedit_act() computes the COW range for skb_ensure_writable()
> once before the key loop using tcfp_off_max_hint, but the hint does
> not account for the runtime header offset added by typed keys. This
> can leave part of the write region un-COW'd.
>
> Fix by moving skb_ensure_writable() inside the per-key loop where
> the actual write offset is known, and add overflow checking on the
> offset arithmetic. For negative offsets (e.g. Ethernet header edits
> at ingress), use skb_cow() to COW the headroom instead. Guard
> offset_valid() against INT_MIN, where negation is undefined.

So you did tell us not to nitpick, but...

> 2) Add more optimal boundary checks (Toke & David L.)

[..]

> -	if  (offset < 0 && -offset > skb_headroom(skb))
> +	if (offset < 0 && offset < -(int)skb_headroom(skb))

Seems that bit of the changelog isn't actually accurate.

However, I don't think this matters, this version is not actually buggy;
so let's just get this merged, and we can code-golf the offset check on
top :)

I did re-run the tests on this version, and they look fine, so
re-affirming my tags.

-Toke


