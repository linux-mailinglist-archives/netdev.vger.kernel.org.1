Return-Path: <netdev+bounces-92540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFD18B7C70
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 18:01:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A6E11F211A5
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 16:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED53178CFD;
	Tue, 30 Apr 2024 16:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WQXNpkp3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE486176FCE
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 16:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714492872; cv=none; b=tnKQVKvktn6keFqyuH5pzVlxGRZo3P7SB3ZXkGuA0ZDldry1Du6dtcQni95kkAk6YCtacXUnqGxNg/UdrdlgRMVH7KiB1tpbaUKlQa5RfkujmH0rp33RM6mxyRmEdr46yE8+rlaZbTcfL2A5jARx4M6V1FyY1+txnwbhL//htnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714492872; c=relaxed/simple;
	bh=uaQtm99TTwvcVB6dE70G+TricRvh3YWN7Mj9VbhFVoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X7o/zEO9OpGPeQpiSefRJSz6mO2bFLUIj1FBKxtSCeN19iyW7E+p4KDU/uMwnnVApGy1GFc2pjy2q+t9OA64WLkVBF3+a0LzYfa5BXoDN0RqiaIw5bi90yamAmHkv/zjX7JKyPLnYp8DObe3AUVYvbMlWlCpxlGo9bFTL5aUQ6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WQXNpkp3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714492869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uaQtm99TTwvcVB6dE70G+TricRvh3YWN7Mj9VbhFVoM=;
	b=WQXNpkp3blUNsTNWWi8KYROrJyiaV6f11LV8XX4NxepTVf9FJDcU7Vv5VNn6X6h9IXnNc+
	tof+DaCOdShOR1O/19YWW7NRjM/8fDK5Ys0zZBTm40RcpiScTSKhEIFN978l/cat8PPEkP
	WeHRgLbi7jIEz3rHkayNEUt3fM6WqzM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-yGeb0ux_NhCEedhVE30P2A-1; Tue, 30 Apr 2024 12:01:04 -0400
X-MC-Unique: yGeb0ux_NhCEedhVE30P2A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 25EC480E95D;
	Tue, 30 Apr 2024 16:01:03 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.193.71])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 119B620128EF;
	Tue, 30 Apr 2024 16:00:58 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: kuba@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	inventor500@vivaldi.net,
	jarkko.palviainen@gmail.com,
	jtornosm@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	stable@vger.kernel.org,
	vadim.fedorenko@linux.dev
Subject: Re: [PATCH v2] net: usb: ax88179_178a: avoid writing the mac address before first reading
Date: Tue, 30 Apr 2024 18:00:56 +0200
Message-ID: <20240430160057.557295-1-jtornosm@redhat.com>
In-Reply-To: <20240430082717.65f26140@kernel.org>
References: <20240430082717.65f26140@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

> v6.8.8 has 56f78615b already. We need another patch, Jose?

Hello Jakub,

I will try to analyze it during the next week (I will be out until then).

In the meantime, in order to get more information about the possible
regression:

Isaac,
Which version was it working in?
Do you know if it was working before d2689b6a86b9 ("net: usb: ax88179_178a:
avoid two consecutive device resets")?


Best regards
José Ignacio


