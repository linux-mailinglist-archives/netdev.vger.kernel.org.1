Return-Path: <netdev+bounces-67096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D12528420A4
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 11:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 101601C25819
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 10:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC13F60895;
	Tue, 30 Jan 2024 10:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ptrBUDj8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E94960882
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 10:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706609171; cv=none; b=mglutryC552n/Hk+Nh2ZyYPcCyrIqOPuPaUKM7PdqgvAMvSjItfbKZNB7iZYPW5nTLClHLXi3Mdm+4JrYge+dGqlX3j3KB06d9PNUtivPpY+DoqICxG5H6dGIk3+vaU4wSGzT9PisVCZQNDRpzVnnfIhnMYEGGRwEzz5si7QHsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706609171; c=relaxed/simple;
	bh=mN24du69dfpVsjxf9h64v6haXtXcEvje0y/RHCPRKdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QX8vBPsLQ8NgoatvAZum7NwoeKgqAy+bt+CH+rksSTZ/rupQUa8VeZ/AgDe5afq8OQRaXj7oN0owgY2jg0uJ2aDmDDrgPka0O6F83XZoVRe13MBMwGD+MvYkNRfLngnlm37VzIfhtQE2EiM3cX3i/wQ50jdCqnAJDqOYQaLE1k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ptrBUDj8; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55f0b2c79cdso2650176a12.3
        for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 02:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706609168; x=1707213968; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=77QGicsthLBoZ1ghB2R2tu5urtPmZmFpryoMl9wbInE=;
        b=ptrBUDj8duyMJozmAfnvAWXkTNC88SJPBaRHc+sZbg55/F3dsPDKBQooBP3miuLiYv
         dEn0M24AxaWjlv6epqEwnAl8sDrKgL55KuPek08txeoQ2JxERoTMHsVWTGu9d/P2U9wP
         sQIkKHajF88x4JqLIOI7C2ThOuoFLrNIfilR646auxdXMYDJE4VCyrJP+3Zjox4SzYev
         3edT7sGCpZEem8UNIn44THKXwKVhuGuEkkOaMSy6sDB38OlxzVPvEPZGPs58nCb9kQM3
         FKKgrQI0ytciiq3jtM7CDAos/odFwbrZBPLDsERCMRAQaW6SSMMXBCPXmVWZd/+A9Exq
         nm2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706609168; x=1707213968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=77QGicsthLBoZ1ghB2R2tu5urtPmZmFpryoMl9wbInE=;
        b=pCPNouzxUMn8QQWnjExNJb5N0mNPZkPgbv8ioz+TH3KK6QSJMATyxcYXHy68w53T4h
         i7MhCgXNT0NOFJQ41jaBp6dm5h5iyZ6j5VmNSOJv/Wgz3u8kiaR4yZ6OjG8IhGtgrBOO
         azDXkIDmAYr/Z+W9v0QaZFwNesV6GNV7beEl7+DFqmxsqskoddF+oQFT1jDYRXBTsKBK
         rXuJ8FL5kO0PCe3L6pk9OxTOeBjnBhtQYuFbr5UpcjIbYHyUhDxFPHAj7gOBL3QcCyPV
         PFIUgs4UrtJYT6Exxf931cS/5XgOirt9V7nnDruE92dIhna8U1rkGFzJRY8FzZ7adA1/
         zTFw==
X-Gm-Message-State: AOJu0YwhcsJIhuPZvOR+xT5PKZwYV5VpW5xiMate6fYW/ewqhdlcRu73
	YWGW0dz56+T0Kh8ovnRIFnO03PPIecLq1PnuR0WWGvKY5hY56XZXc7XVI4lcx7w=
X-Google-Smtp-Source: AGHT+IEFGJwTV8iQxLqYycNi0re0c/Uh0a05u4IOgDhPC5KHMClkENdc+BnOMwOQQuUgVXt12gmVJg==
X-Received: by 2002:a05:6402:281:b0:55f:3975:209c with SMTP id l1-20020a056402028100b0055f3975209cmr899981edv.18.1706609168242;
        Tue, 30 Jan 2024 02:06:08 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id k11-20020a056402340b00b0055f11bd3564sm1523017edc.8.2024.01.30.02.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 02:06:07 -0800 (PST)
Date: Tue, 30 Jan 2024 11:06:04 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Kunwu Chan <chentao@kylinos.cn>
Cc: roopa@nvidia.com, razor@blackwall.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: bridge: Use KMEM_CACHE instead of
 kmem_cache_create
Message-ID: <ZbjKDLtbiKXYpKew@nanopsycho>
References: <20240130092536.73623-1-chentao@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130092536.73623-1-chentao@kylinos.cn>

Tue, Jan 30, 2024 at 10:25:36AM CET, chentao@kylinos.cn wrote:
>commit 0a31bd5f2bbb ("KMEM_CACHE(): simplify slab cache creation")
>introduces a new macro.
>Use the new KMEM_CACHE() macro instead of direct kmem_cache_create
>to simplify the creation of SLAB caches.
>
>Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
>---
> net/bridge/br_fdb.c | 5 +----
> 1 file changed, 1 insertion(+), 4 deletions(-)
>
>diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
>index c622de5eccd0..c77591e63841 100644
>--- a/net/bridge/br_fdb.c
>+++ b/net/bridge/br_fdb.c
>@@ -35,10 +35,7 @@ static struct kmem_cache *br_fdb_cache __read_mostly;
> 
> int __init br_fdb_init(void)
> {
>-	br_fdb_cache = kmem_cache_create("bridge_fdb_cache",
>-					 sizeof(struct net_bridge_fdb_entry),
>-					 0,
>-					 SLAB_HWCACHE_ALIGN, NULL);
>+	br_fdb_cache = KMEM_CACHE(net_bridge_fdb_entry, SLAB_HWCACHE_ALIGN);

Same remark as to the previous patch, the name would change.



> 	if (!br_fdb_cache)
> 		return -ENOMEM;
> 
>-- 
>2.39.2
>
>

