Return-Path: <netdev+bounces-143245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C766B9C1904
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 10:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 585D61F22AE8
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 09:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E07A1E0E0B;
	Fri,  8 Nov 2024 09:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iDIxy1yt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D871E0DAC
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 09:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731057689; cv=none; b=vAkGecvzLLp5SUuO1UQJ8Hh304ZijwsM5h+xkeYeKRjhBm9GADsUx1av5aJhtreNhAtMMqeEicdB48vnn9hHwcPAHPTUYp9YzAXjTtkNrTOkoxhG1TLaHP6gqpVkuDItd0EOLD0grCEAuI1UhVgegkRr0azv5iSUFUd8K8jheok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731057689; c=relaxed/simple;
	bh=ezc//63ABGnfEJIAG6zgWRh3da9q8ac7TWanh0tea2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EomBy5N1lMriXsdvULZTZe6DLRuBSk+sCWw2OZUeXSutN+amzy86U2/jDlYs2Si8XlAiVsUU0dAILd93WbS0DdB0pVD2mFnRL1efEI55UBdbhRG50RnBu6mzlcbekA96TTHX7awIuisXZyaX1X4/i9WPzapWyYWZ52kfApLBTc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iDIxy1yt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731057686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BUob6CfRFwWBXrPo93L+5jKilovByn2fvvak/bmVvMU=;
	b=iDIxy1yteQ0CWm8aS0ahTLlq838Da3X05eH/tewwEYOMvNrBbDQAMx03ZD2On4UwWgQ97H
	E4kSHTPqOFECZ6t9rzXtviKKZhieXhg+9lXayzsTOlRJh37m6m70z3fnys2Zu5D3KqHP9Y
	NnD06FeuvAjhCo2I9jN+m5IJDnwj40s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-9aBlcgd1NQmBXJBLJT9log-1; Fri, 08 Nov 2024 04:21:24 -0500
X-MC-Unique: 9aBlcgd1NQmBXJBLJT9log-1
X-Mimecast-MFC-AGG-ID: 9aBlcgd1NQmBXJBLJT9log
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-37d4854fa0eso1052608f8f.2
        for <netdev@vger.kernel.org>; Fri, 08 Nov 2024 01:21:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731057683; x=1731662483;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BUob6CfRFwWBXrPo93L+5jKilovByn2fvvak/bmVvMU=;
        b=X6USOt6pT0PW7PjnINY4fuRqUeu5aw03Jaep6a8ZTLmBbM8nfZC/dMx28cawz5IDLC
         GMlbCRALRqJqrHEbWhVXaLrixdg6582In+yZH0adSFwy5kGGMtzjPQX30IcPAInbf77V
         77M+uriOXX5wCjHJ+qOsfYBKIiY8VXvs5QCotFk3f1c8umG7TQ8TNtLDkB/yoBnDpoLV
         ScsVMSMLzT2zS8FiJe63hZ+CHHv23yLarwL19vOfbcgU3xPzkenkAR5SBowVMavsmoka
         w7pbFNS8uFxVHgn1AtBW85pTkpQJ6iCGee8Yxkt4wF5sGjk0oP3gb4XHq86m27qt3xWy
         VX5w==
X-Forwarded-Encrypted: i=1; AJvYcCVr5Lz2IsBIg52CcrnGYV1xAxIXbScnKh6WzXDW/KDHSpIYkIMAI6EvUwW1mxK0TzrlMlKDW3k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyuaHhLds5we19+/Ed8Vo2SHaJH+9Jw1/3DaJKHBFdC6zTbRVm
	P8wjOVADCQgdgAh3zE+3UE7u1o9AajwmiVpLeHBQKU9dCIf37Aibs/GdmXEq4hd+fUp+IY/YqV7
	2MlZBbHVfd3Pun/Ve7NCymOT2ufszZzFG4kkyKFxTD6RlDBnyx1s4PQ==
X-Received: by 2002:a05:6000:4702:b0:37d:45c3:3459 with SMTP id ffacd0b85a97d-381f186d35amr1592716f8f.21.1731057683322;
        Fri, 08 Nov 2024 01:21:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGVGfs/L7NKnoBA2cG/5GvEXqRNWl/qXhKUu3SADHB8yVXgRwxSaP0RSeWb5Sly07JEpnKcdA==
X-Received: by 2002:a05:6000:4702:b0:37d:45c3:3459 with SMTP id ffacd0b85a97d-381f186d35amr1592683f8f.21.1731057682650;
        Fri, 08 Nov 2024 01:21:22 -0800 (PST)
Received: from sgarzare-redhat ([193.207.101.111])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa6c037bsm90748985e9.22.2024.11.08.01.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 01:21:22 -0800 (PST)
Date: Fri, 8 Nov 2024 10:21:16 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jia He <justin.he@arm.com>, Arseniy Krasnov <avkrasnov@salutedevices.com>, 
	Dmitry Torokhov <dtor@vmware.com>, Andy King <acking@vmware.com>, 
	George Zhang <georgezhang@vmware.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org
Subject: Re: [PATCH net 4/4] virtio/vsock: Put vsock_connected_sockets_vsk()
 to use
Message-ID: <unazjzgdqrv65uxobcdvz6djts44zk67h676vvzy4fzl4wvghx@ofn3ehx3d6ck>
References: <20241106-vsock-mem-leaks-v1-0-8f4ffc3099e6@rbox.co>
 <20241106-vsock-mem-leaks-v1-4-8f4ffc3099e6@rbox.co>
 <ucfa7kvzvfvcstufnkhg3rxb4vrke7nuovqwtlw5awxrhiktqo@lc543oliswzk>
 <14fbd6da-9ef5-400c-9dde-afff3d2c7525@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <14fbd6da-9ef5-400c-9dde-afff3d2c7525@rbox.co>

On Thu, Nov 07, 2024 at 10:04:03PM +0100, Michal Luczaj wrote:
>On 11/7/24 11:22, Stefano Garzarella wrote:
>> On Wed, Nov 06, 2024 at 06:51:21PM +0100, Michal Luczaj wrote:
>>> Macro vsock_connected_sockets_vsk() has been unused since its introduction.
>>> Instead of removing it, utilise it in vsock_insert_connected() where it's
>>> been open-coded.
>>>
>>> No functional change intended.
>>>
>>> Fixes: d021c344051a ("VSOCK: Introduce VM Sockets")
>>
>> This is not a fix, so please remove the Fixes tag, we don't need to
>> backport this patch in stable branches.
>>
>> Also in this case this is not related at all with virtio transport, so
>> please remove `virtio` from the commit title.
>>
>> In addition maybe you can remove this patch from this series, and send
>> it to net-next.
>> ...
>
>Right, I get it. Just to be clear: are such small (and non-functional)
>cleanups welcomed coming by themselves?

Good question, in this case I think it's a good cleanup, since we have 
the function already there, why not use it. So I don't see a problem 
with that.

If you find others cleanups, it's better to pack in a single series, 
otherwise let's send just it.

Thanks for the fixes and cleanups!

Stefano


