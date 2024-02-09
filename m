Return-Path: <netdev+bounces-70555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCB484F86E
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 16:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D67F1F2543E
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 15:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B8571B55;
	Fri,  9 Feb 2024 15:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ai4FyEO5"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93C56D1D2
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 15:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707492365; cv=none; b=rSXbQ7jXisA4B9RVtYWDNQBHZOS1R8A5jt/F/6CdEN0nZO1ZA6O3eqdpIbNbX+Yq9ey50oWTzaBcXHSOHHIIkG6lU+OgjfRyIKYs6fma6SMr/B7+yGDNPPEKxJQpV4HmW4AEmj4sGMRA3pxsPbJ8IHOotH8vgA11ba6DrL7BfZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707492365; c=relaxed/simple;
	bh=TxsPAvcnFjQCH/kPO7d2XSBHXtJbjDcUKS6j33qkLCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QnLYR508LoEheQxlvW2b5556tsV//somZLlIXT+vDyGdd0Yvatt1pScRpP7mBJSpiVH4EVP18UBxvyOqVCGvlos9SEdPB8AEKq23TBSPnt/fK7HG1l1ZJj5dtBTjke/aTS2jrnglJEpNAl2mXAPxU1HC5ARHB4zVCjzwUBwySNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ai4FyEO5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707492361;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=viUghLHB1KgRZKmu1YGF4bfma8AhYk9/fMYGwIQOltw=;
	b=ai4FyEO5ek5c78XyaRLnm4UnNC/50U/gsmfoxm3ALF/coTd3U0ND0RLyPb5oovJ8n3hEKu
	t73WjgAZTf2HSvO+ztov/rN1HYpz0Ark6mFJoLyvXtH+xE/t++pkhLtJ6KEXqHFBsELXXb
	Mtb2mOhXdiKDF4t8b1GHfxssh/ujEn4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-438-0YuShp0iPWq_vd0yheGETg-1; Fri,
 09 Feb 2024 10:25:58 -0500
X-MC-Unique: 0YuShp0iPWq_vd0yheGETg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 30E463C1E9C6;
	Fri,  9 Feb 2024 15:25:58 +0000 (UTC)
Received: from renaissance-vector.redhat.com (unknown [10.39.194.214])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C98B71103A;
	Fri,  9 Feb 2024 15:25:55 +0000 (UTC)
From: Andrea Claudi <aclaudi@redhat.com>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@gmail.com>
Subject: [PATCH iproute2 v2 0/2] Fix some more typos in docs and comments 
Date: Fri,  9 Feb 2024 16:25:44 +0100
Message-ID: <cover.1707492043.git.aclaudi@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Time for some start-of-the-year cleanup :)

Using codespell, fix most of the typos in iproute2 docs and comments,
except for some false positives. I didn't bother to report a Fixes tag
for all the typos, but I can do that if needed.

v1 --> v2:
- rebased and dropped some unnecessary changes.

Andrea Claudi (2):
  treewide: fix typos in various comments
  docs, man: fix some typos

 include/bpf_api.h       | 2 +-
 include/xt-internal.h   | 2 +-
 man/man8/devlink-rate.8 | 2 +-
 tc/q_netem.c            | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

-- 
2.43.0


