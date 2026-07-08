Return-Path: <netdev+bounces-305642-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BUQhJXLVTWpf+wEAu9opvQ
	(envelope-from <netdev+bounces-305642-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 06:43:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE99F721A14
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 06:43:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=LBniLzzD;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305642-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305642-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FC633019045
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 04:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A086F3AE19B;
	Wed,  8 Jul 2026 04:43:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm2-f2.google.com (mail-wm2-f2.google.com [74.125.225.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A60360EE4
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 04:43:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783485799; cv=none; b=nIn/HlIUi6RbdErzfZRjW4qHIz4PejR+rNKcCUYMJBafF3QQXoWHlbxsV8Xr+w/v1tJ+djkiX5DK09Q/+cm7DCqb741v0MbPsX+1/KXnGlcRb5rio3ByuK6EiBM04ZCBUh7A2OiQjK6bMgwFe0XSgbuAmUFHrynu9MY9ME9GnHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783485799; c=relaxed/simple;
	bh=FAoptCMB2sR5zqcHYSt82rCp/yEQWpVdGexkr86eBYQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Eua+AGT0yvM9vzBSBQ5lCJ0OTPF0jeeCC3O3eRZOfoJuZtlckLiULbK5JNPfqMhGGcTp/pwWfoayGKHpj8MfNAt/zQmpdOYjlTNSTHnrKkWzlZGDErwP+zYmf1ewYpNuZ2UirDUuqwMiQR3RyeOZkZYf+fFKUybYv6h/5cauwCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LBniLzzD; arc=none smtp.client-ip=74.125.225.130
Received: by mail-wm2-f2.google.com with SMTP id 5b1f17b1804b1-493b567a019so1523125e9.1
        for <netdev@vger.kernel.org>; Tue, 07 Jul 2026 21:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783485796; x=1784090596; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FAoptCMB2sR5zqcHYSt82rCp/yEQWpVdGexkr86eBYQ=;
        b=LBniLzzDF8R1Mu7A5VE9jTEzkiRIhCUyrX3TbdeWmA2VwinaInalmdB0sTsR+2XZP0
         5Ac2twMDJhT7Gi1YZ9wzM1oGl+jbbbx3vMsn64/xwx/nC7bjZZ6KKBxhNUGDxs3VcVze
         AuY9HJfA/FnuG7ZDsaY+XAlJUdC7bhcxUc/Lqztbb/bc6jbArOOeGEWxczsuN4P7xskP
         wPovmAzyP2MHOMVZ6pNOY5fh62GVLCR+44/VrihAgrkrDbNEP2Us8cdcSwH8O6ItHC8O
         p6lKMQqD02LGAJs6C5/sfhHvQoZ8kf0RgxOtLvDxXtIRG+CkedCj20zTWXP94eYAYjI8
         YalQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783485796; x=1784090596;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FAoptCMB2sR5zqcHYSt82rCp/yEQWpVdGexkr86eBYQ=;
        b=cC7kmjyJ4UHhDgnEeMoI5AJGQhLk0l1tXyz9JtFVTiM7+Q+VgfT5LOrr475akpKSXy
         y6oQEnXU8wfb/DoxSN9WAOzZ9VT1fmkNaNgG/UMalkEAgbP7UZgfzD+2/owr5VN6lZRy
         lOyH4X/Sdz2RvQIr1t8RPVgy+QswOUJ/NH/ICWGds5E2mc4OW7NYDyjcv28YzOb2fbWN
         drPda7XljUpCIsMIxu00VrCIQWDhmWlfBp6G/kSYirrJVYOjnCF2Se651rw1wd2Ysf5s
         BBfR4APiSPL0+8AYHFFAbM3/QxnhwtBCXngiHBuxCRGryyPOrJEhBwnPnDMrT2+qB2g/
         ELdQ==
X-Gm-Message-State: AOJu0YxiL/5voPjBN/mbR/+joeuPOqtd+RXrc7ImkJkLoUNm2dKLQw4E
	u11VqQvK84mhzBtNkO3ssllKrMF+tCcMmhKImRttWwg10OSEb60OkdFR
X-Gm-Gg: AfdE7cmYcXfF1O2O2XCd3HZc0S1mWb8TcdqGXWXciSqKTPUzdUDZ/t5DonOB23acwDI
	8Dikdoy6noxfLv1KRuvvqwvvek69oDQ9MeEFxz/HOWyUIbfXTeWXw13EeWuax7NMVj8ymhwRP0r
	5hOFG+P1y1IiUI4FXOutFgp5luBtpqcALbZY3C4bVClYWw78dDuGvjC6Xx/sscwL8A9xWbF+NVq
	Ci/RGC9c7eOercWxjnLAEz63JMtKg+Qz8DGy92nEgo0PZxNU+hBn7Ds1JLTHw3CDOl1T+ZQq0Ko
	tBMdK34uemrXun7T+b2m+za8DD8Zm6KNU6+XJQHrVM+F9iqafuQnTkBazuYlIn9lnDps+ttSJ15
	1QFlbD5E9U995yCLTechf/AvbmPbYKEnanh8R9TDq0jdToVlI5HO/IIiyggQ3bHk/QidOuXUti+
	IcsO4N71T5sWKcr2lwIyCaTThodJZZYh+ITvs4Epv63OLs3dxdgUE+5o0iJQxXU9PdjpQ+PZd8w
	hhPZLUvEgvOuWKRqkYOl4bvOWIkTkiulc2Fd8NJt5esGJ5osWXxNvpK7FaECsJ2dg==
X-Received: by 2002:a05:600c:4fd4:b0:493:c0c1:3930 with SMTP id 5b1f17b1804b1-493e6898af0mr6142695e9.1.1783485796334;
        Tue, 07 Jul 2026 21:43:16 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0f5ca1fsm116627765e9.15.2026.07.07.21.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 21:43:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 Jul 2026 06:43:15 +0200
Message-Id: <DJSWY7PQZK30.UZVS6AUU453U@gmail.com>
Cc: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf] bpf, sockmap: Account for receive queue in FIONREAD
 without a verdict program
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: <mattia.meleleo@coralogix.com>, "John Fastabend"
 <john.fastabend@gmail.com>, "Jakub Sitnicki" <jakub@cloudflare.com>,
 "Jiayuan Chen" <jiayuan.chen@linux.dev>
X-Mailer: aerc 0.21.0
References: <20260707-fionread-no-verdict-v1-1-ce94a72357ec@coralogix.com>
In-Reply-To: <20260707-fionread-no-verdict-v1-1-ce94a72357ec@coralogix.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305642-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:mattia.meleleo@coralogix.com,m:john.fastabend@gmail.com,m:jakub@cloudflare.com,m:jiayuan.chen@linux.dev,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[memxor@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[coralogix.com,gmail.com,cloudflare.com,linux.dev];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[memxor@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,coralogix.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DE99F721A14

On Tue Jul 7, 2026 at 6:15 PM CEST, Mattia Meleleo via B4 Relay wrote:
> From: Mattia Meleleo <mattia.meleleo@coralogix.com>
>
> tcp_bpf_ioctl() answers SIOCINQ from psock->msg_tot_len, which only
> counts bytes in ingress_msg. Without a stream/skb verdict program
> nothing is diverted there: data stays in sk_receive_queue, so FIONREAD
> returns 0 even though read() returns data.
>
> Add tcp_inq() to the reported value when the psock has no verdict
> program. The two queues are disjoint, so bytes redirected into
> ingress_msg from other sockets stay correctly accounted through
> msg_tot_len.
>
> Add a selftest covering FIONREAD without a verdict program.
>
> Fixes: 929e30f93125 ("bpf, sockmap: Fix FIONREAD for sockmap")
> Signed-off-by: Mattia Meleleo <mattia.meleleo@coralogix.com>
> ---

Please respin with the fix and selftest as separate patches, but still targ=
eting
bpf tree. You can add the Reviewed-by: tags to both.

pw-bot: cr

> [...]

