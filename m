Return-Path: <netdev+bounces-157918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5A0A0C4CE
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 23:36:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6D9E3A68BC
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 22:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99781CEEB4;
	Mon, 13 Jan 2025 22:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="eCC/GgNA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435261E572F
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 22:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736807800; cv=none; b=NB42yD0ExZA6jzwjj4Unx1UT99zaaU9MQbYzvvJ1vcE8txMqP9ygJX+nD8RWp1kHblQ+kKfC2X74GVQ82+xZlbCNbugWnKWB7SWdeK0dwgaHbXrrAmBX4VZuaGbvtu7xF2JGkly51GYqwaJQ51Fa3gn22cqKbSUBqfev16aOwYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736807800; c=relaxed/simple;
	bh=9SR7vcS8B5h+PYLLSEhJhCdGfpu0OTgltdF73F2+NtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m8xUctdfhq/Ne2bd8so9RQsDibThnIB7wlnfe3s/EQK0KfhZMCZ78BPVaWlEEd658BOkJZk0tNrtm1aYM4Y85KILTOY8/AlZb8fQIeVa17pFKOl7WaeZygc/brXb085NLGoTmBKZTAQ/EJAasf2BER2TLv4mRqsMIgRYXWwAgJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=eCC/GgNA; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-21654fdd5daso82081275ad.1
        for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 14:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1736807798; x=1737412598; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fAuEFnTGIGKNLJ/+VElR82ZjfYlASQtpd5BqQly9RxE=;
        b=eCC/GgNAxlgM8FPmEEFyQ+y1SQak5i63ikJ1Dz2U9aAKqAAM2uTgYT4sjYRPebAmH+
         PzjlEiLnFmGzcudHFHZOh+xEqoP2nWZUn2Dd32nCVtiXFfHh5iNu+Hc06ph48Vt2sfkK
         D1MVlLAvIWc6sbW3G5XkryeLJwv2mqfciV6Ts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736807798; x=1737412598;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fAuEFnTGIGKNLJ/+VElR82ZjfYlASQtpd5BqQly9RxE=;
        b=VVD9qnYVEM0pshKuHzWohlxKoNtD0TIKEa7dqeo8WbG7TS29Q8EnrA1XkWpVQKsxvL
         CmmNL34eTiD0snCC1Lo4njZ3EIxIKHufAehAR/5yrb/kztG9WGFD5D0mWZi3SD74KwrK
         YjrZhgUyE1iPEHnS7D83LdsKB3EXyjGKfDddaGjV/Tq9Poq7y5YL7atOj1hFnYY/4a/5
         cBBlug+jgo1elY+/4sBAwQE9pM7s5qIOmOvNHwNDdaEix7qXx3ou+DOv94iDMmui1Amm
         TZsePHR2zY3V23C+xhj7+tr6J7zwTElHB6aM8eA59Ryeq8XyZH9se4rGuEcYKDK3ywqK
         FGMg==
X-Forwarded-Encrypted: i=1; AJvYcCUciZEFTjip8IuJo69Fe/YboLHuROn1WA5lPoZE/HWw2WXRpeTP+kl9WpJPynFjlzRygDsBen0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrCZDV8BAo+WaHJ+cgSPJaTZg8h8uxnG95D98y9q1fT1ff0Rpu
	flh3PIbZxOFf/83l/DnMLTflc4wqZpJJuu19pPebw/s5l72DLC2qgJ3aFQl+LNM=
X-Gm-Gg: ASbGncv3/BIjQ4NPUY/ouEUjDtPl5MxnldiSHa2G4KEb5atL4sEe+jBDvYM+6onY9/k
	GFy+nDTvkHWVArXRkbnoH8dobH3dv11pMPjCDNR8onf9ZusGvSwJakMLqhdLIKKpHi4Wfre146p
	iyBXbvqwhe6iIyj1ReAAZoh7mu57L4W7MSVVrV9a8xD3dgRpQcCe89eGgDLaEWWdc0iHyuaD+bp
	RhhBaely6MgnuTo56sF8AuAfOGZOHtYdx7oJ4eg/mCBJdJ5tle6dkz1+2icjGVGrvRTGzb70HHq
	mEt0opovY7svWRC50pIjcuM=
X-Google-Smtp-Source: AGHT+IFi3zHEG8+mHeLMQnIF0agAlRlP4URjl9MXFjr93uOSBwzPzS/NZEKJ8GMG9wEVBCq1Q9nGMg==
X-Received: by 2002:a05:6a20:c88d:b0:1dc:e8d:c8f0 with SMTP id adf61e73a8af0-1e88d0bfd48mr37648469637.29.1736807798510;
        Mon, 13 Jan 2025 14:36:38 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d40681065sm6563545b3a.146.2025.01.13.14.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 14:36:38 -0800 (PST)
Date: Mon, 13 Jan 2025 14:36:35 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Gerhard Engleder <gerhard@engleder-embedded.com>,
	magnus.karlsson@intel.com, andrew@lunn.ch, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] tsnep: Link queues to NAPIs
Message-ID: <Z4WVc_PzmCDagWFy@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Gerhard Engleder <gerhard@engleder-embedded.com>,
	magnus.karlsson@intel.com, andrew@lunn.ch, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org
References: <20250110223939.37490-1-gerhard@engleder-embedded.com>
 <Z4VwrhhXU4uKqYGR@LQ3V64L9R2>
 <91fc249e-c11a-47a1-aafe-fef833c3bafa@engleder-embedded.com>
 <Z4WKHnDG9VSMe5OD@LQ3V64L9R2>
 <20250113135609.13883897@kernel.org>
 <Z4WRyI-_f9J4wPVL@LQ3V64L9R2>
 <20250113143109.60afa59a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113143109.60afa59a@kernel.org>

On Mon, Jan 13, 2025 at 02:31:09PM -0800, Jakub Kicinski wrote:
> On Mon, 13 Jan 2025 14:20:56 -0800 Joe Damato wrote:
> > > XDP and AF_XDP are different things. The XDP part of AF_XDP is to some
> > > extent for advertising purposes :) If memory serves me well:
> > > 
> > > XDP Tx -> these are additional queues automatically allocated for
> > >           in-kernel XDP, allocated when XDP is attached on Rx.
> > >           These should _not_ be listed in netlink queue, or NAPI;
> > >           IOW should not be linked to NAPI instances.
> > > XDP Rx -> is not a thing, XDP attaches to stack queues, there are no
> > >           dedicated XDP Rx queues
> > > AF_XDP -> AF_XDP "takes over" stack queues. It's a bit of a gray area.
> > >           I don't recall if we made a call on these being linked, but
> > >           they could probably be listed like devmem as a queue with
> > >           an extra attribute, not a completely separate queue type.  
> > 
> > Sorry to be an annoyance, but could this be added to docs somewhere?
> > 
> > I think I did the AF_XDP case I did two different ways; exported for
> > mlx5, but (iiuc) not exporter for igc.
> 
> Yes, I think netdev.yaml is the best place to document the meaning of
> rx and tx queue type. Are you going to take a stab at it?

I'll give it a try, why not.

> > I don't want to hijack Gerhard's thread; maybe I should start a new
> > thread to double check that the drivers I modified are right?
> 
> Ideally we'd have a test for this. How is your Python?
> tools/testing/selftests/drivers/net/queues.py

Good idea. My python is non-existent, but since I'm the one who
submit all the driver patches...

