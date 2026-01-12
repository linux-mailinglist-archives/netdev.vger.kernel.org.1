Return-Path: <netdev+bounces-249036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 00397D1302D
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 15:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF200301997B
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 14:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CDB35E55E;
	Mon, 12 Jan 2026 14:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LrFICoIE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BwJFCwfJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F2535E533
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 14:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768226894; cv=none; b=NpCAn8PCokNQrLkkczeqHaUbqquAoJxDwSf6kydJqd7Yt47lFtRNLjhSEimnqma5pMp+GndZuydCqxfq+pM8/tX08TDBE1khoRVEq6M3I55i1atjk0y4DSKXR8K++5smqOwvPMhy/ERSxePU7Xp1KZ/ELyx2waUQN9YjDQjL574=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768226894; c=relaxed/simple;
	bh=GKvx/1ooBKBcUVjPLmQrzQL3r3xI5Pp++pamyt5l+xI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DIK6yr7UjJgH4F/JJ5IB2jQqJKg5BLyiV4j+Q4dSWl1JTqqwHFuWEsLtpqXjS4MSiZv7qVb/BE4wsVhC8gMEqF1+SEAO7yor2O/EbPmKqNQyEv9pF1VnvZGUqHBbZG0l+lmtfFgPjDxYQJHH9H6KxoT84xScW5i4+Sh2TBX79/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LrFICoIE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BwJFCwfJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768226892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d5E7sq9k7DMQGsacG+F/JxI7pmnfHnE90xymu2cg9dU=;
	b=LrFICoIEIl/0jkdF1MTblPYiwVPxBfGRAgNolmyZ/jdAsR7R5DeJdJfcUuX/CGcKfA5JpO
	FSOHOffL5oHRqIhouWv9xExOdPLW3Ar+smNgBbXppgsazpd3luZPjB4cf8poW/vr/tqhUl
	veI/7K/T9z3iSlHEXjHZU0bxhP7M47s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-iF1kkqxMNs-7fjM_Er4UXg-1; Mon, 12 Jan 2026 09:08:10 -0500
X-MC-Unique: iF1kkqxMNs-7fjM_Er4UXg-1
X-Mimecast-MFC-AGG-ID: iF1kkqxMNs-7fjM_Er4UXg_1768226889
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47d1622509eso41827335e9.3
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 06:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768226889; x=1768831689; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d5E7sq9k7DMQGsacG+F/JxI7pmnfHnE90xymu2cg9dU=;
        b=BwJFCwfJem6coQD1TwibLTPyES5aolTKDn7+uDR48U2UVSCv0cmH9BTgK8lDLW1PCn
         gWgQx2kNe2daPhqRggid1DK5a52exJJ//p0cUVLU40lzJIzmMh222GwcptcXSkraLNx/
         YvQpXfcrGEeR5f5MFXKYWA6Qomh65uluDBTjWY3gRXJ8FAJA6zaxOrblgXPBUNPbjrAL
         pgWWRxpGkccJAxzVEjoWeAaK0krDY8bDPRmvk2sqzd0ophMSAJGVCK7i7UtPihOVJA9t
         3bgpn91/5q19NhrXDi++vUZCJ+DgQRHiIE9kClFte+I3jkXd0KX+EYXqCKZhol59riyW
         ZmWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768226889; x=1768831689;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d5E7sq9k7DMQGsacG+F/JxI7pmnfHnE90xymu2cg9dU=;
        b=N2qXe9YW+JJVsNJbClzMGdFutw7dAEH/aWWiDLYVDyriz0i3v9k4qxsa+z3yqvby2Q
         ttfeSgvFpBKMAvT+/eDYWtwLV9VTx1TlGe/cUpHVPZnv05L+CkNCxvRsi9XjAMu7/ADp
         IEFu/cuWio3Zn3KybeXa3wsBGwOCk+94OZhylqQfFlLI8g+CUODZyvfGypCnVQDz1sKD
         JgwPip91UlaaQpOvqi7qDkNmCpNxFhWWNSt8mFyc7JgZ0jUgeeIG8gOuB2rT5ZfO3mIQ
         4yaWCi1xuMf2bohbFHqo0lQ1xbKd8oTjp+8K0wSzARE3fN9lmEpumz0WFh1/MjrFoyq/
         dC6w==
X-Forwarded-Encrypted: i=1; AJvYcCUegdciVw0387Gt0ENvcY3qEKBQvYABeL7DUY/Ij3iB4oKyy8P5exwTCKSrr0267GV0f1LZh40=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3zEquFvJ6kQpGditBeHqR6xhs7ywYw3Dz5AdQ2Qzf6Uuu1N/c
	0qRdy7pSJGSoHlphjF8f6Z4VuyjOJuDghUNczByFl18Tbes9JMn0/v+xOeS3HiZG/6RkvK01I+e
	xUVL8GLDBvppyekuk6LkCNYyeKCt5CPDD43oG25lITrDTwzXrNPAxuyN8TA==
X-Gm-Gg: AY/fxX5I+7T6OGAVzraOtY2LWU1YE/01Ils5tiqi20lpkYEJT2Qxi4m/oY+4+sgkXTE
	yI3XFQE2quF+XXrx5j4exKs/hmUQuFDj2JFzJ8Y7iCk13F8hl9rV75wvfhmfWbizErQ/c+3RCu3
	ze+jNWVchFU+WixStXgqiBeRQOCLag/85U/g1DZcIUqLoiZLMBuYUIQvadeIFU/fXzr5BiK976+
	zfv2IjBBPtljOgmoq5yXSKuf2vbPaRT2N4R4m8JFrzooq/D/VmHo5c/1J9UnYyXgch9KcPWqWaF
	kXfJFq6dkAyOU5lodGs5SfzWvIXBC7lwcs3fPWDn+Ljd1VcYnRLabkoTUT3+h6sbTiHH3H8R/Y0
	KaCSvE+VemrJssSCZpEY/3sRKfsPTbocayDDkqB3q9YJwAoX8zZYG5t52XxRviQ==
X-Received: by 2002:a05:600c:a10a:b0:47d:92bb:2723 with SMTP id 5b1f17b1804b1-47d92bb28a9mr88376375e9.3.1768226888782;
        Mon, 12 Jan 2026 06:08:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFSA8MeLEwBc5V/8h9ZTRtoroYd4ri8KOUDoLboqzGTL/mHH9z1of/NksaN4ZE17gxAdWjfFQ==
X-Received: by 2002:a05:600c:a10a:b0:47d:92bb:2723 with SMTP id 5b1f17b1804b1-47d92bb28a9mr88375885e9.3.1768226888223;
        Mon, 12 Jan 2026 06:08:08 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-25-233.business.telecomitalia.it. [87.12.25.233])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0dacd1sm38203341f8f.4.2026.01.12.06.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 06:08:07 -0800 (PST)
Date: Mon, 12 Jan 2026 15:07:58 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] vsock/virtio: Coalesce only linear skb
Message-ID: <aWT-IkOVbrq1Bhse@sgarzare-redhat>
References: <20260108-vsock-recv-coalescence-v1-0-26f97bb9a99b@rbox.co>
 <20260108-vsock-recv-coalescence-v1-1-26f97bb9a99b@rbox.co>
 <aWEnYm6ePitdHPQe@sgarzare-redhat>
 <ae564ab4-2dd2-4a12-a92c-b613fa430829@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ae564ab4-2dd2-4a12-a92c-b613fa430829@rbox.co>

On Sun, Jan 11, 2026 at 11:59:44AM +0100, Michal Luczaj wrote:
>On 1/9/26 17:18, Stefano Garzarella wrote:
>> On Thu, Jan 08, 2026 at 10:54:54AM +0100, Michal Luczaj wrote:
>...
>>> @@ -1375,7 +1375,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
>>> 		 * of a new message.
>>> 		 */
>>> 		if (skb->len < skb_tailroom(last_skb) &&
>>> -		    !(le32_to_cpu(last_hdr->flags) & VIRTIO_VSOCK_SEQ_EOM)) {
>>> +		    !(le32_to_cpu(last_hdr->flags) & VIRTIO_VSOCK_SEQ_EOM) &&
>>> +		    !skb_is_nonlinear(skb)) {
>>
>> Why here? I mean we can do the check even early, something like this:
>>
>> --- a/net/vmw_vsock/virtio_transport_common.c
>> +++ b/net/vmw_vsock/virtio_transport_common.c
>> @@ -1361,7 +1361,8 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
>>           * to avoid wasting memory queueing the entire buffer with a small
>>           * payload.
>>           */
>> -       if (len <= GOOD_COPY_LEN && !skb_queue_empty(&vvs->rx_queue)) {
>> +       if (len <= GOOD_COPY_LEN && !skb_queue_empty(&vvs->rx_queue) &&
>> +           !skb_is_nonlinear(skb)) {
>>                  struct virtio_vsock_hdr *last_hdr;
>>                  struct sk_buff *last_skb;
>
>Right, can do. I've assumed skb being non-linear is the least likely in
>this context.

Yeah, but it's a very simple check, so IMHO the code is more readable if 
we put it in the first conditions, where we check if the current packet 
has the requisites, rather than in the nested conditions, where we check 
that the packet already queued can receive the new payload.

>
>> I would also add the reason in the comment before that to make it clear.
>
>OK, sure.
>

Thanks,
Stefano


