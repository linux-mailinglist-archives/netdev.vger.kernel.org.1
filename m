Return-Path: <netdev+bounces-165025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0FEA30192
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 03:39:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D80D93A1C9F
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 02:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DE71BFE00;
	Tue, 11 Feb 2025 02:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mw2ffws9"
X-Original-To: netdev@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2A526BDBF;
	Tue, 11 Feb 2025 02:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739241544; cv=none; b=uO1byaWGDSUc0gCyaScmswvt723VbxKEs1ZwI1rCqRU7V7IIsBALZgsCkTTm4hR2h9HHXAdOw0YJGhecNfRwdsBKXtLRbQ0VLz/hUzBVovxR+jgdDpx66r3k1Jxi5qEu0Mu0wkTiuDYM5lJz/Il0PYjKdroo1hljHwgpXcxwEtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739241544; c=relaxed/simple;
	bh=5JDfHicwmMEPruu4CfflG+XzYIWbKrLxuaPw0b0Af9U=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=YYUnTwe+0WyjJmbz0XsAoSvpJ+GpyQpkytMyfsSyCfhMY3aYdC+fyiUzBDpOtOT9KRP0g+XnGV0Mx0eitLvOSm112iZTlzanKOKJDUY8qx4xz4lKobbOfAonRQ2gtXrPbDAaiYmFMmrdn8bbNMq3noIwtLmybg27I5ym4/3bYnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mw2ffws9; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=UW7SVyypLT3sDcwZQm79Hbi5R9Lu26flFJ24Hl9wWv4=; b=mw2ffws9btnhS3ETGd5CAUHOuW
	8lQtPqGr5da44FZnK1Qh2dF5QWz7fa7lBfukjJc8tVraI0xgJwgqduGxA0mF5IKmYN2YVL92BCrIt
	NuUphRIaqongLujdCfgxz372z8RAbLwJOmJNoesYGF3C48xh8I18DtHhYhVkwin7sUqNvBU36q93O
	clPcc6++iUr82eUeZ9eXHz+xd+WY62xl801sz/67LklTQjcuG1m9Lo/QNSfHdOkHG8jhNG2gvbLtq
	ly0ty0fGqUF4yp/AItQ21TGgELgW9pS3Gaobtxtv2MOBSiun4chZ6JrYZLwe/W4AAEK58y0TxwCFD
	6Rp/lbUw==;
Received: from [50.53.2.24] (helo=[127.0.0.1])
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1thgAm-00000000SAa-3vEs;
	Tue, 11 Feb 2025 02:38:53 +0000
Date: Mon, 10 Feb 2025 18:38:49 -0800
From: Randy Dunlap <rdunlap@infradead.org>
To: Jakub Kicinski <kuba@kernel.org>, Joe Damato <jdamato@fastly.com>
CC: netdev@vger.kernel.org, ahmed.zaki@intel.com,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] documentation: networking: Add NAPI config
User-Agent: K-9 Mail for Android
In-Reply-To: <20250210181635.2c84f2e1@kernel.org>
References: <20250208012822.34327-1-jdamato@fastly.com> <20250210181635.2c84f2e1@kernel.org>
Message-ID: <CB01BC60-A7ED-484C-A766-BF6D37BF48CE@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On February 10, 2025 6:16:35 PM PST, Jakub Kicinski <kuba@kernel=2Eorg> wro=
te:
>On Sat,  8 Feb 2025 01:28:21 +0000 Joe Damato wrote:
>> +Persistent NAPI config
>> +----------------------
>> +
>> +Drivers can opt-in to using a persistent NAPI configuration space by c=
alling
>
>Should we be more forceful? I think for new drivers the _add_config()=20
>API should always be preferred given the benefits=2E
>
>> +netif_napi_add_config=2E This API maps a NAPI instance to a configurat=
ion
>> +structure using a driver defined index value, like a queue number=2E I=
f the
>> +driver were to destroy and recreate NAPI instances (if a user requeste=
d a queue
>
>"were" is correct here?

Yes, subjunctive mood=2E


>> +count change, for example), the new NAPI instances will inherit the co=
nfiguration
>> +settings of the NAPI configuration structure they are mapped to=2E
>


~Randy

