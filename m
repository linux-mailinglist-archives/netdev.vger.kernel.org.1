Return-Path: <netdev+bounces-69574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 026E884BB6E
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 17:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B12FD283BB4
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 16:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD344A11;
	Tue,  6 Feb 2024 16:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SpQqeEGp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17891C133
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 16:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707238390; cv=none; b=uxPGem/H4mX5uMTy0pLiKgV9QOalh0jN9pboB9h0TJ/Wz0Ew+qBs+ZEuCdIeZqfTLWgQL8hqanSeNXMrztzGDsvMmQvf7qUrkLDNSxx4fBeQevpHFRm8k9C35EarJPjP9NKL6GUE0MNsTfiYuZQ68y/3gjsRVkdjTuztSYTdANg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707238390; c=relaxed/simple;
	bh=yrbq9ZzTJzHd7ISoxxPDyWVUm6InvcDyUEiT1EIr09M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lVbYCcH2XlhGwiLNLdNtyIjB5BefBiS81V81O5BLEPsikv7DIMtwjUUc0FstGwNiaPINzA5QhRqp0+7gKjZZ5NM/3H6eiTxPkwy/ZAsKnrRoSCn4Erw+x6GJ9sYKIZIfGvrCcxLl8NJOYI4Rc8eoq+LTPxBNI1XcgS3bMyLjUrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SpQqeEGp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707238387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yrbq9ZzTJzHd7ISoxxPDyWVUm6InvcDyUEiT1EIr09M=;
	b=SpQqeEGpw2/0e0F0h+ubS4egiZn4tWA7nHAs8BFwB65t6z34FrLrY7IxnvgVsh84c0psFl
	5pUsNLlKkzdeaIgPXnpzeJ5NTQwVBdfD1TapmKt+dpYR4qJNJIB+WDwFJBeSnaem/L0pCv
	UsoM46JpcfKdfoH8gZwmZNE6PHdKc5Y=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-2pAa0aPwMH-Mvgk_hypa6Q-1; Tue, 06 Feb 2024 11:53:06 -0500
X-MC-Unique: 2pAa0aPwMH-Mvgk_hypa6Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D7E2785A588;
	Tue,  6 Feb 2024 16:53:05 +0000 (UTC)
Received: from dev.redhat.com (unknown [10.22.8.235])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9AE541C060B1;
	Tue,  6 Feb 2024 16:53:05 +0000 (UTC)
From: Stephen Gallagher <sgallagh@redhat.com>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	dsahern@kernel.org
Subject: [PATCH iproute] Fix type incompatibility in ifstat.c
Date: Tue,  6 Feb 2024 11:52:33 -0500
Message-ID: <20240206165246.875567-1-sgallagh@redhat.com>
In-Reply-To: <20240206142213.777317-1-sgallagh@redhat.com>
References: <20240206142213.777317-1-sgallagh@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Fixes: 5a52102b7c8f ("ifstat: Add extended statistics to ifstat")


