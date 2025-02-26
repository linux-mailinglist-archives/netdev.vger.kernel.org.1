Return-Path: <netdev+bounces-169961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6871A46A31
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 19:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6588E1889703
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 18:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB51236437;
	Wed, 26 Feb 2025 18:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BtfAtb/F"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D5D21D5AE
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 18:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740595993; cv=none; b=PWuvcTnAK9GwhQuaH0hrYuDJ6DM1aK04QUeyER5w2T/rH+7Woaml/O5xBB5v7Xmz3kI0owk5/K5bUlta98xzKbRGyUL2HYneAS4ScIF4fT8QkNKQWFwSO3wDVIpjN+PrJCCEyD+OmHwqDPKO2nXVXZvJaS+7CCzqk1VBAu3dF5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740595993; c=relaxed/simple;
	bh=ssXShzytIovRoZES0R5YgADemeudwN/H5A5CejYFd3Q=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=mmbKYIMBTAxsA2DwQPZz6p0uZ414k/2DAuyzA0ajIv2n2wghWLltySkHjF/HoEbo+ux/Y775YFXMEwMAKG5wAK+UUUerVHJLfqShks7m6eG6FNSyc6db1/lcSJgmzsZKjmUQI6LmUaveGHHT9/dAQnznUkDi2ATaX0c0rtFv2ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BtfAtb/F; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740595990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=urGEhLujqDagoDvWK5gyybo4cFdKYt3C3On98zVKC1o=;
	b=BtfAtb/F/63AiDN6E8o0fSWvCq8czYcrz5Bn5HWIS8Ecyiiulm2mkbyo1Y67kbLalUv6Nb
	/UP9HHNwoWbK6AFmgav2A3EH/N4dkPgOnFj0G7UaQok45vaTw4WXogr1q82eoPB75kHGOx
	YZ0pwUY4aPHKD3aZXB37qXddkSBYk8c=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-12-dCn1dCgPNaOU2pnQ2ZDLEA-1; Wed,
 26 Feb 2025 13:53:08 -0500
X-MC-Unique: dCn1dCgPNaOU2pnQ2ZDLEA-1
X-Mimecast-MFC-AGG-ID: dCn1dCgPNaOU2pnQ2ZDLEA_1740595986
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AE89F1801A13;
	Wed, 26 Feb 2025 18:53:06 +0000 (UTC)
Received: from pablmart-thinkpadt14gen4.rmtes.csb (unknown [10.44.33.78])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7C0951955DCE;
	Wed, 26 Feb 2025 18:53:03 +0000 (UTC)
Date: Wed, 26 Feb 2025 19:53:00 +0100 (CET)
From: Pablo Martin Medrano <pablmart@redhat.com>
To: Petr Machata <petrm@nvidia.com>
cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
    Shuah Khan <shuah@kernel.org>, Petr Machata <petrm@nvidia.com>
Subject: Re: [PATCH net v2] selftests/net: big_tcp: return xfail on slow
 machines
In-Reply-To: <87zfiagojj.fsf@nvidia.com>
Message-ID: <3e35d85e-c136-f87e-a215-f2e9ccd43490@redhat.com>
References: <23340252eb7bbc1547f5e873be7804adbd7ad092.1739983848.git.pablmart@redhat.com> <87zfiagojj.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40



On Tue, 25 Feb 2025, Petr Machata wrote:

> Due to all the &&'s peppered down there, do_test() only gets called at
> most once, so it's OK in this case.

Actually do_test() do always returns 0, so it gets called all times in the
code. check_err is setting RET and keeping it at the failing return
value, so check_err is always returning error after the first error

If I force the error by injecting in do_test():

  if [ $gw_tso = off -a $cli_tso = on ]; then
    check_err 1 "forced to fail when GW_GSO is off and CLI GSO is on"
  else
    check_err $ret_check_counter "fail on link1"
  fi

The output is:

  Testing for BIG TCP:
        CLI GSO | GW GRO | GW GSO | SER GRO
  TEST: on        on       on       on                         [ OK ]
  TEST: on        off      on       off                        [ OK ]
  TEST: off       on       on       on                         [ OK ]
  TEST: on        on       off      on                         [FAIL]
          forced to fail when GW_GSO is off and CLI GSO is on
  TEST: off       on       off      on                         [FAIL]
          forced to fail when GW_GSO is off and CLI GSO is on
  ***v4 Tests Done***

So setting RET at the end of do_test is needed indeed.


