Return-Path: <netdev+bounces-72038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF0285644A
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 14:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 099BE1F228E2
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 13:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37364130AC4;
	Thu, 15 Feb 2024 13:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TIt5T8d5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EC912FF72
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 13:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708003604; cv=none; b=HzvKVbNJmvV2w9CapyLIUa0HhUPaquBnNW43zE/0sovGYvr/hyrvkCQtjBIGxm9JEQ0OHfZ+OGgCSbG4G4GKGhbgYKyk/to6iNN01j4jiypChYy/3qVo0pYwgDBahHRKFnnvRNY1u07mLCelVdgQyezUQ/XAn/+fP/2yNUG5RBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708003604; c=relaxed/simple;
	bh=7R2FSTbqLoIJPgkJpGMiH1wCCoFDMC1EYWvrfRVf3zg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RoDqVq6vQvrsECN4JnPXLRS3JLCQHMcmErUPRVe2kHUloF/q6G55o60ZJHOo8GBNfZn7U/SZFbMwhlODlZELycJRfBLR5oVr4FmrRCn8v+Wc3s/bHmSyWpW3lLx1ckoLM0uCN8Bksgzuai+4P0QgROJd6zGzt3mxQn3TMovMQ8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TIt5T8d5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708003601;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FLw+lhy3W1tMloxBS/bRk4F1uzdmef+pWM5Uhua3Ilc=;
	b=TIt5T8d5Ms+3dyPU4CRI00020v9seB46Cd0S1AWu1zUD1C1IH3bvWw/MNmDTbS9b+EIVLx
	xNzye+994VS8FsbnVHmTmq7TKiwNOt33VkbE5auCQgYL9tPKteyu2lNS7NfmkgnAfwWIWd
	fBA6UUTSmjZOdr4e8HjTKmECF10HZS4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-ZMaaoQMdNqKR--Zn-Wp17w-1; Thu, 15 Feb 2024 08:26:40 -0500
X-MC-Unique: ZMaaoQMdNqKR--Zn-Wp17w-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a2b068401b4so113935166b.1
        for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 05:26:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708003599; x=1708608399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FLw+lhy3W1tMloxBS/bRk4F1uzdmef+pWM5Uhua3Ilc=;
        b=QlKp5QvTeZKWs00RYdY1ewS/pZwu0bSwrQQurFv0K8YcD5FrdWPB34Vu/yPGc2pCqK
         KYndpag8IjyXNf41gWqMVGfToMu60YA9k99uoxSnNeC9x5CpqSIujEoVystZPhTIjgMp
         cnwA8zr7b51mXo4Hw16rb5TZ2Jhr1G6+8ckgB8E5YCYHnePz6zLSU4w9AzZEsxPgZpBe
         WCybnt4mYrI1FmeQuidNCo0RJtnwXNUCgSU++nuD0Vy8Vp++jd+QyWBXM6ZBitvo+bz7
         7DCTfoayMmHuIkshUOWkr+N9Eu7HAvxfC5koLHOoUuV9h0zMquEBq2Ij3mbUeY8ZhIfr
         kekg==
X-Forwarded-Encrypted: i=1; AJvYcCWh/cx7CR/7+VBIasppAb9PHDnhdwW3bflmZrjnSdGn3CIh1L49JzOEqLoTa9vFM0HSAZ++9GOwtJuNFZ/mmu6m3LeiaTI+
X-Gm-Message-State: AOJu0Yy82YUx6c9mai6fz+fymNItEJNivgJ0Ilu8rH7s7wPjp7bXFdjX
	XQrxXPj7rYE4kJdgskQe90fU/p6CmjlMeB3Fkk8a4Y9dRJfSMislWWMX/bojVoeGWIiTmZOcxtc
	84SeIsxof1E7rx5dhDCVvLAeECcWVP7Uh1aMGw4wYQvuoU/U0OwI4qA==
X-Received: by 2002:a17:906:ae4f:b0:a3c:ec8a:cf8e with SMTP id lf15-20020a170906ae4f00b00a3cec8acf8emr4141106ejb.24.1708003599060;
        Thu, 15 Feb 2024 05:26:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGh3w1124SAANXe3mn4J6Do4jPi80EvOoOD3rif4yZAfDqZu6lAM8VvVhIUSiVnk2Zi1Ps4LA==
X-Received: by 2002:a17:906:ae4f:b0:a3c:ec8a:cf8e with SMTP id lf15-20020a170906ae4f00b00a3cec8acf8emr4141085ejb.24.1708003598746;
        Thu, 15 Feb 2024 05:26:38 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id r29-20020a50aadd000000b005603dea632esm558334edc.88.2024.02.15.05.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 05:26:37 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 98AF810F59B7; Thu, 15 Feb 2024 14:26:37 +0100 (CET)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net-next 0/3] Change BPF_TEST_RUN use the system page pool for live XDP frames
Date: Thu, 15 Feb 2024 14:26:29 +0100
Message-ID: <20240215132634.474055-1-toke@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Now that we have a system-wide page pool, we can use that for the live
frame mode of BPF_TEST_RUN (used by the XDP traffic generator), and
avoid the cost of creating a separate page pool instance for each
syscall invocation. See the individual patches for more details.

Toke Høiland-Jørgensen (3):
  net: Register system page pool as an XDP memory model
  bpf: test_run: Use system page pool for XDP live frame mode
  bpf: test_run: Fix cacheline alignment of live XDP frame data
    structures

 include/linux/netdevice.h |   1 +
 net/bpf/test_run.c        | 138 +++++++++++++++++++-------------------
 net/core/dev.c            |  13 +++-
 3 files changed, 81 insertions(+), 71 deletions(-)

-- 
2.43.0


