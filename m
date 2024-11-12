Return-Path: <netdev+bounces-144199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 063939C5FF6
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 19:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C02B52833BB
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 18:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA9221765D;
	Tue, 12 Nov 2024 18:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CBI1BsNn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14ADD213154
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 18:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731435035; cv=none; b=D/zfgaasZ7Eh5Dyz6JHZnxnBULlg0ytko9m4o9b7B2TtB+aDjwG7cD+oPz8Q0UffbKV2jxyFL6E9cKpH8QawEnhtFzsBECPkoksTBBoL9AcYh9Pw+4YZH/IYXXCNnOoZ76MIi9tgsseEKzPh2WXXmQpzMkTlDmpJqWFH/jS8PTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731435035; c=relaxed/simple;
	bh=U3/I+P/PE+eG7brE4N+kfK95FsISeERGixMLe9GatDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+Yo7UaHcEB0SwNJVE6Acc/HLuYbGBx4MhYaNO7n1vAeCpjNDs0bWpEAQUcceZRNibb//NC5rPkfaIn6HMPOWKSBfEuPLKM0naIWFXjwcPEGY4NoQf743EhO226SVCUR1o16hrf3L1ma0BQlTclZUfk9mAQ1uiXP8YH1WO5pze0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CBI1BsNn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731435033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NeywyyUZkRoekulWeZDAITBA2HHSqAwL/dbKA87lTw4=;
	b=CBI1BsNn7LBMjmT1zT6m8Y/9xNvE3SepuWDwGNeU9QQk7pqFahnbji5ZTz7Z7mgiiuJV0q
	83l62T12E/f6PSrEoZmoi5TM/0Wy7QnD6TKTfs+witaTNL67uLJOCdRm4YdStsVzQ6Q5t9
	k5opfPTK5a5R3XvBtjOqXB0h44jU1Vo=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-SCxaCAXZM5CpOAVDZQ1lKA-1; Tue, 12 Nov 2024 13:10:30 -0500
X-MC-Unique: SCxaCAXZM5CpOAVDZQ1lKA-1
X-Mimecast-MFC-AGG-ID: SCxaCAXZM5CpOAVDZQ1lKA
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-460a85907b7so91745771cf.0
        for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 10:10:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731435030; x=1732039830;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NeywyyUZkRoekulWeZDAITBA2HHSqAwL/dbKA87lTw4=;
        b=niAb63Fc+Mg94pfKdBCa80nR03UL7WmXuPA2STncdbHP+F5cHIhr8ivjOAvBqMrME1
         RP13OXfpfC0PG1zNBlmHo7pJmmZZU2jgO2CgUK5Hvcl18+Mz0dnx9BZe4OzlG0MVqqP1
         X5Tpupn8WfKXTaP4xrpHPqpV1kb2EyRo7YCJGH7qFzhtl6eXdbU2bm30sCegTt183U8M
         RD3y+tl63o1rTyczhjaotmgRn8gHOhpeknQf+6gQBFkoTz8c6KjY2bMnbC50SG5WF/xt
         aDec1pXvEq0tzfCikUz9y9WWQ+Zf150BJeAUWTG0xR8hFMUFFTylQNoH/0Rau2Z/WorR
         aW3A==
X-Forwarded-Encrypted: i=1; AJvYcCX4Ub9HNx33oqo3isKNPQah7YM8/fhiiWOz9NFfFaZ5gLUN9CxOHje31TJiV0bBTlcTDQ0z/dk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm/jQsFkhQ46BvZt6P4PztnM5rgjirAtKjahnzUokZSJ3Rff3J
	vmhGawjyJj5yyRymYk3xWdpyc+aMhBknzKUyb1gWQ+aE8Fp2/eqJq7DGCMrQuq3jrBDFrUeJSjn
	2TS8lhVif88VbF57uJbkh3rAOf64d1oLnxqj7pz/2DxpegAOVzZ5rQg==
X-Received: by 2002:a05:622a:1e0d:b0:461:1895:d9f with SMTP id d75a77b69052e-4630933b0e5mr289369561cf.15.1731435030242;
        Tue, 12 Nov 2024 10:10:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG2Qp7c2NiUDCWdk07hfTKmombDRkdlfJtECCErL4H/pgBQu/FzPw04LHhOd38aCVokx1KvdA==
X-Received: by 2002:a05:622a:1e0d:b0:461:1895:d9f with SMTP id d75a77b69052e-4630933b0e5mr289369061cf.15.1731435029722;
        Tue, 12 Nov 2024 10:10:29 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-129.retail.telecomitalia.it. [79.46.200.129])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ff41d949sm77813861cf.25.2024.11.12.10.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 10:10:29 -0800 (PST)
Date: Tue, 12 Nov 2024 19:10:21 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Konstantin Shkolnyy <kshk@linux.ibm.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mjrosato@linux.ibm.com
Subject: Re: [PATCH v5 3/3] vsock/test: verify socket options after setting
 them
Message-ID: <jjplqknxiasru7oukfrz66eryfhtviukwchxkh4yq6woj3m7qw@augnv6adwrgc>
References: <20241108011726.213948-1-kshk@linux.ibm.com>
 <20241108011726.213948-4-kshk@linux.ibm.com>
 <bltkmoxf6xsknimf6ccrxuritfc3ipxhbqkibq7jzddg6yewcv@ijcc44qmqsm3>
 <20ebaf65-503f-40a3-b8f3-ac1e649e2fac@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20ebaf65-503f-40a3-b8f3-ac1e649e2fac@linux.ibm.com>

On Tue, Nov 12, 2024 at 09:18:48AM -0600, Konstantin Shkolnyy wrote:
>On 11/12/2024 02:58, Stefano Garzarella wrote:
>>On Thu, Nov 07, 2024 at 07:17:26PM -0600, Konstantin Shkolnyy wrote:
>>>Replace setsockopt() calls with calls to functions that follow
>>>setsockopt() with getsockopt() and check that the returned value and its
>>>size are the same as have been set.
>>>
>>>Signed-off-by: Konstantin Shkolnyy <kshk@linux.ibm.com>
>>>---
>>>tools/testing/vsock/Makefile              |   8 +-
>>>tools/testing/vsock/control.c             |   8 +-
>>>tools/testing/vsock/msg_zerocopy_common.c |   8 +-
>>>tools/testing/vsock/util_socket.c         | 149 ++++++++++++++++++++++
>>>tools/testing/vsock/util_socket.h         |  19 +++
>>>tools/testing/vsock/vsock_perf.c          |  24 ++--
>>>tools/testing/vsock/vsock_test.c          |  40 +++---
>>>7 files changed, 208 insertions(+), 48 deletions(-)
>>>create mode 100644 tools/testing/vsock/util_socket.c
>>>create mode 100644 tools/testing/vsock/util_socket.h
>>>
>>>diff --git a/tools/testing/vsock/Makefile b/tools/testing/vsock/Makefile
>>>index 6e0b4e95e230..1ec0b3a67aa4 100644
>>>--- a/tools/testing/vsock/Makefile
>>>+++ b/tools/testing/vsock/Makefile
>>>@@ -1,12 +1,12 @@
>>># SPDX-License-Identifier: GPL-2.0-only
>>>all: test vsock_perf
>>>test: vsock_test vsock_diag_test vsock_uring_test
>>>-vsock_test: vsock_test.o vsock_test_zerocopy.o timeout.o 
>>>control.o util.o msg_zerocopy_common.o
>>>-vsock_diag_test: vsock_diag_test.o timeout.o control.o util.o
>>>-vsock_perf: vsock_perf.o msg_zerocopy_common.o
>>>+vsock_test: vsock_test.o vsock_test_zerocopy.o timeout.o 
>>>control.o util.o msg_zerocopy_common.o util_socket.o
>>>+vsock_diag_test: vsock_diag_test.o timeout.o control.o util.o 
>>>util_socket.o
>>>+vsock_perf: vsock_perf.o msg_zerocopy_common.o util_socket.o
>>
>>I would add the new functions to check setsockopt in util.c
>>
>>vsock_perf is more of a tool to measure performance than a test, so
>>we can avoid calling these checks there, tests should cover all
>>cases regardless of vsock_perf.
>
>The problem is that vsock_perf calls enable_so_zerocopy() which has to
>call the new setsockopt_int_check() because it's also called by 
>vsock_test. Do you prefer to give vsock_perf its own version of
>enable_so_zerocopy() which doesn't call setsockopt_int_check()?
>

Yeah, maybe we can move the old enable_so_zerocopy() in vsock_perf.c
and implement another enable_so_zerocopy() in util.c for the tests.

Thanks,
Stefano


