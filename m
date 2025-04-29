Return-Path: <netdev+bounces-186776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F23B4AA10D9
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 17:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBE233BEFEC
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 15:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74BE23CEFF;
	Tue, 29 Apr 2025 15:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ekWnGT0Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B393A218ABA
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 15:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745941631; cv=none; b=HsZjajMemHKbJImEwKr5VQGDeBQTupZVRXNPCDsp4aDk5a7uuYoDGFeHDsx/xgbmH6BvaUAZY0j1gJPPntD2CC9cFfX3UjxJDw5NfBu3qQ4bEYuETY44gfeRJN/6LN8MwuOENOtu8mPSrozshf1MHlQ56UxI47i26oYLmrMl290=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745941631; c=relaxed/simple;
	bh=QSBiHoqx3+M3umOoryQ3rDqKy5ZFqk3iPCset6hR1FE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gRWYDJJh25jnFPHA+2rPvr9UnheTf56SKItKT8IdH8fzx9Tl4o1HPdQef2S/U/s4snk2tnGBkyTvi0gmT9z1XTPWna8JYUHcq5o64c0cgjOA8u8t//cn3yavbeuznoSN4Z6i9tt7IXXWP1LFHxceUkCjbsSxMKH8gstOEOfPbc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ekWnGT0Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AAE1C4CEE3;
	Tue, 29 Apr 2025 15:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745941631;
	bh=QSBiHoqx3+M3umOoryQ3rDqKy5ZFqk3iPCset6hR1FE=;
	h=From:To:Cc:Subject:Date:From;
	b=ekWnGT0Y/onl8pv2ngqxvD6w6lOfoMrNkgkrfGzGSL4JpfpNYxARKIElwG3hCq1lB
	 0vms9BoXKUBa6AKjNxGlfLe1vKQU/M1/ypswA6p/Rn5Yz3uiikZba8T8C78ZmQAykt
	 6pwlXyKyLxTNQy+x5XRsdT8E9qvptBx3ANbComAkPezi8CeJ+7Vneg7Vsj16RjNb8q
	 sDjbDlmawZqvxsaFi2bgfY/LFVxrSlA7LicFaPp2UVhSw0ObnFB/HfC3wVjN1nGO5Y
	 6WhH18fBX63j1YN3NBwawl2VT054cXa1fNUvwFK11mJRaSds/PItsoxbqdLi4pc646
	 N3yphwpqQNG6g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	jacob.e.keller@intel.com,
	sdf@fomichev.me,
	jdamato@fastly.com,
	nicolas.dichtel@6wind.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 00/12] tools: ynl-gen: additional C types and classic netlink handling
Date: Tue, 29 Apr 2025 08:46:52 -0700
Message-ID: <20250429154704.2613851-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series is a bit of a random grab bag adding things we need
to generate code for rt-link.

First two patches are pretty random code cleanups.

Patch 3 adds default values if the spec is missing them.

Patch 4 adds support for setting Netlink request flags
(NLM_F_CREATE, NLM_F_REPLACE etc.). Classic netlink uses those
quite a bit.

Patches 5 and 6 extend the notification handling for variations
used in classic netlink. Patch 6 adds support for when notification
ID is the same as the ID of the response message to GET.

Next 4 patches add support for handling a couple of complex types.
These are supported by the schema and Python but C code gen wasn't
there.

Patch 11 is a bit of a hack, it skips code related to kernel
policy generation, since we don't need it for classic netlink.

Patch 12 adds support for having different fixed headers per op.
Something we could avoid in previous rtnetlink specs but some
specs do mix.

v3:
 - [patch  7] fix typo in a comment
 - [patch 11] improve grammar of a comment
v2: https://lore.kernel.org/20250425024311.1589323-1-kuba@kernel.org
 - [patch  3] use Jake's suggestion
 - [patch 11] move comment
v1: https://lore.kernel.org/20250424021207.1167791-1-kuba@kernel.org

Jakub Kicinski (12):
  tools: ynl-gen: fix comment about nested struct dict
  tools: ynl-gen: factor out free_needs_iter for a struct
  tools: ynl-gen: fill in missing empty attr lists
  tools: ynl: let classic netlink requests specify extra nlflags
  tools: ynl-gen: support using dump types for ntf
  tools: ynl-gen: support CRUD-like notifications for classic Netlink
  tools: ynl-gen: multi-attr: type gen for string
  tools: ynl-gen: mutli-attr: support binary types with struct
  tools: ynl-gen: array-nest: support put for scalar
  tools: ynl-gen: array-nest: support binary array with exact-len
  tools: ynl-gen: don't init enum checks for classic netlink
  tools: ynl: allow fixed-header to be specified per op

 tools/net/ynl/lib/ynl-priv.h     |   2 +-
 tools/net/ynl/lib/ynl.h          |  14 ++
 tools/net/ynl/lib/ynl.c          |  12 +-
 tools/net/ynl/pyynl/ynl_gen_c.py | 216 +++++++++++++++++++++++++------
 4 files changed, 196 insertions(+), 48 deletions(-)

-- 
2.49.0


