Return-Path: <netdev+bounces-73729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C31E185E0BD
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 16:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E069D1C21951
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 15:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C5980028;
	Wed, 21 Feb 2024 15:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=naccy.de header.i=@naccy.de header.b="WDYofK1A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RwI96EHB"
X-Original-To: netdev@vger.kernel.org
Received: from wflow7-smtp.messagingengine.com (wflow7-smtp.messagingengine.com [64.147.123.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567FF7BB01
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 15:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708528597; cv=none; b=HguKGzoPKn0+1tlXI8zVINg6w1vO10ZJEjldpJXmkw4IoR8WRp/61OOe6feV5wiqSWOHgjbdC2IBmWNX3OegdhW8w7Br+Uy/KL4mDq5h0IAL2J15GP3fw0tikcGOdir5reiIwdA466F0xNnXVK6DYJ4p+S3nA7YumGTYSlgxDuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708528597; c=relaxed/simple;
	bh=sxGL5WM3JZI8i3sLLcDoNXJ/ieo+oveYBplS55pU8D4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o1RLZNK6auWnT33YUhkVK7RevrQUvYLLqGKgvRzGQP8q1usz5mvehsT376H9HcaYVvwKZO4A7V6XXIj8lE/o+YK/ctOvvAzqbwaHm/i9ia0lJISwGGPeAn9BGx2aJQaijdvhq5nqGoQoRZk13WvC4zh1ucsxNcwptMPJnwmCIG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naccy.de; spf=pass smtp.mailfrom=naccy.de; dkim=pass (2048-bit key) header.d=naccy.de header.i=@naccy.de header.b=WDYofK1A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RwI96EHB; arc=none smtp.client-ip=64.147.123.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naccy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naccy.de
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailflow.west.internal (Postfix) with ESMTP id 763692CC02C4;
	Wed, 21 Feb 2024 10:16:32 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 21 Feb 2024 10:16:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=naccy.de; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1708528591; x=1708532191; bh=8Zlrvc+guY3yLzJcN2KR1
	Bz3CRNwoN3738UVPHkwXa4=; b=WDYofK1AXnUvwx9A/reX3Y1N1q6StDVhm4e0U
	z5WrO/xvKCe1v70hKpQfuwLumB9pWBnjVDaIq3qo5ULMV+JzhGqMPu6+0Vd0sfzU
	0TBQu2Z7d2JUSvqI5XFbyRcdHIj9jXSO0+R4nGSCh4q2sfklFwZnpeEU7+Wa+f1C
	k0Ztc2SFcQTtZ3fSLE3GHa2agoMowLN68y7IwD7my4NZuIRQIN3UccFA5JE4PyAB
	KzLud5xaLa5+etpWQJx0x1GxgY76gM5yfsXaQs0Mzzoo4PyemzQHs1Cqe/oa6YJL
	y6NQJ4015igLy0kNtTrD8S0IF1R2Z5J8riWUyV8QfcXrXy8kA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708528591; x=1708532191; bh=8Zlrvc+guY3yLzJcN2KR1Bz3CRNw
	oN3738UVPHkwXa4=; b=RwI96EHBjBDEIrQUtNdfkh2MnsxR2OPBohqo5OVCUcxM
	R97x+yxSKzhOAwjPe7Vg8H6Zl5PJqVGSGQnKgtwWa9Np0Z9GW3YuuqXJZGcSZmF5
	EAEHZEQ6ZfGO5fejG10zP5f8Py5hE5TRLbNJVVk/cVsXIavT0u1LNRbS9z4gnDgn
	tH48nglVpDHMl3OCSJYNAG8Bkcv0jP72dqullsFGKJiiwVKyzE4XidGe3+vJ6bpx
	/ss88FSdW6ywWB9CrbHR4Le2TvG8HrqKr9E/5+HpIAWgW+Q6vqmhj5qkWApacyIP
	Av+3AytijN1Uug7rg8O1y0RS02lBocy7cjOcHts0YQ==
X-ME-Sender: <xms:zxPWZd9QtPETzs3eb91AGo8q8Fu-Q8o-65kcZjnyQ1OkxbLrkF9yJQ>
    <xme:zxPWZRvl-CG3PtbvkZgwWVjfX2cH9F05LFEw9VNaOVp1lraFOZ61T09sPHoAVgJgO
    u9p58fLwF-tLM-CUFE>
X-ME-Received: <xmr:zxPWZbAmFKtgUX4xBw4lAvLkRXGf3NTBBmKeIjlHd8hnhlMmeA9zx7Mo0-q27fMi33ZMcjncq7QD3A3Am_dGle8hh3Jpm4QTgrHXm-gADw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvgdejgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefsuhgvnhhtihhn
    ucffvghslhgrnhguvghsuceoqhguvgesnhgrtggthidruggvqeenucggtffrrghtthgvrh
    hnpefhffeiiedvieehgeeljedtueeijeelgfffjeefheehhfehffeifeegudfhheeihfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehquggvse
    hnrggttgihrdguvg
X-ME-Proxy: <xmx:zxPWZRcFeoHzG4x1v-6ml1rFIRzzzzrvdUWGg0L8SOayVfXd7Ty8uQ>
    <xmx:zxPWZSOZ_qBYugwIqybtnh187ezQdIJSnfnF-suYA8-z79CadLVbWQ>
    <xmx:zxPWZTlCJ1ExAAhO5YjiX_uthw2CiZYi4FfDTGWshMVHIbJfqSURIg>
    <xmx:zxPWZeCr47c-rg3CwbS5THdSX3dDN6jPP4sdYcePoyhm3FP8-Gx8LMweyiiBzNPb>
Feedback-ID: i14194934:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Feb 2024 10:16:30 -0500 (EST)
From: Quentin Deslandes <qde@naccy.de>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@gmail.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	kernel-team@meta.com,
	Matthieu Baerts <matttbe@kernel.org>,
	Quentin Deslandes <qde@naccy.de>
Subject: [PATCH iproute2 v9 0/3] ss: pretty-printing BPF socket-local storage
Date: Wed, 21 Feb 2024 16:16:18 +0100
Message-ID: <20240221151621.166623-1-qde@naccy.de>
X-Mailer: git-send-email 2.43.1
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
in COL_EXT.

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

Changes from v8:
* Remove usage of libbpf_bpf_map_type_str() which requires libbpf-1.0+
  and provide very little added value (David).
* Use ENABLE_BPF_SKSTORAGE_SUPPORT to gate the BPF socket-local storage
  support, instead of HAVE_LIBBPF. iproute2 depends on libbpf-0.1, but
  this change needs libbpf-0.5+. If the requirements are not met, ss can
  still be compiled and used without BPF socket-local storage support, but
  a warning will be printed at compile time.
Changes from v7:
* Fix comment format and checkpatch warnings (Stephen, David).
* Replaced Co-authored-by with Co-developed-by + Signed-off-by for
  Martin's contribution on patch #1 to follow checkpatch requirements,
  with Martin's approval.
Changes from v6:
* Remove column dedicated to BPF socket-local storage (COL_SKSTOR),
  use COL_EXT instead (Matthieu).
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
 misc/ss.c     | 410 ++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 407 insertions(+), 9 deletions(-)

--
2.43.1

