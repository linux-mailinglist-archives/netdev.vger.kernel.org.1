Return-Path: <netdev+bounces-295185-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RmBWFIFaIWp+EwEAu9opvQ
	(envelope-from <netdev+bounces-295185-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 12:59:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DEE8F63F40E
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 12:59:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=I4cyXq2j;
	dkim=pass header.d=redhat.com header.s=google header.b=MI9EvFI5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295185-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295185-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14F35301F9D4
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 10:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6096A40629D;
	Thu,  4 Jun 2026 10:56:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4733405C52
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 10:55:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780570562; cv=none; b=hQ3I78KaZBBDsHGE0F1NetaLUhRa5rQX+8wKQkT1lbrXZ53gufink2U1Gk1Bb4vc/R0rByP46Exj3gZTgoYkG7lXgrdBUnOP8WcuSRbrdusj7piD3BTJnAozGW8b/7qVDAJnLcnOB3wm9YUXjTGRPE5cOYM5jxlU4C23hX5gWcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780570562; c=relaxed/simple;
	bh=7PDVjOFFBvB62jh1T+5fxxeccqZf3wobQfN0ejWBl+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OtGyBAt034B5qn7eJOpE+lKrhkdRQ0CIQ3x83Tk2TtwAhY+98c7LOnWQjFBvo/NcEq1NWc85VVLY1aasOMpyhEb+zVcP2C6nVHi88GE4cEvO6LnpLfO3dQOHhJ9BDTaCt774VNeZ7M56vMpb/9Ac0P270eRNXk00jwMjM6vImkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I4cyXq2j; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MI9EvFI5; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780570558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7wklQVRsViMBNiTmJy4yFl6j2hWwlYVgd/9iVl7uSjw=;
	b=I4cyXq2j1MXxWa4MHZi8HHFkB55NiitQqhTwRK5EjBbkwwV6XqzEMuAI298hIw7j+IeA4D
	xN0CLLEqM1DAo4dX8xFUoRN5kgi0UEhnlkfDiaMvxJ9aIBukniBT0HuoFAYmpX/JfxOjOV
	Szye3FORi5arkASpFok5Fj+jXOr/Bgk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-G3FWmn1oOaSJ8JxYxkEDnA-1; Thu, 04 Jun 2026 06:55:56 -0400
X-MC-Unique: G3FWmn1oOaSJ8JxYxkEDnA-1
X-Mimecast-MFC-AGG-ID: G3FWmn1oOaSJ8JxYxkEDnA_1780570552
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-45ef5e38a18so287070f8f.1
        for <netdev@vger.kernel.org>; Thu, 04 Jun 2026 03:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780570552; x=1781175352; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7wklQVRsViMBNiTmJy4yFl6j2hWwlYVgd/9iVl7uSjw=;
        b=MI9EvFI5CC492CNU1fnOZp0eV9EwEJ3muBcXeBfSLBLuG7XJFSapj1Za9v8hw6SiVZ
         bFoTynRh2bExwPgVOiOic52NPaeBITTOJsOJs9F+T0mSuI5LYPAbetIBCcAcXyZHlTYE
         2iM6zJwUYnPVOPtRnx2w1afksrn1P/NAe70hyHoEml68K5ap0j1aObZHaje9LViTQq/h
         Gcb8UeA2YppKS+vRg8w2PGfVmwwSSk4vbpZ3z03JquRN2rl/yeYZFjVSknUajYrdMGrh
         8PJzYqfbYcT6ZgbajW2ChvKV9os/h2XAvI/6hbLR9DGIJW4m0pYsz1nbO0VklJoDAxfN
         3UQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780570552; x=1781175352;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7wklQVRsViMBNiTmJy4yFl6j2hWwlYVgd/9iVl7uSjw=;
        b=VGQiKXzNsqegHeloAK1Ct61hm9SJLKT3hXcMvYCJZh7bGjOb0RLQ1e+D0VIH7kP6Jc
         DJ2cAkByx2iMlEDuUncOwS1ph33soBA76WYzPvmYfr4qb/YGHMPODmQcsl1RAtUPxGo5
         BwuTUtYcRlCs5pUyBXe4pNuCYdsvdAY5GqpdgRroDOgzJsiwXVYwTLYHrL7Em8ShUT03
         ZTGG/JdTZs/qBz6XYCV1fewCY6AV0ThP9NIAPpV8QBMSjDruAoJSpQ0h2zYCdCmJ8Bma
         TcHrQxqffq2v7aieMKuJRcJ36MzhfFcLOhX6tegCIdoTZgVbkxkMe+w/t+1YfqrJNHlO
         D5eg==
X-Forwarded-Encrypted: i=1; AFNElJ8W3d3pFkz1mRXRG/pmfHkgxQU5TExMBl5KINsg383itZqJyUsluUaXO2Mj2uFua/j+4Q9IXog=@vger.kernel.org
X-Gm-Message-State: AOJu0YySnRfaG4F4W2G80HQ0Osl60x4gMawPmy3mUC6nS6x9cL3Dto7i
	jQODg2pA+JjChlvSN0cWEC5kKl3Rjjea7Q1PG/torgEaj/AcfQLlmE7tnGufaGI0zgehxYdnFUL
	RmV7llTMk7tsX1a4FdBDi9wS3CFfJCaz+8onx0H4xfbdNTLR1GEsjfkdNhQ==
X-Gm-Gg: Acq92OHPQkS1EJ1DQCkW0wNEJdRRU+OzdOLaPf/a2KDtlVmH3tRaCw683AaWL6HqfPl
	KxwAZPxI67eASX7f3Wz8tjmDlr7Mse2v+XC8BJkxQah344+3Ln47vKafj0YcTaxxvIQX7gpepLM
	b/JETyb3ZFqwjgkUj70wT/15JT5lF0jA0kUOKEhVrJL4CbT2wLvOxhCFcLbR2BdrFURlGyDXFWE
	Zs8MWbB25UgN7ergyQWZbHpMnA5lj5AZ5boVoUXLQMRnk2Q1zvE1wRSK3ax1qKmuiXHdPnAEtWu
	qz+mAfmM7/2GiJv3quAOvSXoLm6bvPdebpCbRt6UeO5hLS6TZzWcNvmY90Y1oz9Igh1BH70EjmC
	MPFO7GmoleJcRAzQ52HYil24Awu6hk3FOlYwnkNXamP+753bB9qMjOztLg+3oDi4st7k=
X-Received: by 2002:adf:fb85:0:b0:45e:fa38:c899 with SMTP id ffacd0b85a97d-46021783cecmr8984905f8f.4.1780570551759;
        Thu, 04 Jun 2026 03:55:51 -0700 (PDT)
X-Received: by 2002:adf:fb85:0:b0:45e:fa38:c899 with SMTP id ffacd0b85a97d-46021783cecmr8984861f8f.4.1780570551302;
        Thu, 04 Jun 2026 03:55:51 -0700 (PDT)
Received: from [192.168.88.32] ([212.105.155.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f3529e0sm15330789f8f.28.2026.06.04.03.55.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 03:55:50 -0700 (PDT)
Message-ID: <b6182472-503c-43e9-a850-87cd40f86aa8@redhat.com>
Date: Thu, 4 Jun 2026 12:55:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] vhost/net: complete zerocopy ubufs only once
To: Qing Ming <a0yami@mailbox.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Cc: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Shirley <xma@us.ibm.com>, "David S. Miller" <davem@davemloft.net>,
 kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260601104300.197210-1-a0yami@mailbox.org>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260601104300.197210-1-a0yami@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:a0yami@mailbox.org,m:mst@redhat.com,m:jasowang@redhat.com,m:eperezma@redhat.com,m:xma@us.ibm.com,m:davem@davemloft.net,m:kvm@vger.kernel.org,m:virtualization@lists.linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-295185-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DEE8F63F40E

On 6/1/26 12:43 PM, Qing Ming wrote:
> vhost-net initializes one ubuf_info per outstanding zerocopy TX
> descriptor and hands it to the backend socket.  The networking stack may
> then clone a zerocopy skb before all skb references are released.  For
> example, batman-adv fragmentation reaches skb_split(), which calls
> skb_zerocopy_clone() and increments the same ubuf_info refcount.
> 
> vhost_zerocopy_complete() currently treats every ubuf callback as a
> completed vhost descriptor.  It dereferences ubuf->ctx, writes the
> descriptor completion state, and drops the vhost_net_ubuf_ref even when
> the callback only releases a cloned skb reference.  A backend reset can
> therefore wait for and free the vhost_net_ubuf_ref while another cloned
> skb still carries the same ubuf_info.  A later completion then
> dereferences the freed ubufs pointer.
> 
> KASAN reports the stale completion as:
> 
>   BUG: KASAN: slab-use-after-free in vhost_zerocopy_complete+0x1d7/0x1f0
>   BUG: KASAN: slab-use-after-free in vhost_zerocopy_complete+0x101/0x1f0
>   vhost_zerocopy_complete
>   skb_copy_ubufs
>   __dev_forward_skb2
>   veth_xmit
> 
> The freed object was allocated from vhost_net_ioctl() while setting the
> backend and freed through kfree_rcu()/kvfree_rcu_bulk after backend
> removal, while delayed skb completion still reached
> vhost_zerocopy_complete().
> 
> Honor the generic ubuf_info refcount before touching vhost state, and run
> the vhost descriptor completion only for the final ubuf reference.  This
> matches the msg_zerocopy_complete() ownership rule for cloned zerocopy
> skbs.
> 
> Fixes: bab632d69ee4 ("vhost: vhost TX zero-copy support")
> Signed-off-by: Qing Ming <a0yami@mailbox.org>

The patch LGTM.

@Michael: to you want to take it via your tree?

/P


