Return-Path: <netdev+bounces-286557-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFciEAChAWpKgwEAu9opvQ
	(envelope-from <netdev+bounces-286557-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 11:27:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B59E750ADAA
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 11:27:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7E6C630556EA
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 09:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452843B8958;
	Mon, 11 May 2026 09:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HWkYLsRP";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gUyu9PCk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A6B363082
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 09:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778490661; cv=none; b=IfCtEV/hh6njC3rvsY82WcmHLj2PpX2doer2NV7QNJKkP8GiW/HW4qFKIZHn461PQoL8PdWrGs/iyq2Z40B7mn2SuujJ3l991RhLcTvbZHkDd1Jr+n3q1edObrPFQEkD7neaPc44XwczSrbgVAmGf9BEweXv3aPZ3vO9ZdSoNac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778490661; c=relaxed/simple;
	bh=NOVPw0sRFmhs/549yezkhu2bnfPqQ2AHmr7i3bUMSWg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TTEDUXWAeucjZoRVZkItyfgpk7Os3lBsj2Nv86yGO6OAxNVQ/9m2EqwzHnajSi0Gpse5ktmdht/0uHSIZzIVtTOCvfGhbkxQCACbrphzizm9IMhqPeQFc0nXJByVh6p500S7eDY9CeGeifJ1SCGHGuK7b/4CTwoSPbQMigj5dJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HWkYLsRP; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gUyu9PCk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778490658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GeXjhbPFcIE2xpoWydu6GqD8aKPwmV5ublK6KJ28nAc=;
	b=HWkYLsRPaoHz7KxJeITJVNyRa6E5WsVlc16ZlutllRZbbuFHen+MVD8JttVhcgSGaRIsiD
	oRldV0qbPj6xpMgD2PqQX1yaQ36fidiEJWTB28Th7UTondJ9eIpN+dJDJTK1UM2+lBlNO2
	0Ses0Vlabd6F+Vr88KrhAH0YGSTXECM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-qsIXXvM9N3u2WFhTAeBnVA-1; Mon, 11 May 2026 05:10:56 -0400
X-MC-Unique: qsIXXvM9N3u2WFhTAeBnVA-1
X-Mimecast-MFC-AGG-ID: qsIXXvM9N3u2WFhTAeBnVA_1778490656
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-488d8deb75fso30098745e9.3
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 02:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778490656; x=1779095456; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GeXjhbPFcIE2xpoWydu6GqD8aKPwmV5ublK6KJ28nAc=;
        b=gUyu9PCkWd2lgQx96I+kGh1XC3gqZO9nAu+qbvim7zG6zlyQZW0FDmUBk9NdAH3f+a
         MOPpQ5c3gF/MHJSLeZmR4AispSwWGP90lRx70L0T11x1sttkhRCMwEJXkEsyPBad7si1
         hCUo2MAHhcYjeFohSkq5KRXd/xuM2nujga7ee6jZs8y+9ozs+AN7o08KxBKWI8IS6k8Z
         YOTt+sMCGgBCNPUqmgvl2VrvikQfPiQEWLwf8+g3Rk7h58J1gaXmbGB7+DRpq8U3kcoh
         xv4mm2PZ13z7fIsZHMrmLsVqIMjs+w6fO6NDGn2jtKzmABKC0Q2DD/Jp52MxrMlJifh8
         om9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778490656; x=1779095456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GeXjhbPFcIE2xpoWydu6GqD8aKPwmV5ublK6KJ28nAc=;
        b=NYy4zs1xpOdQLjn1OcHFddv795Y7TclQxa6jRQYB1nA2MxELU2JBCBq9uaXKbb42P0
         AyLufF/BgA4rLsRcmzQAhwhUaj5Zs3nZ4UD8EMRCUdBdT5jtpFvBgHt4R0sGvAZxNA//
         teHZawjASROT1w9No5GaFimG1zFoxmZk89UXBYtVhPR7/gtPPkQOu/mskDll6P8BJuCF
         eHgkG+Fmen8wIHUhv+L31EdNsnxruTTP0APS+AzGfzpnyzG9jpehxKlzBSVP1335b2FC
         pRWwG69KkkUEjJIzBMHrvUYEiu/TdnEswEa8Q2+h5DEPzgf+Qp7Dt0gWJmFgEDbOEjhZ
         nHdA==
X-Forwarded-Encrypted: i=1; AFNElJ/hhyQ4NaU9wx/ANB6FGLvBP6/6qGQH63tGmBSQIxSVW+zUtgFc7p6sJpoc5SAUJH3I6TVehq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZTpZ5vctciDJdMfPrD7BWVZxNg/gCC+zzs6TDir9kUMg64GxZ
	w05RQI6UbX61E2SZo/6i8T3kF+qggl+5TlbfUp0IGAgAm5RE5uZMHNDmQB5oQgZEvxjkiMKKesY
	HW2OpYFm9ig8Sx4tvo6WhNkTB+fm8awgJIbKJ1nbtTYavMIrISxtGpC4hqw==
X-Gm-Gg: Acq92OHPxQqfEWvI9GQG4fsxt2mk2hAHgHYMSNmduorzUAOCL1J6V1NssmgsOinXmEc
	qPueyw2yOjCws9aAD+btPPc1UcxV10TZLPy5POVbQvH++NhrddhlGn95RmtYNxK9r0Znpvx6ufa
	Jy2gOVuI027ArWUO89JsiyRLTzuBJ0Mkiyp8xbDrpHdQDrSZQKHw/gd/IklnTZdm0MVO/lGRu+9
	MuuxD6rdckAlmF7zAvHMNZvgdUKtIzkxtVFseILGXKk9pgJ3lLGfnQWhUwGcgZVgbEf0aRk7URX
	5xQwM4WtpIAQiGL2kCoMzzrzKGuHUaPYZLyNmU2NNVuRwCxGBOdozG883pSUxaoV/6KW6cOiZDo
	ZoRc4VDet0S9olR4/06AnBLrLIGhe0kMhdDqU8gfz
X-Received: by 2002:a05:600c:628d:b0:48e:82b4:b54 with SMTP id 5b1f17b1804b1-48e82b40ba4mr52289595e9.23.1778490655512;
        Mon, 11 May 2026 02:10:55 -0700 (PDT)
X-Received: by 2002:a05:600c:628d:b0:48e:82b4:b54 with SMTP id 5b1f17b1804b1-48e82b40ba4mr52288725e9.23.1778490654837;
        Mon, 11 May 2026 02:10:54 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e6db09cb6sm58109535e9.22.2026.05.11.02.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 02:10:54 -0700 (PDT)
Date: Mon, 11 May 2026 05:10:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, eperezma@redhat.com,
	leiyang@redhat.com, stephen@networkplumber.org, jon@nutanix.com,
	tim.gebauer@tu-dortmund.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next v12 0/4] tun/tap & vhost-net: apply qdisc
 backpressure on full ptr_ring to reduce TX drops
Message-ID: <20260511051037-mutt-send-email-mst@kernel.org>
References: <20260510151529.43895-1-simon.schippers@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260510151529.43895-1-simon.schippers@tu-dortmund.de>
X-Rspamd-Queue-Id: B59E750ADAA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286557-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,lunn.ch,davemloft.net,google.com,kernel.org,networkplumber.org,nutanix.com,tu-dortmund.de,vger.kernel.org,lists.linux.dev];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,tu-dortmund.de:url,stackexchange.com:url]
X-Rspamd-Action: no action

On Sun, May 10, 2026 at 05:15:25PM +0200, Simon Schippers wrote:
> This patch series deals with tun/tap & vhost-net which drop incoming
> SKBs whenever their internal ptr_ring buffer is full. Instead, with this 
> patch series, the associated netdev queue is stopped - but only when a
> qdisc is attached. If no qdisc is present the existing behavior is
> preserved. The XDP transmit path is not affected. This patch series
> touches tun/tap and vhost-net, as they share common logic and must be
> updated together. Modifying only one of them would break the other.
> 
> By applying proper backpressure, this change allows the connected qdisc to 
> operate correctly, as reported in [1], and significantly improves
> performance in real-world scenarios, as demonstrated in our paper [2]. For 
> example, we observed a 36% TCP throughput improvement for an OpenVPN 
> connection between Germany and the USA.
> 
> Synthetic pktgen benchmarks indicate a slight regression, and packet
> loss is reduced to near zero. Pktgen benchmarks are provided per commit,
> with the final commit showing the overall performance.

at v12, time to merge this.

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> Thanks!
> 
> [1] Link: https://unix.stackexchange.com/questions/762935/traffic-shaping-ineffective-on-tun-device
> [2] Link: https://cni.etit.tu-dortmund.de/storages/cni-etit/r/Research/Publications/2025/Gebauer_2025_VTCFall/Gebauer_VTCFall2025_AuthorsVersion.pdf
> 
> ---
> Changelog:
> v12:
> Patch 1: 
> - Revert tun_queue_purge() to plain ptr_ring_consume() and instead
>   explicitly wake the queue in __tun_detach() for the ntfile taking
>   over the queue slot (if its ring is empty).
> - Inlined tun_reset_cons_cnt(), because only tun_attach() uses it.
> 
> - Patches 2-4 and cover letter unchanged.
> - Compiled and short pktgen test.
> 
> v11:
> - Renamed __ptr_ring_produce_peek() to __ptr_ring_check_produce()
>   (Sashiko)
> - Add return code -EINVAL to __ptr_ring_check_produce() which lets
>   tun_net_xmit() stop the queue only on -ENOSPC. (MST)
> - Resolve race on tfile->queue_index by locking tx_ring.consumer_lock
>   in __tun_detach(). (Sashiko)
> - Wake the queue in tun_queue_resize() to avoid possible stalls.
> - Other minor adjustments & reran the benchmarks.
> 
> v10: https://lore.kernel.org/netdev/20260506141033.180450-1-simon.schippers@tu-dortmund.de/
> - Changed the term "Transmitted" to "Received" in the benchmarks,
>   as correctly pointed out by MST, and reran the benchmarks.
> 
> Addressed the Sashiko AI review:
> - Avoid a data race on tfile->cons_cnt by always locking.
> - Correctly count the number of consumed packets for vhost-net.
> - Corrected a typo in the commit message of commit 3.
> - Added a missing barrier on the consumer side.
> --> The barriers now follow the "store buffering" principle.
> - No longer return NETDEV_TX_BUSY at all, because it is unsafe.
> --> Result: There are still a few drops with multiple senders, which
>             would be avoided by disabling LLTX.
> 
> V9: https://lore.kernel.org/netdev/20260428123859.19578-1-simon.schippers@tu-dortmund.de/
> - Addressed minor nit by MST in patches 1 and 2.
> - Rebased patch 3 because of commit d748047
>   ("ptr_ring: disable KCSAN warnings").
> - Documented the pair of the smp_mb__after_atomic() in tun_net_xmit()
>   with tun_ring_consume().
>   --> It simply pairs with the test_and_clear_bit() inside of
>       netif_wake_subqueue().
> - Use 1 ptr_ring consumer spinlock instead of 2.
> - Ran pktgen benchmarks with pg_set SHARED for 50 iterations on
>   latest kernel
>   --> No significant performance difference noticed
> 
> V8: https://lore.kernel.org/netdev/20260312130639.138988-1-simon.schippers@tu-dortmund.de/
> - Drop code changes in drivers/net/tap.c; The code there deals with
>   ipvtap/macvtap which are unrelated to the goal of this patch series
>   and I did not realize that before
> -> Greatly simplified logic, 4 instead of 9 commits
> -> No more duplicated logics and distinction in vhost required
> - Only wake after the queue stopped and half of the ring was consumed
>   as suggested by MST
> -> Performance improvements for TAP, but still slightly slower
> - Better benchmarking with pinned threads, XDP drop program for
>   tap+vhost-net and disabling CPU mitigations (and newer Ryzen 5 5600X
>   processor) as suggested by Jason Wang
> 
> V7: https://lore.kernel.org/netdev/20260107210448.37851-1-simon.schippers@tu-dortmund.de/
> - Switch to an approach similar to veth (excluding the recently fixed 
> variant), as suggested by MST, with minor adjustments discussed in V6
> - Rename the cover-letter title
> - Add multithreaded pktgen and iperf3 benchmarks, as suggested by Jason 
> Wang
> - Rework __ptr_ring_consume_created_space() so it can also be used after 
> batched consume
> 
> ...
> 
> ---
> 
> Simon Schippers (4):
>   tun/tap: add ptr_ring consume helper with netdev queue wakeup
>   vhost-net: wake queue of tun/tap after ptr_ring consume
>   ptr_ring: move free-space check into separate helper
>   tun/tap & vhost-net: avoid ptr_ring tail-drop when a qdisc is present
> 
>  drivers/net/tun.c        | 109 ++++++++++++++++++++++++++++++++++++---
>  drivers/vhost/net.c      |  21 +++++---
>  include/linux/if_tun.h   |   3 ++
>  include/linux/ptr_ring.h |  20 ++++++-
>  4 files changed, 139 insertions(+), 14 deletions(-)
> 
> -- 
> 2.43.0


