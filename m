Return-Path: <netdev+bounces-259923-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WBcHDNixm2lL4wMAu9opvQ
	(envelope-from <netdev+bounces-259923-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 02:48:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EF51715B7
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 02:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3A2130078F4
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 01:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C3B26AC3;
	Mon, 23 Feb 2026 01:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HHUGoU+s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0038F4A
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 01:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771811285; cv=pass; b=A2q5DKVKM/9LxAZYo52RGv7XE1xOIPts8imugaGaThAIash0HJJsXsnv2YaEribQC9uTsEMS8yprWyi9XQVP1dNi+sCog+NDpDEjYWlNx2rqerh9aPCBY9uvSaKKki4OWFUUDixxkcITF2+xu3gNevpvOgcZNPAQ0MHno1zGwxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771811285; c=relaxed/simple;
	bh=N7eJovnh/hAYmC/V6eQ0aSJWtdsteXD3IMBtrBsPF/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WpHvhopseIn2C3tpd9Kz/WeXDVNbpYY4pcoMrOHT2Rs5MD0ZhwK/gWrs+y5FrdZLlVabEMnZGHj59y1w4Sbie+3U3BR0QJYkfrkxbfEDKxNRto9Kmm1W7z6YSaZlOB3qNglfIM2iK+x4kWzeVPDyZQSGkL7YIWavnGVD7vIlhbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HHUGoU+s; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1275750cf9cso3088971c88.0
        for <netdev@vger.kernel.org>; Sun, 22 Feb 2026 17:48:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771811283; cv=none;
        d=google.com; s=arc-20240605;
        b=Hg4wXQYnDPKJiMNEbWe49bIxlb7WuJPqBYjZ6xGLJecdQwsa2T/QMDL3PNd2q2TUwr
         DkaHIqk5NsfDMq4DIZYoyEeR2HuyuEyeiMTL/br0dZwMVWLPY96fJBgUGAJpx3QE1tmd
         kwk79qbpbcFdftuKBZEf5LMxBF5cNHgf+KaC/MldYug0ObFZy5Y/bz8K9QkKt4XO2s2+
         hrAqzt55xJu5BZQZP+mzxZpEg64ktyx82Kk0otDaml5qvFGw7+4zc12YV6v/7xdUM8WU
         YR6OFyip5kHV86V5TZKjS2t+1S1kJEdTDLlZ8tZrCv0gwDZBcbiaYYt+QddP1CXEzPSP
         SRrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N7eJovnh/hAYmC/V6eQ0aSJWtdsteXD3IMBtrBsPF/c=;
        fh=JPOd3kUoicNeOe/aYij1Gs7mMMkj3FwQy/+9EH9StSQ=;
        b=Jwx5vmYYvGKKZJZOUtxa4FL1+TLUAjK/0Q1+ZgvU0IiCmoZC5j3GnSrWMp5fNU/J2Q
         VbP4KSD9HQ+S2tQhPTlBCmK1xwWF8q900jtR+HeFegpX1NYs2IiVdfxhHH4BULQ4Id9l
         waQ1M2aIJUE4bfqb7OmhVBqvoqcUuS2+BTFvvLDdhxGrvowqNV8EHBkMg+6iic4aWHgK
         OpFHcWxneEaRwk2DjneMi/9SNIg26rgQfzzLBOYsERowjXY3knn0k6ca68doOt6939xC
         HXfy6muVLTF1xm0NXOfSuQ/D/oO95Wh68BOree6ibM2VGZCdDdcIjSCnbh/okSNpt9Em
         ekDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771811283; x=1772416083; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N7eJovnh/hAYmC/V6eQ0aSJWtdsteXD3IMBtrBsPF/c=;
        b=HHUGoU+syTv/avbpA74d5Abl5NEeA/qE1GozQLqyWtejyQ411yET3yVuqN2sdqMFsD
         rnzj8lOsD1h/d5d/jaV84UybqalcTDqUZXBpZ0xc8ccKE7YCV5aSvAzKene4jnoDtlOp
         3hB3zAjg8Sg/dpy3NSWAGkaivdsMiw6Mo/TQJSzMIiyAGgDaT0i9keyyo+3fRUHHziso
         zIePiIofMm+F4spersq3mg5O0H+ZCVmRrXF5ebcu/df4XU0VR5a+jK5cS+x6daPUQoMy
         INugDcMhuEIr435UeuYXXBhWiABWU9U1f3vMpCp340UmWD7DNnGAJ5GQtYNZyLdUgDXu
         4T0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771811283; x=1772416083;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N7eJovnh/hAYmC/V6eQ0aSJWtdsteXD3IMBtrBsPF/c=;
        b=a0oMCV/oQF9UQqxRomufcdYeeYd+4reVXQzE0ZfpzCYRRNSbLdgwkF9UCg6VqFzpX4
         CcD0H1nTd4rZCjKaXJz+qMXvKCRQ7VKa5K1ve4OaqTepSxi1eUMbwOx2dnQcio5t90zW
         SrMhcTafNMHP0UwB8kNx6czNS70NU7fWaxdfu+RafuEXZXiFUBDnLEpqz49R4finw4t6
         95pUUvebIlOb1wE0oKtV3QfILXWfRFnCpmDtWtabJqF/OanUKfV1ew5O0+oOV/t9gQWZ
         qzcndGQjscjRtD/xsir1r9OqVKoykZGM74gHw3G2fGB3G3Ue3D9PU/PUPOLyK8mgPrUp
         OEEA==
X-Forwarded-Encrypted: i=1; AJvYcCUgIcVusQc/LUNetW8dHIrnHD3mHfHntYxJlxmnQaV4+GO2UlPsyH76NSyELE4xkgfVXxdg3Io=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyj0jzzoZUkt6KKH4E2VJFDqMLnOOTtBWXCR0aPX6fjVd6vJiRJ
	g7NTworB0Ln6mLaNYwSWaKRQFIwSDkw4QVeijCJeX1kF+FfxuSe6ddekKtoLF0wj3QD0SO/Z5+k
	DWmEJ9Kq20lPvw95eRM5BO0Mk2tG5emfo4hrKFdwq
X-Gm-Gg: AZuq6aJmgixJ99QJ4Kcs8/IuIZovAsCvPdjjk9HPB4ffrOBjkCjUchnUW7jzoJ2jUFH
	fHkteIWS6mXQLwrGmaBfAexhO8msu+gqUoNQeaSAHjqcfgfy2SuBjqzv4aHr67t1dbFjg/45kpQ
	rVMEPQLirX/8L3KNvNT3YOEVue5eLRhEudhpi4voH/jPUPNUnPwWPUi88AdqBs9eQKL2ped29AP
	NTipN0WDPDPwhySeX4+ec05EU/DjBp4rbV8j4dp8iSvqzbLbhv2m0E5R/klUagGqVvbchj71UW+
	5jk31pOHq3uvqVIbOPLFep6iu4X48nMgtlI/kGywKFL9Rs3BdVlK7F36IrAPI46TXv02VJwX
X-Received: by 2002:a05:7022:2383:b0:11a:6424:f40f with SMTP id
 a92af1059eb24-1276ad44b10mr2063197c88.36.1771811282324; Sun, 22 Feb 2026
 17:48:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220222605.3468081-1-edumazet@google.com>
In-Reply-To: <20260220222605.3468081-1-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sun, 22 Feb 2026 17:47:51 -0800
X-Gm-Features: AaiRm520u3uCORPSzrsKaZyyEuJEZ9Td66EC_o7HjJw0xcox0Z1-eTBuOzWe5Lk
Message-ID: <CAAVpQUD5stiiho5bioYZPzKO25Kr6Kk3WjBeWVwmOYOSdLF_rQ@mail.gmail.com>
Subject: Re: [PATCH net] net: do not pass flow_id to set_rps_cpu()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Krishna Kumar <krikku@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-259923-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 69EF51715B7
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 2:26=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> Blamed commit made the assumption that the RPS table for each receive
> queue would have the same size, and that it would not change.
>
> Compute flow_id in set_rps_cpu(), do not assume we can use the value
> computed by get_rps_cpu(). Otherwise we risk out-of-bound access
> and/or crashes.
>
> Fixes: 48aa30443e52 ("net: Cache hash and flow_id to avoid recalculation"=
)
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

