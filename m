Return-Path: <netdev+bounces-280161-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHMnHrmN52m89wEAu9opvQ
	(envelope-from <netdev+bounces-280161-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 16:46:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2807343C444
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 16:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3F2C630362C3
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 14:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCADA3D9029;
	Tue, 21 Apr 2026 14:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKX9rm7E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710283B6379
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 14:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776782646; cv=none; b=iUs46/xMnh84PDsH80g79zXIXwHZKiAeMIYikohXDBhX1gC1HmPS43O9sh4IeAz9O4akIQWDLJAJMpsji0WxSG486fHh/rbpVs1LsASIHj/qzAqdYlimtZwd29o9Y8vFkXUNXt01/nI0EkrXDhnJIDRe/z5cFEsAJXa2BJjNR4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776782646; c=relaxed/simple;
	bh=3Eq+F8XSry8xQEbea4+lGZrP1Td8wfV+hyTcMXkTbmg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=U7ysrCp6YwrIG8fXR++tEcc1ieP20O/veJkHq3otlvnlA2Ng4fmEJ5q2sHWGYbJTnEJyaC39CIP9oe6lruu+sm8xevA2ZbE4MuqvCs0HlK7OqMMfzwEsVccKfjfCeMFW8DaqfaQuYGfl3EdV5aDCQ3Q4fhArzVDkDhHhEpBRIX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VKX9rm7E; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7dcdca9aa0bso383214a34.0
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 07:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776782644; x=1777387444; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wTO2z2lC1hKQZZZplCzqHXyc5pEkF50MtyRflIcZLWg=;
        b=VKX9rm7EBaSPRTnyaapswHkcfKqwYfK/cunxJMRlyWiS0HtPuORs/3gpWEFrziIOZO
         khNWyVJPdWmhngwR7lqiEMKMu13ZjnnNoqC1ldV0NhEEbtEYTzKXISwNMcpMFVZe0szI
         GYxE0t9jCv4gnN23rRaIlvi9oZP7nIBU4qfcODaXJacgYvKeDKkVZnQtw/PaButKK8dN
         zWwn5/5cplsBAyqU3pMSsjsetGjNzycmyw5PEFhh++CoLJEl3KTE28VgLWrFtOsl5zk4
         x+zbJ0uZqJnqvq9fNLbt8RUdeA6BZ0lPrYulIKrlMq18kL+MrPQr34MvRoKKdjryTpJm
         1k0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776782644; x=1777387444;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wTO2z2lC1hKQZZZplCzqHXyc5pEkF50MtyRflIcZLWg=;
        b=dommmTpGShrqUyN+oh9ZcK1kgHVt9D3MYENVgkM9SwkCIsRi3o+BtCMCsfTMBO6zwc
         q0pmiwtZH3oP66KXXc8HvzXrdodowtkH/CxdhYNuoy5bp2Tx7AZVMhGqggbnxLiwqGar
         kAOYFsulNEYi1cubf7zF8xCvk+WYPmX060kLSxZv4+SvNaRd+GBd9EM8YV16hJ/ETJXc
         kpIco/lcw6EExfi/epuufHeUiV5pGYdVxC0JQGyatcqux/gVbAj8iN3lpnplKolyB3f7
         taobZQLvbqQL4RyUZWApizznScdAmipSjVQG1s/x1scmN5b2CE78AJAkBHV+W9YhBBN3
         6t3g==
X-Forwarded-Encrypted: i=1; AFNElJ8WsmCWvXLplID97v/Uqgnge8fQedqFSDW07nX8DYqdCLj6N2ehey27IFo9BorAj7KUsGNrrkc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRTd0jPinrbBK6+n+ffuX5GYcMPccjLlis6qZ21e1g9pUMsNlB
	iKfin+Da7pJZG2g3WUihW4m74gPFa3uMljbzZxdOKjiadDdX+cuSWzcu
X-Gm-Gg: AeBDieuNrWqiJLydTDW2A8RMB908Qh7P2tS8lP1KVx48ZW/C6Dh/+mMPk6I4HHChx0K
	RCvx0Ta3VDZFpg81RMh9dNoWAbd93hE4XuWPtNXSsmSXkFrlTwT1q/0EDwwkAtjDr/lsQYMti+T
	bh10pj7/xwKep27sqCNjKJAYA2kyPYRM3nUd/nWHDX+/LwLZHZiTL0+4jYvb0hAImAz/BzNeTnY
	unjsbJPj59E1lQTT/1T99TK5cM49WO0FSvC2KUaZZAwnzHnP44dqY9fZbv0xNhpz7ZsikT3DFTf
	kN5iYvHlTKI2HTCw3QBwQkwzPkbtjZ0BG6GHDZEZCo3RdV5Ku4Kk+OfMkIydBsMTOCEj7bd3p6d
	dmtsooYqpfxrnJtuxVxpEkCGQToDpwtdNA0TMIS5IPOpB0+rfpj32RVdb8GQc2KexZk2lsl9Xjc
	6rPfI6si3+tIp8Y54FwxzpJPt3VQBXoeNvhkW9pw8/vyF0hCj80OSkFaccaVvSr9NmAiuLG927c
	KNFHDkZE129bvSQj5NCc5EArB1eRRtrbtKnUI2ZbQnYHe5SpG8VIpq5Cg4=
X-Received: by 2002:a05:6820:83ce:10b0:694:85a9:d898 with SMTP id 006d021491bc7-69485a9e036mr2719937eaf.23.1776782644356;
        Tue, 21 Apr 2026 07:44:04 -0700 (PDT)
Received: from smtpclient.apple (syn-097-077-028-210.biz.spectrum.com. [97.77.28.210])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69464e5e752sm8341657eaf.2.2026.04.21.07.44.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Apr 2026 07:44:03 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: Discuss: Future of AX25, NETROM and ROSE in the kernel ?
From: "Steven R. Loomis" <srl295@gmail.com>
In-Reply-To: <CAEoi9W4L3WTVv5Hhiec8D8J=654h-p+Mh_Nd9bbm_cDyardsVA@mail.gmail.com>
Date: Tue, 21 Apr 2026 09:43:52 -0500
Cc: hugh@blemings.id.au,
 Steve Conklin <steve@conklinhouse.com>,
 Stuart Longland VK4MSL <me@vk4msl.com>,
 linux-hams@vger.kernel.org,
 netdev@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <5880136B-67E4-4D7E-A64C-FFF5A3E4A56F@gmail.com>
References: <54da3df9-6c91-4df0-87ff-1975d536761d@blemings.org>
 <CAEoi9W5o_twDPYMZDqajqz+UYJm5wOvAx+hUFefXmU=vUbOgtg@mail.gmail.com>
 <CAEoi9W6vTPPHh-NBKZcgmo7GKTecQw1UuZ4HjwNTzqvNXWC43g@mail.gmail.com>
 <7a9547e1-9958-4bce-8547-71a93153a0d6@vk4msl.com>
 <c412bf83-e8cf-4a3d-8619-63f68e108399@blemings.org>
 <CALJxBtX_T8sv11ank-arLfoVqJqXegi3D_ZT9ZFbMHkuf-2RAg@mail.gmail.com>
 <5549733f-c9d6-4bae-84e3-285a317ee334@blemings.org>
 <CAEoi9W4L3WTVv5Hhiec8D8J=654h-p+Mh_Nd9bbm_cDyardsVA@mail.gmail.com>
To: Dan Cross <crossd@gmail.com>
X-Mailer: Apple Mail (2.3864.500.181)
X-Spamd-Result: default: False [-1.16 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280161-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srl295@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	APPLE_MAILER_COMMON(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 2807343C444
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

So, is an important next step, having a repo with *just* the ham items =
with its own build structure?  because there are a number of other =
modules in the repo mentioned:

https://github.com/linux-netdev/mod-orphan

--
Steven R. Loomis
K6SPI


> El abr 21, 2026, a las 7:06=E2=80=AFa.m., Dan Cross <crossd@gmail.com> =
escribi=C3=B3:
>=20
> On Tue, Apr 21, 2026 at 2:28=E2=80=AFAM Hugh Blemings =
<hugh@blemings.org> wrote:
>> Hi All,
>>=20
>> Just to note in this thread (top posting as it's a bit orthogonal to =
the
>> rest of this discussion) that events have preceeded us somewhat here
>>=20
>> A patch just recently submitted removes the AX25, NETROM and ROSE =
code
>> from the kernel moving it to the mod-orphan sub tree of netdev
>>=20
>> =
https://lore.kernel.org/netdev/20260421021824.1293976-1-kuba@kernel.org/T/=
#u
>=20
> Wow, that happened much faster than I had anticipated.
>=20
>> A shame but perhaps inevitable - but I think we have a good plan
>> unfolding to both take care of medium term maintenance of the kernel
>> code (in tree or out as it may be) as well as a move to userspace in =
the
>> longer term.
>>=20
>> For the benefit of the netdev readership - we had a thread over in
>> linux-hams on this but that may not have been visible to folks in
>> netdev.  TL;DR: we think we have a way forward but appreciate this =
may
>> not be quick enough to meet the requirements/concerns put forward
>>=20
>> If we can delay removal, that'd be grand, but appreciate that moment =
may
>> have passed.
>=20
> Personally, I think this may actually turn out to be a good thing.  If
> nothing else, it's a forcing function for the ham community to get
> serious about providing an implementation that works well, and in the
> short term, an out-of-tree module can keep things working for folks
> while alternatives are investigated and prepared.
>=20
> I appreciate that folks want to discuss timing, but it doesn't appear
> that there is much else to be done at this point. It would make sense
> to continue discussion of alternatives over on linux-hams, sparing the
> already-overloaded readers of the netdev list from the sordid details.
>=20
>        - Dan C.
>          (KZ2X)



