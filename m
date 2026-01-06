Return-Path: <netdev+bounces-247445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 456BBCFAC6B
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 20:48:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C9F631A0F02
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 19:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7863D34D38B;
	Tue,  6 Jan 2026 19:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JegGPYB9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E282E0914
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 19:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767727325; cv=none; b=o1MfMXydTtyas3PXtKa8WTJQ6MHbJhgYdBXlKA/GgkA3p8ZKe7YA7WFEyW0RgViNr8bMslwMJoUvgrq+BLZMdRgEfA+iDIOAxlCd6jvMOWgv6v33cRzvhEhHRhciqgllpL76hBRvk1ZgK/EurLyQE9kGqRPT5xh4ovjwncen6H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767727325; c=relaxed/simple;
	bh=LBPKI5Dvy0WUuYLzMgHVotBvRKNK1svGv5Pedc2vrgI=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=urRkArv1LRbcbEu2OkwTWt1hafR/Y0UyxMlMglUfCzwICgc9Pyq77WSlD3bdxf7Ikq6SZ9TWOiDrptY5UP+HWW4oyZJJnIMCMDJsmI10Dvx7dEzW3UoXOgpKd+I7C0NyJRZOIdO+U7gQftxdzOuCJg2N5YTjxm1eJbjHsS5K028=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JegGPYB9; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-78c66bdf675so14201487b3.2
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 11:22:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767727323; x=1768332123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ne0MOt5p3LXoKMabS12zcHuX9vTa/qErRD1UOPBEfLg=;
        b=JegGPYB9qjGDivWAcOkRFU+9GhjOdthE+0ByAeDaeFwme6m8F50GAbkboiNsHHxTjJ
         iaOlaSPTjEYlhSf9p7nTQEApPm5qSMM76AU4WMcuhBuFQgMUClu61f6aQLAZhqpcKSdZ
         x3I1g5INA7iZu0GtgYPtSPMNZHkRBKc36pLzF7G8HWO35gy21nCkyk58LsssWgOWBjQS
         +2IWqrnjB0tibeBtJYSWpf/2Z/ooJQJtkVben9pohDwb79lr/Uqpt1smfogRcRL74gBa
         YPWuLP49dcG827P2FGi5fxUtzEJTHFRiWEe9dGIrGyonejb1EaEksEyNPgwbHys+jTtV
         sPpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767727323; x=1768332123;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ne0MOt5p3LXoKMabS12zcHuX9vTa/qErRD1UOPBEfLg=;
        b=d/JZk4zBeHfzCJ+YInKeEuLZQoN2fymtgR1MdBvSqGSMMd1QK11mrFRK5qUhc7LurE
         qJY7I9BVNrQUpV3Z5dohPBEeH/h6E0qNmNVk6ebZ6Fkhfeo6Td/3pk3Z7BK0w5S8be6D
         MC8gORzww/YprJi3VIW4Cov5QCY0jBT8U8W+G8x0139B9G89C+QBOuT02FdH8wN/5/1q
         rAaGMFLj148TiimAyc0xIYMw8VkgR1OXUQVcDAKei484EKNoWAFQ5FkiSvNupVTdhZxu
         PYwPicQ11DCSlaX0ySzsgWS0cTXVoEWIKF/NeP6XKSMZPQgnMZQpW0P/5QBCux7eRNy/
         Jmpw==
X-Gm-Message-State: AOJu0Yzb6cMyE5dH678HhPyx6f9tmUG5OsU4pvTCJm9Ozjw9n+WbaPAt
	zd1QlJVpnVIpULfSVgKL1F2jnRwqu+DZTeF9TJtlGEWIyUkpJQsgVcTQ
X-Gm-Gg: AY/fxX7ti/0TaojNVSF+VHbsXZBAIGWMZK+czJSCISfBJZLnAsuEuQqJS3m3kz+ChAL
	uM6NC50j+L5QHBc4L8fta6Evr2ET1m/I/nraWRp/gHr4Bn1RM1X6aZel1P1uUo8RpGpOPl7DIEL
	XvB7sRO/Hw+XCOazTFfyCy/8LEXfqEAqu9yGicsNxpVPiVHJY3cfTCaSYVzbKCyPwOd26wjXKEC
	dVdNeKykoux+XlkWmtVZbgyipInt2gBp+WvyXBQpcWriq7IvmCZK7xCzc/cMRmEyyLI2+6L7DJY
	BbIITK/IfYqA4BSZrBR3S+hsEsZcEAZ2bKC36e3dQC+ekuooLc9UsEZTmqWW6lpr/mM3TEwr0vE
	X4uPImzsI56HqMCJAG+4sLssPrAgRqAzrQ+1YtX2sJ/zv9zLFSWsN9qYi2/v6ltChL2LR7hsAOL
	8EuarkMhEFUXehjo4gHfsbuupdu5AWTQTU9pEMeOlreFWIG6gepPgzzFCPCj17t7dka5frgg==
X-Google-Smtp-Source: AGHT+IFF0b8UOTScZh1/g1SvUdtIQQLHfKpR5K8lF9AvD8//G1tznl87AagKs9yzLwqMIOv6dFVSNw==
X-Received: by 2002:a05:690e:11ca:b0:644:7a37:e8bf with SMTP id 956f58d0204a3-64716c66560mr79257d50.55.1767727322824;
        Tue, 06 Jan 2026 11:22:02 -0800 (PST)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-6470d80dab9sm1195102d50.7.2026.01.06.11.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 11:22:02 -0800 (PST)
Date: Tue, 06 Jan 2026 14:22:01 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Mahdi Faramarzpour <mahdifrmx@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 davem@davemloft.net, 
 dsahern@kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 horms@kernel.org
Message-ID: <willemdebruijn.kernel.36ecbd32a1f0d@gmail.com>
In-Reply-To: <CA+KdSGN4uLo3kp1kN0TPCUt-Ak59k_Hr0w3tNtE106ybUFi2-Q@mail.gmail.com>
References: <20260105114732.140719-1-mahdifrmx@gmail.com>
 <20260105175406.3bd4f862@kernel.org>
 <CA+KdSGN4uLo3kp1kN0TPCUt-Ak59k_Hr0w3tNtE106ybUFi2-Q@mail.gmail.com>
Subject: Re: [PATCH net-next] udp: add drop count for packets in
 udp_prod_queue
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Mahdi Faramarzpour wrote:
> On Tue, Jan 6, 2026 at 5:24=E2=80=AFAM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> >
> > On Mon,  5 Jan 2026 15:17:32 +0330 Mahdi Faramarzpour wrote:
> > > This commit adds SNMP drop count increment for the packets in
> > > per NUMA queues which were introduced in commit b650bf0977d3
> > > ("udp: remove busylock and add per NUMA queues").

Can you give some rationale why the existing counters are insufficient
and why you chose to change then number of counters you suggest
between revisions of your patch?

This code adds some cost to the hot path. The blamed commit added
drop counters, most likely weighing the value of counters against
their cost. I don't immediately see reason to revisit that.

> >
> > You must not submit more than one version of a patch within a 24h
> > period.
> Hi Jakub and sorry for the noise, didn't know that. Is there any way to=
 check
> my patch against all patchwork checks ,specially the AI-reviewer
> before submitting it?

See https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html=



