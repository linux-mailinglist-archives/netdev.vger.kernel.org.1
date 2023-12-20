Return-Path: <netdev+bounces-59240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB9781A057
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 14:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5174F1F293DA
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 13:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6B736AFC;
	Wed, 20 Dec 2023 13:55:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from 4.mo545.mail-out.ovh.net (4.mo545.mail-out.ovh.net [46.105.45.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E1D36AF6
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 13:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=naccy.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naccy.de
Received: from ex4.mail.ovh.net (unknown [10.111.182.250])
	by mo545.mail-out.ovh.net (Postfix) with ESMTPS id BED2024F7C;
	Wed, 20 Dec 2023 13:19:10 +0000 (UTC)
Received: from bf-dev-miffies.localdomain (77.136.66.130) by
 DAG10EX1.indiv4.local (172.16.2.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Dec 2023 14:19:08 +0100
From: Quentin Deslandes <qde@naccy.de>
To: <netdev@vger.kernel.org>
CC: David Ahern <dsahern@gmail.com>, Martin KaFai Lau <martin.lau@kernel.org>,
	Quentin Deslandes <qde@naccy.de>, <kernel-team@meta.com>
Subject: [PATCH v3 0/2] ss: pretty-printing BPF socket-local storage
Date: Wed, 20 Dec 2023 14:23:24 +0100
Message-ID: <20231220132326.11246-1-qde@naccy.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CAS10.indiv4.local (172.16.1.10) To DAG10EX1.indiv4.local
 (172.16.2.91)
X-Ovh-Tracer-Id: 16847684734160203516
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduvddghedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgggfgtihesthekredtredttdenucfhrhhomhepsfhuvghnthhinhcuffgvshhlrghnuggvshcuoehquggvsehnrggttgihrdguvgeqnecuggftrfgrthhtvghrnhepfeduteevveeluedvvedtieegleefveetjeeukeeigefgtdekudeuheduudegfeefnecukfhppeduvdejrddtrddtrddupdejjedrudefiedrieeirddufedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeoqhguvgesnhgrtggthidruggvqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpughsrghhvghrnhesghhmrghilhdrtghomhdpmhgrrhhtihhnrdhlrghusehkvghrnhgvlhdrohhrghdpkhgvrhhnvghlqdhtvggrmhesmhgvthgrrdgtohhmpdfovfetjfhoshhtpehmohehgeehpdhmohguvgepshhmthhpohhuth

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

Quentin Deslandes (2):
  ss: add support for BPF socket-local storage
  ss: pretty-print BPF socket-local storage

 misc/ss.c | 447 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 438 insertions(+), 9 deletions(-)

-- 
2.43.0


