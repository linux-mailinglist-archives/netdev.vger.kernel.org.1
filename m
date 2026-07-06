Return-Path: <netdev+bounces-304994-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +XzGOUqWS2ofWAEAu9opvQ
	(envelope-from <netdev+bounces-304994-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 13:49:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DBA710131
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 13:49:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=e4A6jFZ4;
	dkim=pass header.d=redhat.com header.s=google header.b=jKu58+bi;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304994-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304994-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C60D1300EE96
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 11:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBED41F7D4;
	Mon,  6 Jul 2026 11:49:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0011B414A37
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 11:49:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783338566; cv=none; b=MP+pg2HU5Mh2TSPbFGMH1ky1BblaD7ABPAraJjk3HLDWtDntiX6wJvE2TJu+m0ABN1zW18AibI6TFG064XhE2WKFF1SaRjCNOHbyUOBsHiAtrwu/6uTuAwdu372TU4YpY/bDdSJazqXU+AsQfjW2cnX2Ywtt1iBLol4iur969wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783338566; c=relaxed/simple;
	bh=ej669tqdQRBrUGwoO+9YEmnfZjZOl4s5UHB7MEdZfF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M8YakVNAvDIKi40XyXGfVGBp0IH5Y9Ap24K2oGruozSzoNXqe/O68O4L95F0kr0Nj7hgjGFtSc/jDs3VX8nMSMCwgTJ8D5pWM82w5iOTBc3FJMGN4Z1MwkqUze84Scw0xql/eUrewr0aSOYyrkTnQwR6qvUC5jENJl+dfWkEyck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e4A6jFZ4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=jKu58+bi; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783338564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ej669tqdQRBrUGwoO+9YEmnfZjZOl4s5UHB7MEdZfF4=;
	b=e4A6jFZ4iG1eZr5xBsRt2hLGTX120osrX88wetYam0Cg+XnzClLXfXTQ/Rkxv8g5F+q9sH
	fpyQ39wKhHchmVX7pdzOKUcoakjZOBGlmLEgexYLwtK0FdVHaNkkasVMkIrUUO4h47aTEm
	YcK7deUlzblpm0IiKivbYoqn9OvKS44=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-AEpNDNNKMieQuZWthZHNFg-1; Mon, 06 Jul 2026 07:49:22 -0400
X-MC-Unique: AEpNDNNKMieQuZWthZHNFg-1
X-Mimecast-MFC-AGG-ID: AEpNDNNKMieQuZWthZHNFg_1783338561
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c12792a87d1so211932666b.1
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 04:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783338561; x=1783943361; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ej669tqdQRBrUGwoO+9YEmnfZjZOl4s5UHB7MEdZfF4=;
        b=jKu58+bi/uwSZJhHtAswirNFDHNTG28+UPWscDa00BiRC7d5scqZP1EtXla+kYGCWS
         O4ZJQqATXO7pw7wpvntlsf/A4cLYt4gA+f1SSjPXKa1wm0Hpsd8fWfvEOmmjC9QTHVEl
         fvRfQqGfgItMK7folGDSv0RKt2dGIj1g/9uB0HIcfDLKz7AG3G/KJdP41oPXfW0G1ZF0
         EjTtc6yTVHIMIHvZxXLfepbsTwUMvQ5LDmEHAOuS7Q4PO8yKRNNJIA7yC8hQvprXUIyf
         Nh21TjKiWzq/BGM5gQY/356lgURGZ7LnTvxc8c4ZK0TVQZsdAe7DARxjJJAtZu1jBsxZ
         u5XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783338561; x=1783943361;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ej669tqdQRBrUGwoO+9YEmnfZjZOl4s5UHB7MEdZfF4=;
        b=lzer8kKWz5xjjxn+E9hugMTBJJL89YEitqCEq7wfmSIsU/8W09rVkTmEAqKles4GB2
         Bsy4DOB60Ev1D0mN59PfdPzr17RKZeiSSPWOwo3dwyW6Rz0rl7vkcC0Cmd4SfsPfSlKS
         30UC1akFvbhwjSD+2DVPKwd17L+kZknXRiPBitspVd1Tb+gwkcDy3lUai1vrOL9L+QsT
         XVxTBzPPN95PfVGyqP8lj7yLFXxStYtYbp01pOSgah9TcJTbLM2YjPA2hEzKtNksHdkK
         MM16jNXAQTjODXaO7+tO9dPGjJdD338qPNmP2b5gy1esBd8nLeqDE+WZQpGmeMfNfLU6
         Kw6w==
X-Gm-Message-State: AOJu0YzkUNyP1I6BYL2DGwna1VMIxm4f3oQcoKBpARVb9/vShdNjDnrk
	11+vXHrz/KAjWDmPMw8UmfT/qju5ep2vmwcnSYLKbkPRDQFpaxTT2Vh9qCIjZ3ku5bA8jMPHX8h
	ebR9RmesfFBvUbivkyNdn6Co9+9TkOoQcfqxB0KsUm3U+PSY3StvLbg1XMw==
X-Gm-Gg: AfdE7ckvBTW/9vWBGcIM780ZZOIn2cr3BXKhiKfYl66Ko9KklxaRLYKppReDpZ/66z6
	PlSVlvgaZG1/fzoLbjdLSW9HYF7XPmbprVZqKHlKpdRnEGjRWZXs6la4vdajsVLdg5BMDwvsb4g
	w/xPNRdqi6FbDfPgKKqQAyIryoBSHpV+ezt4geTTZEb62GK6r7exmmcfE/jvtHVFXEFC+KHD3oV
	1hPlEbbwVjIGvySNS45N8X79CL7TxSSfsrpZx0Q1nW3SeqMhw1wshd/yKqCZpGPHSnWdGWlZ6eh
	Dm0MV0LVC4WN9RP6cmJLgtF579loxgIDm/itJvZviG9YNNlfRBwHXsl0edHN7IOL6EjAC2NaxJe
	mbyKrf5sCYjQ8GAc4uaEsavDbExUE97ExOrxbcuzYG4PUB8CCaQ1FhSi70Fo=
X-Received: by 2002:a17:907:399b:b0:c12:9b93:61fd with SMTP id a640c23a62f3a-c15a67dcb6amr12179566b.6.1783338561112;
        Mon, 06 Jul 2026 04:49:21 -0700 (PDT)
X-Received: by 2002:a17:907:399b:b0:c12:9b93:61fd with SMTP id a640c23a62f3a-c15a67dcb6amr12177866b.6.1783338560626;
        Mon, 06 Jul 2026 04:49:20 -0700 (PDT)
Received: from [10.44.49.24] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c12b628c16fsm752234066b.37.2026.07.06.04.49.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jul 2026 04:49:20 -0700 (PDT)
From: Eelco Chaudron <echaudro@redhat.com>
To: Asim Viladi Oglu Manizada <manizada@pm.me>
Cc: netdev@vger.kernel.org, dev@openvswitch.org, aconole@redhat.com,
 i.maximets@ovn.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] net: openvswitch: reject oversized nested action
 attrs
Date: Mon, 06 Jul 2026 13:49:17 +0200
X-Mailer: MailMate (2.0r6292)
Message-ID: <EECA04B1-CDC4-4902-9DF3-4DE93515E6EF@redhat.com>
In-Reply-To: <20260706094336.38639-1-manizada@pm.me>
References: <20260706094336.38639-1-manizada@pm.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304994-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER(0.00)[echaudro@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:manizada@pm.me,m:netdev@vger.kernel.org,m:dev@openvswitch.org,m:aconole@redhat.com,m:i.maximets@ovn.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[echaudro@redhat.com,netdev@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,pm.me:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 77DBA710131



On 6 Jul 2026, at 11:44, Asim Viladi Oglu Manizada wrote:

> Open vSwitch stores generated flow actions as nlattrs, whose nla_len
> field is u16. Commit a1e64addf3ff ("net: openvswitch: remove
> misbehaving actions length check") allowed the total sw_flow_actions
> stream to grow beyond 64 KiB, which is valid, but also removed the last
> guard preventing a generated nested action attribute from exceeding
> U16_MAX.
>
> An oversized generated container can thus be closed with a truncated
> nla_len. A later dump or teardown then walks a structurally different
> stream than the one that was validated. In particular, an oversized
> nested CLONE/CT action may cause subsequent bytes in the generated
> stream to be interpreted as independent actions.
>
> Keep the larger total-action-stream behavior, but make nested action
> close reject generated containers that do not fit in nla_len, and return
> the error through all callers. For recursive SAMPLE, CLONE, DEC_TTL, and
> CHECK_PKT_LEN builders, trim resource-owning action-list tails in reverse
> construction order before discarding failed wrappers, so resources copied
> into the rejected tails are released before the wrappers are removed.
>
> Most failed outer wrappers are discarded by truncating actions_len after
> child resources have been released. CHECK_PKT_LEN also trims its parent
> after branch resources are gone. SET/TUNNEL close failures unwind their
> known tun_dst ownership directly, and SET_TO_MASKED has no external
> ownership and truncates on close failure.
>
> Fixes: a1e64addf3ff ("net: openvswitch: remove misbehaving actions length check")
> Cc: stable@vger.kernel.org
> Assisted-by: avom-custom-harness:gpt-5.5-qwen3.6-mod-mix
> Signed-off-by: Asim Viladi Oglu Manizada <manizada@pm.me>

Thanks Asim for the patch, and Ilya for the offline review.

The changes look good to me.

Reviewed-by: Eelco Chaudron <echaudro@redhat.com>


