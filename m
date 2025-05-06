Return-Path: <netdev+bounces-188459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7094AACE2B
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 21:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A2DE1751F9
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 19:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAC81F4C97;
	Tue,  6 May 2025 19:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OhMXhOKG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A487262D
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 19:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746560342; cv=none; b=ntZqEBmQwNS2OnnS2MbEBHYPd+0dtzk1oxtyJCbWzAs3DzVnp9vBZ7G4EBQAMBaWw/KslcXY4Flx0VpVYTw0f8F83RNz3IzI6K3sTyNv4Yg5r+b96hQekr+or21l1ukPv3Gkfm288woifID3dma1+nYrW2n52mNoOCtv1cUHAfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746560342; c=relaxed/simple;
	bh=JIR+Y45q8z58HzF4wpScKnpLU12WJQjMjwGGWH54DE8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LOR4MTSLl/mh+rO2KJn9pKlJH0tz/8L3kTQ0+ilk4Rsc+uohAwafecUOxMfeuAC+9/KkNhg9Jgn9kuNwE17t44qlkFWKMhfDOdxr1hbVZlUa/kq5Mcc7mWzYvnRNF9rgWdDTRcFHEOIVgfB36m70m8QIJj+9x4x1OM6z2OXWVOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OhMXhOKG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746560337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JIR+Y45q8z58HzF4wpScKnpLU12WJQjMjwGGWH54DE8=;
	b=OhMXhOKG8GODKI0OV+ykFLTo58WxsuF//XDhChH7xavoYAcxLQyHRQjR8KrIGEFl4PaYHg
	nSWbzZtLKrMFVKiLCfXpD0tA4nd/HYWVEJ6HQg4kB22oru7JPcz/hDOWAzjajKcjCxM/Xl
	h7TAA4nablvkxygli3QxERXlhK+Qcn4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-261-haR22DAEMi69ZbS54r9zoA-1; Tue,
 06 May 2025 15:38:54 -0400
X-MC-Unique: haR22DAEMi69ZbS54r9zoA-1
X-Mimecast-MFC-AGG-ID: haR22DAEMi69ZbS54r9zoA_1746560329
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 406961954B2D;
	Tue,  6 May 2025 19:38:49 +0000 (UTC)
Received: from RHTRH0061144 (unknown [10.44.33.241])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E49DD19560B7;
	Tue,  6 May 2025 19:38:45 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Eelco Chaudron <echaudro@redhat.com>
Cc: netdev@vger.kernel.org,  dev@openvswitch.org,  i.maximets@ovn.org,
  davem@davemloft.net,  edumazet@google.com,  kuba@kernel.org,
  pabeni@redhat.com,  horms@kernel.org
Subject: Re: [PATCH net] openvswitch: Fix unsafe attribute parsing in
 output_userspace()
In-Reply-To: <0bd65949df61591d9171c0dc13e42cea8941da10.1746541734.git.echaudro@redhat.com>
	(Eelco Chaudron's message of "Tue, 6 May 2025 16:28:54 +0200")
References: <0bd65949df61591d9171c0dc13e42cea8941da10.1746541734.git.echaudro@redhat.com>
Date: Tue, 06 May 2025 15:38:43 -0400
Message-ID: <f7tselh7cn0.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

Eelco Chaudron <echaudro@redhat.com> writes:

> This patch replaces the manual Netlink attribute iteration in
> output_userspace() with nla_for_each_nested(), which ensures that only
> well-formed attributes are processed.
>
> Fixes: ccb1352e76cf ("net: Add Open vSwitch kernel components.")
> Signed-off-by: Eelco Chaudron <echaudro@redhat.com>
> ---

Acked-by: Aaron Conole <aconole@redhat.com>


