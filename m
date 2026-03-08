Return-Path: <netdev+bounces-265323-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KG8EGa+wrWnh6AEAu9opvQ
	(envelope-from <netdev+bounces-265323-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 18:23:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB14231646
	for <lists+netdev@lfdr.de>; Sun, 08 Mar 2026 18:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 193833009CDC
	for <lists+netdev@lfdr.de>; Sun,  8 Mar 2026 17:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA61439281C;
	Sun,  8 Mar 2026 17:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f50a66Om"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEBA38BF67
	for <netdev@vger.kernel.org>; Sun,  8 Mar 2026 17:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772990636; cv=none; b=p6HhyX9hEF/Gf48sbjMFPJppLqtmIiy1O7VsYYgAsF1J+OVhYn9x7uM66bzb+qAeSjxgyGJhQ3TOy7h88qN2fsWop4k+b7CrZ5mnXgl9MmnqpFreO7bQnM/oNM87GmrlsLiZVZIAT/fOl+UaP/I9oXAqR+BvwXneh13GP1DzMS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772990636; c=relaxed/simple;
	bh=VuoCXCoamOGuF2orFgH+mPmGTHKiDj9INStgVGVwKA4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=AbjmIUY1i4okqngxXPWG7FVyVIzFuMlc7cZJqhaQ5EjTBWMQ1F2YZD9gUzqkS8HQ45tu9NP7blyha/MGN5l7Y7PansFi03O2eE0Qt4tqsBrHZM1AgiWYxrDWk2oQ2X59W9WXcenOfaduXj6B9DdJp2eGuWk9AcsY7Z2Mh9FRwhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f50a66Om; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4837f27cf2dso101123685e9.2
        for <netdev@vger.kernel.org>; Sun, 08 Mar 2026 10:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772990633; x=1773595433; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/JoUPqz4Odc+g6k1BxjgxOzfEYse9Ie48GgdpVEUXwc=;
        b=f50a66OmrZ9cXnItMZNj3zwz+sxNhUYTcoSRHS29yMeggDgkHXvKS4MILJ2dH3E7tg
         5Huu1uGIciBkPvibz/2nBMxY4eRV1JaPhEnUc4KK7UOsDEiN6z1VOvUf+nocyPAU6stE
         MV7JDs1cSLgHKR5cfl3OhP8bjIVHaK2ytXSsDBw4aODXMZEmq//MQfjo+3VaOfjjyB1f
         bUeJwml/7OeSXACpIyT/A5aRTu2Ojn3BWYzvjry+SNXeX3C3N51mKlvOlbvV60Tz0cR0
         6s03tLMAXkbGE3mHzPGeCcgqJPSKR6Q9A+3yAHpqzMkpc7iptfpBJNDNSF96+n8prLeL
         bcSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772990633; x=1773595433;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/JoUPqz4Odc+g6k1BxjgxOzfEYse9Ie48GgdpVEUXwc=;
        b=gKp9wJy4dwVP/nyma4NBn+TQE9FNriczIMPlkl30zQBtsDkegUF0rkGBDmRUPdCRv0
         HhWZIRCstiaKpKK1mPs0pw53ooDcRprc8hsK+wfC93CPC1TbjC5+mTqGm9GTNJrXfPNr
         1yUee133c660aul2eO2FTPD5UiWuiS0YioZs0RbgatK/LmC7BGddw+8NX+3yHVBTwEI+
         H+rCDbtq+A+ejEhkEnb4V+ifsSCEYuthzapg5xOk0VckoCh50WbubIAY87xhlgWX0dZN
         h4lwww/XLK2451wDbCnmcKR1vgssI4ef5LvTqUoCkv0YV5W9IYDO+cQUMqz08XViVKFd
         UUNg==
X-Forwarded-Encrypted: i=1; AJvYcCXOnGMHQEX8uqsnmqyTHRSU2ok+gYBPV7sMtW8zNMyphMjo6fLVh0/vcKi4L6yEEVmc1AO+Ipo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmdS1EFsXxalp/I7LujCUgTnhHlGkDyvoS+QJuc/qsRdmHvQLf
	1+GPB9UuwPnD4w9YunqVV8qLPfR2nqw9BXGqOEK/HFKO5O909Ga9l0dM
X-Gm-Gg: ATEYQzzME2JLarjOsCvj2o0O1sEPA4JLb6c4p5zKD91OyzRlmIE7D5Jt49tJ81mm7oT
	stNicgPBU8fV8ymze/9lmo8WhzMX+FFIztx6W5cB6lo3bzaLnz9+o66Kn+3TNvqW9+o4Sr+Scv7
	MSLTivjARpmS6xHiDv3GKblSELOx1U1jnteg+L1dc4UQA04W1DOgHG2uraTbOdnVlQt3Obfiyta
	H8Y3y4jfx6EXGdzcdmfqnUBy4AkpfPNKVLgdAm15N3bY9WOcVxzJhgb2g8XTwPH5mI6WNycEkBw
	ASuLyurM8pOcQ0v4fb8SNhZJkhKuaQkZMgmgQRjpHg//Gn7KgzIieoRWtGJRgmNcfYQQImAffpK
	p1fcnkaKlKxottZBHOLyLFoJa14/wnuEx283rThxLlbEfA8Os0xPOvHE1jMYaYEXU3tcsn0Mnwd
	J3SHzBJrwjGvftw8N2UCqGtqGB7J7+7Wc=
X-Received: by 2002:a05:600c:3b02:b0:485:2f4a:6ae6 with SMTP id 5b1f17b1804b1-4852f4a6de6mr77880515e9.6.1772990633104;
        Sun, 08 Mar 2026 10:23:53 -0700 (PDT)
Received: from imac ([88.97.103.74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4852ad0ce60sm295102235e9.12.2026.03.08.10.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2026 10:23:52 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  andrew+netdev@lunn.ch,  horms@kernel.org,
  liuhangbin@gmail.com,  matttbe@kernel.org
Subject: Re: [PATCH net-next v2 00/10] tools: ynl: convert samples into
 selftests
In-Reply-To: <20260307033630.1396085-1-kuba@kernel.org>
Date: Sun, 08 Mar 2026 17:23:47 +0000
Message-ID: <m28qc2grq4.fsf@gmail.com>
References: <20260307033630.1396085-1-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: BDB14231646
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-265323-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[donaldhunter@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Jakub Kicinski <kuba@kernel.org> writes:

> The "samples" were always poor man's tests, used to manually
> confirm that C YNL works as expected. Since a proper tests/
> directory now exists move the samples and use the kselftest
> harness to turn them into selftests outputting KTAP.
>
> v2:
>  - add missing ASSERTs on allocation failures
>  - fix the exec in the bash wrappers preventing cleanup
> v1: https://lore.kernel.org/20260306020901.524105-1-kuba@kernel.org
>
> Jakub Kicinski (10):
>   tools: ynl: move samples to tests
>   tools: ynl: convert netdev sample to selftest
>   tools: ynl: convert ovs sample to selftest
>   tools: ynl: convert rt-link sample to selftest
>   tools: ynl: convert tc and tc-filter-add samples to selftest
>   tools: ynl: add netdevsim wrapper library for YNL tests
>   tools: ynl: convert devlink sample to selftest
>   tools: ynl: convert ethtool sample to selftest
>   tools: ynl: convert rt-addr sample to selftest
>   tools: ynl: convert rt-route sample to selftest

Series LGTM

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
Tested-by: Donald Hunter <donald.hunter@gmail.com>

