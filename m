Return-Path: <netdev+bounces-115395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B88B9462AF
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 19:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8B42281A87
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 17:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D03B1AE029;
	Fri,  2 Aug 2024 17:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ml4ER3Q7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AACB1AE023
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 17:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722620567; cv=none; b=XzmT218HZiAFmV1jH1AAXjWgQeGl1mMqIwy01Lsdl+PlHtrdL45D/ISUhUORyAfOqxDxn+fIjuArSx7xBIRDPuk390BaNRC0ThgMVMxPHt8aHs67BE1dBuk+NYrGymJ8DR04wDIB4EPhxCKJsK7Ni6Yx9DzsvbNbddci/3CT5lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722620567; c=relaxed/simple;
	bh=J79iXNK9epessJfAB5+RZWmf9kNmVC6v30LXTrozZ0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oB0AfDWO1G09liAIjDq3CIuXeY4ytVuvuBSibfNEC9GT8GJ+axnbtUL3TRP4lizkAYkkgKMva8J6SdnjOIor+WYi4pfz8mfQNpU/kESHZxE3ZD7PPiJofqfg3ES0I089ml40DaF0WwPZZEfBuvZq7CPAWac4PdJ/pN+U/hvKFWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ml4ER3Q7; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-367940c57ddso4237318f8f.3
        for <netdev@vger.kernel.org>; Fri, 02 Aug 2024 10:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1722620563; x=1723225363; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Fo1Jw27d6kJ2c/4oihcpg8Bes1iWl/SxW8eqBhtNepU=;
        b=ml4ER3Q7tKUmSLMK9/Y9lBOJC0jnhjkxL60V8daqCpgSL69KM4/QDmua/HZG1jNNEc
         UubSMuhfpnN0fVosPv7rJQ51eSMek+ZnIJbGcDC1D4YkIEwZCknut3D8IrTkkr8Wz2M4
         bfQhNaexlCxL2s2Gu5OVa0rqQBXYQXMWPfChKmQ5kdRJut3TwJUUcFfuskK2u2ob7vFm
         NQJkxtQe8uSdPT0XlsdTT14MZey+8k/8vXY8D7yr1E62wZhz6Y/Sy8OqM/dpbLMvkcPQ
         gVYrvSYJOOzGQZctkkYJv6yoROAzefotGS2sTknJ4eQAwcZ+dYxouUuQ2spI1gWf5D46
         VAWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722620563; x=1723225363;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fo1Jw27d6kJ2c/4oihcpg8Bes1iWl/SxW8eqBhtNepU=;
        b=tcHsh3AbSGte4kCGhceqCzsOlaTmlztAz62EYb8lTN4X6HlJH/+9law5lv5DCJD6m6
         FLeDGayBpR1BCgFWUSkUNadUyOY2lYdLrUWGjh5BaMkn2L0qQ/sv4Op7b92V/t8hyOxF
         bx7NRCbBtFUIrWPpzcEo4HKlzy22ENeEAxt2T17oEKrcWTN/bV7qZQFUrJJxSozNER5U
         IsoJP93Tz7ihiHUAVXViZoMhQj5EAlhvMUSCI/yHG8/Exv544EKHA2dTtn3CINIjxU2E
         3p/nu5aaR/ACZu49dVvdvK3XFOlKJSWtzmFTJbqvJV6KsqAX91q1XGeama6t6HWJPIuV
         +FrA==
X-Forwarded-Encrypted: i=1; AJvYcCWK4o6qGT2Ex23DzZINpDABTmHWPmdtSTrEEWbULOUzhmEZ15efOUoGsnj1lsZqjz3ckvJd3Jo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/DWr2hcIEnFYHRcJZRsP/bnFOXgPwCVYiUmZXIpGgSmHHoX9b
	gum9W31ioeqk8cmmgASeQaG+Hfiw7Hs8fBwXvFdEVlFiKyYvhIEOENZoLusA9QE=
X-Google-Smtp-Source: AGHT+IGXsVHnYdTCw2tj0+vAdIxlzcZvHcvH/OjLs64ZjEQNrypWoVHtBio2oOUyzRbsNIVImEp+eQ==
X-Received: by 2002:adf:f345:0:b0:368:3f13:22fe with SMTP id ffacd0b85a97d-36bbc0e5fa7mr3103764f8f.23.1722620562940;
        Fri, 02 Aug 2024 10:42:42 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd06e100sm2438256f8f.98.2024.08.02.10.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 10:42:42 -0700 (PDT)
Date: Fri, 2 Aug 2024 19:42:41 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jeongjun Park <aha310510@gmail.com>
Cc: edumazet@google.com, davem@davemloft.net, kuba@kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com,
	syzbot+b668da2bc4cb9670bf58@syzkaller.appspotmail.com
Subject: Re: [PATCH net,v2] team: fix possible deadlock in
 team_port_change_check
Message-ID: <Zq0akdhiSeoiOLsY@nanopsycho.orion>
References: <CANn89iJDVNqnMiGYHGQissykzASK-DcLss6LDAZetnp34n1gxw@mail.gmail.com>
 <20240802162531.97752-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240802162531.97752-1-aha310510@gmail.com>

Fri, Aug 02, 2024 at 06:25:31PM CEST, aha310510@gmail.com wrote:
>Eric Dumazet wrote:
>>
>> On Fri, Aug 2, 2024 at 5:00 PM Jeongjun Park <aha310510@gmail.com> wrote:
>> >

[..]

>@@ -2501,6 +2470,11 @@ int team_nl_options_get_doit(struct sk_buff *skb, struct genl_info *info)
> 	int err;
> 	LIST_HEAD(sel_opt_inst_list);
> 
>+	if (!rtnl_is_locked()) {

This is completely wrong, other thread may hold the lock.


>+		rtnl_lock();

NACK! I wrote it in the other thread. Don't take rtnl for get options
command. It is used for repeated fetch of stats. It's read only. Should
be converted to RCU.

Why are you so obsessed by this hypothetical syzcaller bug? Are you
hitting this in real? If not, please let it go. I will fix it myself
when I find some spare cycles.




>+		team->rtnl_locked = true;
>+	}
>+
> 	team = team_nl_team_get(info);
> 	if (!team)
> 		return -EINVAL;
>@@ -2513,6 +2487,11 @@ int team_nl_options_get_doit(struct sk_buff *skb, struct genl_info *info)
> 
> 	team_nl_team_put(team);
> 
>+	if (team->rtnl_locked) {
>+		team->rtnl_locked = false;
>+		rtnl_unlock();
>+	}
>+
> 	return err;
> }
> 

[..]

