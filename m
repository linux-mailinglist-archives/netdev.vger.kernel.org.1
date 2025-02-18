Return-Path: <netdev+bounces-167369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E12A39FBF
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 15:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 749ED3B4DB4
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 14:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA2F26B975;
	Tue, 18 Feb 2025 14:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XsejA+BD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6D126A1C7
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 14:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739888826; cv=none; b=u87yvZ/5ZtmtaGeROsKcQr/fTmg0n4CrCHrxTNaD4dH3/8dYeixa1RjYnKwGcKhipjaHj2k+Cc6BoGXLM9o+9eIvheQWYYXk78G+naIV8MWNxCiSgjZu3JJZ84QJ2naZZzHheosMX7RMybV7A/kYa/eJJdcnnOK9RvZr1vs+ORo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739888826; c=relaxed/simple;
	bh=Y9Nr7LmQzEWliBKR3ojyO8kDTwSKPkWSlfC0YNo1IU8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=P6wG89pbT1Eiv+RccVV5taNcWs8ZqjiM+hionl15E2tgQAgqUxFKYamx+N4xmUm8d+ARoyLiYBg0qTHZih0e+xHytabYmkNzztvDHDJMHZ2NBuI49Si/1HbZkK6JTbaNanMG8wXP/gFwOHuKTouyqp8QIdqO+BioQuLid43aqBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XsejA+BD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739888823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KeLNaaHggJAU2Vn6CErljvoV/5mST2FdcAVaIa/lSwI=;
	b=XsejA+BDXMexuBB77rYIjGCGTT/uNWzvnjvxQ+zE5dRMTPVD5G5aFyMfH76nm+0Kq/IfxZ
	H8ugFCGtLqwXG4V9WofZZC7wt5opfDsxhtENXngwxXC/Jf25PZAxlbQC0CRII4JUBuelqh
	74pEcW0Jck5R9N/eJwo4gn34XHZBWpc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558-90md7J2GMh2XE1TgQ1pGlw-1; Tue,
 18 Feb 2025 09:27:00 -0500
X-MC-Unique: 90md7J2GMh2XE1TgQ1pGlw-1
X-Mimecast-MFC-AGG-ID: 90md7J2GMh2XE1TgQ1pGlw_1739888818
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C32B61800986;
	Tue, 18 Feb 2025 14:26:58 +0000 (UTC)
Received: from pablmart-thinkpadt14gen4.rmtes.csb (unknown [10.44.32.29])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3B5431800362;
	Tue, 18 Feb 2025 14:26:54 +0000 (UTC)
Date: Tue, 18 Feb 2025 15:26:50 +0100 (CET)
From: Pablo Martin Medrano <pablmart@redhat.com>
To: Petr Machata <petrm@nvidia.com>
cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
    Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH net] selftests/net: big_tcp: longer netperf session on
 slow machines
In-Reply-To: <87tt8sfmlk.fsf@nvidia.com>
Message-ID: <05eb7852-3e66-3814-9fab-c173a8c4649d@redhat.com>
References: <b800a71479a24a4142542051636e980c3b547434.1739794830.git.pablmart@redhat.com> <87tt8sfmlk.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93



On Mon, 17 Feb 2025, Petr Machata wrote:

> This bails out on first failure though, whereas previously it would run
> all the tests. Is that intentional?

Previously it did bail also on first error, as it did do_test ... && 
do_test && and do_test returned != 0 anytime [PASS] was not printed

But I understand from the semantics of lib.sh that the custom is that all 
tests are passed and then fail/xfail returned if any of them 
failed/xfailed

Thank you Petr! I am resending a patch with your proposed changes


