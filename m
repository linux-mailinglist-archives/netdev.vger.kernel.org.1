Return-Path: <netdev+bounces-166120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2E5CA34A72
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 17:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D15753BCC3B
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 16:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104A5200120;
	Thu, 13 Feb 2025 16:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8tB+YQ+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A5820013E
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 16:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739464163; cv=none; b=NLxPsB4P2coa9ccoDUGMkug1rNqt7KaMXDVad+nt5T9Gus1hiCu6exQMPRIEdeQGgxH973Kdw7sTH8SSIEqSzD7UUfuSpeBTfsuOSm+Ts1csRoHZXXIyck+85H8+oZZX/QelhGXiN6EUEPGzCKbiZgvRkIy8HguMf2dQvgJBYWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739464163; c=relaxed/simple;
	bh=ztckQ6veR3Zd+9ARIoiUSd1Tw2vbNbwZm1GWFQFfzbw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=CS7jsXDplhvaRjo9hT3aOVgMvIcwDimJhPrh3F9XSgLfVSVQotJSUo6wHBLTzhqmyTpeR/JNL492vDI3ViE0gu3HEiygMdfwexLAeqFJFWnDG9q4bnDNPq3MMtywgzPlBJ7OtJm1B26DovFeFXWrUiuk43bjQ0auWBWNo/XsxoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T8tB+YQ+; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c072d6199eso57103185a.1
        for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 08:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739464160; x=1740068960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C84vkflEAu7H0CO5H72DucA0scUC8F3BsKYWxpQT/CU=;
        b=T8tB+YQ+JKABNo9eN0Wd8OzGyRVY70wrtwRJ9w1ti1556yJgCf63smRc0kfqZ1SELS
         sFfJf7kRPUqvYGdqYSNuz9kTMyl78kuesmbgIHxBJKtOC9tNmic7Ng2//Sxnc0GwHlzM
         tFSG8MKpaDsXJZPbd8GQ5BQUobwiUU0A1v4F0JsanZ2GTMHrGcdTvDGvl6p/9GGRWyVf
         EhdszWXSDOqF1q7981nINhnaeWd/uaeZoTI6dbOUySsxCEbiyjjMKlflO8Qz6SL4FF3P
         IYIasmioqVBKKICYlhYQPMwxyMYDLi21pFNevFu4/LvE3EDBSceE0z7DMqbN8dOuubHB
         yjBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739464160; x=1740068960;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C84vkflEAu7H0CO5H72DucA0scUC8F3BsKYWxpQT/CU=;
        b=HhbXtfxOUiPI6Ik4HEbxy6pwY+v0NDeBbCfYU+5o9HF7z+LHWHTIOF0ht3NhgGdhoE
         hLm3NElepSIztuPKj9w7vk1swEGAdkiOS9JtDDdKDV1PnvnFQ/528k8bZDhIUHz4dSEM
         Q8SL0zMESixiI8M3iPtx2GLMFvGgj56bHuEAMr6Rdtigxbi8eSsYVvPUmfnHtKEEq4AI
         QQ166ZCsMloePWCX12/EabZ9TIdJI2DsYDsUPWH/Zy6VFOs3JiQTksDACwklGF+2zlqc
         y+V+ZFcsh25DMu5SrJhclIX2/c/3lROmli1WQmFTD40u9YxDgVjzBm31VuLHGWIIxdif
         TmPg==
X-Forwarded-Encrypted: i=1; AJvYcCUjVCwouew9M0ogb9TEdYS6fl/0FRBi/44MTA9eWa4UI1fTaro+tFA57tiJ1xVBHZHKOCNSyug=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3TQ5u3nJmRAIQD5KRcTYt/CRzfgd8RzILb7bnC4MJfKYq7BFe
	6R2lS66EDoUFckDgK6XtF5b2INR5tWwAnl6C7Lt2c9gEt9wj8sYeE6d9Qw==
X-Gm-Gg: ASbGncvpRu6XoYs5sS4Hb2uGwdQJYtZKDljt6VHuYy0U6cd2SORAmfdOpYbao0NbWoZ
	0x9WWpK/wKaET6M/RjFT+r0HjWsuQoIw5RwIWbKUBuzO+milRFzBzv19SQYzwBDtWbzzVelfWoQ
	S0AxYITFf4hPOQNSQ06OhMjrbwc1AgehT/3Ip+fMTlKJp0d0LUBPYvu7NgiSjV6+24vbdNvsGeX
	FE2jq6tRJIRWrPGumLUozTaOkGbAjQ8wbhtUgEyeBgaVzN4l8p+Xws5OXRbQAAa7oKAVmfWagqZ
	DiB0VNj5dzAtw6otxRRl680dcOfMsvDTEMOGkmCvbT75iGbN4x3ucX1lj1A0/Zo=
X-Google-Smtp-Source: AGHT+IFEa+mJBymH6ocgMmuNPYJvx2JKWx7nFLzTX/i0uS8/ViOhs/UFGHzf2IF4myxrQjnzFrgglQ==
X-Received: by 2002:a05:620a:2791:b0:7b6:d8da:9095 with SMTP id af79cd13be357-7c06fc6bf6fmr1216242985a.13.1739464160239;
        Thu, 13 Feb 2025 08:29:20 -0800 (PST)
Received: from localhost (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471c2a30b46sm9290171cf.36.2025.02.13.08.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 08:29:19 -0800 (PST)
Date: Thu, 13 Feb 2025 11:29:19 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 dsahern@kernel.org, 
 horms@kernel.org, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <67ae1ddf79d37_254fdb2949f@willemb.c.googlers.com.notmuch>
In-Reply-To: <67ae1c7ba11bf_25279029419@willemb.c.googlers.com.notmuch>
References: <20250212021142.1497449-1-willemdebruijn.kernel@gmail.com>
 <20250212021142.1497449-5-willemdebruijn.kernel@gmail.com>
 <10ef7595-a74c-4915-b1f7-6635318410f7@redhat.com>
 <67ae1c7ba11bf_25279029419@willemb.c.googlers.com.notmuch>
Subject: Re: [PATCH net-next v2 4/7] ipv4: remove get_rttos
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Willem de Bruijn wrote:
> Paolo Abeni wrote:
> > On 2/12/25 3:09 AM, Willem de Bruijn wrote:
> > > From: Willem de Bruijn <willemb@google.com>
> > > 
> > > Initialize the ip cookie tos field when initializing the cookie, in
> > > ipcm_init_sk.
> > > 
> > > The existing code inverts the standard pattern for initializing cookie
> > > fields. Default is to initialize the field from the sk, then possibly
> > > overwrite that when parsing cmsgs (the unlikely case).
> > > 
> > > This field inverts that, setting the field to an illegal value and
> > > after cmsg parsing checking whether the value is still illegal and
> > > thus should be overridden.
> > > 
> > > Be careful to always apply mask INET_DSCP_MASK, as before.
> > 
> > I have a similar doubt here. I'm unsure we can change an established
> > behavior.
> 
> This patch does not change behavior.
> 
> Does not intend to, at least.

I should have added that that is what the cmsg_ipv4 test extension is
for. It was indeed not covered by existing tests, unlike much of the
other changes.

That said, this is the least self evident patch of the series. If you
prefer I can send without.

Either way, I'll follow up with a cmsg_ip.sh refactoring of 
cmsg_ipv6.sh that extends coverage to IPv4.


