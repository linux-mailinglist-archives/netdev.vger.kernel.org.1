Return-Path: <netdev+bounces-297796-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xS7jLVmrKWrobgMAu9opvQ
	(envelope-from <netdev+bounces-297796-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 20:22:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D6166C375
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 20:22:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=qmX9xBIt;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297796-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-297796-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1755E302ACC9
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 18:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3595349CE4;
	Wed, 10 Jun 2026 18:22:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B43B33A9C4
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 18:22:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781115733; cv=none; b=tJ3HILg2fIo3ggX3XfreVOAOlBQ+oXo9xWiA87zs69nVPCAXGn3RqFY/ordmf6lWxKvWSI7DOwRLIr2nE/q+PBHMMXzT2OAN2U5HGhvU3V2t+cJ04UUB1cKM67NqkRsWp9DN/dm1jQ5nmg9qy3+fXLw/fmuzeStAjv8dOGwhP+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781115733; c=relaxed/simple;
	bh=fb5cH8rxdSCmzrda7yRA3juiQEWeinPlui/pTJeg9Fo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ieFDnkaCOeX8ySsfrvDT6GoKucNlbyU5WQylJnB9woKruy0C0obVMyGleFVwV13cgGI2BgcKX1vm5IqVAGYfmHAt1Dll7liWS1fu3inxkMosrqds8uvDB4SpwxHDflKNuxqmUEKKU9q2fwzHgC4o+0h7FywNNuLq7pbbNGwtwdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qmX9xBIt; arc=none smtp.client-ip=209.85.210.202
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8421ffff8a3so8752699b3a.2
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 11:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781115732; x=1781720532; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WcLlpTsK1Nk3I3wBbU+yBPA3dp9G4OVqBTMwK6OYAeg=;
        b=qmX9xBItaw4UmIOXDkKrb7EWl423XOJ2KhMtgxmyZRZfsSHQDYuH7vLsTLN6DuSBnu
         /PjCB3pM+lzge7ujwIFloLwVLJIVTD57PDmluDUeDjU02d25ygsF2UUCwvp7rZEVlK/y
         X2l1oP4J64YvlNSGvQScIj3cZfS3v5d/CopeDf/LE/eb/GV8mRrJrHzJZkQR4EfBsP9P
         daew875NZpUmVSt20FPbyEDFPYTlT24W5+ByZBrRj4E/PZukQgPrdpGQmcKfnEbYEyYA
         Pwfm/sHCBF3G88/cmeUtBGAxGOughZqhKM5ssdi175FDf/tMe7IwLlMpR/hodWyGD2JA
         hv3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781115732; x=1781720532;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WcLlpTsK1Nk3I3wBbU+yBPA3dp9G4OVqBTMwK6OYAeg=;
        b=mZuT9mU01EkafjDchzEJpY8FZDumQYKssrq+WWjTq8ymMaV11r+05aiCuyMfMpX93g
         CCI81aDHNlZfieOkQOYQnFon/1Vm6xvz/M4+STsoH7oZV/Cj7PMdHsun/4kedbrXPHn0
         eLsy31f4BesKqdVp2eyy412BEPatShnLFCnniVoo3ihZEwLdi478F8m0sYEr5j1mkC6Y
         lobHfTD0PrRvuLgd51UPBakayd3tWyIeyPvSF1pTEO0+cqbNV2FgnyGC5gMcfm71/Gr6
         Pyw4QqovtPqFItLI2kG1AaS+vUiuRCNj+z/l3cjHfr8PZENyPHgFH+U9+abWZFmr0cKv
         cETg==
X-Forwarded-Encrypted: i=1; AFNElJ9LxXuv+RRSyHUX9JL49RvRgF1vtAbX9pSw0+rElI84Q4bXQrn3nfG9HrZVphH3TxSUoQYMXB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyP8/55AZIOrrUxTfEBAWMyuh5d/CtK1xF5bhWHnfw80ofFhIE
	yUItymcx5+aOPvvwVhY15IeYcgZ78ITsPkYL/v+hhwEvXjnK6t3BnNPA3coz+JyxJJ8szA4oEca
	umIfDkQ==
X-Received: from pfw16.prod.google.com ([2002:a05:6a00:a270:b0:842:2c74:b8cd])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:84b:b0:82c:6683:b866
 with SMTP id d2e1a72fcca58-84330af777bmr415184b3a.4.1781115731476; Wed, 10
 Jun 2026 11:22:11 -0700 (PDT)
Date: Wed, 10 Jun 2026 18:21:48 +0000
In-Reply-To: <6831f6a7-7321-4657-8255-28252b1a3176@ovn.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <6831f6a7-7321-4657-8255-28252b1a3176@ovn.org>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260610182211.2622443-1-kuniyu@google.com>
Subject: Re: [BUG] FORTIFY: memcpy overflow in skb_tunnel_info_unclone() from geneve_xmit()
From: Kuniyuki Iwashima <kuniyu@google.com>
To: i.maximets@ovn.org
Cc: dev@openvswitch.org, edumazet@google.com, kees@kernel.org, kuba@kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, write@ownrisk.dk
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-297796-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:i.maximets@ovn.org,m:dev@openvswitch.org,m:edumazet@google.com,m:kees@kernel.org,m:kuba@kernel.org,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:write@ownrisk.dk,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[google.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 28D6166C375

From: Ilya Maximets <i.maximets@ovn.org>
Date: Wed, 10 Jun 2026 20:00:53 +0200
> On 6/10/26 3:10 PM, Johan Thomsen wrote:
> > Hi Ilya,
> > 
> > Sorry for the late follow-up.
> > Your patch has now run without crashes in my setup for 36 hours and
> > I'm unable to re-trigger a panic.
> > 
> >> But the operation in the diff above is kind of pointless as the memcpy
> >> itself will copy the value again.
> > 
> > Right. So it would probably need at least a comment, if that ends up
> > becoming the final fix.
> > I'm not a kernel dev and I don't know what is the right thing to do here.
> > 
> > Happy to test alternative patches if needed.
> 
> OK.  Thanks for testing.
> 
> > 
> > BR
> > Johan
> > 
> > Den man. 8. jun. 2026 kl. 11.41 skrev Ilya Maximets <i.maximets@ovn.org>:
> >>
> >> On 6/8/26 10:25 AM, Johan Thomsen wrote:
> >>> Hello,
> >>>
> >>> I am seeing what looks like a kernel bug in the Geneve/OVS/vhost
> >>> transmit path on a Talos Linux node running Kube-ovn with Geneve
> >>> overlay and KubeVirt VM traffic.
> >>>
> >>> Environment:
> >>>
> >>> Kernel: 6.18.33-talos
> >>> Distro: Talos v1.13.3
> >>>
> >>> Compiler/config:
> >>>
> >>> CONFIG_CC_VERSION_TEXT="clang version 22.1.2"
> >>> CONFIG_CC_IS_CLANG=y
> >>> CONFIG_LTO=y
> >>> CONFIG_LTO_CLANG=y
> >>> CONFIG_LTO_CLANG_THIN=y
> >>> CONFIG_FORTIFY_SOURCE=y
> >>>
> >>> Hardware: HPE ProLiant DL325 Gen11, AMD EPYC
> >>>
> >>> NIC driver: bnxt_en
> >>>
> >>> Workload/network:
> >>>
> >>> Kube-OVN, Geneve overlay
> >>> Open vSwitch datapath
> >>> KubeVirt/QEMU VM traffic via vhost/tap
> >>>
> >>> Relevant console output:
> >>>
> >>> [  648.742603] memcpy: detected buffer overflow: 104 byte write of
> >>> buffer size 96
> >>> [  648.749907] WARNING: CPU: 61 PID: 27020 at
> >>> lib/string_helpers.c:1036 __fortify_report+0x45/0x60
> >>> [  648.758689] Modules linked in: dm_round_robin dm_multipath lpfc
> >>> nvmet_fc nvmet intel_rapl_msr intel_rapl_common ahci nvme_auth bnxt_en
> >>> nvme hpilo hkdf libahci sp5100_tco watchdog k10temp
> >>> [  648.775429] CPU: 61 UID: 107 PID: 27020 Comm: vhost-27002 Not
> >>> tainted 6.18.29-talos #1 PREEMPT(none)
> >>> [  648.784735] Hardware name: HPE ProLiant DL325 Gen11/ProLiant DL325
> >>> Gen11, BIOS 2.84 11/05/2025
> >>> [  648.890478]  skb_tunnel_info_unclone+0x179/0x190
> >>> [  648.895152]  geneve_xmit+0x7fe/0xe00
> >>> [  648.907240]  dev_hard_start_xmit+0xa7/0x1f0
> >>> [  648.911479]  __dev_queue_xmit+0x864/0xf40
> >>> [  648.919688]  do_execute_actions+0x9b9/0x1be0
> >>> [  648.927727]  ovs_execute_actions+0x58/0x170
> >>> [  648.931960]  ovs_dp_process_packet+0xb1/0x1c0
> >>> [  648.936370]  ovs_vport_receive+0x90/0x100
> >>> [  648.940428]  netdev_frame_hook+0x146/0x1a0
> >>> [  648.954093]  __netif_receive_skb+0x3f/0x160
> >>> [  648.958324]  process_backlog+0x10c/0x210
> >>> [  648.962295]  __napi_poll+0x2f/0x190
> >>> [  648.965832]  net_rx_action+0x2e3/0x500
> >>> [  648.969632]  handle_softirqs+0xe7/0x310
> >>> [  648.985387]  tun_get_user+0x137e/0x1510
> >>> [  649.005878]  handle_tx+0x41f/0xd30
> >>> [  649.029014]  vhost_run_work_list+0x52/0x90
> >>> [  649.033162]  vhost_task_fn+0xc2/0x140
> >>> [  649.064145] ---[ end trace 0000000000000000 ]---
> >>> [  649.068820] ------------[ cut here ]------------
> >>> [  649.073489] kernel BUG at lib/string_helpers.c:1043!
> >>>
> >>> I don't know whether this is a real overflow or a FORTIFY false-positive.
> >>
> >> Looks like a false-positive from the __counted_by fortification.
> >>
> >> I'd guess something like this would fit it:
> >>
> >> diff --git a/include/net/dst_metadata.h b/include/net/dst_metadata.h
> >> index 1fc2fb03ce3f9..e51c3795da474 100644
> >> --- a/include/net/dst_metadata.h
> >> +++ b/include/net/dst_metadata.h
> >> @@ -164,6 +164,7 @@ static inline struct metadata_dst *tun_dst_unclone(struct sk_buff *skb)
> >>         if (!new_md)
> >>                 return ERR_PTR(-ENOMEM);
> >>
> >> +       new_md->u.tun_info.options_len = md_size;
> >>         memcpy(&new_md->u.tun_info, &md_dst->u.tun_info,
> >>                sizeof(struct ip_tunnel_info) + md_size);
> >>  #ifdef CONFIG_DST_CACHE
> >> ---
> >>
> >> Johan, could you try this in your setup?
> >>
> >> The memory was actually allocated for the options, but the structure
> >> is zeroed out on allocation, so the __counted_by check doesn't work
> >> properly for the initial initialization copy.
> >>
> >> But the operation in the diff above is kind of pointless as the memcpy
> >> itself will copy the value again.  So, I'm not sure if that's the right
> >> solution here.
> >>
> >> Alternative might be to revert the kmalloc_flex back to the simple
> >> kmalloc in metadata_dst_alloc.
> 
> A little less icky alternative might be to just split the copy in two:

I'd simply use unsafe_memcpy().


> 
> diff --git a/include/net/dst_metadata.h b/include/net/dst_metadata.h
> index 1fc2fb03ce3f9..996ae8350360a 100644
> --- a/include/net/dst_metadata.h
> +++ b/include/net/dst_metadata.h
> @@ -164,8 +164,12 @@ static inline struct metadata_dst *tun_dst_unclone(struct sk_buff *skb)
>  	if (!new_md)
>  		return ERR_PTR(-ENOMEM);
>  
> +	/* Copy in two stages to keep the __counted_by happy. */
>  	memcpy(&new_md->u.tun_info, &md_dst->u.tun_info,
> -	       sizeof(struct ip_tunnel_info) + md_size);
> +	       sizeof(struct ip_tunnel_info));
> +	memcpy(ip_tunnel_info_opts(&new_md->u.tun_info),
> +	       ip_tunnel_info_opts(&md_dst->u.tun_info),
> +	       md_size);
>  #ifdef CONFIG_DST_CACHE
>  	/* Unclone the dst cache if there is one */
>  	if (new_md->u.tun_info.dst_cache.cache) {
> ---
> 
> Adding netdev maintainers for more opinions.
> 
> >>
> >> CC: Kees
> >>
> >> Best regards, Ilya Maximets.
> >>
> >>>
> >>> I cannot reproduce the issue on Talos v1.12.X which uses a gcc built
> >>> kernel, whereas the affected kernel is built with clang. Don't know
> >>> whether this is relevant here.
> >>>
> >>> I am currently trying to make a reliable reproducer, but I can almost
> >>> always trigger the issue when iperf stressing the VM-network.
> >>>
> >>> Please let me know if this should go to a more specific
> >>> maintainer/list or further info is needed. I am able to test candidate
> >>> patches if provided.
> >>>
> >>> Downstream bug reports:
> >>> https://github.com/siderolabs/talos/issues/13440
> >>> https://github.com/kubeovn/kube-ovn/issues/6767
> >>>
> >>> Thanks,
> >>> Johan

