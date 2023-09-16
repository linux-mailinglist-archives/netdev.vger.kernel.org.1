Return-Path: <netdev+bounces-34299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B9C7A30ED
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 16:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 242E71C209A1
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 14:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603EB134CA;
	Sat, 16 Sep 2023 14:36:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C7E3C38
	for <netdev@vger.kernel.org>; Sat, 16 Sep 2023 14:36:42 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF25114
	for <netdev@vger.kernel.org>; Sat, 16 Sep 2023 07:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=CxqR93FkeZAYPuRDtS6WA/gkFwd0Z6ehAwkQ1R01rC8=; b=rqM+ClOljMj6xpuPdj+G6mczKp
	Qv2mKFgGk/cPw3scAnDkSKX4o9QWMW3/mrd0pwxIDOe6VGCOC9Xsbk0Vy42lFeWmS1boIfkCohjB6
	EL1+3CIK7jrOGefKQJ//03yh/sFPDYvdm3pkBoxGL6FSQuFyOpkAeGD1eEewp4XHvvcU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qhWPV-006dpC-PH; Sat, 16 Sep 2023 16:36:37 +0200
Date: Sat, 16 Sep 2023 16:36:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Coco Li <lixiaoyan@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	Mubashir Adnan Qureshi <mubashirq@google.com>,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	Chao Wu <wwchao@google.com>, Wei Wang <weiwan@google.com>
Subject: Re: [PATCH v1 net-next 1/5] Documentations: Analyze heavily used
 Networking related structs
Message-ID: <69c8b5ce-7b08-42fe-a4f3-724b9b676d19@lunn.ch>
References: <20230916010625.2771731-1-lixiaoyan@google.com>
 <20230916010625.2771731-2-lixiaoyan@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230916010625.2771731-2-lixiaoyan@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Sep 16, 2023 at 01:06:21AM +0000, Coco Li wrote:
> Analyzed a few structs in the networking stack by looking at variables
> within them that are used in the TCP/IP fast path.
> 
> Fast path is defined as TCP path where data is transferred from sender to
> receiver unidirectionaly. It doesn't include phases other than
> TCP_ESTABLISHED, nor does it look at error paths.
> 
> We hope to re-organizing variables that span many cachelines whose fast
> path variables are also spread out, and this document can help future
> developers keep networking fast path cachelines small.
> 
> Optimized_cacheline field is computed as
> (Fastpath_Bytes/L3_cacheline_size_x86), and not the actual organized
> results (see patches to come for these).

What value do you use for L3_cacheline_size_x86? What is
L3_cacheline_size_arm64, L3_cacheline_size_s390, etc.

Do you have any profile data which compares L3 cache misses vs L2, vs
L1. I guess there should be some gains by changing the order of
structure members, such that those which are used at a similar time
are in the same L1 and L2 cache lines, and so only need to be fetched
once, so reducing cache thrashing.

      Andrew

