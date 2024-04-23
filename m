Return-Path: <netdev+bounces-90460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B7F8AE35A
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 13:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55F531F21DE7
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 11:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E925812B;
	Tue, 23 Apr 2024 11:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ILlY2ksB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A5B77F2D
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 11:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713870343; cv=none; b=OpIB0YfbmlBoug4QQ1A4JUrKWGqaJ5A9RCOwXre2EyAa6d4ZP4mvhogui3VCvWTrkQVGibK+tBh9VykxjQ1dPtzTo8u2A9tyqyFDBHqjZTyofycGhFtIq2DmW0efYNuMIxp8stLPVNG0rSVuVmYXTxJYNlRQaYksn/WODpVTOpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713870343; c=relaxed/simple;
	bh=FHeGv2YLNVirWB6r1WEf+deKuxbcZlAeA3VH07AC2js=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NaVlgzJzMgrPEouE1t9/D7sTyYrUZgqSV3qDdcSIUui0oJfSCB+UFDBWdTU5KaCT6Ziir/T5Ugz15wLsQy8zLg3RVLJhFgTSSzRXiIPPZbdBHyfMfNIN7QKB2H9n3lfzkA3O/GmRP8PkMnLXcpSIAVKuIKfiTDON9/cZvkiTcAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ILlY2ksB; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a4702457ccbso615210766b.3
        for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 04:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1713870340; x=1714475140; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FHeGv2YLNVirWB6r1WEf+deKuxbcZlAeA3VH07AC2js=;
        b=ILlY2ksBzfLEiieTj8af6j7zO4QSqW8xUDNIXuXgytTV6Q2ijZtx+69N3sQL+tG6q8
         PBOtjSr/f+V1bLzF/njVtWyisEjecg/wUVdj/0o915VKhw2XjEdrDt+AYGZBoyypI4jv
         Mdew80ju/DTqj4XkAXwyekrDYWOK7uZGimxaErcZ4PxnG1W6RzLE2r62ytloUdQRtUlK
         RhoD+X0klAQTXmfqB5ShCEg2faUyttHLxW7dhxGtHxBpFCPOgnZuiB9aQgWKgM6trKgF
         TQDNdcYrR0a1GvlvQLSW7T9JsyXagY7L+F5kMovuA5UcnozeP5SKQfRVQdX/R5Gy32ma
         qzgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713870340; x=1714475140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FHeGv2YLNVirWB6r1WEf+deKuxbcZlAeA3VH07AC2js=;
        b=CNyTkJi9xYRVTjX6gU+v1j3zmxZDMPjx2ykIyseu66GN783+7N3/7HzPb6fKH18/Mj
         YxgW2he3OHQ0HYWRwvxZ2E8VOw0Kxr/4fBmPuVURF5Cd2Th2/s/OLGBkw95ScQjZJRJI
         lZnYbFqkgyNHVUs9Emxh38HN7X7klGByqrLV7ce7+20YOE7f7BIY+nT3CVhsNu9RwsCN
         vuicks+t6FAckfdKKWf8NMuKnbJNah6kC4W32B/DICDEKH53Eu53Z5T9oMknfWzzAZZt
         6vBBxEGnLV3rrgTGIUCkU6SGtpCsZq10REEsvL3h65YccxpsJUXHt5pi1tiJTsCfeYEJ
         Fj8A==
X-Gm-Message-State: AOJu0YwT+TxqQ+5xyu0w30sSH7cO4Ow6PSXg/OLrdvYdUAQu0HXbiShb
	ZRtaVUYPSrBo17LefrzpUp/0AYWTy8EHRh1Bvg9tAxrgVyexOfVsyOr5RrU76DnE+gmp/JRRjjx
	2
X-Google-Smtp-Source: AGHT+IEMcFz/QSj8GzY/L5b8JyCjXa2e5imQLO79iWsFiejOl6cuc6LfL+IZRllbwNiKhQ7f03Q4yw==
X-Received: by 2002:a17:906:3897:b0:a52:42ce:7da6 with SMTP id q23-20020a170906389700b00a5242ce7da6mr6837988ejd.10.1713870340375;
        Tue, 23 Apr 2024 04:05:40 -0700 (PDT)
Received: from localhost (78-80-105-131.customers.tmcz.cz. [78.80.105.131])
        by smtp.gmail.com with ESMTPSA id c26-20020a170906d19a00b00a55662919c1sm7049435ejz.172.2024.04.23.04.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 04:05:39 -0700 (PDT)
Date: Tue, 23 Apr 2024 13:05:37 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com, parav@nvidia.com, mst@redhat.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com, shuah@kernel.org,
	petrm@nvidia.com, liuhangbin@gmail.com, vladimir.oltean@nxp.com,
	bpoirier@nvidia.com, idosch@nvidia.com,
	virtualization@lists.linux.dev
Subject: Re: [patch net-next v5 repost 0/5] selftests: virtio_net: introduce
 initial testing infrastructure
Message-ID: <ZieWAdmg8xfIyKiu@nanopsycho>
References: <20240423104109.3880713-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423104109.3880713-1-jiri@resnulli.us>

Please ignore, I messed-up. Will send v6 tomorrow. Sigh.

