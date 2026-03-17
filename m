Return-Path: <netdev+bounces-268612-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPZvEM1euWnYAgIAu9opvQ
	(envelope-from <netdev+bounces-268612-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 15:01:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3382AB569
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 15:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 374CF301CCA4
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 14:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C67F3E1219;
	Tue, 17 Mar 2026 14:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDP2A/Ek"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA083A3E97
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 14:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773756092; cv=none; b=QyzreL5dCgk2m14BOKmxQXlszWdYC2/T4khTPckcBNDlO/hTBShQEdFqxSEipd4nY3w838OvT/G7JHm/18tf2OuuDXeW3pNrTECCChWjlEFso64HTUkMHwxc0fFWSJrvA+TVSYuzotD+LSrYgApC9GR7A6b/MHAxTeYf3KB8Wts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773756092; c=relaxed/simple;
	bh=QNGzhaws/ILgJmwyVqWJT7BY2rbvZFUGhFYWXKg1dmA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=r+qOrNfqFOKyCss/F8l2+RTC+8LA+bf7ON569jbVN3CW7knaBb7HxjpqDHLZbZDymwnEPLRMZNsLi6gNSNX/g3S3yXiGV+ljH3OMeB90HrAjC2uvYSTxmWlnLT10JHN0izmM9Ag4AkRlSVEw+dWgoXljBwP5iQe4afpCGvvUQ9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TDP2A/Ek; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-79a3ba1653fso22375787b3.3
        for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 07:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773756090; x=1774360890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9T+kHlqZbPOUk2QRRSgAwGxeEJRArRfLuYjXKmhB30w=;
        b=TDP2A/Eki2fRNnAMltAlHKxXa46RYiCFrjcfkITUE4ZwJvdw+dDruJ2DLoByaRxGN5
         P8SMtjD6D8d/eZYpxeeK69qNy6o5CSB4x6QSARlbotFgiM51MsystVyA13RtqtD6v5Ur
         dXeyuFMabNwkZI1AbAf9QDNEL/iAYwmJb8wYd8GFLIOPH5kCdo7pJsgoTAigLTBarJEx
         hMcnc9xzydLGHaWKnZDsUfg6+rcHx5Af1+qH1aL9LK1wDZz70UBK4NQr7OEXn6PYGMFP
         5RcmRTGA64mlswcjpD5dN4M/6MrEMz/MdoILMP2wjTVRQYxcGIHogVpOzR6rcDf5yrc3
         tmjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773756090; x=1774360890;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9T+kHlqZbPOUk2QRRSgAwGxeEJRArRfLuYjXKmhB30w=;
        b=dK6kP6OfckswWwMaVau09K2yH3wYZHOzn75L2M3m4f63yA1pQ9eYJ0SDEuqzBIfeIx
         gClJkAL7dl4Jztu9JnxDMlEZ4C6qPor3A+tpy/8tC6dl2DEaW9XJ7uXRNf6CnkJ2+Us3
         Y9wtNbOEOmEjWyjDnRJUsqvwAdigwOm+gOqtT/gcflPn9r/boNfol9nw1cnFh2BGYaad
         AgA6OTUSxhpbVfbL4ymWUUFMqv/cKN6XnmkYEvFfMeTp07FV3UkEyH0rFetUr3+0blba
         4CkoILoV6shS525JgYswkCXkzYvY9L64QnWv96iddJlMYexK6cH69SZxkxQWGychewi7
         7ZuA==
X-Forwarded-Encrypted: i=1; AJvYcCXU3gIfPT+wt1OsB7cEuHhUE46Xer5co2MD3H8KktlKyTvjsEjEVezRqIOtn5SxqhTALRX4yjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGpzBgwyIESv4voI1bizJdDg5YW/ppi+iOSFiQFkq8sU3XuzGM
	OzmlbyfeMwCl2n/vhs2aCz8eKyHjGr6Z/RDrua1GVUE5ppgQERyqPwqY
X-Gm-Gg: ATEYQzzNHC0ZQZuYYBjYbfaXSyIWyaqJRe/pzmVC3chZWQS9DNBD5jUZTpNNnCaHxpk
	8dYk4POzoH6NsPigZE9YB9+TH/wcpGhJ19VpencOiE6Yhh70e7kfasrXYZy+UwT3+j+XhmgxeE9
	QLoD7sBALeJsMgd/KRki9Vetqk0WL9vHa1d7GpYI7YnvxRSQM7sF08D++b8DrX+PmHXnAxJW1Gq
	f1bIsnEqFNxVFTc5tuDSy8NId7LeMBPiSafUQaMMo2yySoQ2J7ojoQkRZQ4op5Zqi2bDC+5uaJQ
	BjmnDc8a1GI+wkd8H9jZSAhZfcO31fHn5n1Gslwj0AmevvojDawG7LoMTe37WXQOZ+EdpYUj4PH
	stQWuEzetgQBC3JexkmWO/X/URe4Ypr9Z8azzLNABbmJCfJghZVlKzU0UwS1xw6lu5M5xlYIBo4
	Wrh0Lxvcp2UKrj7Uh4dhLj171ElMDsU80M+nVmAHh8hz8o/EPnMdB5UQFqedQzEd9KOX6xgIZfb
	JI7
X-Received: by 2002:a05:690c:38b:b0:79a:46eb:d1c9 with SMTP id 00721157ae682-79a46ebe0e3mr81263797b3.0.1773756089988;
        Tue, 17 Mar 2026 07:01:29 -0700 (PDT)
Received: from gmail.com (180.134.85.34.bc.googleusercontent.com. [34.85.134.180])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-79a2de73263sm58179747b3.43.2026.03.17.07.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 07:01:29 -0700 (PDT)
Date: Tue, 17 Mar 2026 10:01:28 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Hudson, Nick" <nhudson@akamai.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
 "Tottenham, Max" <mtottenh@akamai.com>, 
 "Glasgall, Anna" <aglasgal@akamai.com>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-ID: <willemdebruijn.kernel.1101cf7573cc9@gmail.com>
In-Reply-To: <39BDB245-4486-4487-9985-0D4FDBCB382B@akamai.com>
References: <20260317121429.2399539-1-nhudson@akamai.com>
 <20260317121429.2399539-4-nhudson@akamai.com>
 <willemdebruijn.kernel.3102df56d5f64@gmail.com>
 <39BDB245-4486-4487-9985-0D4FDBCB382B@akamai.com>
Subject: Re: [PATCH v1 3/5] bpf: add helper masks for ADJ_ROOM decap flags
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-268612-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[akamai.com,gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.7.a.0.0.1.0.0.e.9.0.c.3.0.0.6.2.asn6.rspamd.com:query timed out];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RBL_SEM_IPV6_FAIL(0.00)[2600:3c09:e001:a7::12fc:5321:query timed out];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[akamai.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1D3382AB569
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hudson, Nick wrote:
> =

> =

> > On 17 Mar 2026, at 13:27, Willem de Bruijn <willemdebruijn.kernel@gma=
il.com> wrote:
> > =

> > !-------------------------------------------------------------------|=

> >  This Message Is From an External Sender
> >  This message came from outside your organization.
> > |-------------------------------------------------------------------!=

> > =

> > Nick Hudson wrote:
> >> Introduce helper masks for bpf_skb_adjust_room() decapsulation flags=

> >> to simplify validation and keep flag handling readable:
> >> =

> >> - BPF_F_ADJ_ROOM_DECAP_L4_MASK
> >> - BPF_F_ADJ_ROOM_DECAP_IPXIP_MASK
> >> - BPF_F_ADJ_ROOM_ENCAP_MASK
> >> - BPF_F_ADJ_ROOM_DECAP_MASK
> >> =

> >> Also fold these masks into BPF_F_ADJ_ROOM_MASK and per-path flag
> >> validation checks.
> >> =

> >> This is a refactoring/plumbing change; functional decapsulation and
> >> GSO behavior updates are handled in later patches.
> >> =

> >> Co-developed-by: Max Tottenham <mtottenh@akamai.com>
> >> Signed-off-by: Max Tottenham <mtottenh@akamai.com>
> >> Co-developed-by: Anna Glasgall <aglasgal@akamai.com>
> >> Signed-off-by: Anna Glasgall <aglasgal@akamai.com>
> >> Signed-off-by: Nick Hudson <nhudson@akamai.com>
> > =

> > Only patches 3 through 5 were sent to the netdev list.
> =

> oops.
> =

> > =

> > Please resubmit the entire series (after the customary 24 hr min) to
> > the full list.
> =

> Will do=E2=80=A6 as v2 with patch re-order you mentioned?
 =

Yes



