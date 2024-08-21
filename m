Return-Path: <netdev+bounces-120679-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3F795A321
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 18:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1C811F2427F
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 16:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0EA1AF4CC;
	Wed, 21 Aug 2024 16:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M/JqCOGQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E6A199FC9
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 16:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724258822; cv=none; b=WPVRWdWvtWRwsjT/NRcE34d2lCXUaVUWQNhBZn0ZMmlou8koYYicgF4LtWh4jqsNLVfen7k/wJxlJsbCkI5tnN3Vt87oErsuFIGOANljcYmlX4ljRgDmYuozNIC+Yi/MLJft7dfvXqOXv8kAI+bQUmEw7bNegyGSndgPNaCUVH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724258822; c=relaxed/simple;
	bh=f+vuucxLAED5W3z/rb9SlKuMT45vcRMYwbh+kcs8IAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KrxuIjbk65DnB1ii0nDSx1cNbmWIpsQQVOmKudlng00zgJRtX/CUbCa4YNGj0/48IKHfqLd0R8CWOPOvrmzySq5rMWLTkN1HvOPnFxUdk13ectz8BUWguaxiGVkpyl/zE5WHSbs9JVj7KZqU2lViKEt5M6OFqWokTCaQTeVpx60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M/JqCOGQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724258819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f+vuucxLAED5W3z/rb9SlKuMT45vcRMYwbh+kcs8IAo=;
	b=M/JqCOGQ/pU1wO5gzODqtGi1XqtumwocSqE9Smy7+Y+7At/tALvMMrsxtu8J76+g/8XKg6
	HDEfC0i/Q+OqHSIqx6a1cHw0KBb6oMMVbberbcKUDzPQ3WOMyAXu/xBERJQsjyjTcyZ+4K
	TffcqAD2N/fB9iF94cXQMz2I4fRgbQc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-DYqyk5w2NYy2L0q8Jyu3Pw-1; Wed, 21 Aug 2024 12:46:56 -0400
X-MC-Unique: DYqyk5w2NYy2L0q8Jyu3Pw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-428fc34f41bso60015645e9.3
        for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 09:46:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724258815; x=1724863615;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f+vuucxLAED5W3z/rb9SlKuMT45vcRMYwbh+kcs8IAo=;
        b=gXdXyLzwY549cKZC0vTfcpePZQyB6lLv5NqO/2W4t4ON9rlDDWexg7WTFu2z1DoZ+v
         kVVXy0VMjaOX9iCP6HTeEjWCZXK/6NDY2fR/cPgl8a7MZNgvQqpK7cjixptU/8l6R7o4
         uL3cRoUm5vnlhx8bEiHxnteXQ3V9PrvQOi19DBpT3NOs98P2kVUiHTaYB98lqFdzda3L
         WN2hkhZh+wtGz7Coym11ztB98zDoMlR/3zDagSRBI7sQacqRAOk+w1aXcet/i7eRaPJy
         XXN2mXKZ+eGy8wV/rwNlIQWuAOFhNuHwOAl21kc2ckaa4HtZZ7VVz99GWNDj/17T0FIU
         oYFw==
X-Gm-Message-State: AOJu0YyWbE/eE7BTdzQ0Ii2nLm5ZCeO/T8o0VZTBZMleWiCz/sU9vr6Y
	iuGF4lXHqRuLCjn2N+PJQRJYLqqTNOnaWAl+iopWPyMEazNGHLZVCQHLLc0Hi4sEzUDrHmIfKDW
	XFkU8yAjcyWxXSANkxOmEXjTzGfX0njbVpcQf7ANbssj+B7R5KO/QMg==
X-Received: by 2002:a05:600c:4e93:b0:429:a3e:c785 with SMTP id 5b1f17b1804b1-42abd21f736mr22608005e9.21.1724258814880;
        Wed, 21 Aug 2024 09:46:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+7ndXO7p17x6jiJjkerLBS07RQUf5DqDJRNUzQnYm9da6dNkYwy11xXsLMYPR7RQfvAw24A==
X-Received: by 2002:a05:600c:4e93:b0:429:a3e:c785 with SMTP id 5b1f17b1804b1-42abd21f736mr22607695e9.21.1724258814073;
        Wed, 21 Aug 2024 09:46:54 -0700 (PDT)
Received: from debian (2a01cb058d23d60064c1847f55561cf4.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:64c1:847f:5556:1cf4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37189897128sm16122725f8f.81.2024.08.21.09.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 09:46:53 -0700 (PDT)
Date: Wed, 21 Aug 2024 18:46:51 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	fw@strlen.de, martin.lau@linux.dev, daniel@iogearbox.net,
	john.fastabend@gmail.com, ast@kernel.org, pablo@netfilter.org,
	kadlec@netfilter.org, willemdebruijn.kernel@gmail.com,
	bpf@vger.kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org
Subject: Re: [PATCH net-next 11/12] ipv4: udp: Unmask upper DSCP bits during
 early demux
Message-ID: <ZsYZ+1PsNUMcT9Bp@debian>
References: <20240821125251.1571445-1-idosch@nvidia.com>
 <20240821125251.1571445-12-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821125251.1571445-12-idosch@nvidia.com>

On Wed, Aug 21, 2024 at 03:52:50PM +0300, Ido Schimmel wrote:
> Unmask the upper DSCP bits when performing source validation for
> multicast packets during early demux. In the future, this will allow us
> to perform the FIB lookup which is performed as part of source
> validation according to the full DSCP value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


