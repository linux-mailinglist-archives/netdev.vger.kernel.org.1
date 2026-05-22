Return-Path: <netdev+bounces-290661-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJI5DqnND2paPwYAu9opvQ
	(envelope-from <netdev+bounces-290661-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 05:29:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6165AE565
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 05:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F9FA300B628
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 03:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 954C630BF4F;
	Fri, 22 May 2026 03:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gZS1vfhw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF042BDC29
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 03:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779420549; cv=pass; b=aPUKndWnKohBBZGoNy+4R6UQwP1FRZcUb0DHGBUnoKTVTeFeR4yCQ622jWgXv2eFGYSoj8FIctVrQHtgq4uj7899E8Ll/eTR4jwBtbH0b4YhgxaM4RypHHHBK9iCXpk7chGf604Zrnh+WNPl1py8ibiexfaLx70VK3LaeKniXfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779420549; c=relaxed/simple;
	bh=027YCOQMsFuZwDMaL6aDQfoIXxl33BIFUcRJlnkNxlA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WgmzHh6/0VTBTP8+rXvlURuIKYP4HfGYTBi/JntBr7ut8bYQBPTOlNzUwDUWcocObT7Pin6j0NqENE8XuBr4cDFNN/nTaH17WkTqZW1AiphxhxCV9XThegV5x586AELbUf1x+HHV0lC8suyIWZlXkY2Cc9WRVNkpLDz3gDzMaRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gZS1vfhw; arc=pass smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-13621cca8f5so3270526c88.0
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 20:29:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779420547; cv=none;
        d=google.com; s=arc-20240605;
        b=emOjUJWlEh9BcuOMKeLSagWh8OzFmdJa7LyyV1rRgjWX7G+vGduTVCS0g1K9ylg9Qm
         0xURVkKfvuwBi56utwUhxhJ3GpAlVtD8M94He2QqH5tV18EI3PMBUCWiOvYALQYYM5Ev
         8ObMvZQO6cGwGAmEkwsEcPUU9t7D7Z+OMduTJAq8XRjKVI8VgPOIVBIDdBwzxeIGDYW0
         DDvLlDZMKY0zzLjXRtl86tlcaRLTJHpowbl76at/mn5r0VhqVQvxf9fu9inbxEwYZ+c5
         x4QgpbSGdzwWSRAZ1K4HdOr8L5nQZPr6ZWwuDAXKue3Ygjiz7fciLxHm10iYpvDm1bcP
         zsfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=027YCOQMsFuZwDMaL6aDQfoIXxl33BIFUcRJlnkNxlA=;
        fh=9B148Dklf/HTvgUaBXvahlAx2TUlZJV8pnqWfsV2Cbg=;
        b=Z/306gJxiJjeSYL+PU2lnZ0efAQrXtT+Lxb+70hiPAWrFIF5bLfhT6qN4jgUQrmFME
         7aqGNgW4pYZsCK3+D2r43oBIyFJ0d5il/3qytIuhxHg/S8tZ3aCAVXXCJEvYC2piK3M8
         t7VVQ/JLNLDj3Ol6FMkI+G4P7vLyXKWa6PGn80UE7RIQeV/6fEjqKjPY1eXkDneZQNGU
         O+PyBmHqjzYRxADE8zfRP34BGvQZNfxXnqaIT1GR2sBviIpeLVMga3AuF9ncpdwNFQaM
         UMY6sS5GsspDHs19Bf8oPmcmGNteEFuTIc2Af1CZdCxT9Uga3wRGYNP5wmEE5b3rP8BN
         ZOPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779420547; x=1780025347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=027YCOQMsFuZwDMaL6aDQfoIXxl33BIFUcRJlnkNxlA=;
        b=gZS1vfhwfJsMYuIdQ/wTxu3KYti1I2Ru5EQJY3nYgKCPZU6T+SPd5QxW+ukdSeXLnb
         Oa/S/arduLBk3F09sE7AUH95wBlJs7By8SvxQCz/m8YI0SwzgjHv+FEC2DLlPp05N/lj
         3HyfBRfgoNLAI4GHprSc/X+MrFdBQx6BgXKziDl6E2JUt2UHam6wu/w9LK52ldLZdyFG
         1Ehi0Z5IIzJbWEynPiheGeK9PI+V5KeAlI5lochPErd43VUDU1h0OuIPec81lXOF3mDi
         cj0xiNUXM9txmjainUMb6ThXPXZJhdD7cAPdxXDPA95UtgXlJj7+bqUUGNhdtX7eynNJ
         I1nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779420547; x=1780025347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=027YCOQMsFuZwDMaL6aDQfoIXxl33BIFUcRJlnkNxlA=;
        b=AkmpFGfjEUp65yNJ7IRi562z5529EFhzc9zVmL6g/QDTzYVrKEqEP/aalPNiRhrIXp
         WsRVlYe/eREBDK+C7ocjrwoZqq3eTCiGI1yfV7YLU2nRXygNc64g+NkG091Zz3evHeq6
         4o1BYSVShhFYdjQZ/bjQfL0jwLX8Bi1r/T9PPwCxN4XN4qmEAECMPCq71NA7wEAHSCVL
         056Wm4xjn5kFDORZbBXVgT0AAp8CJ79qg7CHc3r6eO+i+3ayi/AbsBkj1pVnfQhP9gEf
         WZVQKs3eu4lSS4gj1FPYQTnht2HyF2Oaw3fhcMnP/jiYvxAnSIDuryDpXofT2llLGZ7k
         vd1g==
X-Forwarded-Encrypted: i=1; AFNElJ+BY9xswyxEoN3GmsS29wsIO6DjQEo9kB4qXlA9rhiHU0Ean6xQEf+hEbpxhGKQgdI3xMBUsNY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+HjX9OvkuJnsWKyVAobaYDHbT0GCW07km7jhRIBxvjNZz7D1Y
	EgkxJmMvXpJIa9Yeyd7YH/HLDK85Grc+lQpInXAe51OK3ZuqC9iRtSkxEqDgJCRxLC7ugAyCU7L
	BVMrQ1/YqXmnLFEHs7PA4Tf/dV8jmMOFRAWiKDio/
X-Gm-Gg: Acq92OGV8pzqa8fzITM3vlq1w3yqY8Yj1PbaMeTFBhoiWpUbnHEVHieM9lAnfPvfhHd
	ndTawbQ888heQGxfCJNk34lgmAVHr5tyxVjJsWELXs00G3O0zg9mpoVRmRWFRPS4iU/ejtWzuc/
	JPUtHofztkNHqWpO4hoi4LyHVdX0uPE9HvHBANs544vtz7VZKeyuGiISEef3dKNEsxQrEMiX5LC
	tuTh/fGtxamzBhQxO5/SJ3Bye4WhewR4V8zTO5jJK8Jvx6sh9xEAfAJi0hohJ0aIWnKp2frX416
	TQY/dArYvlHtRUVOknOraU//MSrpNEXDn0WUDXRi7aLIY/KpZr13PTjxFi94kANLHYJQuokY1+R
	Ey2ebk0pw+/OU1Xddih1PkbF70AgzGjpilZDf6sRjtyYNssCaNbmR+IoN54o8Rpk=
X-Received: by 2002:a05:7022:6726:b0:133:1ba6:f42d with SMTP id
 a92af1059eb24-1365f812ee4mr870670c88.3.1779420546542; Thu, 21 May 2026
 20:29:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521174038.204481-1-edumazet@google.com>
In-Reply-To: <20260521174038.204481-1-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 21 May 2026 20:28:54 -0700
X-Gm-Features: AVHnY4KYzBoPFB-XaSR-zzhRNkC_IDeAi41exAJpQzD7V4ba6U4XZoWagkaooKA
Message-ID: <CAAVpQUDNRPdvJ15Yr4oih7+1dEob1PVT=jEbza+yZWxYYD+k2Q@mail.gmail.com>
Subject: Re: [PATCH net-next] rtnetlink: do not use RTNL in rtnl_af_register()
 and rtnl_af_unregister()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-290661-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 8F6165AE565
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 10:40=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> rtnl_af_lookup() does not rely on RTNL anymoe, remove the stale
> ASSERT_RTNL().
>
> Add a private spinlock (rtnl_af_ops_lock) to protect rtnl_af_ops
> list instead of using RTNL.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

