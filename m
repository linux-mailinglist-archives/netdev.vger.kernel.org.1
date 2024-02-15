Return-Path: <netdev+bounces-72102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D860856918
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 17:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E91BE285BBF
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 16:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12C5134CF4;
	Thu, 15 Feb 2024 16:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dvWlp838"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F42134CE2
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 16:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708013166; cv=none; b=p4h9Disf5EA5PYkm0RUyI7yI3bN5jcMUpVW+wyjXFyrHzQUhuBKCy0l2JBmbdgB/1giow1Pt1A70JkLcojACbl0iftvXj9wPDzjIKgwUhszh629D9lmU7zbCaX5bWue7pZIaGOVMRqqPeFFQiFmE1kT9+7HM9o3QFrmIlB/8HL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708013166; c=relaxed/simple;
	bh=dra+vz7V749tqxklahoC5fJAfUQ3hlCwWDhw5EAPx/0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W5UmSeXJKeOvTtGX+v8VRuK/tDEGam/iMZk1yLzv8AFL3IiP7SPNMhmJNcMdYovsiGkFxcpJIFXiBV5Nml0lOKfgnI1Do+VkfjsG6Zw6MuiOZS54ODLMjTph41bHqm0rxAU0ZmSeugErnerJAFB6ycWijfQf/HbE6bGZkgKrrCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dvWlp838; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708013164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=dra+vz7V749tqxklahoC5fJAfUQ3hlCwWDhw5EAPx/0=;
	b=dvWlp838zzjqfUeg4zKcWvudLTYcmHJoz9g2wsIWmiqJ8vAcl7Xs7j0mEBiSR80php7UHE
	IPZ/adtpcb19Vho9JZkqQ9wekrf/zXXNGlBsq9DtTijjGr0UqAiayw5C6EDhCVkMVXvut5
	PdF08Zn1aJNas6RT8z0crG4C6Xl/npo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-Lf-IlSkdMdi2NJycv8L9gQ-1; Thu, 15 Feb 2024 11:06:02 -0500
X-MC-Unique: Lf-IlSkdMdi2NJycv8L9gQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-411e27d561dso2493935e9.0
        for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 08:06:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708013161; x=1708617961;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dra+vz7V749tqxklahoC5fJAfUQ3hlCwWDhw5EAPx/0=;
        b=k0n2LFUCt8wMtZm1JAG20EI1zRlDfO2WdIykmkL23AJ5VNdC+MwKrEydaAUbu2ndpL
         3sw/vJuKAjcXsEf2ViOFzs5uQsq2g0Nu/FeEVIJOEYrcxMAIsr5X/cewbS5h42Fb+V7L
         oo5Lau2mcqsgKCVjTj3TwybX7VWCY9FkAdnEM3Ao47jTV2yqshPeB6kYN0sOzf8kPn5P
         7TDVdYUexczMqxwb+A0aQMhchqdtoxcQZNptBswQaQCPEsXmxNFdb30h9ZGdZwbNG5C6
         DXPCMQVwyjvQZ1Lfz4JmVtRmGdEwP1/YHrV14DZAB4dL2c2bOUxIr0dyGkEe22UKzHCM
         OqPg==
X-Forwarded-Encrypted: i=1; AJvYcCVNG0yiTzALn0j9+9L4HrH4+Xx/LpahOqpL5kwRxolre4G1E8K1YXV52hNkZAn7dDdGaDq+c4dnpOnGbJk7TsKxQOxX/9Ah
X-Gm-Message-State: AOJu0YwTGn/h9NdRgE5RrTwvTXYE1b6545+YTuSyo9OLtQpWiiEv7ceU
	F8awihsWEvL43qh9f8Shr0TpVdXvWzAT5HtyoUGiMhHXWPekQ05mXdJMuBtXB0bia2tr0BtPPHC
	epOV746TChkbJwL8ESJC7ThdcKbUi0mGWbwomBOO0erYPjRGW3+RD9Q==
X-Received: by 2002:a05:600c:3b25:b0:412:a19:d8da with SMTP id m37-20020a05600c3b2500b004120a19d8damr1626599wms.4.1708013161140;
        Thu, 15 Feb 2024 08:06:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGyLy/Xzkxe9V6/Ov7++peLCkLsjxrRToc+E4V62gLp2VY35n1ffxwxKajcGntaKklmbHyMhA==
X-Received: by 2002:a05:600c:3b25:b0:412:a19:d8da with SMTP id m37-20020a05600c3b2500b004120a19d8damr1626574wms.4.1708013160803;
        Thu, 15 Feb 2024 08:06:00 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-227-156.dyn.eolo.it. [146.241.227.156])
        by smtp.gmail.com with ESMTPSA id e6-20020a5d5306000000b0033b0d2ba3a1sm2192553wrv.63.2024.02.15.08.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 08:06:00 -0800 (PST)
Message-ID: <bb560ae4edc37d4d66cdddacb849f4d04baa7dd7.camel@redhat.com>
Subject: Re: [PATCH v2 net-next] net: Deprecate SO_DEBUG and reclaim
 SOCK_DBG bit.
From: Paolo Abeni <pabeni@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>,  Matthieu Baerts <matttbe@kernel.org>, Mat Martineau
 <martineau@kernel.org>, Wenjia Zhang <wenjia@linux.ibm.com>,  Jan Karcher
 <jaka@linux.ibm.com>, Wen Gu <guwen@linux.alibaba.com>, Tony Lu
 <tonylu@linux.alibaba.com>,  "D . Wythe" <alibuda@linux.alibaba.com>,
 Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
 mptcp@lists.linux.dev, linux-s390@vger.kernel.org, Gerd Bayer
 <gbayer@linux.ibm.com>
Date: Thu, 15 Feb 2024 17:05:58 +0100
In-Reply-To: <20240215070702.717e8e9b@kernel.org>
References: <20240214195407.3175-1-kuniyu@amazon.com>
	 <20240215070702.717e8e9b@kernel.org>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-02-15 at 07:07 -0800, Jakub Kicinski wrote:
> On Wed, 14 Feb 2024 11:54:07 -0800 Kuniyuki Iwashima wrote:
> > Recently, commit 8e5443d2b866 ("net: remove SOCK_DEBUG leftovers")
> > removed the last users of SOCK_DEBUG(), and commit b1dffcf0da22 ("net:
> > remove SOCK_DEBUG macro") removed the macro.
>=20
> Unrelated to this patch but speaking of deprecating things - do you
> want to go ahead with deleting DCCP? I don't recall our exact plan,
> I thought it was supposed to happen early in the year :)

My personal "current year" counter tend to be outdated till at least
May, but I *think* it's supposed to happen the next year:

https://elixir.bootlin.com/linux/v6.8-rc4/source/net/dccp/proto.c#L193

:)

/P


