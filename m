Return-Path: <netdev+bounces-274414-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMTEFiEgzmnElAYAu9opvQ
	(envelope-from <netdev+bounces-274414-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 09:52:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B1938572B
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 09:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 026C6307F3A9
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 07:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10B03876B7;
	Thu,  2 Apr 2026 07:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="P3ZOdSWd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B40333EB01
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 07:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775116249; cv=pass; b=W7PkmdJJGUG3nrEs9R1BbiIgfNrXHngKRBPgqeQz1Kg0+Va3OvvMEmzemFfSqnL2hnXyw0BpLwf+0HQnDX1FdgN0qgcIh5IZPHWF6uiSJP+eku10ZCf6eHMvaGvohkAaTEZpT76REdz1ZbCPbQ9s2qv7F7KYhiOj2gHAO4CCo5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775116249; c=relaxed/simple;
	bh=TH8sG4ZFTd40xrtO8my09gy9jHZzt6ZP6hpQ8AsXtvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N5K3yCgwlyD0+ZTjYGEojr4vM7JAt9ixKsbLsQwYg+6kflupS/cvPLjUVOLj4J3EJKM///M7NkQJyXWvXwqNac+3pyNm+PhfeP2H4I4Uzvy4etkcWYBr0bu53DDB3geQL0m2ZeiCK6iznTV/J830q9R85rZxDbh2MIcT8v6eiI4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=P3ZOdSWd; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43cf8fe9c2aso295612f8f.2
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 00:50:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775116247; cv=none;
        d=google.com; s=arc-20240605;
        b=HHLGS2FMJb6/dKO0lRlJm/2U4nULsPq7bxxtxYGNuhZ4MvJZJ85QxA/iMc+XkIPQpo
         FdG++nAEK+50p4F2JlkqzXgoyel2z0SAgxbKk5p+gK6SSQNsnJvpDalnAVccQhdAhybp
         tLpzxT4l7LCwfg1lYykqAdhGunsG3Rx7iVPeT9oSMx/DSvKxhl9mnqgoQyY3l8KSOh0U
         qsAwz/b8mneGm4ydIlqa4+8uYZsySg+negs3A6/jTL9AUHHVa/YUaKyc1bMaMIai3Fjt
         YtFfk9AT1lS26TKzgezblXpfPFt/5bv7zA+fe7Qy30jcqN7BiCka24xpdncObNon3F6v
         X8eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=TH8sG4ZFTd40xrtO8my09gy9jHZzt6ZP6hpQ8AsXtvo=;
        fh=hVH/Q8bfQ/19Tf1T+BFYzA5VoEQenUKbAfCvMpu77I4=;
        b=IjZcgXsYg+oJsR5bifdL4yxOtypBDHhpGXAhIUlkL/BJZfn7i7Mw/fW9cj2AtirIPw
         Fcaj6Y1Z5aLyZiYkzb0oseM6YZw0Yf1hzxMpo+AGGC6ZZ8qcBxFUbmm5tHw7oGCUrXzH
         evNvCbOoTHhA3g/KtdgmjEy3OWYvG7mzPcBlJflzAtM1sDwBwsMPnunhkRO4PWSYBxe/
         jAoTOAPU0I6bHHMfEdRMqnGi6bgMVkJDCbjVyl15mPKKPsCfnpJDWtyrvlX/jbYk0ndo
         nEryhkTMzEZwwZQWzwHwKJ9ilOOH6ku9sgl22KKCotzJB/TBuogFI/rs2FtcLUhUMokd
         KB5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775116247; x=1775721047; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TH8sG4ZFTd40xrtO8my09gy9jHZzt6ZP6hpQ8AsXtvo=;
        b=P3ZOdSWdaQv44D940sYB0QYONGevmr94Q8x/sLPq0JhiVl6zfjkUI46GqvT0T7z4xr
         KAXZ12A5ttsmqLX2en9ZVNAdurbyyNJrjavlrYdSpKv27J+6xWenNGQv4Sn+hjFIIguS
         HImudMnCt5/C8EgKgeIo0YBkCFGt3bG8dGrqF7sbX1aWGm+VMTK6aPP1hSJYlEbMyY/F
         ue7krxuTv5xjLa49E6C9KjEvfeqm1QPSA3+gRV7q1u2YZTSvphNwvEY3Zs2kdhLayLKt
         Tfk+j1lC/LEBpztU54Kqp4Cg8ETIUA7WcKnVYhPI82eed5266L80myYd7LF4h68jaV1G
         LURA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775116247; x=1775721047;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TH8sG4ZFTd40xrtO8my09gy9jHZzt6ZP6hpQ8AsXtvo=;
        b=nlx6EP16/mLMV2gUwHH7K3z8bPiLP3TlpxMePW25pVRmXS7lhaOCN++PbJeidWvf/t
         gvk9W8H4tAaDB/BKNXpz4xli+qCnW+O8zaNDnfCRuJ656JrtwdTlb2HeOUpDB4jlaXtM
         AyXFjzcJZhomBGQu1kgyN7m7bGeLBkIEkbZOJAV2w6MyB5lMseQVz0MZeHBdfjh0CSUN
         Dgy5pTjMpUfEzhS0Lv1cie26z20GeD/WKM/tcr77T/1km7WZJTpiyEvgRYPE/Xb7s/rV
         js8YPfodq99ZwZCzK65I01V7/F5apw8eoi0dYNjW0tGCiHGjU1yjm6QLId0JoswKuvo4
         nGig==
X-Forwarded-Encrypted: i=1; AJvYcCX/NAWJsCmL/zaRq0b1zfJc7Vv/S2e9eIoS4Rx/OveOnhAY+N0sBMhrVdsiDmzT5MHSyEMAN80=@vger.kernel.org
X-Gm-Message-State: AOJu0YztrsB8FZf4AiePU4JXc4vdwYyneppvy/1mizyN8oqH03pH3QoY
	w5gTzw+qVsqC1aLNY1gwL0w8nNY2D6I4tVSUkj1/fqFcVDfVLDx9NbY4w1SgLqjCxJkPkZ1xln3
	GU8/i9FPT0TAhrL+AfUfZ4Egpj+8l43dej9BbuVG+2Q==
X-Gm-Gg: ATEYQzw5MrCIXPlLdZhPWinNrH4FKxKjS2Q9BvDKWPVp5ekWXegFQpDjdSPKnHJMdzl
	+RoU6PyhgwWjdI58U9ItWH/MtYiI5mdKlmK5Aw0Hh0OjR6XTGi2nDhwA07/t6COZoPXq9BodUUd
	tSjKisIDYWRQUpL6Qt7HU0Tiav1QlWsTDmjYjtWbtMUdqaSJMi0KsaZXerhQdtVc/WxJiXCTWRU
	TpVa+V+i2n1OnfWmk8hEochJxgTPbnaAWVxIV9395b+n0TSfwITbNToLKRQJCZ3NjTFQiQ+hhnN
	E5KTvk/W4qXWlJbLHVL2SBXY5oFI3WZqrysjG9fDyzsdCV7kK2H77Y60rjqJTOphfiqbffVWbPZ
	V1Dk3
X-Received: by 2002:a05:6000:2c03:b0:43b:4136:1e6f with SMTP id
 ffacd0b85a97d-43d150d3fa7mr11490151f8f.38.1775116246685; Thu, 02 Apr 2026
 00:50:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2369ba83d204290dcfe157aed3f943206213b979.camel@web.de>
 <aa02f39ec4640c9d98963f42121b76e59b58371d.camel@web.de> <20260218073036.AlkNRoAP@linutronix.de>
 <ae213d2b908e46d34856be9daec891d7210f46f7.camel@web.de> <20260226172927.2Ck9wZMw@linutronix.de>
 <20260318103009.2120920-1-neelx@suse.com> <20260318111849._MMol8Hr@linutronix.de>
 <CAPjX3FcRYNkYK2gerbRL4C9wXZPxWSs6=oTjzv5+msm4PQrfqA@mail.gmail.com>
 <20260318145101._iaDDpbE@linutronix.de> <CAPjX3FePCKQTaxB6zuo+_V09PZct=utw3vgJUTM_GrZQtv7_TA@mail.gmail.com>
 <20260402070319.vhRd6c-f@linutronix.de>
In-Reply-To: <20260402070319.vhRd6c-f@linutronix.de>
From: Daniel Vacek <neelx@suse.com>
Date: Thu, 2 Apr 2026 09:50:35 +0200
X-Gm-Features: AQROBzDZUqa_BzGKAluV-XM-Nj1B7MyqvSkoxQA3m3h3_5JZUXOc70CroRCVmQ8
Message-ID: <CAPjX3Ffz22M_ADE1xPqHOCyni1wLwc+reLTVyOrJ+gqNYY6vwg@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,kernel.org,vger.kernel.org,lists.linux.dev,web.de,linutronix.de,atomlin.com];
	TAGGED_FROM(0.00)[bounces-274414-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:dkim,mail.gmail.com:mid]
X-Rspamd-Queue-Id: C4B1938572B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 2 Apr 2026 at 09:03, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> On 2026-04-01 18:55:43 [+0200], Daniel Vacek wrote:
> > > > > The above was me thinking and does not even compile for !RT. Commit
> > > > > b824c3e16c190 ("net: Provide a PREEMPT_RT specific check for
> > > > > netdev_queue::_xmit_lock") is what was merged in the end.
> >
> > Thinking about it again, wouldn't it be better to have one generic
> > solution rather then special-casing for PREEMPT_RT vs. !PREEMPT_RT?
>
> PREEMPT_RT and !PREEMPT_RT is fundamentally different here. The one is
> not preemptible and records the CPU of the lock owner to detect a
> recursive deadlock.
> The other is preemptible, uses a different locking type/ class which
> records the lock owner which can be utilised for this purpose.

I understand that (or at least I think I do).
My idea was that the non-preemptible one can record `current` task
instead of the CPU to detect the deadlock. And that would also work
for the preemptible case (it would actually match the lock owner
approach as you did for the PREEMPT_RT case).
One code for both configurations, no special-casing. I'd argue that's
a better result. Am I missing something?

The size of the netdev_queue structure would grow by 8 bytes for !RT
case, but that's not a big deal, IMO. For RT case it would just fill
the hole.

--nX


> A generic thing would be to remove this and rely on lockdep. This could
> work if it is only a devel thing and never "I setup something and make a
> loop" sort of thing.
>
> > --nX
>
> Sebastian

