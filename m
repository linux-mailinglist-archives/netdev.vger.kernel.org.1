Return-Path: <netdev+bounces-162703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CFBA5A27AA6
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 19:56:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACE23188731A
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 18:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00555218AD6;
	Tue,  4 Feb 2025 18:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="pEGapI32"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C031218ABD
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 18:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738695367; cv=none; b=tSxScLbTgtN5tsc1M/J2BJt4hOu4hFSTHYv+Eq/D702vqHTcj3u0Vm4v15di8snpuGBIDOIDEG9Jo+kcx7ncr8gdAQnDA7heMYKyEPK2vBAOqA3RJHRfYcer9BYQG6fv805fpB67kR8knA9wvjJkoUwlsOJbNQLP5nKtYjKrXiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738695367; c=relaxed/simple;
	bh=GItdYSHhLsRD6frKk30+cPPavuQmFRytKICqT/4dBJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RuHJbL2km5Z/uy+6v1ctDPUsGJqTryLmAjAJKWa1PIWuqGDWjIILePu1pYcoeZ1KV34rjRsHnSoYvalaw5TCGcSr4g6FQW359NtyfufUtoVQjFkol3yHwoMKi5Cr4TER70Q7lQladAG+AnaGUBBTJO8XrK6mgTAZ4IDRoYN3fTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=pEGapI32; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-216728b1836so103657175ad.0
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 10:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738695365; x=1739300165; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WZhLm5+B8p+dPLbM8Xqf7pqGS67mXBcSfruMqYfEfxc=;
        b=pEGapI32ldwUa6zzXkGogK4pLQAp3XC1VxpEg8MN7g2AvBLVVHXZuodIg2Y9Cnlvwu
         JlmhEumI+z5v97rDZmWVZPA6jv+vp9mLew5Ew+P0vngt+WEf7oOoJF/PIbbd6SduLjYY
         vjtEp2+ij7lfvVEEHkfBBXUCar0aPw9cX1FXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738695365; x=1739300165;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WZhLm5+B8p+dPLbM8Xqf7pqGS67mXBcSfruMqYfEfxc=;
        b=WSJB4h6AuXeIBI0KXmvMtWBsBAxUDkqtHMRnsJRwYxe2FKRKjBM300pqO6w78b7G3y
         2D2IFMGcjf7l6O6XmbNLIRo3ciKjLZHN4XKHmNInl60UptHTDiINDVsc7UNKt/AhlnlU
         FTgas+oyIqYYIqoU5lfZfROFnpNA98Tk9zpgRMqHva5hlwWylmgWipVI2l9vielQzRWn
         126zECfF3nKxTjWRgwtEkyYerx6czvDVL6DvEFX77AMwplaHOk7m0E3KcZ+U906cv9xc
         ySqD0W5uwvVcT1wEujPq9JbY9ROLGi+/DICncym+JmRdDh5BOOjaLXY5uXmnGkHGKlma
         Vztg==
X-Gm-Message-State: AOJu0Yy2ICDQH3THiC8LuHl0XVafJgrMl4zYaM3GluUbiUUeky0GyD38
	8J9pr4+zi+U5xIcxSNkUmDcra8ur/eSAlK+eOfXtM50JujlO6xpHmqOFcKR9vMo=
X-Gm-Gg: ASbGncswlnjfQbGSX44Il71dx8jfvYZ7IN3MeUeFf30pyJg7n9Bs5X9hC3UsqJGh1ZF
	gaU5uxUZ9GCGAYAP7W0M87+LuMy8V6E6QGT14asN50Kfrt7lBBXc3o67JUYQ9V7FbsU4krNCGBY
	PRhsZWgYaq649Qi2svM4jmOO9/1Z8CoHU5V1mJrp+f01UKCxb/MiFoQQ3rqOGIKz3tYxXBMITte
	Gk8SfMZVbPZLPMMizoDebRVN4LijEo0731++Dz/ietWlKSHcBgdty/Pn4s/bxdzrygYCjKpqZlc
	9MDiH0NpuAyccB8t0wbi0qHxkQ7C42vp7opsAP7yEyvd9WdtcF3y30ORBA==
X-Google-Smtp-Source: AGHT+IHRQbkrg8ehzCZ4MmSmlHeHzAi9H0bgLV5YFw6LCdJwLx6UaFWAQniEA6o5Lr5nHKy3/k48ZQ==
X-Received: by 2002:a05:6a00:4648:b0:725:db34:6a7d with SMTP id d2e1a72fcca58-7303521c76dmr30461b3a.23.1738695364944;
        Tue, 04 Feb 2025 10:56:04 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe6a188b4sm10919199b3a.168.2025.02.04.10.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 10:56:04 -0800 (PST)
Date: Tue, 4 Feb 2025 10:56:02 -0800
From: Joe Damato <jdamato@fastly.com>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	Mina Almasry <almasrymina@google.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2] netdev-genl: Elide napi_id when not present
Message-ID: <Z6JiwvIvMSVaeM23@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	kuba@kernel.org, "David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	Mina Almasry <almasrymina@google.com>,
	open list <linux-kernel@vger.kernel.org>
References: <20250203191714.155526-1-jdamato@fastly.com>
 <CANn89i+vf5=6f8kuZKCmP66P1LWGmAj06i+NhgqpFLVR8K5bEA@mail.gmail.com>
 <Z6JcR5IH8WzH1lP9@LQ3V64L9R2>
 <CANn89iJ=8inHbr+qQKifcX=m5=TfN8+MELDM_Ho8-mdA156UPw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJ=8inHbr+qQKifcX=m5=TfN8+MELDM_Ho8-mdA156UPw@mail.gmail.com>

On Tue, Feb 04, 2025 at 07:53:51PM +0100, Eric Dumazet wrote:
> On Tue, Feb 4, 2025 at 7:28 PM Joe Damato <jdamato@fastly.com> wrote:
> >
> > On Tue, Feb 04, 2025 at 06:41:34AM +0100, Eric Dumazet wrote:
> > > On Mon, Feb 3, 2025 at 8:17 PM Joe Damato <jdamato@fastly.com> wrote:

[...]

> > >
> > > Hi Joe
> > >
> > > This might be time to add helpers, we now have these checks about
> > > MIN_NAPI_ID all around the places.
> >
> > I'm not sure what the right etiquette is; I was thinking of just
> > taking the patch you proposed below and submitting it with you as
> > the author with my Reviewed-by.
> >
> > Is that OK and if so, are you OK with the commit message?
> 
> Oh no worries, please grab the patch completely, I will add my usual
> 'Reviewed-by' tag.

OK, will do. Thanks for the guidance.

