Return-Path: <netdev+bounces-64381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F1E832C2D
	for <lists+netdev@lfdr.de>; Fri, 19 Jan 2024 16:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A3FC1F2350A
	for <lists+netdev@lfdr.de>; Fri, 19 Jan 2024 15:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46BE53E11;
	Fri, 19 Jan 2024 15:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ar1mGVsN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0D33C465
	for <netdev@vger.kernel.org>; Fri, 19 Jan 2024 15:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705677355; cv=none; b=IEToA11/yAv+XM3TkBCw6JSkiarqCEWXBtEuyUfjyRVxiPhBf70T5AfP0FaqpXx9L3UKlzz4XSNuLdyrUgq9YHptsAJEPqSK+gfa4Pv4Ean9yN1CG0uXTiNnQJs+oV+TWXte4dC09F4FKPKIOV9s29Wd61d37LP9tqToMLvQd+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705677355; c=relaxed/simple;
	bh=1w9W/cr2N+ju7Ch91Z498wknc9aFhxQnor/VZnNQa4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cFdSfiqqScHAhgsvI3g+c2KcA9yjECVsDHD/MuDQEcEJ0psN8X7m81ScSraHc0lYVje332/zCEfvNut8swJ46EbcT8WMWrhOZ/6+HV0RZmn+bh/EFtZaV0BK8g+KFPnTf4pWvDeA9sludedkTgl89GOnZipVgc/5+kP+7sVi5iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ar1mGVsN; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40e884de7b9so11093685e9.0
        for <netdev@vger.kernel.org>; Fri, 19 Jan 2024 07:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1705677351; x=1706282151; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l3KtGTJ8s5ag+c9fOq0ikI1OrIgLOrquKboW9ABy8GY=;
        b=ar1mGVsNexwEA9SrEMKaAvpVh5+Fyw7VPx+Ic2BNaRO0Z76OeKEIkjm3Zrlh3L0uKC
         TTDSsYmwsk56P5kY/llMLKza4u6q+FKIGOLabzLbaUkpzKaoAfuZox6jgjlvEigu5KSZ
         hVAdURZWX7flFqN0PxdrgzxIbEzIYjrF8SVMA2qYaSJZIZk2dU7GeLj8vkseqGgW/+7I
         SEHH3EFuOZhTFAkon7XW/k3xh+LeWvKJ2lHY26eH/xaz+9I3OcKoLB2qxX5w71LtAcva
         pEB4OqU2AhZQBSrIFSZ8S5hnKmQNfD/coRvU2DB3Y7UZ3ixsJLO+22WIWmps92QYsWvL
         bAng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705677351; x=1706282151;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l3KtGTJ8s5ag+c9fOq0ikI1OrIgLOrquKboW9ABy8GY=;
        b=ZbraIq8gxBEYtEuPfgcI5bKMUbjYS9wXxghEsUkW68nxR5JdrNsHjxW99T9wTIEyuY
         M0HfLC2sg9ZEUG8Mxm4L+qAaLHdXHlQzk03RYw/uTTCwN3ZvqoYIH9tK87QJhDA/XV3m
         rl5OjgqZGR6uHovKBJea+LtYg9PQSsXQNqgrXE4DOYO71IZ8okKgPfnCLaKG5tdVTP41
         oX8JQOQ3b7ejsbg/QWufkQcC5TZJ92wxqLT0W4CIA6F62jquFivAmJ9sAf3ofbTXR2q4
         oI1IubIc6ZrTv7mVH01Z1KxFPGG4ps/eca1FaryXm3ROPM+3HTWFQc9q8wh7zGsGoP3s
         g93A==
X-Gm-Message-State: AOJu0Yzu+c+jbsKAq1Y4GOXU7/3DLf3i2rettq+SwWq4ngH4dyu1Kc3U
	HwkOSDSvUkdJpxP4sQcxFjmnvVG9MBJUV+kEBuQ9MBnBJhRA18rkLfQFVUQZKfQ=
X-Google-Smtp-Source: AGHT+IF+9LcbggsFz5IFgFp55p4cRyuVBIWhMWva54TZCUJYf/emAtTU0Qc7c+5OAfIJwM9T+i5usg==
X-Received: by 2002:a7b:c846:0:b0:40e:4997:b204 with SMTP id c6-20020a7bc846000000b0040e4997b204mr1626640wml.225.1705677351343;
        Fri, 19 Jan 2024 07:15:51 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id i6-20020adfb646000000b00337bc2176f6sm6727104wre.81.2024.01.19.07.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 07:15:50 -0800 (PST)
Date: Fri, 19 Jan 2024 16:15:49 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com,
	=?utf-8?B?0JzQsNGA0Log0JrQvtGA0LXQvdCx0LXRgNCz?= <socketpair@gmail.com>,
	daniel@iogearbox.net, lucien.xin@gmail.com, johannes.berg@intel.com
Subject: Re: [PATCH net] net: fix removing a namespace with conflicting
 altnames
Message-ID: <ZaqSJU1FzvNAKBiH@nanopsycho>
References: <20240119005859.3274782-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240119005859.3274782-1-kuba@kernel.org>

Fri, Jan 19, 2024 at 01:58:59AM CET, kuba@kernel.org wrote:
>Mark reports a BUG() when a net namespace is removed.
>
>    kernel BUG at net/core/dev.c:11520!
>
>Physical interfaces moved outside of init_net get "refunded"
>to init_net when that namespace disappears. The main interface
>name may get overwritten in the process if it would have
>conflicted. We need to also discard all conflicting altnames.
>Recent fixes addressed ensuring that altnames get moved
>with the main interface, which surfaced this problem.
>
>Reported-by: Марк Коренберг <socketpair@gmail.com>
>Link: https://lore.kernel.org/all/CAEmTpZFZ4Sv3KwqFOY2WKDHeZYdi0O7N5H1nTvcGp=SAEavtDg@mail.gmail.com/
>Fixes: 7663d522099e ("net: check for altname conflicts when changing netdev's netns")
>Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

