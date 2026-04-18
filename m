Return-Path: <netdev+bounces-279469-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LvSFL4P42kuBwEAu9opvQ
	(envelope-from <netdev+bounces-279469-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 06:59:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A307B41FFD3
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 06:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A164C3037419
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 04:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EFB72C0261;
	Sat, 18 Apr 2026 04:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uVrq2spM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72A01C84BC
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 04:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776488379; cv=pass; b=ppK6H3l7+0v1iE5q4Hhi5RmmhDp6I0e8ZIOiJJZRoQBUiHiAEuNzvbIbm2VcrbOAEcdVcoAwRlHC69o7ZO2PZl8b1w+pHROFU5zmZMsVfWL2cs5OoZOs5PfVinXCt45mic63vBQMJeFLSm6C+baP6ZscsmqZWflMj6VivY97HMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776488379; c=relaxed/simple;
	bh=/qsZRQGC7Elc+S76H5e6WRSvVJp7oY32H7RraWegPY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TWkjBizAYB2kek41PrLyU9CFRnC4sHpTYLbluWv9CnuLBOJrPvQU3T0UtuIMBEoZpvH1xOEpRCIVM3r94VQvY8jTV8OSjT0smDG0BDUV1NyS6fJyXJunONNpWPhrGFyLvjTus1dlv0mpfkNCr4RbEEawYBiMiQwBTYTDhgJZlu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uVrq2spM; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50d880e6fbbso25334071cf.0
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 21:59:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776488377; cv=none;
        d=google.com; s=arc-20240605;
        b=Bm1g1UvSr8+WI/3F3t21ROmArZejoYRihoMnaPtr0LpWnhJmUOGpqBlEuSR1fcjRoY
         8HWVAR4QIVxN/WbRx455jULdUdLuB9KmXgoML/KvzBnn3dChR9Eyax9ZGgvxdlwLYKsx
         hGCoqYulumt301FM3ga2Id16LElwV40gVB4ANSpEILcxaGkLtZVoiApmqSsWGwsvw20X
         48Pu2M5sQWh14wlj93DeSiUJ+EnSJH5qcZCWMn+DRJwY/cil81hJkEZ1GGkn5CvNPmml
         5ZdrsHwmC38FOuid+wqUoydNPsFq9o0823gvxNnv2TiBeutg+i+NXbBo3dNZIjRRvWJN
         NPzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/qsZRQGC7Elc+S76H5e6WRSvVJp7oY32H7RraWegPY0=;
        fh=hWjJeRfF6sPmG8IYbyWps3ixkl1JPsBnkMNcGH10jPg=;
        b=gCgy1bSwOGt7DYabCta9CxN0TBKw3eWveUZwiBZZVCZD8vShxxYSbpgXZ+jQv+Xb/j
         pBdVmAyadRtTQPtIcd/aND/LHE423HsAtZxsFr6iT5CZ+8c4ZsbSG//QUY1CiPs4hWdX
         0Brk9Vf2suCqs9i5nXTKTg7Px9eYl1TJiHIUiFOxOpswuq3iLO20CXBdb1L1WPlrapQe
         QtarbQK1kLnGUktjUEvwyXnxj2kjVi1k2jDwWL5XkPUQ2+HTHGLPbheSxIo6ITI9l/6g
         sfHGOjhs94lbwKbhFWa8euDoI/YluYP9sOvnU5gLmG5oDIqq7/pb6WY5X07KUnp7ya81
         8TqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776488377; x=1777093177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/qsZRQGC7Elc+S76H5e6WRSvVJp7oY32H7RraWegPY0=;
        b=uVrq2spMvqrUoBar1CjMkMdzOSuqxsii+Ii2zVy81LVvAF7P8njMYvO2N/j/jkgSkd
         Bw8WEsmZNZkvirnGCzi3wdO+GvqXq6iovHTdsx6Nb/uvMcPCokxsHiIXPd4H8UkN04nV
         3HTjvVBHOOCe3VfB4o0BMDoPTqEdQy2utFbnZ/AQawz5Xayg5gCiQ/1L9avY2xe0SMRi
         92uLeU5sIM9UQCsRmsR+jLO/5yUVStcQuxfj24aM4baLzrU5kV8AsLxVru0rkAB4C/BC
         wxx9xYYYIIiTYfXet4wVVf4Y9szrtc1eNP8bzwYraianyoqUcLAemjbUYqcD5nD2LJxz
         VRwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776488377; x=1777093177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/qsZRQGC7Elc+S76H5e6WRSvVJp7oY32H7RraWegPY0=;
        b=Xz8wmycpiMOoYKXOnfOtExDZXZe7rGFXRogrKUn+B65lji81Ptu8V3jHEUkrDpZf2O
         SQBfMR+JH2Wk4uNAa+ZDJvTgrnkbE2RSlv3cr6+la+Zp4W0rY4KJ1qn/qQDKxpDiN/n4
         fECWw92s2JPWmgkYhlsoah8TXYtUgkQVdNGiE0jzQsw8QGFwr38hGIeFVmAZPW+3boiV
         AW7enUIKqOJrCy6+ogWlw7AFKVu5KvEBeu4UhHVJjQvQW4K6SZUs/NMTK2pQRjpK01Om
         oFyXgXhMXQ7GtXdVMky6zmB3HMnHvdaL0PWWHFeMqk+L9ARrZnSgLHaX37ZG3bsgmdHQ
         GsIA==
X-Forwarded-Encrypted: i=1; AFNElJ/gPzyoI2NJ0vSjVeIgC1VXZElGowvOUvPEs+N2dY7rS4emzW0bOPyp0vS9l04J1sSYgMkyz4w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEL8Gf2Y09xRi9Oa64u4sRBwK0/0/BONLIXCc2lW0LN1WBO2u0
	z8lwN4b6BCxLW4uPdnmzdwOm7SEksIHEp0+xlGzJ5hM0ewMn9y4F0vRKCrL5iYWe6YXPnVH8Jvv
	1ZGnHN2OYA146E7N/Owr+RJndMzhJYZd/WxVNjn1S
X-Gm-Gg: AeBDievrFPm9+Q3+HlhsIE6UQ/jWpHuEvOMXecLHA1PeMHaxhN2dFf+ouyJabNFBf7n
	T1dIOMKSe5J2CekpId2G8pJPGnza7HD4iuv+7RmwjcdgDfzT8c0k0g/InjaKRWiBMyKr3nRG72y
	NMqodOwt7OqStUHqABUMnv/4n/ix9XTWzigJ0C6lfrxAoXJ6qpl68nJ2MiRtLcJXrmlVBrjSghA
	j9aSiGHUKDdaRh6Z/yQz8k2UZf1m2rdi91FKFb0KyayZd53fp9xAa+43p/z1aJv6dYnZbjBmT8c
	FJbcJD0pM2JtizO42sbHTkEsXGJcxyM69xi0cr5WTHJnBlbVoHL5DgfownM66mHYPBWbuZnmpIO
	qxL8HL6zd
X-Received: by 2002:ac8:5e14:0:b0:50d:7ca3:379a with SMTP id
 d75a77b69052e-50e365f8d0cmr27267961cf.3.1776488376384; Fri, 17 Apr 2026
 21:59:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260418024957.2669737-1-kuniyu@google.com>
In-Reply-To: <20260418024957.2669737-1-kuniyu@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 17 Apr 2026 21:59:24 -0700
X-Gm-Features: AQROBzBy1tXK6UJssMBefrW_nRBZBdWOa7XRSr4kZ9_7po4AjZRn7hJlowqc-D0
Message-ID: <CANn89iLL0iWoU-jh=Nk+0fsGWNOeuwQ8DP=dVUT=LjBGHR_2FA@mail.gmail.com>
Subject: Re: [PATCH v1 net] tcp: Disable usec TS for SYN Cookie.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Neal Cardwell <ncardwell@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-279469-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: A307B41FFD3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 17, 2026 at 7:50=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> cookie_tcp_reqsk_alloc() sets tcp_rsk(req)->req_usec_ts to false
> unconditionally.
>
> If want_cookie is true in tcp_conn_request(), we should not set
> tcp_rsk(req)->req_usec_ts.
>
> Let's not call dst_tcp_usec_ts() for SYN Cookie.

May I ask why ?

TCP usec TS are based on routing. this feature is not part of SYN
and/or SYNACK options.

Both side must have:

ip route ... feature tcp_usec_ts

syncookies are orthogonal to this constraint, so TCP flows can use
usec TS just fine.

pw-bot: cr

