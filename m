Return-Path: <netdev+bounces-190464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 069D9AB6DDF
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 16:14:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25CAC7A5AE4
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 14:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E922C15C15F;
	Wed, 14 May 2025 14:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K5LV0Rvn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458A0191F6C
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 14:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747232047; cv=none; b=EGzEzStYN3BYsDR8CMpytqS9RDP4wBAYH8xJI70LuH2DscmHvx1an0pg2TrkRqmMpJ0Kd93IS/cwFFCQMYoo19wq4vUjAiKT2YQX5n4ZHD+p5BIvJZWz1TeyoYzaf3BCRDJ6OJdZgyKQk+4TX+lzZMVlHQH/yYSBSV+vA3x8IvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747232047; c=relaxed/simple;
	bh=I0sminW4IkwuCW/0W6uZGifwxZ+LnPI2ndnV6UJbjg0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=daf/kfmt0KkccjBFmxlM9WfcDAbh5dFBArNLvqQYAL0wO/V2RZEc8ngfmHqqhiuzCF5BTiFPu8WGNWmHi0Nz7hdq7G+5PgTEqmVgyk+oTmKNFaLINu7WIu6/8nCAUWC4L5+NwWaqIfaN+K1b2z8o4QXvDqfcDxpYWceYjCIjyxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K5LV0Rvn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747232045;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I0sminW4IkwuCW/0W6uZGifwxZ+LnPI2ndnV6UJbjg0=;
	b=K5LV0RvnITeMv0D4JrQRbuLaWkBV7T6ZQ8xZXMpJ0Pe+CwYtQOVSiDXRGAirhoUBkL+ZW3
	UfhUAAwCU+EZBnNXeQtlhFt5MtjMNTvzYzNxPR+/SNMC2Gfe1bNHfeS99FMdkBTQOwlXQC
	BeR2g92RFsaoKy3646giWc77GYL1U7I=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-511-J6KUNro3NLCShhtV9nPBHA-1; Wed,
 14 May 2025 10:14:03 -0400
X-MC-Unique: J6KUNro3NLCShhtV9nPBHA-1
X-Mimecast-MFC-AGG-ID: J6KUNro3NLCShhtV9nPBHA_1747232041
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1C71A180087A;
	Wed, 14 May 2025 14:14:01 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.22.88.72])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2D2DE30001A1;
	Wed, 14 May 2025 14:13:57 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org,  linux-rt-devel@lists.linux.dev,
  dev@openvswitch.org,  Ilya Maximets <i.maximets@ovn.org>,  Eric Dumazet
 <edumazet@google.com>,  Simon Horman <horms@kernel.org>,  Jakub Kicinski
 <kuba@kernel.org>,  Thomas Gleixner <tglx@linutronix.de>,  Paolo Abeni
 <pabeni@redhat.com>,  "David S. Miller" <davem@davemloft.net>
Subject: Re: [ovs-dev] [PATCH net-next v4 07/15] openvswitch: Merge three
 per-CPU structures into one
In-Reply-To: <20250512092736.229935-8-bigeasy@linutronix.de> (Sebastian
	Andrzej Siewior's message of "Mon, 12 May 2025 11:27:28 +0200")
References: <20250512092736.229935-1-bigeasy@linutronix.de>
	<20250512092736.229935-8-bigeasy@linutronix.de>
Date: Wed, 14 May 2025 10:13:56 -0400
Message-ID: <f7ta57fe0uz.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> exec_actions_level is a per-CPU integer allocated at compile time.
> action_fifos and flow_keys are per-CPU pointer and have their data
> allocated at module init time.
> There is no gain in splitting it, once the module is allocated, the
> structures are allocated.
>
> Merge the three per-CPU variables into ovs_pcpu_storage, adapt callers.
>
> Cc: Aaron Conole <aconole@redhat.com>
> Cc: Eelco Chaudron <echaudro@redhat.com>
> Cc: Ilya Maximets <i.maximets@ovn.org>
> Cc: dev@openvswitch.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---

Reviewed-by: Aaron Conole <aconole@redhat.com>


