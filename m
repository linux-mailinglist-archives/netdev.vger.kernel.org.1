Return-Path: <netdev+bounces-240372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CA0C73E87
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 13:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 555A34E93F2
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 12:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E760330B37;
	Thu, 20 Nov 2025 12:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="JpS0W1TQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDBD2D4B40
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 12:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763640644; cv=none; b=KsJLkXJLzKOKrKPMG4uTxO/lK+sSD/qdrA8c3GuNmlnT5+kRR1rgsVlBJN835FDEbKUm5GHGP4fLCbEJcLMaCrnsc4TJHzngPP3Kzr+LsIJRuc9slnZ9G3Mc1Eh4+CIIRfLL6vl1RHHqKbaBPFkdWjCKQC4Cb4rzEEyQgb/8slk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763640644; c=relaxed/simple;
	bh=m/55A+V7WZGEwG/ncj8yq8t5mUIYMMWfG53tB0pcvZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dYDkuMIQKIMw80QYUP4XwZmroz2pkdSaIgRA+QXlWCA3yY5Gx3Ghy53dg2vVuYjccvG3bgYdfdZqhaCkpi2xHj105t9DA8V7q1qHxc6sRz3qqAPb+sRRDTZV1H+18ND6lAkgEBTyeGznaPMLppgqRL8QaTVSqBIKb2GyKJwV+7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=JpS0W1TQ; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6417313bddaso1144719a12.3
        for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 04:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1763640641; x=1764245441; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WF1V8Lo+g6bHb7nUgBgHOVWhKdwUKfl+CvDrWrbTRLE=;
        b=JpS0W1TQtjpMgjFr0ALEKxeM2swqebHL+/SWnD8SxfqXb4j0QTpRBO15kGrqejQV5D
         8sy307lJ81uIDPymcj3yWP4rqIXDq7/HBx951XeREZNeWObsWYBufxCPYFWrq8xCjPt2
         Pw8zCtj2X9Qtz+4zTA8uSZxrQboy0KB+ZTstsOPVHuhNwneGvo9QYsKcFW0QTrCeZMMW
         /fJ5n1YtuRyr5bf3SVkpXFuzPgfZtTIZHYFn8zx76uHjre+TkZdwplg941Wjt86Sr/gf
         MztxQeCdzDB2ZxzpbReGND73uucealWk6007JrzHiS8x+pL5W4DtAPcJEEEaqrIyi/fx
         XQng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763640641; x=1764245441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WF1V8Lo+g6bHb7nUgBgHOVWhKdwUKfl+CvDrWrbTRLE=;
        b=vsJETM3tpKVhICvb2LoSNBm7GUOGH6YCKs/8o2xhkLdsAwt/glZPjmUWAwyjn864Rc
         wRGcUcpJu++5zZGm65pSynxY5xsd4H5PDlUYgw4e+GOimHAU89eQd1y5xEEy7cetw7Yd
         F2AzG6FpD66bMIz7IgHq/dnuZYVWkwLcGPPOlEeK0Xe+Ixn/9GHrBTgbxnIU/VUG76ak
         4YCVFZHWxVcQBQZxkTr6OJ/142cvVdhCetriWkODtTdR6vgZCdvm4U7HqJswtF2XNVR+
         85ZEyFs8lQOrdF8diG96tj7KuIoycN8qUHNKvXxUCcEos9cY26y/u9Lon2T1T6DBTGnX
         pc7g==
X-Forwarded-Encrypted: i=1; AJvYcCW9M7HfvyQTxR1KHxYUB76rwizNuIt93iunS106Aj/F0YwGUA+jS9AxvrBmeg959wnZcYLLshQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQtP1ALKW79AuZrwBV/38ZKg7giyYP818RjK/GVLzt2+myDYEy
	1n24oT0g8z/iVVgj2ZCGkFucV59OHuyn0sf/TGAiNnN07Pc9YezKjktgZYgGCb/AW7U=
X-Gm-Gg: ASbGncul+V/J1C1J3ZQxQWFxOR36O+W9bE6r9i+VhRjKbmSHB0F/c1+md9v45kBcYqS
	e3V34bboIUQG+Wknp3iOD6cSkNzmmty0w6OyPS5/kb8o3QShO1f6GqnFnS59Rb7pkdQyaDaLkwy
	TJS9gt0mFdGXChDRMaO7/Y+XAavkKTt/UgzNhuY03RDImxTk5e/ADt3L4dU8Z4Ej6TiBZeEFVjG
	VYn0DquCzr9ANE7tNnJ1IpcuA7FQhFNOEGGdarh1EoGOqBDSv/+SIweNDsPALKr4DH0r8KY8Sls
	4MRcoCl5WWKvSFYJUI+pGsFd6eGqyYG3jPMgNrYItF+hmsRnjDeVx+7lPeSXHNJ608xT/DgYtcQ
	9yh6YvN3BV+tlQ7lA5jGLPolObnI9wvySsJO4/2k8Y82jgXE6oW5oz0dz//NiRdIMIApqJLMccF
	p4L6e4Ss1wdxl2l+ZKAtE=
X-Google-Smtp-Source: AGHT+IGM5o1dcZiUH1w1RTEoK20tGPiAAMV78u1JTMVCwkwgH8Ctfw+Tp03T9xXvviwGmWXpHVgtTg==
X-Received: by 2002:a05:6402:40c9:b0:641:6535:6ccc with SMTP id 4fb4d7f45d1cf-64536402014mr2636596a12.10.1763640640723;
        Thu, 20 Nov 2025 04:10:40 -0800 (PST)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64536460ee1sm1970033a12.34.2025.11.20.04.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 04:10:40 -0800 (PST)
Date: Thu, 20 Nov 2025 13:10:39 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Moshe Shemesh <moshe@nvidia.com>, netdev@vger.kernel.org
Subject: Re: [bug report] devlink: Move devlink dev reload code to dev
Message-ID: <itvidojyoklvtzlrnsufxwwrnpk3rxnhkhz4tygsgc2qrxyfva@ykpysuejrqpu>
References: <aR2GHqHTWg0-fblr@stanley.mountain>
 <35ekvmjyb4ty5vdkyspwirz4qoahotpow22zt4vkonqjmtqziz@yk6pwla34ayn>
 <aR4JWMyC7QHITJZp@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aR4JWMyC7QHITJZp@stanley.mountain>

Wed, Nov 19, 2025 at 07:15:52PM +0100, dan.carpenter@linaro.org wrote:
>On Wed, Nov 19, 2025 at 06:19:18PM +0100, Jiri Pirko wrote:
>> Wed, Nov 19, 2025 at 09:55:58AM +0100, dan.carpenter@linaro.org wrote:
>> >Hello Moshe Shemesh,
>> >
>> >Commit c6ed7d6ef929 ("devlink: Move devlink dev reload code to dev")
>> >from Feb 2, 2023 (linux-next), leads to the following Smatch static
>> >checker warning:
>> >
>> >	net/devlink/dev.c:408 devlink_netns_get()
>> >	error: potential NULL/IS_ERR bug 'net'
>> >
>> >net/devlink/dev.c
>> >    378 static struct net *devlink_netns_get(struct sk_buff *skb,
>> >    379                                      struct genl_info *info)
>> >    380 {
>> >    381         struct nlattr *netns_pid_attr = info->attrs[DEVLINK_ATTR_NETNS_PID];
>> >    382         struct nlattr *netns_fd_attr = info->attrs[DEVLINK_ATTR_NETNS_FD];
>> >    383         struct nlattr *netns_id_attr = info->attrs[DEVLINK_ATTR_NETNS_ID];
>> >    384         struct net *net;
>> >    385 
>> >    386         if (!!netns_pid_attr + !!netns_fd_attr + !!netns_id_attr > 1) {
>> >    387                 NL_SET_ERR_MSG(info->extack, "multiple netns identifying attributes specified");
>> >    388                 return ERR_PTR(-EINVAL);
>> >    389         }
>> >    390 
>> >    391         if (netns_pid_attr) {
>> >    392                 net = get_net_ns_by_pid(nla_get_u32(netns_pid_attr));
>> >
>> >Smatch thinks that the "net = get_net(nsproxy->net_ns);" could mean that
>> >get_net_ns_by_pid() returns NULL.  I don't know if that's correct or not.
>> >If someone could tell me, then it's easy for me to add a line
>> >"get_net_ns_by_pid 0" to the smatch_data/db/kernel.delete.return_states
>> >file but I'd prefer to be sure before I do that...
>> 
>> I don't see how get_net() can return NULL.
>> 
>
>It returns whatever you pass to it.  The ns_ref_inc() macro
>has a NULL check built in so it accepts NULL pointers.

Of course, I don't see how NULL can be passed to in in the current code.


>
>regards,
>dan carpenter
>

