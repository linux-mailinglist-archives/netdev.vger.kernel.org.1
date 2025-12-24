Return-Path: <netdev+bounces-245968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 168C4CDC49E
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 13:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 748B33052227
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 12:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033E831A542;
	Wed, 24 Dec 2025 12:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b="n6n5ZWOa"
X-Original-To: netdev@vger.kernel.org
Received: from www3141.sakura.ne.jp (www3141.sakura.ne.jp [49.212.207.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB43E2F3614
	for <netdev@vger.kernel.org>; Wed, 24 Dec 2025 12:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=49.212.207.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766580797; cv=pass; b=fu4dZ8mLb47IUChoGvwHuFY9navrx3l/WspdQ/U/xyfMmDDw+Cm6K6Y//IZrFY0s/v0Le6yEMa/7fMx/E1KAYRdA7BpdR60buQEmZqn7o9t/7SYZZoiVdld5aha6dmsR2MTDfMRQRpDUWcX8jqapu9PylUYEebF2lsNNFX9zHao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766580797; c=relaxed/simple;
	bh=RvSSgF+Ty4E5Q23//WRoOIdOX+/Nhnb0VDFyPNwWrc8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=i5EWjdbF10UHW13r0+HN4bUwBbk5vGqP0hIkPs9JIaRMJWZ8T+ZbyMKTnSG7v57pdQMd/XyvNeCswK3j7uPF62uuZf+ios1i58l1prZX0tlEVekRumVJ9wQ7yDrVb3eUokP0xvOITXKT4mFZ2P2Pf2vx5DJx6H73MhVbz2ALLzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org; spf=pass smtp.mailfrom=redadmin.org; dkim=pass (1024-bit key) header.d=redadmin.org header.i=@redadmin.org header.b=n6n5ZWOa; arc=pass smtp.client-ip=49.212.207.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redadmin.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redadmin.org
Received: from www.redadmin.org (bc043154.ppp.asahi-net.or.jp [222.228.43.154])
	(authenticated bits=0)
	by www3141.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 5BOCrCBn075363
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 24 Dec 2025 21:53:13 +0900 (JST)
	(envelope-from weibu@redadmin.org)
Received: from localhost (localhost [127.0.0.1])
	by www.redadmin.org (Postfix) with ESMTP id 455E0109D6C01;
	Wed, 24 Dec 2025 21:53:12 +0900 (JST)
X-Virus-Scanned: amavis at redadmin.org
Received: from www.redadmin.org ([127.0.0.1])
 by localhost (redadmin.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v2qtyPeFh8P3; Wed, 24 Dec 2025 21:53:08 +0900 (JST)
Received: from webmail.redadmin.org (redadmin.org [192.168.11.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: weibu@redadmin.org)
	by www.redadmin.org (Postfix) with ESMTPSA id 75513109D6CBD;
	Wed, 24 Dec 2025 21:53:08 +0900 (JST)
DMARC-Filter: OpenDMARC Filter v1.4.2 www.redadmin.org 75513109D6CBD
Authentication-Results: www.redadmin.org; arc=none smtp.remote-ip=192.168.11.50
ARC-Seal: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space; t=1766580788;
	cv=none; b=lZjC88tO3iuPiGGcjkyzvfJFBBtxD4no11lRDefWVi3JByI8n6+7fgw2Wc2p4lic0l0U61HC3UbF0HiPkgwFQr06qfo1cfon5zhNYvinCR3YmAU7AhPBYV4UAjEHj49ukDczwAEebQH5QQI8mWeZtgy2k3lz60uqoEg2jNUe44M=
ARC-Message-Signature: i=1; a=rsa-sha256; d=redadmin.org; s=20231208space;
	t=1766580788; c=relaxed/relaxed;
	bh=2JBkhuwY3NIkmFyOH8xIaV77KY39PYxYhlDlN5/RPQc=;
	h=DKIM-Filter:DKIM-Signature:MIME-Version:Date:From:To:Cc:Subject:
	 In-Reply-To:References:Message-ID:X-Sender:Content-Type:
	 Content-Transfer-Encoding; b=u97zruLhITYp3ImuWu9Pfk8u+E9n1lJ+kOwNytousBXPc9Nc2sZONQKr9gvsdH9p1noTcLBndwUpeZ0VzkB5TiJxLbdsr+Hv88mcgCaAPyWu/UFuaQFhRZ5A7NWQtY50HQH5mrJWzg6s0zOy89NDue+DwsgXya/WyJ+QbGDDWfg=
ARC-Authentication-Results: i=1; www.redadmin.org
DKIM-Filter: OpenDKIM Filter v2.11.0 www.redadmin.org 75513109D6CBD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redadmin.org;
	s=20231208space; t=1766580788;
	bh=2JBkhuwY3NIkmFyOH8xIaV77KY39PYxYhlDlN5/RPQc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n6n5ZWOawRiszxzy74OrLArzo+Prf/lsNA3kqN8PVW4L3vajg+3EoakSHYqop34TT
	 uQxd/8k9FZ0pR0hktTw2TcfBoJj6Y+vpAya0EQNhjyjbtbRRXc/A9kAFL0pC5jkzzO
	 DAUgF85MecXNYLBfCL3qAlx/Rg4HNUUDYZKhV3kI=
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 24 Dec 2025 21:53:08 +0900
From: weibu@redadmin.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
 <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: net: dsa: marvell,mv88e6xxx: fix typo
In-Reply-To: <a5984b03-6c9b-4f5b-ba71-57ef77104e03@kernel.org>
References: <20251224123230.2875178-1-weibu@redadmin.org>
 <a5984b03-6c9b-4f5b-ba71-57ef77104e03@kernel.org>
Message-ID: <f99d3ebf3b1c1bfd99f6095d32a2da61@redadmin.org>
X-Sender: weibu@redadmin.org
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

Thanks for the feedback. Understood — I will send typo fixes aggregated 
per subsystem going forward.

2025-12-24 21:36 に Krzysztof Kozlowski さんは書きました:
> On 24/12/2025 13:32, Akiyoshi Kurita wrote:
>> Fix a typo in the interrupt-cells description ("alway" -> "always").
> 
> Please do not send trivial typos one by one, but fix all of occurrences
> per subsystem. This is too much effort to deal with such one liners.
> 
>> 
>> Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>
> Best regards,
> Krzysztof

