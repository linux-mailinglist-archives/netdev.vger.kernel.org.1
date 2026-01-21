Return-Path: <netdev+bounces-252023-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AGCyM8UUcWkEdgAAu9opvQ
	(envelope-from <netdev+bounces-252023-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 19:02:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 802845AF1C
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 19:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7D170B02B40
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 17:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B563A0E9A;
	Wed, 21 Jan 2026 17:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCCGwsSn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903DB32F761
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 17:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769017014; cv=none; b=isOLXdFN/O+pN7+QDjIUi5PWPdkxTIfx20Ux4PuBFGwxQZiHm4fo+ApHnAdanSaTuOXHORTO1gHv1QMPeHYuAGZtm8sLmaTg7dSjpxAbLRGUnY9ceIde/Q43sBjnRJngGKydWJNW6p1hHo3CxFCp/+QjHp1+aUkWXkh8wJL/0qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769017014; c=relaxed/simple;
	bh=tpGlhPJQhs6K29z4KKdexPB885DZk84UD04BRE7PW+k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X+CnoypvD7dJKG/FpJuhF5w5EAahuo2lmYqsI2jdX9oIU36A5JWxNMZdFcH4k+xi0Iko/VsyULrleWr5hACrX04AGYASWvwhLmf/lKjWBV9REfua6+VGwByOFR/5jArTVUDDBz7Gnjyj0FEkEeTwPVJnsiJFYeSSEA9LocXkIto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cCCGwsSn; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-6446d7a8eadso162004d50.0
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 09:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769017010; x=1769621810; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TzQpPNktFvNOdBi7+gsCZqhpBpuEURHyo6CUuqA6z7E=;
        b=cCCGwsSnRtmoCkAf/NTQtmaBasIN2I58Q15Ljxb++/KX+GhSiZ/IiKr6dn6nIzF/Qz
         N1/VL2O9l4io6YRGd/QZx2JxTaoe3km0Ux9s5s0uFOVmfZ4DrdIx5tHlEfnGjWlwVbgD
         Mm0CVcdR9PjNS5Pqba2TWoKXbXQ3hTnsxAta+gcYwXnQvRWGmReuuAxfXK+WVJ42w7xP
         HHZznvsa4G9/Z1WE3+wi4VZWZxLvSN6FCnjetTk2698CYz0oek0L0+RMSYU9Bj7R0gsa
         sGeyyBgemZDSTFqHIlYSpvicCd74Ff+j7gr8yCi2LKY2g7AL4vOu1gPNXxgOiG2iYlT6
         ijSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769017010; x=1769621810;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TzQpPNktFvNOdBi7+gsCZqhpBpuEURHyo6CUuqA6z7E=;
        b=rLUknv0cJC2J9EIhERWoEKAwVcCcCVYia3hEcdA+j6AcS37xyVBZ3CPqM1bzUEYqjW
         Q3i5W4MJbhgPYFf+0/WRKXcYCXgKBN/Y2BWezou7qZzZwt2+3p8GfO1QHCMJX3Gcwg9g
         I+7fcSUhCLNjs0uLgACoguBfou6O0rV/DOsE/FEsydFdIV63Xyx+bHdmd+IwiG+YeqtV
         bQo7VcNFriOPphvYrolmwSTuFkXpIDmQ4743ZNrddeRZVU6YHriPTS4CzqnAhnjo+SKG
         03oDi2yhrNCdt46vOIyQUml1CQIvrRS+WcweRTHyvAqMrcI2jUC13twyG+B84s70s5hT
         G7tA==
X-Forwarded-Encrypted: i=1; AJvYcCXUwLw/kGKg78rfGiVcyB6iPJepinzCpRJH74Phe/pDYvfdXhSj9XYtQjRz3Zu5WwlAfJsxle0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuCnyL/fxkBdQfywMkUEdLk+f4VENT/885n+Eh4lTV9sPmOdMV
	nSuhdRlanAm2ue8KHWpE0CckGl2mgXKGg6AuqbpJCzyW+1wLCX26ZdXk
X-Gm-Gg: AZuq6aL64LrOBYd0Q0IUMKU/eFg9L3g0J8CG9SilAm9fzbfX+krsZBkFnVRZXuaiU5k
	KcTy73McjeO0h9+OB031fi4kDNywsdKI2UIZ/OPvhu0RhBUVUkRR1tN0ZNvPsflNC/eufpE8GzB
	OnN7yaj7QA3yLNhx/Pp6Y/t/kXh0kAVWsIeOFRxQzMv25aLAitCapzuHz/I+tU6VgpE6zBo1Zi/
	FuqJIyhVT6Hf1F7ZXkAMykCcgAhrMAfRqisk2zFlXp3menbGuO3b3MuUjudqIiibcvCKzHampcr
	bvhNZ6lQnZsJ6pV19RnE6dHaC6s0CuCsJLoVE8OBtKcj9xO/4mjhr3ZxI5cDSDbrBzmCQmwDujy
	4ykVN891hvXG4zlA8pkSHYenDbjRk/nO81AkYSs9KjTHBYjREJHHZmrW4zOpjsnlFf+JpsQQQ6/
	k525LfDCOS5kHASGvZd7RoGSvttvvt33W7+rbVWjX8w0Gv
X-Received: by 2002:a05:690e:1c1c:b0:644:60d9:864d with SMTP id 956f58d0204a3-6493c872baemr4135180d50.92.1769017010185;
        Wed, 21 Jan 2026 09:36:50 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:d::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-649170adf11sm8096311d50.16.2026.01.21.09.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 09:36:49 -0800 (PST)
Date: Wed, 21 Jan 2026 09:36:48 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-kselftest@vger.kernel.org, berrange@redhat.com,
	Sargun Dhillon <sargun@sargun.me>, linux-doc@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v15 01/12] vsock: add netns to vsock core
Message-ID: <aXEOoCqMvsbN2gtJ@devvm11784.nha0.facebook.com>
References: <20260116-vsock-vmtest-v15-0-bbfd1a668548@meta.com>
 <20260116-vsock-vmtest-v15-1-bbfd1a668548@meta.com>
 <aXDYfYy3f1NQm5A0@sgarzare-redhat>
 <4997118e-471c-45fe-bc1f-8f6140199db5@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4997118e-471c-45fe-bc1f-8f6140199db5@redhat.com>
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252023-lists,netdev=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[31];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 802845AF1C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 05:32:34PM +0100, Paolo Abeni wrote:
> On 1/21/26 3:48 PM, Stefano Garzarella wrote:
> >> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> >> index a8d0afde7f85..b6e3bfe365a1 100644
> >> --- a/Documentation/admin-guide/kernel-parameters.txt
> >> +++ b/Documentation/admin-guide/kernel-parameters.txt
> >> @@ -8253,6 +8253,20 @@ Kernel parameters
> >> 			            them quite hard to use for exploits but
> >> 			            might break your system.
> >>
> >> +	vsock_init_ns_mode=
> >> +			[KNL,NET] Set the vsock namespace mode for the init
> >> +			(root) network namespace.
> >> +
> >> +			global      [default] The init namespace operates in
> >> +			            global mode where CIDs are system-wide and
> >> +			            sockets can communicate across global
> >> +			            namespaces.
> >> +
> >> +			local       The init namespace operates in local mode
> >> +			            where CIDs are private to the namespace and
> >> +			            sockets can only communicate within the same
> >> +			            namespace.
> >> +
> > 
> > My comment on v14 was more to start a discussion :-) sorry to not be 
> > clear.
> > 
> > I briefly discussed it with Paolo in chat to better understand our 
> > policy between cmdline parameters and module parameters, and it seems 
> > that both are discouraged.
> 
> Double checking the git log it looks like __setup() usage is less
> constrained/restricted than what I thought.
> 
> > So he asked me if we have a use case for this, and thinking about it, I 
> > don't have one at the moment. Also, if a user decides to set all netns 
> > to local, whether init_net is local or global doesn't really matter, 
> > right?
> > 
> > So perhaps before adding this, we should have a real use case.
> > Perhaps more than this feature, I would add a way to change the default 
> > of all netns (including init_net) from global to local. But we can do 
> > that later, since all netns have a way to understand what mode they are 
> > in, so we don't break anything and the user has to explicitly change it, 
> > knowing that they are breaking compatibility with pre-netns support.\
> 
> Lacking a clear use-case for vsock_init_ns_mode I tend to think it would
> be better to postpone its introduction. It should be easier to add it
> later than vice-versa.
> 
> If there is a clear/well defined/known use-case, I guess the series can
> go as-is.
> 
> /P
> 

Our use case also does not need the ability to set the init ns mode, so
I'll revert this bit.

Thanks,
Bobby

