Return-Path: <netdev+bounces-301549-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4xcdDHCAO2qSYwgAu9opvQ
	(envelope-from <netdev+bounces-301549-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 09:00:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BE16BBF6A
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 08:59:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=RWkzwMjf;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301549-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-301549-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A09C0301A429
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 06:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B80638A72B;
	Wed, 24 Jun 2026 06:59:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A696388E60
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 06:59:53 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782284395; cv=pass; b=OKjF5pDW2xnfARvLWqC5ke4uQv2758QvwvfKN/RX0u0DirBu4kSqSPnFNb3HNhKcybKG6T6KU2X53QUM5IqFiHR1qSu91MJywTAgWknb0rOKNjClYTH3LBihMRKO7Kgv3R8uwC9LgW71xtQ7UgYB5RSU6tVVBbc9AIVFbofzrx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782284395; c=relaxed/simple;
	bh=44VgNbI0l91KEdDqjsLiBND2ODLDt3zLlCpOVTLuvwY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=dtjvymgxE0tyJY3ox3MXfuqTU323XaPAb6csSvNJoa6fq/oKkF+inFqIKPoG/7xh+exNDZsHEDL0yL6ahfesnv1Xpokv5TwBRBH6u67NqjQKGf627mWDRwCI3CccP8MWg37VoFRu5ZjedLFNPtA1TKPTRuqKY6hcsbI+/fVS/Q8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RWkzwMjf; arc=pass smtp.client-ip=209.85.218.54
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c07ea058c1aso106219866b.2
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 23:59:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782284392; cv=none;
        d=google.com; s=arc-20240605;
        b=RPmXzpWv1xo2CC/I79wi2hNm2Sb6s/Xi/WjDNeFGhEJWgidQDx8jrwRyaH09bWEo5D
         dJACiXHit0GIg0ueBbmKytXfPY1koiyDU7nomkF/WHybqI184c+6EzBPEk7etaAQD09l
         tMIquzyjXrldP7qRwsHitheg1CA76kGDw8uFH5OaXKLUjLK1NMBq4mlneARRkP1NB4pa
         CgzA656o4N4rPGJOxn98pDcFpW3NIx69FrGqvgc6tA/hQW0oUaVAAlx9USA6Svgh/hfF
         kOvJCh6+2iK4IASNcsCMX2VPe2Z9iDO1NBc7aQc2y+1vBSjocc+fhxU3TdN+pseKZVNY
         Cthg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=44VgNbI0l91KEdDqjsLiBND2ODLDt3zLlCpOVTLuvwY=;
        fh=YnKlXY/m4wjAzlaJO4PetBysFnTV3feDsPCpbe50kvo=;
        b=Onm0canpET/xmFnvgdsDgeFKtiZFdMHBq2wDKoJqbaSYskXOpvquolKiVzTmhc005h
         dzBpNIo7hb3f7wH8Rmr2UBcYt1Fei22MEU8k1CvBXXIkk65EPCjYaGk6e5o+3AhJNLZj
         tm1x7L9T0LYebg/2v1EukYSfE5OZEbum/SSpOaG5IEv5kH/hM45ZELXFTaO3qJ6kA8S9
         n9maItRvJww3KDJA25bmZ3Sfs9Ze8gZKKyRBhJhmi7IhgLHwXVSbA0H8CbOhxbLr6cr6
         cssjbJkgcxEhGOK++SrbZA+hj8iyU1+LEU4B0ewpFVJSBpWrtsYj25nYHDLtAm54lxzJ
         ampg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782284392; x=1782889192; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=44VgNbI0l91KEdDqjsLiBND2ODLDt3zLlCpOVTLuvwY=;
        b=RWkzwMjfSbspuGMitpVnC20hjUGIfGntEprkZdgd3gHDn7maXw5PsQ1Ipd4GBmTZaQ
         /pFbvKA7j6KDUm69QpvhQUgw5ldVOrifq4dZu4/F9+DFo+DbFW8ido/7Wu6pEOVvyOqP
         QdZ2ehXh4sJmNq8uLNTvOEvhHtqhFjU7dGYKQcrlvskthhX+SaoLtrXJpK8MOO2LTIHX
         7RVV8I4pG3e7Orm6h8SlU+CW0o6GdqHDt73boWVk1Thrr5Nt2Dd/gevyqIGj3Z+dYLak
         Mo/7l0QXamYBuwWEU4UKuQqX9EIQijapP/XVr5p0jGcjwl2FQEgOV1uZC2j3SkXjoiR5
         k57A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782284392; x=1782889192;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=44VgNbI0l91KEdDqjsLiBND2ODLDt3zLlCpOVTLuvwY=;
        b=VvFivxi4/OhC32WrtrWoMhC1DLc8FweavZs0FosHfgtqCkp9Gl9TsmVkMGuzaJTlCT
         xXpIS3OV/cBz30xmvO6ABedCs+kHiMQ7jZq0d0ugXQP+O5tIUy4GvPuPJYYYHegZJhAx
         vRVlF+JF54eVUlVChmhCePMBg3yApQzh2ILm40+cTJmjskvlwFugnYDHhxf0PWg0tMHc
         fRr9w1rwBXvp1Nr0/4D3d8MrtRcE1tBWEn/XNn+DZCQ1JVkyH2fYVSS44BVhszYRU6D2
         fcYo19z49GFKC6bSLqv1FTaCGsuaL+bg1UGwnbrfvMWkvFBsEYw/UwSuRtwWPJZcSGg0
         Dm9A==
X-Forwarded-Encrypted: i=1; AFNElJ/JTIvYYJPaISNwT1u4bTaSPOiH88s+fBfbWCC72UjiJYDqVUbFNZI+7iQ+Sjw4v9ichnpAqcI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8w8pR2sIEFehurrFDsTuuFmYkJUSqbIsdWVMYNSZ6K1AbiifI
	fSzmnpJj1fawt0tST0zP5ggy/juR1CcIeAEJ4Gkiu64pTjsU0NDqYVNxh2Hsfktgm9hM5nvzqDw
	v5OQeYFDAtS45ciCgEPhRb23kiunXtdM=
X-Gm-Gg: AfdE7cnV6rQa3zzVJkuU1uMcmrttDsV+A6jxY53dJkPiSTQWdKfipDLcKonhvnxG8CD
	pv/Lz20BqMFOH9Nck+K0im2pfjYO/7SoJXesr97S+LaquFeLJFhJZsKS9zUNjF5KKS3M5dQ5ghw
	e0R7gXNaMdXlW6wy2WRRz+Bbqd0V3HX5fIT3/g9/IlOXYWL9uClt2BFWNsKKOnwCwbrSlkfPYET
	/lQURnV7/n+HuQO2HVqfeigUmjjAw+Q+JJt+0PC4l61VP/U2S/6AA4MqS9KjKP/zc607ap1rAIK
	Y6Dje+o6
X-Received: by 2002:a17:907:a807:b0:bea:f5ec:e70d with SMTP id
 a640c23a62f3a-c119cc73499mr81252166b.10.1782284392161; Tue, 23 Jun 2026
 23:59:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ujjal Roy <royujjal@gmail.com>
Date: Wed, 24 Jun 2026 12:29:36 +0530
X-Gm-Features: AVVi8CcjqT2HGCtdY0b3TsVb5_1CyqP5ethEgfbUu0VypPx0SY_tnqJhPcFQITk
Message-ID: <CAE2MWknz4X_gcNo6jkR87Lg8F0zfubkOc4Ujr57CS3aBMWrjEA@mail.gmail.com>
Subject: Please backport bridge multicast exponential field encoding fix
 series to stable kernels
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>, Andy Roulin <aroulin@nvidia.com>, 
	Yong Wang <yongwang@nvidia.com>, Petr Machata <petrm@nvidia.com>, stable@vger.kernel.org, 
	Greg KH <greg@kroah.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Ujjal Roy <ujjal@alumnux.com>, bridge@lists.linux.dev, 
	Kernel <netdev@vger.kernel.org>, Kernel <linux-kernel@vger.kernel.org>, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:razor@blackwall.org,m:idosch@nvidia.com,m:dsahern@kernel.org,m:shuah@kernel.org,m:aroulin@nvidia.com,m:yongwang@nvidia.com,m:petrm@nvidia.com,m:stable@vger.kernel.org,m:greg@kroah.com,m:gregkh@linuxfoundation.org,m:ujjal@alumnux.com,m:bridge@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[royujjal@gmail.com,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301549-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[royujjal@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 99BE16BBF6A

Hi Greg,

Please consider backporting the following bridge multicast fix series
to all applicable stable kernels:

726fa7da2d8c ("ipv4: igmp: get rid of IGMPV3_{QQIC,MRC} and simplify
calculation")
12cfb4ecc471 ("ipv6: mld: rename mldv2_mrc() and add mldv2_qqi()")
95bfd196f0dc ("ipv4: igmp: encode multicast exponential fields")
e51560f4220a ("ipv6: mld: encode multicast exponential fields")
529dbe762de0 ("selftests: net: bridge: add MRC and QQIC field encoding tests")

This series was merged via: db314398f618 ("net: bridge: mcast: support
exponential field encoding")

History: The multicast stack currently supports decoding of IGMPv3 and
MLDv2 exponential timer field encodings, but lacks the corresponding
encoding logic when generating multicast query packets. As a result,
query intervals and response codes exceeding the linear encoding range
can be transmitted incorrectly. This can cause multicast queriers and
listeners to interpret different timing values, resulting in protocol
interoperability issues, membership timeouts, and premature multicast
group expiration.

Testing: The series adds the missing encoding support for both IGMPv3
and MLDv2 and includes selftests that validate the behavior.
I backported the series to v6.6.123.2 and verified the accompanying
selftests. The selftests fail on the unpatched kernel and pass after
applying the series, demonstrating both the bug and the effectiveness
of the fix.

Given that this is a protocol correctness issue affecting multicast
query generation, please consider backporting the complete series to
all applicable stable kernels.

Thanks,
Ujjal

