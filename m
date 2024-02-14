Return-Path: <netdev+bounces-71777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB198550D2
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 18:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 538B528FD70
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 17:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C476A1272CA;
	Wed, 14 Feb 2024 17:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=naccy.de header.i=@naccy.de header.b="OD0WkNJU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K1vDOeMD"
X-Original-To: netdev@vger.kernel.org
Received: from wflow2-smtp.messagingengine.com (wflow2-smtp.messagingengine.com [64.147.123.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772C2127B4B
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 17:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707933123; cv=none; b=qM6qlkOHCDrl7yZhEZl5iYW6fATQLsOx7XJ27pLuFdFjGfv7cPjaG66b7ptlA3BDy/M2sAfxo3b+3tBzxBCuvo4oBPTqwTGQrMZadsV4uMHdApqJwku96hA/QBVtcwiTEtHYIeFczgLfkSeABinCOR0BZEUoSTRlicb+CbgWbII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707933123; c=relaxed/simple;
	bh=iKlMzOvO7wOkGmYcXWpPmmsEJ/vZpLj6vS3LzkOExPI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bVQQuB1CcyUePi88Ba6WuML8B6b3MCtAA5k7pAE7dBt06FvwaqNs6GSRyIxuEOLjETsCBALNwLSOxArQR6w4dYGW7P6fXzDjQNvYOfEpIyGO9AXDtgGrTuYcMwfw9RTYjQ2zCGNUg6r+pLi5JLR7gc6SYkdorvrmZ8vis3R6Pro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naccy.de; spf=pass smtp.mailfrom=naccy.de; dkim=pass (2048-bit key) header.d=naccy.de header.i=@naccy.de header.b=OD0WkNJU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K1vDOeMD; arc=none smtp.client-ip=64.147.123.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naccy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naccy.de
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailflow.west.internal (Postfix) with ESMTP id AFF6C2CC02BE;
	Wed, 14 Feb 2024 12:51:58 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 14 Feb 2024 12:51:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=naccy.de; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1707933118; x=1707936718; bh=7DXs/JPhCuc0YrZvFU9/m
	d/8dz0cuhVcDK9itk64MEE=; b=OD0WkNJU014rofMkFZJfveKrVpmo0ojU94mQ6
	hUBCxKNBuUZY2shk7iaGCV2nK0hKaTbyU0KBMSZfpxOetPfbgWXvskWRbsn/nhoX
	Wo1HoDxUUOhjpcp8PIhBSB3EcyvQ3xrzLSOXLu7mzDLdMELKx2nkDzlpruaHEf/6
	Vw+31PXKl4onOgsRRi/HTxnya0207++Ej7EfEwcTHktzHqnRCs5vXvaH3KnqexQC
	UCYbAUCKieKLGQBzvvPYdiWMpeZPhyXh2XJwHJ774RsthjBzoXuusE3SrMSzcvK3
	k1N1P62+WofqQv+fEVTFgrfL4F91+UyJP7jDkSgSBzFdvjsbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707933118; x=1707936718; bh=7DXs/JPhCuc0YrZvFU9/md/8dz0c
	uhVcDK9itk64MEE=; b=K1vDOeMDr5ovOs2Giew6ZeCDZ+Ev9TcLnjLGqEB5yvYR
	VYt8/90yacBlVlBpkCdUe57vRDc/PbvM7ieF35G5Yu3BlApJXD2RfNVEzXPO0ns9
	Uf+BkXYhP3kqCOlebP4QzGp8GRjcYAe41f0iSThj+TSlc60z/dUThgF4dDPy49Rw
	C3Y/LrZNAyg7ZCMmebY6LhEgyCcLvphGPXmIyjdZoWHmWdRWhEJQYpnRv7wB3Yt+
	Ce/EepJPK9wjrkbJ/6t/4oeqJKdpJxJiBZgLJbAcHcol2LyhXJXIJBvk6bBFUEu3
	cFUylMHnH7lpXh7tr/JsGtkTcaB6JlC9ixUMXC2I2g==
X-ME-Sender: <xms:vf3MZULYIBc8t9CImr6SlLTfNVvA5YxLZ1PLrN8qOKiXTBmS5lPikA>
    <xme:vf3MZUJ8FTzfhN81t9hg4U8f3gTh4tCpctD0zUuAK9A-Pzs7OM7fZFm0InfPcUfV0
    i8bWKd8liLnJyeJzdo>
X-ME-Received: <xmr:vf3MZUuMAaOM5zGnBoJiTIkfYsvBm3T6kxoyIFEyCAVd1kWuQmc0oxuL8pJtEqdr-3ZnkHLab_in0FKlaiQCrT3fUFGh-Ytl0X-etUKPSA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejgddutdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepsfhuvghnthhi
    nhcuffgvshhlrghnuggvshcuoehquggvsehnrggttgihrdguvgeqnecuggftrfgrthhtvg
    hrnhephfffieeivdeiheegleejtdeuieejlefgffejfeehhefhheffieefgeduhfehiefh
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepqhguvg
    esnhgrtggthidruggv
X-ME-Proxy: <xmx:vf3MZRaKu2-b5Ce4WQ6fw2aXVA22-P3Y4d18huObOX51L4EV6Fjilw>
    <xmx:vf3MZbZTda2a_K410ixQvoQVNant596Zg3JVtbB-5TLsUj-C3K-_rA>
    <xmx:vf3MZdDE2MTU3eRQsGWLDD4MvEpDVVHx3ToQS8z6JHYsVr9EQluN_g>
    <xmx:vv3MZQPSXIowKv7jb5cKk7-kmkYyOo0J9567f61iIMvNgK3rk_943VVCplS2ZTtG>
Feedback-ID: i14194934:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Feb 2024 12:51:56 -0500 (EST)
From: Quentin Deslandes <qde@naccy.de>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@gmail.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	kernel-team@meta.com,
	Matthieu Baerts <matttbe@kernel.org>,
	Quentin Deslandes <qde@naccy.de>
Subject: [PATCH iproute2 v8 0/3] ss: pretty-printing BPF socket-local storage
Date: Wed, 14 Feb 2024 09:42:32 +0100
Message-ID: <20240214084235.25618-1-qde@naccy.de>
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
 misc/ss.c     | 404 ++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 401 insertions(+), 9 deletions(-)

--
2.43.0

