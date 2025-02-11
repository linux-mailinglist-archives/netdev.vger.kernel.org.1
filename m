Return-Path: <netdev+bounces-165201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 591B3A30EE9
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 15:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CE457A1EED
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 14:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2A7250C1A;
	Tue, 11 Feb 2025 14:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="weHFce6J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE789250C12
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 14:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739285916; cv=none; b=TB6IFbYqgLXqyN0VryouR13GURRogpT6HbgrV5GCy/p0B7L0BYxycRbTwh+Cpu72hnY5X0AUqD55eIBnsYbDd4ClTxKg2801FXrKKg+F0o/mJckfFJdq4PmVntC6lA7iFqy8tBBwNAJfESzVDWO6Eb8l9AryzbR3kdIe1yDAix8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739285916; c=relaxed/simple;
	bh=jXLfZ1iqlX07hTvoIFlqWCtUKrmxC5WH5rAvbA0JX2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jdi8yi4+JopapUG6vFBB9+p5FM5OX0jsv6RqiP8sRVrtTEok9gAfsgFUmuD5NmOljOnn086ZQYAFmzkK9lf4lbBLAo+Wlb8Tw39BSzZBUCLdFLGnLjYBmCOecPEhdxpE1TsfXnLWodDK9vt62LkW34DvDXz+zVIMmJ09E2A8aE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=weHFce6J; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4394a823036so16333625e9.0
        for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 06:58:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1739285912; x=1739890712; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LoaezNQ5dV/9EG0tpbR4FMDwqT8KupFNVSUAN3IN2AM=;
        b=weHFce6Jm8hwgNbTLEwevOKcT/PxK1TDvA6mvKl/o5reYkF2c381xjRfpVeKPuaZp1
         5eSPRF7RWuP32JkIdyI5ElJO9fjNB6rchkyr03dHifK98A4OUY1cHqeXoOaI5yXMDxkw
         3a1Drf4bnAT5iSr+6O+jx+2/2t+ydzhgJin13LrlV81jLhcXnSVvNuX0oPTMfrz0RTI8
         8d58ITPSH9qa4X2F2I1KFXJX3ZDdbI0zlT+g+Z0e3IOYgwlAEp2GtvnL4F+H11WyeIkq
         JLWcXhf8IF+GqBHq4y22RyfeIUCtVBBwaKLSvISF/4siJ5LITqYDLtEO5BljNSIwI5vx
         ajxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739285912; x=1739890712;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LoaezNQ5dV/9EG0tpbR4FMDwqT8KupFNVSUAN3IN2AM=;
        b=VtbyXxRHRddKPMlylNOxi/FlpaoelutfgBniCMYZ9eglDhhgEjqYbVOKSxG4h3Nf6O
         ONQ4YdTUkshV+4p98vxgJGIKFLixm5kvy9CJzz5xBCdJj2OgjSTN0OmLNM+d+nO9TDv3
         7rXlVH5NCas9IWJhzZPDtXaa+d6g3H7vt3+wTLIgoxHQFN6cFL+ssbL6IOnq2v/inGYz
         kk2wHo6vXH5zuDXSLuXQWF7v7xlcXB9IsVqiWMRPxHtIeZ2dDjitN82qDNP/d5WBOfvw
         PDf/1iWh3WXsAdNN/+kLHOE2m5pCa1/XAydX2VldVXqyUyzOjAZYivR6ELfzCtcSIqtM
         tCKA==
X-Forwarded-Encrypted: i=1; AJvYcCXIz7keQt46/3noolsRkhtcGqtZojVkGC6bL4yltlChAKloc+yKONoMqpSdy2zkf2a3aEwAMlg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyB7E+zmbws+OlSwRUopuDLO/KgG+8smRmbnzaz8MTFwNRqv7wC
	/RlKAJnrvzOAgV5xPfZltef1cGf6IWPWHGpRmxALsY53BTJbs6Jdm8Ps/1GkMHK4+tMoHlONKCI
	qtJo=
X-Gm-Gg: ASbGncufDOs59qfzCz3nUaNjOGmez9dwSfrhhqT85IgS6KL8KztmVOLZN6a/uxkvc5Y
	WXTS6QAnBJV85i0tNnN5ivI8Mh7CpRB8SlydifGF2GqtwmGkar/NdBNGetAKG3fvzJC9bhcYFsM
	uVtdQNmSLkl4133zbn4Mrp4DWy9+jhwGKXuy8V1gP1SSyXrxrq0eIf6PTWUNVIlCv4lOFCGuIoH
	Zovi39V11uw2t6BemgVmaL6B+4pBVD4n43MXeX6r1X00KzapMrvrQ10EonvLAFdGqXsBJ8ml/La
	s+1Brv5cMXcrcgKyc4EdCd0=
X-Google-Smtp-Source: AGHT+IHL0OJnuZEqNVcWxZ9zrAwEjLpFNma5IQgCQ1H/NCGrNKX3TzyjupN6rGBnskXGKbChGpwhgg==
X-Received: by 2002:a05:600c:1c96:b0:434:a30b:5455 with SMTP id 5b1f17b1804b1-439249c6eb3mr146742895e9.27.1739285911887;
        Tue, 11 Feb 2025 06:58:31 -0800 (PST)
Received: from jiri-mlt ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43936bcc04fsm103764985e9.20.2025.02.11.06.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 06:58:31 -0800 (PST)
Date: Tue, 11 Feb 2025 15:58:24 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>, 
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "horms@kernel.org" <horms@kernel.org>, 
	"Polchlopek, Mateusz" <mateusz.polchlopek@intel.com>
Subject: Re: [PATCH iwl-next v2 02/13] ixgbe: add handler for devlink
 .info_get()
Message-ID: <wftf7fg3gtgmmjufdrtnnlkqzp4x233kmty67hnlchkym4u4ci@ubujjvrt2txa>
References: <20250210135639.68674-1-jedrzej.jagielski@intel.com>
 <20250210135639.68674-3-jedrzej.jagielski@intel.com>
 <bxi2icjzf37njzl4q5euu6bbrvbfu2c557dksqtigtegxcnowo@yyfke6ocrtpf>
 <DS0PR11MB7785B1EF702ED5536D4B4CCBF0FD2@DS0PR11MB7785.namprd11.prod.outlook.com>
 <qmjitflm2k3zo5yiym74c6okjg5skzhb46evfhn6qpzkwch3uc@epvkzeg37n3f>
 <07f0e1d1-d526-4b35-8958-0abaf7ef4829@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07f0e1d1-d526-4b35-8958-0abaf7ef4829@intel.com>

Tue, Feb 11, 2025 at 03:38:25PM +0100, przemyslaw.kitszel@intel.com wrote:
>On 2/11/25 13:52, Jiri Pirko wrote:
>> Tue, Feb 11, 2025 at 01:12:12PM +0100, jedrzej.jagielski@intel.com wrote:
>> > From: Jiri Pirko <jiri@resnulli.us>
>> > Sent: Monday, February 10, 2025 5:26 PM
>> > > Mon, Feb 10, 2025 at 02:56:28PM +0100, jedrzej.jagielski@intel.com wrote:
>> > > 
>> > > [...]
>> > > 
>> > > > +enum ixgbe_devlink_version_type {
>> > > > +	IXGBE_DL_VERSION_FIXED,
>> > > > +	IXGBE_DL_VERSION_RUNNING,
>> > > > +};
>> > > > +
>> > > > +static int ixgbe_devlink_info_put(struct devlink_info_req *req,
>> > > > +				  enum ixgbe_devlink_version_type type,
>> > > > +				  const char *key, const char *value)
>> > > 
>> > > I may be missing something, but what's the benefit of having this helper
>> > > instead of calling directly devlink_info_version_*_put()?
>> > 
>> > ixgbe devlink .info_get() supports various adapters across ixgbe portfolio which
>> > have various sets of version types - some version types are not applicable
>> > for some of the adapters - so we want just to check if it's *not empty.*
>> > 
>> > If so then we don't want to create such entry at all so avoid calling
>> > devlink_info_version_*_put() in this case.
>> > Putting value check prior each calling of devlink_info_version_*_put()
>> > would provide quite a code redundancy and would look not so good imho.
>> > 
>> > Me and Przemek are not fully convinced by adding such additional
>> > layer of abstraction but we defineltly need this value check to not
>> > print empty type or get error and return from the function.
>> > 
>> > Another solution would be to add such check to devlink function.
>> 
>> That sounds fine to me. Someone else may find this handy as well.
>Cool!
>
>perhaps we could also EXPORT devlink_info_version_put(), that would also
>help us reduce number of wrappers (also in other intel drivers)

Why not. Make sure you sanitize attr value.


