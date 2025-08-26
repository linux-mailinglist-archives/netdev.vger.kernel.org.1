Return-Path: <netdev+bounces-216904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D906B35EC2
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 14:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E3BC7A5EE1
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 12:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520E729D293;
	Tue, 26 Aug 2025 12:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="er2dw5UF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B729A1C5F10
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 12:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756209919; cv=none; b=abTBhYkgq+XCfZ6Cw8n4A8WXTdWKF8v9Zdk0/gRIwHuVDJfL5sgLPVORY1ihP/42eS8+BSoxBe9d3lH5hQnNCSpEYLbXox9Z9RVnfAEMj3cMg+zLqsCnhqejU2576W9SQ8dQX9M3AeO/WfMx/CUgzma2Zl8WupAXudJYJoDXqkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756209919; c=relaxed/simple;
	bh=TOGdKw85dJTbjIhknIuxHsOHfB1xD9yGU4QiqRpVg3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qVC+rIgzt3E2DTB6Q3seFdZyuETQE97RMVDSmAGc3gkBcEm8G30JYHuKiZuCaHZ0AwuyE02ESZSxlF/IsWcqXzR677Rd1H9JhblFVUdSdTlYvetQZRX+gKJDYR2WGQ6CfBxtw0+IpIBEGzEgbOzRm+zUdOqKPdU6Mrh+/4z7AbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=er2dw5UF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756209916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xjtwaBlBD81yFg2hxw6K0USx1InnGz1uKLVg75wM/z0=;
	b=er2dw5UF8ZiXCZeIDqW/vYmS2kdU/C5YBhXw9dZWIkF7CAkGQ5iggM+arPOUglQmpnzvdW
	vgF6tommcjv+yEUuCMbweTD3rBiUuHN/Q22FCr3/7nDn5wac6rfjDxDlZOfOYEeARgNteY
	KTt5M4vM7VAmGtT0eWqpsI+cjkGJlWA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-P0Q39sGHNK-TsxFQzsgqbA-1; Tue, 26 Aug 2025 08:05:14 -0400
X-MC-Unique: P0Q39sGHNK-TsxFQzsgqbA-1
X-Mimecast-MFC-AGG-ID: P0Q39sGHNK-TsxFQzsgqbA_1756209913
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45a1b0045a0so37852435e9.0
        for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 05:05:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756209913; x=1756814713;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xjtwaBlBD81yFg2hxw6K0USx1InnGz1uKLVg75wM/z0=;
        b=OaJwWqKJ7BnefDauO+xU4AAxY82MGsDUsJmXQCIXMLcHnuA0/N4elQntrnHzTgr6Ej
         syzus/6u/THx0v2ukoRWr9ujG8SuQuAKSdoCHJnxc5QSXxehBOqfQtCDpuQMolchIrcY
         +IMZhPEuwaIXp3VDVr6dah5gd+mSk3z+aPzHLGi/MvPqDClEgEJ+kdTDENaL80rbUyWM
         ORDGkmepTHIdIeatsBUG8qOofWItv5XnkusNQ6v9G3uyfxJfT8majIqXCzHTG6tYMzbn
         4wYZyqtRpLhGGJ4iPtDIcJVcS6xbC77U9giEy/cUJFnCQ7GCDjI19RhgjEBkDANwfShc
         UDRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqGzaZqJShnHQ4HxgJlFxe86ps7GfTlOhwPGsKtPfxdLXAK37QANHVVk5CGx5FhFwPBa0I13Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeESww44W77DyhIgthXoXMCofMYw7QdyoTrbQbV8bP2jj6NZTO
	6b2qSq3OycAA9jT6x8E8aRH6DnO49M0Zx2rsCifO2XwFzBZQ/NhgeEYn8o1h5rLJER2gLhUEioG
	2IvDgOsug07K4QwvixzVJzHLKIDjIYju7zk5RFi/V/tCpmF3FzduNQ1GlyA==
X-Gm-Gg: ASbGncvnVxYULrBpTeFe2WvdC4gHNEY36nAu+QHV4wMMgMJQ4aOFVOH1C3VI1Z472VZ
	iEPNs3tdN3YxCQ7MAj78X7FDtSLxQqm4D5GvUZ+kyAO4jRdGNX6jAyq/YbGn0G3rUBNA0K8FkTm
	Q6xIViR9VRZYInEwyFwe8RBrcsEZiFzVG2bsXDWExqT7nOk93HEPdiYEX49PXrzJiJ4X/ZnH0O1
	h1YT8eshMTnPn7WFWjMloUrAU6EY0bUmSfLPpi+LgFi70NLi2HsS6T/E7m82af3nudJR43Zk5/T
	Q8mHiGqh4760NZxXgnt1NGaL5s/ufQQjsESDbgR+py1E42a0hqOyzqOPz4fnebagTlVfE63il9M
	eyt0VfbpKpZg=
X-Received: by 2002:a05:6000:288a:b0:3a4:fea6:d49f with SMTP id ffacd0b85a97d-3c5dcc0dec3mr11785812f8f.49.1756209912908;
        Tue, 26 Aug 2025 05:05:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESRh+9eFogMiLBiX9mUifZNyKFqPNI/MTAlVt1+GIbNVeFTwAiEJnTYi/AYHCX45rLdF6dkg==
X-Received: by 2002:a05:6000:288a:b0:3a4:fea6:d49f with SMTP id ffacd0b85a97d-3c5dcc0dec3mr11785722f8f.49.1756209911489;
        Tue, 26 Aug 2025 05:05:11 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c70e4b9e1fsm17300022f8f.14.2025.08.26.05.05.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 05:05:10 -0700 (PDT)
Message-ID: <e3d43c09-7df2-4447-bcaa-7cec550bdf62@redhat.com>
Date: Tue, 26 Aug 2025 14:05:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v15 12/15] net: homa: create homa_incoming.c
To: John Ousterhout <ouster@cs.stanford.edu>, netdev@vger.kernel.org
Cc: edumazet@google.com, horms@kernel.org, kuba@kernel.org
References: <20250818205551.2082-1-ouster@cs.stanford.edu>
 <20250818205551.2082-13-ouster@cs.stanford.edu>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250818205551.2082-13-ouster@cs.stanford.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/18/25 10:55 PM, John Ousterhout wrote:
> +/**
> + * homa_dispatch_pkts() - Top-level function that processes a batch of packets,
> + * all related to the same RPC.
> + * @skb:       First packet in the batch, linked through skb->next.
> + */
> +void homa_dispatch_pkts(struct sk_buff *skb)
> +{
> +#define MAX_ACKS 10
> +	const struct in6_addr saddr = skb_canonical_ipv6_saddr(skb);
> +	struct homa_data_hdr *h = (struct homa_data_hdr *)skb->data;
> +	u64 id = homa_local_id(h->common.sender_id);
> +	int dport = ntohs(h->common.dport);
> +
> +	/* Used to collect acks from data packets so we can process them
> +	 * all at the end (can't process them inline because that may
> +	 * require locking conflicting RPCs). If we run out of space just
> +	 * ignore the extra acks; they'll be regenerated later through the
> +	 * explicit mechanism.
> +	 */
> +	struct homa_ack acks[MAX_ACKS];
> +	struct homa_rpc *rpc = NULL;
> +	struct homa_sock *hsk;
> +	struct homa_net *hnet;
> +	struct sk_buff *next;
> +	int num_acks = 0;

No black lines in the variable declaration section, and the stack usage
feel a bit too high.

> +
> +	/* Find the appropriate socket.*/
> +	hnet = homa_net_from_skb(skb);
> +	hsk = homa_sock_find(hnet, dport);
> +	if (!hsk || (!homa_is_client(id) && !hsk->is_server)) {
> +		if (skb_is_ipv6(skb))
> +			icmp6_send(skb, ICMPV6_DEST_UNREACH,
> +				   ICMPV6_PORT_UNREACH, 0, NULL, IP6CB(skb));
> +		else
> +			icmp_send(skb, ICMP_DEST_UNREACH,
> +				  ICMP_PORT_UNREACH, 0);
> +		while (skb) {
> +			next = skb->next;
> +			kfree_skb(skb);
> +			skb = next;
> +		}
> +		if (hsk)
> +			sock_put(&hsk->sock);
> +		return;
> +	}
> +
> +	/* Each iteration through the following loop processes one packet. */
> +	for (; skb; skb = next) {
> +		h = (struct homa_data_hdr *)skb->data;
> +		next = skb->next;
> +
> +		/* Relinquish the RPC lock temporarily if it's needed
> +		 * elsewhere.
> +		 */
> +		if (rpc) {
> +			int flags = atomic_read(&rpc->flags);
> +
> +			if (flags & APP_NEEDS_LOCK) {
> +				homa_rpc_unlock(rpc);
> +
> +				/* This short spin is needed to ensure that the
> +				 * other thread gets the lock before this thread
> +				 * grabs it again below (the need for this
> +				 * was confirmed experimentally in 2/2025;
> +				 * without it, the handoff fails 20-25% of the
> +				 * time). Furthermore, the call to homa_spin
> +				 * seems to allow the other thread to acquire
> +				 * the lock more quickly.
> +				 */
> +				homa_spin(100);
> +				homa_rpc_lock(rpc);

This can still fail due to a number of reasons, e.g. if multiple threads
are spinning on the rpc lock, or in fully preemptable kernels.

You need to either ensure that:
- the loop works just fine even if the handover fails with high
frequency - even without the homa_spin() call,
or
- there is explicit handover notification.

/P


