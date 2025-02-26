Return-Path: <netdev+bounces-169931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AADB3A46824
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 18:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1254165C79
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 17:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5670B224884;
	Wed, 26 Feb 2025 17:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fNh6FIqG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE36C1E1E1A
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 17:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740591154; cv=none; b=sC7SIpek6Psa7Jwd1Gg/Wwz+zWhKjm5Ecm/CnrhmI8+zVp8NkoK6CAwM5CBIdhAgGnJN2zPm8hgaVH3PtgiWfIJKVYp89Gbkj9B/P9edtFGwUWrkWPw+BE4Up7SUXI35stcM5NPLj6M3TJVt8SpVdC2lflnRTB4DpMbSEc56PWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740591154; c=relaxed/simple;
	bh=JGvRpxteJxWEJq3pHWFtcHfXehKkzuG17f3YzkWNZJM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=uacYWk/cL56nak8MlKo3spCoqLb9yktRjezPxGhophB07KXqAOtOM0vvXCl8lqipx8PZ8AVt/ajfb1tQK5kZnkSyol44RKMoKBTAx1oIu83hjfX/gG88zRnMX1Ta9jfzqUZc/Qv8sEDzvrls89/VcAE/8rzj92/+DsTLQbmxnd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fNh6FIqG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740591151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JGvRpxteJxWEJq3pHWFtcHfXehKkzuG17f3YzkWNZJM=;
	b=fNh6FIqGGZ5dx/taNZ0unEoAk9+GjTo/Fzo6e4x8qDQNQ6eXxknFmYcZjPa1G3e86P+cok
	5wrOPVZj5AN8EDtw9khysE7Te3mE9U9VGSHBj6kIUxf7zsA5lrxrhTGpsBxHb/a6Xlccin
	kvNdayp/2E3BcBAiVw3JXNNyLOAQjh8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-248-Mq3gCe4WM2exIZO678rRDQ-1; Wed,
 26 Feb 2025 12:32:27 -0500
X-MC-Unique: Mq3gCe4WM2exIZO678rRDQ-1
X-Mimecast-MFC-AGG-ID: Mq3gCe4WM2exIZO678rRDQ_1740591146
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B163D1955F28;
	Wed, 26 Feb 2025 17:32:25 +0000 (UTC)
Received: from pablmart-thinkpadt14gen4.rmtes.csb (unknown [10.44.33.78])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 964381800358;
	Wed, 26 Feb 2025 17:32:22 +0000 (UTC)
Date: Wed, 26 Feb 2025 18:32:19 +0100 (CET)
From: Pablo Martin Medrano <pablmart@redhat.com>
To: Petr Machata <petrm@nvidia.com>
cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
    Shuah Khan <shuah@kernel.org>, Petr Machata <petrm@nvidia.com>
Subject: Re: [PATCH net v2] selftests/net: big_tcp: return xfail on slow
 machines
In-Reply-To: <874j0ii3ip.fsf@nvidia.com>
Message-ID: <d38dc75d-adec-77cb-6f06-ad006d1f8c5d@redhat.com>
References: <23340252eb7bbc1547f5e873be7804adbd7ad092.1739983848.git.pablmart@redhat.com> <874j0ii3ip.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111



On Tue, 25 Feb 2025, Petr Machata wrote:

> It is customary to Cc people who have expressed interest in past
> versions of your patches. I had opinions on v1, so please Cc me
> on v2+ as well.

I will keep that in mind for next versions. Thank you Petr!


