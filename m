Return-Path: <netdev+bounces-300684-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id r1NcFZ8bNWprnAYAu9opvQ
	(envelope-from <netdev+bounces-300684-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 12:36:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A7E6A53FA
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 12:36:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=UTPcLzzH;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300684-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-300684-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 76B643007B34
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 10:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598BE3624CF;
	Fri, 19 Jun 2026 10:36:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A8A2E22BD
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 10:36:08 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781865370; cv=pass; b=jPhMPzDAMMHL71IYkU14Xb6Scca5XTabtTPu9eRdvPUH2G5YdRoCfq0sbRxnbkrH1RVA3ocVPqC5nB/53ty+TJHGGdvBZo0wLCN+VJ1WXZyxLEOrgl6j8U9S3x5MgIMxLFj+53Xz1QIBOmYW8qGBaFPS/J7SXkG4swF3ayuRtvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781865370; c=relaxed/simple;
	bh=FOdmCgzPzP+ZrD32qm0DZYaD4yZ8nHOzcyFMY4gH3FM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=se1bq6opc/lYUvr3PeFBAZ4k+JcK4+uymxcG1GNS2PT9Zy465Dt5nTC13XcXLeNe25Bcx5GjE1gNCpYye3OnV7Gj70EXUn8mlk+M7NVBKq3+CsNMCQd0LwOGlJj3B6CKjLWSYT0IEZkJ3Hv0My1qi8EygNKj5BtkHtYkFHJHYw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UTPcLzzH; arc=pass smtp.client-ip=209.85.219.52
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8dea42b547eso7157246d6.1
        for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 03:36:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781865368; cv=none;
        d=google.com; s=arc-20240605;
        b=cwlkF6NhkB8ImbNF4+9BU3tnd7N1EvXIuRG++kXKeMqKKhuf7d4LJnCExYA5SMpHHh
         TyJgwrlyyOJo7Tt5TSAvyE0+53IDLaGkbFqfAQbs3Dxyz5zixO+HUW09GkEjyWEQTSud
         pBxUwvzju0mpYRZ8c7QJtbm3xazlTI4P0RQ+osvoLAGEeTcpKH/RmkGCfaPfOqsvwVdY
         mnvXe74Oug2sZFS1qqpr/0E6vH+l5VWW13C2dFgdlyX/LCMNNQpi/6wbYi7NiHf6c7Rc
         /KilpoPXtFjBmN+6sJZOmj8mhX/K0ydU6SHciDktPRII/5lx2oeknVXR2JtpPaTOJQWg
         SeIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FOdmCgzPzP+ZrD32qm0DZYaD4yZ8nHOzcyFMY4gH3FM=;
        fh=E5/cZtofQ3nF6wi8pQvCjUA3M+X4WbFNp2bbs8v8308=;
        b=AvHqckgjCB4PAHj9ScQGN1CLRlIqb3d6VsFQeT6B3H+PrqtF0kmvmY/NtSoealBbfX
         pXSu/GMBBiADioGx+EgQB/DoMfRksVrTiRZUpnNx81T1WcWtEDMasi7etikyOYRovACV
         8ujdnwBzvm0WtvqBTlHljIIgHzhqt3eJMAIJYxPPFTMh2FdGdtvqBPeAfQALwpOnq7ap
         rvY3EIoYFR7M3OARP7v/28OlFYFYrIeekoouSxL+QflXNy+Q688hE1kPhiqP5GB6Txnq
         cdZl7vE4FjbFEUcuvgyv+tJ92iER9OnRposY+s/8bXd3aYEGUkhJPQamFDquzu/E/KsN
         gOUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781865368; x=1782470168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FOdmCgzPzP+ZrD32qm0DZYaD4yZ8nHOzcyFMY4gH3FM=;
        b=UTPcLzzHgUxke7hnAnESSGo36Cz76iFJZ26CgW1aEJVgjl0r+Ku2tnO/EH5qT/KD1v
         +WarU4tITR7bjma5LdU/RQ7AytZ42n3M8CAqNKPhQOvFBziroWla+Nn5JOGU8Tg+pY1I
         QqTyr/vhY3t1C3mneASACquXZA+Q17RmtmaEplgWf6BAYGVTvKMVBpKn7ER0IGMN9yTI
         kOMWNP0Q7uiW1UgWXWh0smx8joK8PyxCxuMYbqex4f81coi3R7oC7ObSB3ZoWyF4cmh4
         qRgLNBCUjqayNEiTXmzNBecuWqKA160SI8ffK5dRVZZ2Wqpw4od+WevbSFb3N0XY2cE3
         Ah6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781865368; x=1782470168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FOdmCgzPzP+ZrD32qm0DZYaD4yZ8nHOzcyFMY4gH3FM=;
        b=I0FFBJO4J0qieZ+zUiHvh7TwENzyxl0uf1fvVC/xwSiGRa/4J6k/9KmQKfaWUgk4Su
         R7/1OO1J53zsDve3Kis+bWTeKVzf4l7kyZN929y1ZWqIjaLKII09yWF8kv5s2fO0SeW7
         vD6VGdMAEHU1pEShk3N30xwoBJraGPwM6miFiKQjuSzNnSE/wwsT4AkIIUX9GS89ajNK
         zmOjmQw0Sn4+lh6L82lrzvsygJxKde1vfXlxNeiZkQ8kM58XYlTwRgFfRbdW/Kccyq7p
         22gBC9vkCf3kxMS8FQIq0D13MEa/X0jJweCmasDFPL+gJilFhzUxzKnErgNXZFoWhPqa
         mvXg==
X-Forwarded-Encrypted: i=1; AFNElJ/zOOe/ZdabqjayYFVNppGEH1/foisDS0rqVDjljtkXtSr14qsGWIi13n3tk5Rfh3tX45RhQvk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyezpIhI58KZ2qL7UcsTWUtQo5SsekbtsLHeBDtvCnDg0Qhxvfl
	N8vADKs8NgVBbfUYkH7BQbOzNfg7lq7N7wvpxxCRxi/6C5DI2cg8CcK2ej6T2vo6txTLlLzV3bu
	Pf8KIXYp/AGQGfhfJJpccLhq6lBNF+Vg=
X-Gm-Gg: AfdE7cme/M4jZLmC8TBnpAjFgIYEu0J8v06u/jz3lgq2XFnWqG7zgE52TqCg+efInf3
	cI0AsOsRAibgp1x0owZTDo2rBedggvwK6cea2010mgzWy3bxI78g8N0/ybDD3ZgQVbUJ3rMiFey
	QoKH435F5DaQ8BYrclaOPTbKGt+Pijr5Y4xrMUTpCVU0bAyslRF2xabXh4quGMa/q7Jw00pwJew
	aMCHwpliED/kRb5t4t/wd5I2Tl5FjzorhZjE1Cq2xoOuJxttO7ZTn5eOf4mZhG7aWWKCDjC2A==
X-Received: by 2002:a05:6214:6108:b0:8c9:53bd:ec78 with SMTP id
 6a1803df08f44-8de4004a83amr38002496d6.19.1781865368123; Fri, 19 Jun 2026
 03:36:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEKmD4KSvAGWEod3h8mPKQ-UYhKqakxfakt4gXrsU8sWuAO77g@mail.gmail.com>
 <20260618211231.GB2636677@ZenIV>
In-Reply-To: <20260618211231.GB2636677@ZenIV>
From: Alex Goltsev <sasha.goltsev777@gmail.com>
Date: Fri, 19 Jun 2026 13:35:56 +0300
X-Gm-Features: AVVi8Cc5YRyvnAYW-HF49GqUl4hwVsb0wCcdhH7ZhXSITHKBKh3FSzwnUEzJw0A
Message-ID: <CAEKmD4JfM5GWSiRMUn6NK+kKFeyXA8i3A9gthDz3hVKFcR1YDA@mail.gmail.com>
Subject: Re: [PATCH] net: add sock_open() for unified socket creation
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:viro@zeniv.linux.org.uk,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300684-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[sashagoltsev777@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashagoltsev777@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 51A7E6A53FA

> What's the point (and why not make it inline, while we are at it)?

> Are there really callers that would pass a non-constant value as the last=
 argument,
> and if so, what are they doing next?


As for `inline`: in this case, it would have no practical significance.

The compiler already treats a simple inline function as a regular

symbol within the `EXPORT_SYMBOL` context, whereas a static inline
function (the standard

kernel template for helper functions) would completely break the
export to the LKM.


This function solves the problem of actual API fragmentation:
currently, there are

three nearly identical functions (sock_create, sock_create_kern,

sock_create_lite) with slightly different signatures. If new variants

are added in the future, this will turn into a =E2=80=9Czoo,=E2=80=9D simil=
ar to what

happened with `kmalloc` before it was unified. I propose unifying this

now, while maintaining backward compatibility (all three existing

functions will remain unchanged).


As for the last argument, yes, today it is usually a constant,

but that=E2=80=99s not the point. The purpose of the enumeration is to prov=
ide

a unified, explicit control interface. It=E2=80=99s important that if, in t=
he future,

someone adds a new type of socket creation, existing calling programs won=
=E2=80=99t

panic or throw a compilation error, but will smoothly fall back to

the default case and return -EINVAL, which is a safe failure mode.


I=E2=80=99m also aware that in `sock_open`, the first argument passed to th=
e
`sock_create_kern` branch is not safe; I=E2=80=99ve placed it there as a
placeholder and am considering how to elegantly pass the `struct net`
to the `sock_create_kern` branch.

