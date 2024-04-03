Return-Path: <netdev+bounces-84493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0898970FD
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 15:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF0BB1C24A54
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 13:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EC0149C74;
	Wed,  3 Apr 2024 13:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GnpodGso"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFAB1487F3
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 13:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712150815; cv=none; b=d0/aJq6zfztgmMeq1iJWt33PDThz9mGmXHKyPdyKVsKlwx7uFypVpP4277WLa3zR7LsEFR04d5vXwTfBWvbOBDSD/0NKBZXCQYblfzej+8lIZVw093JZU1w+V5L2h/JB9VZwC6wDUFcHy7TD+7hyY7XlZzr3mbEsKADA0/OnG+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712150815; c=relaxed/simple;
	bh=52UmcMJZtoCW9vlBYc/fadTAz/Lbo5LlOCiiSVdCjOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E+B5bYR3OUfZbI+DcZSj4g+kWqUGClBPLHChc7OMyC6jKhUPXkFJ5ZD8jHEb/dmRqeOewwNgbFu5a69snxKSPVYqP6VZbwfKUI95DVg1ySqsXMEj9HSajcQb8Ug47ShDr9BJsPogbOy1AniImPSsw1kF/YG91aNp8KZpvn44AfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GnpodGso; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712150812;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=52UmcMJZtoCW9vlBYc/fadTAz/Lbo5LlOCiiSVdCjOQ=;
	b=GnpodGso3ChUO++aH1WG+xQIsXjzadVdEcOqAjzw/3gXO449O5Frcq7njhwvJLXNIZHqXf
	BNf1bP37wnfFP6qsq/LUWtr5t7w/W/4HgwGxg16F5RXb7N0peuQ5Buwbs+Zmwuwitp+Zp7
	6ykAvUbuzJ9MFPv7CbcPRwcklqwiq9E=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-59vSHkt8OByb0-iMdjEcZA-1; Wed,
 03 Apr 2024 09:26:47 -0400
X-MC-Unique: 59vSHkt8OByb0-iMdjEcZA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A05083816B4C;
	Wed,  3 Apr 2024 13:26:46 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.193.197])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5C1A1492BD1;
	Wed,  3 Apr 2024 13:26:44 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: kuba@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	jtornosm@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next v3] net: usb: ax88179_178a: non necessary second random mac address
Date: Wed,  3 Apr 2024 15:26:35 +0200
Message-ID: <20240403132639.344958-1-jtornosm@redhat.com>
In-Reply-To: <20240402183237.2eb8398a@kernel.org>
References: <20240402183237.2eb8398a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Understood, I will repost when the other one is merged and with the new
context diff.

Thanks

Best regards
José Ignacio


