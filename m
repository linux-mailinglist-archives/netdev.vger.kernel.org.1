Return-Path: <netdev+bounces-134030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 339B1997AF5
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 05:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E78C1287501
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 03:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A48418893C;
	Thu, 10 Oct 2024 03:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k9cYxlht"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CAB1BDDF;
	Thu, 10 Oct 2024 03:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728529264; cv=none; b=GGxGKUyPIhv0onBdpTbH2QXiBio6gS+FM+Fs1vss1HobVKsKVN5J7Tdz0dQ0e4s07tmJTp1PSz7FeJjLENsvWlwj373IVINwXNrx3qZYBH2Ut0RTi5+/CRJ5ZITTzDC+YvzH7B7A7QmCM6vwT3N+r1Ig4PydGh6m8HHuD2BFtog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728529264; c=relaxed/simple;
	bh=aLs0MvUCLAofU2lCCIVDPON8mIU1J1lcpTUT+63WbjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SFS/VFPuuLWqStS/17ae2b2VICo++UMYzPegmB6n+wMeQELjzSiIwYw9MygQyykykCdf8otHyFZkipV/MVE/GcNuBV8oVUtNwHwzMpch4FblApnxxL4JqolKFnA9O9J5DWXq+dNq92f3PnX4ITp+xgwPQac4sl5p5E44Ushq8VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k9cYxlht; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-208cf673b8dso4110225ad.3;
        Wed, 09 Oct 2024 20:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728529262; x=1729134062; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aLs0MvUCLAofU2lCCIVDPON8mIU1J1lcpTUT+63WbjI=;
        b=k9cYxlhtF+MiQscHQ6BqZyq0Nyry91g2K9lW0lSKxacedOayV6a4Am0z2j9bHesF/d
         gU2v+9s/q/v7NPM4TBZP9O6moINy8XhcIU9Bg1R+agde/UEKfhZoq2Lk3F1Nh9Wrm+gd
         A/8cIbZtvQpx+11kGvY+eg2iFtd1f5gJzmy0rs7k6+38mclqfnsjFBubK6JduIAQD+wt
         ZevPhyr/GSoFul1ZtFta/0TlvXKWvIXjp11OqwXWK6Hh4jfWR2LIlg3gGR8gekda3Rx3
         xtGbIMpKJg6CQuJPAQNf48RkpbOWHv9HxL39RIcMt9UmsQBfLfeXG+Hk/Oe5WdHRWPOR
         REqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728529262; x=1729134062;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLs0MvUCLAofU2lCCIVDPON8mIU1J1lcpTUT+63WbjI=;
        b=ALJGFzVdStCFGoW3tOPhpKu+/R0rHxYwBrzQ7CjrHk9OL5bvvgyN/CJ9zYenLoRJ+O
         jBKKC8re16lwHTG+Cv2kgfDaEr7IchNG+7QS5sPCWOmlRlWIDjVcCF86UTWws4mCTZHm
         oWpt/+beRgFArJAU+QKEwfjtdgDbyfRNdBWef/T/1oZCB9lQTpxL051K21w4YFLFPEUE
         bPR2G+HkKNtCL8/JoSsgFDARGbz5uzja7AcN4xoLmAlT82LoNRfM7og1uYJ3Bk9XA0J5
         XQtHZLgO+D/bD26iUq/AuWpSjv+ztdaqqkYGREGDM8/jEeXPtLV1ChGDAb8L6hpDXHvR
         /BUA==
X-Forwarded-Encrypted: i=1; AJvYcCVxB29XfHTiExpSuoKqWPcC6I65n+2ie8vpB+gmQG/Wq8E+oLXOBeAlmP7QXyqaf4fBl5kaqJbT@vger.kernel.org, AJvYcCX0Cv3LkDKt7Il5MdZ1YMYEyuOhVb75F+d4D3hSG9r3ON5OBoBa4Xp0PmLGtTBJtz0aPdq0WjiiJdcVtVU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypu06nhse169tfQE7AKmRrPY93Qs8yYO68NggMXbx0DbRcmm7+
	G62hXP0dO0quRzWN7XzL1yDI6vHHatLWYF55t6AS+5YRqyHUf8Gu
X-Google-Smtp-Source: AGHT+IGRaakPox5E+y9r6VwzrOYOnwIpNk1IVI4a06VciaTfeETxIyK8+8aWPC31EdJRo+k2i14qTw==
X-Received: by 2002:a17:902:e810:b0:20b:8776:4906 with SMTP id d9443c01a7336-20c6377f6e6mr69914725ad.37.1728529262239;
        Wed, 09 Oct 2024 20:01:02 -0700 (PDT)
Received: from fedora ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8bad99ecsm1233235ad.3.2024.10.09.20.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 20:01:01 -0700 (PDT)
Date: Thu, 10 Oct 2024 03:00:55 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Jiri Pirko <jiri@resnulli.us>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] netdevsim: print human readable IP address
Message-ID: <ZwdDZ01RG6Lp84BV@fedora>
References: <20241008122134.4343-1-liuhangbin@gmail.com>
 <20241008122134.4343-2-liuhangbin@gmail.com>
 <20241009122122.GO99782@kernel.org>
 <ZwafpMwkVtcGjk0v@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwafpMwkVtcGjk0v@mini-arch>

On Wed, Oct 09, 2024 at 08:22:12AM -0700, Stanislav Fomichev wrote:
> Can you also update tools/testing/selftests/net/rtnetlink.sh
> accordingly? There is a part that diffs this file and it now fails due
> to new format.

Thanks for the reminding, I will update it.

