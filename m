Return-Path: <netdev+bounces-280541-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPpYMuoe6Wl+UgIAu9opvQ
	(envelope-from <netdev+bounces-280541-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 21:18:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7922344A164
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 21:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E0097308C959
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 19:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A128A36CDE0;
	Wed, 22 Apr 2026 19:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G5kKOSPY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mlpT3hGK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198C836D51D
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 19:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776885456; cv=none; b=fsJwRMKZdrStT29PJ6Rp40g9zjzcu09dzYtOuxcFGmDEMXlaJAI/QeaIqDAEdfvggc5Y27Md3DWTmFjFs5xW4Ge82Mm+nEZ5SwG5CCV0ARV29Qq5gOF/8PKTzeZI7PXA9mYA2GN7q/hXds6AiY3l6ZGc5tQLGOCrdiFE9GUC/hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776885456; c=relaxed/simple;
	bh=6xwAF6LQhdvQWGciR8NgWuvUr+MpJGOUxwxYpgWHEt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pc46KM10u61De9kUlQGgsmy4eqZobwdoL6L9r6DENQXzbvlHRKLYzjWRon5/Y63YO6CFBbrI2Ro6a5baAqhhZrffhAqOAvWh8dIZme+nfk+b5vf5J1/DjEh6KtBNOaAFTEl1QSqDWvHcKdSuNA6DqdObFlMX2Q3mhjzX5EBQNeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G5kKOSPY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mlpT3hGK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776885442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c58WyJAsGl6Zxg673v15wl6Ol9ueBA67C9y/ZIOdNaQ=;
	b=G5kKOSPYa6q3xP3h7TCZDEpkIhYGbOCpgBlUC5hx636IydIZWhx2ImBVxR/7PHJLXB6bJo
	SvFjFLxqz91f2iu6ezsKSAAyXIeFKRT9FFo4+wp4bhHyjqz4KAofCiw22Jz1EejYzJEBSS
	+zqUequ81dwn4hd/Cc425MzX1ZJSdoE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-fI_roMzUMbSN9_lnIR8Xzg-1; Wed, 22 Apr 2026 15:17:21 -0400
X-MC-Unique: fI_roMzUMbSN9_lnIR8Xzg-1
X-Mimecast-MFC-AGG-ID: fI_roMzUMbSN9_lnIR8Xzg_1776885440
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-48a55de6fb0so20489345e9.3
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 12:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776885440; x=1777490240; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c58WyJAsGl6Zxg673v15wl6Ol9ueBA67C9y/ZIOdNaQ=;
        b=mlpT3hGKvoodnx0UB/ptVDAUML0sJn1An5jX10fAd7L0s2NY/yvhxybWUcxJfxm3Vc
         njwPz2gvUv3Xm6YtskBlLZHdCb53kTzRy9DDFTLEO4uIAIGoFNll26JzPNDpCF4NPXol
         snIu7wcDyCyNKMmR8SFwVh898AW9Um4QuIWcX+8jvWziUoeeF3K9rL23HUxIa85SCC3Y
         XqkZnxodMGro6Su8K+zhf5fyN9SzKxm/RPQeG1JZyRvWJY3fiJhfaljo0eYxQu+GAH6z
         +N2Y5xaMc0D6JUnGa++r7qP5KSYTNLxEf9+bnuJMZry2yGxdj6BT/W/GViDV9WfR1XZM
         sa5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776885440; x=1777490240;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c58WyJAsGl6Zxg673v15wl6Ol9ueBA67C9y/ZIOdNaQ=;
        b=U5s/jWOOGruyuUGQ09f/0DM+QBLPwhsjyaNbHVr7fakuemznoCzp6rLnKt2LrwEbeP
         HU1qUiC05pL60hEWkFek7GcyW4FgH0UhwLXFIMrQcy0tDcUFtRQtgvEaJVG7bMjSZIA5
         p6EDxus2xnV8YY+/Xo7Mld0raQmKATucnvjkthtjlHDfiz4mvLN69moT6x3kVUCEMVJ2
         k/5PeupI5AYT/7vFLFBbWzC92YHYG0XS3LWyNOjLEzyzy9pZ9+hFtjHoX6+m5k0Nud7o
         PGxFnRgaY7HhQup9uNnCkO+pRPH0RNRpo+Skt6fe2b2CrJPSryM/IV8T0mSJ88OnOZpz
         5Tww==
X-Gm-Message-State: AOJu0YzrpXbyAgZ6yckliB3wZXFBsk/dNZx2B7kESr7zWfc/flIlyid1
	DownzudZIA9tf/Xr7dRUkHMq+fVh+tgfDcikGKNpeHWrmtcCAcIYK5QyzOKV8ak1sBOgz0vf++d
	DnppKu+oyemoM9+V/67yNMMdIVGJtASpCt8HfNUCfkC9GWHN/gezJIiIu/A==
X-Gm-Gg: AeBDiesZZNvHUGlSVpwSHEqT8NhlExiyGrg9A3nzI5SWpVK1dQpMvL98EsFBELPKEy6
	Ha8KJT+q4K/cIos48Qsu7UdvdXrTUScdNGUD/N/B/tEFCeVqFjdDy6WUqgph92G923U1P4MYQgP
	AwpWFQpLYcDQGlWW5gSHmy7n+UtWN++u370ggAWMVS9P+4RnYPY229fYKa3aeAMaFx2PhUFsgGF
	1fONQ6T7BI0vHiEzaPC3tcmjZj85feTzNHtjB64Wq+gNT9ApJbuo67V3jZuJxz8MoJC2QkAGKBc
	+3G3NOz9D8sDiYJHqiHtWz205icpKd+TQqrldBzR7lSFpSAk9CeC/4BathIdZtK+EXVW5y1ouyC
	zMsigSyY2DlA0fkhAYMp/aXf0+zA19VM=
X-Received: by 2002:a05:600c:2e42:b0:489:1fa4:50c6 with SMTP id 5b1f17b1804b1-4891fa451bamr103358975e9.20.1776885440443;
        Wed, 22 Apr 2026 12:17:20 -0700 (PDT)
X-Received: by 2002:a05:600c:2e42:b0:489:1fa4:50c6 with SMTP id 5b1f17b1804b1-4891fa451bamr103358605e9.20.1776885439968;
        Wed, 22 Apr 2026 12:17:19 -0700 (PDT)
Received: from [192.168.2.83] ([46.175.183.46])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e44f69sm49650997f8f.25.2026.04.22.12.17.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 12:17:19 -0700 (PDT)
Message-ID: <a3243a70-4163-41f6-8337-83da1972f871@redhat.com>
Date: Wed, 22 Apr 2026 21:17:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net] ice: fix infinite recursion in ice_cfg_tx_topo
 via ice_init_dev_hw
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Nikolay Aleksandrov <razor@blackwall.org>,
 Daniel Zahka <daniel.zahka@gmail.com>,
 Paul Greenwalt <paul.greenwalt@intel.com>,
 Dave Ertman <david.m.ertman@intel.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 jacob.e.keller@intel.com, intel-wired-lan@lists.osuosl.org,
 linux-kernel@vger.kernel.org
References: <20260413191420.3524013-1-poros@redhat.com>
 <20260415163003.GP772670@horms.kernel.org>
Content-Language: en-US
From: Petr Oros <poros@redhat.com>
In-Reply-To: <20260415163003.GP772670@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,blackwall.org,gmail.com,linux.intel.com,lists.osuosl.org];
	TAGGED_FROM(0.00)[bounces-280541-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[poros@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7922344A164
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/15/26 18:30, Simon Horman wrote:
> On Mon, Apr 13, 2026 at 09:14:20PM +0200, Petr Oros wrote:
>> On certain E810 configurations where firmware supports Tx scheduler
>> topology switching (tx_sched_topo_comp_mode_en), ice_cfg_tx_topo()
>> may need to apply a new 5-layer or 9-layer topology from the DDP
>> package. If the AQ command to set the topology fails (e.g. due to
>> invalid DDP data or firmware limitations), the global configuration
>> lock must still be cleared via a CORER reset.
>>
>> Commit 86aae43f21cf ("ice: don't leave device non-functional if Tx
>> scheduler config fails") correctly fixed this by refactoring
>> ice_cfg_tx_topo() to always trigger CORER after acquiring the global
>> lock and re-initialize hardware via ice_init_hw() afterwards.
>>
>> However, commit 8a37f9e2ff40 ("ice: move ice_deinit_dev() to the end
>> of deinit paths") later moved ice_init_dev_hw() into ice_init_hw(),
>> breaking the reinit path introduced by 86aae43f21cf. This creates an
>> infinite recursive call chain:
>>
>>    ice_init_hw()
>>      ice_init_dev_hw()
>>        ice_cfg_tx_topo()         # topology change needed
>>          ice_deinit_hw()
>>          ice_init_hw()           # reinit after CORER
>>            ice_init_dev_hw()     # recurse
>>              ice_cfg_tx_topo()
>>                ...               # stack overflow
>>
>> Fix by moving ice_init_dev_hw() back out of ice_init_hw() and calling
>> it explicitly from ice_probe() and ice_devlink_reinit_up(). The third
>> caller, ice_cfg_tx_topo(), intentionally does not need ice_init_dev_hw()
>> during its reinit, it only needs the core HW reinitialization. This
>> breaks the recursion cleanly without adding flags or guards.
>>
>> The deinit ordering changes from commit 8a37f9e2ff40 ("ice: move
>> ice_deinit_dev() to the end of deinit paths") which fixed slow rmmod
>> are preserved, only the init-side placement of ice_init_dev_hw() is
>> reverted.
>>
>> Fixes: 8a37f9e2ff40 ("ice: move ice_deinit_dev() to the end of deinit paths")
>> Signed-off-by: Petr Oros <poros@redhat.com>
> Hi Petr,
>
> I don't intended to delay this patch.
> But could you follow-up by looking over the AI generated
> review of this patch on sashiko.dev?
>
> Thanks!
>
Hi Simon,

Thanks, the sashiko.dev concern is valid. ice_init_dev_hw() swallowing
-ENODEV from the torn-down hw is a latent UAF independent of the
recursion fix here. I will send a follow-up patch that propagates
-ENODEV to abort probe cleanly.

Regards,
Petr


