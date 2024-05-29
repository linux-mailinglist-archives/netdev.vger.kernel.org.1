Return-Path: <netdev+bounces-99174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 678FD8D3EC7
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 21:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEB9C282C3A
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 19:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE33187332;
	Wed, 29 May 2024 19:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="dtZttDWi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D135C15D5B9
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 19:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717009662; cv=none; b=Y2ocqgwbM55KS3XmP0zucnRSvy3yr0ip39rspFaZH54Mgi/GoDZUYiKVMu9TtCV6r0WfD7XJPQpJZQfXvUHXbbUS0u1h/mZlI1bq19qht//6JpsrZIfAqveVitpnOuvO/Ahgxeaf2hsaLJgToTklvlZoHzwBf4x3i9RmxieeUhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717009662; c=relaxed/simple;
	bh=GbqbrXOgB+dV/1cs5LgVzL55647SBoad7qia0Wmckno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PP+tR2AmGqDa1OthhF9DWWvP8EchihMFAchtPEv3g1r42XCezUM4JJ2azxJWd/kPxgp/eH4qWSM3zTx6LVKnBjfLC5oIHjXrPSex6a1lclyewcGrzi3xzHlbuDc/DzpcQyZRYkcSJjjH537/qx7Wclinl1gPlU1yV4Mhos1RjM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=dtZttDWi; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f44b594deeso635215ad.2
        for <netdev@vger.kernel.org>; Wed, 29 May 2024 12:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1717009660; x=1717614460; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qAL64kLDiXuHNqNC5S8RmKMt8Tv5YCg/9aXJq9BvE/Q=;
        b=dtZttDWiDe7M4fwsi8eRASW2FbYqn9FvdlblNIxnsbkOvV9uDHmLTKD6s30BpiSMLA
         +0l6zQ+d/7FE5OdZJLGIBAQI9trw05jN8tho55xQmt8PMr8I4oUVTbNTNJOXCcJ90OU0
         SBrgCl62HFGAjd+jaNY6r8wlb6wZPSkA4iU7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717009660; x=1717614460;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qAL64kLDiXuHNqNC5S8RmKMt8Tv5YCg/9aXJq9BvE/Q=;
        b=hQ3r2hhj/weftKEuVoWusf0bxOcp1PInYunEhOn92eTAKOpZcpuUq+Dp+7l4m5XpzI
         qhcmJRu6CdqOSJ4Bfkpa7LgYkIf/laXrQsO1PP+6J+8cOtLHXhFBlSiPycr7EsZwUQEv
         EVRp/osOjYFOdg+U++B4x9yeCeMzhRwi0hAj7If/o2Q5117l/u2siNqpC4Wx56vpAews
         zs5VVhQjuY5IRvGScf3BBfjuFma7dNLgLBapxYfoD+ArqprbqUgnd49UnlmDkcyUbUcz
         M1II9U5CXAaTjlWSZ3B7DwhqVt8+lFDYNbS0590vcIA6uM7xNRbt/mHjQVR66w49ObGC
         cvnA==
X-Forwarded-Encrypted: i=1; AJvYcCWoakj2jIojd0Fmk7zPmav3oaT8R26CP7IIgT8+BVJ10hyfmyfdv3uPlK/03hkbl2hdMIPuYq3uU3k1apChKnzbECbn7/gh
X-Gm-Message-State: AOJu0YyAqkJ52UA8kg8g+NZgtKy0MtshnhDlwTX8qVI5LBmuUnF/VhFT
	5ie1NGr8AYFPDmmk9N/p+TN6H5KRfee2ipAKK2TREQhafbFbsWldgqDrveTLUXA=
X-Google-Smtp-Source: AGHT+IH8rD9CmBQ+DDRAY0qTd2kqwPoaW3O/fLc+Vg8ZTnn+fVFCHDg4VEQ2iZiLnbuCa5dE+8oWtA==
X-Received: by 2002:a17:903:41d2:b0:1f4:f02f:cb14 with SMTP id d9443c01a7336-1f4f02fcbedmr22785225ad.47.1717009660017;
        Wed, 29 May 2024 12:07:40 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c992a0asm102989855ad.197.2024.05.29.12.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 12:07:39 -0700 (PDT)
Date: Wed, 29 May 2024 12:07:37 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, donald.hunter@gmail.com, sdf@google.com,
	amritha.nambiar@intel.com, hawk@kernel.org,
	sridhar.samudrala@intel.com
Subject: Re: [PATCH net] netdev: add qstat for csum complete
Message-ID: <Zld8-aZ5JOMVTKY3@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	donald.hunter@gmail.com, sdf@google.com, amritha.nambiar@intel.com,
	hawk@kernel.org, sridhar.samudrala@intel.com
References: <20240529163547.3693194-1-kuba@kernel.org>
 <ZldytYTJEU8yAJqA@LQ3V64L9R2>
 <20240529115736.7b83c0f3@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529115736.7b83c0f3@kernel.org>

On Wed, May 29, 2024 at 11:57:36AM -0700, Jakub Kicinski wrote:
> On Wed, 29 May 2024 11:23:49 -0700 Joe Damato wrote:
> > Are you planning to submit a separate change to add csum_complete to
> > struct netdev_queue_stats_rx, as well? Just wanted to double check,
> > but I assume that is a net-next thing.
> 
> I figured we can add the handling with the first user. I can, unless
> you're already planning to add more counters yourself once the base 
> set is merged.

Sure, adding with the first user makes sense to me.

On my side: I honestly have no idea how close or far away I am from
landing the mlx5 qstats stuff, but if I do somehow get that in, I
would be fine adding the extra stats at that point.

Hoping the RFCv3 I have out now is closer/almost there.

