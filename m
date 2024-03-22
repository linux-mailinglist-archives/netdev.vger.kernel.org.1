Return-Path: <netdev+bounces-81246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E4E886BE9
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 13:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E31C428338D
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 12:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A7C3FB96;
	Fri, 22 Mar 2024 12:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="EC756TnO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F120E3FBA3
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 12:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711109697; cv=none; b=XGexkM91Q159g1lBkHovpybek4RzSQhknwq+udjty/qlwUxY83bmmjeJbMD0ZVuWtqsoxLA07NoSvzHg2PESGhiMKDRrwUPG6DYC0SMjO0bChtCI3qQm1X4XZ41Vf82359tjVggkR6y+LB84yA/BYmoQObjDLtZUYZ313fdjIJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711109697; c=relaxed/simple;
	bh=zZsG9GLN8dsvNBjxY5iKeUEMx/EFbSsTptiLrr1sNsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nZU+lok8yCl7UL/S5PaNUjGXmevbgQIozaM9lB6ZmicuCZbV5yXb6F1XJ78YY2a5kyIoqy6JFyUEjgfLiUTJI0tB91NyfLuROyUJDD9LlUtB2Mt9u3hkPKzL4US4vCV2soFmHyFBRxkwFUpt0EI4BQqEPmE663aWwduKrr2Ho7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=EC756TnO; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d68cf90ec4so34281071fa.1
        for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 05:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1711109693; x=1711714493; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zZsG9GLN8dsvNBjxY5iKeUEMx/EFbSsTptiLrr1sNsg=;
        b=EC756TnONcY8q3g3lpt7UZSZzOvGaCzNkDbbWDLWv6XYtZUREDR4uYSKCLMFdoaxOo
         OHFlu4WmYk1+JTkI7qWX4k/0wVYKckAzBBd2L0yDAI6etYfzAG1viDWJHjqTrw7u4DOQ
         vkyHx9gWao0EwcPpvf6ANmPV7WvYjUku+uYThkGq/zUUGdCbAvt8OSnysjwoNnixEv2d
         /yMxAck+FGwSPnsWJgftlN9LMzbCOWGUpTaFQiWLfoKUC0FQg8TjTmyLUD6B4MSqT6lJ
         ldU928uhTlxHTXYmi5MkcdjCDnyUr6TJbVZk0A0b1bElSfqYlpzQgBkUTBUGgKXa9mFz
         dRyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711109693; x=1711714493;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zZsG9GLN8dsvNBjxY5iKeUEMx/EFbSsTptiLrr1sNsg=;
        b=Y3aD4Z6xAWi/kdT8YCZogiCn8zv+DlvoqWPZ2e4jr5uQb/xIXkBlm3O7w2pFMXeRqU
         J3u+94aJSX6XOf1QmwJioS1x327Shl1dxTXogU7mB+sA7bNM4Hl4Cequ34Tof4tvCVK7
         PjcHwtXw32+FlEC3gNCzdUtVsJ8ajWPZ+/vo6cYNJPzo0tkLrILvKLmyQOBFRXQ3hxK4
         PJNRt55KmvnB5da0guVxMGNLZHMOfEIFSGq4GAmp3LCw3xZ4omK58jvSdGHvcWyx3Lo5
         aGADjuWAF+fQuFmA0DCUmyR5biFnW/pLskgcu/A5q6zJL9UlqdVJPt79P88MayVEuR+w
         zk/A==
X-Forwarded-Encrypted: i=1; AJvYcCXtCVTK095eYjvU+1Ad1FRFS8eB2sZdUKzjVYLI4kbPLfRzbSWoBn8X6qc5HO9sE5VDXFwsiVCeUqKk+irNwyirW/SkJUsh
X-Gm-Message-State: AOJu0YwL/8YmGNuCDTIP4B3KEDQvCM9NhV0lu/NlnQ+E3r0nsEUC0kqG
	CQOp/Y/IpIG+EDiE3uYgvp93LWq4AC35xvALeWZgPEqKsdEEOxbqEG+MeJ6lrK9RMNllKVBWzvR
	E
X-Google-Smtp-Source: AGHT+IEaQl4+2yhplbIBm4NOBJcyx82S3na+uASlPZ/S07tHfKQXRPEADTaCAdVeqgWWzkL+QlX3AA==
X-Received: by 2002:a2e:a416:0:b0:2d4:3c32:814d with SMTP id p22-20020a2ea416000000b002d43c32814dmr1595735ljn.26.1711109693070;
        Fri, 22 Mar 2024 05:14:53 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id r10-20020a05600c35ca00b0041462294fe3sm2924459wmq.42.2024.03.22.05.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 05:14:52 -0700 (PDT)
Date: Fri, 22 Mar 2024 13:14:49 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Prasad Pandit <ppandit@redhat.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	netdev@vger.kernel.org, Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH net v1] dpll: indent DPLL option type by a tab
Message-ID: <Zf12OSZZ2kVOwRCB@nanopsycho>
References: <20240322114819.1801795-1-ppandit@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322114819.1801795-1-ppandit@redhat.com>

Fri, Mar 22, 2024 at 12:48:19PM CET, ppandit@redhat.com wrote:
>From: Prasad Pandit <pjp@fedoraproject.org>
>
>Indent config option type by a tab. It helps Kconfig parsers
>to read file without error.
>
>Fixes: 9431063ad323 ("dpll: core: Add DPLL framework base functions")
>Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

Next time please wait 24hours before you send another patch version.

