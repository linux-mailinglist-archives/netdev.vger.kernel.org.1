Return-Path: <netdev+bounces-284376-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YArXE9vm+Wl1FAMAu9opvQ
	(envelope-from <netdev+bounces-284376-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 14:47:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F854CDDEA
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 14:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C0C63062C33
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 12:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F2232D7FF;
	Tue,  5 May 2026 12:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="BNWWAMYI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E10248F57
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 12:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777985171; cv=none; b=akYKtpxTWQcL1k6T06TtCPDJUesA21oyMoFlp5FKPYlwF3Zm7nN/nfvhGO4atfuozeAW4UbbU12DLJgDrfZDRF5W0qNf4I5bvBsZyIs9S/gx87asRqYwsPFjCuid0ZwBB0upRQ21nmhyOKhVifAY7UJUfVImVBhR6BP58+vBTkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777985171; c=relaxed/simple;
	bh=Q8btijusTbcegc0sKqIbzuRppMLBoN9sS7wsw7/34N0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cuBy+csocKgkd6nNKNGvIxrbdQmy3Y+PbuMHBJDX/7eiB59pHD6u8W6cnB56ABtAqOYeYc7bONaIgydPrPO5wGdB2rQPrig0Apay+u7zz7ncKiYkvNTTLVSeR2sgWToTmGnBu1vmyp/5/Rfp3qbQexPg7dHePC7IoALJCqZF+9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=BNWWAMYI; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4830b67aa6bso7358905e9.0
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 05:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1777985168; x=1778589968; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Dkf1zWYJ45ADlq6jCOSU1ASv+G9aemZGPgQNzFaPIQE=;
        b=BNWWAMYIFXoZX12qpQ7hLsVwU/KcJXp19soexbGq8VNA+U4upV1g8m0c2SNjQYCPHW
         +dgibYTK/dqM2+IjiYAk0vowleUFnXhLNGzHwNmki3yE6ESJl+Qv7ZP/iJFYsbgzRHqY
         +CgVi780LOmi8EThXIVBtoPX2DR/htxZav0WSx1MU2f6ycsQqttCO5660VDDlXggrGGl
         VAjjGlHH11G5lEGuIVFWe/TRJ+7K4vMuu+QdFYAmy31m7pWymZr6Ak/yOvBtr+9FOD/y
         Uet31M+4s3wx1ekAW3VFP/UrX5l2XjQQFJK68W0+JDllR/Lqw6o77731VeXRIbMmuzkh
         tC5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777985168; x=1778589968;
        h=content-transfer-encoding:in-reply-to:organization:content-language
         :from:references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dkf1zWYJ45ADlq6jCOSU1ASv+G9aemZGPgQNzFaPIQE=;
        b=iyKFdK4QAImsAa3Dw2oHoVNrfYSMRccZoA725zBg0Xv/8SUjI/E3JfiUuH5HCZthnH
         2mGn8YdIOqYdIES5HlIhmQ0Cn7VBazP4dpoiHBEgqLxmuXeCF7dPRGmjkq43W0U7btia
         J3xnbDnB74XMJIx3sbJbCTDiDynRC8OddisaWNhe8RTaBSR0pJOn74HaqlBxzXNfIsA5
         8fMNMQhnCAXhnU2HK9shIA6XWE4/oMN6MV+hcnzKEVE/+7plgb/FXzHqvrIn8uDaFPD0
         qSaMjW4WbH1lk15SJPADSg6U5dzo8ZekuQCLzQdhtCgK1EiAyqPtxgr9aG3jhqIldYfG
         XOTw==
X-Forwarded-Encrypted: i=1; AFNElJ//C9ewSJlsCYcrzF/NsyUSHpxqApYO4kg68v3bC6C3fIGc9iZB2Xj8gHcjoAoyf+o3Q8a4i88=@vger.kernel.org
X-Gm-Message-State: AOJu0Yytk6Ue7t51GztEwTEYZCwwnyKys61nroquVRQVqjwoTyV5gVdT
	1XCzGu2zMCqx5He6k6FJBLvTTE0aLuQ5h0UU/Gb1wPk13SDNCuh9rzhFBWp7NwVYIgs=
X-Gm-Gg: AeBDiesuAA3I5nnHenuMtFdvqrrIkx/Ih+TtbOtSQhCwYdHhauOZpyEG9pot0LiZCW9
	WPP5rPx1VPr4QfBYZ7UBXJRXB8439rpJv3htSKmOv3qZ6YdKnhmUi7SE0HqANkWp0Fdz89hwJng
	KPE9S3MU+UqDG+mfHa2pyzkr+eZlDHnO+K78ZMXuZf8HeAeR/DkAjszfCjvca7OUQTaF3AVgSyz
	7oBbQDbdFK39eR/4xitbbyfiAqibW0JpijfnxZGy4CIhoFbSCendM5XynV7is2tjapZPIUkslBq
	YQWRl/EPN0iEXiw4tC83wts4SsGUEbul/ETcpzK/tCO6skTkAl9GNoyBQi2fn1z74oul+M5SzEw
	YiGQ6L/6Qh1xhi1B5XxAI0WETg/3DYhj3VRpit2Vx0wiMzf9Jhimy4bVNfp3MDSox7ZyPELuYCm
	dHlRLc6iEdWo6/+o2Bgfg2wd3D31CMCKsitDvaYfm8Vxvm20xmWuGTkfiyNfCM2s73i3SMlLX+2
	ZNcMq4fZ7CuGC4=
X-Received: by 2002:a05:600c:8b27:b0:48d:1021:e5d1 with SMTP id 5b1f17b1804b1-48d1021e782mr58724545e9.3.1777985167877;
        Tue, 05 May 2026 05:46:07 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:6a1d:efff:fe52:1959? ([2a01:e0a:b41:c160:6a1d:efff:fe52:1959])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb694fcsm372520405e9.3.2026.05.05.05.46.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 05:46:07 -0700 (PDT)
Message-ID: <7efb0d25-aa70-4e0e-b97b-d1dce52b1672@6wind.com>
Date: Tue, 5 May 2026 14:46:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH 1/3 net-next v3] ipv4: centralize devconf sysctl handling
To: Fernando Fernandez Mancera <fmancera@suse.de>, netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 idosch@nvidia.com, dsahern@kernel.org
References: <20260504123143.6284-1-fmancera@suse.de>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Content-Language: en-US
Organization: 6WIND
In-Reply-To: <20260504123143.6284-1-fmancera@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E9F854CDDEA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[6wind.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[6wind.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[6wind.com:+];
	TO_DN_SOME(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	TAGGED_FROM(0.00)[bounces-284376-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_REPLYTO(0.00)[nicolas.dichtel@6wind.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nicolas.dichtel@6wind.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Le 04/05/2026 à 14:31, Fernando Fernandez Mancera a écrit :
> The logic for handling IPv4 devconf sysctls is scattered. Notification
> and cache flushes are managed in devinet_conf_proc(), while a separate
> ipv4_doint_and_flush() function and DEVINET_SYSCTL_FLUSHING_ENTRY macro
> is used for properties that solely require a cache flush.
> 
> This patch refactors the sysctl handling by introducing a centralized
> helper, devinet_conf_post_set(). This new function evaluates the changed
> attribute and handles all necessary operations like triggering netlink
> notifications. It returns a boolean indicating whether a routing cache
> flush is required.
> 
> Note that the boolean is necessary as this function will be re-used for
> netlink IPv4 devconf handling where the cache flushing must wait until
> all the attributes have been processed.
> 
> Finally, this is introducing a small change in behavior for
> IPV4_DEVCONF_ROUTE_LOCALNET. As commit d0daebc3d622 ("ipv4: Add
> interface option to enable routing of 127.0.0.0/8") intended, the cache
> flush should only be performed when ROUTE_LOCALNET changes from 1 to 0.
> Unfortunately, this was not true because while implementing it the
> DEVINET_SYSCTL_FLUSHING_ENTRY was used for the attribute, making the
> code related to it on devinet_conf_proc() dead.
> 
> IPV4_DEVCONF_FORWARDING is still being handled separately as it requires
> more operations.
> 
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>

Reviewed-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

