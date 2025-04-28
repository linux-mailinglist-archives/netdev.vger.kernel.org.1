Return-Path: <netdev+bounces-186486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19938A9F5D5
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 18:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F0093ABD7F
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 16:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488DA27A10A;
	Mon, 28 Apr 2025 16:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="0kdEaGTd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CCF27A10D
	for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 16:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745857815; cv=none; b=JwGBQ1gMkgMbYYq9urH/pmXfWJ38H7xk/0Bfj87jjp23y4G4jtWS1Eb92LWR52mtVE2SnBLz9D1qIIOy/DxU/u8AWXPABAbO+uNn0cEAUq7C3DCX7PiA3T8o9epTZbHo0llPp9hgtqJnYpwJKjn7JWuVQdQqnhlIbLRSTHEfB/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745857815; c=relaxed/simple;
	bh=rgWGCaPEut3Sq1Q77Ef5DzARVmWfDHJR1UaK/ONKD/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bjL3a+dvVP9PqZ4ACK58aYaXxR+CEqRtkzsKXtckqJWJt7CPaL6qOLfV9LvLnHWv7pCiQu+IlH2CHlT+lUbty8xrl79J12jDDDBa7pqhIK+pujCjEhD4kB2LRBER8Fcfvh+LkJSgGBqPc2MAU+1jAzxCJMh+aiSJzdlUJfcm6lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=0kdEaGTd; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43edecbfb94so47574245e9.1
        for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 09:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1745857812; x=1746462612; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FuJOxYPlqCw8gPPVBRRb44B+5zXaYBpyH/3cY9Vx8mI=;
        b=0kdEaGTdcQeXsuafyzc/VaNQUAdIHXv8BZLAHsp46f36nsNanGQ8IJnz7pcMgEetVp
         11ZvvEKYxel8+aDNik7HziiQqK98xePoJTTYWpwYBZkbsSlJeTFOqaBd5sGPln5P1TFC
         D89Eef3CxN1RB9ilmNNkN07SPJuGPUPjSbvmWX2353y5AqOqzFZc/HXpuJfwLhYYASez
         /xOTQcCM2+FaE5uMwYYQeq5wAzk8vJxbXBd6fcw7hWATDV5+wg0JfqHrBbiNwZc/HHex
         udIxxdOAKlvjmWH/EVZDZLbQWqEYgQYHzTDwHwr4pPgPBtSYRUGFFo9DpNgaXBGZlo4u
         YHiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745857812; x=1746462612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FuJOxYPlqCw8gPPVBRRb44B+5zXaYBpyH/3cY9Vx8mI=;
        b=WfjVE1W/0QxldXhsQOM4hIPLjGUR9Xk8StSa971XBUjABAdgDfXVlRo9fqLMtiuzx4
         IDT6gJJSpgo3O9rwbeJEiMqyrAaVzoa30nhe9mkq75ys0lFBv0fv2KqflWpjC5IpEfLP
         k3ps3LGpV+OZbt7u0/KSepd0wGZrZGKUIj+M/TLlKC7Q2mVRST25DBVHt8BevmCCKH3s
         91NuRWNMnZJ5Vt2QdlaCXHbD4+mixFUTrDORtPIHtnqGDgsvau5tQEGwWjRI8oboNF5e
         n6xzqYk93IWS4OaxJXe+s4yM8H91yYxzxqal0TUIs7G7zjgub/IK9ripGrb4huGFC2rK
         5SyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEajI+6TRZ0FDlBJnAT86fd5dc8W0TbQEAQ+fozYEPZPkUmUfOKJFbKQDaOAdPCtZIFewNpnM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc02xoH+hALLLsVnAQ5UbpCdRVpo7yY3oObvg02HYv8t5VmZlJ
	31a0idyKsNB1f4OdIJsh0QawRLyDJp6EKFasbKIzXq+KQzkDEtXTNjHLLcN2Trs=
X-Gm-Gg: ASbGncu3SAcy5/aw0Rh7v8oJMBBgiDys38R35B0XJE21IbiZsnNNE/NI75eOzywi2qs
	htQUqnqdCfy9H5o0pSItNqSnYHD1yuKO2v6nmEdGSNQm0+yfYhRnTcjAGf0Hn0TAf4mcuDfIRsT
	MiaHYVcMXVwF00ehtZMXnVlOZtlOl/wg9lC0SJVuG2wXmG5ZQahzb+J3RkHX2U1WMmqc7kYLmJD
	zPtElZq93jlWMUcQbJ30hbIdGDanCd81p1VIDAlZ3YqPTZXsCl/79YpLXVu0mp0Vb/99vbyMKt6
	pEi9t652h8uegtvqmwhcql8jTSTDAP+9JgZ5183HUJQ=
X-Google-Smtp-Source: AGHT+IGaaz3CYcksWmUnsuWsQ3KB9jzWWAhT4gaxPA4FOa4HSZGlGOlTGXbO9xt9wIHJVIR9r09odQ==
X-Received: by 2002:a5d:6947:0:b0:3a0:8325:8090 with SMTP id ffacd0b85a97d-3a0890ab7dfmr384630f8f.18.1745857811363;
        Mon, 28 Apr 2025 09:30:11 -0700 (PDT)
Received: from jiri-mlt ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073c8c968sm11412748f8f.8.2025.04.28.09.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 09:30:10 -0700 (PDT)
Date: Mon, 28 Apr 2025 18:30:04 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Moshe Shemesh <moshe@nvidia.com>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Tariq Toukan <tariqt@nvidia.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: Re: [RFC net-next 0/5] devlink: Add unique identifier to devlink
 port function
Message-ID: <z2ihsuor3mq4fkohk5snh6dkmcm7wvwdlj2camvdfpbjfa4she@bpvcb2er23pi>
References: <1745416242-1162653-1-git-send-email-moshe@nvidia.com>
 <20250424162425.1c0b46d1@kernel.org>
 <l5sll5gx4vw4ykf65vukex3huj677ar5l47iheh4l63e3xtf42@72g3vl5whmek>
 <20250425105145.6095c111@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425105145.6095c111@kernel.org>

Fri, Apr 25, 2025 at 07:51:45PM +0200, kuba@kernel.org wrote:
>On Fri, 25 Apr 2025 13:26:01 +0200 Jiri Pirko wrote:
>>> Makes sense, tho, could you please use UUID?
>>> Let's use industry standards when possible, not "arbitrary strings".  
>> 
>> Well, you could make the same request for serial number of asic and board.
>> Could be uuids too, but they aren't. I mean, it makes sense to have all
>> uids as uuid, but since the fw already exposes couple of uids as
>> arbitrary strings, why this one should be treated differently all of the
>> sudden?
>
>Are you asking me what the difference is here, or you're just telling
>me that I'm wrong and inconsistent?

Both I guess? I'm just trying to understand the rationale behind the
request, that's all.

