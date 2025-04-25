Return-Path: <netdev+bounces-185821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6646AA9BCF7
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 04:43:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD8D617A64C
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 02:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49B115573F;
	Fri, 25 Apr 2025 02:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sTV8lDYp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECE87483
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 02:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745549003; cv=none; b=dNZL6ZO4jxwnhpavkF3Lw+3eCW7wGrRjr4nsgo1mvZTlFkVqZwErUws9xV4fuP3H3N2OvaJjiHAa+M3nYnB6BJwTiMqR0RNzPoJwL93RbEs3bDlJ4bQOgoEicQ8kJ0WdWUZVTxxQUULgo8cUL0XWSE6Lg8Ms77cmTJbJ9F/xaBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745549003; c=relaxed/simple;
	bh=FasH8rhgU5Huc3BbOTAL3f7y5GnGEabqTLqe8rqmvRw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tEWrm1rTUq6MM57iYI/TzL8tSzp1cahDC3bw57PtRjipxYl9bfxxrISidtj/U97OdKEViPr8ox+/oMVwmhsuERqu46+0f2wjt1zav82yXxqYfRHVSBcOdwKgHgdaMMY00G8Kx9nxzvbo4vqYBhr1Cy/rdhHJxcI44o89vjyg/YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sTV8lDYp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7256BC4CEE3;
	Fri, 25 Apr 2025 02:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745549002;
	bh=FasH8rhgU5Huc3BbOTAL3f7y5GnGEabqTLqe8rqmvRw=;
	h=From:To:Cc:Subject:Date:From;
	b=sTV8lDYpQJjbH+44ccr+FQYO9qH1XgqjngV4RSyVHkrwZpefuP1jOz7hf8Kjsj9/Q
	 37aCYd14oiQsMcpfPMStCFm2BvbSbTTm5f0gADzDfDuXU5LfK3d6vuX+ZugAvXnG8J
	 mo+MNCO2373FD5UiEpeFRUq66OSuOV2a5YKqqJqken6u0E51M+HEVwoE7eC8jd8Qg8
	 zoiVv8DKiWzhM2Ma0STltw5WzsYLckJ6RC3PABT0XGvm9CaWAJ12s+npDCZrc04Yxc
	 cEwQKFC+dydJzw3wuELq2uzeJA9VIEEq1PMTr27NJZPjlUWm1pgXOKrO+godPyC8Bj
	 c7O6UwNuSH43A==
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
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 00/12] tools: ynl-gen: additional C types and classic netlink handling
Date: Thu, 24 Apr 2025 19:42:59 -0700
Message-ID: <20250425024311.1589323-1-kuba@kernel.org>
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

v2:
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


