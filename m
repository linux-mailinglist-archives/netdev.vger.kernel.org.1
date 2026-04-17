Return-Path: <netdev+bounces-279417-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBh+JiOe4mn/8AAAu9opvQ
	(envelope-from <netdev+bounces-279417-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 22:54:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F04841E935
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 22:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 737A63002D7F
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 20:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B48332143F;
	Fri, 17 Apr 2026 20:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B9swe/mZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E5A13C918
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 20:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776459279; cv=pass; b=dJbJuul/jXTrI1AwMB2iMsNbWcrplbLU8kbgIhV6buzAREFpTQ/FCTEw8aIK7pifZyYr65NDrC6Xfx8Q8uPocGQyqkCRT995x9GJlk6cfrjGZbLve6hZxBFdjGkSmgxnebWq66cojbJfo9/9osZ3lr+f+KY2powqaqvfKV9ivIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776459279; c=relaxed/simple;
	bh=UyMR4aiAgkMAWZ4GY+7KEQYdTDpRSP89oKKHuw3OD98=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rib7jat9ItkY7CmZSaNHSaYX/GLUTYe6K83xbFZHxN7ExQxArkEhgPmp2huKXB/b3PCBcneUYtnutxLYFRDgc6K8Jzd+m2v3rttIzYsVPKKV5XrCiKfdTH76o6ETxPnDMTQ6Xp5NQtGgyqruypf3/v4NQ11fS7pyouVq+6IgMNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B9swe/mZ; arc=pass smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8a4b8c3a30bso11644806d6.3
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 13:54:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776459277; cv=none;
        d=google.com; s=arc-20240605;
        b=ixcrMOQyDt9q+PCcny4qu4xmti6BP0kLINgzkOVRUsyznWhoQJ/2HCtW5erdNcR4q2
         LcLsNt5ltWbYicYzQYw+KePdAIpuw66Cw2AzwSGm5kfYSkOKRM9n782X4XsM7l8c856B
         n75P7D+DgShAVaxfvxh77NFTVgHrXrlR2DP4PwwVDvNyjEKHZB5s9eBOrxxESo+EAwp0
         LXaoaQFGvKhipsFi3gGLEOMlT+j/JCgwww8/6G5NpIKu+waADa7724360UEVfimPewNk
         obiYxg+mYPDijZvCEikzk0rrPYcIs71Inxom88Mv0wrVztkjv97zywjVnddykx5owJTk
         LjHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UyMR4aiAgkMAWZ4GY+7KEQYdTDpRSP89oKKHuw3OD98=;
        fh=nzF1hwpu8O/+NKGbT4qL1o74xkH6317EDoa5oeI+hTc=;
        b=h6wiVkS21NO9xu/ahEq+qgVdwM3D780lYkgNqYvVB2X2GmPjdbYiXkcn/Lk0vWWZv4
         5vKfUEN+CJIanIZiYAJ7Bn8Ww5S+Q/3+7C19xovOso2ZJ/LTE+chm0cncEhh6iLheq89
         RWi0Cs7+4OTORuiWHFgFnh9sFbepHikeQzThJBGphx1zt6z43V9e5ui+Ck4Ie/nVUjsE
         bYM2EVUxIzF1/sOQYVHQPqi1cHPALsZ4QF5UPuShwq44/8/BR/Mpwv4WFC1Cf6J3szwT
         e+lWYADtk6eZhgDKpEI7+9am4/ku45JepeGMF93JSJbBFNxC86EDQ3PQoiIw7C7GuMSy
         l5aA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776459277; x=1777064077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UyMR4aiAgkMAWZ4GY+7KEQYdTDpRSP89oKKHuw3OD98=;
        b=B9swe/mZB0OhoeZmWI1XvVyPw5DgNyHG2n47XyZoBILyo/X0kJb3zyPmEc1lpGOHym
         hASdGk5iL7YnFsJBRXdoQLQ2PXO/BJANQZde0h4VuYf16wPyK0tzIasEuwrPrzf0d2xJ
         pgjSomAYzeDoSFYrwekxp/R6yGR5FGG1F2nWGDAS3VJD4RHQnzjcWXrn1roTWsoB9E34
         UGVAA9pifzBIJEqmhTBDUXHJ9Bq6mfaddmOWrwFt9Vq8jebcjdfRmFY2MzLYOTPguXFr
         b4gVLziPyXRT7o+vII6ar5w003wVquK8JXxug5K3GkzK6y2tWxzrZ1nmfXnMKV8HG1da
         0eYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776459277; x=1777064077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UyMR4aiAgkMAWZ4GY+7KEQYdTDpRSP89oKKHuw3OD98=;
        b=pTILc/KRU7sJ8dzxsBcpKYg64SkCgtFUU2ITjkxOAT5IjybJsQ5+JBcDz9Bpt04kK2
         orvpib/OpUDyqNWoGnzipJHE3THtSuhOFLV64GA0ltZgdhA3kBXPJRj92UcoCp5K2JnQ
         Y9uRJsfVYEtymK5BWe44OiOVW9KHexjniDGBwerarp4nn8rDU6TTiuzlbQ1sHwLYFz1p
         HQEmD2S5C1IAybE3H8fSjKtn5ysPHUHRClsCPGU9D7om6X16RgdgnGPjTEDGyso5mb1l
         O3F60s7lweS3LTcpBjHi8hHcEIHr+bPcyN61hYfIXHSbGYRK2ImkACtP9KuOFyY8soQA
         zRVg==
X-Gm-Message-State: AOJu0YwTJE0TGgccR2ow7zfLF2phQxHqEOSBjun8duxK1tLOFYdNV12f
	djlQ2rNRlg+1/+Z0cUT5F2uPqAT2h0OD2wB7pzEcvWcVMkuiZPgz7qzA7YP7vih1Q+aDbU0NvO6
	2uJDsvpncAR0CrZ8IjsQPA3nc4aZb8Gq9qNMVkxK8rY9D+cpwoJBBw0f+WIo=
X-Gm-Gg: AeBDieuNfqM7UOw7/qXD+glElN/H8amrMhs1LSwajUDOXf+YgQ08GccBxJ60IeqLv85
	P/vFownYYh9awYD+efew1mzspUFc5faIQOTL07KPeZIBuCX9hjL3jjc9NZ8UrRn92ti6UHN03VC
	HxhH3o9cGGD71wLOc5U4wtp+H+rUVSimFJ2vQn88R8uP81YajAptWhFZMichHQ+t1g4aynvDpxa
	OD3vqTyJTtGb3EPUxS4ql/q+n4u0HNy8ELWfzevvFDeZEoVS3xiNpABx++vRmosPezyr88zGtfN
	ZUPT3Z/1uq1DSHce/+GZnpee4A5GbsAyHc6DEC/UQOQ7mkXtNkVqVZr8/GSUUEYJgPP+n/J7Ge/
	rLaBgnsC/
X-Received: by 2002:ad4:5d65:0:b0:8ae:6282:df2e with SMTP id
 6a1803df08f44-8b02822456emr73810786d6.44.1776459276431; Fri, 17 Apr 2026
 13:54:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417202518.1354891-1-rubenkelevra@gmail.com>
In-Reply-To: <20260417202518.1354891-1-rubenkelevra@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 17 Apr 2026 13:54:25 -0700
X-Gm-Features: AQROBzATJJtS0KmIK0a4Z1QPtKoyGtuhuhSyn8CckO_lBwlXzz5vQewr34lZio8
Message-ID: <CANn89i+zy=YttsDesBzvtSrkdY+==L_L6j4O7EFjYKEggcXbGA@mail.gmail.com>
Subject: Re: [PATCH] tcp: fix orphan count order in __tcp_close()
To: RubenKelevra <rubenkelevra@gmail.com>
Cc: netdev@vger.kernel.org, ncardwell@google.com, kuniyu@google.com, 
	davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279417-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 3F04841E935
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 17, 2026 at 1:25=E2=80=AFPM RubenKelevra <rubenkelevra@gmail.co=
m> wrote:
>
> __tcp_close() calls sock_orphan(sk) first and drains the backlog with
> __release_sock(sk), which might call tcp_done() which decrements the
> tcp_orphan_count. After which we will increment tcp_orphan_count again.
>
> Since tcp_orphan_count is an unsigned int, we underflow to uint_max if we
> started with a 0 - at least on all current supported platforms.
>
> I could not locate a direct user of this value, and in
> tcp_orphan_count_sum() this underflow is contained by adding the unsigned
> int value into a signed int sum, causing it to behave like -1 on current
> supported platforms and then get clamped by max(n, 0) to 0.
>
> The impact therefore is currently limited to e.g. tcp_too_many_orphans()
> checking an artificially low value, if the cached sum is refreshed within
> this timeframe.
>
> This fix mirrors the previous fix I found while investigating: commit
> 75c2d9077c63 ("[TCP]: Fix sock_orphan dead lock")
>
> Later commit eb4dea585304 ("net: Fix percpu counters deadlock") moved the
> increment down for old percpu_counter reasons. commit 19757cebf0c5 ("tcp:
> switch orphan_count to bare per-cpu counters") changed orphan accounting =
to
> plain per-cpu counters, so that old reason no longer applies the same way
> now.

I find this patch rather confusing. Have you used an LLM to generate it?

You are mentioning old patches that are not relevant (bh disable/enable).

Given we advise only increasing tcp_max_orphans value (default being
262144 on modern hosts),
your patch has really no effect.

