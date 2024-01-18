Return-Path: <netdev+bounces-64118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC903831307
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 08:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CC3F2822B5
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 07:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22BE8F60;
	Thu, 18 Jan 2024 07:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=naccy.de header.i=@naccy.de header.b="Fdf6dnrI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tit2fNZ8"
X-Original-To: netdev@vger.kernel.org
Received: from wflow2-smtp.messagingengine.com (wflow2-smtp.messagingengine.com [64.147.123.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2EDBE50
	for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 07:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705562090; cv=none; b=UN4GeJT17I6gvUPD8QPlYDYNvjWePnct9F17zetZ3BY/1QhzBq9tdVKMH34pEoGw3s1W1jgt3hbi4PE6BmfLMX8xqYq0oP02dljccsnRIhmDcHxcGVoKZFaYGWaNbXfiSKgjHDtqGJYZt09cZ3yZmiMEPH12XJCUxqP/veeXvRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705562090; c=relaxed/simple;
	bh=KUVgivdhZEzLCu5zo3/O9KTMEwC6WqkE2GfgkXjdxpo=;
	h=Received:Received:DKIM-Signature:DKIM-Signature:X-ME-Sender:
	 X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding; b=HzyjXOYmV6/vfd1nBFgaYoC0qbQrdVKY2fpdJDbbPxE3HeNr3CPILCjdCgA/XWRSMAWQNz3HaZYSt2z8etYewpRBwQomuE0aEmJxwjdJaQD8NOAZWE19WqDvfiWYx/2QlQY5tqHNOj0UQ9AnjJGdWSk5L6zkvwv+fAnZXgN0dhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naccy.de; spf=pass smtp.mailfrom=naccy.de; dkim=pass (2048-bit key) header.d=naccy.de header.i=@naccy.de header.b=Fdf6dnrI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tit2fNZ8; arc=none smtp.client-ip=64.147.123.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naccy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naccy.de
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailflow.west.internal (Postfix) with ESMTP id BBC882CC006E;
	Thu, 18 Jan 2024 02:14:45 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 18 Jan 2024 02:14:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=naccy.de; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1705562085; x=1705565685; bh=7aRTAYX5R94l0DBpUNpuo
	R0w/jCr1r9T3n529OS2yX8=; b=Fdf6dnrInvAXZqr+FcVwtpXPTzlwhOSJSo0GQ
	J5xLdE/vI7CH4lhCc0HK0h2Z/nAeYVMMCYQN09eye87Sxg2jAW1YO3GcnZFaFMPf
	nZEshjhMp59HvUlVApxlENOyy5ufw+i5hWbW6YUTYpWJvvlLHvsnfpQrt5+gm2uG
	M/b69u6taLqyi3bYJGbW4521ZHeJyeLJ7top8x6gHba8bOJY/NPbBsj+3tJyjx/X
	Ws5KxtL3hJQA0iFXfewPAp7zB737Uf+kCmHdsshlKdvWdzVc0QCEPHb9LFwgkQJp
	gY6zHMMOG4MaXe1w2A9tsDRUzIEm+oOwJ7gYNJpyWi/17Ct1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705562085; x=1705565685; bh=7aRTAYX5R94l0DBpUNpuoR0w/jCr
	1r9T3n529OS2yX8=; b=tit2fNZ8BgM1coY3HJb6ZIO0F4NR5JxR8r3BaWEsnp5O
	i9zhV5CvRiM+syNoGB0NdgI4fTl64kQcMNBfKPyGdfhTXjqScQoUwvxDNqot3HzX
	y6GZMOFIaFiV7rsIUJrWXrKVnraa9IixF22c9sSVVgvWurXFd8NENVnUYjS3G2xB
	UNI1B5XCNRPKlwjndRQgovUXdNfc7YnqnP+OpLA8BNvKSyqQqGak238FxQfBgrf6
	SL2lX+2un1Dc+x6yTi5EYaX9ygAKZHqMLUpiRilYxLTyGaJH31jCAr1NWMZYLkC3
	NDHY3Csq7BY+aJLf4B7X9moVVg9AKTNMF6xIeAg64g==
X-ME-Sender: <xms:5M-oZVQqMXz5cQoHQuWS5qxXjTULV0GiODqU7QY8jZk6uvO-cu_6uA>
    <xme:5M-oZeyZXDJLWS3AhI9eWofC_R6IEfXm7mECaDrD-NIV6bsfXHsspMFKWz64Gk3a6
    qneprIB1F5F6nNUI5o>
X-ME-Received: <xmr:5M-oZa3ppygWrQcQs-nqi8hDDymVNYUjgRpl5q-P8vRd6uHJiRpGFX0-jUUYXKv6aPBSQ5tX5VMeLS_kYcAxfgSShlxc7oe0b8iLyETtYA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejiedguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefsuhgvnhht
    ihhnucffvghslhgrnhguvghsuceoqhguvgesnhgrtggthidruggvqeenucggtffrrghtth
    gvrhhnpefhffeiiedvieehgeeljedtueeijeelgfffjeefheehhfehffeifeegudfhheei
    hfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehqug
    gvsehnrggttgihrdguvg
X-ME-Proxy: <xmx:5M-oZdBYz-F7gh8Ynn_9OXBYvtJBl4GGD1maORBdFp0PevJQkZmRyg>
    <xmx:5M-oZeh0F-ubj06WlLRNYb3CiPK0_xYGFnhz86ovOH8d0OALRu7PJw>
    <xmx:5M-oZRrTy6ID9VEGUw5Nx4eu1GzgiEL-2I6zW0YaFCcqYtTZ66cU8w>
    <xmx:5c-oZQZx8JfV2kXpvrHS7423QiVJ5hYiyD7BJxaUGd-UqyOtczl8TIzQ8N9z32aj>
Feedback-ID: i14194934:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jan 2024 02:14:43 -0500 (EST)
From: Quentin Deslandes <qde@naccy.de>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@gmail.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Quentin Deslandes <qde@naccy.de>,
	kernel-team@meta.com
Subject: [RFC iproute2 v6 0/3] ss: pretty-printing BPF socket-local storage
Date: Thu, 18 Jan 2024 04:15:09 +0100
Message-ID: <20240118031512.298971-1-qde@naccy.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BPF allows programs to store socket-specific data using
BPF_MAP_TYPE_SK_STORAGE maps. The data is attached to the socket itself,
and Martin added INET_DIAG_REQ_SK_BPF_STORAGES, so it can be fetched
using the INET_DIAG mechanism.

Currently, ss doesn't request the socket-local data, this patch aims to
fix this.

The first patch requests the socket-local data for the requested map ID
(--bpf-map-id=) or all the maps (--bpf-maps). It then prints the map_id
in a dedicated column.

Patch #2 uses libbpf and BTF to pretty print the map's content, like
`bpftool map dump` would do.

Patch #3 updates ss' man page to explain new options.

While I think it makes sense for ss to provide the socket-local storage
content for the sockets, it's difficult to conciliate the column-based
output of ss and having readable socket-local data. Hence, the
socket-local data is printed in a readable fashion over multiple lines
under its socket statistics, independently of the column-based approach.

Here is an example of ss' output with --bpf-maps:
[...]
ESTAB                  340116             0 [...]
    map_id: 114 [
        (struct my_sk_storage){
            .field_hh = (char)3,
            (union){
                .a = (int)17,
                .b = (int)17,
            },
        }
    ]

Changed this series to an RFC as the merging window for net-next is
closed.

Changes from v5:
* Add support for --oneline when printing socket-local data.
* Use \t to indent instead of "  " to be consistent with other columns.
* Removed Martin's ack on patch #2 due to amount of lines changed.
Changes from v4:
* Fix return code for 2 calls.
* Fix issue when inet_show_netlink() retries a request.
* BPF dump object is created in bpf_map_opts_load_info().
Changes from v3:
* Minor refactoring to reduce number of HAVE_LIBBF usage.
* Update ss' man page.
* btf_dump structure created to print the socket-local data is cached
  in bpf_map_opts. Creation of the btf_dump structure is performed if
  needed, before printing the data.
* If a map can't be pretty-printed, print its ID and a message instead
  of skipping it.
* If show_all=true, send an empty message to the kernel to retrieve all
  the maps (as Martin suggested).
Changes from v2:
* bpf_map_opts_is_enabled is not inline anymore.
* Add more #ifdef HAVE_LIBBPF to prevent compilation error if
  libbpf support is disabled.
* Fix erroneous usage of args instead of _args in vout().
* Add missing btf__free() and close(fd).
Changes from v1:
* Remove the first patch from the series (fix) and submit it separately.
* Remove double allocation of struct rtattr.
* Close BPF map FDs on exit.
* If bpf_map_get_fd_by_id() fails with ENOENT, print an error message
  and continue to the next map ID.
* Fix typo in new command line option documentation.
* Only use bpf_map_info.btf_value_type_id and ignore
  bpf_map_info.btf_vmlinux_value_type_id (unused for socket-local storage).
* Use btf_dump__dump_type_data() instead of manually using BTF to
  pretty-print socket-local storage data. This change alone divides the size
  of the patch series by 2.

Quentin Deslandes (3):
  ss: add support for BPF socket-local storage
  ss: pretty-print BPF socket-local storage
  ss: update man page to document --bpf-maps and --bpf-map-id=

 man/man8/ss.8 |   6 +
 misc/ss.c     | 413 ++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 410 insertions(+), 9 deletions(-)

--
2.43.0


