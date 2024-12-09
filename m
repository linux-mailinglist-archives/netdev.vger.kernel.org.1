Return-Path: <netdev+bounces-150166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E9A9E95A5
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 14:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89B522821B7
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 13:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D37A3597B;
	Mon,  9 Dec 2024 12:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fbOGnd//"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E363595B
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 12:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733749184; cv=none; b=RlFmcjMER50A5ZQGJT284BeZuXooc1+ux5EakChxvSaEpY+Hgs2U6FWtzrwDnVg3HAFl+fzTSlRNfrjsZS9PeNt+QG3QqvNyu5ZTdB/PoKsQHqVeIPpqHocZJimYSF6jmJWtsTKvIe/bJAlx8zL8j5fqYkefjBXoZK2XiKYyytQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733749184; c=relaxed/simple;
	bh=/ryV6IzvZ+HqXSJnGC+wom1MiwzaQb78ZbJsm2JS2o8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sHghyDcZF+s3BiDfi8fVjg+75ac6K+47kcN9+w3f4aRFVDnOiXcbsA6XOp5RvLI1Mdt/jKZkFvHnQ+4TSFHP7YNU4hxlJscznDPVA5hDN2ao5mADdOZKSb+4sxDIZbBE5B/jX9Kak/SVWklL5g0W6HmNcmoRvhyptv0Z1MyXhns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fbOGnd//; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733749181;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dhf/XfzpYsSPb93mu/nTzylFTC6NUpySvcmgI47UhBQ=;
	b=fbOGnd//OYoYrP8rS3I2gKdWSI/Z3nH4b6G6GR2pJq0obS0mdMkKDCwAr4zXlx2L0M/9VB
	IiXeuBD5rRTRhpkQ2yllJ2+PJKmCNyQOiRZl+kyZw8QoCt0jL+zlv2Wrk35uffIVe5UzzE
	E2VnAl5JOJf+SFno9RZslgUmo2NiVYM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-7J5m7q_dMWOi4AZx7g12Mg-1; Mon, 09 Dec 2024 07:59:40 -0500
X-MC-Unique: 7J5m7q_dMWOi4AZx7g12Mg-1
X-Mimecast-MFC-AGG-ID: 7J5m7q_dMWOi4AZx7g12Mg
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3860bc1d4f1so2415312f8f.2
        for <netdev@vger.kernel.org>; Mon, 09 Dec 2024 04:59:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733749179; x=1734353979;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dhf/XfzpYsSPb93mu/nTzylFTC6NUpySvcmgI47UhBQ=;
        b=V7lZpYJqOw0HMoDkkENALx6MuNmqHUXuvBBdM7dGr9psaivtZ3vyNM0/RX69+jwajB
         bZMheqSuRLbm1bSjLg6V0zSVFKLq2Gqjoh9e3esAPrmP/CeFdgGmEBOV+Xaq0ShWFPnq
         tY9nZGNSwQax+tcxpEC2ENi4Wj1Sni/zlqD1jR7OcChbUWlx0dzajTKUFLJzW5jsvBpb
         we0KCma6I65tqkJx1YxRpiWiARjsRL+gioOJTKIpo0rTYzZ4DYjl0Ym9d/WBtp8BPC2D
         vD/mF3DJkr29nffuSlPdt2Vd5qWpm1rRzq+r7s8H5seYsCUbez3tKXbAxAoTlpZwxm+E
         QkGA==
X-Gm-Message-State: AOJu0YwO7u5FQnWLuOrqLxpncVLOSTmxUW7kx5UN0Tja1XboMnff2+hS
	3Wh8MakuAR1gWIcqXmpY61AQnF8GxDOVvkqhqLp6oNY0bjvIaaRxfkH3AAiWAOXDfyqBCvio/oc
	5spXhMNTzwb97yyO//MwXEJtrcKNVIwMJtcuuwIVUhNqww7NhheAeXA==
X-Gm-Gg: ASbGnctGTqO9T45RS7cx8DZJidgofJmDS+tJcFYM2k1aW60XFeILy479KPwbbTjBTfs
	e2agEGj/+ijV/5ufSZVtnjTFcWuL559+e5GjAtxObYzjEaacjEQGqWf59a9eG95xIAOuI+S2ZCJ
	3r3bjEu8Dqjwkg705O9W9KcRGY1uvFSgFJkZTs29x/QF964DrVS91MV03WVhXxkkfPVK61daCUs
	aZKX6DvsJ/TCjb3aSMZkLifAU018By6SGft6zlw4Io64gPFjCxkBN30dpdIfjWXI3VCOSLxZ2Kg
	t51bFRChP9r20iN1rUF5mmZ298Nc
X-Received: by 2002:a05:6000:1a88:b0:385:e9ba:acda with SMTP id ffacd0b85a97d-386453c5e58mr238192f8f.2.1733749179448;
        Mon, 09 Dec 2024 04:59:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEhQzfxjFNqHJB6XTPw4CbBK7oqzNkaGMUQBK4V27M6uR4Sq8rd6LkAhzCWUMGuV0TiU2h17Q==
X-Received: by 2002:a05:6000:1a88:b0:385:e9ba:acda with SMTP id ffacd0b85a97d-386453c5e58mr238169f8f.2.1733749179099;
        Mon, 09 Dec 2024 04:59:39 -0800 (PST)
Received: from debian (2a01cb058918ce00016ee0d7ec045c7a.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:16e:e0d7:ec04:5c7a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434f7160599sm44388655e9.23.2024.12.09.04.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 04:59:38 -0800 (PST)
Date: Mon, 9 Dec 2024 13:59:36 +0100
From: Guillaume Nault <gnault@redhat.com>
To: James Chapman <jchapman@katalix.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	tparkin@katalix.com, aleksander.lobakin@intel.com,
	ricardo@marliere.net, mail@david-bauer.net
Subject: Re: [PATCH net-next] l2tp: Handle eth stats using
 NETDEV_PCPU_STAT_DSTATS.
Message-ID: <Z1bpuGs5Y8kmY5hu@debian>
References: <20241209114607.2342405-1-jchapman@katalix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209114607.2342405-1-jchapman@katalix.com>

On Mon, Dec 09, 2024 at 11:46:07AM +0000, James Chapman wrote:
> l2tp_eth uses the TSTATS infrastructure (dev_sw_netstats_*()) for RX
> and TX packet counters and DEV_STATS_INC for dropped counters.
> 
> Consolidate that using the DSTATS infrastructure, which can
> handle both packet counters and packet drops. Statistics that don't
> fit DSTATS are still updated atomically with DEV_STATS_INC().

Reviewed-by: Guillaume Nault <gnault@redhat.com>

Thanks!


