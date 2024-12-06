Return-Path: <netdev+bounces-149660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C699E6B02
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 10:48:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E408C16A196
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 09:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E38E1DF96F;
	Fri,  6 Dec 2024 09:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="QKX5mTNS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9851DDA3A
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 09:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733478482; cv=none; b=BoTcDyxrmMfmfkGRznu3txDnUy1IxOmLA4gV/+KPL22Y8ssWTQTC0onHmPf2XIyLO+FMOTtRXzc0bFou8ISe90O4Om67oQ2++S63IOs1f122VWmMOdw2mxMJygAuiqjzgq6GiHs7Ldmz1fX9ODndsI2kZ0y6Erza8LPJtaiSNXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733478482; c=relaxed/simple;
	bh=VidXAn4ir97/AEN9vhKsR5R1rn9vt8skhvEMtzPf66I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DdrR4OHExoA4QvgsDzbU1PUqnI9EntRxjeCNkJcn5SNIo537vgm4Iv2L0WfpBnS/GddxC0GD8mUf7hv0uRmJm92pqK4Ilod5yJOzRvRtjnMwvGTc68Lheq/yTVahy8wV3MzU0MMqKI3yEa+OX1XA1iw0K9Jiv23E6lE+/nRiZGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=QKX5mTNS; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa530a94c0eso374007566b.2
        for <netdev@vger.kernel.org>; Fri, 06 Dec 2024 01:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1733478479; x=1734083279; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BOtZV3lioqf7lZwlOzVdOk946aGHd3TqbCzDypevJzY=;
        b=QKX5mTNS0HRUQWW4pbagEI3uE1Bt4GIBXlKS9VjuyNgnuAHsrodVFdlwVrD8xuo1ZW
         bYom2p3JscXO5YUsmiZ8AT9bEPjhuaGKNcIaKgcusyiIhUJUv7LTMrgmG0HkPay/uiWo
         FPA1YLw4z250zZnafiQBVIdgCgA06zu9E5Li9uHcBWfB+hS1ogkTONUH9fJbu4RJQJmj
         RKta+vjzmVs86AQ1yMIi54EHdmJxM5/LvPrTl8tv56zrXXY6hIhU0KgWX7QrIskN/xJy
         WNrmS1cC1j4k6xrejDsq4zSqgn0GYs1WZLCpHkL05TNZdTMwRLXi6y/DJsHIZOBl+7MK
         Z8oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733478479; x=1734083279;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BOtZV3lioqf7lZwlOzVdOk946aGHd3TqbCzDypevJzY=;
        b=nHWEFbljReW11zdyIB97TkTiRs9hRFn8EiIakryqURbJicBZXyQeMISfiBbVpnO3Kp
         0rktLw6W8roRSu/zqk7zGKgHvreYc38YKGHWuynwqxFm+H3JkYL2u54+LS9yYMIVINtQ
         s90FDQ2tKLWvNHoiE6Wa2NrCrP4XRzImk0+aK6KwC7t4C8F7rJRcnWK5bvw72o1y+opH
         kKEYf8Uo3YqoG1U72mzt3pfb4vdETgSMJDeZHNHe7nsIbqatubfrwGt0t22JxSi40N8h
         2IZ7QLNJiWoexTJQ1MXB4o998XKj5YpQPeLx0ZsVDMRUM0XggaO3+mwoMAkbqNe2wij2
         TIFg==
X-Forwarded-Encrypted: i=1; AJvYcCXkjGPOdxdZUye5zcr5JtRejoCecNkDFAjByOtqHLiCeOrhv4qIAA4AHhCd3eH9m//yGHST7AE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJkmv6RJcc8a/O70CJNfCdZ513NAQrJBykqu9ZbYSdEGwu0pIf
	nJcXwIwldFE/5BdJGNPIdHdTMshBteT/A1s8ph33uKxT2GQpbxPb/lzYIV+r68oA83g7as6Cj01
	E
X-Gm-Gg: ASbGncv8XUu5+zoQH7poZw0tWfCn9qvUQQm4TRDVAsZ2KSRpZ+DJjIR7vT37g/hHDJP
	5uP121T4HZG/Gm92NIeeU9OCsOAHPymHHT8DbWV5z6ttBR2iP3/tNKrcJ89z07J5V+kUYJ+tCVq
	yi5Jvh2+Nh58LtiuWQ1TMmb6dVNa2BSyRaHZGFDAnYy/5syyescbJSNn/bPavH7eFTFQMMOGEyJ
	yg5tr88X3EA6YAYzaOj/xiXyU01W/HtF78hIz+U5/vQ2lY9nDqg
X-Google-Smtp-Source: AGHT+IEX4HIGNKN7bIPWT67vqMUA29oneT0luRqlCWfItIn1HY7UczxN4i8j+GMIEQcE65pcABA3BQ==
X-Received: by 2002:a17:906:cca:b0:aa6:1c4f:4642 with SMTP id a640c23a62f3a-aa63a26661bmr180434366b.53.1733478479044;
        Fri, 06 Dec 2024 01:47:59 -0800 (PST)
Received: from [192.168.0.123] ([62.73.69.208])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6260e8b05sm212863066b.190.2024.12.06.01.47.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 01:47:58 -0800 (PST)
Message-ID: <72119ee0-8ac3-44dc-958c-86a615e26d74@blackwall.org>
Date: Fri, 6 Dec 2024 11:47:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 08/11] vxlan: Add an attribute to make VXLAN
 header validation configurable
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 mlxsw@nvidia.com, Menglong Dong <menglong8.dong@gmail.com>,
 Guillaume Nault <gnault@redhat.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Breno Leitao <leitao@debian.org>
References: <cover.1733412063.git.petrm@nvidia.com>
 <c657275e5ceed301e62c69fe8e559e32909442e2.1733412063.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <c657275e5ceed301e62c69fe8e559e32909442e2.1733412063.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/5/24 17:40, Petr Machata wrote:
> The set of bits that the VXLAN netdevice currently considers reserved is
> defined by the features enabled at the netdevice construction. In order to
> make this configurable, add an attribute, IFLA_VXLAN_RESERVED_BITS. The
> payload is a pair of big-endian u32's covering the VXLAN header. This is
> validated against the set of flags used by the various enabled VXLAN
> features, and attempts to override bits used by an enabled feature are
> bounced.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
> 
> Notes:
> CC: Menglong Dong <menglong8.dong@gmail.com>
> CC: Guillaume Nault <gnault@redhat.com>
> CC: Alexander Lobakin <aleksander.lobakin@intel.com>
> CC: Breno Leitao <leitao@debian.org>
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


