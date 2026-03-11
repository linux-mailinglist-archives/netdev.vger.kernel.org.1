Return-Path: <netdev+bounces-266630-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KOT0DZpfsWl/uQIAu9opvQ
	(envelope-from <netdev+bounces-266630-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 13:27:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8EA263981
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 13:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E9C9301ECD5
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 12:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786B43CAE7A;
	Wed, 11 Mar 2026 12:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="DXryKu7H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78E03D88F2
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 12:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773232006; cv=pass; b=kdnCpGiPjRwbuey4c9hX2Mz3dFv/xJ0ZDhHPoY+9fwzjY84Qsh3+9t0fNPCdQ0TBjoxZATXuqh0w//NEu+EwGgAsJPZzm3nOIGHLybJsJZBHI687ylIjkdxFFR/svHb5aFX/F9t+ro5g2xnDdHz1Etke9ZAYYAoZCQk4kDDFazQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773232006; c=relaxed/simple;
	bh=Y8pa5D4jf9Wctpgklwk5CjbRDTtSY67QAOzsjuD7QB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JCB/+m9Wv1bdfUEAs/m61Kd1EtbF8UECEdX805dFBELvYaTv80Y5fEs4k0YyOtp9PL1Lia4jlmD/bMJ0luqFA27ki2KwoWpDxlNZSIdVNOxnsFOhpEFxtnZ64Lm4krh4NBd4Suf5Ld/1St/Ypz8ntQBU5UrpvgcWLoIObP/Tkzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=DXryKu7H; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-662abedbeb7so4262725a12.3
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 05:26:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773232003; cv=none;
        d=google.com; s=arc-20240605;
        b=NEoiDpGP7JF6BW7FNVL2Yf5WnaLLnOc449RC44w3M+9z7biizROp5SbQR/eKm5oKPQ
         740fZkILXUyY3qhJEyLY1rHu05TkIKQoPWQZbIBeOqKDSietqI3FY5dX0avQx7Ob8XHV
         Bf8FtYqO/tpaXkPuOOtnv8xnYQhI1tKSuuA9yEVwfx8060lX6Egxm9wA6Rkqy6KhRapj
         y+v1uo5tABAjG2tP+WfIa0xkx2uRohVlYVpST5tSE9myGT4YEyEyprlaKiKy4mnU0oSa
         i5eMKlezhu1UE8O94/9yVYemsv7cX+f4T/5y+BmAtP557L+lgg9bKpvfadCTP723CNUL
         zWmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zu56vqUMDNMKirad/bzBgcShav08Datpno9Z6/bNPPg=;
        fh=ppuZ5c1ftFS70S/5xLj9TNbZ0mK1DcX9RY+T9446+Kk=;
        b=J2M9DcIB5NGnZ4I7e9UnxEmHVJWgZmZpKgkLLOp+Jx6PwCybDhnvz1BzigvJembN9v
         ZaA2/CZOrvRIQCLreMCuTI4aUiGcnHg7Sd47QTLOIniMRdQcqV+2N+Q9fDqZxIBitFsB
         R2NQQEdFy15/tbjlVJ+qcOtglIFB/3szUZwj6eHY5OqDJmuFEsPRJja67hIT8tvofEmW
         bM5xg/sVW14gIIjqO7wkU3sEvjat4oSnyqA1ppSg7zenKLkyVkfQNYf3GrxZ18dR8PjR
         efEpGERWXjRY7a8OFQvA+WpX4JdVv4yu005C9EORexwd1l8jCFw4JNKhpuzGblMBCDTF
         HQGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1773232003; x=1773836803; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zu56vqUMDNMKirad/bzBgcShav08Datpno9Z6/bNPPg=;
        b=DXryKu7HuJk4cHEPW2iuQ6PRA1iHGAmQhiC0WyHtGgUJgCWLguSViJQD82/3pQnJKd
         58COVU85kQYkyN9N+5gPO17RTzvz9Wy/mX8VdWCqWbAxHb524v0msbW63J/rMZbJi/5M
         INAPYbrhQn1LyKU6JI/ZB+OXvsuUlyjm15pQUVRE+BQ6bjyZo4cayVA7km4gDwxRnX3W
         zvVwIOwKIi9c0o8oglCUKssGJ+0qks80ZUcD7fGBPBoAAVC/JTjanl8J7Bq8QGuP4xHi
         lN9QxQuJLm6ZYV0zX+zieBXJhQSYYQLjowD1hEIK6Wxi9XagLGtLACfQ/OndvNH6buX2
         bnqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773232003; x=1773836803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zu56vqUMDNMKirad/bzBgcShav08Datpno9Z6/bNPPg=;
        b=NDh794fddY/BUup/2+BUJo7xb58GgK7Fey7P8RU6gGcefXzUqXXnWTRZWi5RFGfN9D
         MVOpoVgb52/gDzoJ0NZh+RvliN0yi2k+1lTSGLuRwdkw25QUIfux2oKRSKMcgRvF/+Xl
         Ksajn7b7lvncO0Qtg96X/0TazhRWizpZNpXHFDwIlubjVJgZRp8R0y32keTEz+hEDltu
         IbwudlhJfX8SmWNzu+BDXa1Bb6EZdIQUlH6+jhfuoJobsd/0bXuQYHjW8p19vzR4S82y
         fED1WIj1Q53IAhefM13qynMxWbUziLMx4ZmkVaRkYEsuIGwWJknc77OKUq7pl7+DFG48
         alkw==
X-Gm-Message-State: AOJu0YyaRDv7XRwewW8KFmcGmIvCfKpToeZbSaIU1qmsvUIq+fqkRcse
	EcpDbZW/G08nMNiw5Lpyv3U9BZIx4B728W9UEAiPhlm8b6ALXhnHbGpKFk88lEBq9R0qHBy9NRy
	5ysPdIxBA+ZvKK2SXs+db++SzvslW8prt/SWTIG9utdddy7Mqd+W9qKFdIRiy
X-Gm-Gg: ATEYQzyPpSBWJJXSrdwx5uWvwaVKhqJrgyD3m2D9+/1ZF6aae9zsxTOrJO3FyvUHBBv
	dH56wobS2VDoU7N7yTFLRFKCwaFUGkksYbkrgSy7dD2YTH6X3f69GP9OPgDnB/pP5GktJflT0Pz
	LTdeybXGNHy7q1XEkmu16S1fOSRLyfB77GsaX40lIbFQFQ/wy94IoH5x39el1tFTjTzEmHK4k/t
	/6dn8sXmCKaGPa1BZCv9M5VmaW3nBuHlm0Vj9lNlUxQ9Bfz8xi2Bw8AWkTs52hdSqQ7mCJJSlIX
	K54gye0SfB+Pmtna8k/Y+nXKtWWt/bpUz+H36QfnBg==
X-Received: by 2002:a05:6402:51ca:b0:65a:507b:c7bd with SMTP id
 4fb4d7f45d1cf-6631a4d5515mr1120417a12.26.1773232002988; Wed, 11 Mar 2026
 05:26:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310141057.3353333-1-justin.iurman@6wind.com>
In-Reply-To: <20260310141057.3353333-1-justin.iurman@6wind.com>
From: Justin Iurman <justin.iurman@6wind.com>
Date: Wed, 11 Mar 2026 12:26:31 +0000
X-Gm-Features: AaiRm53E9FZ6mtIevc91YLRjNkGYYODpCWChpVn3Afuc9_9qk2AePTWD3IgrTJM
Message-ID: <CAOY2BqxUswHYoisKjABPunMUC5QJ-B-O9aXu=wKrhTZaqSqedQ@mail.gmail.com>
Subject: Re: [PATCH net-next] seg6: add per-route tunnel source address
To: netdev@vger.kernel.org
Cc: andrea.mayer@uniroma2.it, davem@davemloft.net, dsahern@kernel.org, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	justin.iurman@gmail.com, nicolas.dichtel@6wind.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 9A8EA263981
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[uniroma2.it,davemloft.net,kernel.org,google.com,redhat.com,gmail.com,6wind.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-266630-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[6wind.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justin.iurman@6wind.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid,6wind.com:dkim,6wind.com:email]
X-Rspamd-Action: no action

On Tue, Mar 10, 2026 at 2:11=E2=80=AFPM Justin Iurman <justin.iurman@6wind.=
com> wrote:
>
> Add SEG6_IPTUNNEL_SRC in the uapi for users to configure a specific
> tunnel source address. Make seg6_iptunnel handle the new attribute
> correctly. It has priority over the configured per-netns tunnel
> source address, if any.
>
> Signed-off-by: Justin Iurman <justin.iurman@6wind.com>
> ---
>  include/uapi/linux/seg6_iptunnel.h |  1 +
>  net/ipv6/seg6_iptunnel.c           | 79 ++++++++++++++++++++++--------
>  2 files changed, 60 insertions(+), 20 deletions(-)

AI review raised three valid points. Will be fixed in v2.

