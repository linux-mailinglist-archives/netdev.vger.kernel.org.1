Return-Path: <netdev+bounces-177989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A8EA73E13
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 19:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B419A179FDB
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 18:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED7321ABAE;
	Thu, 27 Mar 2025 18:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="b7nyekHo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CDC17A303
	for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 18:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743100828; cv=none; b=QLbL2HGLiDBqj71nhfNDwfDYqkKlpwuH8DfMQF06mjOQ2KWuikVIcUULLyr3kyPJV7sAeMRNddCMMwVmQh33I+RRW6oLuKeWWmOD2gfAD8igkconzQZ92jxHG00+nIPZCk8ZQTKgP3vE6sT4xKYJLiA8+iPKTeZgFtJagoSQBhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743100828; c=relaxed/simple;
	bh=sqO+c3zVowZ2mju9c10pCZqQWyI8ZZArQVs4ej6LI2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EMUVyLA+gZrgwME6QaUJDtcj4YO333+KIT4Fm6rXfjo2Z2yhM2UGbjkOaQdA2R1bzs77q+K5q8JOCkuWqVAOWL2kFMJxEYjWgB16i+LsnqZqW/YAjJHzmb7HklaqSBeAb2d0w8vsuMJrdaYAN0NtgFLm+FxcoQd7MBprXY+srgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=b7nyekHo; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-22435603572so28581645ad.1
        for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 11:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1743100826; x=1743705626; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N1Ltoh8eIURvRQqqha/Dr9ol27MhcX/xial0/yP3a0Q=;
        b=b7nyekHoPF4qXo0ByTPzMXm+8uZyXHe2q5lqG/ZiLofQ8sw2MPA4Tfv63O7+jFNmgX
         DvphcX1dzAw/vvTG7CbaqFjcj89/6I5dpTkjN/aB2XHW8AM1nKHS1Gef6fSSEbTe12jj
         xwYP4PC5UmoTAYEF6LV7Cz0u61X7w63/yJgTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743100826; x=1743705626;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N1Ltoh8eIURvRQqqha/Dr9ol27MhcX/xial0/yP3a0Q=;
        b=XQMEeOgEIhV2WuEfdCo93Zq7NoTEEW7e+mU2yiiV90lD4KvkZWvzSLwPQIvnoLddiz
         JV6+fFzjjicQIG2gSSDMwp3E5By4X4iKOwJRvq2ciNReX+ckLSda5cXcZF3cSReH+yp+
         KIcgRhuwcw9DoKm6ghzMrj3RxSjWUcdiUZjK0EnUnEWybkrDF3IOOQZk7Q/lfmkYOfO3
         jI6JMNZUIkA7CXzqiDE39A20MPPAw1Y1vMwV9SF7vAXDQOVINw7Je6vroUlkORoTedq6
         Gxa7YV1mwMnqJRilfkPSFtAV/PO/RtO91hK4iGNou9uPPLmI6HhXuxkj6Xss8db3Uk86
         AgbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcAZx4ujA6Dd8jI0DCyRHeqdUbTs1jZYeUGXiJq0yRyV7zbuyYV4bS6LzQms+xuyaei0AJWXY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz48f5SFkuZWw0Nk4nIEXhocyf47Z9DwvGJdt4A8ozgXUohRxJZ
	Hir+7J4tDpo6UhApQ1+1EtcoaP4xQ0dRqRsHG4X1SEYVUQ+b60+/Lxx28SvB8zA=
X-Gm-Gg: ASbGncvJ9IF82oI3Cc1iDVPsys13jEkqWHJng1gl8RScrjoy/vTkwLTVwUcAclfGPOy
	pHfmlq1d5myw34FjsTIYr1zpvOGD585VqAmwinSznkqRO45urIsgRnxtjCtpsKfPnEEc4RUXSW/
	iLQI6BxSmhnk+spY1rBNNS/yHTVOWGv5atQUZLHAFaSm14aw7jw7VFwoBpmlnKp8GDiIZh+O/+D
	yu4VgM9lIEBNOrxCuu8+xDlwsmx32aWe7Wtu7V+43uOZEuE8xtAx8kN9AIlRTAdARSsPKq3I5pw
	/AYZyQLTB5oCE/kIAOv6+3fmiVkKr5i+mvTwQJW0mXUJ0J0IWXfuuIE0+LY=
X-Google-Smtp-Source: AGHT+IHUICs9mvwZG0SZ1/YWei3wFTyTyO855NWJGkk48Uli/tP7TnIqnW0OCJGJjAc2ofO9V6mrUg==
X-Received: by 2002:a17:90b:2e4f:b0:2fe:b8ba:62e1 with SMTP id 98e67ed59e1d1-303a85c5c7amr7344278a91.28.1743100825756;
        Thu, 27 Mar 2025 11:40:25 -0700 (PDT)
Received: from LQ3V64L9R2 ([208.184.224.238])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30516d3e125sm253019a91.5.2025.03.27.11.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 11:40:25 -0700 (PDT)
Date: Thu, 27 Mar 2025 11:40:23 -0700
From: Joe Damato <jdamato@fastly.com>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Samiullah Khawaja <skhawaja@google.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	almasrymina@google.com, willemb@google.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 0/4] Add support to do threaded napi busy poll
Message-ID: <Z-Wbl6KoxKkbEemf@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Martin Karsten <mkarsten@uwaterloo.ca>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	almasrymina@google.com, willemb@google.com, netdev@vger.kernel.org
References: <20250321021521.849856-1-skhawaja@google.com>
 <451afb5a-3fed-43d4-93cc-1008dd6c028f@uwaterloo.ca>
 <CAAywjhSGp6CaHXsO5EDANPHA=wpOO2C=4819+75fLoSuFL2dHA@mail.gmail.com>
 <b35fe4bf-25d7-41cd-90c9-f68e1819cded@uwaterloo.ca>
 <CAAywjhRuJYakS4=zqtB7QzthJE+1UQfcaqT2bcj6sWPN_6Akeg@mail.gmail.com>
 <Z-R4UUzeuplbdQTy@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z-R4UUzeuplbdQTy@mini-arch>

On Wed, Mar 26, 2025 at 02:57:37PM -0700, Stanislav Fomichev wrote:
> On 03/26, Samiullah Khawaja wrote:
> > On Tue, Mar 25, 2025 at 10:47 AM Martin Karsten <mkarsten@uwaterloo.ca> wrote:
> > >
> > > On 2025-03-25 12:40, Samiullah Khawaja wrote:
> > > > On Sun, Mar 23, 2025 at 7:38 PM Martin Karsten <mkarsten@uwaterloo.ca> wrote:
> > > >>
> > > >> On 2025-03-20 22:15, Samiullah Khawaja wrote:

> > > > Nice catch. It seems a recent change broke the busy polling for AF_XDP
> > > > and there was a fix for the XDP_ZEROCOPY but the XDP_COPY remained
> > > > broken and seems in my experiments I didn't pick that up. During my
> > > > experimentation I confirmed that all experiment modes are invoking the
> > > > busypoll and not going through softirqs. I confirmed this through perf
> > > > traces. I sent out a fix for XDP_COPY busy polling here in the link
> > > > below. I will resent this for the net since the original commit has
> > > > already landed in 6.13.
> > > > https://lore.kernel.org/netdev/CAAywjhSEjaSgt7fCoiqJiMufGOi=oxa164_vTfk+3P43H60qwQ@mail.gmail.com/T/#t
> 
> In general, when sending the patches and numbers, try running everything
> against the latest net-next. Otherwise, it is very confusing to reason
> about..

I had mentioned in my previous review, but worth mentioning again...
using --base=auto when using format-patch to generate the base
commit SHA would be really useful to potentially help avoid this
problem.

