Return-Path: <netdev+bounces-282454-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wNpYGytE8mk+pQEAu9opvQ
	(envelope-from <netdev+bounces-282454-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 19:47:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1141A49845D
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 19:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD95F301E212
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 17:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A663438B7BA;
	Wed, 29 Apr 2026 17:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dYL3iS5u";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SlZBLP3X"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E196534DCD6
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 17:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777484781; cv=none; b=Gf42nZhcb/yO0zgP7dMo9TtRkl7wKtpyK/G1aCC9PYBdTZRhL55lU4T2/9IqlFpmREBRT6e2gITG16g0NylmpOetYDEZYUDO3VREOhM9pZl8CCXLMb/aMRHxATNrD0FBNzchbVAvSgFrB42SBNxD2eKi7h2+juq7TqAP4PnOjpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777484781; c=relaxed/simple;
	bh=ltPFZOH3+F5GclvIiCsZJo9B3Rkn54SH6kgVTpcfOWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iIBWmq0JcMSK2G34JL2YM9Wk0sAVFncdWm8f9zN8jwyvBDg4Pc4WK8UFGDU8eSXEZ6IOwjpjy+BPBscvAfOx+C7Ay3mAC0t7jFpmMfybO1zrxnUASut4HHwAL5eea9Wvc0EsFsZYFsQ5z7Fu8WfPf4pMZfDXXN07LeJpcDqI4B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dYL3iS5u; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SlZBLP3X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777484778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=or10qtpHF5q4FsYpWyH8aqkdxHYxoqC0I1ML0azCPiE=;
	b=dYL3iS5uYETJ4zADPmWkRrp7cQjfSTMNUX2+9dBovd314LFuqakIyjSmw5g+lEd/E0tfRx
	ZmzIIICMvHtPSlQs4QiCPCpSuspdhrMaIu6KXUTgOshrUeceuUQyFgilCtaqFF8abP4ipx
	F5syzjEAC0X8EjlW2Ynkx4+wviE3yuA=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-1GbuMOO5Mo26d9eVRF4c6Q-1; Wed, 29 Apr 2026 13:46:16 -0400
X-MC-Unique: 1GbuMOO5Mo26d9eVRF4c6Q-1
X-Mimecast-MFC-AGG-ID: 1GbuMOO5Mo26d9eVRF4c6Q_1777484775
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b934e96af9dso1341459866b.3
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 10:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777484775; x=1778089575; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=or10qtpHF5q4FsYpWyH8aqkdxHYxoqC0I1ML0azCPiE=;
        b=SlZBLP3XuTCp2bzQvvEcYvgNI4iXEI5ycfw3lYvUV+HUF9P+SfOIYFJfzNJO7i1ZVT
         0EEmpSdj8UKKjFk/e/WJRasdxpfAUTkGRpmzGnZ2pf9up23tEKDydYPIHh8bNWIYLK4W
         xjcqTNhwCjMhp+p/uVIUfXP0tm58s9Rq+2sV8m+wm4ZHbjqIY9qJQPA4VttvwNsuTHGQ
         T8m6+Aghyu9R6R8GwJEOiSyQGFitLzUQBTvJk0cXJxIVH+f+WGX9mflcAcaeU6OjcoBs
         1v9bXlh4O4fJAvM0XUhcVSBSkgPmd3PpK53NWthKfRdbQgWpOUD7J1Dq3xX7aiRBDrdF
         HHeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777484775; x=1778089575;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=or10qtpHF5q4FsYpWyH8aqkdxHYxoqC0I1ML0azCPiE=;
        b=JU0Vl3xYplQa37hDrHCNLaxQg2plosoQ5rPxXYsXbap4kheptu9crdFO5xYch4zbpV
         VdicPvxtzATDFmfx3MwtbYazqBpYu+S5Un1l0EyqnrmIS3/9MHX/kIuyQuURce7w31u/
         lqFE/UUo85oMowcQpmUkQsS+RUmeVIuHVcisAfN18PWz5I95MyxY/NNOwPUuQ1SAJ3g3
         I+22CnkZkshCB2GUWqf0Ps8nVO3OrVG0yGxEmyq9/Ugc3Ws06lYcERcF0Ebxf5YnVv7d
         rj0htCu1EMZqoBt/ySIzB6YiuhehNgx8vYC6AUyHwm54H0oy4QuCw69rV3FLbP9LEdYg
         sHMg==
X-Gm-Message-State: AOJu0YzRtngNl1YksvUPYHEv1Y1pIhbnu2+PmQfTNuX1Z33v6TPEtaTV
	v/56lQOWqn7BI/EqPAtCEAr26H0SSkN2VDynWG8QW/dXM/H26JmibDU4lWsVsNeXSwB0QsWnnN2
	BgJpQWarQUhpDipGpR39WT2sSExlkQGvGTibOtpJrHd65RfSOYWuxrhWjiRU5i5w4dA==
X-Gm-Gg: AeBDietV6Dd1hDcQ/8P7eLduY0lESEF77cRIQk44oIzH6gDrAcpRpqT8FAgD7+63z0D
	IyWj7HZOKzsm8rlzTrYLumPc0EYjdEDVtvP/vRsy2iAEmbF53Fl/fqUrJh55A+aWeECtlliTO4F
	HKd4POyY5QAl0iohhp0cOdzUJTS5a9veFoZIGl7BIYiLtIwBx7/g7ZtGgURT1CA3Go9zTnvqvv8
	cBpi7hVUEqAtqdD0gXfDFZsobheVxftwZn34bHsLQxuazcX7k7QnhedwUfK6IU+RrBt4bJ8iCoR
	udfi0eB+RFDgPx13dFP7bfU+dfHO/OKqmVF5rTL3IU/TC9gunwQ3iJZ0r1WIs05DwTikMNrrMiF
	gtYyRi9c0ECfPuMSMfwJ/ZHM9/mBRCrDyLTUiSeZpdYOD4YFh/r6ROnslzm4NFSocNjeLpMKz5U
	hQ3pGBSQ==
X-Received: by 2002:a17:907:1c29:b0:ba7:4cd9:ca12 with SMTP id a640c23a62f3a-bb8026bd340mr584861066b.13.1777484775203;
        Wed, 29 Apr 2026 10:46:15 -0700 (PDT)
X-Received: by 2002:a17:907:1c29:b0:ba7:4cd9:ca12 with SMTP id a640c23a62f3a-bb8026bd340mr584857866b.13.1777484774601;
        Wed, 29 Apr 2026 10:46:14 -0700 (PDT)
Received: from [10.44.49.209] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb980a6f9d6sm125280266b.10.2026.04.29.10.46.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Apr 2026 10:46:14 -0700 (PDT)
From: Eelco Chaudron <echaudro@redhat.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, Aaron Conole <aconole@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>,
 Yuan Tan <tanyuan98@outlook.com>, Yang Yang <n05ec@lzu.edu.cn>,
 dev@openvswitch.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net 0/2] openvswitch: fix self-deadlock on release of
 tunnel vports
Date: Wed, 29 Apr 2026 19:46:12 +0200
X-Mailer: MailMate (2.0r6292)
Message-ID: <AF80E37F-6D40-4D74-906F-196FBFE7A032@redhat.com>
In-Reply-To: <20260429151756.4157670-1-i.maximets@ovn.org>
References: <20260429151756.4157670-1-i.maximets@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 1141A49845D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282454-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,davemloft.net,google.com,kernel.org,outlook.com,lzu.edu.cn,openvswitch.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[echaudro@redhat.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]



On 29 Apr 2026, at 17:16, Ilya Maximets wrote:

> Two patches - the fix for the actual bug and the selftest that reproduces it.
>
> I missed the self-deadlock in the original patch that introduced the issue,
> because testing required code modification in the ovs-vswitchd to force it to
> use legacy tunnel ports.  I thought I made the change correctly, but apparently
> something went wrong and the tests were run with the standard LWT infra instead.
> The selftest added in this patch set will at least prevent this kind of mistakes
> in the future.
>
> I mentioned, however, that these tunnel vports are legacy and not actually used
> by ovs-vswitchd.  RTM_NEWLINK + COLLECT_METADATA is used in conjunction with the
> standard OVS_VPORT_TYPE_NETDEV instead since 2017.  The code to use the legacy
> tunnels still exists in ovs-vswitchd however, but only as a fallback for older
> kernels and we're planning to remove it in the next release.  I'll be sending an
> RFC to remove support for these legacy tunnel types from the kernel, as they
> serve no real purpose today and only increase the uAPI surface for CVEs, but
> we need to fix the known bugs for stable versions.

Thanks, Ilya, for working on this patch! It looks good to me, assuming you
remove the unused socket library in v2.

For the series:

Acked-by: Eelco Chaudron <echaudro@redhat.com>


