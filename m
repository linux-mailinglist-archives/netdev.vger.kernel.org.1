Return-Path: <netdev+bounces-199581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D05FDAE0CB6
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 20:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A12266A1AD5
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 18:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0496D2980A2;
	Thu, 19 Jun 2025 18:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EmevkanV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C2030E85C
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 18:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750356716; cv=none; b=LOcBfClMDkYkzB7QucTktt66eDU38mwir8qmeYRoQQYdlvbHWluAVhlUTfnp+5FRW4I0aQBQ29Q29UFVttIKUkpWzw5Mz4KSk++C2okaz590X2LYVRxNc+atvJHwJwcFdd+0a9NRygqa861tbms1u9sOglIlQ0sWDXffBFvsawA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750356716; c=relaxed/simple;
	bh=vQO5NXx9YhUvfonXiIHAH8of64qG4w8OyACLr3BTsGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qbd/I4vL3EAFzHPuhwDkZZFsa0nmjz6Jb6iDwOTfxfDSNO+ADk4u7uTBuuq2UliiNvgx4qS5wWZKwBjux4Hks04F/gkpWKcMtSpWsR+JMSL0HA9asBjvIylbSjOF2YxpDwzDazdQL6oa5O3OeWlMZZY/7g/Q0b3ZkpmoNFq2BJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EmevkanV; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-73972a54919so757214b3a.3
        for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 11:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750356715; x=1750961515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OgXokqbyvcTuMWjdghs+W/s3FB7a8coLtFefPlkipNc=;
        b=EmevkanVgV9uQwsTcMQFLZnLRcnP44tw9q/AlRtamLuvzg7Pc272vEAPnij7lrZ3sC
         E1T7Rf2sAxWAA3/TkXPSXyXcE1b0fyPm+xiEmwz5bFS30iLgFPb/jFD3MhAcf/iWiHFu
         EtCfC3MJDIMT3IwC/lrjPhtAJ6xtXnvcwvODjpPS5/Q5YOPT2kDBEY3a0X2XkVODquD5
         KkeGm8tstEpp/KMF3k9RI1p4Pv/FjXQkUxUx9eCoo1vO66O1NdIl/G/qY4X7ybbsxnZG
         Wa45pWX7zgH47Bp7lPMgXItyU5hXN8OTeFat2ilMjGwWkzU4oIL+ekAGJmSHkiocJIjk
         ZWuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750356715; x=1750961515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OgXokqbyvcTuMWjdghs+W/s3FB7a8coLtFefPlkipNc=;
        b=T1QsVgFvA/XyEcHc9s184FcaSbzSw9xBz8oMttzXEWT3wvAK0e0an/kFcW9tLHukHj
         +e8ZIVS/vzF/q4u7pK2LUN2UdJFlc41JDZjPXIEPiXxNLpZXv4+gHn783AEkz8EL/rx+
         I6nn/Bk0jox0FekHBeUtOJ6Oc5Sw0Ia5ucf4QoM6wAqbbmv/CeddNZMj/sY55mItmy5C
         U5Z+SMsmy5V9HiSQ4qK9rOAlO/gUa/xcu7QfdxFI9i3SWNqdAv1zThjW9Z/BZwYDFZD0
         PcJfIaKHkm5arl80RlNtvwLu6cvXOSTJ6OnpeUgO9PJmXAkqEFYC+vSQreG5/zrxDMTy
         vRdA==
X-Forwarded-Encrypted: i=1; AJvYcCVEHNxX1jFyajlKcriboE54YJL0f+G6YPZDp/X3sd73ueh4NBrddG3cGdLXEjTh+AvUmvFZmbk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsjhZ6AZeAA1xU7nJK+kcy0gmn2tFexZCXacDNImG4XR119+kr
	ZiEqnjQrifFh+BujYhzMHtkosnQXEtayNqMwdIdN91LOGB4S+P6ub9o=
X-Gm-Gg: ASbGncsS0BfH+GXjKcNsmIOqC0cIcv6/ThVJpRgsFLYoGACmHmfCTVLXSBitsigwtLJ
	2Qjm95pCrU4ETlPvI/dy6uf7COT4CCyFxd4B4tpfSPlzsvNOEIvUNbWL0GOCcVyRNpiTC/cEmsv
	5gAOUJj4Crzmn9yqYBPqhgHdChG2jOiYp/mC/gWpQZe/P4mQB1/hW6cyv3Y3TO3FkZPcD15pdoK
	KHgjxwYc2ZxD1VoAa5v14bJDZLV5KxH4T513QN4xbOnaX5hVltAyLp9fJBKm/h+ZZ7iuoAU3Zl2
	6Jjea7d3+KRbgkAUYodjcBwmktvlnM+Hd3ab5OE=
X-Google-Smtp-Source: AGHT+IHIXQhGEPKYQoWKvIHGqAiuZ6OvL6F1idcMHy0iHGU39vSB4CmicgGn7UCBwdoN4er9rkOJUA==
X-Received: by 2002:a05:6a20:d04c:b0:215:e818:9fda with SMTP id adf61e73a8af0-21fbd67f904mr32755400637.27.1750356714637;
        Thu, 19 Jun 2025 11:11:54 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7490a46abc3sm373984b3a.14.2025.06.19.11.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 11:11:53 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: pabeni@redhat.com
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	kuni1840@gmail.com,
	kuniyu@google.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH v1 net-next 02/15] ipv6: mcast: Replace locking comments with lockdep annotations.
Date: Thu, 19 Jun 2025 11:11:44 -0700
Message-ID: <20250619181152.1621004-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <7f2ac806-d033-44de-9241-e5a3194dd729@redhat.com>
References: <7f2ac806-d033-44de-9241-e5a3194dd729@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paolo Abeni <pabeni@redhat.com>
Date: Thu, 19 Jun 2025 13:56:26 +0200
> On 6/17/25 1:28 AM, Kuniyuki Iwashima wrote:
> > @@ -2072,10 +2086,7 @@ static void mld_send_report(struct inet6_dev *idev, struct ifmcaddr6 *pmc)
> >  		mld_sendpack(skb);
> >  }
> >  
> > -/*
> > - * remove zero-count source records from a source filter list
> > - * called with mc_lock
> > - */
> > +/* remove zero-count source records from a source filter list */
> >  static void mld_clear_zeros(struct ip6_sf_list __rcu **ppsf, struct inet6_dev *idev)
> >  {
> >  	struct ip6_sf_list *psf_prev, *psf_next, *psf;
> > @@ -2099,7 +2110,6 @@ static void mld_clear_zeros(struct ip6_sf_list __rcu **ppsf, struct inet6_dev *i
> >  	}
> >  }
> >  
> > -/* called with mc_lock */
> >  static void mld_send_cr(struct inet6_dev *idev)
> >  {
> >  	struct ifmcaddr6 *pmc, *pmc_prev, *pmc_next;
> 
> Why are you not adding the annotation in the above 2 places? AFAICS
> mld_send_cr() is called only by mld_ifc_work(), after acquiring the
> relevant lock, and mld_clear_zeros() is only called by mld_send_cr(),
> still under the same lock.

The two functions use mc_dereference() at the entrance,

static void mld_clear_zeros(struct ip6_sf_list __rcu **ppsf, struct inet6_dev *idev)
{
	struct ip6_sf_list *psf_prev, *psf_next, *psf;

	psf_prev = NULL;
	for (psf = mc_dereference(*ppsf, idev);

and I thought it would be redundant like

	ASSERT_RTNL();

	ptr = rtnl_dereference()

