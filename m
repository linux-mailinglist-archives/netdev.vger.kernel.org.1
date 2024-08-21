Return-Path: <netdev+bounces-120620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37ACC95A007
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 16:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E86BE2842AD
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 14:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C423719993B;
	Wed, 21 Aug 2024 14:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SgsgiDJC"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA91B76410
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 14:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724250950; cv=none; b=p2jaztKG/r/dF+1M992aJ/5jhrnrfTBYMSHcN5Dqvv1X2ggIfeF0wyTSI6wTrsqUYubysKc4xE2xNBxS+XfxYzTCeOarjMdzwjh8UxPDMGOJ3243cymm6aqnX+SOC+BTX4UmdpnMZCgj4geGcQ9thu1VFkwQq6SrZ+XPvKOqJYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724250950; c=relaxed/simple;
	bh=phxy8Nt1OqlzmKYCd5FABRPmYnLA1V4MuusvN9MrHXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EsG/PKy4rfSFgVNuADxkMNtcAwauJBMjdvqxiBnjihbeN0TxB7mEMfh+s2kJpDTXXK2Iyoq2OY9tjo2wjmPUKzTLqGpsKgtkCGCFCiqlE9mFizwDOPrtncxXT8EZ4oM5eD/VFY6pqooxHH2YNRMviwD1QF0KfEtVI4i0U5gYNkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SgsgiDJC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724250947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=phxy8Nt1OqlzmKYCd5FABRPmYnLA1V4MuusvN9MrHXA=;
	b=SgsgiDJCHpEsrkvStAMX9yN0EalhGwmr631XCOIfgt/WSFW4kuuMPVvsUTI1cV/iwl82gf
	XyDyslD6XjV19TViMzEeNLoE53dWrghe61KQfgaqYNOIXqSHErJOT2CdjCz2pg6trQhTiz
	BdFXijfPN+qCQUnPDji+u/pY4/ESo50=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-uvSABWlUNmaKXhlq5aMHlQ-1; Wed, 21 Aug 2024 10:35:46 -0400
X-MC-Unique: uvSABWlUNmaKXhlq5aMHlQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-371ab0c02e0so3260359f8f.3
        for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 07:35:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724250944; x=1724855744;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=phxy8Nt1OqlzmKYCd5FABRPmYnLA1V4MuusvN9MrHXA=;
        b=bEIDUvvz2k8oL9Z7d9mwPL/BHIxBARm0VvgK6gDwgavmxhoGqvDkMUEMBA5TU+HTxP
         DmaAB/ObjbBGYS95H0B+r38s2UWE7hXcU78ABl2eM1nt/TfwjxnyDXZ6EnZnmLoBJgY2
         H7gP8nMxPAugDLfeTi10mIdXlt7DyasRqrC7FH4CQlXbL7a5OZaaLVAkLNvwbskmyt7J
         nOZSTzQ0OA9mC2BJfXIrGnRzxbO9TeKW/BR7hmLY1wDuTTRctCGqib0uRQv1Mn4HvwGL
         oRuXaDqApMJPluYrYSk7hlu1Xo+rihOH5Z/+KAZT5VlmAgmE1YbYSao/hNylts99N7qa
         9zYQ==
X-Gm-Message-State: AOJu0YxWtmEwqWk1cGP04vcQXjmyiYPz4J++hclpXT7j75/x2bCYeOub
	7h7BpizHot6lIZ+VXqLvhDA6ak2cF3/NTEWjBc5LFqBu0iNA7q9I9kDN27fq8IgriINs2AQqrrE
	cAT7RvXk/qCsHHfZnGIRFO3lP9AoE/vzcxBg0pMifspcY1JVHm+mGOg==
X-Received: by 2002:a5d:4252:0:b0:366:efbd:8aa3 with SMTP id ffacd0b85a97d-372fd57fb24mr2452556f8f.2.1724250944652;
        Wed, 21 Aug 2024 07:35:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFguEF2AfMMWHH9u4at0L9cYsD4b608kMRe3EHd4+r93puOqWjRitnQ5PtgsiIk3CRcl7anlA==
X-Received: by 2002:a5d:4252:0:b0:366:efbd:8aa3 with SMTP id ffacd0b85a97d-372fd57fb24mr2452513f8f.2.1724250943820;
        Wed, 21 Aug 2024 07:35:43 -0700 (PDT)
Received: from debian (2a01cb058d23d60064c1847f55561cf4.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:64c1:847f:5556:1cf4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-371898ac79esm15887277f8f.110.2024.08.21.07.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 07:35:43 -0700 (PDT)
Date: Wed, 21 Aug 2024 16:35:41 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org,
	fw@strlen.de, martin.lau@linux.dev, daniel@iogearbox.net,
	john.fastabend@gmail.com, ast@kernel.org, pablo@netfilter.org,
	kadlec@netfilter.org, willemdebruijn.kernel@gmail.com,
	bpf@vger.kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org
Subject: Re: [PATCH net-next 01/12] bpf: Unmask upper DSCP bits in
 bpf_fib_lookup() helper
Message-ID: <ZsX7PQNRh+9Cz7ig@debian>
References: <20240821125251.1571445-1-idosch@nvidia.com>
 <20240821125251.1571445-2-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821125251.1571445-2-idosch@nvidia.com>

On Wed, Aug 21, 2024 at 03:52:40PM +0300, Ido Schimmel wrote:
> Unmask the upper DSCP bits before invoking the IPv4 FIB lookup APIs so
> that in the future the lookup could be performed according to the full
> DSCP value.

Reviewed-by: Guillaume Nault <gnault@redhat.com>


