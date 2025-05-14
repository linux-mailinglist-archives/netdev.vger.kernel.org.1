Return-Path: <netdev+bounces-190466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 396C9AB6DE1
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 16:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBEEF1B6811D
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 14:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A02190685;
	Wed, 14 May 2025 14:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IjJbyk49"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D922418E377
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 14:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747232076; cv=none; b=NlGXAY3x2anq0cf+bzrxJE2xC/riFrAqO1hhyce2kBzGUzok+dlU2Eid2qX+K4XyGUlArWgaqUZBEkouqucJhRuGEokLL4s9t1E8/uapjRHWMzelwP9vp2t+EHkrvol5veWhgqye3hS0T7s6VqF9k06CFXW5JjFEvzAz5URiazY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747232076; c=relaxed/simple;
	bh=r+rdiSnfS0ewBDl2wJtTSwpAvJKY5lt9tHzxYmbOs1E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UOvKPkYDr7h4UCEyZ9qBdzLc4F35TVYp8BN7Msf65Z2ESWibLNO5qlTNnlAH+W4C2XxV89IjXgFGc3vpeNgHOTZXarUgomw6IwyD9c5+6QF0qou5uGMF6StKFWELlBVa1SStqbbG1FL3QxYK4KmEu3EcmuqauoeKjxIP2TZFZsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IjJbyk49; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747232073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r+rdiSnfS0ewBDl2wJtTSwpAvJKY5lt9tHzxYmbOs1E=;
	b=IjJbyk49iUwm8cVP9AynPDYxGYF2OD/087yZdEALe1Ia5eJ4ocwzsXcPGQeEYF6LgJvyBX
	WNXVwyaHsHT7U9mNZpIfta7hSH4TP+JtqEEzW+k4YwNZOhTm+ShXSvaFOZ1cAJXA5XXU4M
	0E7cIBHeMHrAczY+75L55Acrnpy0Ruc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-66-dTX38y8GPuSRWNTzDXh5RA-1; Wed,
 14 May 2025 10:14:30 -0400
X-MC-Unique: dTX38y8GPuSRWNTzDXh5RA-1
X-Mimecast-MFC-AGG-ID: dTX38y8GPuSRWNTzDXh5RA_1747232069
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E59EC1800360;
	Wed, 14 May 2025 14:14:28 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.88.72])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 34765180049D;
	Wed, 14 May 2025 14:14:25 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org,  linux-rt-devel@lists.linux.dev,
  dev@openvswitch.org,  Ilya Maximets <i.maximets@ovn.org>,  Eric Dumazet
 <edumazet@google.com>,  Simon Horman <horms@kernel.org>,  Jakub Kicinski
 <kuba@kernel.org>,  Thomas Gleixner <tglx@linutronix.de>,  Paolo Abeni
 <pabeni@redhat.com>,  "David S. Miller" <davem@davemloft.net>
Subject: Re: [ovs-dev] [PATCH net-next v4 09/15] openvswitch: Move
 ovs_frag_data_storage into the struct ovs_pcpu_storage
In-Reply-To: <20250512092736.229935-10-bigeasy@linutronix.de> (Sebastian
	Andrzej Siewior's message of "Mon, 12 May 2025 11:27:30 +0200")
References: <20250512092736.229935-1-bigeasy@linutronix.de>
	<20250512092736.229935-10-bigeasy@linutronix.de>
Date: Wed, 14 May 2025 10:14:24 -0400
Message-ID: <f7t7c2je0u7.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

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

Reviewed-by: Aaron Conole <aconole@redhat.com>


