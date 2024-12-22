Return-Path: <netdev+bounces-153963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E06C79FA507
	for <lists+netdev@lfdr.de>; Sun, 22 Dec 2024 10:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57ADD1652B7
	for <lists+netdev@lfdr.de>; Sun, 22 Dec 2024 09:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13104189BBB;
	Sun, 22 Dec 2024 09:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="bdMHf3h0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FFA18A6DF
	for <netdev@vger.kernel.org>; Sun, 22 Dec 2024 09:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734860715; cv=none; b=k1bknw9ftEcbnN93Jc+XNkeK8/KrW2c51d66DL3MdckuTrNmLIQB4fpUJ3Gt3vj58FDJdX8QH4da+Snj4q01otAqihbbVL8ZolS073VorB8x2kdg0l9Z3ZiDNtvC08/bnq1RE+vUZoiwoaMHta6mZdeV3g7Y80mungcx5P2KW6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734860715; c=relaxed/simple;
	bh=OUXsu3SsIQEIs/KvbrddT+mv/XrsjETOldACl/PfCqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tBNyu+J6zaUg5rp6D2lxnJxE+BHIAhu5pOJ/iCfu3TruAtulXJquXujLm2VCFYnZRsBMpWP3tiMXt9BUXy8b0Q/P1t8/tJqiJmwCnan+o+A0qRSxzpkdr8pGOEmb3wjAF6Hq9wpkazHkvWuhouwB902x4J17guaTQiHvBTzy0xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=bdMHf3h0; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-436637e8c8dso29376475e9.1
        for <netdev@vger.kernel.org>; Sun, 22 Dec 2024 01:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1734860710; x=1735465510; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y7UylIxX/vO/9Hcmkt6Up44Ia9UxkJvcsUx2VBfUKlI=;
        b=bdMHf3h0kOLZEWYvCAQzE7oyZbMuUa+8Ant9ZRNObJlO9CDKBJ0KWRjQOhAgQcA6lC
         9RNIPRmPcV/CRUBRAUZxRGHnInXRVbF59e55x8nife80S691u4TAHSmXA1kFCA7QqFCs
         TEzjF/y/REmGV+DLfzRnKJJlWEw81beMx6UFV/qJin8fgqF8e5fxETiti4OF+sEF0vrz
         P4rVdkB3N7lRHwJakDUct/8t6fWj2NZjp3v/4SrQ3r1ECkotcO+Ej/re8azuriRaXuom
         emYET3iAscVVQ2qQL+jSNjz4TnXqRegWw8leXIFm+qFLwX46cIOPCoETP8/ieycwKDms
         UcKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734860710; x=1735465510;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y7UylIxX/vO/9Hcmkt6Up44Ia9UxkJvcsUx2VBfUKlI=;
        b=jI5fi3c0Wcd0yutFdcr7vP1gmvyY8h2W6VradpDB5b+7LbcTvZmpCSshYRv0CVz+NO
         vm30NfYGlv9lz4vExqhssjZ9L1UzEP4RYk0+Y6hwUdIlnsFkHtLf+PV12gwRaj7Z8Mim
         A5FwagAfmFvwPwNiPIyASihnu738JYeLRcF0hnPA5yjysKzKcObKha0DXiPNIC6jU0Hi
         U9A5TnrPm5qRAIYE4XpQg3CZpi7JfQNvxUYzlAkjcKR2TQQ6yp6XGzfuCkbmc/a90A4t
         0LzQ9LcHvMfI4E/XJIv7rFpjNf1MyVzqMSTURQyGmmCkzv3ayy+kEJf9YWGymAmg6CPo
         An6A==
X-Forwarded-Encrypted: i=1; AJvYcCWYONMFcqXdfM26knjQcNkg8pkdZZjOR38VeaEXO4yU2aZ0dBc/lDgbRwMQDYSd7aAQAaWmf28=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT3SzYs92PvmfE7hZF5y18H27WY/BXD8mh0bXeAQURgbQ37xdt
	fBhJc07pnMgxj/68+izf6BvbuizQfacALBOs0jov0ey3G+YXfieRAr34PSkJEvk=
X-Gm-Gg: ASbGncu1MTmxQmaxs9sqCKPaaCcq0V1R6d6n9t/5bZrJlVEWFfFhcHIgQLn6yx6s68h
	+JCYagOykhhJfI1JJ3vBnsysh8efTQSBNmNYdw2ASfdeMsR9vBZncsl6KEudCV9DGXtRIcTGFiQ
	78Ico8HS0bgnaL9SLOMPuvhTPlAwFcmdNQIX9PEqsKkF2JUwkAqnzVX++hZ1vu8Lta2gEWDMTNe
	AdSkeu9lhYHgUpMFqAuaGTmhgKvfybdmpmSgq94+1psC50Live/gFWibqMZHQ==
X-Google-Smtp-Source: AGHT+IFz6DFvEGYC1jixUKT369V5V2dPgCc9bnnP6QVvHtzTXLaTgll2cK+dV9FnlMJlWd6TXwcbzw==
X-Received: by 2002:a5d:64cc:0:b0:385:eb85:f111 with SMTP id ffacd0b85a97d-38a221eab40mr7017731f8f.14.1734860710400;
        Sun, 22 Dec 2024 01:45:10 -0800 (PST)
Received: from [192.168.0.105] ([109.160.72.197])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c89e1acsm8473677f8f.68.2024.12.22.01.45.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Dec 2024 01:45:09 -0800 (PST)
Message-ID: <e1384459-4923-4e02-9051-404c5291da95@blackwall.org>
Date: Sun, 22 Dec 2024 11:45:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/2] net: vxlan: rename
 SKB_DROP_REASON_VXLAN_NO_REMOTE
To: Radu Rendec <rrendec@redhat.com>, Ido Schimmel <idosch@idosch.org>,
 Roopa Prabhu <roopa@nvidia.com>
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org,
 Simon Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>
References: <20241219163606.717758-1-rrendec@redhat.com>
 <20241219163606.717758-2-rrendec@redhat.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20241219163606.717758-2-rrendec@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/19/24 18:36, Radu Rendec wrote:
> The SKB_DROP_REASON_VXLAN_NO_REMOTE skb drop reason was introduced in
> the specific context of vxlan. As it turns out, there are similar cases
> when a packet needs to be dropped in other parts of the network stack,
> such as the bridge module.
> 
> Rename SKB_DROP_REASON_VXLAN_NO_REMOTE and give it a more generic name,
> so that it can be used in other parts of the network stack. This is not
> a functional change, and the numeric value of the drop reason even
> remains unchanged.
> 
> Signed-off-by: Radu Rendec <rrendec@redhat.com>
> ---
>  drivers/net/vxlan/vxlan_core.c | 4 ++--
>  drivers/net/vxlan/vxlan_mdb.c  | 2 +-
>  include/net/dropreason-core.h  | 6 +++---
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 

Acked-by: Nikolay Aleksandrov <razor@blackwall.org>


