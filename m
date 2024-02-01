Return-Path: <netdev+bounces-67754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 573ED844DE4
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 01:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1153728BBA0
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 00:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B101102;
	Thu,  1 Feb 2024 00:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ncVnjc/J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151031848
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 00:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706747591; cv=none; b=MQQMHaGuL7je8Bsi6HG5g4Q/jfAMP2IflUv5AcN/dPNuZWRY8KlhNIYSO4cvyECBEy+Lnon25NvDCkrKvLhbD/AYxidASTHwWN1KJApk7UMSqGjUwESbCUmooX5SuD6zAdjYEvQNPWuCuFWP3cb3Im0ZXEx9Nkj1kePn0yWp1GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706747591; c=relaxed/simple;
	bh=DfK90FjFExrJjPMMCY/tsvVrtnVfs8jikyEr8u82fcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RUatnYaBFX9w/tliO+XuRzRnUI27Fndswa5F334NReXZmMIuBbI8LAzeau6hyfX6yx52cCVWQUw2cul/phmNuPPDj5wrvs6xxcMQRMKq6zzza/9AAjrLGoWVx/xHlbHjAdVh8NCGfG6RnSW2STfNjzSe3Pi+bctRo0S1p8yVM2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ncVnjc/J; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a2d7e2e7fe0so56388666b.1
        for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 16:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706747588; x=1707352388; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sYc3IxBIqD76M0X/oe6yDzIKEZbPMAmuRtmpKU/+RyE=;
        b=ncVnjc/JsZa0MzIQcH6f4PodSJA5dejIAlgunK/yISYcnj3cgZOoNUTFSsBkZBZV0S
         ymr2tZGWmr45k0F9/kLsG2zR3Y1/RaMOwXu1q5WCil7/WIShKfgnfh9vtbKCKw4kJ7DN
         TkAozXZISCYuATZ+L3Y9GFcjuQDG7cFN5AXowr3Uq5QDOC6ptLjIVrvrF+x8qzbzRj2v
         xlp2bUNiDahn4IkQegBu3m8wQ7kOxI3O1ejJVC0j52VRsmnSCo/4CP9AuBYq6mPQX4e9
         oZ3p71Wa49yOEBzJ4wmwfX8Ru7pDVK4Nm3FhefF2+2DJmUCJvfZ3hAaRxLBW7dJ7vpRO
         TaJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706747588; x=1707352388;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sYc3IxBIqD76M0X/oe6yDzIKEZbPMAmuRtmpKU/+RyE=;
        b=njeWrgJ4RcipAk5kY0YkIbxjHwDHndkG7q+gUs+v9w5ZztflcC+IeclRK3iMLjZ0lB
         GuGIx1ek71tUUBqLJgVDCo2evNyKXArIB9XaoN1WIYbldk6kCJ+pGG3pd3O+Q6TQserD
         bmjmXc9V26s0G3wVxCP/JYvBaVpxP0S3lETIuKTGN8NJnTL1DB1oqajLRrSY8/zAcooD
         mVmpxl9Ze+aFcm+CpcTV5mHfhuJJ3jx8wSQ+kCsjT6aoHW70+e+N4NRixxSkI2TFwN6J
         HGbxkqMtQP5hVZVMnB51hOvEWjf+h6aQWaJU0km6b7KGEmrkN2cY2/gn4hG7ZuF2ZKRy
         nW5w==
X-Gm-Message-State: AOJu0YzPHbP2L6dIcTf5d/8db0Jz3yjbP2FFUndwYwwzjEnvJ6GNrob3
	xgdoXQlivMuTfCgN6QOiWGnSTHQgVrb7v/OonD3I2KudtGWi3uhrTRuAbucg
X-Google-Smtp-Source: AGHT+IEv8ssH6QhCRod9XfGdUzEQZLHdO4Wt8EUNG5erRbBggiHIBdojxLF61LuKsWFNv2B3fcdZ2Q==
X-Received: by 2002:a17:906:c795:b0:a36:39dd:3f93 with SMTP id cw21-20020a170906c79500b00a3639dd3f93mr3199570ejb.4.1706747587975;
        Wed, 31 Jan 2024 16:33:07 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVCXJrEtYNLYN0unC1ZswqY7VqW+7k40kVV2s0UBLdDcDgo4+eyUZyPDEgG3YTl3bJs9jV703oGkBxfo1HudUBaqDc/vQeKTIOM6uU5mkuh2SWhKOIelql8CZRlfJmifcdB2Dixrlqu2C5QwL3h7JnyN8KNjewZ+188RHFcD7fACU8OEu7ENxMkqhO95dIZK2BD4NcmoJ8UBE0DGYJoatdCClPT95QonxF0WcVxcTEf9h7hAEigdzErYdKFejSkJQ==
Received: from skbuf ([188.25.173.195])
        by smtp.gmail.com with ESMTPSA id qh20-20020a170906ecb400b00a28f6294233sm6630925ejb.76.2024.01.31.16.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 16:33:07 -0800 (PST)
Date: Thu, 1 Feb 2024 02:33:05 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Tobias Waldekranz <tobias@waldekranz.com>, davem@davemloft.net,
	kuba@kernel.org, roopa@nvidia.com, razor@blackwall.org,
	bridge@lists.linux.dev, netdev@vger.kernel.org, ivecera@redhat.com
Subject: Re: [PATCH net 1/2] net: switchdev: Add helper to check if an object
 event is pending
Message-ID: <20240201003305.thoj2y3bjyxq2hlj@skbuf>
References: <20240131123544.462597-1-tobias@waldekranz.com>
 <20240131123544.462597-2-tobias@waldekranz.com>
 <ZbpCA3kgoCKsdQ4J@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbpCA3kgoCKsdQ4J@nanopsycho>

On Wed, Jan 31, 2024 at 01:50:11PM +0100, Jiri Pirko wrote:
> Wed, Jan 31, 2024 at 01:35:43PM CET, tobias@waldekranz.com wrote:
> >When adding/removing a port to/from a bridge, the port must be brought
> >up to speed with the current state of the bridge. This is done by
> >replaying all relevant events, directly to the port in question.
> 
> Could you please use the imperative mood in your patch descriptions?
> That way, it is much easier to understand what is the current state of
> things and what you are actually changing.

FWIW, the paragraph you've concentrated upon does describe the current
state of things, not what the patch does; thus it does not need to be in
the imperative mood.

