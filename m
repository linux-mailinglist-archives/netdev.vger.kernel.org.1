Return-Path: <netdev+bounces-282515-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uM4QLFx/8mnarwEAu9opvQ
	(envelope-from <netdev+bounces-282515-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 23:59:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D67149AC19
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 23:59:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 40ED4300A514
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 21:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC18A396D06;
	Wed, 29 Apr 2026 21:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D50oExMl";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="aHxS8Rcc"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BD5387375
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 21:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777499990; cv=pass; b=VQ89TEaRmLn5lduoiU722p4S/RvEUtw2RP9YCwxOwTDYZVLzKcgMxMxOl1fec4GIm2e9xWHou8G41UDpuN8W/bqUR/31T6JRTgYs5dVuHubaYfQ1CxWnvOS7c54PPP30uqyC5E2EZnnNt2F32mQRR6e4Aqe9zpyj3/X366TXGIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777499990; c=relaxed/simple;
	bh=ckU6BlywLCQn1zkVJ+Ykqm5HURqPnfgSidoz4ywj2cE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j7f6BisxrXNFnnGPIjmFmLVQPv6m95kwqTFqYoB3yb9E3U/jFi8aIecHztIGgDT4Tr62L4M+6NuHxw8BFlZjl23/CEsaqRLJGk9ljYupDmV55Jz6fFXUq6ZH2l2UAzlB3u5zQDu4km0M1qEpAA0K7fsaHevEAbQgpUE0kRWi8zs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D50oExMl; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=aHxS8Rcc; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777499988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ckU6BlywLCQn1zkVJ+Ykqm5HURqPnfgSidoz4ywj2cE=;
	b=D50oExMlXNjD8PfiiUiER9KwcqFoEs88kmbvwTgAGSLN95kk1uwwOEQmoW6O4kHPTW7dhi
	HFIYfSYFvnwec7V8uUmrVXeyacwbfWytuMT1CNASgLJ0WV9VaZp3SEJwE17kk71EYPl6DS
	H1g2txp5+2DSZfHqRxQaGNqE8lnjc1g=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-R6GMHDNANMaP-qFA3_ACUw-1; Wed, 29 Apr 2026 17:59:47 -0400
X-MC-Unique: R6GMHDNANMaP-qFA3_ACUw-1
X-Mimecast-MFC-AGG-ID: R6GMHDNANMaP-qFA3_ACUw_1777499986
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4728b95f695so76163b6e.0
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 14:59:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777499986; cv=none;
        d=google.com; s=arc-20240605;
        b=Uz23tg8s6l2j5OqejnzwwC7U/cHYvWes0Lezni3l2S97PJ8QrBxEMkA8xf8Fkxiyfk
         jjiMcbgOAg/ggjlEP2yWVFyJG7d7QI4ZP/bhXhpmiZA1c+3iO62HfmgcuLUlCFpPCCVk
         0FKgicpQ37YzE6aeG1CQfN9UJbkXuhuJDw3DT5KT0NBfmQXhvoUm3QqSTRCSHhyCQYat
         JI9bjw05vm6J+2xFgAWIvGETDxtxfdMQwo4Bfxj+hFbLQELS9atLHFFr4IKYNWa0bh4u
         cBXtUXsoPnPQcGtZdq1jbKtNh3VnjInL0+IOdA2qGIX64bBTxSUzGHPnKG2lV/TzCszN
         XBXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ckU6BlywLCQn1zkVJ+Ykqm5HURqPnfgSidoz4ywj2cE=;
        fh=hNHI46qM68lLxOuNpM7iE9QJX6tCK8rhx6y4+WNDFVk=;
        b=NJdgrwTR7kEJWpodXiwsFo8Jw4zWFW96u29VAXNFRbr3hsSlKz8dhQoiLofCDWLGak
         11QK3PUwbOfndZzgSC3jxAL7CrgjiydwmyAv6SZcARJfbaJg+ocdWOGUw2/SgxXMfxki
         uc+FdCNVldsHXVZyU2dTac18WKR+MGXSzOyqw04KLt2pPsaL0Vcj89G9CLuD0L/Pydep
         DLtL2vh2Th78LkZMJVADGTSLmM4fsK77RCigNKuA/SxTR2S1nCMlAoJGGvuvk0JB6apj
         F418j+KXTvcciCNckiB1vITyExag9Fmnm4B8ItIm9KUxpRiF2368hIjlqeuow6N7whMo
         Bw7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777499986; x=1778104786; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ckU6BlywLCQn1zkVJ+Ykqm5HURqPnfgSidoz4ywj2cE=;
        b=aHxS8RccDr40zDLBHIAIedRtmmustF5d0uRSUdWCzlLhZeT8B3izI+d8TB6vmisNVJ
         9CoB44zF/jddyFHlUnA2WK7qMQsGAPf/n/8797tr/q+2mjcURyXRT4rirPLS0b2NDSpr
         HGrX2iGfoNX1snbd3gF8klhdbP2hDq1QL+evcG+Lw0ZpWzhBOl1Eb3ESuwlgGW+k28Ds
         gj3ZZmFS6xMlFEHPx2R42t2cX1W/S7ZZWtZqvQKFtlX+v/amGMkhzWk76ReTOzRkiSuO
         aIzKMMfRkT+cXvDKaSYPFM8Q6dVeAAGPWUovYTQlliugkLuuRDzKD0bvShoHW7FDS5uK
         8AQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777499986; x=1778104786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ckU6BlywLCQn1zkVJ+Ykqm5HURqPnfgSidoz4ywj2cE=;
        b=UZBQWgJaNbjhLelCox0A5OBuIZUlFgNvAQuhZmz4aBCsNOK5yIGwl0PguJRLWkdXXm
         3FPYX2jV5KF3+YGag30x97brSkoCpfJQryqmJbCiXcEVs0DbXHCfnBwAu+A9BiMgTpHX
         Yvtt7QFh/r9/hVDqJJzX8Q2l872cSJHdLSam9u9dhDxG9en0t8eJbN22ulZg3r4z70XB
         JKue1SrvJEbb0jW/CM7V9O7M1gEwA9kMsmrTIbIzKa4tZk13Q4DYvIcrC1zHJC1SDXNm
         bbZkBXUDZGP6XQ8Q+7+npWCOWnzxqWm6iWdv1kgi7ryd2qGksjQCcClKYOG3DIkpg0W2
         ZFPg==
X-Forwarded-Encrypted: i=1; AFNElJ83wmWUEeTphEilt4CaQXf2BZFVQ5cdiWHr0sUP/aXGU13qanjx7o/bCe+3ntOxzXS6F1Dgtjw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpMCcuBB+s5yhzZCvIjHcApIakSUG2tkyT/6gitokZ2eNBnBmF
	q6r23TIKKh2AVmHrk3Xz7BF0fFF6KPVNuVtRp7yO0LVss1Tr8KBKDozSyv5mm39uRCxqo7a9u/d
	xgQMeSs8U8fER+UN+EWR4eZ+RkVoaMbqcz3DYTsdTlqTGkV4sLqDqmcOLo+/eBQ5DsqvYuG2eM2
	nXb/Hby1T7nJpQDhvxL7rEv/o8uNfzOPlH
X-Gm-Gg: AeBDietRKZUk7SrHd/OkmIpEnMj2lYUt582+byTaBcFI4uFlwZWQ5i54VgcOc9xhbgU
	M4eR2YY3aS0twUzG9nIKa5F3k1l8J5XwfRsjTJ0lkqTuHwJfAuon2+2VRICfGUOsW7GMVo/AJH9
	P5KbVu9GumeQx/+dcISoAeGeonTetowf18G8DoKucq59nlPKJJ9KssT0iCAUT+nbMPohro7E9k4
	VAwdWwO9qqFrkWC
X-Received: by 2002:a05:6870:312a:b0:41c:9f58:baa4 with SMTP id 586e51a60fabf-43433778db8mr193024fac.1.1777499986247;
        Wed, 29 Apr 2026 14:59:46 -0700 (PDT)
X-Received: by 2002:a05:6870:312a:b0:41c:9f58:baa4 with SMTP id
 586e51a60fabf-43433778db8mr193014fac.1.1777499985793; Wed, 29 Apr 2026
 14:59:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427151827.43342-1-mschmidt@redhat.com> <2106884f-6914-437f-84eb-262581b9fef7@intel.com>
In-Reply-To: <2106884f-6914-437f-84eb-262581b9fef7@intel.com>
From: Michal Schmidt <mschmidt@redhat.com>
Date: Wed, 29 Apr 2026 23:59:33 +0200
X-Gm-Features: AVHnY4K7QDn2acJZ0UOfycvXxeY_tNPK4c07I89nHPRJ7kapJLnnMkA3FK5a2Bs
Message-ID: <CADEbmW0BsQsu1pPX=kk58tTz_5EArjCKgmp_MKxRFcuvb3TDGg@mail.gmail.com>
Subject: Re: [PATCH net] ice: fix stats array overflow when VF requests more queues
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jacob Keller <jacob.e.keller@intel.com>, Petr Oros <poros@redhat.com>, 
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 1D67149AC19
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-282515-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mschmidt@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]

On Tue, Apr 28, 2026 at 4:00=E2=80=AFPM Przemek Kitszel
<przemyslaw.kitszel@intel.com> wrote:
> On 4/27/26 17:18, Michal Schmidt wrote:
> > When a VF increases its queue count via VIRTCHNL_OP_REQUEST_QUEUES,
> > ice_vc_request_qs_msg() sets vf->num_req_qs and triggers a VF reset.
> > The reset calls ice_vf_reconfig_vsi(), which does ice_vsi_decfg()
> > followed by ice_vsi_cfg(). ice_vsi_decfg() does not free the per-ring
> > stats arrays. Inside ice_vsi_cfg_def(), ice_vsi_set_num_qs() updates
> > alloc_txq/alloc_rxq to the new larger value, but
> > ice_vsi_alloc_stat_arrays() returns early because the stats already
> > exist. ice_vsi_alloc_ring_stats() then iterates using the new larger
> > alloc_txq and writes beyond the bounds of the old, smaller
> > tx_ring_stats/rx_ring_stats pointer arrays, corrupting adjacent SLUB
> > metadata.
> >
>
> thank you for reproducing the bug, it is exactly the situation that
> I was facing
> have you tried with my proposed (unfortunately not public yet) fix
> to just combine ice_vsi_alloc_stat_arrays() and
> ice_vsi_realloc_stat_arrays() into one function?

I tried that now and the result is: yes, your patch fixes the bug too.
Michal


