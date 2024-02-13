Return-Path: <netdev+bounces-71152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3325D852775
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 03:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C49591F25DBA
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 02:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED4715A8;
	Tue, 13 Feb 2024 02:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkKee7L6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39A64404
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 02:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707790635; cv=none; b=pkg9r8+wC8c479yp9+5pRSl8DDCi2J+x54iZ4rwldo0BbpLWsKpoUCmnH0Y7agys4h800ZSHC81YhuJJiK0sok3X1NmtxBKUiaMVMB6c8uXfzq9EqXVmzFL30u9DiooxQA+c3qAlxVEbw9HViNvOkLmrfexPLT7t5UIXEaI4bZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707790635; c=relaxed/simple;
	bh=d09HZUYvwv4nihUP829/vuzC8yAZLGtgdJ4LNJ5GgK8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=KMc6p60qls7ogE+DHtAoaOF3uz7oxp8h94p4GUy0+LWUkeHJpWP+inQ0ncebxIi+qY6O04BmcQe7MRAYC0UrBNRW1HRYtfO0GRp+6b5Cl8rlTJ4L4wHnJn3Ejm+iasMthYWq9kDQRffe1oCaPyJaQymqOZOX3SYE0kmwFYxL2WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hkKee7L6; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6818aa07d81so28531816d6.0
        for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 18:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707790632; x=1708395432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A1JULeKSQ/FJQa/sttPzDojBhF596PUHBdUMKvZ2HBs=;
        b=hkKee7L6AXjQkJRbgkRyh6mUBkJACETpXf2VSUQo3a5fQmccDnOV6GtlCt8sD5iD/q
         t61mjCR+K+uw0NsOu6v7htqW7pAc63j95ibinfZ5Kiq3OrP4aVJ014K/E4dy0jBfcUrs
         bSMTsi0qN6Q5OzFZ+Lx6q0a4RiW6GgDB9Tm7xvgDubo4/WxDeBdvbarCYXda/uIHlCX8
         zTuCy7aIQ7ATl4S8zfwZdnJV1Thf1uuvVGkm3oYvi5J6HZ/J0V31q79GWLf549e3+xyF
         FPzm4jAfjIRA7Z00Z8QMZJNEw34UnO8ekV3lStorVkxPw4V3D6zRLuGuYNPYpEx1pnZr
         gdVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707790632; x=1708395432;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A1JULeKSQ/FJQa/sttPzDojBhF596PUHBdUMKvZ2HBs=;
        b=DvHRek3bBrspx47dWJN30JRjBglSimv22mrgR9NVvWJfyjIldU097QxbXaYJOxAAZm
         ltLqNmyxbk8sLJuhmUNMz0KTizkq3z3Z1zHgDHDXSKVWcJcwjn3q330w/4e9s9gZUxQx
         ZD+GIqadHJ/EcWB6N/IHnxTeFEbxv+E5CFPnvnn3UT4bhIkfoGnp8vQUtu/INvya5oM3
         pbZLd0eZfTXPwClbmTsSszxJtOfzIi4Yg08VmUM4KuI0W9Gv1wP5FXLlsWWBL1sDu/g/
         jXpJaLY2rCQq1HkjBuN83sRS9xTiprEWXAJEPd4Q3HfDuc/kasWidNkSszyFD4SyB4Gb
         zDmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEkzpOI+2vviKC1BZ+ZOjV+b0DR+dCzxJFV6vyeo3mG0t1IuFui3OPpcihWO5/RSH6FUlgRkQcGA8P7Dz70pTwY48FXY6L
X-Gm-Message-State: AOJu0YzCh+DIT9KLYCfq0/1le/lAGoDIxTQQhiEslFKV9NSML39M/yPr
	kDv4wV2PfD+kNscw7gqDM0peiC+9kXBRZtaIu/ncNwGfubi6xF+v
X-Google-Smtp-Source: AGHT+IFk2P/0eLaRfFEF0DuhTSycPgAs9LH94cWpz4XULQyvdFnmCSY+flab4uqVr2sI3b7oJjr2bA==
X-Received: by 2002:a0c:aadb:0:b0:68c:c5c2:70a with SMTP id g27-20020a0caadb000000b0068cc5c2070amr8963454qvb.62.1707790632563;
        Mon, 12 Feb 2024 18:17:12 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXgtnvztJBd22NixcDVV0xo4UdpAGMJKP4rYjJ381FZyd0g03G1Qw3aubjHy8oj1tVN4bkOPCTofv5twYRnr/3oItJyw6sLJBrd8014662kHrEYKDmJuXEDIRJqBIAZyf2HZe0uF6sJ3QYIRhHVyVJ5ZHbdmyqmerSrrJN270P0IsfVZdaL5lUFpkGrYGcNHNI3Ja8Uo+++fECrkr+u3Oq022YBHTvEZ1jbFkddR2zWq6PRBStz1w==
Received: from localhost (56.148.86.34.bc.googleusercontent.com. [34.86.148.56])
        by smtp.gmail.com with ESMTPSA id u14-20020a05621411ae00b0068cb1855d84sm781992qvv.130.2024.02.12.18.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 18:17:12 -0800 (PST)
Date: Mon, 12 Feb 2024 21:17:11 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Vadim Fedorenko <vadfed@meta.com>, 
 Andy Lutomirski <luto@amacapital.net>
Cc: Jakub Kicinski <kuba@kernel.org>, 
 "David S . Miller" <davem@davemloft.net>, 
 Willem de Bruijn <willemb@google.com>, 
 netdev@vger.kernel.org
Message-ID: <65cad127de7c3_1b2b61294f6@willemb.c.googlers.com.notmuch>
In-Reply-To: <567a7062-9b4a-42dd-a8da-e60f948a62f0@linux.dev>
References: <20240212001340.1719944-1-vadfed@meta.com>
 <65ca450938c4a_1a1761294e3@willemb.c.googlers.com.notmuch>
 <567a7062-9b4a-42dd-a8da-e60f948a62f0@linux.dev>
Subject: Re: [PATCH net v2] net-timestamp: make sk_tskey more predictable in
 error path
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Vadim Fedorenko wrote:
> On 12/02/2024 11:19, Willem de Bruijn wrote:
> > Vadim Fedorenko wrote:
> >> When SOF_TIMESTAMPING_OPT_ID is used to ambiguate timestamped datagrams,
> >> the sk_tskey can become unpredictable in case of any error happened
> >> during sendmsg(). Move increment later in the code and make decrement of
> >> sk_tskey in error path. This solution is still racy in case of multiple
> >> threads doing snedmsg() over the very same socket in parallel, but still
> >> makes error path much more predictable.
> >>
> >> Fixes: 09c2d251b707 ("net-timestamp: add key to disambiguate concurrent datagrams")
> >> Reported-by: Andy Lutomirski <luto@amacapital.net>
> >> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> > 
> > What is the difference with v1?
> 
> Ah, sorry, was in a rush.
> 
> v1 -> v2:
>   - use local boolean variable instead of checking the same conditions 
> twice.

No, I meant that the code is exactly the same :)

