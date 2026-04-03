Return-Path: <netdev+bounces-274867-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WN3AJwU3z2kAuAYAu9opvQ
	(envelope-from <netdev+bounces-274867-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 05:41:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 036B1390B78
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 05:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39102301982B
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 03:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E775352C3C;
	Fri,  3 Apr 2026 03:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HPCp9rf/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE1A285406
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 03:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775187688; cv=pass; b=UPZD+tDkB0TQQlI9fu6PeaINo6MJJH0A26wkFxURKpPuol7t1ZJa2EwC1oegPP1+Z3dkcc6/5KLetlFL2i8qe3NuPP/XxmRh2R3oIPeYhUhLIHjRF2eRuqPvQ9oNyAk5SLysjWd9+TqMQkEkN2dD2H9bg1KqzFOBeZZUQPJKUjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775187688; c=relaxed/simple;
	bh=XIkHOd1FHvl3dx9BV0ITQXHH2amJU9tNkTlkcOG9bBQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ecng93lCgXKpRuUK/BgguUIDwTcSAkLOpv+OrIidkF9YQTgoxwl4WO4htYD6/jkVsSq9NTBWZU77m+Uxnhym4PDGKWQGGShnNotuv/17FqxB/OqbE1Ju57ctx4jPq4Pmd7/8pEcJoZy7vAc+3RTRPCshdBz1ju2s8vzfkVD2vf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HPCp9rf/; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-66b0dc690bcso3956a12.1
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 20:41:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775187685; cv=none;
        d=google.com; s=arc-20240605;
        b=D+XROMbgcch8v446BvCzDlmERr9Om4SAwxrm0gFsGglyYPND0DtuXqWYnm8FJAUsg6
         EC0fV/9wCxmCzMBoIgOyXc8JcrZIaaF8dNCpuwPA3YWVMA77wwytha2RGlSOr4fOYZoc
         gKGqXHEos68pGgYHaYQCHr2PRFCPVir4KxM+nkgiLU3au1l50OOpfEGCmxlKTMw4+zS2
         99LN3MIc5AK9Zq4zXv8aWOWPkw0PISm+F6iU+vOic/kuquPOx38qEhU1P+N7ViN4clpU
         wjBQJFlxXKUvX6H65yaBdv8TYsIbvB0hBW03zEGI6X7LdgjIvb6DnS8fiGl+mOpipIpO
         NngQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XIkHOd1FHvl3dx9BV0ITQXHH2amJU9tNkTlkcOG9bBQ=;
        fh=R/OcOudBg4nbAUtyO1MUBV51g8s9OCYFYO5gUy8UmUM=;
        b=SqMpKlH/oeZ29JBv5hHwUFaaikVCkXUxU48Ah3cqw1N4ear5WiOsWO9LBv5IPO6NLQ
         y9q++a34t6Qh2kDD8qGA9gtr3LeUrILXvyawDZAuE3araEFDGNzJXFMa50URr51ozfFw
         tKqEhxf/d5yC/usi3kmqcBMq5lYq72xPh5MqofxBbepTvH0YcxGsp8JM4ncKNZrShhlo
         uZ6ocLtne91IWttFrvfji0JpkvzT1mEfruKZrZERhgJJssRVgGeVZSK2ToMrvryTmp96
         UglhaU4pGriG01+CUcjAVAu7s7M11TPabJXoRerjl2S7zbVJOubBfIdIqB0od/UPoq1O
         siTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775187685; x=1775792485; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XIkHOd1FHvl3dx9BV0ITQXHH2amJU9tNkTlkcOG9bBQ=;
        b=HPCp9rf/5y/Ao+YNYzRWMMvkhwybS2QKaN8z4UGGqoAnmVhrdn0oU2pZ7eoq/sUO3H
         f4eKKuucMyXpmgyGJs1R8XXXEM+v+6eV/WujH+vjHV8Sqfqj1NGsm6QIY0n1Qt+6P8nQ
         nsqGCY/zy5PE9lGQvOCTkfv5AZW0UyfuYLah1OWOqr0J2kVUw9865Uy29v9L9tV6EuCL
         Ngctj6DuE/Kr1adFN+i1cy3qt3/uowC77ODo5Y9JsQFRw+VbPXMdmvdux978jRR6Jm5K
         UisvfMGQ3WeSZEGclBEh6py6GHzusg5rdQ7cVSkkv7Gje4b7RfLHP7xIBCvNhnfRyv3U
         B7og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775187685; x=1775792485;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XIkHOd1FHvl3dx9BV0ITQXHH2amJU9tNkTlkcOG9bBQ=;
        b=ktiVMnZpqhzhLQK32sSl1by02SW/qI1raHyqg2nc2UzShzyKUed17yBI2IqBB4YBho
         tdlfPERW2JKTHubPgene2lhL1f5FpPawK8V8PxNv/c/TgYtFRxqNtkfLcXC3r8O2LEYb
         FwYhf3fudG3Nyd0NCFJryPmhXQQ+oU87AbqRsoEl51JOQe1Ofrc0qBJAmZnaoHJlVYjg
         rHHaS61uaBty03IeMMr12woEdNH/cyjOwek4bH311XOO9A1GPJhgzC5T9S4Jl80Ycai1
         GF2dbTlqNVRLAwRaMa5ISUiHQ9sE+4MO0FMHBwgeJw1nYVEWDBT3SVauBTia8GSiExlD
         VIog==
X-Forwarded-Encrypted: i=1; AJvYcCWCP6tySO4QUsUv5xQK14uPYiFUJvMAuFgZW2RyzpC4oWyOjd4iLY+ahEWdt6d43vf3BTVjcxw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx98G04Vx9+iFc1BDOh+F27oqJShicgc/KfLk0BIK2pKXCoyz72
	OQfh5sFKTcBz4wZCJPQs+kt8B52HO0jIf0g7QOe54EJm83jZn6ra6Y+q/Doa7VkMz1jsPCygyRA
	mkz+8EvvRgQ2krUU8o5z1u9rnM+hEsAi9yGHrGmzX
X-Gm-Gg: AeBDieviL/O9kJOKwqvvGv4bcZ/lVerSb7LdWUci0Dyo21pwF65HCdHe+coNvGtFT5m
	OnWeGfOURcZXM2vKLb6wDy+naKzFK4IB1MuTL0yfmAM5csSYqwyJGEJdvWgCMgRgwAP62KrIqYP
	JcvN+9tg9KUfIa88of87yq2Og7IJSaBNj6ato4zOU/8r4TgOUR+iPxeUt0YN757YcUwPYvMD9wU
	mnAqXMVMOj84skLl6VypOoJDjIGD9HAngpNp8OYAOuEJVmHu0RIVYlt8W6D4hRGjoGtNO168yjl
	ErKzTYJnp4kY5iNRfgpz0bW8gx9faBynDuTOt/I=
X-Received: by 2002:aa7:c548:0:b0:664:d536:82f with SMTP id
 4fb4d7f45d1cf-66e43f21a8cmr5732a12.9.1775187684933; Thu, 02 Apr 2026 20:41:24
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402-teaming-driver-internal-v3-0-e8cfdec3b5c2@google.com> <20260402074538.205e307c@kernel.org>
In-Reply-To: <20260402074538.205e307c@kernel.org>
From: Marc Harvey <marcharvey@google.com>
Date: Thu, 2 Apr 2026 20:41:14 -0700
X-Gm-Features: AQROBzAlxZy-jqAhcgQO1cYPSAVMLl07FHUvPVYLpxT2ENVW5QTeG7yBwvTOW1Q
Message-ID: <CANkEMgkV3qAC4asCDhL7ZznK83fD4MeAD51u-7+j1+LS53pbjA@mail.gmail.com>
Subject: Re: [PATCH net-next v3 0/7] Decouple receive and transmit enablement
 in team driver
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274867-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marcharvey@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 036B1390B78
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 2, 2026 at 7:45=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> Sounds like Jiri asked for changes, when you respin could you run
> shellcheck and clean up the warnings? We ignore SC2317 SC2329 FWIW
> selftests confuse the checker.

I will send v4 soon after splitting up the main functional patch, as
Jiri requested. It appears all of the shellcheck errors are from
SC2329. I see a bunch of other warnings in patch 5 (from
tools/testing/selftests/net/lib.sh), but they are unrelated to the
changes from that patch.

