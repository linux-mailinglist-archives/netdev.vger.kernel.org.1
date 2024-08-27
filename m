Return-Path: <netdev+bounces-122369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D120960D9C
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 16:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 900B11C221B4
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 14:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348C119DF5F;
	Tue, 27 Aug 2024 14:31:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDC81E520;
	Tue, 27 Aug 2024 14:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724769075; cv=none; b=ieZCI74JK+u5+VyUv2Xav6m3ceucnpDyrTyi2+86gjizyvv8dG/QlfPUoAzuE48DqreL9Sh3g9TjBHFQkig/O8HmoqsFNr1Vpfs+Fb+cHWzLCYNvs8uxT/xRFmb/a3yH+Ald0QYdu5m9HpmNe4ex2fYIU25FrLvWtap127RLplA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724769075; c=relaxed/simple;
	bh=m6nhO4iWbTw4iDhbUCmU18kyJNTHT5lOP8HBqVqyiSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tKlUJ5/4tu6KBlMiCAHbJd/mXkJFnfllpf+SOYY00W7s6lXsT1FN+cjw0OZh+3nrXZN4OWdmEP6kz1daLyJQHGG6QZARAagcTp63vFJ6Q+j8pCJVdGVYdVlAGB8WLAN1tOEVQDyTrytsoC7wGhfENwgml6P/wQmRcipFqvyhD5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a868b739cd9so668895566b.2;
        Tue, 27 Aug 2024 07:31:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724769072; x=1725373872;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sG23+qoWY46Jajm0s76Z+fW6MdmfN+U1Ppd3ZWTkb+w=;
        b=oGuRg9v1XDJ8WppApvqAEMc68DdEvMhH5MVHZVneM/wv0AY+y4gclo/HTM4EaLkvYF
         pRTVO06f/97hjSkvF4Xlzc6VVmcX7SFCyxUEcVAIqOsd0zmv3mr7zrN0bdMvZOScN659
         mru0rVPieNsjihHphJ4K7BaYiZlucy69ZiRx6/GUbgU2sO+hjI+mQD0FHADLlyGxdU+8
         EFqWtQ+403sGmTBQlmqRrh7Sjyl5aTVW+s2/8gzjmLQperxHllAzasRDX2EeQtsRbtsy
         g7SjiJeGhcUaI78HE6VYaqtvj+QmhKIqINu06x69dzUbqaO1h1nU4//8O9nr19yX53a3
         ccSA==
X-Forwarded-Encrypted: i=1; AJvYcCU7UkJBWDOGdgWYsPt9esqnzvJnSiN+1TdGwVtR924ard6cotPqamyIW5YHFEhSbaLwMqkQbY84@vger.kernel.org, AJvYcCWR4RTbkhzoxwOI42VlTWvuv2aKIez0/PUZ+L7yi340WhiXjjTcdvTWm0YkKJDywkh0NSlQqijkOngFMmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLh9R7EqFO0fTHRYm2hsmDB9BGXqNVYcMHLrSCz72TQNvP1OOz
	N6vVtoL1aVH1ugcXC9uGceTrhVuA4YdRIw9j5LgKyKgWZQpzYHco
X-Google-Smtp-Source: AGHT+IGxCsgsUch/iKfglrbmw5nS5bILYtm6bTHIKTk/PKJ4FiT5Cb/hWiGmV1EIfL70pjGjKD+56w==
X-Received: by 2002:a17:907:3f99:b0:a7a:3928:3529 with SMTP id a640c23a62f3a-a86e397e60fmr275905066b.13.1724769071070;
        Tue, 27 Aug 2024 07:31:11 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-000.fbsv.net. [2a03:2880:30ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e549cbedsm118241966b.62.2024.08.27.07.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 07:31:10 -0700 (PDT)
Date: Tue, 27 Aug 2024 07:31:08 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: fw@strlen.de, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, rbc@meta.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH nf-next v2 0/2] netfilter: Make IP_NF_IPTABLES_LEGACY
 selectable
Message-ID: <Zs3jLJNuGfqtpzEE@gmail.com>
References: <20240823174855.3052334-1-leitao@debian.org>
 <20240824103756.4fb39abc@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240824103756.4fb39abc@kernel.org>

On Sat, Aug 24, 2024 at 10:37:56AM -0700, Jakub Kicinski wrote:
> On Fri, 23 Aug 2024 10:48:51 -0700 Breno Leitao wrote:
> > These two patches make IP_NF_IPTABLES_LEGACY and IP6_NF_IPTABLES_LEGACY
> > Kconfigs user selectable, avoiding creating an extra dependency by
> > enabling some other config that would select IP{6}_NF_IPTABLES_LEGACY.
> 
> Resulting config in CI still differs quite a bit:

Sorry about it. I wasn't comparing the whole .config.

I will submit a next version that preserve the .config intact when
running:

 # rm -fr .config ; vng --build  --config tools/testing/selftests/net/config

Thanks,
--breno

