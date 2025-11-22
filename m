Return-Path: <netdev+bounces-240951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 429E3C7CB3C
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 10:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6E33F4E484B
	for <lists+netdev@lfdr.de>; Sat, 22 Nov 2025 09:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17AB285CA7;
	Sat, 22 Nov 2025 09:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="XGyalS1n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE5AA2F4A16
	for <netdev@vger.kernel.org>; Sat, 22 Nov 2025 09:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763802884; cv=none; b=Kltazap+ACqD986GHu+SCEsElEByoCH//FzSAkvNcA+9h122Mp/E8u1dnPxBrhSv9mmAnEyB7vfHEr5VMCYh+ql96Ll5Gxr7khW2ri3RPHPMc4ib+9SnLbTkQv7SSTKWcWSGpDJDgeyxU44Xw2i4YRzrnZEPG7Ljc8G6zaB7k8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763802884; c=relaxed/simple;
	bh=H+01goabi4UebVYo9/hfDy2puduh6rhk53cwAPuJQCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pcwuIgBgpZBLJ342UMx9KSrhqq16R6Te8hhnL2PjtvBjGGhij3GQ+iTMXSx2G0nbTwZht5OUDLEIj1FhcgvT7+lsiBbFDibMairskiUhVoe4IkojpOW2RJGDS2zXYOEAhVgc3bb33BzTtmI5i5vndmJaGATvK/9wG/V+VgEv1og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=XGyalS1n; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42bb288c17bso1735995f8f.2
        for <netdev@vger.kernel.org>; Sat, 22 Nov 2025 01:14:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1763802880; x=1764407680; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=k2ehDcXqNmLRZa43scdlcQMWWr8uZ4wi/beI//utLyY=;
        b=XGyalS1nyPIIvOYbFnEfnWYLfSjYBWOboNa1eJT2Oyi6Jejm04xMPbkWoLP0rc67Kg
         xslRIatNCSl+sVD7YMV8X5GHMAdbWOQPO9U2QY8SJ3WZPyh5rBSQE1aeHLf5KGvhaG2T
         c0B8xBV/+5ZgrJih03iE8rz44CL2v2daLs+9DN9FAoWC0limW+p8HJlFDobTf9xaMiPP
         oxvFwNHlno6abQ2SIJLN+BFrlEdnc70fWCDMDamMiBj0QXaZkjFXlCsbHbs5SlmzA4JR
         uN7UUZee7ZGyfnthoMig8xP0lFmeoc27zri9xutSWyBmMd02rmPGP0sg5rvsedHuOfEc
         O+uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763802880; x=1764407680;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k2ehDcXqNmLRZa43scdlcQMWWr8uZ4wi/beI//utLyY=;
        b=N9FWUbAAjdza1JodmNu8RZX8Iaz+TE6GM4WmQqqH4WkNlCD6mP73Wou7QwPELEMmeb
         tTJlEM23m2rf3b320LzzMh/TvqD2E1F7/wpLhwjuT0rYyCf6pddLIjNuD1cUPVXenCJ5
         LIWyK3O92pB9VTNMsGdpMoKJ9I9034iP+G0AbLo0HWTlSFCODjqiU9ZQQ9H31k42+n7s
         WZXfLy5vrYKxRxdOQciG5w+JyaFP0KV4rLaGMjOLdQUUV86mGFjyTuPDThvvksz0yrG3
         6G0EyqBCuWmDpdrHWCEPBFdwU0Xl7QVEiTatsWR3q7sHhT9UqWG7FKnoo3t/L9MwNZrv
         2Gnw==
X-Forwarded-Encrypted: i=1; AJvYcCVxm5v7UcHgRfEIpkL25dS2PScZW/BCM5JXVwXPW4bdkzHGGU27qHlTGy77tG5qGeMI1MP9EaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsoTqqNcPlGwUQAXJBdXemPs6psxRrDXzRFpj/IFGHwAjSYS2H
	pqc7r97sHeIs0Nej3TFnzSEH1a4gFU+Sql579k3bq7r1Zho39nTU39GhP0mpjfWdiI4=
X-Gm-Gg: ASbGncsT3GKXxUEP4Lw3OlMGtULi5F6WGzrtsHlx4NVRAEFG0EF+IzAr2r0jriN939n
	TcxoK0ILzor63k2io7F6/UgObDNboewWYqideeHr4+G6pukpjzGyRQwXgPTHTc7h2fcJIrtmyU0
	yu6AjLHzLFi42+QV06WbEEE8oCSi/U2rovOvDyoZB2adkJ3FfFpsxptQh9fq4CU+bbWy5Xooy+W
	ZMfvIg8VOrNNvq0FiI4sbEIIe42QpPU3SH39FLIP6fwDqvEuaUM9ny2TUg2ud1oPLvwn4fgZPHw
	fAImiHj9AHi39DTbacs+KnSdNjui1mV1if1xD7MMWP4lgaPGKxBYcWUMH7vksskwOVabLoQkd3u
	yivZGJKbLPY9mnohd2ZMBOHcz1NXuLMFrniJEV6Pg0QIOgvfAqoJdPZOHQoim7Thyrn+YiPA/FV
	/q63nc9smqMlcdHpCtbYIOEruQ3J2jdbs=
X-Google-Smtp-Source: AGHT+IF1xC/ayVeZNuPt7Biho7pEGcvQ76qknkpXHKsH1yKuhY3KjnH8ugtj+/9a96LrzPEPmtjI8w==
X-Received: by 2002:a05:6000:1787:b0:429:d725:410c with SMTP id ffacd0b85a97d-42cc1d0caabmr5018172f8f.44.1763802879382;
        Sat, 22 Nov 2025 01:14:39 -0800 (PST)
Received: from FV6GYCPJ69 ([2001:1ae9:6084:ab00:7d8c:1d72:b43a:e19a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fa3a81sm16032477f8f.26.2025.11.22.01.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 01:14:38 -0800 (PST)
Date: Sat, 22 Nov 2025 10:14:35 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Parav Pandit <parav@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, 
	netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	horms@kernel.org
Subject: Re: [PATCH net-next v1] devlink: Notify eswitch mode changes to
 devlink monitor
Message-ID: <fiiqvm3to3rq6yzdvj2uybfqtolrlep63ttjtpa2p7x2p2y6xb@3wh3ya5ujeud>
References: <20251119165936.9061-1-parav@nvidia.com>
 <20251119175628.4fe6cd4d@kernel.org>
 <32hbfvtxcn3okpylfcgfeuq7uvrufpij4y7w6au6vxrernwthb@pdxvc6r6jl5z>
 <20251120065223.7c9d4462@kernel.org>
 <q5n6ata2nhrtbkcnemyuiuhsf43365uqpdrbhm2qvpckxkyyuj@u3ugwpyqab6a>
 <20251121064813.57f2018b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121064813.57f2018b@kernel.org>

Fri, Nov 21, 2025 at 03:48:13PM +0100, kuba@kernel.org wrote:
>On Fri, 21 Nov 2025 09:35:24 +0100 Jiri Pirko wrote:
>> Thu, Nov 20, 2025 at 03:52:23PM +0100, kuba@kernel.org wrote:
>> >On Thu, 20 Nov 2025 13:09:35 +0100 Jiri Pirko wrote:  
>> >> Thu, Nov 20, 2025 at 02:56:28AM +0100, kuba@kernel.org wrote:  
>> >> 
>> >> Nope, I reviewed internally, that's why the tag was taken.
>> >>   
>> >> Well, For the rest of the notifications, we have NEW/DEL commands.
>> >> However in this case, as "eswitch" is somehow a subobject, there is no
>> >> NEW/DEL value defined. I'm fine with using GET for notifications for it.
>> >> I'm also okay with adding new ID, up to you.  
>> >
>> >Let's add a DEVLINK_CMD_ESWITCH_NTF. Having a separate ID makes it
>> >easier / possible to use the same socket for requests and notifications.  
>> 
>> Well, you still can use the same socket with just ESWITCH_GET. Request
>> messages are going from userspace, notifications from kernel, there is
>> no mixup.
>
>AFAICT DEVLINK_CMD_ESWITCH_GET is already used from kernel.

You are right.


>We could technically use the seq to differentiate but that's not very
>generic.
>
>> For the sake of consistency, shouldn't the name be ESWITCH_NEW?
>
>No preference on the naming, we can go with _NEW, tho, as I think Parav
>is alluding to, we don't send _NEW when device is created (which would
>be the natural fit for _NEW). Perhaps we should?

devlink_notify(devlink, DEVLINK_CMD_NEW); - is this what you mean by
"when device is created"?

If you mean DEVLINK_CMD_ESWITCH_NEW, then I believe we should send it
both when
1) device is registered, right after we send devlink_notify(devlink, DEVLINK_CMD_NEW);
   in devlink_notify_register()
2) when eswitch config is changed in devlink_nl_eswitch_set_doit()

And for the sake of completeness, we should also send
DEVLINK_CMD_ESWITCH_DEL from devlink_notify_unregister().

