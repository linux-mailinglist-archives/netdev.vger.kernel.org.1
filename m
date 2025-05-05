Return-Path: <netdev+bounces-187730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C80DAA933E
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 14:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A45D3176AC8
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 12:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2641D90AD;
	Mon,  5 May 2025 12:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TjYG4+vU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FBA2745E
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 12:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746448489; cv=none; b=mx0jrEohoe6luFyS6HzaIyWvYQgRBVBXJHoXjWIrb8FtVYSsqKwqP1Xda9fcfR2AwpcTk/w4S0cihWWrHgUjxjuUcYC6S3+yqdqPZJoFoRgxF1NRZWcsaecchMost618q5Zi56ZjgcOU5l2GkCKguIdItBfWwudVml9pWY+RGFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746448489; c=relaxed/simple;
	bh=YgOMSyYUQHNaGZxMccTqNRLhpDhKEy7ClD8WjA9WSio=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oQFKrzE6aquFDewuhPoypE/dt+2EBWL3kbJ24UECh3o8lvvEhGkpUrziuOPMCOgpGi6dC7WL0mV7NhhGL/vjVX0OUqVoydyH7QNkHftvWr7y3j2vOdaSfyzNKIN3VXrD2SlTWCylxQnJfH5hj+IpsojsDbI1YULpRPidJa7dtrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TjYG4+vU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746448485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QxqNPO/7iU44xWKsZUOMqjngAIKrMVeXOUJcdf4ha7Q=;
	b=TjYG4+vUEy2/15upMjwKEwqZ4fF6KO8Tm/hCKiVHSVV1nI76XRYS70xngOOXgnbwR1lQxo
	yhNx9t5nJaMDtXQXoRV8rXm5D/W9YnDhaN5uePaUgxKQunsqQeStw8AqyitSQ7fFJQcec+
	tfi5iAnxS0w5um+H36hLEar7t+JcmKg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-csKgwSHCMmClMGq5PjoqRg-1; Mon,
 05 May 2025 08:34:43 -0400
X-MC-Unique: csKgwSHCMmClMGq5PjoqRg-1
X-Mimecast-MFC-AGG-ID: csKgwSHCMmClMGq5PjoqRg_1746448481
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3F3C61800ECA;
	Mon,  5 May 2025 12:34:41 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.64.78])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C81EA195608D;
	Mon,  5 May 2025 12:34:37 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org,  linux-rt-devel@lists.linux.dev,
  dev@openvswitch.org,  Ilya Maximets <i.maximets@ovn.org>,  Eric Dumazet
 <edumazet@google.com>,  Simon Horman <horms@kernel.org>,  Jakub Kicinski
 <kuba@kernel.org>,  Thomas Gleixner <tglx@linutronix.de>,  Paolo Abeni
 <pabeni@redhat.com>,  "David S. Miller" <davem@davemloft.net>
Subject: Re: [ovs-dev] [PATCH net-next v3 12/18] openvswitch: Move
 ovs_frag_data_storage into the struct ovs_pcpu_storage
In-Reply-To: <20250430124758.1159480-13-bigeasy@linutronix.de> (Sebastian
	Andrzej Siewior's message of "Wed, 30 Apr 2025 14:47:52 +0200")
References: <20250430124758.1159480-1-bigeasy@linutronix.de>
	<20250430124758.1159480-13-bigeasy@linutronix.de>
Date: Mon, 05 May 2025 08:34:35 -0400
Message-ID: <f7t7c2vdyn8.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> ovs_frag_data_storage is a per-CPU variable and relies on disabled BH for its
> locking. Without per-CPU locking in local_bh_disable() on PREEMPT_RT
> this data structure requires explicit locking.
>
> Move ovs_frag_data_storage into the struct ovs_pcpu_storage which already
> provides locking for the structure.
>
> Cc: Aaron Conole <aconole@redhat.com>
> Cc: Eelco Chaudron <echaudro@redhat.com>
> Cc: Ilya Maximets <i.maximets@ovn.org>
> Cc: dev@openvswitch.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---

Tested it with the same script, and see that it preforms inline with my
unpatched results.  This is without CONFIG_PREEMPT, so I didn't do any
checks on a 'RT' system.  That does make me wonder whether it really is
my system or something in the way local lock is being used, or even a
misunderstanding about the possible contention scenarios.

I also did check the openvswitch userspace kernel test suite and that
also passes.  So looks good that way.


