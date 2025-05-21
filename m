Return-Path: <netdev+bounces-192264-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B963BABF30B
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 13:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 759801BC381A
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 11:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBA4263F47;
	Wed, 21 May 2025 11:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="do/33eOd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750AA239E79
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 11:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747827509; cv=none; b=ALBB0DduRTGA92Rc3DREhwF2f/4LkpyMtkoJDXFHpdCVQkTDJZ+6l/EZYk9jrV+MZzyW6O3WP+lwKrGrq4wPq6RRUbs9qI8bGwyIhkpjuJKHsLY486ysQ4o3lSRJpl+rnvGYrQiPuHueBBzXtPmCPc5N2X9zI64gKF3k9bYdhSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747827509; c=relaxed/simple;
	bh=EC2djDRVNxLUp+AOSXQOGAcIwXvb+u6b2kB34q4ZBhw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IWhI6xGz58/+LwFzZsNmmHxQdo5FVhj8qRSQMXHaPlP7zUQpv3qrcwNxFr81hnNEbjX+bmLDWFRkhRbDWrNvhh3ZdzCx4obMtlqfMn8NoakhP3RiAMe27e8tlJyBpo1hPXOKTGgJk9LEjaXAxCQ32ThVWo3iaGkAeGlTJ6wuiK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=do/33eOd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747827505;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1b6yZ2HGUl7JX37AVsn47EP6PKyC5Ci8ZwU5C45mfxU=;
	b=do/33eOdlrnJVhFDY9iOMtqbkRhlY1PZjm7GhXUd2GtIAgE6mmQQyWqWToe5vycCoR16D8
	VtcTdE28N1jqD2qPtI1E7KENSUQeOuFnlN9UFSMuoRfR8TqJnYfD9gsLfhYnjMLwGq6jIj
	DNINEwM8QyAtIR1ucyKLVj/imunM3iI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-503-_VfPL6aaMaG_Zw4dy-6PXQ-1; Wed, 21 May 2025 07:38:24 -0400
X-MC-Unique: _VfPL6aaMaG_Zw4dy-6PXQ-1
X-Mimecast-MFC-AGG-ID: _VfPL6aaMaG_Zw4dy-6PXQ_1747827503
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43efa869b19so53316645e9.2
        for <netdev@vger.kernel.org>; Wed, 21 May 2025 04:38:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747827503; x=1748432303;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1b6yZ2HGUl7JX37AVsn47EP6PKyC5Ci8ZwU5C45mfxU=;
        b=uMZ0MgSClCvNLdMrryXidqf/7xFJRSeCsSO3KOrrcpbT/P/8R5zBDUQaTsL8PcqYVD
         hDp5Q7TKS/L7XvF6gH9/Jyn+pAWLx/Gl6OlpjA3SZ/UxZ/TSgnUIy6QrpvZM3J5+OBei
         Y/njtURxYJBijk3dJ94QLN3dafxkqJXHXCk3SDSUcdjdotEruJ+d6nai880arvbAZgnz
         gEuIdawMc0yQqRdrwkq6WUI7nSXY+Sc3a+vpRmmQ7wpxR1LFSJfKM9SjRQsemZp6iTDG
         3eU9Dg01Npefc8UBPRKvryEQjPdDirggzwUz0sq3CU4iELPl563T9v+R47cbac/jFhe9
         pVRQ==
X-Gm-Message-State: AOJu0Yw4ere51wPBvxBMMbW9pemPAhhesZZnavYZNQqcVS/e6skkbB7v
	1h6WNurVbVroRf1PDr8SyKs75olmaoAsxx4k+sxoNqnrH03lUtns/Z5k7vTmPs1b2zVn/vbFSy4
	KVEcYjnZgVonkITF9lzpnI9QvEZC6XG9sfiaJSPd/jJqb0MVTsqInpJQ/G1Py5LmBK0UC87a2XT
	huaXQHJc7698SIg0Ws+KqrbSpk6J3lzT2mV+xfIfnBww==
X-Gm-Gg: ASbGnctQjVvSfQXl9JL3qRtVpt+JsuKLlETZ6ZOmfXa2CqBbmhOccTCPAflqsgxn8IA
	WB9wVmaDKqk7dnr3A0UUxRMOaz8Fy69kcD8dXoU3Gx7c0wwT29csNwgoyhXY4Cjz29/fXwGT2/N
	C/Ak2CusMtO+mwNHqgirb8JKKA2KzZ7vaaVI9CmvV+8zkqMTuv/MnNPSX3+PiqHcDWupsLtKu0D
	OknWo58Jx3ZMd7dBy1u5GSNqcbWdykvf4UNwdZ1stXejniOA8WhfFgFlR2OGzVup2hqSV0Iz3Eb
	HK/GwVxEcqlkoOaR4UAUN2WcIDf/NpoxP+O7qb+EV4z1kWTO+8FdznvF3gE=
X-Received: by 2002:a05:600c:3c82:b0:43d:1b74:e89a with SMTP id 5b1f17b1804b1-445229b4341mr119719775e9.9.1747827502685;
        Wed, 21 May 2025 04:38:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHASunwJ5KdJXbCP8HRoK3uTb2f00aYg//n3dfzYK8NdmYLKrCt/anYK5sckH2uHsq0Fg+h4g==
X-Received: by 2002:a05:600c:3c82:b0:43d:1b74:e89a with SMTP id 5b1f17b1804b1-445229b4341mr119719365e9.9.1747827502116;
        Wed, 21 May 2025 04:38:22 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:cc74:1e10:8d32:cccd:b412:bb47? ([2a0d:3341:cc74:1e10:8d32:cccd:b412:bb47])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f7d975cfsm68713755e9.38.2025.05.21.04.38.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 May 2025 04:38:21 -0700 (PDT)
Message-ID: <739ef09a-e44f-4a81-bc51-a7389434d954@redhat.com>
Date: Wed, 21 May 2025 13:38:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/8] virtio: introduce GSO over UDP tunnel
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>
References: <cover.1747822866.git.pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <cover.1747822866.git.pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/21/25 12:32 PM, Paolo Abeni wrote:
> Some virtualized deployments use UDP tunnel pervasively and are impacted
> negatively by the lack of GSO support for such kind of traffic in the
> virtual NIC driver.
> 
> The virtio_net specification recently introduced support for GSO over
> UDP tunnel, this series updates the virtio implementation to support
> such a feature.
> 
> Currently the kernel virtio support limits the feature space to 64,
> while the virtio specification allows for a larger number of features.
> Specifically the GSO-over-UDP-tunnel-related virtio features use bits
> 65-69.
> 
> The first four patches in this series rework the virtio and vhost
> feature support to cope with up to 128 bits. The limit is arch-dependent:
> only arches with native 128 integer support allow for the wider feature
> space.
> 
> This implementation choice is aimed at keeping the code churn as
> limited as possible. For the same reason, only the virtio_net driver is
> reworked to leverage the extended feature space; all other
> virtio/vhost drivers are unaffected, but could be upgraded to support
> the extended features space in a later time.
> 
> The last four patches bring in the actual GSO over UDP tunnel support.
> As per specification, some additional fields are introduced into the
> virtio net header to support the new offload. The presence of such
> fields depends on the negotiated features.
> 
> A new pair of helpers is introduced to convert the UDP-tunneled skb
> metadata to an extended virtio net header and vice versa. Such helpers
> are used by the tun and virtio_net driver to cope with the newly
> supported offloads.
> 
> Tested with basic stream transfer with all the possible permutations of
> host kernel/qemu/guest kernel with/without GSO over UDP tunnel support.
> Sharing somewhat early to collect feedback, especially on the userland
> code.

FWIW, the user-space bits are avail here:

https://lists.gnu.org/archive/html/qemu-devel/2025-05/msg05027.html

/P


