Return-Path: <netdev+bounces-120711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F90295A5C1
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 22:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D29841C2194D
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 20:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3CED16F267;
	Wed, 21 Aug 2024 20:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1cw9GPp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BB528DCB
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 20:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724271676; cv=none; b=CLuLNonLiuu4eQHLf2wdyLprgKtXLTFituDlB79QZZ1RRJpZ7ZZLBkhHDqTx0coMflqzoE9DKoB61jPDR47YCxna33neaLEA3E5YzYBI5kVFn7qE6ZazAKOqFbCpdaDQl9AxPqEtatQjtj42myYt1DJMyNC3oPxdyb4Tlp0Dl7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724271676; c=relaxed/simple;
	bh=8pmbY/TEIBNgZWruoDmxHjyGE7/X4xNgrdNDNCHMfQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VSc5TT6CdJ22RGjGverkefPhE+oHXlDQC7A14hR/7a/Z0QABeieySUpul7FeKP+zumfzokbuGM4novzyaOlHf88brm0oSHeUqW1/ZFQIJKvCG7P7o2nD7VqJ+AIs14NBJ02WAiWUTYOLsDrURNG5l762i3KHb4yV4bl6J1YB0PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S1cw9GPp; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5bec23c0ba8so13942a12.2
        for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 13:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724271673; x=1724876473; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8pmbY/TEIBNgZWruoDmxHjyGE7/X4xNgrdNDNCHMfQY=;
        b=S1cw9GPp1jnLoK8KOc+wJm7EOXp36bNu+Dg7PAZ7B0n3vjHN0i8jETMzrrnklPyL/n
         yjr/0bcpzGCZPQ0TY4Xx3lv5lclRpyfnPN0Z6bt9FmjTsMbL2CZng8sUgB9D1vKxqi7o
         XlP3Za39OoLNkGm0G3Rw0sQAdJz6GBN7tRQ1Ii+dYlvmOFLl4dwD3a8hGwzcwpAe+SNO
         ybPIX5656xnELRVnJtULG/WW9iVa3MQaE1XzWo+owmUJDLYoLYdNEudkGPjdIm0G25cS
         lamLXhR76b5m3fIHAGBV/KrLj7NOEsU5FAlVYokeTwLQN4Rhqv0Rlfu0k1+QBtB98zKe
         KPZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724271673; x=1724876473;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8pmbY/TEIBNgZWruoDmxHjyGE7/X4xNgrdNDNCHMfQY=;
        b=QhxyEbzuLRoKlRM/a7vSvcIWZ47nLZuEjFoyS/QWWw5SGvcaSh94VPV6OkMKM1G8FH
         6U5PU/F6eW1LBoecKjwD0+Ra12pr41BC84NncuXlnpr9bGjopUvePAr6trnhipsG5h2n
         9n8YN6YchyRoJyroTmB7bW07N7YQdG2Bd3or0L+pWroEnqr6mmBzHNpwXveolD/3qa3T
         BwRdcNnbNWVAtHNSCkfWVbNPttbpIvB0FqOrH7AMGRoKzFM0RB2E65aW4qKA8AMuhgy5
         rSJ7mJACOMEV90O9sK+Mm0G7CBu757lWz6IXu1APJULnclLvU34Few57E0llxyWCUI3K
         Dbtw==
X-Gm-Message-State: AOJu0YwN5F46Vy6M26+bnzrcM/qiLpFqgaRlaHitEtcmg0cv0ksgh5L4
	X/H2Jnp4QyVDQAGseNYA0JNMsYJSsmOZYk8/PzT7RMgqoa1FnQT6
X-Google-Smtp-Source: AGHT+IHQYC1qxXpz6Mo8sw5VFVUG9CHEGBTVxvnA7s4f+pq/EcP0cyCBfJHrelyT3dtFrUwzKZLVBA==
X-Received: by 2002:a05:6402:40c4:b0:5a1:1ce3:9b58 with SMTP id 4fb4d7f45d1cf-5bf1efae7c1mr1200380a12.0.1724271673039;
        Wed, 21 Aug 2024 13:21:13 -0700 (PDT)
Received: from skbuf ([188.25.134.29])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c044ddc0d0sm7688a12.10.2024.08.21.13.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 13:21:12 -0700 (PDT)
Date: Wed, 21 Aug 2024 23:21:10 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: lib/packing.c behaving weird if buffer length is not multiple of
 4 with QUIRK_LSW32_IS_FIRST
Message-ID: <20240821202110.x6ljy3x3ixvbg43r@skbuf>
References: <a0338310-e66c-497c-bc1f-a597e50aa3ff@intel.com>
 <0e523795-a4b2-4276-b665-969c745b20f6@intel.com>
 <20240818132910.jmsvqg363vkzbaxw@skbuf>
 <fcd9eaf4-3eb7-42e1-9b46-4c03e666db69@intel.com>
 <7d0e11a8-04c3-445b-89d3-fb347563dcd3@intel.com>
 <20240821135859.6ge4ruqyxrzcub67@skbuf>
 <0aab2158-c8a0-493e-8a32-e1abd6ba6c1c@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0aab2158-c8a0-493e-8a32-e1abd6ba6c1c@intel.com>

On Wed, Aug 21, 2024 at 12:12:00PM -0700, Jacob Keller wrote:
> Ok. I'll investigate this, and I will send the two fixes for lib/packing
> in my series to implement the support in ice. That would help on our end
> with managing the changes since it avoids an interdependence between
> multiple series in flight.

There's one patch in there which replaces the packing(PACK) call with a
dedicated pack() function, and packing(UNPACK) with unpack(). The idea
being that it helps with const correctness. I still have some mixed
feelings about this, because a multiplexed packing() call is in some
ways more flexible, but apparently others felt bad enough about the
packing() API to tell me about it, and that stuck with me.

I'm mentioning it because if you're going to use the API, you could at
least consider using the const-correct form, so that there's one less
driver to refactor later.

