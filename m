Return-Path: <netdev+bounces-91051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C8C8B11CA
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 20:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2B9B28461C
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 18:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F9C16D9A9;
	Wed, 24 Apr 2024 18:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iaobvusv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998A216D9AC
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 18:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713982458; cv=none; b=ocbbKBNNOK4heEjGnCeO39d01HVlv4NWxekIbAJX6abEktUhTuMzmxPDgaRAAR8e3GxJvR1fuKL91Hqhqv4ziT+l/CnNZWKYc1cy64fT+CZSLzUImENJnjXCFO+ZxiHhIHAZUL8CLcHmGv89fb2Womrpp+p4Up8cRACCaLPafuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713982458; c=relaxed/simple;
	bh=SyIRfey7jd9uKj0E+ohfTS21kVAZf56wNteZoSqDhME=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=goAzxfSM1WBY0EFtn3vXEEldocGeDeEr/0CE0RmKyJdvZ8PRE7cpsO6u5/gIRmmeGmy/ycyjYeTOwKcQLTGffCfTgke+Sfu9qLLdxLOLPSILkMzkevmFj2PoYunzpwx7vaet30Hs1wh5fVwbJt77mTkf3eO4H/4xqdZ7KKabpyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Iaobvusv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713982455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P1Nbcn66OdAwHlw8WC2+eMDDgpxdIVjkxIqiKXG1znI=;
	b=IaobvusvEzBFsIU9DfDUAj7i29O0sQw8ZHxyp6iYotSS288yp5sqls9vXgN1RMQTAS9a/R
	jBxW1m4Zm8i3g8GwFibqx4hUD7/7pc0mcOWyHTq9hUS2glILNlfAfDcp0mqTGADy3RdWrw
	h6qaHlp9yjzntKuOnz0SJcl1zmesUDQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-551-Wio6EgnANjmWG1RqmvZTbw-1; Wed,
 24 Apr 2024 14:14:10 -0400
X-MC-Unique: Wio6EgnANjmWG1RqmvZTbw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A591F1C0513F;
	Wed, 24 Apr 2024 18:14:09 +0000 (UTC)
Received: from RHTRH0061144 (dhcp-17-72.bos.redhat.com [10.18.17.72])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7AEEB1121312;
	Wed, 24 Apr 2024 18:14:09 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Simon Horman <horms@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>,  netdev@vger.kernel.org,
  dev@openvswitch.org,  linux-kselftest@vger.kernel.org
Subject: Re: selftests: openvswitch: Questions about possible enhancements
In-Reply-To: <20240424164405.GN42092@kernel.org> (Simon Horman's message of
	"Wed, 24 Apr 2024 17:44:05 +0100")
References: <20240424164405.GN42092@kernel.org>
Date: Wed, 24 Apr 2024 14:14:09 -0400
Message-ID: <f7tle52aary.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Simon Horman <horms@kernel.org> writes:

> Hi Aaron, Jakub, all,
>
> I have recently been exercising the Open vSwitch kernel selftests,
> using vng, something like this:
>
> 	TESTDIR="tools/testing/selftests/net/openvswitch"
>
>         vng -v --run . --user root --cpus 2 \
>                 --overlay-rwdir "$PWD" -- \
>                 "modprobe openvswitch && \
> 		 echo \"timeout=90\" >> \"${TESTDIR}/settings\" && \
>                  make -C \"$TESTDIR\" run_tests"
>
> And I have some observations that I'd like to ask about.
>
> 1. Building the kernel using the following command does not
>    build the openvswitch kernel module.
>
> 	vng -v --build \
> 		--config tools/testing/selftests/net/config
>
>    All that seems to be missing is CONFIG_OPENVSWITCH=m
>    and I am wondering what the best way of resolving this is.
>
>    Perhaps I am doing something wrong.
>    Or perhaps tools/testing/selftests/net/openvswitch/config
>    should be created? If so, should it include (most of?) what is in
>    tools/testing/selftests/net/config, or just CONFIG_OPENVSWITCH=m?

I have a series that I need to get back to fixing:

https://mail.openvswitch.org/pipermail/ovs-dev/2024-February/411917.html

which does include the config listed, and some of the fixes for things
you've noted.

I think it makes sense to get back to it.

> 2. As per my example above, it seems that a modprobe openvswitch is
>    required (if openvswitch is a module).
>
>    Again, perhaps I am doing something wrong. But if not, should this be
>    incorporated into tools/testing/selftests/net/openvswitch/openvswitch.sh
>    or otherwise automated?
>
> 3. I have observed that the last test fails (yesterday, but not today!),
>    because the namespace it tries to create already exists. I believe this
>    is because it is pending deletion.
>
>    My work-around is as follows:
>
>  ovs_add_netns_and_veths () {
>  	info "Adding netns attached: sbx:$1 dp:$2 {$3, $4, $5}"
> +	for i in $(seq 10); do
> +		ovs_sbx "$1" test -e "/var/run/netns/$3" || break
> +		info "Namespace $3 still exists (attempt $i)"
> +		ovs_sbx "$1" ip netns del "$3"
> +		sleep "$i"
> +	done
>  	ovs_sbx "$1" ip netns add "$3" || return 1
>  	on_exit "ovs_sbx $1 ip netns del $3"
>  	ovs_sbx "$1" ip link add "$4" type veth peer name "$5" || return 1
>
>    N.B.: the "netns del" part is probably not needed,
>    but I'm not able to exercise it effectively right now.
>
>    I am wondering if a loop like this is appropriate to add, perhaps also
>    to namespace deletion. Or if it would be appropriate to port
>    openvswitch.sh to use ./tools/testing/selftests/net/lib.sh, which I
>    believe handles this.
>
> 4. I am observing timeouts whith the default value of 45s.
>    Bumping this to 90s seems to help.
>    Are there any objections to a patch to bump the timeout?


