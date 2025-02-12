Return-Path: <netdev+bounces-165573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B313AA32983
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 16:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA3F018885BA
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 15:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B83A2101BE;
	Wed, 12 Feb 2025 15:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="L8NIxDdo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90B720F09E
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 15:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739372737; cv=none; b=mmk9DQ1EqX2rn3JI7mIHDwnkGoYrlgyPOGwioEosSYdxLw1xLS3pzaxx4HD0GfrHEYIzH/BM7rHyff75tGH/Q88V7TeyOyiOSVfMJoZbRVs7ArTZXx0UDzk8F7I4qonIWSCu4MGkskAzuG++nAEr9j74CNIh5kAcsA04zbda1zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739372737; c=relaxed/simple;
	bh=0LW+cJqHaSbaqjs/gJfVwUq4cdkqyGBJej9TaePDAfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G7fDlcSB7DFnx66Lb6Iqxt8+aDtUQWGAdYgt/NfUSgXQycA07kOn2uneH51UWsfpD2NHxvr59xpq27BNr/1hsVGLgxvqUO00o4m1jFU4ROR7208/HsIVqYK6mR7ECNDUJxxc+9tJnkXLFiN0yDg6Giej5kmCt+HO0g0zilSpqLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=L8NIxDdo; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43944181e68so38793745e9.0
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 07:05:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1739372734; x=1739977534; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0LW+cJqHaSbaqjs/gJfVwUq4cdkqyGBJej9TaePDAfw=;
        b=L8NIxDdoX9TQlx6vJ0RHoZrLDHT+gGvWTLPj3oJSYQ38fk8wOPAXKKPR30zJ3hr4SM
         78f9eCWLfWBdggEg4i5yPpHiV2gqnDufzUiF6o/HFEJNbg7z4QK2lfO7Dq3x17l4ZG0g
         acXWRAmi7VZWJpHW7+BHQ5WFvcvw4erpzXbDRE/uYXCqnLsOgCasv0wSbBYJwRaMiBor
         uW3JB01rJCHpA4ZBoILL0B6IsKPjc5jXhqAC1GSRYGfdX5QaZWQ5eCGoLXlJq89e6NWV
         tnV17R6eoFMnCzZ69dXyGns/q+fHiZrG5v6s2tU3CUBsPAPXgvge36cqlfJCSVD5yPpn
         6EKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739372734; x=1739977534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0LW+cJqHaSbaqjs/gJfVwUq4cdkqyGBJej9TaePDAfw=;
        b=mqmrJ0/9nn6TNmMNnWL9j+aFfaRSkgr7T0jLNx3a/q+zcgzZGzkjJYpQJXUASGDww0
         eta2iOkcfigS5et+qHhqkk5/D8ptZ59RF0d0IHOwLV4LRqsNQcbDIVbppmc+8YOMdk+9
         FSYZPAMl/c6t/W6uBNbeDkz7KuTiztIrqKMH1MQ085N55Dz5gT3p8fSYY6+Lw/cSTxng
         eDoT7WQtNLjjSEQ+zMP4G6Qa5XYgERSzNS9oikU6VpqayZCEAyKj5Ci/Jc/lBqJVyEMk
         0PxDJRBJ3e0IC5F6RLomjIM6uOiY7IeF9I6gZjnKCEHqzFlEwD9VNWhrYnIiJprrLePs
         fowg==
X-Forwarded-Encrypted: i=1; AJvYcCUzm10Qx/qRTCC04DMkPcjJQM64EC/lChKC8oGBGFDRaA3nUyJeyo5WWFRK/hPg+t09Riq3SQk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3NNsW/GSpt7yNTMmH4BKgHbwbd4HfmVPKqYyRzbXJJGpTZvwy
	ByRf6lwLm+O5ARIW9XiELT20yrSHrBdhnQ0m7b615FlZAopMYYnO0gsiN+3B5dSRsKDYCnzribu
	StiI=
X-Gm-Gg: ASbGnctvMeeiarj6LQFwN3ul2/XWXq1SlvQdpeepnrwFbDpbRCDbOt5m6JQe0rijBVj
	8MhOdNQQ9/Jf3FqtiDdzFchR90Vsqs91Vqg/WCjTE3lql5wS4cQJKdZ/BOQnMnbguG1Euz50Fdz
	I9GUnfO8KSPVKEpraXmRK07EJ+PC1YRf3M6dO2TAOdUU7db3ZdCUi9CaVGOZQFA8Go8kclhqkpR
	48QPfgsuG/n6hhQgUgHmQDkNnSYUgXwT6NG3TpJ3rlWSoCQXDTBt6ZdvWmWOTaGyiA8y4td2tN0
	X4/tULyEJujrBPntPS6AGrwyVA==
X-Google-Smtp-Source: AGHT+IHBCT1DisQ2uWD0re37YqmFa5N5jQkihG3cb5IpzwueQUwofnfOov0k0D8x4BE4nLsrJGBwLg==
X-Received: by 2002:a05:600c:510c:b0:439:48f6:dd6e with SMTP id 5b1f17b1804b1-439581be2demr33842435e9.19.1739372732308;
        Wed, 12 Feb 2025 07:05:32 -0800 (PST)
Received: from jiri-mlt ([194.212.255.194])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a078489sm21958685e9.33.2025.02.12.07.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 07:05:31 -0800 (PST)
Date: Wed, 12 Feb 2025 16:05:29 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com, 
	netdev@vger.kernel.org, horms@kernel.org, Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-next v3 01/14] devlink: add value check to
 devlink_info_version_put()
Message-ID: <x2wsjmoizxg3hi44luqmc7smete2dhqze5do5qnfw7p527ixcs@ynsfzwvggawj>
References: <20250212131413.91787-1-jedrzej.jagielski@intel.com>
 <20250212131413.91787-2-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212131413.91787-2-jedrzej.jagielski@intel.com>

Wed, Feb 12, 2025 at 02:14:00PM +0100, jedrzej.jagielski@intel.com wrote:
>Prevent from proceeding if there's nothing to print.
>
>Suggested-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

