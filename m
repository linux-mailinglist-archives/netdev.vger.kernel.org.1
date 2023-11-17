Return-Path: <netdev+bounces-48537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E31E7EEB72
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 04:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C1771F2586A
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 03:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9CC610D;
	Fri, 17 Nov 2023 03:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="OYt/Q4VU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CD6A5
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 19:31:12 -0800 (PST)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1f066fc2a2aso728171fac.0
        for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 19:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1700191871; x=1700796671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UAbms2nLVWAYifj2VUcvr1iA9MxR0EDJBUZSIU5oCho=;
        b=OYt/Q4VUU2vVdYqawe5jLPKhXIdOiPpPlQfoKzFaTkekYHJ1bOuVwGtrpCeGAWnNsk
         8cfB9Z/wg9h8/pwr7ClZHcCuu3NcCb+Xhc4MGIFStsV2r3u7kDIF+0DQHHmfiYhmS75a
         G/SUl0O2FaddniityWwkBhRKtfqBlAeYul4LiviIsWP5692Th+Xkh+mbxnITmn/s9rbL
         VV9eU7ns0UQLjJWDnlGHDzuyNHY6srINmEh1lz5cLWshou9aIQCqAUNru61JqrSvxC1T
         1H2Pf5QYsfgLzNdePL/qSzLLOhrTQ55ES74UcOtlOGyBmPSZRYyguYk04TzdAmX4GF9g
         cowg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700191871; x=1700796671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UAbms2nLVWAYifj2VUcvr1iA9MxR0EDJBUZSIU5oCho=;
        b=qSc6CIJke1P3IzECfavBcZGcM9RpNO5HeKIujhvrtwPxWhCrTuta4tvSp+EzpYTSsA
         FSMC3Pr69VaVTfNQs5B/+9Bynvd7Qj+f1tRpf/F9GCf0/mGvjGYwGNI2l1aqj9risZUH
         TWWH+sJvy9/5QLM8g2JvzCHvejwqfvN9rX/zV3ULw1v9/1rb7tSHEIrlXRH/5MRQhZHH
         dQsDPv1TEIkNMn4rBDkzWoAmXU72CkMm3Z9Tvpabz5Yo4q7+yI5uYQSNBBJq4GdKHaA8
         7l+vxwDOF5BD9a1NqDxF4Dq/WkxILZVzF4aYyrtLxx0Ldf9xWAg2caPgMWAtBqnyTCUT
         MBEQ==
X-Gm-Message-State: AOJu0YzgsGJgEvuFs4D5IDlZGx3s/5wK9pVqWYG6PohwyjrCclNgYpfU
	dJEx8OEHasH3I/dqf9xewyX0x2OCkLA+6ZlB5EBhcA==
X-Google-Smtp-Source: AGHT+IF8l/v6e4cgSIwZN9h0y3fsKq+FkZF3+zyvgkXUA5DkFPvGg/a5y6m05eKm3pidFA/xS+n2vA==
X-Received: by 2002:a05:6870:c102:b0:1f5:5da4:9355 with SMTP id f2-20020a056870c10200b001f55da49355mr7385411oad.57.1700191871420;
        Thu, 16 Nov 2023 19:31:11 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id gu11-20020a056a004e4b00b006c4dc5b5b42sm470067pfb.33.2023.11.16.19.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 19:31:11 -0800 (PST)
Date: Thu, 16 Nov 2023 19:31:09 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Andrea Claudi <aclaudi@redhat.com>
Cc: heminhong <heminhong@kylinos.cn>, petrm@nvidia.com,
 netdev@vger.kernel.org
Subject: Re: [PATCH v4] iproute2: prevent memory leak
Message-ID: <20231116193109.37ef55b8@hermes.local>
In-Reply-To: <ZVa2Oha4ahHnYw16@renaissance-vector>
References: <87y1ezwbk8.fsf@nvidia.com>
	<20231116031308.16519-1-heminhong@kylinos.cn>
	<20231116150521.66a8ea69@hermes.local>
	<ZVa2Oha4ahHnYw16@renaissance-vector>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Nov 2023 01:45:51 +0100
Andrea Claudi <aclaudi@redhat.com> wrote:

> On Thu, Nov 16, 2023 at 03:05:21PM -0800, Stephen Hemminger wrote:
> > On Thu, 16 Nov 2023 11:13:08 +0800
> > heminhong <heminhong@kylinos.cn> wrote:
> >   
> > > When the return value of rtnl_talk() is not less than 0,
> > > 'answer' will be allocated. The 'answer' should be free
> > > after using, otherwise it will cause memory leak.
> > > 
> > > Signed-off-by: heminhong <heminhong@kylinos.cn>  
> > 
> > I am skeptical, what is the code path through rtn_talk() that
> > returns non zero, and allocates answer.  If so, that should be fixed
> > there.
> > 
> > In current code, the returns are:
> > 	- sendmsg() fails
> > 	- recvmsg() fails
> > 	- truncated message
> > 	
> > The paths that set answer are returning 0  
> 
> IMHO the memory leak is in the same functions this is patching.
> For example, in ip/link_gre.c:122 we are effectively returning after
> having answer allocated correctly by rtnl_talk().
> 
> The confusion here stems from the fact we are jumping into the error
> path of rtnl_talk() after rtnl_talk() executed fine.
> 


So looks like a GRE etc bug introduced by the change to parsing.
Should add:

Fixes: a066cc6623e1 ("gre/gre6: Unify local/remote endpoint address parsing")
Cc: serhe.popovych@gmail.com

