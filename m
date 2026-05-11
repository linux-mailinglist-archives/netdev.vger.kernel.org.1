Return-Path: <netdev+bounces-286581-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDciOgiqAWoMhwEAu9opvQ
	(envelope-from <netdev+bounces-286581-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 12:06:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB8850B8A9
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 12:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DABBD30E6DED
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 09:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88783C1978;
	Mon, 11 May 2026 09:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ez4G0l1U";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="iGYIg1UJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415913BED16
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 09:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778493050; cv=pass; b=i6Wu/vczehcxIOoE9DRJJ7X54SRomu4zybov9eJ6EfR2NZWhxt8outlXEJlxO/ZZvRrxSdH94vURNlfqXg95LaEEsJtsCrXW/7kqmc1PCu6HbOEpFr6i5ZbhNJ9FDvTmU33x/hSe9h4hgMlzRHr3LslNvkITBBTdg5hy+ogTeiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778493050; c=relaxed/simple;
	bh=TyZ0hxf2iniFxRampZvCNdzcdN7Urpbpg3cYJjymmNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tPM6n9RWoRjGr2s7s5grSDiV+Zh+WXP3C84cp1xyv3TpYhAuQ9A2NTu0KHNMXsyb0ahEqwoSz/gArb50+8/LcHKQbUXXDjW19gWawcbZQQ7f28IFWVJWNggPUf2EDEAfG1ycUUZZvMciWrHR3lrUGgaVc42aJeqZk18acRUSj9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ez4G0l1U; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=iGYIg1UJ; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778493048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TyZ0hxf2iniFxRampZvCNdzcdN7Urpbpg3cYJjymmNs=;
	b=ez4G0l1U6aEyGlJ+he356XorfAo8lsc9M0mRhoE9ceWRxSJvUt4eC19v9WQc+pckPzJi0h
	+D1D2Uw+Q70vtJahsp31s8MooBznIcxQBV/rF8pogMrjWk8igdaiz4KT4eCNNZM9QXLoXy
	JJIwP2ASyQC4fRbU1eiWSpmkQkTtMlw=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-133-T4bAtkhhMIqAtqUOaw2S2w-1; Mon, 11 May 2026 05:50:46 -0400
X-MC-Unique: T4bAtkhhMIqAtqUOaw2S2w-1
X-Mimecast-MFC-AGG-ID: T4bAtkhhMIqAtqUOaw2S2w_1778493045
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5a40505f715so1441315e87.3
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 02:50:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778493045; cv=none;
        d=google.com; s=arc-20240605;
        b=Gb0fY6ULojl8/xGnUlPJj+BuVi1uL9sccJgSBSZR5EYDOT3p97X41AKxMLfmNqEfgM
         D2cUbvxNVjRwo0Ix3eHIoMDV1oR56UPP5e1c0vXCSWsP77JEk7YTncISHv55uBm9QJat
         Or8/lhYfCMrnCpm048X5yu14+h522y9tF5CZNBmv0JTRoFa16IAIBuXDlmv5VxujV7t6
         KgJnpCMu3khVxTZJVvzT2nb3euc9Tm7p83PWqxaeYlIX5bl9YeHnmUOYDNDEfQXGjuEa
         e0RZrppBkifx25zgX/ZZb0zMeZ5OkIEVf4QPs5dpLS4Y5H3jwR1kw2rlaOqXzP/1yj8v
         xt1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TyZ0hxf2iniFxRampZvCNdzcdN7Urpbpg3cYJjymmNs=;
        fh=rJq1ursW1Uze1y9el16XkFPgBMs2GQdPYrp6TtyuXNg=;
        b=ajA8HGcsbAmVmFRCpki6D5eZVZlz1kt2VaiurDVgUZlVUKylbUdEH2OblC6fbZaybS
         iUtoa+eFb7qHbyTC1TU5YXws8AD3Zf/lbL6ig+bpzxUBuvIqDBsE6HK3+hyQoBpvd63C
         qb8Su7t/7IQk9wQC5tn0ckOC0r4SsObHZSRnvsS9H5MCMC27PhgpqY6LBJRY/6Ld8X/7
         Myhchi/fI5C+DiLiK49bvNg8ZZM+CpMrDu9WBeYAmJFROyOiwchTRCVlubqyoL9bD5LD
         ro7pF2tpCIqIxqTDst9P5CyddtIoFqxry1scKzC6Btn1m+yQxmaHNcsEbEC0ismrWU8Z
         //bg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778493045; x=1779097845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TyZ0hxf2iniFxRampZvCNdzcdN7Urpbpg3cYJjymmNs=;
        b=iGYIg1UJFu7vIx9Pk44jKpM/yR8klyjVVkMJiPqq09Ma5jaq3n6UdrO5EigGilQnVE
         7LnJAsWKbeMlhNBlKt8ssr+dfLBwl+vB4lF7e/gTMgJoVaLtws4gupjy7CIwVAuvZaID
         gJbkucpNTq8MiVVvdBiIj4UtfiE1Lpq9cNLl5CkleUCh9LnT38g1d2nWdprk5+joSUoc
         f6kycTGlXhY2YTNSZF+/MqXq8KYXeNLdH9hJtmrYWT7d4KOcWw69uX7KXoJl0L9faDXl
         O05OoZwFUg/ddTJ+GFyHaJD28zNrQMgiOeCS4cagA6zFFmC2zELd/BLspNme4wkG8Jxw
         n/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778493045; x=1779097845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TyZ0hxf2iniFxRampZvCNdzcdN7Urpbpg3cYJjymmNs=;
        b=Fo52GhRkvxsm2ohYxtOPX2dgA7DiEps4/TPc3R5r1o4wTab+dYcFsfH7LCaIumcpyH
         cfzv0vqmrlsYHGauXgM5+1Jk6I9SXFZwVA74W1hwAhbbwcrsZ7V/533Ib9mv023W26SG
         G7x6DEe1yEFs8A14uUfmmtfd8u3A5MFVfGGdCtFYK8H+0awTrj/w0vgIo13Y9ofvu1iO
         ShA/75jtuXA+uW7DzR2HRpCzCwB8ineFzetRTCg8x7Lp77szyBsPYQ0j3V2Or2+8jSi5
         feX+ahY+H9NTTzWBclmempe9nJXM1xhj1fITLi7Bi93YAPVzKMQo3ZGcfyEIT1vqdVWB
         TUtA==
X-Forwarded-Encrypted: i=1; AFNElJ8pPIYgFFEGwoF1qcFcpVWqu8u2g/1uenhD50wxgmWIPBHlcD1Z40kLohQkkrakOH+cQM3+D0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAZw2TyJivDwbqkj/2GzY8/CpRaZXQf4Ea6rmlYkwp2SEW3egA
	4EMf1IM8s2eVon1JzDISNTZAutng1fnHrw9WSCA98nSp2GkElamqk7WniGjUUCtylmzFeQOUgwX
	Jj0PbBlOU45PG6zH5yYzeVpZ8s4ffuy29aoxBD9DGdRzhYJNNgzkdgO1eOqenvKmIo18n9Hy4mu
	v2giogDC2dw7K4YTPrroA4lfVxVAoJvZBp
X-Gm-Gg: Acq92OHu3F1eSE+hQLV1bbs7J8qSJvaTHAar8WwzWxnLA9NRqZlb9wmeO9B7dTQ2sSO
	YDzNgitVRiF8WMctOEkeVDtxbxnMyf9iBiKs7HzZRQ4aJvztvtki58SAG7Q7vT098YlI5tC9EKO
	kNr4qinMFm1eHj0cBMwnKb3vu6cn6ymh8/Bnc1915QFJETtLdhqvEyDjThyiSvZk4iNOB2/3O8z
	zjQtw==
X-Received: by 2002:a05:6512:3046:b0:5a4:56:aa88 with SMTP id 2adb3069b0e04-5a887ce5cb9mr8074552e87.27.1778493044710;
        Mon, 11 May 2026 02:50:44 -0700 (PDT)
X-Received: by 2002:a05:6512:3046:b0:5a4:56:aa88 with SMTP id
 2adb3069b0e04-5a887ce5cb9mr8074540e87.27.1778493044330; Mon, 11 May 2026
 02:50:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260510164337.7611-1-ihuguet@riseup.net> <20260510095246.5c8f6d0b@kernel.org>
In-Reply-To: <20260510095246.5c8f6d0b@kernel.org>
From: =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>
Date: Mon, 11 May 2026 11:50:32 +0200
X-Gm-Features: AVHnY4KpEIM0JZ6n7jbTbprKPPeQ-2CVzz4QuyQAwivI33Sd8j48Nhm6mgqEVfo
Message-ID: <CACT4oucitAa05V11KD0d2mQYc7h1L36zDGumnRYXn6+6XUa=QA@mail.gmail.com>
Subject: Re: [PATCH net-next 0/5] netdevsim: get link via ethtool, set via sysfs
To: Jakub Kicinski <kuba@kernel.org>
Cc: =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@riseup.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Sabrina Dubroca <sd@queasysnail.net>, Filip Pokryvka <fpokryvk@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4FB8850B8A9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.07 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_MIXED_CHARSET(0.59)[subject];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286581-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[ihuguet@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

Hi Jakub,

On Sun, May 10, 2026 at 6:52=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
> Could you please explain your motivation? Feels quite trivial,
> so it's not immediately obvious why we need tests.
>

We use netdevsim for some userspace CI testing here at Red Hat. Specificall=
y,
There are some tests that require reacting to carrier changes on a device
matched by permanent MAC address from userspace. As veths don't have a
permanent MAC address, we need netdevsim for this test case.

As you say, it's pretty trivial, but IMHO there's nothing against it, as it
will help to resemble better a typical Ethernet device.

Note: we know that there's no guarantee regarding netdevsim's uAPI and we'r=
e
ready to adapt for any change, but the truth is that there's no reasonable
replacement of netdevsim for these kinds of cases where veth is not enough.



--=20
=C3=8D=C3=B1igo Huguet


