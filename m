Return-Path: <netdev+bounces-297781-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rtsAJlWcKWqFagMAu9opvQ
	(envelope-from <netdev+bounces-297781-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 19:18:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6E766BEB0
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 19:18:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=e1810oCA;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297781-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297781-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC7A53041386
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 17:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EFBD339847;
	Wed, 10 Jun 2026 17:11:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081CE32E72F
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 17:11:13 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781111475; cv=pass; b=oRe2JOB8OzqoqNlIQ14kqxt4WNppDc/nwPQgzmzWhspb5tQq9YZtULjacrYVDonwu1DJ117fKpixgAfR9Ggk18D8wSNm9JeSNWUfqGZTifSIrvTiu0u+mTCTI6KcQKKZHj0v2C1Xucqi937LM13IAtzQaX2+Mzk076kPVg8I9jI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781111475; c=relaxed/simple;
	bh=zWs32IJrwN+s93zMClQ1TA7bxc29P32qIZVb/wG73VI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BZGhGC8WfpxvW6wwmI21Ta4B+/5i8YWxM29Kgelfc4KVHKx969o550PHX5iUySWqBnGi6+3dDHfgY0rBmG71o7ej7pnNa15UEYCyHTQRJ5agP9NWLUsa3ypcpdn6V9CfoEexRX2EgFH4F1U+fWe7VHxuz2CEJWq7YFtOEoX+73s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e1810oCA; arc=pass smtp.client-ip=209.85.160.178
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51790c0a692so72823181cf.2
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 10:11:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781111473; cv=none;
        d=google.com; s=arc-20240605;
        b=iTK/rT58g2ab4SrLBBaaffrb85d6ZkPCWvHs6UtoCoktF1LVjC1N9tPZL81G+Nuqrb
         BT1tPG1ffzRlm0rVR9jg3mDlLZjoCiD7IoHEFcMQEFWF1kbr0cnqnMCrUSbK2cg4e9g+
         2Q0GRph5MLMYkG+pPrrBpL1korevoUqopY8kZF7PD1pJGPVwSnud7EWkEO19L1ET2f3J
         y9K77t0jz3KTQCEzquVkoWcgL+wTlSnKT64dhzqg9j4s5jBGBva5q3kOY7SuGwH+7aJp
         ufED/Hkr9BdaWDBQPdjVDXZ4g2fVSOMBSn9Hb4LI00iRvISsMwP64MbVjT9qr+kMoB7L
         tzgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zWs32IJrwN+s93zMClQ1TA7bxc29P32qIZVb/wG73VI=;
        fh=a/5gO7Lqb6fzN057xkfgzNfk3AVY8MoTWY40V6VU2so=;
        b=ZFiPGwOGf0dJCP7/LqgBT8NKd3Fg72PkdB4KsGt+XDyq8ARPL5lRHal6eM4gdhPKrC
         zqGVmfbL/Z6Pxhqe+SsG7liiQw4oT8+sdPajTMJPN/QfHNvy/LMuPiAPpXW+xUgcQxLm
         ZdcKviElsFYWlYlroOcxLK1MYsxTXURcsfw+nlFFLh/YL2AKIvDctuiO0YC8Qu/nMd/3
         LUznnQMAaXP5i1Bc7AEwvJbMgwnGIWDBh9prHyGIEkod4/x8O8P5lroE0PGX7pu8/s6+
         Jb7QFmaTM0IX7j8PT8LIdJyTm5U7L/vICglKhYrhP8ZmoEHF7HaTjTovKFYT8lBU2daS
         Z22w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781111473; x=1781716273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zWs32IJrwN+s93zMClQ1TA7bxc29P32qIZVb/wG73VI=;
        b=e1810oCAP/tnAr8lzAuFtDAwseYnciALbOB3eAchkaqeTEbOd1nVfYNVLSgsRupeiq
         hP2fEkpVqW2KjGJSLYXMYLO4uGVAbfblLEk0HpzU6qvcM0eYlFbDb7+gbobc2YIzKeGA
         2Ugz0rVNC6Mt3PtPRTzP7UdXKz0d7vnad+HYasdp10Bkk88DyvJdXmwgG20MUHWRepLm
         /6B9AI8XadJwRYUlvXfDxrPPGZvy4M5yM5h9zU7aNN7728dw43GDOFfGSy3L7I1y+gkl
         JiBJXOMLNn+rY6G/85LR7rw5hZ0n9CuJfgYEZzxHXn0yauJVEvfy75WPAEzzDnVGfSFX
         y0Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781111473; x=1781716273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zWs32IJrwN+s93zMClQ1TA7bxc29P32qIZVb/wG73VI=;
        b=K2EB6I8gdMM/ntTAmAfyofk8iZZopevYVdfX++iKHch2IJYd4K3EpBwIJSjvXftkdg
         1heEwTvZWf5mb7yg9OCVuNXhSy9nCz7xp7zvSMHTynGq+5e3xkDdpYaX/5RHl/suYo6F
         tjRT7XmJDh4MfopAcUwcPLegRfG5JQXDk4XCFyBsKtebVNhutDEqn5hFoMWzfKfUO1Aw
         CbRdRT3znakqkNMpE8hg2VDoHCHulkx9xOkDJBLtr0UJuzZVdnkjqLnQNNoyMHNPA7rE
         Rt7pKK7+vG+DFfllJA+5J8M5hOxfwIUkxYQhXJyPiVnx9SiReCSBUTLytSqlMFIHEYkf
         Hb1A==
X-Forwarded-Encrypted: i=1; AFNElJ/zvMObdD4PgW0257tMEQ2lm2pQCmanuyLGof4d6rXMOgiK5jnOPcSWYc4/EMKJMuq6xqrZsig=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQxd5HAU0lovRaFmIt97JcJD8vWIyDicg3kFc0So0twb06+hpY
	/qAi4A7PwmPs8aexRZWKT3Ozj1sejTpTtIKflZkwaI083sEYivNuL/OYTo3K+OwzHc85L8pa1Uz
	bzUtnqWbL5xyZXWrPiGB4gDTczlsuu68Kvd6XngC9
X-Gm-Gg: Acq92OF2TR9wDiF9qhuTIUP26mgNbPkS9OxL16VLe/5T3NGhBxaatsUEE5Hza/XYRwX
	Bq6uaSkS6nJ7u2pmPwB4PUGk05GEdrGV44DONGihIhHLzAKaALXZKH8rDXS5OR6J1ZxI+0My4jA
	IiIGsfs4VCk0cIAduzMn9dqgB4lEXVkIFjZ1qXAEU3zwHfnYDgV/5pdyIjWoq0Y44MUcfk+kDaI
	oFPDQn17Z2BBBiAXf/PPeyDqzWwXeHLj1xYE/krgLp1nVpJBCJ9QUj4fy67tTgFzVEjPMFH20Me
	nf+wRjqsjiZpl2fuUPt010EEZ2gF3FRFW7nrjEN1Cn1lVgDvaXNDjKWB6kfXQc7O3TAgKlhRc8Z
	mpiB0BHmBv+U63CV5OQQOK06zdF1CZw==
X-Received: by 2002:a05:622a:4a07:b0:50d:9e8d:9837 with SMTP id
 d75a77b69052e-517ea707e88mr2754801cf.11.1781111472348; Wed, 10 Jun 2026
 10:11:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608130755.5626-1-maklimek97@gmail.com> <CANn89iLjG0krEoEE__3KUrcK+ZO+USZRC_2qZV5hAsxRpkTmhw@mail.gmail.com>
 <715cf429-9f2b-4898-84b4-15dfba4a9a8e@gmail.com> <20260609152704.2512ce9d@kernel.org>
 <85eaf82a-28bf-4d3d-958d-1225a7ae9608@gmail.com>
In-Reply-To: <85eaf82a-28bf-4d3d-958d-1225a7ae9608@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 10 Jun 2026 10:11:00 -0700
X-Gm-Features: AVVi8CduHZ0nw7MMirntoyUksbjZ2eGYKzRcx0KTDpH8zpvDvMFVaj28nNw20qY
Message-ID: <CANn89iJg19PsPU4svPxKvJJjiPkeAJjjuQvPebNRRQ7wcNa9zw@mail.gmail.com>
Subject: Re: [PATCH net-next 00/10] tcp: support non-GSO jumbograms
To: Mariusz Klimek <maklimek97@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, andrew+netdev@lunn.ch, 
	davem@davemloft.net, pabeni@redhat.com, dsahern@kernel.org, idosch@nvidia.com, 
	ncardwell@google.com, shuah@kernel.org, kuniyu@google.com, 
	alice@isovalent.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:maklimek97@gmail.com,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:pabeni@redhat.com,m:dsahern@kernel.org,m:idosch@nvidia.com,m:ncardwell@google.com,m:shuah@kernel.org,m:kuniyu@google.com,m:alice@isovalent.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-297781-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[google.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EB6E766BEB0

On Wed, Jun 10, 2026 at 7:16=E2=80=AFAM Mariusz Klimek <maklimek97@gmail.co=
m> wrote:
>
> On 6/10/26 00:27, Jakub Kicinski wrote:
> > On Tue, 9 Jun 2026 19:01:02 +0200 Mariusz Klimek wrote:
> >> I understand your concerns and they're reasonable. I would still like =
to
> >> proceed with this series, though. What can I do for you to consider th=
is
> >> series? Would it help to submit a few less-significant patches first b=
efore
> >> resubmitting this patch series? Should I resubmit it as an RFC?
> >
> > AI tools changed how much we value code, but they did not change much
> > about how one joins a community.
>
> OK, I'll start with smaller patches to establish myself more
> in the community. I am still interested in eventually getting this
> series through as it can speed up workloads relevant to our company.
> Do you think this patch could potentially be considered down the line?

Too many hidden assumptions in our code about MSS <=3D 65535.

I have more urgent work on my plate than making sure nothing breaks.

The opt-in argument will not fly, we will have many security reports
because of CLONE_NEWUSER | CLONE_NEWNS abuses.

