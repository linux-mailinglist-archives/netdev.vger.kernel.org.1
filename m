Return-Path: <netdev+bounces-129828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5819866A4
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 21:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64D491C21515
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 19:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA77A13C9CF;
	Wed, 25 Sep 2024 19:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Hs+1455r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A96C126BFE
	for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 19:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727291225; cv=none; b=RreTYT/QE/eIgKlLMaN4hXc4Tz/La7oO5ukiL5AOpgG508y6n4b0hvv1D7BF5vfmrgkpcZ2kMf/57apohyk76R8P4VAAKCQBjugP1dptkaUPvp6ExWqIiBT0KDiL3bEFtvr1+8RYVsPzYB6LEo1WEP/K0Bmbke+AIPb4cwzxk8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727291225; c=relaxed/simple;
	bh=HQb1YM274AOzZp2Sgn30AN8Wzk1EM4pSx1ANcv4yvw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tgMDDR3bJfdYS9yiuIAZhlLh7SXbYlh2gszF3FM0el4MRDnwJKRjwykAfK+guEXAXlWo1v2/b4FBm0swIUEAGa1gHktOZYvjhJSRKc58tbEq7C0KHh0F06rJg+jwKbW3eC65u7gMMXrrbz0CYZFePRXmA5Kd6lWy34ZJ54uId9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Hs+1455r; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20aff65aa37so1200775ad.1
        for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 12:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727291224; x=1727896024; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TqoOFNfe7bBEKj6EDtDyUmJV1rjjnQZq2u+cU8GC21k=;
        b=Hs+1455rtvw4/fWYsvQdZ2ccuUsXxiGBCtet41WalRSTLSP9xgzn0/BPzkFKmCIhe1
         K+72767nPYFRjtvmRBZPlRyReUfiZKIhSi3S1rLPZwQdYgrrspitLcwfAKtPZBKgNKva
         cagg8UUtON0zSt7pQnDNJOFjK5CWR/rQ4as5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727291224; x=1727896024;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TqoOFNfe7bBEKj6EDtDyUmJV1rjjnQZq2u+cU8GC21k=;
        b=fYN5LQ1015gOmmqPRgUpcHo9K4wdsg7b4vntJKwK3hndZJXqrJQL2L8zAW5v/3i5+Y
         Wm9SKT5XGGO7vBc45SvuaHZ2x4+z7zWRG/vvO1z4IUryUjvd7SvbdgjE6YvPjAdqjni9
         j/Ct8UlRevijKNgzROFPfuwb+zq6Sacu263LjS5Jel2jUxn5gDAJOddqOZ9FNsH223t+
         5i0D2RPNEeHmamP49g2X0tWnwMTUZ0SpaQarcDC+TuZnmwVc2GntZ02ChxTSxifDws/d
         ez80GlV6uQOQmwuplpkLoowEm8zMULx1hz6pMJ+9L76h8+5Oo0/13s25mhlGg0Y320vl
         FSEw==
X-Forwarded-Encrypted: i=1; AJvYcCUF79WjwKAWudyn+GQEhhUzAeTDzeHIaFN9dLB1vyZdRsX+rCQQa54hPsKUAYfVfw6ZiKW+A7E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5m005Qf9T5kHOtfCd254gkQh5kJeW40WxFCHU40Zx6h+oL9Ms
	+KnH37q9k198XWUcONKzbyG0QbYyOq6AZ2nv7exlIBusnYGZ9xMTX6pXbfqNtLk=
X-Google-Smtp-Source: AGHT+IHWjn4VX8ruZmuk6eEj+O1hEWrvE2dIWj/xdpajnyugepmEbjY0HPeFa/6ejRBd3CjEB7womg==
X-Received: by 2002:a17:902:e74d:b0:20b:e45:a837 with SMTP id d9443c01a7336-20b0e45ab5cmr27760455ad.47.1727291223764;
        Wed, 25 Sep 2024 12:07:03 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7e6b7c4e33bsm3025560a12.40.2024.09.25.12.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 12:07:03 -0700 (PDT)
Date: Wed, 25 Sep 2024 12:07:00 -0700
From: Joe Damato <jdamato@fastly.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	Willem de Bruijn <willemb@google.com>,
	Jonathan Davies <jonathan.davies@nutanix.com>,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net 2/2] net: add more sanity checks to
 qdisc_pkt_len_init()
Message-ID: <ZvRfVKoPsPnPMpoW@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	Willem de Bruijn <willemb@google.com>,
	Jonathan Davies <jonathan.davies@nutanix.com>,
	eric.dumazet@gmail.com
References: <20240924150257.1059524-1-edumazet@google.com>
 <20240924150257.1059524-3-edumazet@google.com>
 <ZvRNvTdnCxzeXmse@LQ3V64L9R2>
 <CANn89iKnOEoH8hUd==FVi=P58q=Y6PG1Busc1E=GPiBTyZg1Jw@mail.gmail.com>
 <ZvRVRL6xCTIbfnAe@LQ3V64L9R2>
 <CANn89i+yDakwWW0t0ESrV4XJYjeutvtSdHj1gEJdxBS8qMEQBQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89i+yDakwWW0t0ESrV4XJYjeutvtSdHj1gEJdxBS8qMEQBQ@mail.gmail.com>

On Wed, Sep 25, 2024 at 08:55:16PM +0200, Eric Dumazet wrote:
> On Wed, Sep 25, 2024 at 8:24 PM Joe Damato <jdamato@fastly.com> wrote:
> >
> 
> >
> > > git log --oneline --grep "sanity check" | wc -l
> > > 3397
> >
> > I don't know what this means. We've done it in the past and so
> > should continue to do it in the future? OK.
> 
> This means that if they are in the changelogs, they can not be removed.
> This is immutable stuff.
> Should we zap git history because of some 'bad words' that most
> authors/committers/reviewers were not even aware of?

I never suggested that. I suggested not adding more to the
changelog and also mentioned you could feel free to ignore my
comment.

