Return-Path: <netdev+bounces-278386-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAP3LdYZ3mmFnAkAu9opvQ
	(envelope-from <netdev+bounces-278386-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 12:41:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC0773F8E12
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 12:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2857B301C3D2
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 10:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76FD23CD8DF;
	Tue, 14 Apr 2026 10:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNWEW0OQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADD13D6CAC
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 10:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776162748; cv=none; b=HwB57VSdXAx+yIN0nz+1YuDXyWn6SyQnKn1qrAgvfAMfDm2WkZBoCXkyZmEPHo6FpmRToZCAVa3eWBxS35U7AMSTpGmtiS4JP/nHrTSM9avNCGEr0S3oGYdWRBSs2WtHN9OHg5LSs+SvhElM6hbYfnTd5TYBt5mmh7sqVh9DaGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776162748; c=relaxed/simple;
	bh=u3IQEBuxXIVMnDTRG/PqxHBCvQ+nXHFARKDEMj7TE+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LPC2N7oCzA6YNo5/LdRQI+ygIo31fN3idA2QOIWdiLZWS8D4YjVB4nuvwibeXeGuAwdJeW2w+cubcbWTDO9KM3Luf2S49eJQubPK/wS1ZtF/PJKpNfdX2dUhBAlEcEFbNHVxT0hOoisI/S4bwll8EQhzYg/kAnk1xWsKKsbDIBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gNWEW0OQ; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c76ffd06593so3675596a12.0
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 03:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776162739; x=1776767539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hBS3kowVpb/DYMvMlm9GChGsWIitbQGeNsLSY8qHLyg=;
        b=gNWEW0OQBk4SLDTX/zWZn073YZGjdod7FtdoQx5PTqGUnpxP9vDiRFsDoT9IqmsDu3
         WFhMMmatiGm/J+qHe8BXWIhOKp8Ik81cFCreAQYTkPtP8caGnrWWFwYFPMzT4uiooQnq
         gM0S0PMPxBLuOYP+XrsdHYxANvLF0vIGdDpWOVjOtq+HFmbZN2pU8ZoMQxWEEWg3N2FG
         BR+VuXnXpSmD1A6GmPU+pKoZPaaT83d1AtohLOqAZCy2WJGN2SYu31uXBwDkOsG84Bbb
         5nzZLtj82eBOHsaETxShkgmIb2BfgeJVSIyhSBcp7z9D7CS3PafHCKylrnb1iBZ8o6Cw
         TLjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776162739; x=1776767539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hBS3kowVpb/DYMvMlm9GChGsWIitbQGeNsLSY8qHLyg=;
        b=EXck6sfZyZ5BzkGFchh2NlMhu/zsQ8dUYQBSx0Ox7LgI9+ZJuYQgczBvxe6TuYp/ZL
         SqTaIBNtTf0XRfE26CNEna2TYHhyEHV9X2vHLz/M2+GiNJJFM1TBQijwuOuoWj1Xy7L8
         0MNAu5xGBzkxJCQLjKxYyOQsgFfRd/nl7wCcd5V/FpoYX2/FLaSBGUHOsWAzdeVnY5my
         48bbXoNcZ03fkRSe8wgb4CZyM8TtVLXJyiT9a80+hR28K+MgegVDjc68EnWt3wA1tY3x
         EPoRfUmdRDW6947hNvMmzwtQhL++1vjnpOCsVpH7Kw/tdWgpIDrFsCFOfmL4JDjnJizV
         Fq/g==
X-Gm-Message-State: AOJu0YyOdUzJSfOw2K8sifnvomLcVEtvY1UamZFg6nmHTQDHC3W5JiQD
	m48xSOKUNgqlMLodbYPikxpKKQ9/DyUZ1pUnCS46Kdapqiyk2UdvVvxGwxfx4bHS0ifDIQ==
X-Gm-Gg: AeBDiesjcxeWbCvutABmPKyplucXkMKl/lweGSZAlSm7ch/NbCzI7rK2yTrQ6pFdaQo
	MPjm22FzOvCdddMCsl2meWYKcndMgaCHi9U6/c36BNLHIxYqPxkjy+l4/2gaxGnPNsYxLMwD8sY
	7Whf5980XUZTrWBVXZkJfQpJ142zhoctS1d0XNcoxUeSF7zhFtIry1u0DPSpUs1mx7tyk1KbS75
	dpTcwWUEOkeKKhjrnM017lemeuJxig0ob6Nap5zJmuO2VklPFJ2RNS2kps+evXAlD8DRGGRfPkH
	iaYLwbSjCB4riTxvqay7ks9APncmW8mBWSHcg8YxqaQJdhCPYWx6FU8mcRRqXOlyoeRHj5HITVI
	bho/NEgQ843a2y+d+yloZ8tsOjafYKz6bSzG8KdiH9F/MiWKiqia5ZBrqvQaAeyPj2lwOdt7af7
	tNUDRens166Q82qD0T
X-Received: by 2002:a17:902:edcd:b0:2b0:5a4c:7263 with SMTP id d9443c01a7336-2b2d5999974mr121396355ad.18.1776162738906;
        Tue, 14 Apr 2026 03:32:18 -0700 (PDT)
Received: from houminxi ([38.207.130.223])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b45cbf11b1sm65747245ad.17.2026.04.14.03.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 03:32:18 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: Minxi Hou <houminxi@gmail.com>,
	ovs-dev@openvswitch.org,
	mhou@redhat.com
Subject: Re: [RFC] net: openvswitch: Inroduce a light-weight socket map concept.
Date: Tue, 14 Apr 2026 18:32:05 +0800
Message-ID: <20260414103205.1623706-1-houminxi@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20250627210054.114417-1-aconole@redhat.com>
References: <20250627210054.114417-1-aconole@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,openvswitch.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278386-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[houminxi@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.995];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DC0773F8E12
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Aaron,

I tested two stages of this work on x86_64, single-node setup:

1. Early RFC (this patch, June 2025): basic socket action plumbing,
   ODP parsing, and socket_lookup configuration.

2. Current development branch (sockmap_2026_feb, built as a scratch
   kernel based on RHEL 9.8 / 5.14.0-611.el9_7), which extends this
   RFC with: rcuify list, sockmap get/del commands, action list rework,
   packet cmd fix, sockmap fixes, tuple detail improvements, and
   flow-socket association. Paired with the OVS userspace sockmap
   branch (sockmap_cmds).

Tests on the current development branch:

- ODP action round-trip parsing (valid and invalid): pass
- Socket action generation via ofproto/trace for TCP (IPv4/IPv6): pass
- Non-TCP exclusion (ICMP, UDP): pass
- socket_lookup enable/disable per port: pass
- socket_lookup with group recirculation: pass
- OpenFlow regression with socket_lookup: pass
- Conntrack regression with socket_lookup: pass
- 2-namespace TCP performance: pass

During 1000-namespace scale testing (2000 veth pairs, socket_lookup
enabled on all ports), the following WARNING burst was observed in the
kernel console log:

[20652.730148] WARNING: CPU: 118 PID: 304284 at
               net/core/skbuff.c:1000 skb_release_head_state+0x95/0xa0
(185 occurrences within 79ms, followed by BUG: scheduling while
 atomic in OVS upcall handler thread handler2052)

This is triggered by ARP table overflow under 2000 veth pairs, which
floods the OVS netlink upcall path. The underlying issue is that skbs
with netlink_skb_destructor are passed to consume_skb() without first
calling skb_orphan(). The WARNING is reproducible on a stock RHEL 9.8
kernel + stock OVS 3.7 without any of these patches, confirming it is
a pre-existing kernel issue unrelated to this work.

Tested-by: Minxi Hou <houminxi@gmail.com>

