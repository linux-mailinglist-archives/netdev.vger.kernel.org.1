Return-Path: <netdev+bounces-154061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5239FB070
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 15:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C852F1882150
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 14:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB98A1AD41F;
	Mon, 23 Dec 2024 14:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g56nFqAQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBAB1B0F11
	for <netdev@vger.kernel.org>; Mon, 23 Dec 2024 14:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734965954; cv=none; b=suOZmtis8xH9qBDakY7zJhXbFsL94geQP7xFecWZp2kGOlz16N3ZtslpiOY7W/Kj6CHJnu5SvqWUCvqX69tsOYqS3FeO7pWPqYoN756CgRXQAm1IixN7vWxRvLRSXs8VtfbhL5LyQKH3lmGuH34ysShTDCwtUwzxG9D7LijD8pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734965954; c=relaxed/simple;
	bh=5ezYGpq8Iuxdfnhce8wPyID8+bFnBmY10Jtl1auOU0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p0Be6/Or26wftb/SwayaISxSRuMPNPXf8+OwtU9t8aXlQG8o8mHeTm9xk4YWgZq7pbU3hK72pOgnbwzQvfKN/YjpzeA0hzzXLKQB2ZVwfQz1SyR1VgIvfwFKosGr1AMRZdFcLTc6svgb9BEp7ZlQQ4OXvOgZTPP/AT+rb0B9SuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g56nFqAQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734965951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5ezYGpq8Iuxdfnhce8wPyID8+bFnBmY10Jtl1auOU0M=;
	b=g56nFqAQ7FtkNCvD1QV492YFarL8tXm9bNL652Gff9m19kJK0ClHtc58bsSax+pp1KBMgx
	9HFM07P35jM973Q3NV3a/Dae9nPZJSO2MX2CNSb1kQvnEspr63L2zCX8p6qKy3snCdNGIC
	UQlW4EUvg6vgcSInRaDT9avodX+iK8E=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-ahDPOpolO0GuoFnF6DiuoA-1; Mon, 23 Dec 2024 09:59:10 -0500
X-MC-Unique: ahDPOpolO0GuoFnF6DiuoA-1
X-Mimecast-MFC-AGG-ID: ahDPOpolO0GuoFnF6DiuoA
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4361eb83f46so32315865e9.3
        for <netdev@vger.kernel.org>; Mon, 23 Dec 2024 06:59:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734965949; x=1735570749;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ezYGpq8Iuxdfnhce8wPyID8+bFnBmY10Jtl1auOU0M=;
        b=tGBSMYeEOKaMqP/C3tpKvK/KOE3eRDAZDF+HTmH6iXIfP6snA/7H65ZKEPfCCYnz8r
         ayWalg/Dg0hyjT9kvMHFmWevYi7rKdgTfBUo6LCFu6gBXtthbZwYJp8WhFBszvxHv2f7
         XKv0I6zYlPQblCArcvm29p/7bGi7JygA7wBZJWZ1IcIeSWtmjL6ICtxG/wH7E89fEwLy
         nTzn17z5LENXb5fxoK4cIn8mX6i8OgfD+l625ExgsAsNbIjrp4FZHUC0s0onJuV2L+Uj
         Js3/aIdKVDCybZWEpTaEJNRP4eZAB0TYGF2/GQ9Pqbg2Nw4IqQybbSfOu4C8VFCQZ+yM
         F22A==
X-Gm-Message-State: AOJu0YwsCWj+EH9Y7QgLdz/NgVRYI0vxjG7xwKa4zHxlLvmZNsCGY0bz
	/cmgCpcuxw4c95NupOyxvme7dFQCvPSqvKzzqVmb9Toc4xgsjDG8xFFOHQbWUYFo90zzMjWH4sT
	ncp1txSZLA+G+zUC0qLiSulsC1MjX4AHK1S7nWq3D3An0kKjfcBtN+KSL1quFSA==
X-Gm-Gg: ASbGnctMliLOC/mDphPTqpq5wzjs3nYP6P0ARr7CX0iz2LWQXs/OVr/rI9/oyshqf5P
	lEzOrgJpO+7dy+/UTxbncJZnPV9x2kwWPHf+uiv/ilFaQXWPU5Byc96kbwSYJxs5IQZFjIvhd7w
	mszV3roVU6fBYnsO45J+W45La2z29bZ9lok22klLM6FMgrzuPCbxtPZEpSMxRQBzFgoofZ9Km61
	H9G9Eem1saMy+5iQi62g0bsWew+qL547WjcCokwXY2qLqlAjvou2tI573szBR6UHpEpCCMGEaCo
	P/KhKN4hyRwZ3O1i8/YpP1vBTDmBlwlzKxwb
X-Received: by 2002:a5d:64eb:0:b0:386:3711:ff8c with SMTP id ffacd0b85a97d-38a221f1fddmr10451197f8f.23.1734965949260;
        Mon, 23 Dec 2024 06:59:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFj57qYkTVvwWeziq3MFGp8ys608EevXiecAiHxQvrM/+3YDzSOmdDsJewlqk5vL+Av0lXrOQ==
X-Received: by 2002:a5d:64eb:0:b0:386:3711:ff8c with SMTP id ffacd0b85a97d-38a221f1fddmr10451176f8f.23.1734965948925;
        Mon, 23 Dec 2024 06:59:08 -0800 (PST)
Received: from debian (2a01cb058918ce005e4e8e1560349352.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:5e4e:8e15:6034:9352])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8475cesm11577269f8f.57.2024.12.23.06.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2024 06:59:08 -0800 (PST)
Date: Mon, 23 Dec 2024 15:59:06 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, dsahern@gmail.com, stephen@networkplumber.org,
	petrm@nvidia.com
Subject: Re: [PATCH iproute2-next 0/3] Add flow label support to ip-rule and
 route get
Message-ID: <Z2l6us3/D5FcubTX@debian>
References: <20241223082642.48634-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241223082642.48634-1-idosch@nvidia.com>

On Mon, Dec 23, 2024 at 10:26:39AM +0200, Ido Schimmel wrote:
> Add IPv6 flow label support to ip-rule and route get requests following
> kernel support that was added in kernel commit 6b3099ebca13 ("Merge
> branch 'net-fib_rules-add-flow-label-selector-support'").

For the serie,
Reviewed-by: Guillaume Nault <gnault@redhat.com>


