Return-Path: <netdev+bounces-67580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8944E844302
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 16:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0C0DB2F33A
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 15:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C0683CC5;
	Wed, 31 Jan 2024 15:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MG7dgYXb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30085DF35
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 15:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706713608; cv=none; b=iKN5CJLAtPs6ICmXxydqUvgBtfpDm64p75qH2NxKl7jEdew5tfbI08jSLO6eSmBdC7Ywj1jCnUFwqrEUnjG7NOGdMGnBvMExIGUu7CJyPn2wtiwc0YW8BnCT1XZZ5WTj0byfMcQtsdYdm41eUUVTz9Ud7PuR/fv0P/5uQHkP+Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706713608; c=relaxed/simple;
	bh=JKswgWfJZBdtmIeko8KWMNuj6Qcy/inlP+BGa8aajbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPhyzEPsh9+jmuG1jKN/Ls3EGjFF/kFHn8OjTOhsAibfJXozyDtVOzjZln40eeDteY7ypeeSyobxLNg/Udfgvzo28eOefoyFgkvvQMkMSPsu9Q502HpbgJiEK4EwWc43gygXWnCpc6CMPponUJ1527hpmB2urlbWX7gbqfmxAlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MG7dgYXb; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40f02b8d176so16223295e9.1
        for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 07:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706713605; x=1707318405; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RBVPi7n/ictw/t00XJIGW3x01xrwKWQ4gYT/CyEnd8A=;
        b=MG7dgYXbEe2Sm6UNe2JstDMeE1ouyDeu9vrNd5hWTbj25rmXikc1eEDtY2NQvnkBR7
         bLQaE1vyrB2LltOMy0Xb2geIjmYERQ+Bo+hA2nIZYBKMnzKK6q+d0qlkPS1qCZ0Filpp
         eWD0HDWGfA4lfjt+1x2tzbU+csAc+pdEdeRbyawhYzpaNJyJnUCYYgcoaOtX+w+r64Mv
         3BrWqJqODs92cYiqjpB+8z8vH/U96xw+6t2Egr9SzWqg/RxLz+n4WvtVyrFMb+/W18hA
         sA8pXQqkI9KdIPeoYZnMRsf4/biBWfb80SWMkd3+NFEWFZ/Zqnc4W5lw4OZg8xBykhlP
         DuCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706713605; x=1707318405;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RBVPi7n/ictw/t00XJIGW3x01xrwKWQ4gYT/CyEnd8A=;
        b=fmkjkbZYrRVIWMU6eManM/oAyC402FZRkn6E7Q3TXskEFaBs8cD9qsO5R6BIQd9p70
         81omF/LDrTFCIOipqIve4FOdEyRDNz1ohePimkHNAoNPglRsWP6IUy3GzxVn2W6+ppPs
         U5FOdLSEuLRcVNyZcNKJpqKNIh75QZJ2zvNNBXWeoTRhHxk8N4vjocYIqtbQEmk1vZ0M
         L9lcNeBlKY442lS0q792hUOA4smwRAOR74yj4xLfE5A/m1y+fYHPXReSzqwvYZAlyf4y
         L/8s8ANIAFoI80Gnfy8hrtXh0zKUipp1RwjZ+Hh1/nDkhhVOQH/VaSvzBtFKANn2bnvJ
         o64A==
X-Gm-Message-State: AOJu0YyaSGOr/BOWCJE9IS0ANzZKYCMlxETCI32vs3sv35iV13z6177W
	WqzuGwW273znOpc11ajlS0iOiY8AF8kMTg0BM7o2EC5jYbCt0WAU
X-Google-Smtp-Source: AGHT+IGiPoUnJ8P5vNtErB54OdVWsBM1JqyZNoTTI4pb+oGNQSvMiZkX02utUlDRvS6s0kGjUwFv3w==
X-Received: by 2002:a05:600c:5109:b0:40f:b45c:85a5 with SMTP id o9-20020a05600c510900b0040fb45c85a5mr1374110wms.22.1706713604721;
        Wed, 31 Jan 2024 07:06:44 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVbcKo0Qr9DO0LxZunuvEOwIWqWEwOsIBHjNHHasl9y0GDJzI1QkS4wFtT8gBqqvQ15W3cZGytxXNOQU89wvtdcpz0YRlYHafuRF0mSfxf2Xg0mFGuaYT0yQzttWy5Wx2s7LRYjqAtLy7hydQ/pyznFvgURi+2KYExUIpiVP/0ZqiLj52AHAo9HFBtmWMTzqWmdgjcPUCVnNb+cTj/Ti/ycon64wWyiNnsrtBsJZXLB3YdvK+ydRSZbw87H4g==
Received: from skbuf ([188.25.173.195])
        by smtp.gmail.com with ESMTPSA id eo9-20020a056000428900b0033ae9e7f6b6sm9541782wrb.111.2024.01.31.07.06.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 07:06:44 -0800 (PST)
Date: Wed, 31 Jan 2024 17:06:42 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, roopa@nvidia.com,
	razor@blackwall.org, bridge@lists.linux.dev, netdev@vger.kernel.org,
	jiri@resnulli.us, ivecera@redhat.com
Subject: Re: [PATCH net 2/2] net: bridge: switchdev: Skip MDB replays of
 pending events
Message-ID: <20240131150642.mxcssv7l5qfiejkl@skbuf>
References: <20240131123544.462597-1-tobias@waldekranz.com>
 <20240131123544.462597-3-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131123544.462597-3-tobias@waldekranz.com>

On Wed, Jan 31, 2024 at 01:35:44PM +0100, Tobias Waldekranz wrote:
>  	list_for_each_entry(obj, &mdb_list, list) {
>  		err = br_switchdev_mdb_replay_one(nb, dev,
> -- 
> 2.34.1
> 

I think there's one more race to deal with.

If the switchdev driver has signaled SWITCHDEV_BRPORT_UNOFFLOADED,
it may be that there are still deferred port object deletions.
If the switchdev port is under a LAG which is under the bridge AND is
leaving the LAG, those deferred deletions might run too late, aka after
it will no longer process the deletions, since it has left the bridge
constellation.

To fix that, we need another switchdev_deferred_process() call, after
the br_switchdev_mdb_replay_one() calls, while still under rtnl_lock().
The existing switchdev_deferred_process() call from del_nbp() will not
help, since the net_bridge_port (the LAG) does _not_ disappear.

