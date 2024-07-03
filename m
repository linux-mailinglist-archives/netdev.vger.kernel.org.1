Return-Path: <netdev+bounces-108752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12EAC92532A
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 07:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71C3528A349
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 05:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6C949641;
	Wed,  3 Jul 2024 05:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="AZlJETt3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3D6C2F2
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 05:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719985813; cv=none; b=bvMTqe77xBU8sm6wAtpnIUJNvnpko3KsJtUsHbUJmqUkTCf8gPH/d812gbtVRqLCsTOijDtWTX298foBvb/OSPU3FgIpZmgbt74/Hbmre/DOmvZKs2pmbqkBmOJHogdlwxF7M54VV7Jx8gbWWlGcRHdSkyLx2sUbfySW6rHhZew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719985813; c=relaxed/simple;
	bh=acTW0/kBCsnpdMbl8++jAAFAOZp52xMnqY2t13vpoUM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qnGt1aQBCaY03Rx/QxbadLLpBeBTiKDqni46Xh3hp7CS9rK9G0TkmZNzhO949FT26N9UPvu/OxUW+gCmsfHitXmy/bmTQUvLMwN+FDOZ7PQlLob8CWATXdKpkne85kpxhzCbHjHXIqKY6X6qC1qdyK1R/N7aqsbhW0PxXlg/1hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=AZlJETt3; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70a078edb8aso200299b3a.1
        for <netdev@vger.kernel.org>; Tue, 02 Jul 2024 22:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1719985810; x=1720590610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OtXRsO3ABIH1xguC/+WmLwv74N1+Hb8hKREtjoV46Kk=;
        b=AZlJETt3cePGUhezjebpS9Ciug0Vs2304ML9l9bFC+dxTxRmYnXMUXr0G70/ctY86w
         0h3iEzdpl6miWskJBLcVU+/+CYVNVlMYrw0UPmsGf1HteXdIA2CufJp6jg2CYDHv+9dR
         TmELpuv8iTHzagRyVmJAJjhpMQy/RgEdKplIs+RoZ9VErq8gTHmhqxeJpuVd6q0WcIWH
         zBJNos/Ywaq8H3pXfum6SnV9slFwrSyH+GTrNFvi3CJYJH3A3D7CBdEXlOupJD60aatg
         DpZcV5kFnB+lY00KOlyjj3E7d39VPMa5E7ro6mE/o7JM4H4TNRb7YkuFah0Mwfl48RoW
         +HYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719985810; x=1720590610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OtXRsO3ABIH1xguC/+WmLwv74N1+Hb8hKREtjoV46Kk=;
        b=PjL7amyMGdTJhOwB4oNP/TohQ1UsbEMeSKewaFK4QkKUT423WIFPaF+xjpayDX5SX6
         DKgWdaQJ9R+fav5zhgMIvEbtHpyD83MktxExhg/Hx6XrtFaF7BJ5H7+mbuEaft76Df8K
         eIlOp5BYUFmvIKMx9AQ+cbAz++SCiPr0i/zNC4Y2RI8T/C/S0xdDxo4L+ZpnqZvemocu
         I9H7xjAXwcyt33OKskAU9yL+6LPGtCPvzl+N9huCtZndFk/nJQ8gjsI31PjEdh9TAyPv
         tRu1ftwpL9l9MxWCSE1xQaAQlM+40Ct51I0/Z/YZB9xJfPyvq6SrjaXYBQ6edc0ufFF+
         gKLw==
X-Gm-Message-State: AOJu0YxQwxwlevfCY2YoskKUIfZ1Jwxa/puMXBIS2jhEKtT9UbRI79II
	nz6dJ/aj+Te3G2HkANv3j6vNbevdqdSSEucTZC8ISbe38JwTuqxtW2nwhFOTfs+CM7jXEjaKtrB
	i21c=
X-Google-Smtp-Source: AGHT+IEjyMsViZbi7s/QgjIL9VfJ2c9GBrZVFWC5WeVr9Tsvi/DWcOVTtxQgVGoMm62vMO5UhKO3ZQ==
X-Received: by 2002:a62:ab11:0:b0:706:1bfd:4e8e with SMTP id d2e1a72fcca58-70aeb3ebce8mr1089552b3a.0.1719985810197;
        Tue, 02 Jul 2024 22:50:10 -0700 (PDT)
Received: from hermes.local ([84.39.151.145])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70801f5a2e3sm9525885b3a.21.2024.07.02.22.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 22:50:10 -0700 (PDT)
Date: Tue, 2 Jul 2024 22:50:07 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Muggeridge, Matt" <matt.muggeridge2@hpe.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: "ip route show dev enp0s9" does not show all routes for enp0s9
Message-ID: <20240702225007.33b0fe3b@hermes.local>
In-Reply-To: <SJ0PR84MB2088D9C951AF8B39C631950DD8DD2@SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM>
References: <SJ0PR84MB2088D9C951AF8B39C631950DD8DD2@SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Jul 2024 04:00:44 +0000
"Muggeridge, Matt" <matt.muggeridge2@hpe.com> wrote:

> > On Sun, Jun 30, 2024 at 09:23:08AM -0700, Stephen Hemminger wrote:  
> > >  Good catch, original code did not handle multipath in filtering.
> > >  
> > >  Suggest moving the loop into helper function for clarity  
> > 
> > Thanks, looks good. Do you want to submit it?
> > 
> > You can add:
> > 
> > Reviewed-by: Ido Schimmel mailto:idosch@nvidia.com  
> 
> Just wondering which repo this will find its way into.  I sleuthed
> your repos and the iproute2 repo but could not find it.
> 
> Thanks,
> Matt.
> 
> 

It would go in iproute2 but was not an official patch since it was not
tested. Since you are doing multipath routing, could you please make sure
it works.

Suppose a test with dummy devices is possible, but somewhat artificial

