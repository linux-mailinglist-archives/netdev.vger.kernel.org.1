Return-Path: <netdev+bounces-190359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5748AB67A0
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 11:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F3291B65B8D
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 09:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A45122838F;
	Wed, 14 May 2025 09:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="DE4XMmRZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79805214A69
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 09:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747215278; cv=none; b=AfY57BreVM+DbNZqjPMhQCninof9uqqK4DxTMkk3SOmDVlsDah2Y2v7ealxgt2w1A9A7Lo8ODWnkUb+GZpdx7JfhSi6Vcj81lP5Say0WW1udoNlJSHXThO9MlZTt61BD5N37PJzLTjsN0fBoJQAlPF6RQleuknTI5Dh1JkC4uiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747215278; c=relaxed/simple;
	bh=16EZkmDNcr6GNBM0F0ukp7A4+ilky02cVpOkOY1pbSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dktPOeeTW5XrNlw+LTbn3UmzQNOZ3DNH3tC1nbP9uj/4n/K9TRx4uZ68ojME9sYkca8lXdZohDrXcnjkJj2NVd8kS6k5KyQIupOlyiM+1yW2bODixMWHQGmHN3jc3BNlkBV/a7L2CNq0YsKZ9unnhiefBnZe92niyXmXZgXA3ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=DE4XMmRZ; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a0ba0b6b76so4800310f8f.1
        for <netdev@vger.kernel.org>; Wed, 14 May 2025 02:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1747215275; x=1747820075; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=leuEkxmjG5F+2dcsIfXiwT2ApWtcGuljDlHQPQW9ejk=;
        b=DE4XMmRZj+KorYfIyH/qCEX3PU5usck/kMiSSog1iZrozTBuXJu+3ZtfLMbcBe0fqN
         jBM+0U1a85TnQa8hr2SCFfyiQ5ta7HhsVPy0eqQ9S6cqHI3AKEp8ZWdXPyURk+l1UJDs
         uFwMFPXrA0pRkmBP/bnWNTvMTGLHw1c5A9ojMY0IZGldfFgPuPlVK+jOWgB41253IPlK
         FOnkw+SfkI0TMZdpbRDZaP4PxhNJD+hsU54a4xoWyuxk1z2jweui9+XC+RBfZ7z9Qc6v
         NAaMYIfRc63IPP+FmC9asdOCWzP/rgFojfOXexgcG/j2EqXNY+gPlgJA1fuGI3EsV+4V
         aPHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747215275; x=1747820075;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=leuEkxmjG5F+2dcsIfXiwT2ApWtcGuljDlHQPQW9ejk=;
        b=KLQnUujQTIcjAcQn1oXwEDv8Ruo9seZH+TeBZCv1TAvSAiG0ellCKySxJ8Xfk59EQa
         YCCLt5vTAeFaHDF245GaBzDmfDvKOCOGX6ymIRC78bE3sudoDJmWm+B0HWv0XvIDrIQP
         SkgQf/J0YYBJDw+hUmwTHuWeKzh42EWaZtiJfBnOnEXfGUZtuOUzOFYNbj6A9ACJtpo4
         O0wnztgUA0Hjx+YEneIIAXtEJasG+TiTvbr1Ne0rmI7sSI2tNkWpeW+d/xKZmCRGNK0p
         tC7l6WfSXp9sXL236Ct+1nVNGUHzkNRDZaK0oVGC1+Tq6MmNc3jqGHK99DkLnHyXtNDt
         7zJA==
X-Forwarded-Encrypted: i=1; AJvYcCWtFlFZzptPbg25/PpEQmLOjMUpKxEg+0mEOgS1xQfa/YWLbJMMyJgz9twFkXbJ+SfU75cDiz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRbrj0nfWCnvjT/dfySc2IRqFCTClMrw4m6UDk2ns9a15gJySZ
	hasaYKCRvXxUS3nQfBC6XcPRBEC4qmoGcndkiewQghckJ+I8J6lVbahsQr8QLGY=
X-Gm-Gg: ASbGncs8mO81RfVwCfFAPECsmD5Lrx/Eh3a4kQWlf4BnyEf3Iz3x8gN9bSOVnOIRxTx
	dn1XFge0IG/o3ZnYnhExe3r6D2pecQYzMzKyZPiFGR67cCsOQdK1hXKNuBZPxN93EsVRXr15RC8
	aIlh/TvH8nrrFhThKK7THfrOgD+PSarVtpjZNRMXOBVspyMWQMRNkOGIezqsQfLyBeLaxkWxVIB
	ROGk0BEEhPDd2mXI/tKV1bG6+boPZPb6NZVP11eV1kkDk+CCGeKCBd6nnz03khVKps9qeiu8hUf
	Rk4pEHOFOxoL3uq2rbSLEZXkXgBoMfLsUXwqsOUu+BpteoqA+8yXuusLpQL+ZugkreD+KSl3yra
	SPvFhaSI=
X-Google-Smtp-Source: AGHT+IG6AOjwo0jrHzH5ZtVljtCl2/AIuOHGZ+zBFjV1XswjiqdDkt3LttXaOozhHG4GGzNVarROjg==
X-Received: by 2002:a05:6000:1445:b0:3a0:9dfc:da4 with SMTP id ffacd0b85a97d-3a34991c1e8mr1901912f8f.42.1747215274492;
        Wed, 14 May 2025 02:34:34 -0700 (PDT)
Received: from [192.168.0.205] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f5a4c804sm19310592f8f.95.2025.05.14.02.34.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 May 2025 02:34:34 -0700 (PDT)
Message-ID: <f11ade9c-753f-4128-a67a-edbe2f40c912@blackwall.org>
Date: Wed, 14 May 2025 12:34:33 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 0/4] add broadcast_neighbor for no-stacking
 networking arch
To: Tonghao Zhang <tonghao@bamaicloud.com>, netdev@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Zengbing Tu <tuzengbing@didiglobal.com>
References: <41542B8DA1F849A9+20250514092534.27472-1-tonghao@bamaicloud.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <41542B8DA1F849A9+20250514092534.27472-1-tonghao@bamaicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/14/25 12:25, Tonghao Zhang wrote:
> For no-stacking networking arch, and enable the bond mode 4(lacp) in
> datacenter, the switch require arp/nd packets as session synchronization.
> More details please see patch.
> 
> v4 change log:
> - fix dec option in bond_close
> 
> v3 change log:
> - inc/dec broadcast_neighbor option in bond_open/close and UP state.
> - remove explicit inline of bond_should_broadcast_neighbor
> - remove sysfs option
> - remove EXPORT_SYMBOL_GPL
> - reorder option bond_opt_value
> - use rcu_xxx in bond_should_notify_peers.
> 
> v2 change log:
> - add static branch for performance
> - add more info about no-stacking arch in commit message
> - add broadcast_neighbor info and format doc
> - invoke bond_should_broadcast_neighbor only in BOND_MODE_8023AD mode for performance
> - explain why we need sending peer notify when failure recovery
> - change the doc about num_unsol_na
> - refine function name to ad_cond_set_peer_notif
> - ad_cond_set_peer_notif invoked in ad_enable_collecting_distributing
> - refine bond_should_notify_peers for lacp mode.
> 
> Cc: Jay Vosburgh <jv@jvosburgh.net>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>
> Cc: Zengbing Tu <tuzengbing@didiglobal.com>
> 
> Tonghao Zhang (4):
>   net: bonding: add broadcast_neighbor option for 802.3ad
>   net: bonding: add broadcast_neighbor netlink option
>   net: bonding: send peer notify when failure recovery
>   net: bonding: add tracepoint for 802.3ad
> 
>  Documentation/networking/bonding.rst | 11 ++++-
>  drivers/net/bonding/bond_3ad.c       | 19 +++++++++
>  drivers/net/bonding/bond_main.c      | 63 +++++++++++++++++++++++++---
>  drivers/net/bonding/bond_netlink.c   | 16 +++++++
>  drivers/net/bonding/bond_options.c   | 35 ++++++++++++++++
>  include/net/bond_options.h           |  1 +
>  include/net/bonding.h                |  3 ++
>  include/trace/events/bonding.h       | 37 ++++++++++++++++
>  include/uapi/linux/if_link.h         |  1 +
>  9 files changed, 179 insertions(+), 7 deletions(-)
>  create mode 100644 include/trace/events/bonding.h
> 

Just fyi you should wait 24h before posting a new version as per netdev@ rules.
Also to give more people a chance to review the set. Please CC reviewers on
the full set, I had to chase the patches on the list separately.

Cheers,
 Nik


