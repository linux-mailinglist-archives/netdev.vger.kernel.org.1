Return-Path: <netdev+bounces-241765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D25CCC88032
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 05:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 50B804E2310
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 04:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFCD30AD02;
	Wed, 26 Nov 2025 04:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1yJC/40"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69436307AD3
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 04:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764129773; cv=none; b=RDzfENeIMK+JEuVAez9UcRDPIXHVG0sh5GD0qQLFz3X8gH+ly9CQNg5yljPgg8JatHFOrKZ+FQUJQMdBlePUxno+ZfMAdfb5eM1jnOiL56oMZroHMdYfYsXoBOpSCAoJ33EsV5/ZpyZKFAsKW/V2Id7OE3m3tGjyPIiVKPVCcJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764129773; c=relaxed/simple;
	bh=vLDyl2lfMZ8nAyQ3Z+vzcPF2pvQ0dnkrY0r2GBZL2CA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FVfRGTFVtBWOpXmg0Wq8dIySIydn3EAD4OnTmcwNQPVuDe/cU1pcRTKjgRVuSwhXcqegXDACtTFKCImrgLnpN529WBNq7xg4UlJn2YNYiPSmTTQ2tGhKXkaLUApd3UJaD08Ng00LBC4ngzkuw3+exgIv09kZuFEdTdCFnwXcOOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l1yJC/40; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2953e415b27so73946095ad.2
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 20:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764129772; x=1764734572; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vLDyl2lfMZ8nAyQ3Z+vzcPF2pvQ0dnkrY0r2GBZL2CA=;
        b=l1yJC/40/+M16neXk2jQ4fND6jCK7naxldrdxLXhZxc0OXZlxVkmtAnoBAJazLRq4b
         QQwut/AnjDUDHMHVod6evK69QW1JSQlKCCyCW1UX/ABkzCwaXM4Wkzy4hfAwMyu1Zqgm
         POnkS0tAA4acW0rzMX55ywb3Gm+67luY58yVVjlNId35MfCgKm36d1a9MxyH15jE5mLM
         Yv6M0S31arGXW5xEvKjY2iZrb/aUgLhr8FZadGAvTiJxxDwlo7lqpLAmA25HzIwSqYY8
         DHPBaYpzBtN0g4UtdUlIGGM+iJCHJgL07dOJ6fu3CTHygeIUjtkVpS4FS8f4ZH+NrdpB
         JbUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764129772; x=1764734572;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vLDyl2lfMZ8nAyQ3Z+vzcPF2pvQ0dnkrY0r2GBZL2CA=;
        b=LyE4+RKlA9xo90n275SBdMYe5c2Dar9z8+rxawNhTNCYeQZJdkPh/xXIea8YEWWD1A
         YUvG2SdIraP6nAgzeY6VOyAm2KL/mQy1zSNwEWwtX9wSpUM6w2m/RW/gDXZ1gra/+Fm/
         F8IZ8W8g77FsFiTOPNygz91fVQPSgbdyBANk0XRzbFengWdPmh8YEjHzaMUaUXm2fUyW
         JwBc2BzV9l8rA0BxqI1mYfIXdYi2rpbgY0xW1j09Jn0ErdNahGLp4lEKx0Y1f17m/NxF
         cirRSsVaNyLrZLXtkYePTDce+HpMqzS/11T6gzHQk5UGix94wmMj47DqbF6QGSWHAuNV
         JHLg==
X-Forwarded-Encrypted: i=1; AJvYcCWyYu81NWvhqelw1nwBajzMiwN2UZSAc8xCpzFcEgh9a5SaK2Hb9atSIxD/CQhqdCGwEmp7EU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeeOOW+p2fiAgx6/OfxCT+t1/smzcBojzqhObvUvXUP3+oRtq0
	8p4Iz4P+bl8835yrTyFMsD4CaBj3NAZj8BFqv/e0rRDD+sQYMtWN08GL
X-Gm-Gg: ASbGnctGUduxvHoHzuKyTQJOvoOSaq07b7mDXFJpjPsNYoUK+0A7odblVsQWmWDVeJL
	EcSwC01Qov7ZMVw9ienYgc8c8t5pYYfF3VoAke0a3M++Vt5rvc90S1Cq4HygaJZVpvWO/rBwkp7
	cdBjeWjy0yBW5J0xZylHSAZ/uw32Oi9pxp/aq1Ujfr1jaZLIXXN6+Apmr2w/2UwoTiRBplu+177
	cQs4czJbEjsEqsmpIw/wsWgOqb6NkPbM8PFczZvokz1PaB4u79X7Ri62B9QsqyDZ4MuuXL6AjJU
	2CkTrRy7WLlxA2hj/vDHHHzsjqO3hTbUe0u7abk28X1j7CMnrkEok+91w8oTFfvfqWsb80ImJw2
	Igmcy5hYBGsl3QlwVdIW9ng4a5XV1VUmwY2jvsyVrqDUIMPXxl18zJTEmLLmhieaK374+xiPb+U
	H7az8H3pFvfpWZf44COjhYrI8sQgc=
X-Google-Smtp-Source: AGHT+IGG/4gDI80ohwAsbOFxmJxFlSe9A7ma93hxoRpUX2M6mMSLUFzzoYYudEWKWs8CeF27EjSrcA==
X-Received: by 2002:a05:7022:692:b0:119:e56b:c752 with SMTP id a92af1059eb24-11cb6836855mr4290852c88.23.1764129771614;
        Tue, 25 Nov 2025 20:02:51 -0800 (PST)
Received: from localhost ([2601:647:6802:dbc0:a2cf:2e69:756:191b])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93e6da4dsm82819553c88.9.2025.11.25.20.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 20:02:50 -0800 (PST)
Date: Tue, 25 Nov 2025 20:02:49 -0800
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Victor Nogueira <victor@mojatatu.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
	pabeni@redhat.com, jhs@mojatatu.com, jiri@resnulli.us,
	horms@kernel.org, stephen@networkplumber.org,
	netdev@vger.kernel.org
Subject: Re: [RFC PATCH net-next v2] net/sched: Introduce qdisc quirk_chk op
Message-ID: <aSZ76SZItmQPbK1R@pop-os.localdomain>
References: <20251125224604.872351-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251125224604.872351-1-victor@mojatatu.com>

On Tue, Nov 25, 2025 at 07:46:04PM -0300, Victor Nogueira wrote:
> The goal of this patchset is to create an equivalent to PCI quirks, which
> will catch nonsensical hierarchies in #a and #c and reject such a config.

Sorry, we can't use another ugly code to justify adding more ugly code.

This is not anything personal, all hard-coded rules in kernel like this
are equally ugly. We should just revert the offending and ugly code,
instead of adding more ugly code to fix it.

BTW, I don't think this could fix it completely, it is just impossible
to know how many valid combinations this breaks.

Regards,
Cong

