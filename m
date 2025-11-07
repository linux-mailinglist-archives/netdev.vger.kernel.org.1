Return-Path: <netdev+bounces-236578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0DFC3E119
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 02:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F6F93A86A8
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 01:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566AE2ED843;
	Fri,  7 Nov 2025 01:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UahQDDQx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9712A27E1D5
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 01:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762477249; cv=none; b=X1Z2OmqYwKXrxxSHY/cOQXM/WgetrV88CbXXnv+6YixYOV9AG5og5Xf45HfazRxbf2XBxk9mPWlRo4FBZTevIfxIcMezSrjFqP+HkGnOkM4WFdWbAPhhJpnZYmLN2bqbDBM7eANvWXJ1G08DEdyH8LkVvD02yjX3AW80GoujJr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762477249; c=relaxed/simple;
	bh=NZ4x6TEl3CJtkTGi+wP+m0cvmfYI0RmaIhfXqjufJuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hc5cYvSFBjqFQLN8QJR4R2TJBvRSoATbWW3JcXA74PqDjCYu+V/8K90szGJLqmxxf7N3np9rPsHnNCl/V+SOrzk4Z+ElKz1b3Lf8ueHHduZGqk9IqUN1ErN8eje+bSP3BsOj20q0s4NWNAf127V0d17iMhTl9B8SBhBKYv3Dklw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UahQDDQx; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-786d1658793so2457167b3.1
        for <netdev@vger.kernel.org>; Thu, 06 Nov 2025 17:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762477246; x=1763082046; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pUVfqUQtUqV0wkzqiVXGQWjP7m/o2AcCBa4KNQ5qB/w=;
        b=UahQDDQx2S/1+zIWEWiVhNo003fauqOQy5AgYuvhKeQE8tNtjf8bOQ5y+Fbu+luyQL
         /OIS8kOez8tLa5sC16jyzoYGdFn0H0g7ADg+OQv5rlbIDv6y+c8nT/mwsG4dqcsBVg2+
         Zd9J0FFDwC3yPL/myUA66ilAJp9QFkUzFpFse2pJfl0CGuA8BVmCmgivwtOmRexrgaXq
         thw+FHED6lMejoj3tTeRJjXPPdHGR/q71Ca7fIyC+8N0/P2tYQ9pWJ4WmtpaqYZqGFLi
         w/X4b9xDIu3VVJ7oELkLmb79HdkYAwV1XciG777JgLDOwH6lJP265XwVLwv4ncpqRjhG
         7XEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762477246; x=1763082046;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pUVfqUQtUqV0wkzqiVXGQWjP7m/o2AcCBa4KNQ5qB/w=;
        b=q84PlN6l6EY8+bJq5VDPyKw7CCnOPZa4XVBC0F1lYhobYx4gNxhTg2BNxT1SxrlQ/t
         1yKWmhwTuCe9jfeYqGlg3XRMaaCcuUSku8GZSwSJR7VozN/EtcyduS0Bwv6ZnUmE7HVA
         RtFC/feS/NFB32O22jRSjYHqALDc1376Knb/VuTdbfJjP8krOqyVJpZyIfoekoSpeSvT
         KIWFWXS0p56Y8cOxRANeWDoSCp7jxH4q7BspK8aHSop/PVHEtrlzobqyKhp3X5TZK8w9
         gnDVHDi4HJMSYPvgxhTYehYwz+xbFsNFMCTPWq102grD6muYRxLN0hUb7xod/2sClIoN
         pJ2A==
X-Forwarded-Encrypted: i=1; AJvYcCWQD9yfzkeBnssJt00zLMUTYGGZE1PVtrtyFmC8GEhkgxy3lKaaHAzwDeLlhB/1fd5TuNLm1uU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNNQ9LG8dWks4JHIkSA4TAdShOxuQxNBVN2/Alpfns79pZqVTh
	66iPavxpuJq/f3FNM5S8fJw/Oq0IVsoNvg3lrNdB4D5CP5TKVD71JDH3
X-Gm-Gg: ASbGncvD4R7M4cWqr8Azt62ShENGG/iQiaZ5eNiEbpXgioWUnWkF7EeGyRy8KNhuTNU
	FwiXL+mmo8tZhlBknOgwhqETKpd4QPSzMjus5mCmQDnxf2cYbgjdCmqFN41MEfsZPRyYkabKLvo
	Z5j/20ROQ5EmUTDvai0qo0blhDhliYFYGLY+XU61Yk3EPI/mydurROFVbE/qmrbW/oKV1K35HhE
	yDEKUw17XPKt6ncQqrTIcu4VVeDz0Y3NCwlcOM8+WYuQwm6tdpygfkbyuw0rWnpb/gJ8LbDTQN2
	VUS9DX+91YDKIjU593BW04yGhU1djY3FSyYo9PyCssYjLjmC9wsTbi1nLIn3vz/LqruDV9QV0Od
	m4UX3jEpCLkPxw4G1rcEjuQSa8pP85t2SHKe1vcjxK/GmtbKE+EDOUHseWOnD3/vGo0ffz6Dwxr
	KFT8CtFS17aEeXM99OYUqMEHpOzIhDp3P4p47D
X-Google-Smtp-Source: AGHT+IGXlZDS/7AIW+f4SW9AQZ+mYsEsFZB3pq1/mcaIGtLtZbgr70tzGom2CV/dzdZ26+pnChUzJQ==
X-Received: by 2002:a05:690c:360b:b0:786:6076:e8d6 with SMTP id 00721157ae682-787c542e985mr22214027b3.57.1762477246594;
        Thu, 06 Nov 2025 17:00:46 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:5c::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-787b15ffc52sm12984557b3.54.2025.11.06.17.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 17:00:45 -0800 (PST)
Date: Thu, 6 Nov 2025 17:00:44 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
	berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v8 00/14] vsock: add namespace support to
 vhost-vsock
Message-ID: <aQ1EvN3q90v3r3RD@devvm11784.nha0.facebook.com>
References: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>
 <k4tqyp7wlnbmcntmvzp7oawacfofnnzdi5cjwlj6djxtlo6xai@44ivtv4kgjz2>
 <aP+rCQih4YMm1OAp@devvm11784.nha0.facebook.com>
 <4vleifija3dfkvhvqixov5d6cefsr5wnwae74xwc5wz55wi6ic@su3h4ffnp3et>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4vleifija3dfkvhvqixov5d6cefsr5wnwae74xwc5wz55wi6ic@su3h4ffnp3et>

On Thu, Nov 06, 2025 at 05:23:53PM +0100, Stefano Garzarella wrote:
> On Mon, Oct 27, 2025 at 10:25:29AM -0700, Bobby Eshleman wrote:
> > On Mon, Oct 27, 2025 at 02:28:31PM +0100, Stefano Garzarella wrote:

[...]

> 
> I just reviewed the code changes. I skipped the selftest, since we are still
> discussing the other series (indeed I can't apply this anymore on top of
> that), so I'll check the rest later.
> 
> Thanks for the great work!
> 
> Stefano
> 

I appreciate it! Thanks again for the work on your side reviewing.

I'll address your feedback and rebase onto that other series shortly.

Best,
Bobby

