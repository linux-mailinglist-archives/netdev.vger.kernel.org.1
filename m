Return-Path: <netdev+bounces-83725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B13DD8938CF
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 10:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 657DD1F2163F
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 08:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B4DD51C;
	Mon,  1 Apr 2024 08:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hOeBJ2DT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6182FD515
	for <netdev@vger.kernel.org>; Mon,  1 Apr 2024 08:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711958811; cv=none; b=X8nZQ+Zewu8pErq5CO4fhvXGAW4RQ2P4BidO+Mxchqo8UVifXsRCQhFmFuv25bzJzRqOa5UZ1Oufzpt7lZIW6zYVm676A8gpn/BpdPU8olbMUYEOoMgwcokamspoaOsKzqmt3orRHMGXm/uh8rsUjUYKVtTBsNIGhg6FEpU2yMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711958811; c=relaxed/simple;
	bh=8UebOuTJBhPPkYw51jyujYO9dmpHZI0JM4BT9ioA+NE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T6fk/WRpHSLsCk95yO8jwG99UiK18w2RBIlTArVgB31EhecVVdDchQj3E+LA6bBfOgjxAFKEHtM5ZHUEQhxgVLuf7lp18P3wDJZ2KAswwtTk04HtK+1kRjMsvG/q1J7ogli+Pj6eayU+UZAJEXitOftR4C+Y3XTy+32sb3aJN8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hOeBJ2DT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711958809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8UebOuTJBhPPkYw51jyujYO9dmpHZI0JM4BT9ioA+NE=;
	b=hOeBJ2DTdun+bL8q99F/S0WbgPxjevxZJBqurTNXZxWO47tPiG1NNUQJI37Bzw5b9+CUcy
	LjEXjc22VExHVg0kS6YTb2T6h3Lh5gVQkA2KcmAlB5xRg9K7V0uVFv3WJCjDgjFMcN/fML
	jLCwIAQxb2tNhKtmh9f+VR7byd/K304=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-pUqHvB_DNi2mQ8J8yUxjWg-1; Mon, 01 Apr 2024 04:06:45 -0400
X-MC-Unique: pUqHvB_DNi2mQ8J8yUxjWg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 59F70851784;
	Mon,  1 Apr 2024 08:06:44 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.124])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1B4C03C21;
	Mon,  1 Apr 2024 08:06:41 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: horms@kernel.org
Cc: dave.stevenson@raspberrypi.com,
	davem@davemloft.net,
	edumazet@google.com,
	jtornosm@redhat.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] net: usb: ax88179_178a: non necessary second random mac address
Date: Mon,  1 Apr 2024 10:06:19 +0200
Message-ID: <20240401080620.7092-1-jtornosm@redhat.com>
In-Reply-To: <20240327160052.GP403975@kernel.org>
References: <20240327160052.GP403975@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Hello Simon,

Returning after Easter.

I'm sorry I didn't understand you, I have to learn more about the procedure.
I hope to do it better now.

Thanks for your help

Best regards
José Ignacio


