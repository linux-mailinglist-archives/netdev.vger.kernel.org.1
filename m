Return-Path: <netdev+bounces-70997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25191851854
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 16:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D50BE287704
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 15:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA34A3C68A;
	Mon, 12 Feb 2024 15:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=naccy.de header.i=@naccy.de header.b="P+XqEQOu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AmIxZ2rQ"
X-Original-To: netdev@vger.kernel.org
Received: from wflow3-smtp.messagingengine.com (wflow3-smtp.messagingengine.com [64.147.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CCB3C689
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 15:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707752623; cv=none; b=UiS79BCN8rOxkV4sprhJBctxK8bx8dsgiixjsR54XV4uCk1PuD4a29OATxUDRtuAg+8Ud4td9rZ6DoFKXvBwBRCwvmthZRGEjDsk/O/oHeNa/ew+CJ+DLmpr4870TGGa2EkVhJQMx/2KcXjvkHcRxqPcFQHZK9VsLRb38sdtgEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707752623; c=relaxed/simple;
	bh=8Q2zDym3Hvxydi9Ks4V6IV+pPWzOUBinKGWxn2fgzlI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rXhKNE8nejuZkj4AaTwMk+KRTICKORmQxH/vDSxgc/j3L8TONriCAWv0YPF79aw1l2i1oetX62jwsReuxgrn3jSUo2c6CmtjPCiI6fPUKf74ndpTrJNy0Scj3KgGE0rXz4/yRRv+PwjmGqvrpBO3fGVls0pXHW+Hu1ubbdfK6io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naccy.de; spf=pass smtp.mailfrom=naccy.de; dkim=pass (2048-bit key) header.d=naccy.de header.i=@naccy.de header.b=P+XqEQOu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AmIxZ2rQ; arc=none smtp.client-ip=64.147.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naccy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naccy.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailflow.west.internal (Postfix) with ESMTP id 788942CC0468;
	Mon, 12 Feb 2024 10:43:39 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 12 Feb 2024 10:43:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=naccy.de; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1707752618; x=1707756218; bh=ha2/GGd9CRYEhZ7TszRUA
	RHpfDarq2qGho84nlukgaE=; b=P+XqEQOubZHhLjyFj2L3jG3upNNevgLNGmGDd
	d6ZsEwhII1tBKUudKgXPuhsyLo13VnW+xykoLA1cXUjcz+FpjbUJaT4IzvFO4FCG
	6yyIU1hR6qoSbOugSiBsasXdWgnuDUHfjSWhGhzYbScwEd5K8T+L7KIgYUfBvY9E
	wPLNtR+RJ3Ynqe05pytAKiEGZuD/jovsJVRt0+JYma6Dj3q1TdtDKi+YogS2jPWn
	yx24Ggr+G0YHIXRsahiMaEAicDzFIMK8I1FEDFhFcSS5bCa9+hsn4LoPa1WbuB4W
	v4tLoScUYTKUdBr+t8OCCpgcih/WcAKAQSTFgX+MtIbh525cA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707752618; x=1707756218; bh=ha2/GGd9CRYEhZ7TszRUARHpfDar
	q2qGho84nlukgaE=; b=AmIxZ2rQomQ06cmlQeN2vhMKSttl/rMsHryWG0XkB+EM
	jzAanmiip2zl/eUvB03ynX1oh8jAiXlb3ZwWEpL+vcffsYk5EZgXcgKfZGYm4gRq
	iCGIQPzHqgbp0Humqxd1c/Z5F5LdBaH338ZSXhP3uQxyCaQjyU12qeJKAJfflOah
	VhOxCQUn8SKN88f9e29VzUnadc8Zi46dsAEsmXXjozSGN6lNGXbriHrow0/zc4qd
	7LLA7uyJ7jr49xk+TBLVyB1LCII+INMUzI3oTR0SRKqiNdh2NAtG1J9QF7OmkWWj
	2SaCKPeoEhlkN90cnB2fJ1Mtj+LxtiilUUmxnu0nUg==
X-ME-Sender: <xms:qjzKZSSnzOIJ9R21zYbdmhoLz4iN1DBkr0fT_VENcihsxALzo4Ne3A>
    <xme:qjzKZXyecwRyu01p7dPP7aggQmjcLAprFzo7FAQ5EeoihbTfTQZHrfCBTG6EXyr_e
    d7v4iMNd1JXyv5ITSs>
X-ME-Received: <xmr:qjzKZf06Tl-k90xvYWE424Ni-VTuDhGw0757jkCOK-ZmcuXYWXCulhrw_3ZEeoDSlIiNR6MWauZbifUpf5P25GiUlt43QOPGLIk8NjE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefgdejkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefsuhgvnhhtihhn
    ucffvghslhgrnhguvghsuceoqhguvgesnhgrtggthidruggvqeenucggtffrrghtthgvrh
    hnpefhffeiiedvieehgeeljedtueeijeelgfffjeefheehhfehffeifeegudfhheeihfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehquggvse
    hnrggttgihrdguvg
X-ME-Proxy: <xmx:qjzKZeDXbemDAIqJ7Xu3SOEYNmNormLskOQGIAZ2ymbyq1G94M2n6A>
    <xmx:qjzKZbjue5LsQ0ehXU9xWhpyVWB0t9RQWhCKXZo2I4qTuNojuRmOGg>
    <xmx:qjzKZaqQxNm5RMNNRLhE4qTGp2tJmXzTo_hDI5SCvaoFGipmcnxhvg>
    <xmx:qjzKZWUdAhecHkujAB-Op3fps-68WQbcxIFfZYMECWK72MvUVE9LDjt11XnDz6Hm>
Feedback-ID: i14194934:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Feb 2024 10:43:37 -0500 (EST)
From: Quentin Deslandes <qde@naccy.de>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@gmail.com>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	kernel-team@meta.com,
	Matthieu Baerts <matttbe@kernel.org>,
	Quentin Deslandes <qde@naccy.de>
Subject: [PATCH iproute2 v7 0/3] ss: pretty-printing BPF socket-local storage
Date: Mon, 12 Feb 2024 16:43:28 +0100
Message-ID: <20240212154331.19460-1-qde@naccy.de>
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
 misc/ss.c     | 399 ++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 396 insertions(+), 9 deletions(-)

--
2.43.0

