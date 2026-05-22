Return-Path: <netdev+bounces-290871-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAl6HXB8EGrdXwYAu9opvQ
	(envelope-from <netdev+bounces-290871-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 17:55:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E337A5B7389
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 17:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B223E30DDD70
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 15:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FAB376A02;
	Fri, 22 May 2026 15:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="maFg3rz2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956AF25B0A0
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 15:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779464491; cv=none; b=IBx6EN7xL8ZgnN6tnB2Uy1tnHOAgkZ1EW+63nG5iUifIWnjYA+6KURqHcZjZqv5k9Ijt0KnFTk1eCPyNKiPK3KlJ3otEWBiVZT0uSzmkVD51wToPzuk5/VVvL8UcVfW3ziBkFNByKwVrAq2s+6lw37YkfWZOwcDbsDndbu/9EVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779464491; c=relaxed/simple;
	bh=mQGHAvVaULvUTzHfl5O0N2R9WyRsRACnUIolwju07yE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JdnWbhpq7TBl46yhClJ2Cdh65sXO6A0FDqLzzHv0s4oJHAeupQoZf3Y0HDgYWC77qvS4vuOBmD+R9Qo4wE/i53qBQ38upT1CtmynNIaEzQjq7ZVBSG1WvkcyO4Wu/oMd+ZwAdTGmwNhehlhgqED0VkA48dKd9U5Izn1CosLThWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=maFg3rz2; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-367d88b9940so4877248a91.1
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 08:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779464490; x=1780069290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WYpGjrpcI/QWRW0u6cXWL87F6QxybhFOh1NZVYhUS8Q=;
        b=maFg3rz2SlbRluoIRGxievTyvsUN6hHKuh+Rb7rB4Z1S9/pGKPp/lBNFLg8qbw4gvE
         MzaR6CA0nNVhxS/SPJBQXjxGwol1pLaZG9rbABe02NI7/9Fi8NSv0yAccbhUxI3oLbrv
         iLqlmLsZQD5cY8/ZwVRmkpgGPzNClV4nz6fABYh3DwptwsScrVktVxin6Vi5lcMb1QID
         yxTf9n+wXR905YhcWH3aYgMRThiMK/h0/pmezP4T+1D01v/HjnwTE1e6o11R9uKcOLhn
         7oOW7llm9bjc+MsYdc0fbl/gfdYPF2QFrjvte8BFuMvYXvMh4JN/y9yPxdDfl5uLQJ2O
         ovaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779464490; x=1780069290;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WYpGjrpcI/QWRW0u6cXWL87F6QxybhFOh1NZVYhUS8Q=;
        b=mwlnf5rRde1eE4uL1Wa77DW7MNGhSVSl/1Bf7dIwXyiHADURLB58VD+itk5I7GlKHv
         Z7WegVwdfgpc9zrfnihqgSF3cdQgFFP0Fmtebx8f77gpRemmxX6R3WA4a9lBRMuQYNHO
         iL/xny+mBQsBu5M35uiLG+0SAOU4soSJFVkIFWLIvHFlBYs2iSgGbzItccFAOeffO4pN
         iJSnUfcfYxYoAUj6k+nodbvfM+jheE89F5vIN0AN8vQAxwXgpPwhZngvM+OD7bP3KOf/
         w944KopaNx4lZqFo75YUKDnOzw2Wll9WGsClPje/9cxmjc2uPZ0/fO7fC301In2725ey
         Y4DQ==
X-Forwarded-Encrypted: i=1; AFNElJ8gWG9rQjcVrpnP6iarBtHs3ffB71C84KskYWK5O+3VZ3npEXPw45iOsRNu/23BAMl4YafvUTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxogkIigEQQJu/gYtIhKXk/tXgYnCgmn1Dgdjpe4oq8DQ6WDumy
	6iZ6Fwg/GaN7CLxkQ6PP8o0El78FeHBQmlsMNdJxjiXODXwFRcvcHKN7
X-Gm-Gg: Acq92OFiMj+tFYDsbSt1i7uNELwSNB0JHkV6fbxyipEHxwFdtNGEzbqtP5Js5CiEXAm
	SIvBOmVfJb/cNeRILV8Ppr4uPOLROxzSIZUrVT9B2FF8vQtLBVf1UrC9KL5ScwuFmTo62hE9NAv
	YZOwshLqf6p722b3L+eAUe6YI+3M9CcqzdugQZ7yMRXdk0ixgC93C/6z7YTObrcR9AnmCHVADlq
	v8qutO6P5frrAzHJmZVRsK1oGv+xgLNnxGj3biHdmUSI6ISVwJulVnx1Knc2H5JQt9PQhlkqfTA
	3KTGZM5SfN0WAoqbkSfhG+lxRRM7e2BXvDjUfwMiowRvfrVWMtlikIpwEMAd3zOryB5308FoJQU
	SnepfoXnDE0jK21u2QhAmUkeHtfV7PceKV8cSWtzGNhJ4/sPnM7TDqFPo2/KZqbLc3cogAhMY0L
	quFT2OX1Xl1q/hbVpJ3T267hYm2Y/W4Nf6NlLBwGgoEk67d0EQ
X-Received: by 2002:a17:90b:3887:b0:369:7433:2fe with SMTP id 98e67ed59e1d1-36a676f5e4cmr4109664a91.6.1779464489866;
        Fri, 22 May 2026 08:41:29 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a7212aa06sm1365450a91.3.2026.05.22.08.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 08:41:29 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: Petr Machata <petrm@nvidia.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: List iterator used after loop in mlxsw_sp_fid_port_vid_list_add?
Date: Fri, 22 May 2026 23:41:25 +0800
Message-Id: <20260522154125.121895-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-290871-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,maoyixie.com:url,usenix.org:url]
X-Rspamd-Queue-Id: E337A5B7389
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi all,

I came across what looks like an iterator used after the loop
ends in drivers/net/ethernet/mellanox/mlxsw/spectrum_fid.c
(linux-7.1-rc1), in mlxsw_sp_fid_port_vid_list_add(). I would
appreciate your input on whether this is worth fixing or whether
I am misreading the pattern.

  list_for_each_entry(tmp_port_vid, &fid->port_vid_list, list) {
      if (tmp_port_vid->local_port > local_port)
          break;
  }

  list_add_tail(&port_vid->list, &tmp_port_vid->list);

When the loop walks the whole list without break (the new
local_port is larger than every existing one), `tmp_port_vid`
walks past the end of the list and `&tmp_port_vid->list` aliases
the list head via container_of() offset cancellation, so
list_add_tail() resolves to inserting at the tail. That is the
intended behaviour for the case where the loop falls through.
The dereference of the iterator after the loop ends is the part
I am unsure about. Same shape as the Koschel cleanups from 2022
(99d8ae4ec8a tracing, 2966a9918df clockevents, dc1acd5c946 dlm,
and others) and the "controlled container confusion" pattern
described in [1].

I drafted a candidate fix that initialises an explicit
`insert_before` pointer to &fid->port_vid_list (the list head)
and overwrites it to &tmp_port_vid->list only on early break,
then passes insert_before to list_add_tail(). The iterator is
no longer dereferenced after the loop and the diff is 5+/2-.

I built spectrum_fid.o on x86_64 with MLXSW_CORE + MLXSW_PCI +
MLXSW_SPECTRUM + NET_SWITCHDEV + VLAN_8021Q at W=1 and the
object compiles clean with no warnings. I also ran a small
userspace mock of the two versions across seven scenarios:
empty list, single entry with the new local_port above, below,
and equal to the existing one, and multi-entry insertion at
head, middle, and tail (fall through). The final list ordering
matches in every case.

Does this look like something worth a [PATCH]? Happy to send
one if so, or to drop it if the shape here is fine.

Thanks,
Maoyi
https://maoyixie.com/

[1] Jakob Koschel et al., "UNCONTAINED: Uncovering Container
    Confusion in the Linux Kernel", USENIX Security 2023.
    https://www.usenix.org/conference/usenixsecurity23/presentation/koschel

