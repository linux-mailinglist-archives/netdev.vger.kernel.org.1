Return-Path: <netdev+bounces-187146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5642BAA535E
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 20:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 904757B8498
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 18:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70C6270ED5;
	Wed, 30 Apr 2025 18:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="qQAYMJC0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF47269806
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 18:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746036668; cv=none; b=BT6fOnRqzcOFJwTqqht3lwMA1Bqhokm98yB1O51IXB6pLFtE8LJ9JUdf+C2SAZTBIPxIufrTNupxRmlLjS53Ap2pcL8C2SvOJivVvF2iLRgyMWfQzkWChX+6rym4Vq6njsxeikOWrekl2lNj4SuoK4CVBRfdegJyiQ//9gMVk7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746036668; c=relaxed/simple;
	bh=DWL1vowN/b3VeSXgo1xh0uHaWIC/ef28DMSi8/xLUI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tCmKk8FKF5O/8AdgH/VjVeHpMwiteVPE9+wnrElAaMIqraf717W9Rw4oeU8qLlVfjOqzNpjO268dJZOhT+UHzTkgbMlJEuolcd6DcbF99oz6KI6ZzN+9obgAv0EJWwc9RoxWSvg4pdeV8JDbMA3pgLEbL850nkBfEu6igoDbf9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=qQAYMJC0; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-224019ad9edso2588415ad.1
        for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 11:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1746036666; x=1746641466; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O26UvXyz0SAntkpUFAlqdJt1bw1y+IBUhz9XEjTaHdw=;
        b=qQAYMJC0KDFwJjwXLNRfDF45mGoWlgATMo463AsNXYx8ZWJ5uKA5coXbiiDxftlGhv
         VhLyiM+vLFGbDOSF8kmD/6IYVAKsKPE9QaG5I1wQTc/AcfQnTgRriPv4votG+nisB6fL
         rZKB/Sb0Qu1NE1DOwGf3eDu18QnqoJYLzElUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746036666; x=1746641466;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O26UvXyz0SAntkpUFAlqdJt1bw1y+IBUhz9XEjTaHdw=;
        b=jKzh9r72bt/+W6ZpHkYOrslRb9457sy3ynjQb11GfA5mVV8JV4AEwVz9/EpV5yFu2k
         j07/w/ed77h83YicTenXKPALIfeC7epLXZKeNjE6ahbhd1NO3uT8uxLQSbmnHAX0/iby
         1tDlgGlskWlLMJnTuNn+FCSrgO9hlCsCxp7p1On2hwTs/pX8gqVNpgCeGQ66NX2FjQ4I
         ICgFqPyNnD/f3y3+IA10j1JreEgdtqIALNCt6IfX2Q+Xp3bYnZn6VxOWm3AQvobRqUII
         HhDLX2YvFBND+mH/Qo+Pv2cXhSQsKiSbUJ/Lk52c/LNP7KL241HMi3qFm5Nph7SVg2Fl
         cy8A==
X-Forwarded-Encrypted: i=1; AJvYcCVSYqJMMineaLZ6xmaaMHiY+1sNoJtSsgVQ1rAqp8EFcYUSjxX/T0nGaoMxnaUdDmDu0sWWUW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLOnltsehaVl1Hg7WumLisTzqErQjy3FWDOVmJKkRW1+eqB3dw
	OI2s8N1uCTwQx4jIJFswxGbiFJhjlBJblbh3O/OM1bbn+lLUO6Z+R9p6OqvaBOk=
X-Gm-Gg: ASbGncut1kBflaffVFDAy/XmvLztKEGrrA59Gle7oXDjHunF23jonNGNSHRhlGYXW9u
	g4MMe2Hw55p6dEfsapsfcH4FD68G3vQrkvSCI3C/J3uOrtJg4dLXzKRFCdrUp5+3QDBmQRdMlua
	RCwrlRIrit0IvYAri/23UGj5s9zx4tvm+KUOlNb1I4Y8LqsSlDz2LLhoS7YwQ1qA7GjF5gqZOWx
	mwK9RufahVTHKYkskatltOPctCyre27UGVX2jM2jpuy4x29PlhnA2t6GA1Es7L9RZtqrhxbXBat
	GvTemRPNl1vh7E/0YhvGpzi7+lGOCxmiw0e3kyA6Ow3cCdzpT52EfXTll9tkMpiwQzWduVx6Dmx
	WFZU8634=
X-Google-Smtp-Source: AGHT+IGAOOwAAb2W2jOEytol+r/HohAeqevas3rSZxZL4UbbGwgTi2TZooNlQaf1fnqf3Erca1V5gw==
X-Received: by 2002:a17:902:d590:b0:224:13a4:d61d with SMTP id d9443c01a7336-22e040c6c36mr392655ad.23.1746036666314;
        Wed, 30 Apr 2025 11:11:06 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db51026dfsm125950875ad.170.2025.04.30.11.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 11:11:05 -0700 (PDT)
Date: Wed, 30 Apr 2025 11:11:03 -0700
From: Joe Damato <jdamato@fastly.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	almasrymina@google.com, willemb@google.com, mkarsten@uwaterloo.ca,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v6] Add support to set napi threaded for
 individual napi
Message-ID: <aBJntw1WwxxFJ9e2@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	almasrymina@google.com, willemb@google.com, mkarsten@uwaterloo.ca,
	netdev@vger.kernel.org
References: <20250429222656.936279-1-skhawaja@google.com>
 <aBFnU2Gs0nRZbaKw@LQ3V64L9R2>
 <CAAywjhQZDd2rJiF35iyYqMd86zzgDbLVinfEcva0b1=6tne3Pg@mail.gmail.com>
 <aBJVi0LmwqAtQxv_@LQ3V64L9R2>
 <CAAywjhQVdYuc3NuLYNMgf90Ng_zjhFyTQRWLnPR7Mk-2MWQ2JA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAywjhQVdYuc3NuLYNMgf90Ng_zjhFyTQRWLnPR7Mk-2MWQ2JA@mail.gmail.com>

On Wed, Apr 30, 2025 at 10:54:16AM -0700, Samiullah Khawaja wrote:

> Also please note the discussion on stopping the thread I shared earlier:
> https://lore.kernel.org/netdev/CAKgT0UdjWGBrv9wOUyOxon5Sn7qSBHL5-KfByPS4uB1_TJ3WiQ@mail.gmail.com/

In the thread you linked, you'll see that Jakub said this should probably be
fixed in the future:

  Can we put a note in the commit message saying that stopping the
  threads is slightly tricky but we'll do it if someone complains?

So, this suggests, again, that this need to be fixed and Jakub
already addressed how things have changed which would make this
easier in [3]:

  > We should check the discussions we had when threaded NAPI was added.
  > I feel nothing was exposed in terms of observability so leaving the
  > thread running didn't seem all that bad back then. Stopping the NAPI
  > polling safely is not entirely trivial, we'd need to somehow grab
  > the SCHED bit like busy polling does, and then re-schedule.
  > Or have the thread figure out that it's done and exit.
  
  Actually, we ended up adding the explicit ownership bits so it may not
  be all that hard any more.. Worth trying.

So based on all of the messages in the v5 and in the past, it seems pretty
clear to me that this needs to be fixed.

[3]: https://lore.kernel.org/netdev/20250425201220.58bf25d7@kernel.org/ 

