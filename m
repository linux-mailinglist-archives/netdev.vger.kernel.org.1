Return-Path: <netdev+bounces-180027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D171BA7F2A5
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 04:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA3AF1897556
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 02:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D8F199FC5;
	Tue,  8 Apr 2025 02:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="klz8euvx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E7A1DA23
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 02:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744079295; cv=none; b=pbb8YMDXdvRj2WBFxfba5FxIhZ81I+9oKpW1/adF+A8irHG5aMkZ4d8d1/UOE+n13Ixy5ivnHrcgabb9+606l2kAIU5VoagNzshEDX8KRH3ZfUyuRUqFbWqXSOL8Z//mbCKFWlmnWh7WKtmZryoazGnc0yiTHX41inj5JxN3P1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744079295; c=relaxed/simple;
	bh=LOcXy+TslI7xuCm1TJ3wgkZjOYWF/BVhXU5AXZs8/zc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=puPj5ty58Z5fjiVUxEp/BF22oqJFjRGyLRtoOlEIYNL+p+JcGWnsWPFrurQi+rMWWC+8hfkFC8PvU3zG7zxJ7+SVIA2boFHpw9W77qArUNLSJkXLIburdYoYxXB6IIdDEC93s/X5EeKa31z1EjxFMHRpRoy5UzEcI9E7WE/dGyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=klz8euvx; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so4266482b3a.0
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 19:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1744079293; x=1744684093; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Khx8xQqGqwLsCVp5u4Rdlaoz4edeU6/N3QDOrUtLDLs=;
        b=klz8euvxIpQpjsy/AYYmP2lksr1+Nv70OxdZgOLkzflnVfFZIWg2l15RocDtI7zdtj
         2FO4jV6CzWBUwx4sJjM9U72vsjragb5efVQTPa6/vlbbV+dn+NdEl8Jf98IMbF0qZ8+u
         hzGnHL6FchfCWM82fPvBe3/vrv/BTkJxlCgCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744079293; x=1744684093;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Khx8xQqGqwLsCVp5u4Rdlaoz4edeU6/N3QDOrUtLDLs=;
        b=fjGLYzCOtTlYC1RDXpv9G4c9k4oBtOQCZK9DkMVhS/ajtNO402ijc6rCblP59hp6vY
         PouFnLDP4VOHGJRdxQXs8ktS4FmaQCtpl2eVACZsc19rEcGJkpzWmMQDjPEm8bYpvG6o
         yMfmAlo7pASy0ZxdUrP575EGdlXh9Ets1qL9mgRu6+ZwUHUqE1G1OCU/+FBm0sPujGfp
         4REVb+hOSzX51CS9p3rTo1XAviBno8Ml6IRJ/VvrSV+75EWjnP3dR8Sf0SfzKvofVZr7
         oi4r1jC8NnEcNGbVl/ccMKzX7U+/21VKeUgW9tqBJYPFsSwFUHoc4crkGTm6qk4zR2aF
         1pmg==
X-Forwarded-Encrypted: i=1; AJvYcCWFbblA/auFcBhpf2wJtxIu/kZyHu2NnoCV1QA+AIdImkAoSJZZ5DhLTbry5ntdCyJ8Gwj44RQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuqYuApJbjbjivS3rLpgt1xh8Fu8+4UvZ8a6fR3lZbgZTgTmRQ
	gR98x7ZrF1wWAKCzAreDAQxkpeSuijKk/bne8Oe8ieWDQLST58p09r43JBf1ii0=
X-Gm-Gg: ASbGncuZcraXDNCIf7XlL4qEZX7e2kI55GXuVL4mAkyiwXoAqpKnqUWsYonpETvCdkf
	nNSJlGYhebMUf2RbZH9V/MQF0ztdrMS8hyurdDCkwXtNhaD6i/ae/WT3hH5FgdVdnZmjl8gEDpo
	6n2ZRIqnM2y+87Wo0VEBzKVZi+cUBt3LorawVhiMdo164Ix/QNJ5lOXnTCNUC9G4+qR0j7LSVdw
	tpQq/YqCKnF+HqZDxlGs4gRRlA3ax9Ncsu4W1f8v9yeWdlVO8TFcUvUY1iPjntZlKMrk6RU9lkf
	88ARuMdPXqXj07zje1yFDmXqCZpEGFBDAScVBPTyC6Mz53Dqs1Y3Nq1IEwwBkTlbhHo7q0t1Krn
	90WR4qh2wr58=
X-Google-Smtp-Source: AGHT+IFkTkfSS7nzcnvAMunAOXjuvXeAUPtSjtBgUjWPloju4C0SHQ8XMPY4EouBrDQRrBOtu8YxQg==
X-Received: by 2002:a05:6a21:338b:b0:1fe:90c5:7cfb with SMTP id adf61e73a8af0-20113d27956mr15129094637.27.1744079293233;
        Mon, 07 Apr 2025 19:28:13 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739d97f3708sm9533813b3a.62.2025.04.07.19.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 19:28:12 -0700 (PDT)
Date: Mon, 7 Apr 2025 19:28:10 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	sdf@fomichev.me, hramamurthy@google.com, kuniyu@amazon.com
Subject: Re: [PATCH net-next 4/8] netdev: don't hold rtnl_lock over nl queue
 info get when possible
Message-ID: <Z_SJupHRfAAGLe-P@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, sdf@fomichev.me,
	hramamurthy@google.com, kuniyu@amazon.com
References: <20250407190117.16528-1-kuba@kernel.org>
 <20250407190117.16528-5-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407190117.16528-5-kuba@kernel.org>

On Mon, Apr 07, 2025 at 12:01:13PM -0700, Jakub Kicinski wrote:
> Netdev queue dump accesses: NAPI, memory providers, XSk pointers.
> All three are "ops protected" now, switch to the op compat locking.
> rtnl lock does not have to be taken for "ops locked" devices.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  net/core/netdev-genl.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)

Reviewed-by: Joe Damato <jdamato@fastly.com>

