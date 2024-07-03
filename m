Return-Path: <netdev+bounces-108642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C636F924CA2
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 02:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA6A71C21711
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 00:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DB339B;
	Wed,  3 Jul 2024 00:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKpiiDDn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9AA376
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 00:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719965435; cv=none; b=mhIBNvuUjVUD53kXG1u+5t7GJ3v8QXPhAeRg7/aoL8Esmhzv+ggV9IdNpeBv5yFfTWk/jUly/JRThBU8aiZ9HtOzUlywjMmuTvnMD8alXXklzWTEuTq7pLBQpWq/WpPMOCrWeEAqPzjVenJ3tNyIIEKLxANrCWr9VnQLzK6FDOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719965435; c=relaxed/simple;
	bh=TPjYhTvIMkQCpo5ebkpk5G8DoQFPADomF2M7GD8JGA8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ccfZjly4QiNJs/sWWJtJPMxUtlIlmxXpwUWh1lsLjNAc6zdPRBNf8hCiK3URRDmoT4RIWWuVaixknTJ8P/Ign5FKxKdftOMhUgOdigzhM09AueYxTFt4QS+3Z0TFSOwfnjg0jjAyRUhHL9GkapVrrNRLcHYfR/c7fo3pgTCmF4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NKpiiDDn; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6b5dd7cd945so3841426d6.1
        for <netdev@vger.kernel.org>; Tue, 02 Jul 2024 17:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719965433; x=1720570233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QIcJxv9YDtF/HEfsEYabnqsHSva40JQ/cs1DEVhaYGA=;
        b=NKpiiDDnsoHfYr8j4C+EPx/SIGUc2pXZxe0fI3gmy8aEQ+D32N9y8OTXR9V1X7n8Cn
         xE7NWuNDerYaXRUzipx4k/Ic7qRoOqiWV5j7GoetR/e4mWsnhBZpHHYmeArrPh4/qKcA
         2fDn7uLCt4r/BMnipBPxDgrLPeN25isKCo/J3o0b3/QIa3RDfTy8cK+Xww/gPKorwllI
         rzMG2+7gOco1OopObBwChLOWLC06AqOwg1r7onzBTiiasr8ChGxfGzhxDYzYCOjk1513
         0E8v8u2Of3sIEiGBAbLOt4Gu5ScI7k0pFxJ0u8EMeouaLoegnqVDMUOrjGiQNlJ86Vle
         Vz1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719965433; x=1720570233;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QIcJxv9YDtF/HEfsEYabnqsHSva40JQ/cs1DEVhaYGA=;
        b=LUN0NyQCBhVkTeMRiJhuDH/R9SmTi+yYNcp0O0Hmf+ASYirodS6bSBBa6qzLfZ3nG3
         hOZO4U30Iud3ShPyy/OCARUM7Fn6iIRkNq7gvqQxrYthtbA44MqK4ErR0935Ib2f8l/R
         ul7bcR3QRiN9MEGXnU9ejnz1RcOC5tPv9faMzzu7vlDVwb9X9Cfc7tJf07LnDVmb+Wqm
         dLKbdnvBBlqwR6ST+lN27exVY4GQY+eY9qdhoiopyhQkmH9nE3BEnb4o0Jehc/kvbv83
         Q+wo7G8IW90fz5fq+sD9Wvu6rgZReqFOTtaxZsvzrJaoz3Ar3shp9Irk7s5A9L1/PbE7
         g0MA==
X-Forwarded-Encrypted: i=1; AJvYcCWk+YUKB0X8VQM1K2BMbgegDnCFOUJ6tZmQ3q6aadOQFy3rWRspR4/Kn26kVJX61yqZ/L03UE0ODCwta1din7oC3MhvnxXV
X-Gm-Message-State: AOJu0YzGMhsdO66EoDhh+Ema3cj+20J7+8A2jLS05j/ipEj2J6fKY961
	bLrQhkNW86XAq5JfX16tP/yZTU6UKRJXdtxEpXJDhhuoUjxmk5xk
X-Google-Smtp-Source: AGHT+IECMzhQAyA+VTmhFaw/SgMmNKqVCMCvCQuIbZU5sNaz4zS7TV/I1JAluRRLuzj8TubgmB0ICw==
X-Received: by 2002:ad4:5ca6:0:b0:6b5:4c5a:a502 with SMTP id 6a1803df08f44-6b5b7148b19mr141242456d6.51.1719965432628;
        Tue, 02 Jul 2024 17:10:32 -0700 (PDT)
Received: from localhost (240.157.150.34.bc.googleusercontent.com. [34.150.157.240])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b5b7c4abe9sm34727016d6.60.2024.07.02.17.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 17:10:31 -0700 (PDT)
Date: Tue, 02 Jul 2024 20:10:31 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Zijian Zhang <zijianzhang@bytedance.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org
Cc: edumazet@google.com, 
 cong.wang@bytedance.com, 
 xiaochun.lu@bytedance.com
Message-ID: <668496f79fd0c_8889a294f2@willemb.c.googlers.com.notmuch>
In-Reply-To: <1596dbc6-65cb-4d3f-8e56-33842e3dcd2b@bytedance.com>
References: <20240626193403.3854451-1-zijianzhang@bytedance.com>
 <20240626193403.3854451-3-zijianzhang@bytedance.com>
 <66816f021ccc4_e25729443@willemb.c.googlers.com.notmuch>
 <1596dbc6-65cb-4d3f-8e56-33842e3dcd2b@bytedance.com>
Subject: Re: [External] Re: [PATCH net-next v6 2/4] sock: support copy cmsg to
 userspace in TX path
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Zijian Zhang wrote:
> 
> 
> On 6/30/24 7:43 AM, Willem de Bruijn wrote:
> > zijianzhang@ wrote:
> >> From: Zijian Zhang <zijianzhang@bytedance.com>
> >>
> >> Since ____sys_sendmsg creates a kernel copy of msg_control and passes
> >> that to the callees, put_cmsg will write into this kernel buffer. If
> >> people want to piggyback some information like timestamps upon returning
> >> of sendmsg. ____sys_sendmsg will have to copy_to_user to the original buf,
> >> which is not supported. As a result, users typically have to call recvmsg
> >> on the ERRMSG_QUEUE of the socket, incurring extra system call overhead.
> >>
> >> This commit supports copying cmsg to userspace in TX path by introducing
> >> a flag MSG_CMSG_COPY_TO_USER in struct msghdr to guide the copy logic
> >> upon returning of ___sys_sendmsg.
> >>
> >> Signed-off-by: Zijian Zhang <zijianzhang@bytedance.com>
> >> Signed-off-by: Xiaochun Lu <xiaochun.lu@bytedance.com>

> >>   		if (cmsg->cmsg_level != SOL_SOCKET)
> >>   			continue;
> >>   		ret = __sock_cmsg_send(sk, cmsg, sockc);
> ...
> >> +static int sendmsg_copy_cmsg_to_user(struct msghdr *msg_sys,
> >> +				     struct user_msghdr __user *umsg)
> >> +{
> >> +	struct compat_msghdr __user *umsg_compat =
> >> +				(struct compat_msghdr __user *)umsg;
> >> +	unsigned long cmsg_ptr = (unsigned long)umsg->msg_control;
> >> +	unsigned int flags = msg_sys->msg_flags;
> >> +	struct msghdr msg_user = *msg_sys;
> >> +	struct cmsghdr *cmsg;
> >> +	int err;
> >> +
> >> +	msg_user.msg_control = umsg->msg_control;
> >> +	msg_user.msg_control_is_user = true;
> >> +	for_each_cmsghdr(cmsg, msg_sys) {
> >> +		if (!CMSG_OK(msg_sys, cmsg))
> >> +			break;
> >> +		if (cmsg_copy_to_user(cmsg))
> >> +			put_cmsg(&msg_user, cmsg->cmsg_level, cmsg->cmsg_type,
> >> +				 cmsg->cmsg_len - sizeof(*cmsg), CMSG_DATA(cmsg));
> >> +	}
> > 
> > Alternatively just copy the entire msg_control if any cmsg wants to
> > be copied back. The others will be unmodified. No need to iterate
> > then.
> > 
> 
> Copy the entire msg_control via copy_to_user does not take
> MSG_CMSG_COMPAT into account. I may have to use put_cmsg to deal
> with the compat version, and thus have to keep the for loop?

Good point. Okay, then this is pretty clean. Only returning the
cmsg that have been written to is actually quite nice.
 
> If so, I may keep the function cmsg_copy_to_user to avoid extra copy?
> 
> >> +
> >> +	err = __put_user((msg_sys->msg_flags & ~MSG_CMSG_COMPAT), COMPAT_FLAGS(umsg));
> >> +	if (err)
> >> +		return err;
> > 
> > Does this value need to be written?
> > 
> 
> I did this according to ____sys_recvmsg, maybe it's useful to export
> flag like MSG_CTRUNC to users?

Good point.

