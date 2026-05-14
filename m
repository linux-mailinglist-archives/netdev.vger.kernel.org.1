Return-Path: <netdev+bounces-287893-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0D7ILaubBWrAYwIAu9opvQ
	(envelope-from <netdev+bounces-287893-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 11:53:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59876540030
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 11:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8D2AC300B1AF
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 09:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8C43A1CE3;
	Thu, 14 May 2026 09:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MNDX+nEg";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rfz4c17j"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E13A395AD5
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 09:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778752424; cv=none; b=sO+UGJz50horTU+7IG4cgGMRFHB/hMNuDaVrhQaJs1UgdL4ByEihiaHmz8Yw0lWhw0LymGsQxKy1qiV6/XT8Ei2ZV5rgpJkZ0DjOSusaclR1lFFhDbmlf9M6yreZiXCbsZHL+otG2aBY8fEzZMx5FzyINjpcYMqt6WlrTfu4mKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778752424; c=relaxed/simple;
	bh=QrjK6BQ59ep/1bMn2obVpOo9paaD/nkuAL/gEMrLF8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mM2FZEc1ybtsU7iGO2KxuBMB482OyVsm0+BucJjTw8/SM+wcViJ5+qBxYRQOvToHt7ftbCw8aBlSU62uE2GZyjX29znnkN/NWND3TPSHRMGBKM51PKFaS4pHzwGrIsfYcXfFTRCnjl6dQG5wZZjG+NWZdA7MHdVOBc+xqGSE1hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MNDX+nEg; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rfz4c17j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778752422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I0se+N3hFO2P7mdYqzi9ilKsAjBpW37BH2P7iQnnZDk=;
	b=MNDX+nEgmKXLXcIYCJl3igSoO0D+obFAcP0uvHiEZmS46d8o7uD+hW8SrO2jhkjza2LVJb
	Rc4AtjZEzIxxssxYl2vphnyWO3+RVHG4sBNim60xmthqqVFi8/sGq6MSa9AhRBDKDlDFAf
	0vfJdV2BdNonrTC9WHmGeNojz9AnnJ8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-wOACrYbcM3mkhD1YX6II5g-1; Thu, 14 May 2026 05:53:41 -0400
X-MC-Unique: wOACrYbcM3mkhD1YX6II5g-1
X-Mimecast-MFC-AGG-ID: wOACrYbcM3mkhD1YX6II5g_1778752420
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-48fda34ed0aso3045755e9.1
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 02:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778752420; x=1779357220; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I0se+N3hFO2P7mdYqzi9ilKsAjBpW37BH2P7iQnnZDk=;
        b=rfz4c17jyomiL5Q/6HL0BsLcxBtuwOiAXbQk7z8tvJdAZ9rXR1jL2h06zWzqF83T01
         HWH0ITtlTeKqFOf/tJiKR9ZA/W/jOR+EOQkQhRaxWrT1ym6Os/k4vrgmYr5WiRg7/Glk
         lGObzeqXuU6v+QBffl2807mgMsOyp5vZqOE/AoqEH69prxKG+huiyUu8pD8LL7D1wyJe
         w6DYosDIHpm2hxBMCIVPn+8Kar+rnbNMj6N7oy2TK+0wJRaIm9IfaBi9HX5BQsaikosf
         L8WTufrMeFFbw3qBd9bGvlyeJA7nKZIOx8wYrXEJuuTmKRXsDwsIbr6MvVnVzrasJQhn
         ibPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778752420; x=1779357220;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I0se+N3hFO2P7mdYqzi9ilKsAjBpW37BH2P7iQnnZDk=;
        b=d3zv4AN5enLAAoR/bLfLEt05Zo5H9+z780LtJzQlfqrZAbabNSYHsrWW5ZQEewcmq3
         eIAI7ZLLLiEiRu4w36BxDAlNC75csCrRdKeGwnovzk/tu1p6K9HTUe0fe4FxmBFziahT
         xPiKM+mg5MI16eMQhuMr2SHwU2Dg92M/HNvVLJYyzf77JVejrxaDNBgHgVNDMFNbGRBS
         v/HPNcvOY6Ouxar/TSc9VfqzeKpPgZ/j4VwRtvZwveOPfZDke9E/teGTl/9fWYzkboT+
         y3STJ9G3vh97+6qL/XOYCgnzz2Gn5TZqNsQ51ypLOZXSEszv69aDTXyak18mWyWzzW4d
         VOSg==
X-Forwarded-Encrypted: i=1; AFNElJ/Pd443yn5+99C18LlnNJj3heZMLtDba+wgQ3dzH3b1K/MJ/EdQoRSCAEh/DGjcCSOwqsK7CZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoPe1KSuMFgh0ck7SFYn/aKB+L4TRFueo3KsaFLZISV6/N5nZc
	xoz3SGQylZgXctX8zgLO51iLNzJM6ZY9ULRglKInuvJX7bGdRreSYDgrfxCMaQHep3GwcunKMSh
	y0zRH+pr2x/2ozKD7qqb5gyf7ChwKae6RjHUrIIFhWi+O5PK4j433WLUMDA==
X-Gm-Gg: Acq92OEHWUtgxNx9dqZmpfZP2/3QVAI9hl80WmWMyEUU7jMPPdsIsMFsAqyTd3GE/FA
	uBm2tohwzTfcFbwN9aDtdUkFmPGp9SKcY0ZP92vF8qMRa0h+4HZwcUl7AXUgxq/Qg43Vs5+wYgx
	Ta+zVDG8Km312Zxh/XSibgPa6vX+OAQaDrjD+vfghz+fShQ8EMq0e+8Un/hdTpumpKiJjVdPeYH
	YVJoSKmDcFVz5p0gNFOkY/DYAXKSjW446emOH9oMV4vFT4FLwqJALZmJ59whR56zdwSLdcZDkcJ
	dxnkJSwhhDjeSrr136z42M0JD76wlyPegQkbFdwMFyGQYt6ZSI7MG+cWGqAhBhOMchjYVN0EaCU
	WXeuBtBoyj7EDdrFkyykB/SAc9tVhIjFpRZWKTrNm6+MOcl41HuCFGss=
X-Received: by 2002:a05:600c:a11a:b0:487:219e:42d with SMTP id 5b1f17b1804b1-48fc9a143afmr81776855e9.11.1778752420296;
        Thu, 14 May 2026 02:53:40 -0700 (PDT)
X-Received: by 2002:a05:600c:a11a:b0:487:219e:42d with SMTP id 5b1f17b1804b1-48fc9a143afmr81776595e9.11.1778752419903;
        Thu, 14 May 2026 02:53:39 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.9.106])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fd6498a7esm50954115e9.4.2026.05.14.02.53.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2026 02:53:39 -0700 (PDT)
Message-ID: <a0d4052c-2e8d-4dec-afcb-c8050f5d1ac7@redhat.com>
Date: Thu, 14 May 2026 11:53:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/8] net/mlx5: Prepare eswitch infrastructure for
 satellite PF support
To: Moshe Shemesh <moshe@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
 Akiva Goldberger <agoldberger@nvidia.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
References: <20260510053448.326823-1-tariqt@nvidia.com>
 <20260513192539.7fd96592@kernel.org>
 <639580c8-f93f-4945-acfa-ff116b841f6a@nvidia.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <639580c8-f93f-4945-acfa-ff116b841f6a@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 59876540030
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287893-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/14/26 9:56 AM, Moshe Shemesh wrote:
> On 5/14/2026 5:25 AM, Jakub Kicinski wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> On Sun, 10 May 2026 08:34:40 +0300 Tariq Toukan wrote:
>>> This series prepares the mlx5 eswitch command interface and vport
>>> infrastructure for satellite PF support.
>>
>> Could you perhaps start by explaining what "satellite PF" is?
>> And how it differs from "socket direct"
> 
> Satellite PF is another type of Physical Function, its role and 
> privileges are similar to the host PF, but unlike host PF the Satellite 
> PF is on the DPU and not on another host. So it's kind of "Satellite" 
> for the ECPF which is also on the DPU.
> 
> The next patchset will introduce the Satellite PF, while this patchset 
> only does some preparations. Small changes to prepare the eswitch to 
> manage another PF.
> 
> While Socket Direct is a hardware PCIe topology, that adds another PCIe 
> link to the NIC, the Satellite PF is just logical entity, by firmware 
> configuration, no hardware change.

My understanding is that Jakub wants you to capture the above info in
the cover letter.

Thanks,

Paolo


