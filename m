Return-Path: <netdev+bounces-119143-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 998D895454D
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 11:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22208283F37
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 09:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771D713C690;
	Fri, 16 Aug 2024 09:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="fERQoJiT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D66E12CDA5
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 09:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723799994; cv=none; b=e7JKDexQxVnQ7tMzI7o7KdNznIN9RKgPTE53C4ejG+2KRVbUU1SmtOz4hAGgl7MxMAx9bhBiDecafP2jMYj4jgMtQktWV1KGD8PJ/Tg/LK9shsmDrxSxZ069087L8vQYZQ9R34iOCjtKCoFhMMFTTxPMrg4HUN9cq4WMETx4zoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723799994; c=relaxed/simple;
	bh=Txv6dxhCQb7CpH3BtkANJ/8qLWEM5WFLYt0CnFayVzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fhFt/plnZOEPdJjOyGM5KcJEIjQzz95YjoLTOyWbHbseAVnO80QGzI5CwecCDh3uv+v2d0z2sBlCrg2rUqyoPVkM4nT9N7yqiRCL/VyEopYiQVM/g4ZUpg72AoiZPwoF33KqR9ucyl2NQjosopI1EBwzUd9si0Dk+Tax8UV2wF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=fERQoJiT; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-52efe4c7c16so2286553e87.0
        for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 02:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1723799990; x=1724404790; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hZg61CcIJSroZbZ9Hf8HXuiiFUn95rDGA0Vv5KsldF4=;
        b=fERQoJiTwGoBp4IPekXYOrl/NOL2l+S8bGQsZOgGSSWGtAYAMQ2/fp52DPmlfzq+0q
         TsdVNdHI4Sj7YeAXZDMl6lnYmLzt00eaawWV5bx55N3iEsn7qaIBK0xPCkDgk7GeYCu9
         XV/f3FWSt2yQEF00y2ChIi5Cp7JHtTf3QRrqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723799990; x=1724404790;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hZg61CcIJSroZbZ9Hf8HXuiiFUn95rDGA0Vv5KsldF4=;
        b=jd32/JU2pGFCk8dqPzkCOLihpzfEEOfnuqWB9yoowz+5jhPZ38W4/yi9eSIkc4eBe8
         4e13RhNQmTLLAjCw58aXsUT5Uk04IxTAmOFrHUV7unLodustMGqXOHrd1ESiir6LCFmR
         byT9jvv5jSLhdXGfiqXac78ejHT4td9XUVAab1Pa3wW0qxiMVRtxLjlRO3zFFcXWUbC1
         uBA7XkZoULNUSXR/yq6t+nuAOy5BXD1AwsWawxMxEuI5slC39fMzfZbvJL3jdlhQm+Vi
         ATyOk32p3Fe+5b9BbTpPZ44/YvCQZKm6BcvMLpriz02fpxTT6+dP639tfTTHigmNwWcD
         klHw==
X-Forwarded-Encrypted: i=1; AJvYcCVhpfgx/46+972eFQkimOm0aAZ9D3ahnug2/ztOSu2oW4ow+L+9nQwONsN9hiYp2J3TeYf0p8wLKj/T7DyeLQ5uf06OOaFf
X-Gm-Message-State: AOJu0YwbD7uTFYA+LZK4omfnt/GvncGd0fDyWke/xe2oGmpqj3i4K2M/
	DMegTSGRTRx8WjeOVcl+VxSRNs7+fMCW4mWM5j9ohufluCvifkgS58Te6nF/lCw=
X-Google-Smtp-Source: AGHT+IFJtuCbxL5nft87aWupUp4cVGbBa6eOge9TSai3Pyf3nrGLBUDiG8eTsXpd8/bhLmgrx9Acig==
X-Received: by 2002:a05:6512:2346:b0:52f:c833:861a with SMTP id 2adb3069b0e04-5331c6e533dmr1216274e87.51.1723799990381;
        Fri, 16 Aug 2024 02:19:50 -0700 (PDT)
Received: from LQ3V64L9R2.home ([2a02:c7c:f016:fc00:24b7:f59e:d2b4:4e58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed648f55sm17654675e9.3.2024.08.16.02.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 02:19:50 -0700 (PDT)
Date: Fri, 16 Aug 2024 10:19:48 +0100
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Edward Cree <ecree.xilinx@gmail.com>,
	Network Development <netdev@vger.kernel.org>
Subject: Re: Per-queue stats question
Message-ID: <Zr8ZtKXUgUo5OgSK@LQ3V64L9R2.home>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Edward Cree <ecree.xilinx@gmail.com>,
	Network Development <netdev@vger.kernel.org>
References: <56a36d45-f779-0c67-2853-6ead9e8f9dc9@gmail.com>
 <20240815124247.65183cbf@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815124247.65183cbf@kernel.org>

On Thu, Aug 15, 2024 at 12:42:47PM -0700, Jakub Kicinski wrote:
> On Thu, 15 Aug 2024 18:11:42 +0100 Edward Cree wrote:
[...]
> > On a related note, I notice that the stat_cmp() function within that
> >  selftest returns the first nonzero delta it finds in the stats, so
> >  that if (say) tx-packets goes forwards but rx-packets goes backwards,
> >  it will return >0 causing the rx-packets delta to be ignored.  Is
> >  this intended behaviour, or should I submit a patch?
> 
> Looks like a bug.

FWIW, while debugging the stats stuff on mlx5, I tweaked the
stat_cmp function to output a lot more information about each of the
values to help me debug.

It seemed too verbose for an upstream patch at the time, but since
you are going through the same process a patch might make a lot of
sense.

