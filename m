Return-Path: <netdev+bounces-73176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07ED285B40C
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 08:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DD771C2384A
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 07:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F6845B5AA;
	Tue, 20 Feb 2024 07:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="vzBrAV67"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5169057313
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 07:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708414289; cv=none; b=rB2r7Fb5TftYfPyep/Hz5PNFrcJ3E1wC52HleiHNyr61JPhxho1J9jaIf+f6VG4705h0rtZ+KB+BYBuJI8yv5JdXd2ndpXbSpUdW+98cYqJm/h9uH82boAEzaJ40qZC+70QNxSnOhyN+0GuGp4HvPavSKDzBUdHh3FSb6+MJJ1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708414289; c=relaxed/simple;
	bh=9Kb9gEGCekFk/72r8vF1EovTGgvXBHyoOMoRfzDVtyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nTAppVUMGNv0CuRaOA+Fac5sB7897xnStjeCAGa8KVC+mBo4FbgcqfqohKSHvY16K04XZYntf+wnGBsUxB6+hKkACbTqwg4J5QWd8LE0tyPkViDp/fJqThgZdg/ZzKZyTefAGJH+ugwMPKf6EQoMX49A7KuNo84pV8Koqb+35aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=vzBrAV67; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a3e6f79e83dso264162866b.2
        for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 23:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708414286; x=1709019086; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w74UEPbIDRayApcomN3I+g9HHKF6DaXSBkGLYHaZSPQ=;
        b=vzBrAV67RNAGBM2b6yBwAMCGS9eATSAuVTSO8pQROA4vEzvFGxSGyht/qnV1C9RcJd
         eqaiEpfwE/9meR+3BQ2Mm/B04HX+mU91gSIWgjDSD1d3rM+8h2f/6WVMEqAW+MfW0mpk
         s8s6ZQVyr9QFaOM0Vp/yISLimCjOPpe8WYsNKNFPa6f3SQaFjYV3YsWevcBmkMTIOS4g
         r4aWiBiR5bTAgCUfFq2Mt8K1PsXHVL6CDYdiMHOTxAP4emzr4lJqVqdRF+TF9iN7h4cx
         prvkAFDFJCGuNlvcptSjWtpc1nHcckeOZyCAqoMYvBMvvqfczuF4ba6QvisCLxyN5ng6
         NE2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708414286; x=1709019086;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w74UEPbIDRayApcomN3I+g9HHKF6DaXSBkGLYHaZSPQ=;
        b=otiC1Ho1z1AFZWxwdjExFmVL65Yp7ovr41I8v3adWtgW1kdoctdP7hj3bm5zsGteJm
         C/dAYowW/e23Jaes1NHmR3MMGZISl0A9VTqZ3DtThWJKfFKcZNZ8oHdu9lciG6UQIQYs
         iWsQDgmTsWUSjlJ2U5tTGGZd1W/EYRjHnhRW8YIlKGl/yuKYEdCKz4BZ+mZ7bSO8E+Qa
         wa3zjUODTO89lep0sxP3Gj3A/6eEj2p5kH/ZSoP58WW/b1saPMnFur4gDN5lUK/8CLtJ
         +BJrZb4CxL0jF9+mTahVtjR/DXTKjoKNxz9ymZVEVZC62gRezAOeOp5IQXniXz+fwNoy
         7BNA==
X-Gm-Message-State: AOJu0Yy3SHdL+F5+0obv3qd/yzY8IyusXn67onmx9JTv/DdnBVQN5K0n
	CnHxNl68cANQ7KJun1c0GybBhcnFd4OjDIYkQQg0ShQVfiQWe6pug0qqcWfel5k=
X-Google-Smtp-Source: AGHT+IHO+ZI4119yEs8dTE1PUGk0PRLvxgVDOCRGlt7qWTQCsgOyJJIaPjQUzj98NLMxo6Z8DNpTtw==
X-Received: by 2002:a17:906:2c0d:b0:a3e:7b6a:baa6 with SMTP id e13-20020a1709062c0d00b00a3e7b6abaa6mr3622423ejh.49.1708414286626;
        Mon, 19 Feb 2024 23:31:26 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id lj8-20020a170907188800b00a3dd52e758bsm3652239ejc.100.2024.02.19.23.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 23:31:26 -0800 (PST)
Date: Tue, 20 Feb 2024 08:31:23 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, jacob.e.keller@intel.com,
	swarupkotikalapudi@gmail.com, donald.hunter@gmail.com,
	sdf@google.com, lorenzo@kernel.org, alessandromarcolini99@gmail.com
Subject: Re: [patch net-next 06/13] tools: ynl: introduce attribute-replace
 for sub-message
Message-ID: <ZdRVS6mHLBQVwSMN@nanopsycho>
References: <20240219172525.71406-1-jiri@resnulli.us>
 <20240219172525.71406-7-jiri@resnulli.us>
 <20240219145204.48298295@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219145204.48298295@kernel.org>

Mon, Feb 19, 2024 at 11:52:04PM CET, kuba@kernel.org wrote:
>On Mon, 19 Feb 2024 18:25:22 +0100 Jiri Pirko wrote:
>> For devlink param, param-value-data attr is used by kernel to fill
>> different attribute type according to param-type attribute value.
>> 
>> Currently the sub-message feature allows spec to embed custom message
>> selected by another attribute. The sub-message is then nested inside the
>> attr of sub-message type.
>> 
>> Benefit from the sub-message feature and extend it. Introduce
>> attribute-replace spec flag by which the spec indicates that ynl should
>> consider sub-message as not nested in the original attribute, but rather
>> to consider the original attribute as the sub-message right away.
>
>The "type agnostic" / generic style of devlink params and fmsg
>are contrary to YNL's direction and goals. YNL abstracts parsing

True, but that's what we have. Similar to what we have in TC where
sub-messages are present, that is also against ynl's direction and
goals.

>and typing using external spec. devlink params and fmsg go in a
>different direction where all information is carried by netlink values
>and netlink typing is just to create "JSON-like" formatting.

Only fmsg, not params.

>These are incompatible ideas, and combining these two abstractions
>in one library provides little value - devlink CLI already has an
>implementation for fmsg and params. YNL doesn't have to cover
>everything.

True. In this patchset, I'm just using the existing sub-message
infrastructure with a bit of extension. The json-like thing of fmsg is
ignored, I don't try to reconstruct json from netlink message of fmsg.

