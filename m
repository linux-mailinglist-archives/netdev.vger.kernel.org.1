Return-Path: <netdev+bounces-284331-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAepFfDH+WlhEAMAu9opvQ
	(envelope-from <netdev+bounces-284331-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 12:35:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A985D4CB7C9
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 12:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A50243142357
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 10:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DDEB346E7B;
	Tue,  5 May 2026 10:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eGDbEP2C";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JgS1uo6x"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAD1347FCD
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 10:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777976788; cv=none; b=H98t7hVB+f1rollUcwupcCBjWOjSIg7T0cPTz5/mJmHJ+GRq6LSj9tbp5nuXgiGt5jZAeq5DdFF3c1pA+RII4TTjwLE5g6ftf/xmfW8nv5poMdB/Q1Bnuz8kOBG7i0d6yQJGp+ItrhptFLUTBB6d2RlNDoqIGGQJ7r06LxwJ67k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777976788; c=relaxed/simple;
	bh=RRVfVaOkvzElgVyb2yZpLwWWK5VmJ9IAKgLIwU5tDcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m7STcEoc1xTo8j8t/8tzFTXcEcQw1NEYsh8mlr+Gt5a/rFr7FC4phlZFIMRmdHBNo/xQsNjjtml9cv8bkh8ajjgdnHF0LIz/DB/YBkmhwEmICeCiAOECkZ4fI4lp4YK5sp35kVbBJ0wgUwLb4QdTZguYk461CCmFe4mObw7CkrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eGDbEP2C; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JgS1uo6x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777976786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1OCMbAA6XIkOk80k4O/cwTIGAofxbZ6zwNtF/F1aXko=;
	b=eGDbEP2C6NgHWsCRw46WhvmNp3RaXFAbb797/fKXI+jQ4KYzH0pkgaWeK0qGuLmnETS+IJ
	3xNB1EKGUfqpAW7uiV8/IH8SaQxM4sCMqgN1x/i8+ObomPiv4/jvKtLZ9j99rojgssPPBB
	JtGOf3xbsCoJx9EvkElAJI2dAYNk/s4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-IipBVjDuN8CWaNN4Ojhbkg-1; Tue, 05 May 2026 06:26:24 -0400
X-MC-Unique: IipBVjDuN8CWaNN4Ojhbkg-1
X-Mimecast-MFC-AGG-ID: IipBVjDuN8CWaNN4Ojhbkg_1777976783
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48d1bc85bb3so2150445e9.0
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 03:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777976783; x=1778581583; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1OCMbAA6XIkOk80k4O/cwTIGAofxbZ6zwNtF/F1aXko=;
        b=JgS1uo6xmcggPsJkl1C1y+OM04GxvtHWSPbB6lnzgLxjCqCSpm76nTWFbHZoaESpOV
         HNr+BXZTaoTwiHn0vaNOuLHjHb2btdmeXJeO3y90t9ACagZ/Z31RfmoV7p4Fl0uA8wDh
         poj2G1bDUHsGduk1kYHLkxkbfTq7yzodDHTSPxmlEdKOc1JmNeb9Caq7F7Ml7wuGEoFr
         kMPYIFl0sG3G2+AIVhjzyG2kag28zrrgT60gLOKSJkLy0LbzeftrJUx8EQQn3I7dKF5Y
         3px8Eoc90Ww4IMNqYwABYnNN+MjsPo89EptF9eDPyvI0XHlBab17RfAKMUt4JwPI7pcl
         3lPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777976783; x=1778581583;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1OCMbAA6XIkOk80k4O/cwTIGAofxbZ6zwNtF/F1aXko=;
        b=BJZmxA/DPhHfWZBMgo22Sx1egHVoZqf8M67PtUvEKVLyOh5XnofJQksvbyE/fsnGDy
         UsPeThq2nVl2f5laWp+oeY/HFiiVyn02yohHV7ta1hROUHtztx8SOB/u9KqifPvj1sS5
         SQCG9olVy06fXGQJ7mLGNPdT1hx4WsAFbzNMxhCjwP412VjyMkYb/oCcb81h5g5Oyy72
         AbTOV5YawyvPkhrO80XUFu5lD6bqvPGC9DsM+/oXW4HRd17yBxy6N8Xtzqt+g2jSWk1w
         ifMJOTFe+gD6BZyrL05X0DSTHSf74D9OQjuqKHNMr8pEE1MskQuefd+W2HLshXzN2sCf
         IgXQ==
X-Gm-Message-State: AOJu0YycUFpFG4LHW5Q94e8XGDUCsAQrVlZkVLyaFR2O24T1BFjaVfJk
	SE0NJYvLhKPVnE3kFYkEpvVc+JhrYPj1teyxgxwYkMeYwXW7cAXFlg8rcCcN2voflgX/TwaiNED
	1e4jAIewvO/HGvIYAGX3dukvc36531aWge4qp5BhRuW/wVkUGwBkCwxlKVA==
X-Gm-Gg: AeBDieul9WwqaiZJjQxd2cAMpy5z8nJrdVVBx7NgUHsiehm0HvLaECl80/gewq0WIOV
	N7R+f8zSNqbbC3j+8Rwdx7Ur9Sr3+OaVoQXMTa3Mjq820REaR+dulmuJ5x3vWukHLNpuiLaiCpZ
	Fb0K/wTG1OlzUtIpDrUAgl5lTJSeaXlz7072dSPt1cSMwU5TSpfYPZaJEegNWyRB/Cpw2OMhAPc
	WTqrEpa7/kwFg/hm2swakXucv+oFl/ffaiveAeJ1Lhb9xPoiASkoK17E9q6BqLN61x6qasvB/YE
	/l/XLM8ZdWnZ9eJyMoxq5j52DybuSmFg2/SCFl0WlKbgWp3qdyj7XTJigUrZ5PeZGXLThrQKeDl
	yEbjSbngMJl4sc1+EnRtVRoZnHfhT2uByLS9R0RkkpL0cELKzjhAAKqgJR0P4U+axHPA=
X-Received: by 2002:a05:600c:4e16:b0:486:f893:56c6 with SMTP id 5b1f17b1804b1-48d1425b450mr48869345e9.10.1777976783420;
        Tue, 05 May 2026 03:26:23 -0700 (PDT)
X-Received: by 2002:a05:600c:4e16:b0:486:f893:56c6 with SMTP id 5b1f17b1804b1-48d1425b450mr48868885e9.10.1777976782990;
        Tue, 05 May 2026 03:26:22 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.47])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48d17714dc8sm28079685e9.4.2026.05.05.03.26.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 03:26:22 -0700 (PDT)
Message-ID: <f4e52dcd-59ba-4c2e-9936-49cf27528b21@redhat.com>
Date: Tue, 5 May 2026 12:26:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vsock/virtio: fix vsockmon info leak in non-linear tap
 copy
To: sgarzare@redhat.com, stefanha@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, mst@redhat.com,
 jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, horms@kernel.org,
 Yiqi Sun <sunyiqixm@gmail.com>, kvm@vger.kernel.org,
 virtualization@lists.linux.dev
References: <20260430071110.380509-1-sunyiqixm@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260430071110.380509-1-sunyiqixm@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A985D4CB7C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,linux.alibaba.com,davemloft.net,google.com,kernel.org,gmail.com,lists.linux.dev];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-284331-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On 4/30/26 9:11 AM, Yiqi Sun wrote:
> vsockmon mirrors packets through virtio_transport_build_skb(), which
> builds a new skb and copies the payload into it. For non-linear skbs,
> this goes through virtio_transport_copy_nonlinear_skb().
> 
> Helper manually initializes a iov_iter, but leaves iov_iter.count unset.
> As a result, skb_copy_datagram_iter() sees zero writable bytes
> in the destination iterator and copies no payload data.
> 
> This becomes an info leak because virtio_transport_build_skb() has
> already reserved payload_len bytes in the new skb with skb_put(). The
> skb is then returned to the tap path with that payload area still
> uninitialized, so userspace reading from a vsockmon device can observe
> heap contents and potentially kernel address.
> 
> Fix it by initializing iov_iter.count to the number of bytes to copy.
> 
> Fixes: 4b0bf10eb077 ("vsock/virtio: non-linear skb handling for tap")
> Signed-off-by: Yiqi Sun <sunyiqixm@gmail.com>
> ---
>  net/vmw_vsock/virtio_transport_common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 416d533f493d..6b26ee57ccab 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -152,7 +152,7 @@ static void virtio_transport_copy_nonlinear_skb(const struct sk_buff *skb,
>  	iov_iter.nr_segs = 1;
>  
>  	to_copy = min_t(size_t, len, skb->len);
> -
> +	iov_iter.count = to_copy;
>  	skb_copy_datagram_iter(skb, VIRTIO_VSOCK_SKB_CB(skb)->offset,
>  			       &iov_iter, to_copy);

@Stefano, @Stefan, the patch LGTM, but sashiko pointed out to a
pre-existing issue you should probably want to address:

>  	to_copy = min_t(size_t, len, skb->len);
Does this length calculation account for the offset when a packet is
split across multiple transmissions?
If a packet is requeued, VIRTIO_VSOCK_SKB_CB(skb)->offset is increased,
but to_copy still evaluates to the full length of the skb.

/P


