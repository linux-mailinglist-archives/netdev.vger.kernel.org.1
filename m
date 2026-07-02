Return-Path: <netdev+bounces-304039-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OSuSCAMpRmpqKwsAu9opvQ
	(envelope-from <netdev+bounces-304039-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 11:01:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAF76F509E
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 11:01:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=QQKxZv9Z;
	dkim=pass header.d=redhat.com header.s=google header.b=g+H1OBUj;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304039-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-304039-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2028630923BD
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 08:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB914367F2F;
	Thu,  2 Jul 2026 08:56:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED88449EB0
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 08:56:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782982578; cv=none; b=SQcxD64jTAuLKV1LfzXTE4k8/fQvyJVJAIJouT1jJ1iedOke7fk6CAS3V+ICxaR3IOY7yQinImeo0AylZrobkzauZ3pAYWsg45MSeOIpx07oI25A1bADQWzkuNzx/T8qJYPFb/WZGvPsg9y/QIwu88dyCp5Lml6TUKkS1QNW+5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782982578; c=relaxed/simple;
	bh=IqR1f/AEimWy9td6sTkb7Jq/+F4NeD8zy8Z1IlmH0fM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RszeWfLg9y7d1g1SBKe/R5HOpFYhSnVUqpDGr18o9Wnup5qsJ8tINxCqmFGEgVNEK+z83WJYNaEISeGSdf8WTNLyGSzalHv5G8PBCOydU+cl1k1bOpGTwWjKcKLPVLl47QWZ/TYTDu6d0HGFOrDJqCAdVl5J8jsAJhsN2uymLzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QQKxZv9Z; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=g+H1OBUj; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782982575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jzu6+yi+0UPBChb/E9Oct0h9dnkvsRVovpFSB+irYu0=;
	b=QQKxZv9ZUwB8+EDVgDDZRNLjyMvPfdTPuE9l0AlqGR3rcvgiiAiOlRErgQaxqbM+Q0EmiD
	DgBhoY6J6TOA0ScSxYAVuauZrygt+QsNNnoA8zbkIM9rU/9TYGQlOabOi4m1ACzTK9mWmR
	7AsZmmHxpeMR9MZjVadOkF/0QAba0iw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-0uFqEfyGNKaIcwi9H2APVA-1; Thu, 02 Jul 2026 04:56:12 -0400
X-MC-Unique: 0uFqEfyGNKaIcwi9H2APVA-1
X-Mimecast-MFC-AGG-ID: 0uFqEfyGNKaIcwi9H2APVA_1782982571
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-492714d002cso11302695e9.0
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 01:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782982571; x=1783587371; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jzu6+yi+0UPBChb/E9Oct0h9dnkvsRVovpFSB+irYu0=;
        b=g+H1OBUjhsMBbbQW0qzr+CQZod/o5/IvBj2mdzDYzZ2Kd1COtqsUb4fLZHQiuCLDv1
         FXTSkJTGHC03c5CIBDky5P385pJXxoUGYjzh9lGEig+OyrIiLNle7OdDiQ22ntFpaRzY
         WoxmpdSBi6vikaaMbxC5b4tf6xpdQ6y2tf1WyegdSbHMj92t5Kz8Ma1yhyLLP27ji11Q
         chnKeTNzoxWlQT+51J7v0Ln4pYCy/mNxbPnQtglPHzaI0FyPa0TiXjzOSywIQBW9FDJk
         /6K73a9CVDAh2QyA8DW2XSyu0fOobhVW6dA6I0DU66IYEJT3lJ+sZUTIYdDgq21KTIGs
         kLYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782982571; x=1783587371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jzu6+yi+0UPBChb/E9Oct0h9dnkvsRVovpFSB+irYu0=;
        b=FNhzZg7/pqw1Io9w2UeOP3VcO0UVj0kM4QmIh2DvdmLH14EkiRCRGsYvm/GKJ0hEYj
         vqB9RPBxLjILkm/n/q61pCepRO36dF8mnTRljKByg/reCtW4GZcAc3jI3fZkSWjaEFB5
         OPdrTSjLHV72EqlKNJn/eHqM6eDzB9fJxtNn7jvYbUl+SFTcnbB1zuw4zA7N8cy69Aih
         LN0njKZEaHUVEtSPkBVIhmlsl/hphQ2ELghZtJvS1Yv/0tPLIR/AnOdzGjh0ZiZnYtTU
         MnpvA9XVFIn5NCYeQiGENkkGMd4FjumcoE0vnjsbiUsLiQXiLEgQFg3mJkQJ+0PmwnrA
         IyhA==
X-Gm-Message-State: AOJu0YxZXViHqs4rKbuOpi9apRdafdoW4qONmW44fe8wW/v01jyDCkmi
	1T5OWh9q1MlaZ7GLgbarw/W3XpWeRYL5BZe7P912mEkhfznVM6GSsc0D0IY4b2KctpNNu/8BVjQ
	c0Eua+xC6P68Rtk0eWafMYHWpQUtBfhKLHcUaq8htw4V0sr1MKCPUsaygHg==
X-Gm-Gg: AfdE7cnBkCfEp0XNzHeu1hDPCT5mdz2ExP8+uhCpFt5c/Pvb9ZwZIXibLEDL97rpZ+f
	KkjESNyo3uZVtLQ8irCcLkTWbCkYRxk5HGb5N8Elw5KVw1hk8Piv7tsHlw54jCw0Cyfj2O1U8rR
	9vAhWeYYm8XGJkpuTN5UgjeYXsWREApKUeK53oRu32VN7bpWkWf3NX70b5URoSBq2Lar+yCS2Vg
	KO2Zdn4socwORhr7Pq/3fUNY+FhXAZTo3WhsyPq+2V6WJkdDjw6E6l7ZyafrctYS9F7qMW6FRPV
	frPZhdNdjjb33+DeKlJVqiM6aQAPiRwlAV4k2vzamRRsx03lXxuQYyP5OFCFWbDg6eRY0LF1IQh
	3Zx6J4UGfhI5M0zowHHxErR2Xl6HaC3xePeUphRH/0IctMPynnHAUHpCZlbRT
X-Received: by 2002:a05:600c:5391:b0:490:c032:ae92 with SMTP id 5b1f17b1804b1-493c3df2b42mr53317705e9.33.1782982570897;
        Thu, 02 Jul 2026 01:56:10 -0700 (PDT)
X-Received: by 2002:a05:600c:5391:b0:490:c032:ae92 with SMTP id 5b1f17b1804b1-493c3df2b42mr53317205e9.33.1782982570427;
        Thu, 02 Jul 2026 01:56:10 -0700 (PDT)
Received: from sgarzare-redhat (host-79-34-22-35.business.telecomitalia.it. [79.34.22.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477ddf0f27bsm6829505f8f.30.2026.07.02.01.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 01:56:09 -0700 (PDT)
Date: Thu, 2 Jul 2026 10:56:04 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eric Dumazet <edumazet@google.com>, 
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
	Stefan Hajnoczi <stefanha@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, stable@vger.kernel.org, Brien Oberstein <brienpub@gmail.com>
Subject: Re: [PATCH net 1/2] vsock/virtio: collapse receive queue under
 memory pressure
Message-ID: <akYl38_9Y4ydXuqE@sgarzare-redhat>
References: <20260626134823.206676-1-sgarzare@redhat.com>
 <20260626134823.206676-2-sgarzare@redhat.com>
 <akVBmydgSd0Eb46/@devvm29614.prn0.facebook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <akVBmydgSd0Eb46/@devvm29614.prn0.facebook.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304039-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bobbyeshleman@gmail.com,m:netdev@vger.kernel.org,m:jasowang@redhat.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mst@redhat.com,m:kvm@vger.kernel.org,m:virtualization@lists.linux.dev,m:xuanzhuo@linux.alibaba.com,m:edumazet@google.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:stefanha@redhat.com,m:davem@davemloft.net,m:eperezma@redhat.com,m:stable@vger.kernel.org,m:brienpub@gmail.com,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,kernel.org,lists.linux.dev,linux.alibaba.com,google.com,davemloft.net,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2FAF76F509E

On Wed, Jul 01, 2026 at 09:34:35AM -0700, Bobby Eshleman wrote:
>On Fri, Jun 26, 2026 at 03:48:22PM +0200, Stefano Garzarella wrote:

[...]

>> +out:
>> +	if (new_skb)
>> +		__skb_queue_tail(&new_queue, new_skb);
>> +
>> +	skb_queue_splice(&new_queue, &vvs->rx_queue);
>
>I think the new skbs will also need skb_set_owner_sk_safe(skb, sk)
>when adding to rx_queue?

IIRC we added it in the rx path, mainily for loopback to pass the 
ownership from the tx socket to the rx socket, but here we are already 
in the rx path, so the skb will never leave this socket.

Maybe it's necessary for the eBPF path?

In any case, I can add it, but if you can help me better understand what 
it prevents, that will also help me add a comment above it.

Thanks,
Stefano


