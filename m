Return-Path: <netdev+bounces-284930-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLoYCxtj+2kuaQMAu9opvQ
	(envelope-from <netdev+bounces-284930-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 17:49:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6368E4DD961
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 17:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 67E29307202D
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 15:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCD0348B39A;
	Wed,  6 May 2026 15:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="S07HY8zE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECED3F7869
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 15:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778082189; cv=none; b=KF8CSOdFg8GEBvrwCtFCyNE96XBOrnIH4+lIo0uKAodvJeA4WbcEBqydMHWdB6i/lBxb4PGB8gGR2xLTlHJBG4Aw1oKsQXQmHGGssOm6VX1PNeD9vRNCwbrXOYhU1Aa0lTPWi5lTw/p8X3nyoMsRD9nt41/vnQJWgtNP5kmsOcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778082189; c=relaxed/simple;
	bh=xsmzwdd1MBKsPgxT0f3M2DbdqDto8wvtJ7iL924KG3w=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=RGi4HIS8hslpcsWYXi2kv+rZARre65VFHH1+1j4JvdvcTlRPptPCVkICsUuGjgFExuWu1lPm8K/Z0Ay/GEJdQ6+Lc5gOpDQVBu57y/+JlwAGNnWh+RDgSPlcbSsOwtR8qlEyOKwax7du7RPiMPSuNgVSq1KO02+eApZ/Sck4MuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=S07HY8zE; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-12c8f9846c8so9097127c88.0
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 08:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1778082186; x=1778686986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DVcF1pwCeCEpXjOB2ycJimgmvFvZxkVUxlvxYda7Z2E=;
        b=S07HY8zEm6Sadb19c/Bu3wx0hHVfcby8HPQ98m1Q7l1DI1OrVEjJp6OG0l9gwybvjY
         xeJQPqCW6qMlwaBFqdN5BNEOrK5OP5SdK8NIpJbHY7zFJfWjY6E7JuraRHKFsHYCgSuX
         d5P+g++MBLf+gCRIl/eCWteEt0+De7Vl0GHgPXIzQ7ROWFfXjL6EKxuvOI2bgD3CQFrK
         GVW15wAIjnlvj/F4Sip904J2/FZFh8oZuZwwSt/4nwETN0B0NhN509XAT478nW6DZZF/
         xkAS1gDk74ZL5cjnjyyILjio3QBQwOK0oQmy9wEgbCXzReGtBFefI2/GEyaUAarpMQz7
         81jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778082186; x=1778686986;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DVcF1pwCeCEpXjOB2ycJimgmvFvZxkVUxlvxYda7Z2E=;
        b=KakvZDPYfSt1Mz8TLb1uy2cNq0nTIHeuz4eV89QqXbBKqH146xRFzXf3Hg/2dx+UsA
         LlPdxuTSjB51NcXhnsA+IFkB5FZFO8U1Qc4nnlWqOUr1QynvpDIP6Ki1mv631IWlJlqR
         YBQgwzIAAL/p6IpNa/E3e3ktVDruttAYiyq696XQwTKM7D7FSmY4bkjihKkY5dOK5Lqr
         20u2ivHrgiPY0V2uLVty8D4aoRm6hhgCQM69OAdQUjuzX6Lc2CHtkfs2r9udjcQQHBA3
         NLLwA6sr8lDGvhGAVRrpEFtEQwKYaMlAnfWa40RQcacl1Nw8z29ikgs/h+VJWIq3heI5
         Emhw==
X-Gm-Message-State: AOJu0YyRpVekCNkGO6mqUGdQGYs42B+E8f8uK/K51pl5gCDw1hHtSPKq
	tuKL3vdNCfPV41LQaoETS54aJB8l4NsfSqu0iDC7msgOp/I9jOUgce4FLcTzaRCm+rWIt/y4szE
	eFWli
X-Gm-Gg: AeBDietlJpCYKGvpbvrSvQFZQ56DqGs76pFNX3iBLZjHNf8CR/ohLjTBuWVixaXUp2n
	aVZn98TnrOv67uk5Dt3j+3q1MLvRKdpjWn5eTgQejZjgKIe/PBeFHjJZhS7IgCx3zarqYJKqlKi
	blGF98mlshjhUhgWe6ZVT3Os8oA6UW6nkeOrKYQSXGlsfVcwGhqav08m0HPVMKcie5Q/ByxwnBG
	IYmOUnI0NWqPLMNDEduVbLcpN9ujuwSfuOo5rQTklylicem923taQNuPIaqQ9OWbIZNvD0ZTm8r
	OFO4l/I6krtPlLxmAwjscPlsKR668YNHUlHyRhKcwVilZJAFb4rAivSwQlh3KSU3ymzL1LxBxmm
	LpXu3s8JtQkGO1o5lYEELd9pIf0csca0zeA8D109uAZFxmdALr073njOpoaEQzEaDFHuG6QfrUi
	NAsywnbwuhXYiraqksZkgSHhoD4Ku7dA9gJj1PjlW8uY9aQg==
X-Received: by 2002:a05:7022:6191:b0:12d:ca31:f1b4 with SMTP id a92af1059eb24-1318e92854fmr1995792c88.24.1778082185652;
        Wed, 06 May 2026 08:43:05 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-131f9679db9sm3757328c88.1.2026.05.06.08.43.05
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 08:43:05 -0700 (PDT)
Date: Wed, 6 May 2026 08:43:03 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Subject: Fw: [Bug 221470] New: ARP reply received at MAC level but neighbor
 entry not resolved (Linux 5.15, automotive BSP) for vlan interface
Message-ID: <20260506084303.0fd0632b@phoenix.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 6368E4DD961
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.56 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-284930-lists,netdev=lfdr.de];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,networkplumber-org.20251104.gappssmtp.com:dkim]



Begin forwarded message:

Date: Wed, 06 May 2026 05:29:26 +0000
From: bugzilla-daemon@kernel.org
To: stephen@networkplumber.org
Subject: [Bug 221470] New: ARP reply received at MAC level but neighbor ent=
ry not resolved (Linux 5.15, automotive BSP) for vlan interface


https://bugzilla.kernel.org/show_bug.cgi?id=3D221470

            Bug ID: 221470
           Summary: ARP reply received at MAC level but neighbor entry not
                    resolved (Linux 5.15, automotive BSP) for vlan
                    interface
           Product: Networking
           Version: 2.5
          Hardware: ARM
                OS: Linux
            Status: NEW
          Severity: high
          Priority: P3
         Component: IPV4
          Assignee: stephen@networkplumber.org
          Reporter: rajkumar.veer@harman.com
        Regression: No

Observed behavior: -
During a system suspend=E2=80=93resume cycle, ARP requests are transmitted =
successfully
from the target. Corresponding ARP replies are continuously received at the
EMAC/MAC level, as confirmed through driver debug logs and hardware RX
statistics.
However, the ARP entry is not being resolved in the kernel neighbor table (=
ip
neigh), resulting in failure of communication on a specific VLAN interface.
This issue is sporadic and observed only on a particular VLAN interface.
Recovery currently requires a full reboot of the system to restore proper A=
RP
functionality for particular vlan interface

Environment: - Kernel version: Linux 5.15.x (vanilla, with automotive BSP
integrations)
Architecture: ARM64 & Exynosv920 soc
Ethernet MAC driver: Sxgmac EMAC controller
PHY: Macsec marvell phy/fixed phy switch =20
Network stack: mainline Linux networking stack

What we verified: - ARP reply frame is valid and well formed.
Destination MAC matches the interface MAC.
No RX errors or CRC issues at the hardware level.
ARP reply is visible via driver-level logging but not via tcpdump.
Neighbor entry remains in INCOMPLETE state.

Questions: -
Are there any known issues in Linux 5.15 where ARP replies are dropped befo=
re
reaching the neighbor subsystem?
Could RX offloading, VLAN filtering, checksum offload, or NAPI GRO/LRO affe=
ct
ARP processing in this scenario?
Has anyone encountered similar issues on automotive BSPs or embedded Ethern=
et
MAC drivers?

--=20
You may reply to this email to add a comment.

You are receiving this mail because:
You are the assignee for the bug.

