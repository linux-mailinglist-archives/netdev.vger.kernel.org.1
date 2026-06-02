Return-Path: <netdev+bounces-294384-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uy5XNEA2H2oYiwAAu9opvQ
	(envelope-from <netdev+bounces-294384-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 22:00:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E2263195B
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 22:00:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=networkplumber-org.20251104.gappssmtp.com header.s=20251104 header.b=mfIMLQyS;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294384-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-294384-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=networkplumber.org (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E2503046CFD
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 19:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6687C376A14;
	Tue,  2 Jun 2026 19:59:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A8D34C155
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 19:59:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780430397; cv=none; b=RKOQMtPguFDtimxQtVtgdaKzT812DSogM96SCqIt78vUGY/vJG9EtPCqt/q76NFl0olvB/rwicSbiWHKE0BPBlccsaurONW+ayLRX4bhFPAKfUy+Ks7FPV9ZpscWrVZiYKj7rubCfWXbHeSSv1ScuMY82Jo1O0HNNTl1AErPgrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780430397; c=relaxed/simple;
	bh=imAszdYXpMzxuYrajj0P7k+POijX3kDoSxRyoxQZTKs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jyy+kGuNVW0GvTuR3EdvUASVqibbvDLWXboKnPHk26fHXjYQcn0IUawRETViknQEBBi20br3io3hW4yqaz3sxZGMrr0mzkvKMsQC/o5UDSZo2oEJFquvvWUCmkqev4GzaAPTMhvcRxa/W41oUwwvg8DTka1SXU9arecluX9cwAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=mfIMLQyS; arc=none smtp.client-ip=209.85.160.42
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-43d26679a6aso1035863fac.2
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 12:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1780430395; x=1781035195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tq+eB9XFyDeqN81SawrHPGuGK0wAhA1RCA+ntvgu974=;
        b=mfIMLQySjrpxS1uw+KfnNjAFkyAgKaJ0dDBJRHhpIOz9v3mWt5EUMk9Q3dOLKzsiqL
         GidF9RCPoOQKu5SXdlHKG6JG0EvSNBUE9Vg2AIotrOpIm5PouHj5S/8PyyPF5xCOZ5ql
         JcppJuJpcZJQcQ+YWnlgjxqaEuLAN5Qi35uoUu7VoNp9Hd+0nPD+2i8mChZhL5ikgKQ4
         u1Wn3U45FS+YvE5NQzVVM06ZVzxQygTZacvp1mdHsbk6zEu/MlSVb/Gb9kKXuuHuVRS6
         6IGeSuh3q9Yw8oS97Gppv98GcqJ39v8eBxqyvZJhpOAVUAKl8AZxOZDCx+5HKq7Yb6AB
         fZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780430395; x=1781035195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tq+eB9XFyDeqN81SawrHPGuGK0wAhA1RCA+ntvgu974=;
        b=L90rGiKnFfmBDuLZ098MdXz9EZ5eIgvbao7gKLJhkKfwtl5A4GsZ2u41mF7U/EhPn2
         C9VYoSZhN9+e0bxwqaCHlUBbD9x+zOxoDjvP7iJ9RQ4UnvumtJe03nkVFjqROBjtG9kU
         pYhejO49W9z2Cm8G2u1+OWuPtIGNVbDCiX1CUj4ad3Ek8Ryvhrik15ifoTHC0FF5IK2V
         yRkSLYk+Ei+bElAWKhYc7Itw8QZjZ1ZYZVAKGVOGv5Fh5txJqUXBjpNMQlpOpkF3+mjy
         7+At3Pa7WCwzOv8612sCXnvCr9Kz6jjf7RwBVfmnYNXaV3KqqVtgPnb3g09OzgxCT3Us
         DdFA==
X-Forwarded-Encrypted: i=1; AFNElJ+/lvwLy7I42xZ3eLAMHnf/SSzT2IFVuWVwe4GvAbirprWMmYi0kh/M37cuA8wgJJofcyKLP2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFTDI20dh6x5jEzFNnlkH4W51dx1Z6IAWHoaQjB3RJLI5ts5iX
	LswJRSw/goianKex89u9XNaz72kT54jQ1Qfw49CM31Jiu0nrBwTWIvhe8npUtSCOgFU=
X-Gm-Gg: Acq92OHHTYpcMODbPvs7qktL5DKxOl23/6ERmoPtvaDqx9+0a/F4BRijGw1o9Lz34ES
	MWtN2hX8ripkRrjv9TpzOpNkseoDJZYNWh0O/rMMnpRbYvdS1QNh6S5ok32seaN8CNfn9FMeoMk
	nBOWci/pt2fhpSrqmYgGaY1nn6ScY3/TkfHdnRvtjJxu+yVT+9W1LVlzpULvFEXNX2raNC5zzq/
	8nUcCsIjM0XTQ9Qs2zIFsDSrdEuazvnJizLuAfOE+8fmw0QRzAPH8hQDEMKTWzEXiS0Zp30modp
	jFVm3dwwAIEwfRZYcL+wqREsje23r5d9bnY9w2OFZqgvZjtfoVP4rvOg+pK8ZphH/1Lihk3CqVS
	p9QuDE0u49SJ/c4vamXhJkJoHKBbnEqvbiMoQjKWRX0CdMaQqVpFu7kuXLgB3CJUGoHrBSGEqZR
	/mu2T8WU/Np8Lyunb9cl2uAUSS5KoAz8gK+WwKA4CGnlaFy4XuTtlTREBWe12sJ0qcNaI97ItU6
	AU=
X-Received: by 2002:a05:6820:178f:b0:694:9156:9b97 with SMTP id 006d021491bc7-69e47ea5e23mr328550eaf.22.1780430394801;
        Tue, 02 Jun 2026 12:59:54 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69e462413fesm515723eaf.6.2026.06.02.12.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 12:59:54 -0700 (PDT)
Date: Tue, 2 Jun 2026 12:59:51 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: David Ahern <dsahern@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 netdev@vger.kernel.org
Subject: Re: [PATCH v1 iproute2-next] iplink_geneve: Support
 IFLA_GENEVE_LOCAL and IFLA_GENEVE_LOCAL6.
Message-ID: <20260602125951.50492267@phoenix.local>
In-Reply-To: <20260523061102.2762452-1-kuniyu@google.com>
References: <20260523061102.2762452-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-294384-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:kuniyu@google.com,m:dsahern@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 31E2263195B

On Sat, 23 May 2026 06:10:58 +0000
Kuniyuki Iwashima <kuniyu@google.com> wrote:

> +		} else if (!matches(*argv, "local")) {
> +			NEXT_ARG();
> +			check_duparg(&attrs, IFLA_GENEVE_LOCAL, "local",
> +				     *argv);
> +			get_addr(&saddr, *argv, AF_UNSPEC);
> +			if (!is_addrtype_inet_not_multi(&saddr))
> +				invarg("invalid local address", *argv);

No new code can use matches(), it creates problems with conflicting
short arguments.

