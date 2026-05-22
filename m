Return-Path: <netdev+bounces-290660-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKDMB+bMD2obPwYAu9opvQ
	(envelope-from <netdev+bounces-290660-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 05:26:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79FE35AE544
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 05:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24DE9300E732
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 03:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5C731F9A3;
	Fri, 22 May 2026 03:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FOA++UnX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757BB32A3DA
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 03:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779420324; cv=pass; b=Jmt+PI7SHOPinXUduQNlPKGZhLGbBQJoJOpDWyxQnEBmk2AzevlDqwYWy5CeEoHet12WcdDRrBly5GMVpvyKlQukTTC0+H0F4UIP8OkYsRBO217WDcw/R1+IqGMOGY9vGeuJQX13Lvl9ZdmhR8MdnTNgJGUzxfp/6CGYGNZ3BGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779420324; c=relaxed/simple;
	bh=kuBMRObowoDM3WYgENCLpwQ0ryejnqjqba6UXFFhu0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U0VGaJRwx0qR7eb3/A761IrUlvuTD9CXLwgGyah19yiOt1+63kmtjT8YZ9vHJgwlZYg4lc1xSPRDRCor1B8e/DljyXMVDBUxnLFt1y7Fuh378TYDBApquCjXMM7i9oUOGypzWXxd4HcecESfoq/ekRyuaQvlVJW6/bFswoN5AOc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FOA++UnX; arc=pass smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-132c338a537so4617347c88.0
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 20:25:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779420322; cv=none;
        d=google.com; s=arc-20240605;
        b=D1lM+KTZU8ilA1i2EY+7i7an+TMVWiTA7czrR+zAvLVL/UrHo6jB9++TBYHH5N5kvB
         oKVTZezbx5T4xiCqSawpjlZF8i3kkcARD2WpekkUtARY/OSFnIHluRa2zxmCkjm4xf0C
         hw6M1Ft5ZzsdSYOnbKmBhx0M5Yf+QTygE8VFUtbOHR3PnXZRlz9dKxgrhHkkD3nhAlww
         J/aEPn8/Lqfi/t56G1mZrM/jCLJhpmCHGOzuKMwKc2BRdF+KTIAJrhVUYC3XcbZ47eRZ
         fj/usCWXI97o9kHK8h1qrWvhg8qDiam5daI/mNmkzAm+b63C66qgAjtylYjQnhEctsAB
         Bx/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kuBMRObowoDM3WYgENCLpwQ0ryejnqjqba6UXFFhu0I=;
        fh=Zd1VZDxNtaD+8j4wWMbZs/p31fbLVDnzazytdrKHMlw=;
        b=McDHu5lT6sapuqWTS/+bZuNGwHE5Yux2/nZQcrLoah4gGUfxsSg6Xrv9lRURKHjwfn
         hTzy924JBiu5N+Hb8Oz2BNt0H3YZBUg72Z9kcUFq9zGqilwziLYlzraBTlQvv2NJIftz
         XWbujz/gMsTTff2vj7KzWJRJI2ou5aydlD3YQckN4BURq9B/p1qVFLgpcbf091lP4M/m
         BzI8I9tgbADfXsxHjUTyGFfMapLg2IzcI63Q6a3LC0YElCcWrx0rY2d1FlDF/bX7nHBb
         6B6rv90+3r/wUvVo31zjy7OOsHWWsn+JNd+aN5HN1RLT8jtzAFfJHjkXs9nm8n/BInPA
         r8qg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779420322; x=1780025122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kuBMRObowoDM3WYgENCLpwQ0ryejnqjqba6UXFFhu0I=;
        b=FOA++UnXbkLeHCurJ7kD4q5WFcP7sMc7WmrtgDkoZ5lfNfvpkmvZ3PulHRGqpjij5v
         WvgnKDH4S5oWB5bTcLzdwDDNgL3MHBkJbyVb/jIf1E4aRXygKACX+qRW77FeDFcwvCzc
         jgMGevlkkM7XqECrxEK8n115XDUgQjDn92AtzV9gp+pqt2NscL2UTKsSjsYVQ8TBy5Wa
         pUwGuN1zob26yyBE6aFQ9hhBtKJz8wPL8np8UtU5ENWSEXzlQG+NNTSFfHXppRT6KtzK
         2UCMaKEDvkqBHl3k4b+2kjxsyCn+jjN/rv3/kZSxHk7vIKQmd0znt6Qyq3wflnaYzTeI
         E0TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779420322; x=1780025122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kuBMRObowoDM3WYgENCLpwQ0ryejnqjqba6UXFFhu0I=;
        b=IEK98FGyBBr+OBNdKQJaFqPBEedEWOfv+qWNC6SnDigo6CsLd102p9GfBNYNzwTlW5
         xrq2uq1gkc7UfnGN4FrzbdMeIJj7ZxF/w305UH5KpHOI/X6DcaxyCjaqW9pq8zYwolK0
         NwkBemWvStomyodOhiQ+YBFMigzPKSLi+ujxtBpxPMKPx+J06WvVErCgjLsYHUSIHCQF
         OZmlS2cpkk7Nd3rPt1vA1BNdIF3rbpLWNbMcdAiO7KgXBeSDF8fXnPQfhyuRVMGy8D27
         wcbnhJUGXmuMigVTBV2HERvuNAARA6P6S3m7TaZzZXjZKs7I38QXKaRK9umDTjnPsLwT
         L2kw==
X-Forwarded-Encrypted: i=1; AFNElJ93u4CuMSfZY+dM4SF+SEHlJa3OjA8sOru+kn6MhAiP6zrEH+MH+gA+x6AbfX8mUkrDDsEdo4A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4l+KJjxzspMF5SWon2N+4hrJ6kU/Yu1C4ZWXkL3aZj1zz4mtV
	bq5AtkjpJkh7dFq8y5hCiYiMpuGIh8Jp0chxnraJ28jJ1+c6L8Aw5JIfVQTNry61DUOMqPt7/KU
	NDHyeYXPde1d1zSbPude1hngrbdEHzt1RsLs0zaSS
X-Gm-Gg: Acq92OGS+Tc/yxkaMxwv07M9vE5Pv3/usZCYCWtPGuAnpLNejU9TAnNShO7iwO9qp4q
	LcsB08s2puy5Cz7CizDHHM6sLm5Tx6wRaF1ig/eLG0wK3cKT31YSiWHSBL0Vc+21OsnSxLc5nf6
	LuijOXYIJW7/tPAGwkfWwUZfyT3mQ5BQA7cAvnctsHqgexmtx4eAd4cYoPIVuJokVnzmO2N/9yQ
	wiEA+doPyI4LgiAtLC/AJQyYujsRGbsjCTvuVpo9QGuXqrWfccc1u6Y7s9eMqruFp/dPC63bh3d
	1RCbV6iADHwVdSI6AQ8kUZrO6i16j8ObVSvkDI4l3iPbpTCd23ksElpNCk3LdZblzOjqceHZt35
	3w/dcTZlBLcu2loltLnK/BDRMD/HShIBB4mW8aZG9PJb5zygUPtMC525ifd7mHlQ=
X-Received: by 2002:a05:7022:3d08:b0:135:1ae8:39a1 with SMTP id
 a92af1059eb24-13633fba771mr2190178c88.17.1779420321623; Thu, 21 May 2026
 20:25:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520103227.1133277-1-edumazet@google.com> <20260520103227.1133277-4-edumazet@google.com>
In-Reply-To: <20260520103227.1133277-4-edumazet@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 21 May 2026 20:25:10 -0700
X-Gm-Features: AVHnY4IrJQK991FivV9kbCG-jcggHLjue4ikcUjZpNUR4-j4W3wWmaodoMMo8So
Message-ID: <CAAVpQUA5pTovJspjx=3Uz59yh6BNLjO2nvco-qjB1-YxGVhP6A@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 3/3] rtnetlink: do not acquire RTNL for
 RTM_GETLINK with RTEXT_FILTER_NAME_ONLY
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com
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
	TAGGED_FROM(0.00)[bounces-290660-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 79FE35AE544
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 3:32=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> When RTEXT_FILTER_NAME_ONLY is requested, rtnl_fill_ifinfo()
> is dumping device attributes which do not need RTNL protection.
>
> Many shell scripts invoke iproute2 commands specifying a device by
> its name. After this patch, they will no longer add RTNL pressure.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

