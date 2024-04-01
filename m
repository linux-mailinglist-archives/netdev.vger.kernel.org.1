Return-Path: <netdev+bounces-83694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49796893715
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 04:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F31B31F2169F
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 02:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569E7385;
	Mon,  1 Apr 2024 02:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XRzFfaeI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92737F
	for <netdev@vger.kernel.org>; Mon,  1 Apr 2024 02:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711939314; cv=none; b=jkvaCIdKDlHHOtNrYGFX0AssYV3IRbcCE1qbCFS6dzXh+iXjW0ZD4Q4A4Sno/EvsO5mheIrsAnT1tCJ6eucBgKbUF9c6igDzJeR6Qf+Mguh3G7yWl7a2a9qOzTN2E4tQvcfcmxLkZm9AdGsIsi2pOYxIavxw9eDr9T1URypGwec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711939314; c=relaxed/simple;
	bh=ZlRFDz0rwEINNL7l2OtL4tNYMWx3UFbDKsWl/05KEZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qDoWyerDj0KV24DCHnpeTyrgeKtYLuiKOy5w945WAnUOZ70YMBnWGuqk6PFaOLyvSgbxTiI8+AT8L1dhNa9gTauLihStBBwXclJBt4N0vGQL6cO1Ft6lybVsDoxGZGdIYAk2UizOVyHlWuru+qr5jPVkcPKHD82mT0UaynnFdUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XRzFfaeI; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-29de4e12d12so2600344a91.3
        for <netdev@vger.kernel.org>; Sun, 31 Mar 2024 19:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711939312; x=1712544112; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fZBK8EROkRYcxdsl5FONOU0dSuBeSDS3QhcopJ/WLBw=;
        b=XRzFfaeINzFW87InFbQLDkD7Lus5ZF6Fu2enzOsKlHfsGFa/1Io36MfQas2GmmoP90
         khv4kXFhGCagjVHfUKj7sFaz3phJ3YYtQ82LpOuMfmF53cB0WVd5BD63qobcmBUW3W5H
         jitRsxIWrguyRwNlKBth6bc+qJwku+KkiruF8pWAUnKzVGi0RK1jxFGsYjBF6n4kVL/z
         5fnlQ/YeMLiIKqYno6CLTnUImlaBS9lvTV8g1Cw6iv9N7y3K6ISfyQvZFXtJ95Sq8q9u
         FTijJAOR/8UfApkP0pPaMl/R2AJAA69zE37UmvWZQoCmnI2qb0ph7wB/X8E9j45257Nh
         sfcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711939312; x=1712544112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZBK8EROkRYcxdsl5FONOU0dSuBeSDS3QhcopJ/WLBw=;
        b=IxbZTleer7YxaN2S+uS7JQlAlEHvq+zIt8x831ESEP9Hbo+Ja2QCH6eGypO3vG4Asm
         kFs00xFh2yEHxZW/A9zpYArWrvgFj3bc+YKBpRr0AYvZxKTB2P9IJkVZ62RC/xDZ2zPS
         pCqewZTkpXrZu9WCiz5uDTno2ZTURetJQNmAavNONGRKd5CggnJ13uAx6oFplGOGUmQf
         M/5M2uQoZvXEVmIzsRuAeyPkuPBTghL+USQP4DRSQk5/g4qBYRqB4Z3L4e36Te/ud/4y
         Z+Ps609uar2JJ063NSta3QdyH4F4swJ6B41l/ZrV4zPrBNd68rgvTDm6jnzbnt7Ne4L5
         zXyw==
X-Gm-Message-State: AOJu0Yyk5Vdu3UpA2PbfEQ9pmXe9seWMWna7sgFOGTrVRqbM0aBo8IwN
	RsvSv/wu21AP5b8wlHt4izM4NVnmEfQZbS9F/lFbqKlBVg7Ao+IU
X-Google-Smtp-Source: AGHT+IF8pa87fsspDBSgtIVYgelZAgAN8qB6o1KxG9i18Tym3nuoElKx0RxT6mo5v8eur60Ovbr3jA==
X-Received: by 2002:a17:90a:d149:b0:29d:f1e9:a9d2 with SMTP id t9-20020a17090ad14900b0029df1e9a9d2mr5448164pjw.49.1711939312175;
        Sun, 31 Mar 2024 19:41:52 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id z2-20020a17090ab10200b0029c7963a33fsm8717439pjq.10.2024.03.31.19.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Mar 2024 19:41:51 -0700 (PDT)
Date: Mon, 1 Apr 2024 10:41:46 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Stanislav Fomichev <sdf@google.com>
Subject: Re: [PATCHv3 net-next 2/4] net: team: rename team to team_core for
 linking
Message-ID: <Zgoe6i-kf_u-_E2R@Laptop-X1>
References: <20240329082847.1902685-1-liuhangbin@gmail.com>
 <20240329082847.1902685-3-liuhangbin@gmail.com>
 <20240329150804.7189ced3@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329150804.7189ced3@kernel.org>

On Fri, Mar 29, 2024 at 03:08:04PM -0700, Jakub Kicinski wrote:
> On Fri, 29 Mar 2024 16:28:45 +0800 Hangbin Liu wrote:
> > diff --git a/Documentation/netlink/specs/team.yaml b/Documentation/netlink/specs/team.yaml
> > index 907f54c1f2e3..c13529e011c9 100644
> > --- a/Documentation/netlink/specs/team.yaml
> > +++ b/Documentation/netlink/specs/team.yaml
> > @@ -202,5 +202,3 @@ operations:
> >            attributes:
> >              - team-ifindex
> >              - list-port
> > -            - item-port
> > -            - attr-port
> 
> I think you squashed this into the wrong patch :S

Ah, my bad. I need more careful and double checks before post them...

Hangbin

