Return-Path: <netdev+bounces-153881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA83F9F9F09
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 08:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BE9216B968
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 07:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D29917A586;
	Sat, 21 Dec 2024 07:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="YBvk2BXs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597AB1AA7A9
	for <netdev@vger.kernel.org>; Sat, 21 Dec 2024 07:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734765818; cv=none; b=oCoqc8yR4DfwRGjSOURdoX4HNsZykb99x9MkKgrzouZSyxYMCaLuMhlL8zfrJUE9DiEpuge1RQteqy+27LQyxmEi96vew/vkM7OrBVi5GSqnWh60CcwdOFQuJXu6EgHyUUlRcQndexZG2skW0JP7SnldlEYBnJ9PNN02+rFj1/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734765818; c=relaxed/simple;
	bh=aqb8+RHJ6WxTEsAzfR/cFGlypEucYWaD7igL/fV/Qgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CsTI8nR8zVKYsJup55wjp0v9afod9+R1iEPw9yaSWls+eUGjEBz9+39DTqYNorVDXVyazMnZVcO5hY4qUGvyUVnb0/AHW9FOBsthDyw/SKP1mbWROHv+t8fDnea5US6pObPJ4J82XTRh2+yaWSYHlwlU7ZfX5nrBekc6vOifDCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=YBvk2BXs; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43635796b48so16609285e9.0
        for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 23:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1734765816; x=1735370616; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L9mtmPZIi+Kyt6bE6scI5p+7PdJbZWOLUW810rPO8q4=;
        b=YBvk2BXsFvMSBVA6BY8dpzRv82OYXAWvZcB76EKcCSjb1WvS7MN/D1MoJoCzIFMkVU
         j1W9TBqCa7ewtspHMKvKYhnFGgMEo7EzSpJ6FogRcHkvabXzUX3HROgYkM2QDtvtEtjJ
         YXC5jVlMLucKmeNXfbr6JR1p49Nzn6HcxnX6Th6eMKKn+qeKsOjVmfIqAf7m/sNOgbAP
         EajR3CAE219NV9JaN6HBO5ejajS3bKQATpAug3BPDw7jVx7MetxNpJj7GZMQ9+JeOUfu
         luH9pcPN2NfC6a8EZwownK0DMtKztTbwZPuOS0fc09X3s2AvyETA7s8YAVom+xgDPOkj
         G7Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734765816; x=1735370616;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L9mtmPZIi+Kyt6bE6scI5p+7PdJbZWOLUW810rPO8q4=;
        b=EnA+oYZ2enzxc2H1c+qyAOXn5XvwDyBgGR2x86Ja0gIUS1A+5MH+gjConaRKuHMA4g
         /vKhe8vfV5cYxxJBN/NUAm/38oMFruPY7jBupvnBu1nHG9REe/WxvIYDX0q78GXEgGK5
         Y+EzSYAG1ApzwWD/g6ts/CesPwj6Lhnyw+YlyVof3e3fUjpkhUhm6erradrMnMaV1ZnA
         TUkzUOiLZaJtA8He30cdEarSihj4nYT0jW3xGgaSwjSQ8wkZaapAcuo+lVXbvbLyNtWY
         +Qo8SFQq/+PiXMJVMxct+uCwBS14xSm+8axveDr8C1ShnNWClvdYYUhlaherWKjPqn6E
         pYfg==
X-Forwarded-Encrypted: i=1; AJvYcCV6eSZ9NrZoyQ/GA6IwfpTbUbILdjGBeMmnySRHZKEz2i2WZDx17+FVSg0wpbN5THlcvHOgiF0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/W4nBPXsgYMq0x00UwehRbwsatTxrYSPuauDPsnyxV54p6/Kp
	qABr15rlMV2kiBpawMCSvoMoL2cB2RScwFe+tkgF8LIZQlcaToSIaVDFoYeyvDY=
X-Gm-Gg: ASbGncu0Sm54mFWLwtJ4v2gttpjX2jYMyx7ij0BIQE+gyV9YiC1lO493YpE0qTkWhk+
	mWyu7lVSkLzp4t77Ey8/hYP2HqztMQabMbeV1Qjn3yhAXL1xIruZr07h+GurZobbDnR2hOrIGgK
	XbBQU4ZpDMtDzn5OfhankWZarvd7qPVTomVMxxrxHvj+lVR88z6P29JpdrxF3B5i2VntJdkdMER
	f1xqg/upD1en/CqQXpDBBEE6oHg4YJpOnXimkfbhSECVUbSnQ5NWliC0PuQ3tIwqPv2djFzqvMi
	1spgeKNbCScW
X-Google-Smtp-Source: AGHT+IFzR+b0dJ8cXMxJaFZxa/uj8LNvR4GrBhtZTQrt4Y4gAjYydHlqcDBVhcZM8706zr0B7e7dvQ==
X-Received: by 2002:a05:600c:1c02:b0:434:f2af:6e74 with SMTP id 5b1f17b1804b1-43669a28ea7mr46560595e9.15.1734765815604;
        Fri, 20 Dec 2024 23:23:35 -0800 (PST)
Received: from [192.168.0.123] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436611ea3d5sm68529405e9.5.2024.12.20.23.23.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2024 23:23:35 -0800 (PST)
Message-ID: <e08ccd22-6537-41fc-9934-84b8fdc0dc3e@blackwall.org>
Date: Sat, 21 Dec 2024 09:23:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/3] netkit: Allow for configuring
 needed_{head,tail}room
To: Daniel Borkmann <daniel@iogearbox.net>, martin.lau@linux.dev
Cc: pabeni@redhat.com, kuba@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20241220234658.490686-1-daniel@iogearbox.net>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20241220234658.490686-1-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/21/24 01:46, Daniel Borkmann wrote:
> Allow the user to configure needed_{head,tail}room for both netkit
> devices. The idea is similar to 163e529200af ("veth: implement
> ndo_set_rx_headroom") with the difference that the two parameters
> can be specified upon device creation. By default the current behavior
> stays as is which is needed_{head,tail}room is 0.
> 
> In case of Cilium, for example, the netkit devices are not enslaved
> into a bridge or openvswitch device (rather, BPF-based redirection
> is used out of tcx), and as such these parameters are not propagated
> into the Pod's netns via peer device.
> 
> Given Cilium can run in vxlan/geneve tunneling mode (needed_headroom)
> and/or be used in combination with WireGuard (needed_{head,tail}room),
> allow the Cilium CNI plugin to specify these two upon netkit device
> creation.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> ---
>  v2:
>   - static struct (Jakub)
> 
>  drivers/net/netkit.c               | 66 +++++++++++++++++++-----------
>  include/uapi/linux/if_link.h       |  2 +
>  tools/include/uapi/linux/if_link.h |  2 +
>  3 files changed, 47 insertions(+), 23 deletions(-)
> 

need coffee, just acked v1 and was looking at v2.. 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

