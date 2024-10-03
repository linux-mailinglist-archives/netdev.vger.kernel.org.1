Return-Path: <netdev+bounces-131800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0854C98F9B6
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 00:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E8A91F23680
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 22:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F336F1C1746;
	Thu,  3 Oct 2024 22:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OM/BCGIM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A751C1AC7
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 22:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727993775; cv=none; b=GpIbVExUA2FDw92KmiiRbyW1UDCzEdALt7V/36tvu+9pCysGbZ/7EHaiQhKUua0eGFZ6mkiF7ydANVDdhBtk1Cb4kx6ap4o3ZNUTOKGD2QrgLClNdSUQxAmOsuc34Yrmxms5msxbrkdaN2l07lZYByRygMWIEgxmzB0l2DHt8hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727993775; c=relaxed/simple;
	bh=7mPMRNsYZ10J1wFw/MDsB8h6BOgagdJaKx4/n0vW4ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dY3vb/BjviUN27510/KUZLG/tXeIjfmwMwsjI3VZVeHgrvqAtXrnzy4yCymZcHum0FlFakSM9KNvOrR9jcVpEbpJ1msTlo2CukULBVNvp8ueO6614xHQbs1Y+rWJ6AQHbGdfj8IMrTUJIOM5lWEGPAXHeUPCTC050DAeKmJ/ZA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OM/BCGIM; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-71dba8b05cbso1491953b3a.3
        for <netdev@vger.kernel.org>; Thu, 03 Oct 2024 15:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727993774; x=1728598574; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cIflqqdmN+vhu+d4/Bewj+I4vNTaM2Yo4aeA9fXx7pQ=;
        b=OM/BCGIMWu/GD7iwLvti44OYbIFwhFV+5E+TlGbBd9rLSFlwnMT6gnJ0Orzzoo2jk6
         6Cuj7wvrXdwO2TMGuzqx2lpZVbJnvN3bdbrCKpjBjcTgZD7+72s/UuZ96D8P7JZNPbbA
         nui3sjn+zoFOJoZiXQKN/n3pbb2ImdAjUhwEcRi0vKjFlqLBLZdMe1rSxTSizn5i+jZi
         S0OFlTus7MWGGhajj+xnkHnlbaTTEufo0OEmWdpJ3rzZwyUtkpmbkEODbOk3Ub5OO+Rp
         KP6NM/daCEUgbo6rPUBKVdg2j5E0uuBJjm5FdgebAnRQ++3MDWqURzNifqBpQUYl+BZC
         gztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727993774; x=1728598574;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cIflqqdmN+vhu+d4/Bewj+I4vNTaM2Yo4aeA9fXx7pQ=;
        b=J6WKVIoheM8TSJiUNCTGg39j5c0hSCuOQKzWZPayWF042HRuBHpkzQ4BJovcznL6Pp
         9khlVqjCBRm65Rl6VZDjoROhQ59rD7RhvQ1sUdg6GevxhhLuWaMhB4c8WOoByD4IMGUO
         W9Avf8URIVUV2tryhguy5K/jSifhmXRgwxnC4jv6Q+HZsTL6/YocMAA3bJrCyCE+05Af
         0P59lUnSX18SPxLfvenUqm8M9o/EU+4Tq2NWeqqOToRKX0B8CQcy/amcWBke9Fy/aC+0
         5fyEDWtQOBRUPPzTrA9Uyc8RtQw/ENDZBvJr+xqb5D/gAshCP6S0tYmk7uAvrbFhZWG0
         PRBA==
X-Forwarded-Encrypted: i=1; AJvYcCVd7iBuZ/KkbwW21lE+Rb+TJb4KuTZDUWa2GXwbS1bjzDP1HMTxwZYC6ei5QClWNqmuQ6QkDeM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiUM8Xluw8TtQAuCT8VJqVpzMov2XuYH8J7PkD7PoGkW4lXc/7
	zEnxsnZl4lLh5jBUYO0AzUZ9+BTu+3Fk0jxlDIXSzI3R064sEVk=
X-Google-Smtp-Source: AGHT+IE+NJwRLyY6M/hovdYymw4ajsY++XRgf+9GSKw3E9WCQ9jbZTvkt27mwzTwVjn6s8JjBmm6CA==
X-Received: by 2002:a05:6a20:e687:b0:1d3:ba1:18f4 with SMTP id adf61e73a8af0-1d6dfa42880mr1028106637.26.1727993773616;
        Thu, 03 Oct 2024 15:16:13 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71dd9d8e473sm1875424b3a.81.2024.10.03.15.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 15:16:13 -0700 (PDT)
Date: Thu, 3 Oct 2024 15:16:12 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next v2 09/12] selftests: ncdevmem: Remove hard-coded
 queue numbers
Message-ID: <Zv8XrPEG6g_W_k7O@mini-arch>
References: <20240930171753.2572922-1-sdf@fomichev.me>
 <20240930171753.2572922-10-sdf@fomichev.me>
 <CAHS8izNK+DiQUUkkvnPQvBRJiQ32WRO0Crg=nvOW9vn_4kCE+Q@mail.gmail.com>
 <Zv7OMcx2yff-QSO9@mini-arch>
 <CAHS8izOJaGk5g9m-DgBJE13XDcgdXNAbbBq9MmcjH229cSVoxg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izOJaGk5g9m-DgBJE13XDcgdXNAbbBq9MmcjH229cSVoxg@mail.gmail.com>

On 10/03, Mina Almasry wrote:
> On Thu, Oct 3, 2024 at 10:02 AM Stanislav Fomichev <stfomichev@gmail.com> wrote:
> >
> > On 10/03, Mina Almasry wrote:
> > > On Mon, Sep 30, 2024 at 10:18 AM Stanislav Fomichev <sdf@fomichev.me> wrote:
> > > >
> > > > Use single last queue of the device and probe it dynamically.
> > > >
> > >
> > > Sorry I know there was a pending discussion in the last iteration that
> > > I didn't respond to. Been a rough week with me out sick a bit.
> > >
> > > For this, the issue I see is that by default only 1 queue binding will
> > > be tested, but I feel like test coverage for the multiple queues case
> > > by default is very nice because I actually ran into some issues making
> > > multi-queue binding work.
> > >
> > > Can we change this so that, by default, it binds to the last rxq_num/2
> > > queues of the device?
> >
> > I'm probably missing something, but why do you think exercising this from
> > the probe/selftest mode is not enough? It might be confusing for the readers
> > to understand why we bind to half of the queues and flow steer into them
> > when in reality there is only single tcp flow.
> >
> > IOW, can we keep these two modes:
> > 1. server / client - use single queue
> > 2. selftest / probe - use more than 1 queue by default (and I'll remove the
> >    checks that enforce the number of queues for this mode to let the
> >    users override)
> 
> Ah, I see. Thanks for the explanation.
> 
> My paranoia here is that we don't notice multi-queue binding
> regressions because the tests are often run in data path mode and we
> don't use or notice failures in the probe mode.
> 
> I will concede my paranoia is just that and this is not very likely to
> happen, but also if it is confusing to bind multi-queues and then just
> use one, then we could remedy that with a comment and keep the
> accidental test coverage. It also makes the test simpler to always
> bind the same # of queues rather than special case data and control
> path tests.
> 
> But your 2 mode approach sounds fine as well. But to implement that
> you need more than to remove the checks that enforce the number of
> queues, right? In probe mode num_queues should be rxq_num/2, and in
> server mode num_queues should be 1, yes?

Yes, I'll follow your suggestion with `start_queues = num_queues / 2`
for the selftest part.

Tentatively (default to 1/2 queues, if want to override - provide both
-t an -q):

index 90aacfb3433f..3a456c058241 100644
--- a/tools/testing/selftests/net/ncdevmem.c
+++ b/tools/testing/selftests/net/ncdevmem.c
@@ -64,7 +64,7 @@ static char *client_ip;
 static char *port;
 static size_t do_validation;
 static int start_queue = -1;
-static int num_queues = 1;
+static int num_queues = -1;
 static char *ifname;
 static unsigned int ifindex;
 static unsigned int dmabuf_id;
@@ -706,19 +706,31 @@ int main(int argc, char *argv[])
                }
        }

-       if (!server_ip)
-               error(1, 0, "Missing -s argument\n");
-
-       if (!port)
-               error(1, 0, "Missing -p argument\n");
-
        if (!ifname)
                error(1, 0, "Missing -f argument\n");

        ifindex = if_nametoindex(ifname);

-       if (start_queue < 0) {
-               start_queue = rxq_num(ifindex) - 1;
+       if (!server_ip && !client_ip) {
+               if (start_queue < 0 && num_queues < 0) {
+                       num_queues = rxq_num(ifindex);
+                       if (num_queues < 0)
+                               error(1, 0, "couldn't detect number of queues\n");
+                       /* make sure can bind to multiple queues */
+                       start_queues = num_queues / 2;
+                       num_queues /= 2;
+               }
+
+               if (start_queue < 0 || num_queues < 0)
+                       error(1, 0, "Both -t and -q are requred\n");
+
+               run_devmem_tests();
+               return 0;
+       }
+
+       if (start_queue < 0 && num_queues < 0) {
+               num_queues = 1;
+               start_queue = rxq_num(ifindex) - num_queues;

