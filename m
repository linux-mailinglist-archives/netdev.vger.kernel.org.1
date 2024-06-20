Return-Path: <netdev+bounces-105302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B0F91063C
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 15:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 606DE1C21066
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 13:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76ADC1AF6A1;
	Thu, 20 Jun 2024 13:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dslo+qye"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F396E1AED59
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 13:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718890305; cv=none; b=tPJTAayRdYzHl+ryEeB6B2pwn56RC4ndRvGDKeCfoTQlzOEYA2DEbPCzKoxVUfM3nswkYaMXxKYfLQzw6uhjiw3+hF2OrHwyFhCYKiM8nQpbnwDEww+h4SjMGYDyJIw1ytVOwpeWl3TuRGb2CYCO6YlLeFqVI3lp6U06RsOFUV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718890305; c=relaxed/simple;
	bh=ppX6VBx7+1zsn2VbQNl3tkDpaOj+UZLirFEMqA8idfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WHWoeHntIHEvEmdXiqOTYhphxFh4GHWHrGGuE7C29lmooWFtp5/W/QdJ5YSBmVKDgN7U41eyWpGxUFON2LwnhExExThEf/7vfbT8UIs1NKPKPX3iVQ8kQj3XQN79fBNU2Ibp1REzfRUYcQP6rOs4J01W2EE4wCeOm76fhxpQ3A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dslo+qye; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718890303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vE+mxyg8YyUZt5GQS1+ElW8LtSozIu63aF5ZDw92HPo=;
	b=Dslo+qyeoESHuDhnIEkaKWBMENF/FenJ23DT2YIT9O1rMLL8hTOgtFT8Y0fISZQgbkSJKB
	/JkvhPhlgr58VdcuYKRLmxY4fzj1npvTpFYuUbKCXNIF+dfu9C+sY1K9T0kdufEvdRKY+g
	1UPYg6rjHWKTWms8j2cBpCVL/vHzoUU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-61-mEWm_jU-PZ-8LL1KS58Nvw-1; Thu,
 20 Jun 2024 09:31:37 -0400
X-MC-Unique: mEWm_jU-PZ-8LL1KS58Nvw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 229C01955D68;
	Thu, 20 Jun 2024 13:31:31 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.104])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3988E1956087;
	Thu, 20 Jun 2024 13:31:25 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: pabeni@redhat.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	jtornosm@redhat.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] net: usb: ax88179_178a: improve link status logs
Date: Thu, 20 Jun 2024 15:31:20 +0200
Message-ID: <20240620133124.102154-1-jtornosm@redhat.com>
In-Reply-To: <c76d1786c308aeb6e4c836334084e3049c0f108a.camel@redhat.com>
References: <c76d1786c308aeb6e4c836334084e3049c0f108a.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Hello Paolo,

> Please always include the target tree in the subj prefix - in this case
> it should have been 'net'.
Ok, I forgot it.

> Here                                ^^^^ link value is always 0, so you
> should using a constant string.
Ok, better in that way.

I will send a next version of the patch.

Thanks

Best regards
José Ignacio


