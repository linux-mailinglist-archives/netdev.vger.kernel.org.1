Return-Path: <netdev+bounces-278978-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wO/JEl+k4GkEkgAAu9opvQ
	(envelope-from <netdev+bounces-278978-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 10:57:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D20B140BE4A
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 10:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FC37304CA5F
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 08:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9934B384234;
	Thu, 16 Apr 2026 08:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="NkKIkdKV"
X-Original-To: netdev@vger.kernel.org
Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76C93803E4;
	Thu, 16 Apr 2026 08:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776329701; cv=none; b=n+vqypitbriEmSSD5fwDbuaN76oQbwbqGEx0BHnNvXEoS5D4XtleYXqMjmW30kpa924BL0W9tId2QSQRyVSQRoN7Fb0OlI8La6/CfULYCLq3aVyTSjwUY8kdF9eIHlb9iYDzjw/aYXdDq8cbHiXisk7fSdzezHbJzjBq+lNBm6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776329701; c=relaxed/simple;
	bh=9IobvFpQbS8xVL4t/3Nn3NBNUu395pAwqYcnMxHAGNg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=O/1GlA9aamQnb8GbiGUodeniDPz3lYfQZdoWLk6dEuxM1h8MVEyT0WgNdFhZ78Ed0QFfyzJKetgdDY2wNZAqwu9zhc96Sbj+hE+Rr+s2fBewYepMWdEiR6GdBMK5JR6bgScN4xTiJaiT95rKcdFHoabExNmyb0KnhmQDLtrjG7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=NkKIkdKV; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
	s=unimail; t=1776329687;
	bh=9IobvFpQbS8xVL4t/3Nn3NBNUu395pAwqYcnMxHAGNg=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=NkKIkdKVZ4fi31ItM8Tvf11CiXJry9lcn8AW+qVRkgp8lSukkUZMgkG1/DIDVZLDj
	 FQscoDR2J+LiRYJm7BWOAT1RzL42rfLD6X1ETF+8Iv49qFV0KfMkXi0+AXCT2pAHPs
	 o9DpEaDWZNF7HhNxKdLnbqYEptjrZ/MrEMEOoFUY=
Received: from [129.217.186.105] ([129.217.186.105])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.18.2/8.18.2) with ESMTPSA id 63G8skqo025371
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 16 Apr 2026 10:54:46 +0200 (CEST)
Message-ID: <73033bfc-4da3-4057-9480-bd977a66ecef@tu-dortmund.de>
Date: Thu, 16 Apr 2026 10:54:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v8 4/4] tun/tap & vhost-net: avoid ptr_ring
 tail-drop when a qdisc is present
From: Simon Schippers <simon.schippers@tu-dortmund.de>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: willemdebruijn.kernel@gmail.com, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, mst@redhat.com, eperezma@redhat.com,
        leiyang@redhat.com, stephen@networkplumber.org, jon@nutanix.com,
        tim.gebauer@tu-dortmund.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux.dev
References: <20260312130639.138988-1-simon.schippers@tu-dortmund.de>
 <20260312130639.138988-5-simon.schippers@tu-dortmund.de>
 <CACGkMEtN9XgYPGHQg4TEWEsa_UcMbcnzO=VaTFT=0Tn4BayMDw@mail.gmail.com>
 <0908392d-6314-4141-b908-6c9a880ba0a4@tu-dortmund.de>
 <cda710f8-033a-4772-b5ce-a2cfddf42bea@tu-dortmund.de>
 <CACGkMEuLqxnz=GtdKp3-u0egkGT_eZUgBBwvvtHcgAYpLJv-UA@mail.gmail.com>
 <3d3274b4-f274-4cf9-9d0f-989d05148604@tu-dortmund.de>
 <CACGkMEsUag4zNZG+aYipHv_PirbKb_rs7DzSOr-NF8ckhUaJOQ@mail.gmail.com>
 <b9d84d88-46d5-4fd3-a5b2-d914f54766f6@tu-dortmund.de>
Content-Language: en-US
In-Reply-To: <b9d84d88-46d5-4fd3-a5b2-d914f54766f6@tu-dortmund.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tu-dortmund.de,none];
	R_DKIM_ALLOW(-0.20)[tu-dortmund.de:s=unimail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278978-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.b.d.0.0.1.0.0.e.a.0.c.3.0.0.6.2.asn6.rspamd.com:server fail];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[tu-dortmund.de:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[simon.schippers@tu-dortmund.de,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,networkplumber.org,nutanix.com,tu-dortmund.de,vger.kernel.org,lists.linux.dev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tu-dortmund.de:dkim,tu-dortmund.de:mid]
X-Rspamd-Queue-Id: D20B140BE4A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

To summarize the discussion from my POV:

Open point: __ptr_ring_zero_tail() is only called after
            consuming ring.batch elements.
1) Consumer wakes up the producer but the slot is not cleaned.
--> I disagree, the consumer only wakes after consuming ring.size/2.
    Then __ptr_ring_zero_tail() was called at least once.
2) Producer is woken up but see the ring is full, so it need to
   drop the packet.
--> I disagree, because then NETDEV_TX_BUSY is returned. This is
    noticeable as qdisc requeue and only happens very rarely.

Points I will address:
- Minor nit on patch 2 by MST.
- Rebase patch 3 because of commit d748047
  ("ptr_ring: disable KCSAN warnings").
- Document the pair of the smp_mb__after_atomic() in tun_net_xmit
  with tun_ring_consume().
- Use 1 ptr_ring spinlock instead of 2 (currently used for consume
  and empty check), not sure how to implement it pretty rn.
- Run pktgen benchmarks with pg_set SHARED.


