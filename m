Return-Path: <netdev+bounces-181193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5100A840C3
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 12:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4971E8A0876
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 10:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E05281512;
	Thu, 10 Apr 2025 10:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cs6zMhPe"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48870280CCA
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 10:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744280933; cv=none; b=ZEePDU3rHOinABjeqXZkZxWjH8RnwcK8SRWIMnopTWKBDJ/IfeDPvrX9dZ3kQiKFd0Fw0SiVRvqCqjbRU5uiUDx125cH4le5qtOJH3tUKIlok7Ce5UFlgna4UBmYrVe97UEtLrmByTnsdmcDKiU9OpcZRnsE7Tc05mhM8wKNSg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744280933; c=relaxed/simple;
	bh=WcAd3LXlDteij8yOQv38VMsI99IN+S818EGpm6QqSEY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QBVzz4XyT3CXgulY7SnDdvLM0g5z7YV4F57CyHL7QINh1QSav9OaEroV2w5gcvw2I9D/Um164BUl6dm+6F3eabmKYVoUP9Y/gsKsryQiGRjtdfP3ls3lV4MEm36kIxYa5p00+VXL88xLSyxEOzUddFlediArCp+EJoANLNGdkbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cs6zMhPe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744280930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KS1NBEWRL3nfliiTC1ZmXDkGU6+q8mzvG/pbAxW5e8Q=;
	b=Cs6zMhPepdFVGsTJXTj/jh8zpuI4t9sg7dblZtbz1KJsWDSTTgOjG+Ko51GBYDDOJeCia/
	9bvJMWAnZPc5JYDeAdIh2B/qIg7mCLk1aVpV2o3J1fVZhLqkuYRfr0helbErX5m0HDZfgl
	zrhwjpqeAYplleprS14ZY3H5VynK5OY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-lr1VMAoVNW-skoAnKamQGQ-1; Thu, 10 Apr 2025 06:28:47 -0400
X-MC-Unique: lr1VMAoVNW-skoAnKamQGQ-1
X-Mimecast-MFC-AGG-ID: lr1VMAoVNW-skoAnKamQGQ_1744280926
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5e83e38d218so791287a12.1
        for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 03:28:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744280926; x=1744885726;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KS1NBEWRL3nfliiTC1ZmXDkGU6+q8mzvG/pbAxW5e8Q=;
        b=NhU1Ti5WAqt7bCKjZrEOBdkayuSPaAJbvovQMSGtc9kax9EfOVoHZBWkC7CZoNo4Dg
         mFxxBnUEQ4yQizxjuQmJ0vYcxvlte9Ik5YW4jXNZEaZife+FKM6q/+oZqe//m4qVySqG
         4AvLI2UW8ZQtn0Ntem9bDkEETrE5THniHpCYjkVWuf+t1HfFMn1/eWbjBFUtSrCmAMTj
         OqqGA2YFfmJAukUpg6p4ehY5X12u3djm7D2xA8nTIq25XFkXv+QGv/tqaof+inC3x3lx
         /2DKDyjeYPBKYnZbWtOyR6uXDnT2XjLnpwiIIDgHl9K+cxmQ41F1Feq50vt4W0QYq/1a
         mO7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUU4MmMqz7sdpbVXHqo8qaAcwvpkhWBF+IyxIrt+iPzxAzVQjSM0Yf2O1HM9Hfo8PNT3IKdYGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNAqNzh1IOIGWY/E3858v/+JJ8cY+lxfSpSJ0pIvWOwtcKOZAs
	nQ2bRf9VCGBtqxMP+maaATJ567zYYCt+MIsAg2BIC7pb8Lw2Q0Wl2ES12jwy8+rcwsYmncSGvnm
	kwNwoeJt+i6f36w4SWHpUicTqQEwfSHkSOP1CFDCCBN82xik6jTScaw==
X-Gm-Gg: ASbGncszarZik1d8PpZp6AZvB43YiYJMdocw6jZERfB7fi8LXqJuRbL55Pff4V1hLmz
	MONL7TiA1j3N3Ek2L5Itf/+T5qJS39bIidyOSxKkj6pEhmBVsZ04LF9FYzRCkC+hYqVYce0qS4q
	4IUOZbAqTCN4iRD+lPOqy8UwiHv20kvRv0ocSMXJnpT7KAYL1Qjpt1AsmYQBC4ZWCGdu5vMr4Sh
	0t/sjs6JpJG/okSiQe7lPEFEKhwIhlZ3mljkImLd320vTdW3A6mRbmjYVMFVIvloIWT4Lhu4GME
	EZ6kR3Dvn+PhvMPr8cn2IPvzEmOHE0WIm3J7
X-Received: by 2002:a05:6402:2349:b0:5ed:53f7:a46c with SMTP id 4fb4d7f45d1cf-5f32a138c66mr2012005a12.12.1744280925847;
        Thu, 10 Apr 2025 03:28:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmEHsSt9yymbJaNVRemNEVltMzzyLUuZaB6vGJOx950oe1qnR3PePRtIZSFlg+l+TsZftBAA==
X-Received: by 2002:a05:6402:2349:b0:5ed:53f7:a46c with SMTP id 4fb4d7f45d1cf-5f32a138c66mr2011982a12.12.1744280925469;
        Thu, 10 Apr 2025 03:28:45 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f2fbc2b975sm2099500a12.33.2025.04.10.03.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 03:28:44 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id A8A651992275; Thu, 10 Apr 2025 12:28:43 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, Ilya
 Maximets <i.maximets@redhat.com>, Frode Nordahl
 <frode.nordahl@canonical.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
Subject: Re: [PATCH net] tc: Ensure we have enough buffer space when sending
 filter netlink notifications
In-Reply-To: <Z/awKFETLHDwN6dE@pop-os.localdomain>
References: <20250407105542.16601-1-toke@redhat.com>
 <Z/awKFETLHDwN6dE@pop-os.localdomain>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 10 Apr 2025 12:28:43 +0200
Message-ID: <874iywux7o.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Cong Wang <xiyou.wangcong@gmail.com> writes:

> On Mon, Apr 07, 2025 at 12:55:34PM +0200, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> +static struct sk_buff *tfilter_notify_prep(struct net *net,
>> +					   struct sk_buff *oskb,
>> +					   struct nlmsghdr *n,
>> +					   struct tcf_proto *tp,
>> +					   struct tcf_block *block,
>> +					   struct Qdisc *q, u32 parent,
>> +					   void *fh, int event,
>> +					   u32 portid, bool rtnl_held,
>> +					   struct netlink_ext_ack *extack)
>> +{
>> +	unsigned int size =3D oskb ? max(NLMSG_GOODSIZE, oskb->len) : NLMSG_GO=
ODSIZE;
>> +	struct sk_buff *skb;
>> +	int ret;
>> +
>> +retry:
>> +	skb =3D alloc_skb(size, GFP_KERNEL);
>> +	if (!skb)
>> +		return ERR_PTR(-ENOBUFS);
>> +
>> +	ret =3D tcf_fill_node(net, skb, tp, block, q, parent, fh, portid,
>> +			    n->nlmsg_seq, n->nlmsg_flags, event, false,
>> +			    rtnl_held, extack);
>> +	if (ret <=3D 0) {
>> +		kfree_skb(skb);
>> +		if (ret =3D=3D -EMSGSIZE) {
>> +			size +=3D NLMSG_GOODSIZE;
>> +			goto retry;
>
> It is a bit concerning to see this technically unbound loop.

Well, I did think about that. The loop will terminate eventually by
either succeeding, or failing the allocation. Most likely the former,
since this is only called after a filter has been successfully
installed. I.e., it's not like the amount of data being put into the skb
is unbounded.

>> +		}
>> +		return ERR_PTR(-EINVAL);
>
> I think you probably want to propagate the error code from
> tcf_fill_node() here.

I just kept the existing return value (of tfilter_notify()) for the same
error case. tcf_fill_node() always returns -1 on error, so I think it
makes more sense to keep this?

Paolo already merged the patch, and I don't think it's worth it to
follow up with any fixes, cf the above. WDYT?

-Toke


