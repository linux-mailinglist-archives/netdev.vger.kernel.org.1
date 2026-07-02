Return-Path: <netdev+bounces-304088-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SgVpJUpCRmolNAsAu9opvQ
	(envelope-from <netdev+bounces-304088-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 12:49:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 338C86F62F7
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 12:49:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=bbYSEosO;
	dkim=pass header.d=redhat.com header.s=google header.b=oastiVx2;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304088-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304088-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D5BAB32F382B
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 10:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D888480348;
	Thu,  2 Jul 2026 10:02:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2767F47CC69
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 10:02:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782986538; cv=none; b=Md20FBhI/OKHJMFcQfiGNWT/nqjowRXL9BYjwltaNOEezlXNtM3ooitedKjuKHztykmLlWQTwW01uW49o8RwFDoLTM7vTfjVwjBBJFZGUmgWwpG/wbMYV5zEBurzgtvM0XFD5WRa8rSzYWKbhNyOUbkZGrxzZQwSV7jmxiiIgIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782986538; c=relaxed/simple;
	bh=l/4zG+3D9ejOnVWvPH58fKkY+gswQsvE7oQpLDlZzVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gAtsUdHm6m0Skyp+H79N6ptKjNPrafrOhCgUbTSXM2HQgKDYzU+NXy8ueBtAgGrnPB0ibhhzG20yPhjD35R0CeTMnb+myhUgydHGQl45nxXlKuRZLNjmIH3JsmXMEmQ8UPzNdX5rs1cI737o5Llz9byG73QBdpaS+YZN16CQib4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bbYSEosO; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=oastiVx2; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782986536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LfUu6pC7EJB8qiPkqY3N8+Svxs7+7n13Ik8Ta0Guoyw=;
	b=bbYSEosOy8AjqMocITXesieDvAiWM1eA9XF11XRWdBMg3U3Xypz9x+N/4U+4bLlcK7FQzj
	vmsYI7+CrDIc6lNvJrM7hAZPRvGs3dEaCncdUWSVd7djyXbjnSzNkwS0gAbnRKte2QovBk
	XYZc4dRyUgXfF55CeS3/H5/dAWYPrrI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-5QhWY2A-Na6qv8_qMogjwQ-1; Thu, 02 Jul 2026 06:02:15 -0400
X-MC-Unique: 5QhWY2A-Na6qv8_qMogjwQ-1
X-Mimecast-MFC-AGG-ID: 5QhWY2A-Na6qv8_qMogjwQ_1782986534
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490a767b782so15315335e9.2
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 03:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782986534; x=1783591334; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LfUu6pC7EJB8qiPkqY3N8+Svxs7+7n13Ik8Ta0Guoyw=;
        b=oastiVx2aWNgeMvEzBzlDXTp2ULJOG/l7LYkAbG+jAOtHz8SUtTId7wAaMBI1ggp5J
         OWjur+qphQ8MZjdkYQDqQpqnY7zXxkwPETVtoS2/1d8a39uFAJpLG5vmbuqYPWj0HjTc
         j7NU0NzCdGzMYlP7oI40QD9vMonxi++xemoogK+nqJ/S1CIwFwaOzj71aWwXqpa8EmrR
         bNwSK7xwGq4mTXih5i0KMlYoz1WiBL91SGTyqFHafq5ba5a9/LKViSZwW8XuR5FEZe9U
         +Ht45Jc1IBRrbbiTz85wwz/3NMaod8ViFir2t3OtX3C5unzc8GPvLaRwBBEUfGXip8k0
         XTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782986534; x=1783591334;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LfUu6pC7EJB8qiPkqY3N8+Svxs7+7n13Ik8Ta0Guoyw=;
        b=B7iUFc+/z7KDXAR8FGWUtbgYZgz/diUQp1KWZhrEJg6jwqvLkNQa+fA52IXSfnXabo
         ZucIfL2RUU1xvr4LQCw9k6xDBQ92DsOwQBG0kkJmAEaoh9doQn4emMgdAUXU0QjzIbqp
         XZuMsdHOqSu+wICfRFTgdPPuISG7v+SVWZ9GBgpUR+dPZGTKbQYxM2pY1nt4jJLIAAxh
         9KaaM3ulgb4bDhBrrbF6FSjEBPq/ere8baCAoURbjYPL1BUcktLPv+kUpU9y5ZXmypg7
         Y/0XvKbS2/Ia8dAEejWd2mYfumf+A5SfIBF+KoeJxJkS81/aiPUnKop5wSkoCWY+jyg5
         nDRw==
X-Forwarded-Encrypted: i=1; AFNElJ+R5kpv12ca7tgs13pOx4i6WFlwFnLe7ZdgHx07dX6PFhSSk7YxfA9zo/RwQxjy+3NreVezYTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxarSsZ7cOK+NW+97jGBceyreFrAToYCDVMl9KrQWMffsTG2Den
	nL9SIP/JN8DwwglISk1rHFv5A+BawGsQxLOqANOQhcyDxieq/48k3fbL+JpHhxv6d8ZLVQAA3im
	hPeuelauGTudOtuAtJmDDKAJ1fSOUrPfGk4zXJ1yw5TQLGHGEmaHhoS3KRA==
X-Gm-Gg: AfdE7clYRCzCMCwaZe+KI5qxeZ1bOaGJctVS8V/8ODN5YZ9wSHoVerQjazr5gWnlzH8
	q/qMfuh41ruVbYik1rCLVozPKrb58OM4iQuyqazYZFe1GST5IQnqfwtGtz0jTH6RlI8IKbl6yDX
	X1eZIGCOJirm4aAbFnXKOZJ62PzdjE+k8iymS7dwPO0FMnx3yKAP4P9aTzg5/zHqB+Eyz7dxZ6Q
	ujTNQMyrq5dHb4qm57qMQTNLyJF96TPSw8u3/nPig1RSBqF4PAP49hSfSNh3WbnRY+8aTlEOcp/
	cU4c463rMreArn4wYmQW8jmBweHYrVSqkzrt2hbSjEQC2DBS6vcpGEPfCheb3DaShvwTBfLgfTh
	AsB3wjuM5l6N3QpQUTpXvxzbxNMZs4z66dV5UCxgElDSOJmuuSr1jwNl0olr0RZ0p0cmDvfWaZ2
	VPa4JiLCtdtw==
X-Received: by 2002:a05:600c:1547:b0:493:b729:3a9 with SMTP id 5b1f17b1804b1-493c3cfb04fmr58962495e9.27.1782986533638;
        Thu, 02 Jul 2026 03:02:13 -0700 (PDT)
X-Received: by 2002:a05:600c:1547:b0:493:b729:3a9 with SMTP id 5b1f17b1804b1-493c3cfb04fmr58961865e9.27.1782986533117;
        Thu, 02 Jul 2026 03:02:13 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:2eb7:f61a:75:4534? ([2a0d:3344:5521:6b10:2eb7:f61a:75:4534])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493bef17c82sm80193455e9.1.2026.07.02.03.02.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 03:02:11 -0700 (PDT)
Message-ID: <3f540a8a-4167-4727-9516-6fb91335333f@redhat.com>
Date: Thu, 2 Jul 2026 12:02:09 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Subject: [PATCH] net: gro: fix double aggregation of
 flush-marked skbs
To: Shiming Cheng <shiming.cheng@mediatek.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 willemb@google.com, daniel.zahka@gmail.com, alice@isovalent.com,
 sd@queasysnail.net, eilaimemedsnaimel@gmail.com, imv4bel@gmail.com,
 nbd@nbd.name, dsahern@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Cc: stable@vger.kernel.org, lena.wang@mediatek.com
References: <20260630023512.26927-1-shiming.cheng@mediatek.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260630023512.26927-1-shiming.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-304088-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[mediatek.com,davemloft.net,google.com,kernel.org,gmail.com,collabora.com,isovalent.com,queasysnail.net,nbd.name,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS(0.00)[m:shiming.cheng@mediatek.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:horms@kernel.org,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:willemb@google.com,m:daniel.zahka@gmail.com,m:alice@isovalent.com,m:sd@queasysnail.net,m:eilaimemedsnaimel@gmail.com,m:imv4bel@gmail.com,m:nbd@nbd.name,m:dsahern@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:stable@vger.kernel.org,m:lena.wang@mediatek.com,m:matthiasbgg@gmail.com,m:danielzahka@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 338C86F62F7

Note: the patch subject is quite uncorrected

On 6/30/26 4:35 AM, Shiming Cheng wrote:
> The new skb_gro_receive_list() function is missing a critical safety check
> present in the legacy skb_gro_receive() path. Specifically, it does not
> validate NAPI_GRO_CB(skb)->flush before allowing packet aggregation.

skb_gro_receive_list() is not very "new" and definitely
skb_gro_receive() is not legacy.

> This allows already-GRO'd packets with existing frag_list to be
> re-aggregated into a new GRO session, corrupting the frag_list chain
> structure. When skb_segment() attempts to unpack these malformed packets,
> it encounters invalid state and triggers a kernel panic.
> 
> Scenario (Tethering/Device forwarding):
>   1. Driver: Generated aggregated packet P1 via LRO with frag_list
>   2. Dev A: Receives aggregated fraglist packet and flush flag set
>   3. Dev A: Re-enters GRO, skb_gro_receive_list() is called
>   4. Missing flush check allows re-aggregation despite flush flag
>   5. Frag_list chain becomes corrupted (loops or dangling refs)
>   6. Dev B: TX path calls skb_segment(), crashes on corrupted frag_list

I can't parse the above. Is this something that can happen with in-tree
drivers or do you need OoT module to trigger it? In any case please
clarify the actual order and the involved driver. Possibly a stack
strace leading to the critical aggregation could help.

> Fix: Add NAPI_GRO_CB(skb)->flush validation to the early-return check in
> skb_gro_receive_list(), matching the defensive programming pattern of
> skb_gro_receive().
> 
> Fixes: 8928756d53d5 ("net: add fraglist GRO/GSO support")

The fix tag is wrong, should be:

Fixes: 3a1296a38d0c ('net: Support GRO/GSO fraglist chaining.')

/P


