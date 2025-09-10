Return-Path: <netdev+bounces-221745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC8DB51BEB
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 17:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D84C163C2E
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 15:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B139626658A;
	Wed, 10 Sep 2025 15:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CizH0mtH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407EC261B72;
	Wed, 10 Sep 2025 15:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757518748; cv=none; b=XQBn2Q5MBrL5MMqNBn15ajBIBZOUTB/zfWnz3S7UsehHtXYczg5lJY13cl99DH+CHJ/Rf2lxiHVa9/isQzwJRiO8En7+ijjwRjtmtZ6onQaoC2FUFdBfviorWV1gXaYhwsS92DwsGM883QXPRPxvbb3UfBaY5rj62uI5d36+MXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757518748; c=relaxed/simple;
	bh=jm+MVMnoTGcoOitioMl0JhUMddpemBxEk7bQFr7MI0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hUnsTsCnM73fHs3iRCUywB40Utu7+z5Hqf30CVphp+mvnOkBQz2u2CTwzVsxEPiDUGKHQjPYM7qe5DYbHXifaJ6VOXev1BwywFdwkkBRgCVI4BkHYC8QYySSP45YrMQWZYGKMQaT9sgvrqry+mw4Kp7msNbE11/1tEu4Qn+7Nd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CizH0mtH; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7722c88fc5fso6390997b3a.2;
        Wed, 10 Sep 2025 08:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757518746; x=1758123546; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lz3cQe8OGk16StuUYAxBdT//qXXUYyNpCBr6VvSGyb4=;
        b=CizH0mtH+Z362GF0Odg4Nt6M2eGm1AQ/DuA7X/QJx4jY8x+xKishZSf9gCnOzAs/MA
         fUran4rGerKIstTnkg1sOsmB3X2Iq9TycOlFvl2+BU5bPeWVYPJ5RQ3CasAYWlsXSpXQ
         C+UlBM5liMZGjPV0hi3CXFZfU5NHHBJwp39mT9s3u1y5VDHu4lFhlBQKGj4GysEc3sya
         N0Cob9h/o6v2zgSXw0HVeLJK2yGhCpcfWSS+95TAYfvlP9mndHs7XamHgAZUsYYxDmQS
         ziL25jqOTmIP1SfF90BkdXQBn5olWAMGVI94Q6PZC3/ZypwGNxpXV8kgpJNrX+5LLzdt
         W4MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757518746; x=1758123546;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lz3cQe8OGk16StuUYAxBdT//qXXUYyNpCBr6VvSGyb4=;
        b=AS0LU/eLGddUCPuLP5m0NUZkMPUbAkvjL6Fr8ApRmZzNxmVyZraIBLkTTlLyK5C0B/
         O+kjp0jGrphj1e+guf2NSYFqu0PJtPXp5vxr4KXElU+La15W7Ho5jW8WSClHsOs9gB9a
         b8kqcvDBHcX0JDJF5tNP1CCNuxd/i/jme/rkvYBOyH3NVHFSV8t1p6OxzhEgRpM3kcCz
         BHH3Y5cRQD77Nbxh6eCLXVN3yipDcmrz57pEoLI1jcJphemM7z4GxE+aAlnp2UHY10YQ
         5/iXFgZMOna87LYxCeMVTWKI7i+x886/DiohvFEYX3/HX7sYoR2nh6upSm31uCqv1BG7
         FvPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUt4pGdbjpEEYIZRjh9S7pVOdQrKOgWEnq+/b6aLy8vwmQ8tUjfI69Rfv1dkJQ+3okNWlDZge+slcGJaYQ=@vger.kernel.org, AJvYcCW6pgl++AFb/yAJL4odtQ/U0U/zENWcrOWqXXdkAYpU22Zo4MAb4xYx1MS98b9XWVKcsFT7px1B@vger.kernel.org
X-Gm-Message-State: AOJu0Yxotm5ahdcOK3jJFta47D99ivRJ4hUrtWnzFLSQA3WqOk4lWfwV
	lZZwjpAzNn/Y6tUUPvrxx8NmoTT3tzB5rXf7l+ZM3Ih6KlHqfOEeAeU=
X-Gm-Gg: ASbGncunjcp1BFaAphBSqBVB2MVc+S5/xoql2z0DkBg4zq5tsK9WXKlMWqhJmWdvqcF
	yj4H7mRFq+suqhOwuynUr5n9mu/YLSQoQnLQCqtjlE7TUt86VGm28m9Q239Cp9rq0/9W9C8tXML
	yviYI+z1glN49Fbpd6GvBplDimZwC8J2Da2i6CXa0YHMFVE2aymhNaWmTf3W0mhPutjtWCGyEP7
	D5OBTpkiGCYnI8s2I9vQCzBV5LsTzJNdLDLthNwVeILpqsg6KDcyyc6pY0OkhoMa/Ll4AhNcnkV
	G+C5adIfqeyd7jtI8+YWmevffn5YoszLRn18SV4tiv5+L2KE6xy0M+LWP4Sez2JhjrOWYFO4W4i
	xEZv82nTMrigWC6oXdi1KpGzoKOnr/oRxJL5vppLnHZr4hz0ESGkVXS/yhf1mxRrPb8zPFBxf7W
	qcI0VOOmmlZ6eAByOBIcAZvepPBOptTpKz2jZ5ymgG7reB6a5dYEiGkuRuj1WEgZ6RIEsDtCJYS
	EO7
X-Google-Smtp-Source: AGHT+IFSwkFbeETzq+QiSm8+ryNjI5pbUDXwTIKCYzGzs4hkPWKya8ykTb09IpsoIryiTqNMyUVY3w==
X-Received: by 2002:a05:6a20:1594:b0:243:78a:8291 with SMTP id adf61e73a8af0-253466eb563mr21179972637.56.1757518746406;
        Wed, 10 Sep 2025 08:39:06 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b548a3f2ba5sm2946984a12.10.2025.09.10.08.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 08:39:06 -0700 (PDT)
Date: Wed, 10 Sep 2025 08:39:05 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	ncardwell@google.com, kuniyu@google.com, dsahern@kernel.org,
	horms@kernel.org, linux-kernel@vger.kernel.org,
	Mina Almasry <almasrymina@google.com>
Subject: Re: [PATCH net-next] net: devmem: expose tcp_recvmsg_locked errors
Message-ID: <aMGbmaelbnvKymvB@mini-arch>
References: <20250908175045.3422388-1-sdf@fomichev.me>
 <20250909183550.5bcc71d2@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250909183550.5bcc71d2@kernel.org>

On 09/09, Jakub Kicinski wrote:
> On Mon,  8 Sep 2025 10:50:45 -0700 Stanislav Fomichev wrote:
> >  				if (err <= 0) {
> 
> Should we change this condition to be err < 0, then?
> I don't see a path that'd return 0 but it's a bit odd to explicitly
> handle 0 here and then let it override copied.

As you say, we don't seem to be returning 0 from tcp_recvmsg_dmabuf, so
this is mostly about the readability. But makes sense overall, will
repost.

