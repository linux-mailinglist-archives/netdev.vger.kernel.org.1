Return-Path: <netdev+bounces-303290-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id y7WRLVPmQ2oOlQoAu9opvQ
	(envelope-from <netdev+bounces-303290-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 17:52:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE216E6220
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 17:52:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=PnA90HKC;
	dkim=pass header.d=redhat.com header.s=google header.b=JsncOWrg;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303290-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-303290-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8D728303BEB7
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 15:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377CB45BD60;
	Tue, 30 Jun 2026 15:52:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B1E466B68
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 15:52:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782834752; cv=none; b=AIR0YJG2ciCzt/KrcJ0Q9gmv040I14+fTNfuNwOtGKBz5Lc285Be/frUP3gNyV6e2qGGidPHv8vCsULyRJhfWgaz9YyBFtftQ6S6VfIVOKFZlKHaJpViarwEg17g02nvPgogk3Jrr59m1YU5yoRtd3AnmSNy0adZizdQ8dTpsLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782834752; c=relaxed/simple;
	bh=xAV++Nv09s0Fx3qQqUFt2hh8zlLTaDft5mA4iivYxak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JaY4pjXv4dxjXgbX9DZIjyazneEy4+ccIBzqKRpc5AnOgnHdXDKr2RhFlK7Ioc+gXEtfbndEbHZzr+IiExAdtIk1+hwLKAkz2Tj0QptXNoieAyE0Gatd9lMAvmfes7CHowuSJ3XnIMKpobATxrknYlRg/3Mz5+ILZ/svVqDl6NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PnA90HKC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JsncOWrg; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782834747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0U78ZlodXLMOImJ/ZNFyI40d4zG0e33pCvJOLPMpoNw=;
	b=PnA90HKCmV7n1HW8iG9iTgUjkfejpf0LMCghQoWd4VoUy/9c7BAnuVmDbcKy0JNj9xAwVe
	e0pM5ydpj81jdOQsZB36F4G/d6Iucz/H2ExqZMN8SaJO1/SfAhrXMTb+TYWPk/vP7wzje9
	MlETvitQr9v6sWF72vtiLKMJbPA4/dg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-JmfPpJdlNDyii_Puy4-G2A-1; Tue, 30 Jun 2026 11:52:25 -0400
X-MC-Unique: JmfPpJdlNDyii_Puy4-G2A-1
X-Mimecast-MFC-AGG-ID: JmfPpJdlNDyii_Puy4-G2A_1782834744
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-493bab443f7so7639265e9.0
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 08:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782834744; x=1783439544; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0U78ZlodXLMOImJ/ZNFyI40d4zG0e33pCvJOLPMpoNw=;
        b=JsncOWrgiszwh2daQsPf6bfJWxQZDfziPSjV+dsM1F8Kqjk9OOVdP3fZOLvMLprcZz
         7VsuKiewE5UbmDr1kTA4v2Rq4+NFKj2QobAsCeJ2m1TglMHy3iUltQsVTGfc+Smh7Va3
         roMQ5OO3MsQOgn5AoJ5xNP64MLUfI551D4T2sA7YVN95cGvdLMs99bLbIQUpS7e3hQBz
         MIo34GB2/ch9WI1yK2BuIdx5Fd6pOuM8cKkNjeI1gTO9Vjo6g8kXOGnwqljtet4DHn9L
         FtyFaqIKwht5ffraNafMBKCxI9bmyddugtkykc2bRmi2+7YTrX7rqmq5/nZ4SFv6sbg8
         wcUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782834744; x=1783439544;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0U78ZlodXLMOImJ/ZNFyI40d4zG0e33pCvJOLPMpoNw=;
        b=gERQL2YqzG3dGA8XeNujU9vyG2hyCdxfOKmvkmtcVxgpuGntvzS+nDlrIMKhNVsF08
         4GGBw09E5dLvOJIkDmSqaj47qlDnV4g+dl7KCiotF3HlzU1lVtms2LDv0LfV+s3use5U
         fZbv8UdGwNGVkYAsA+XBtgEqBOF7uzOjaeNY638Q4s3hWo3V3TYBFkTPOiyigc2KxZZl
         S+ASKfWOYS3WXqOWayzdxC6xEyBdRC/D2AlD9v4C0h2GW74wdxlXujZWd00eAVsbGa6K
         taaeN3ZxMpKeqpv7lXUBT5VtbMuOpPdt96roC8ISh5QVQDO2o4VJQDMD8fFC7bJc/gjX
         8jkg==
X-Forwarded-Encrypted: i=1; AFNElJ+uUvFTZtMttCHoeStAOcBabknIGv+cucr42MbAW1MXGVuqWlH0mHsbndR7NBFiVpGA9KnZi6s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw20AqwA4k9EhX4txc7FKUgIyvMMA68f3RQQMSvLLG+jRfaUtkW
	uFAVBEkxKIvb16CQfcTmFsgVodcOxwsgprpfugr7Wa6D+i0Q3n1QZtTvIEo1Ko12MVmBq+VabT5
	0QJ6P8AIv4bzT8FE2xtFpBeI7E/+ElaSFDAPQpE89eqfjDOJ3ZQOGr3sV/w==
X-Gm-Gg: AfdE7cnRVkitCGFsHcjzEYFgXuVxpKfx4KiETcINXrYAkq8vsbds0NumkHmuvZ9I+CC
	mgd3HO2el9OnsAlS5QytK9nH7IEa8taFkAo9dbJ5Wjj3Hig/wioAFdpgKSQTjYpTLKVjEGBXKOo
	hzMq/Pmr8Lzer+5jkr5LwcdWFDulAktP3zshUwOs50jzn1Js3ckjaBc0Yg15n81OEvb5p8CZpzb
	4wucaDmTf6zVFER3G5evqIuvHT7nKxS84L8PdHr2O6zz3Fvp/MVk6mIOcQFpB3HqEggAARZQ6vn
	fgIOLtHLbs9Bz+jmE6P4DwrSTQ3gIhMMo66Ll3eeCUsiJW4JF9Uth0e4QaRacOgxe23PQVZ7Rci
	AGbYcslJ80Fk8Sme1eAxa522TFO44iLa9DZGok7COAfPUTx2H8be8XzMN7TbTasXH9MaipYUGKC
	35MjcrJ+tPwg==
X-Received: by 2002:a05:600c:8715:b0:492:4871:7e21 with SMTP id 5b1f17b1804b1-493bc53dc56mr31413425e9.10.1782834744264;
        Tue, 30 Jun 2026 08:52:24 -0700 (PDT)
X-Received: by 2002:a05:600c:8715:b0:492:4871:7e21 with SMTP id 5b1f17b1804b1-493bc53dc56mr31412855e9.10.1782834743805;
        Tue, 30 Jun 2026 08:52:23 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:2eb7:f61a:75:4534? ([2a0d:3344:5521:6b10:2eb7:f61a:75:4534])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be22098esm5669225e9.2.2026.06.30.08.52.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 08:52:23 -0700 (PDT)
Message-ID: <caeaf483-b19d-45c8-82e1-79eb2d56dc65@redhat.com>
Date: Tue, 30 Jun 2026 17:52:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4] vsock/virtio: rewrite MSG_ZEROCOPY flag
 handling
To: Arseniy Krasnov <avkrasnov@rulkc.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Bobby Eshleman <bobbyeshleman@meta.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Simon Horman <horms@kernel.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, oxffffaa@gmail.com,
 rulkc@linuxtesting.org
References: <20260628182052.951760-1-avkrasnov@rulkc.org>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260628182052.951760-1-avkrasnov@rulkc.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-303290-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux-foundation.org,gmail.com,linuxtesting.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_RECIPIENTS(0.00)[m:avkrasnov@rulkc.org,m:stefanha@redhat.com,m:sgarzare@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:mst@redhat.com,m:jasowang@redhat.com,m:bobbyeshleman@meta.com,m:xuanzhuo@linux.alibaba.com,m:eperezma@redhat.com,m:horms@kernel.org,m:kvm@vger.kernel.org,m:virtualization@lists.linux-foundation.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:oxffffaa@gmail.com,m:rulkc@linuxtesting.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,rulkc.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6EE216E6220

On 6/28/26 8:20 PM, Arseniy Krasnov wrote:
> Logically it was based on TCP implementation, so to make further support
> easier, rewrite it in the TCP way (like in 'tcp_sendmsg_locked()'). By
> this way, patch also adds handling case when 'msg_ubuf' is already set.
> 
> Signed-off-by: Arseniy Krasnov <avkrasnov@rulkc.org>

The PW bot is on holiday, no automated notifications for a while.

Applied, thanks!

/P


