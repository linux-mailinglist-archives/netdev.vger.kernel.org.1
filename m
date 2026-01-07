Return-Path: <netdev+bounces-247662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4894ACFD194
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 11:05:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4BE430E5E85
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 09:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2AB329E4D;
	Wed,  7 Jan 2026 09:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DvOQnoPf";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nrDO4YG6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88466326931
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 09:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767779285; cv=none; b=pvvyZc8DmxvD81zcDLmf8gV7etRbJaL+b5vnV0ROYp52ICspGXOfc5N31hgTKCzB/Y/5OCsNJWCIwkNrFpViMRzqCgDfG69I0vr7Fh4c9/85LayJYaHdRwPAbOjaXZL0w0vLKvZtk3JJtjtR4xZ8l35MSfmcs4jdZjzICgOzKOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767779285; c=relaxed/simple;
	bh=wnY5o/MC+2tKe4BqCdLjMx+OdS/yCXDDRqj+BryQq2k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TJLV+4ZQD2WMiq6SPTG8Q0seUEFZZp/P0hy1W8SD1wUx4E3doiY3Pm/wCsrUpo+XRf/0Va2Qt+7RrjQS/IKpbE5fvBBXuanHixW/APSG4gMPcQsxcpS4oeqC+llzZQhU25lXdeAuLqTsr5kmrT9KzU2+PvU11S/Bfs4TQpX+BI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DvOQnoPf; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nrDO4YG6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767779282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ScDN5rAHIF+neP5c5OtPOLevrSkBcpaaU/NLEzKk+zA=;
	b=DvOQnoPfrABYvoAb11LDQPpoMPDQtYeh/suMnfVgJmkREk7vsIQ2EVq7X+ilvffpUxXI6f
	lL3Sfwx2Zy46x6s7xIlKND4GNc/12y3yFyviou9/BTYdsCXxkWwFqsVKAdT1nlUJeBC5d9
	VENPAIFSCp7SgHjM9MR57PWC2fBuxtU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-d4aNNw2rMKGBe7i6YsHEuw-1; Wed, 07 Jan 2026 04:48:00 -0500
X-MC-Unique: d4aNNw2rMKGBe7i6YsHEuw-1
X-Mimecast-MFC-AGG-ID: d4aNNw2rMKGBe7i6YsHEuw_1767779280
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-477964c22e0so5363415e9.0
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 01:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767779280; x=1768384080; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ScDN5rAHIF+neP5c5OtPOLevrSkBcpaaU/NLEzKk+zA=;
        b=nrDO4YG6w0MA+JKrTncee5xr2L1/+ogL9H0+5crMCSElWuO0bj8ggy6t1F5xp5YERO
         BjiPHA37Sb8SO1m6qCL++/BjTqEeAqJcgL7ehwDcaKMj/d96A9lFbeaJCTr5zoh5Fbdx
         Dhe2AYFQj/wAHlxmjQcFrSKP2xNaVTnIdRHiB1EhulAnffUUuE3FfSIZnwwckdXvsqt2
         W0GmoN+fJ8SmpcAsUHpUDQobu620Pps79MjlSL3aDuTsQ3jdWZhEBlmExIF2Gzbfy+or
         f6sRTYeMrIi8Qx+qAlk9ANtfNGlM3T+9PZQTORZKuTtIvxY7CV5p/Kv1covmGkIm7Txk
         l4NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767779280; x=1768384080;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ScDN5rAHIF+neP5c5OtPOLevrSkBcpaaU/NLEzKk+zA=;
        b=vLj4aVvvTv1LFlUM7m5wlIZlzvnHrGEcT/PjTyR6Qg0iNlM94rnx9me5kng+4axPBV
         CV0R+E/z/bRUTw0e50Rq/wrNKrSl+/nGRHrOVlHEcjhBKIIyxxZBAPRo4Tp3usyqocG6
         DI99OKNp7g9rcdEg4RUZG5MOJy/ZCEHyBAsMWkLBGybUr5bHYxjcV9rclokU9tjUqQYP
         2fkW+QXMs/5Gn+hL9yy0Lyr4udC9AroJnXiDaV6CsOdqQ0QVqnMAsSkfcxJEVgSj5SiS
         VVQ2l3PPT4c6xR0ZoM07tmLR6Jd20md29h0wYi1kuckTQuzSmeaJMtOEqLud16V0QYAQ
         jdKg==
X-Forwarded-Encrypted: i=1; AJvYcCUZWTjCRkv1NS+TzAM9uLi/O34Gl166PgMmp+QBlAL8nJNSuib/RBfxUyZx5oNE6zz5rDzqGGM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5EweVuDIaEASlcaiQBoImEmoFrLhrqYSUZsSAK76SJ6yPAKuR
	qCCJAxcD7gA5BtvTjJxm1X45F5yGfXaGe1sQlZ4J7M7+hb8bLJW/BhF9tQGPehyd3weBD4FyI0q
	i/LHTjUYWGwq1eGnA91pPhHeTOdgNMwBRl+nf9hJ8gNgOKxTb8c7abE15pw==
X-Gm-Gg: AY/fxX6kP38LR2n5j8cQmtXvuwW4ZFn/HO+tNqmYUqdIKw4nlr8iMqXsZyZG8SpI3Sp
	SAwHEnTpzOeExp0m4g1w+cS+/B0fqXUnUNDo3hynN8GhwJiYlkFMV6YN63Gsy1tf2MlpY4jlZuR
	61CWiyZRMs2EV0nRFubHPt0IAbuLC404n2vqPibVp3wfZ0K5RGqnbVguRWGwjZP07HCy3vPpqBG
	mibr84HNKMU21XfanJYhM4BdP5Tt7f8vv0KByT6yDEPDy6rSszReTKtZLxSpkes7IIpYFknj76Z
	n+Bsbd7ZsHfCEUENHGHyEzzfUL6PLlZOvpXVmp/aHSRrbDirD8RGnGbNxy/5dC1YezGBopTnpYt
	qfIJZ8g8Yr8L0lg==
X-Received: by 2002:a05:600c:3ba9:b0:477:9d88:2da6 with SMTP id 5b1f17b1804b1-47d847d0f30mr23929015e9.0.1767779279701;
        Wed, 07 Jan 2026 01:47:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGR14oCSs320qahGMCj2fpcjCaeoaq3gXPszOqvA9YkYZCVCcyOQTMHSiIeVJj9qvkiojdvAQ==
X-Received: by 2002:a05:600c:3ba9:b0:477:9d88:2da6 with SMTP id 5b1f17b1804b1-47d847d0f30mr23928485e9.0.1767779279246;
        Wed, 07 Jan 2026 01:47:59 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.208])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f69e13bsm86823385e9.7.2026.01.07.01.47.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 01:47:58 -0800 (PST)
Message-ID: <99b6f3f7-4130-436a-bfef-3ef35832e02c@redhat.com>
Date: Wed, 7 Jan 2026 10:47:56 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 04/12] vsock: add netns support to virtio
 transports
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "K. Y. Srinivasan"
 <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa
 <vishnu.dasa@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kselftest@vger.kernel.org, berrange@redhat.com,
 Sargun Dhillon <sargun@sargun.me>, Bobby Eshleman <bobbyeshleman@meta.com>
References: <20251126-vsock-vmtest-v12-0-257ee21cd5de@meta.com>
 <20251126-vsock-vmtest-v12-4-257ee21cd5de@meta.com>
 <6cef5a68-375a-4bb6-84f8-fccc00cf7162@redhat.com>
 <aS8oMqafpJxkRKW5@devvm11784.nha0.facebook.com>
 <06b7cfea-d366-44f7-943e-087ead2f25c2@redhat.com>
 <aS9hoOKb7yA5Qgod@devvm11784.nha0.facebook.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <aS9hoOKb7yA5Qgod@devvm11784.nha0.facebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 12/2/25 11:01 PM, Bobby Eshleman wrote:
> On Tue, Dec 02, 2025 at 09:47:19PM +0100, Paolo Abeni wrote:
>> I still have some concern WRT the dynamic mode change after netns
>> creation. I fear some 'unsolvable' (or very hard to solve) race I can't
>> see now. A tcp_child_ehash_entries-like model will avoid completely the
>> issue, but I understand it would be a significant change over the
>> current status.
>>
>> "Luckily" the merge window is on us and we have some time to discuss. Do
>> you have a specific use-case for the ability to change the netns mode
>> after creation?
>>
>> /P
> 
> I don't think there is a hard requirement that the mode be change-able
> after creation. Though I'd love to avoid such a big change... or at
> least leave unchanged as much of what we've already reviewed as
> possible.
> 
> In the scheme of defining the mode at creation and following the
> tcp_child_ehash_entries-ish model, what I'm imagining is:
> - /proc/sys/net/vsock/child_ns_mode can be set to "local" or "global"
> - /proc/sys/net/vsock/child_ns_mode is not immutable, can change any
>   number of times
> 
> - when a netns is created, the new netns mode is inherited from
>   child_ns_mode, being assigned using something like:
> 
> 	  net->vsock.ns_mode =
> 		get_net_ns_by_pid(current->pid)->child_ns_mode
> 
> - /proc/sys/net/vsock/ns_mode queries the current mode, returning
>   "local" or "global", returning value of net->vsock.ns_mode
> - /proc/sys/net/vsock/ns_mode and net->vsock.ns_mode are immutable and
>   reject writes
> 
> Does that align with what you have in mind?
Sorry for the latency. This fell of my radar while I still processed PW
before EoY and afterwards I had some break.

Yes, the above aligns with what I suggested, and I think it should solve
possible race-related concerns (but I haven't looked at the RFC).

/P



