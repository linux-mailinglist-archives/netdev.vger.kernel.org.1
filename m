Return-Path: <netdev+bounces-204660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F603AFBA58
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 20:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BD9A422D1B
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 18:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918F6261586;
	Mon,  7 Jul 2025 18:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7AuKPmH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381A21B4F09
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 18:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751911546; cv=none; b=i2bqntrXlR7DaDysbeFMqJ4MEIbPbP2HCVM8yiz9Yrjl+cs66BW1MjsaQ4i1ai1M4TyAssEBeXAs3MQxv5Y/RImUpXY/EN1bpDzGt+OmpS8CgJJl/q4epI2aJj/qnHHVPU8fTi1OfLblP5xj2l/AdCS/L8CFK7DM3rzeEVNVAqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751911546; c=relaxed/simple;
	bh=di8CZAbou0uqdWDUi5tFCPYICaWbs8iNl4RN4eYyxd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FXdhG/FOtCUA8RTGWhZ6sw3eQohAi3dExd3zzPjwWeJq20mKOPuAs3o1JDf7XkLWotMwPhBtZGLc6Hun+oW0aZrpfAZj54v/aTOmSaO5YAYEZJbhIeUnc+IiWIKLWDTcvsMOT1YY+ZwA/0h7tCpY2NAG5jcfb+BFKTVNmWe2IvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R7AuKPmH; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7490702fc7cso2084246b3a.1
        for <netdev@vger.kernel.org>; Mon, 07 Jul 2025 11:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751911544; x=1752516344; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U5nxiUGkdjuZyGoruQqrhn1q0CnhNyeJbJAD6um/Hv4=;
        b=R7AuKPmHlNuj772tHrAHHrCosU5pgbedHSxWpRsBWR68vRCyeqpUGJGbOnZtC7BnND
         dp/HNo1SvWdG7Py2vx4WiOs5obOYx4NguiTB6toKaPZpCOvJxR1NcFGypzrGSHhIbDIg
         wp7rTmCk52b4TOgjISuEUHAaPdZN6ThDF2s6EAAGgzYGrwLNmThAXYhq4H2QkHKB0ODe
         WkxOVchJBCdTeKVVhaELl+hjZvVeOR2UKzH78cI3EUMWF510x0VAeSjee/ea4cUjLWMy
         tZ5WQ3wyTWk1QrTT2Lxy0Rc/jOOZ14lMEjcUS2rV22NgOm82e98T8bn5BQKbOU7Q/L6u
         X0AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751911544; x=1752516344;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U5nxiUGkdjuZyGoruQqrhn1q0CnhNyeJbJAD6um/Hv4=;
        b=nGmoHD+SuUEu0o6n19oPbunWvpj+Mq6Qidc+OUrJ+Uvs2E98gC91rgrwFY89yfXgqR
         97eTQF0LwiND8PH11A6M1DgOMSLWUnyvi6QYNjJbmKVBJkQct+IF0oK3mF3tLEpwxZDh
         oDygxR/7iK0xSLfWRroYM8c9gfN0hk8lhxG62fa24biP+UPA5jNvOJcPP8nvBfxXhnNB
         pvdeM3SpMGe/zUqjbTUmq+sS/gKHUnfVx50cSt0bKGvRZ/k/leRey4wvTPCygBouANXc
         KcaJ70yu0wHDaufZXhPhFw2pXsHn4qLRuo6XttW0Ni7C1YLbCji7LEkjwICr97z8TthY
         vgmA==
X-Gm-Message-State: AOJu0Yy6OGgnbQ/eIUaiexAELl0MUsUbTcLDEsZAom/2zLVHQvH8JjGG
	206XQY8enPrveMUK232R/V41YBktOQyJfFLlV94J+bcMioqJQJAgRe11
X-Gm-Gg: ASbGncsmmtFCgo3oMeeFocbVAaYefVU2neA2q2Z25dPx9kf+jk+fi6aIfvb9BDSzAil
	bSGCHFkkqqzZsuzvzn5NAUWC/cq+YmSxHCXykaMppkW3GixUHclRTb/yivfDQFOegvfINkYsQHO
	Fx7lMSsu4BtV72xlbxPd2r8j6IScgkwlNv1UHU8Z9Ei+1poJwvviVk8q0wUN0fRX+dv9JiYFIqH
	F2oZ+vh0MRkLiC/6ghrlXf6agVASDOb+oddH9KwGCHqfzDV9pA8BWnhT7Q1LjS0uQsYxOak0A9o
	BfLc4a3AaeiA1v6vBmcnkivqoWcPNqENGcGuHZGbdS4mh+/99ZqWsRjzH7W8aLZnLa7jJcS6tis
	2
X-Google-Smtp-Source: AGHT+IHAmLFcMGatHx3iroX3dURfRUK3YnSRXSPwx4HRPqvuh1arf7xRGOgkpWYBhnsfB9n/BOUPhw==
X-Received: by 2002:a05:6a20:9187:b0:215:e43a:29b9 with SMTP id adf61e73a8af0-22b4564905emr14854637.33.1751911544397;
        Mon, 07 Jul 2025 11:05:44 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce417de1bsm9791644b3a.83.2025.07.07.11.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 11:05:43 -0700 (PDT)
Date: Mon, 7 Jul 2025 11:05:42 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Xiang Mei <xmei5@asu.edu>
Cc: netdev@vger.kernel.org, gregkh@linuxfoundation.org, jhs@mojatatu.com,
	jiri@resnulli.us, security@kernel.org
Subject: Re: [PATCH v1] net/sched: sch_qfq: Fix race condition on
 qfq_aggregate
Message-ID: <aGwMdlS0Y9R1MDsw@pop-os.localdomain>
References: <aGdevOopELhzlJvf@pop-os.localdomain>
 <20250705223958.4079242-1-xmei5@asu.edu>
 <CAPpSM+RKqRQoc7+6zgC-7O_5O73X7CK=oOWdHafB-h9OHAuEfw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPpSM+RKqRQoc7+6zgC-7O_5O73X7CK=oOWdHafB-h9OHAuEfw@mail.gmail.com>

On Sat, Jul 05, 2025 at 03:49:41PM -0700, Xiang Mei wrote:
> Hi Cong,
> 
> This is a sch_tree_lock version of the patch. I agree with your point
> that it's unusual to use sch_tree_lock for aggregation. What do you
> think about applying RCU locks on agg pointers and using
> rcu_dereference_bh?

That requires more efforts, therefore should go to -net-next.

If you have time, you are welcome to work on this and send out a patch
for -net-next.

Thanks!

