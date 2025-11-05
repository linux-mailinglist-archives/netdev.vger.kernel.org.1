Return-Path: <netdev+bounces-235732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E619C345D3
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 08:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 85A3C34AA2D
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 07:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5002C21F6;
	Wed,  5 Nov 2025 07:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKJnnlB3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA82420487E
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 07:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762329359; cv=none; b=UgwOh/BLwxHzgdSNjSbskzDZJSfJNAdP9aEdmZQJ93VrlqFzSnFB1icOoll+Vo5/CMLWuVP4ft2AvZCMejU1ebxt9wyf4poICXGtNjFEAl3UNUnfYKrWnMgpbOVHueN+upL01lR0tGu8RPuruXshR2CzUz96XIZjFt6m71eFuvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762329359; c=relaxed/simple;
	bh=AbDuRmZXeMPetp7OedkIwGRtdY1JYUDRbpkaMbMziX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SxWbz2bLER0AyLHBvWG81NNeFLi4xBv3MhzQgDfySggRi9PHgdpozt3ou+w/QQ7eRXYtYC8sf1YnE8DaTtWoPvbPt1W1dSnX0saVAj7umrAXShEHw8vSbEBQE70QVDFEWAfcLye014m6Cc4i1a0IJunO2EidyGUffX/Zav7FY44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RKJnnlB3; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-29586626fbeso33843315ad.0
        for <netdev@vger.kernel.org>; Tue, 04 Nov 2025 23:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762329357; x=1762934157; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G7v4p3X4ILgkmSzKG/xaZQHmVRIUznEUAF2qixE0ubE=;
        b=RKJnnlB3ZqxyQ416SmhjpJrA2cyFgSVkpjG/nMX1Nw0qUcKs3BNdff/96r6t//v8OR
         RHfoOycq3qZQNC03XRxcPCOI/o7npzgkLSj4ba6IxnzLJzlVQlpsmlxF2Qgs9oKbuniq
         H8N1BH53mdWsMPhGcGyMQFdCcLITnowDECwDOBTkojmQpvIn5v3WK0BYA4Jwc1ELb3b7
         Ax0j64WEh/+fvxmLU1ua2H4tu8D3UGQqzKBJ2FWSUpTh0W1NW5E44OO1D48VhIsNqmQo
         31OOdeVHpnyBDOIA+aY/y2bBZWK9WDUZoNxQ9+0UD4NLU2yhMcx4Ox54p9h+h2lWoNsW
         q2DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762329357; x=1762934157;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G7v4p3X4ILgkmSzKG/xaZQHmVRIUznEUAF2qixE0ubE=;
        b=K3zKGaWLjjLVXqhYZLEO8Pku4QgToiHT0qKgwj9wz38QCxyTpPqcvf0EybQ7jWT3bT
         zpMXRHma9TAdUjmeg8p93+xmzx5h+L9z/awms2mYnU/DdnObqBnxk5kXfCE2LZwfBLyI
         6hXgO/9FVblbo38ZIcZl4ZNInFnQZMN84klV/SyAb211OGE0HI5UBJ+gKkw40RTjuaNR
         3Gz7g7xzunIUkXT4MPix5zIcIRV6XacrZ6URuBhao2EhTqDHqdk0fYI1Lmt/JOQBYtqm
         V+5VNRy7mPnN5zSVjrwnuWmZsTYoGEtOY7r+wzOugAwNQkLq89cBeZVYs7L2Rj1CnCsj
         fpiw==
X-Gm-Message-State: AOJu0YzJFAJ1YpnS27456eqX1S+u/naFWD61hbZDG6CwQQfM0FU8Tixu
	1volA9RC/t43lyIk67Ba9cL7+9QQ4MjPhGHj12I+tQMTjm3w/uAUfdtO
X-Gm-Gg: ASbGncs/Zi0wcVGelRq2ydEBqToow39CwSPu7k5XV90tODacc3GSmf94UrWLNWEJuL/
	RXQQOWgjYlKc2i2u8o2l7RrsMEQcp2a/ymuJlDKrbLSyS7Sagv7QT4xbQx1l/fRC10PCu3tr1Ti
	l/ZdpVsu/5obTV6ngl10YtQa3K+KYxUQbLoGo8JAQoOtFFvZnVG1yY9HTKyUrnhi8w206ED2HFs
	Aii9nrRA1BpDYzNmLsaulxjLBYvaVpmU2Xo34t0zEHg51qtYPwmMQaqVXQhAraEhwfxXVCzcchX
	Ho/x0KEReLYV8Vdh07iFtbSOOtWvJ00cl7uHBpv2wmlUXP9k8vvFiBBuj9EXxduK28UkkL1t9vJ
	LSMx5OGziUmJu7huOfLexgLnHpxxpTQf0RqNB209NtAeQzeaxYvJFwRVDpfUafog0ROekzGF4SS
	eXFqDuw90y1nkBf38DrIi7r+wLxA==
X-Google-Smtp-Source: AGHT+IFORckqmpACXLUcSu5EfRyS7PDFOGfdE0/YK3mQ3vQaO+BarSBlRiLSVrcGVNLWr2Gsr5XDzw==
X-Received: by 2002:a17:902:f544:b0:250:643e:c947 with SMTP id d9443c01a7336-2962ad8857dmr35644135ad.28.1762329356844;
        Tue, 04 Nov 2025 23:55:56 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601972892sm50941165ad.23.2025.11.04.23.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 23:55:56 -0800 (PST)
Date: Wed, 5 Nov 2025 07:55:47 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jan Stancek <jstancek@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	=?iso-8859-1?Q?Asbj=F8rn_Sloth_T=F8nnesen?= <ast@fiberby.net>,
	Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan <shuah@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Guillaume Nault <gnault@redhat.com>,
	Petr Machata <petrm@nvidia.com>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next 2/3] netlink: specs: update rt-rule src/dst
 attribute types to support IPv4 addresses
Message-ID: <aQsDA7ufLlIwSf1h@fedora>
References: <20251029082245.128675-1-liuhangbin@gmail.com>
 <20251029082245.128675-3-liuhangbin@gmail.com>
 <20251029163742.3d96c18d@kernel.org>
 <aQnG8IYsY3oyYekf@fedora>
 <20251104164804.540a9b8d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251104164804.540a9b8d@kernel.org>

On Tue, Nov 04, 2025 at 04:48:04PM -0800, Jakub Kicinski wrote:
> > Hi Jakub,
> > 
> > I just realize that most of the address/src/dst in rt-addr/route are
> > dual stack. The same with FRA_DST. We can't simply change binary to u32.
> > So can we keep this u32 -> binary change?
> 
> Ah, should have looked at more context..
> Yes, and in that case without the display-hint?

The display-hint is required; otherwise, the displayed src and dst fields
appear as binary data, and setting the rule’s src/dst values also fails. I
haven’t checked the code yet, but with
  - display-hint: ipv4
the IPv6 addresses are also displayed correctly :)

Thanks
Hangbin

