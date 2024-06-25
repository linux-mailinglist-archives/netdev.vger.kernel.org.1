Return-Path: <netdev+bounces-106507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 644679169F7
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 16:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FCC41F217D2
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 14:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8F7149E05;
	Tue, 25 Jun 2024 14:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F76G5rtT"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE97D38DDB
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 14:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719324949; cv=none; b=YHaM9yDHWPQ8JtjL9W0yPrtQ1romuNFTdD2vJO8LCcYJdVybc8gu8VPLpJ6xw655CRdQP4pYaU5JV0CClkyp44oSrgxjyE4HBDlmFc3rhhrMH1zPJoFxiJWfgT0wB6wYTb5wg9XqWG/XdGAnmwB5JI6n4+LOP7y+INFVy3Y001w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719324949; c=relaxed/simple;
	bh=8M2qHHwCjXkaeZROkxqCF62UlYq9qGHUVUS3TBwEOM8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QIATX1iptYmUSdNd7SdSjTIgjeN0uT+3Ns1zKvK3kGv+Bu7VwzRch1+dPpIGazRoulH92fts6NyswxJoaAgPG5yn26l0E8X6dvEr9gpiQRUERf2f9Ll02frXIuXF7ZbV9P4fNW4Z8zQoXhbsFWqmsTGNDM6UqNbYl0+LdneRfYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F76G5rtT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719324946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W7ydIp+uRxv9vpeC5lM+Zdk/FaOMqbxesom5QUbL9cA=;
	b=F76G5rtTa4uo7mzqeW1lLJeC5nyWWEgNMAgNXEa0yYvu5ET4H8aMZb59G1VzLZ3M+EGgds
	zgknFWTC/87lYudoLs5a9x2oECfXpcdtSbYBpWTKo/Vohvx5yZ18GzzCQ0PUL8Is6YQaLh
	I7ztbSlYGUkB8wCrTIGZuE3fPYR9YX0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-568-OPeVeDlENNmCBT0iajHARA-1; Tue,
 25 Jun 2024 10:15:41 -0400
X-MC-Unique: OPeVeDlENNmCBT0iajHARA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id AE49D189BF8B;
	Tue, 25 Jun 2024 14:14:43 +0000 (UTC)
Received: from RHTRH0061144 (dhcp-17-72.bos.redhat.com [10.18.17.72])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C4B5C196C0D8;
	Tue, 25 Jun 2024 14:14:30 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,  netdev@vger.kernel.org,
  dev@openvswitch.org,  linux-kselftest@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Pravin B Shelar <pshelar@ovn.org>,  "David
 S. Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,
  Shuah Khan <shuah@kernel.org>,  Stefano Brivio <sbrivio@redhat.com>,
  =?utf-8?Q?Adri=C3=A1n?= Moreno <amorenoz@redhat.com>,  Simon Horman
 <horms@kernel.org>
Subject: Re: [PATCH v2 net-next 0/7] selftests: net: Switch pmtu.sh to use
 the internal ovs script.
In-Reply-To: <20240625070654.6a00efef@kernel.org> (Jakub Kicinski's message of
	"Tue, 25 Jun 2024 07:06:54 -0700")
References: <20240620125601.15755-1-aconole@redhat.com>
	<20240621180126.3c40d245@kernel.org> <f7ttthjh33w.fsf@redhat.com>
	<f7tpls6gu3q.fsf@redhat.com>
	<e4f69335f90aae3f1daa47ba8f69b24ea15ed3b7.camel@redhat.com>
	<f7th6dhgnvm.fsf@redhat.com> <20240625070654.6a00efef@kernel.org>
Date: Tue, 25 Jun 2024 10:14:24 -0400
Message-ID: <f7t1q4lgldr.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Jakub Kicinski <kuba@kernel.org> writes:

> On Tue, 25 Jun 2024 09:20:29 -0400 Aaron Conole wrote:
>> > I'm still wondering if the issue is Kconfig-related (plus possibly bad
>> > interaction with vng). I don't see the OVS knob enabled in the self-
>> > tests config. If it's implied by some other knob, and ends-up being
>> > selected as a module, vng could stumble upon loading the module at
>> > runtime, especially on incremental build (at least I experience that
>> > problem locally). I'm not even sure if the KCI is building
>> > incrementally or not, so all the above could is quite a wild guess.
>> >
>> > In any case I think adding the explicit CONFIG_OPENVSWITCH=y the
>> > selftest config would make the scenario more well defined.  
>> 
>> That is in 7/7 - but there was a collision with a netfilter knob getting
>> turned on.  I can repost it as-is (just after rebasing) if you think
>> that is the only issue.
>
> Sorry for not checking it earlier, looks like the runner was missing
> pyroute:
>
> # python3 ./tools/testing/selftests/net/openvswitch/ovs-dpctl.py
> Need to install the python pyroute2 package >= 0.6.
>
> I guess run_cmd counter-productively eats the stderr output ? :(

Awesome :)  I will add a patch to ovs-dpctl that will turn the
sys.exit(0) into sys.exit(1) - that way it should do the skip.

When I previously tested, I put an error in the `try` without reading
the except being specifically for a ModuleNotFound error.

I'll make sure pyroute2 isn't installed when I run it again.

Thanks for your help Jakub and Paolo!


