Return-Path: <netdev+bounces-274565-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFvDOI55zmmMnwYAu9opvQ
	(envelope-from <netdev+bounces-274565-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 16:13:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DE31538A4E3
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 16:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AD56B303C116
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 13:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744603E9281;
	Thu,  2 Apr 2026 13:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YZnrXn/u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480233A0B0B
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 13:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775138319; cv=pass; b=H1hV9oEQa7R5zdt+OaTj89ZxnPBRfOVN+HEjrco1oWGjTRYo2zdAYDhxFpYT7BnDHvgf4avCI5RZIngFLlVTV/GkR3K+8sa06O72s0RpfEJc8v/prpxUSjxnbMvJK0D6kUBn0x1PmCX7ICztTYTnkeAAbyz+Tvv2JLcCZVNT1Uo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775138319; c=relaxed/simple;
	bh=VU0AbFtlLFJSKOUB5IbB1iaCG7SEJEo5AKtWU3UUzNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nm2RN7zhP+52mhLQq1kuR2R32aFRRMFqJnIleJ6uwUcJiJtUaSs9Jl5s+dbC7xmNwsoT/h5BH6Qja2AZXcSOCDobuG52GckHC7q1lPiGGI/8gzSJ8cwXzqQObc9A7f5j6edf4I4dewnACRq9k7miV0j/CWTVqX+iiGgV7LtQfGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YZnrXn/u; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43d01d6b50cso801720f8f.1
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 06:58:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775138314; cv=none;
        d=google.com; s=arc-20240605;
        b=iZs6Q40xS9+pJdok/apgOLTKTeUP4oMg6zbThwUN9iVOSxL56tz2ztltXVE0SGCf/3
         33aK/3sKagypvp90pXM5PEAweWfSfXtgvtXyK8FF1X6ziVy0qNoiNOhZIFeLUGKxozsB
         tjF42ZKUeL1eAuerpxVrSOH3/VEHIKv54ael0lOyrzJ+yOD5ybWEwtER86GZSdy8QL3B
         H0opUvD6K9INsOoJ0q79WJhSwpB2b99qs35TwKxD/93MZBzIhwUV1eqIOkyPFI/CRBP/
         rRwPTElH58nAK6l1V3DSHNRP+YmrWw2WxYI7AwLSZFLJGjP2E5yv38nu6faHk9BHr+oI
         6/PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=VU0AbFtlLFJSKOUB5IbB1iaCG7SEJEo5AKtWU3UUzNE=;
        fh=5oPE0GCY8fNT4Tyl1J15Ht/fkVoH08XUWqCwvgG94CQ=;
        b=bRC+pGOsSAMS1WKo0OUfRePbzZlsPrCM2vFjNZqbM98bWXFFVfyV7ePnesm95S22zt
         iDna22OF2dPIzctQv5x2tW90eR20HXh3ytf6nSChqts1CDDhDYTPbd0Wki3QkkfyQxP3
         YLupphR+Rjf8AtAjUp2h+Wlpk7SqFQbfUEcIQC5rnXjVNd44Bdx3XbJH4EMqOOcOIu5w
         bn/dDrvh8lQBWmqSKdyQUz72ZJRzcZmSM8tthYzIgX8n8HVI45Q6FNeA0YND97+oRnNy
         PAH9eFCoamSoDPIcjF2vaeIS/o+GYR4zb2z0ybC2tYxCHdCAmdUvLOs6aFHUsvLiiIN2
         0oKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775138314; x=1775743114; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VU0AbFtlLFJSKOUB5IbB1iaCG7SEJEo5AKtWU3UUzNE=;
        b=YZnrXn/uX7S4av5pNnuujvcI08mYLP/l5fhpqXLgfQQM8fhcA43BSYVurFvL5nJPAe
         v53/7ZFdUyKBaOe1zPAqgGzonr63be8UJ2nm+uJScWqm6jcYV72ohpmErcX66SoO5/dI
         vLRsr35LgQfJ2wluOTAHS51NfwPzYYA/BY2YjXT+RITLiBKUzm72hrKpzW/kCkbUfoAB
         Wsmdrr2LP8Yi2B8Ew6xVh7dqM746azCJfTbvrOiA7X646G9NBbGfKyzcje6SQAimNaYm
         lIilxLAaBeJViByhms732p1Tdp6LqvYaOmV5JSRCDqG3tj/wlIhJdqMsgIDUfWGbfSk6
         0EPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775138314; x=1775743114;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VU0AbFtlLFJSKOUB5IbB1iaCG7SEJEo5AKtWU3UUzNE=;
        b=b9yYtD6UmRMIKYsiEXP+xtzYm+klF6M+rx/mQDVIrtkzWbx7a9fVoTtMJvR6KbVwAx
         I6CUcPzk6nXK2/nQEhCvMCZJwT5l+Uo7NjJr2OsCs9F6O6q8aAoMV9KNPDDCtM4VKuIS
         D+xjc/Nc6gHDlvDIQw5l8s0sZ4U2QMcTl3ng7jqldisXTu3snQsO6+wXrHZ2uFXeyOyC
         oSe3wHtk1mPmCXjMziZpj6NQh9WfqX6SsYaQap6wRmvffZ1oTYgzKjHrT94TDC15T9El
         k0TOON3rovckz3X2NhqqsqI6NYGYok3bLBCzUv8pmF9gLUEOUcEkd+y0/ttrqDejaUuN
         tXxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVu2OwzizdRGfEgekfBo4wlrqO5dB7M9eYK2o7lC/fWKTB4WM7A5wZ/frFyjxF1o36ZhR7lsU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7GFXIFD07Lax3AZdjc0tTJiltGVP4m6CY1UprabWCGATs6RZh
	L3cfQ1VWZSZimEj2L741IIdZXwvSva0bn94Vk4E8YSkO1/y+4JkTYavFVdfo7R4Pm9An3PEEYvJ
	rpJjCKu3uD+K1yT+SvN3J4tQI6Tz7v3W6J7fmAU3e6w==
X-Gm-Gg: AeBDieuCwCFrj5EN8fvnVQ0f71PeQ9iOQvhlxLOSD8LK4fcPODWB/6vnp/BzGZMLFiY
	sLGFhGFuuzVP2YgOZv+3oRnESOD0Eh8AYzdsIQ4RP0fPtyWajIS31NvQuvQY64iOf0aH1q2y1Ii
	Kyuej8izbpDB0HCQRiO7CG1zdHkX2dzaRvGcbkvC3HGymnsBcfSAArsiZrc1UuZHnwqxvsG06/e
	OIDWkdm9RbuSRu12gI8/5GXRB6fwN0oYH2CGplEBXMgA4v1kOYX5LAmxirBpCkKIMLsdKXpPJ9F
	DD8V/bnzQOWEPdjMMZUoI3Re2Pk5AMxoCu2dR+CLfxzRNmJVxTjAEbx651Ax74UnxsLjsFbBMxe
	DTKZS
X-Received: by 2002:a05:6000:2010:b0:43c:ffee:ee95 with SMTP id
 ffacd0b85a97d-43d1505649emr15414743f8f.16.1775138314295; Thu, 02 Apr 2026
 06:58:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226172927.2Ck9wZMw@linutronix.de> <20260318103009.2120920-1-neelx@suse.com>
 <20260318111849._MMol8Hr@linutronix.de> <CAPjX3FcRYNkYK2gerbRL4C9wXZPxWSs6=oTjzv5+msm4PQrfqA@mail.gmail.com>
 <20260318145101._iaDDpbE@linutronix.de> <CAPjX3FePCKQTaxB6zuo+_V09PZct=utw3vgJUTM_GrZQtv7_TA@mail.gmail.com>
 <20260402070319.vhRd6c-f@linutronix.de> <CAPjX3Ffz22M_ADE1xPqHOCyni1wLwc+reLTVyOrJ+gqNYY6vwg@mail.gmail.com>
 <20260402083123.1H4kyAEn@linutronix.de> <CAPjX3Ff8Zv2EArKaCSKFAAFfBCCVu0YgqHk3SV85BBPm6-D7HQ@mail.gmail.com>
 <20260402134633.bRxz1V8a@linutronix.de>
In-Reply-To: <20260402134633.bRxz1V8a@linutronix.de>
From: Daniel Vacek <neelx@suse.com>
Date: Thu, 2 Apr 2026 15:58:22 +0200
X-Gm-Features: AQROBzCJXTJV8hcjctLKcmZ2hBR3GmC6EUKHtExZ92lQyFZHUvwnLJh4BAs_1v4
Message-ID: <CAPjX3FebJxdSMJV9Qs=3BtgL4mT7q55C6Te9c3OqpUhR5C+Ekg@mail.gmail.com>
Subject: Re: "Dead loop on virtual device" error without softirq-BKL on PREEMPT_RT
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, netdev@vger.kernel.org, spasswolf@web.de, 
	tglx@linutronix.de, Aaron Tomlin <atomlin@atomlin.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,kernel.org,vger.kernel.org,lists.linux.dev,web.de,linutronix.de,atomlin.com];
	TAGGED_FROM(0.00)[bounces-274565-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[neelx@suse.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,suse.com:dkim,linutronix.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DE31538A4E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 2 Apr 2026 at 15:46, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> On 2026-04-02 11:21:20 [+0200], Daniel Vacek wrote:
> >
> > Well, that's the patch I originally sent then.
> >
> > https://lore.kernel.org/linux-rt-devel/20260318103009.2120920-1-neelx@suse.com/
>
> That was an alternative after everything was already done.

That is true. I don't mean to complain. But also because I haven't
seen the applied version on the mailing list. That's why I originally
sent my patch as a reply to this thread.

I'm simply asking whether we should proceed with the discussed
approach? Would that be better in the end?

If you don't object, I can send a rebased version along with a
follow-up cleanup.

--nX

> > --nX
>
> Sebastian

