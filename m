Return-Path: <netdev+bounces-44737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C42DB7D97C9
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 14:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 723982823A2
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 12:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B79518C10;
	Fri, 27 Oct 2023 12:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992F91118C
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 12:21:23 +0000 (UTC)
X-Greylist: delayed 337 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 27 Oct 2023 05:21:20 PDT
Received: from smtpout11.r2.mail-out.ovh.net (smtpout11.r2.mail-out.ovh.net [54.36.141.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528C210A
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 05:21:20 -0700 (PDT)
Received: from ex4.mail.ovh.net (unknown [10.111.208.36])
	by mo512.mail-out.ovh.net (Postfix) with ESMTPS id 9581F265A5;
	Fri, 27 Oct 2023 12:15:41 +0000 (UTC)
Received: from localhost.localdomain (93.21.160.242) by DAG10EX1.indiv4.local
 (172.16.2.91) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.34; Fri, 27 Oct
 2023 14:12:20 +0200
From: Quentin Deslandes <qde@naccy.de>
To: <netdev@vger.kernel.org>
CC: David Ahern <dsahern@gmail.com>, Martin KaFai Lau <martin.lau@kernel.org>,
	Quentin Deslandes <qde@naccy.de>
Subject: [RFC PATCH 0/3] ss: pretty-printing BPF socket-local storage
Date: Fri, 27 Oct 2023 14:11:52 +0200
Message-ID: <20231027121155.1244308-1-qde@naccy.de>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [93.21.160.242]
X-ClientProxiedBy: CAS8.indiv4.local (172.16.1.8) To DAG10EX1.indiv4.local
 (172.16.2.91)
X-Ovh-Tracer-Id: 12244442962285293224
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrleeggdehtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgtghisehtkeertdertddtnecuhfhrohhmpefsuhgvnhhtihhnucffvghslhgrnhguvghsuceoqhguvgesnhgrtggthidruggvqeenucggtffrrghtthgvrhhnpeefudetveevleeuvdevtdeigeelfeevteejueekieeggfdtkeduueehuddugeeffeenucfkphepuddvjedrtddrtddruddpleefrddvuddrudeitddrvdegvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehquggvsehnrggttgihrdguvgeqpdhnsggprhgtphhtthhopedupdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdgushgrhhgvrhhnsehgmhgrihhlrdgtohhmpdhmrghrthhinhdrlhgruheskhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehuddvpdhmohguvgepshhmthhpohhuth

BPF allows programs to store socket-specific data using
BPF_MAP_TYPE_SK_STORAGE maps. The data is attached to the socket itself,
and Martin added INET_DIAG_REQ_SK_BPF_STORAGES, so it can be fetched
using the INET_DIAG mechanism.

Currently, ss doesn't request the socket-local data, this patch aims to
fix this.

The first patch fixes a bug where the "Process" column would always be
printed on ss' output, even if --processes/-p is not used.

Patch #2 requests the socket-local data for the requested map ID
(--bpf-map-id=) or all the maps (--bpf-maps). It then prints the map_id
in a dedicated column.

Patch #3 uses libbpf and BTF to pretty print the map's content, like
`bpftool map dump` would do.

While I think it makes sense for ss to provide the socket-local storage
content for the sockets, it's difficult to conciliate the column-based
output of ss and having readable socket-local data. Hence, the
socket-local data is printed in a readable fashion over multiple lines
under its socket statistics, independently of the column-based approach.

Here is an example of ss' output with --bpf-maps:
[...]
ESTAB                  2960280             0 [...]
    map_id: 259 [
        (struct my_sk_storage) {
            .field_hh = (char)127,
            .<anon> = (union <anon>) {
                .a = (int)0,
                .b = (int)0,
            },
        },
    ]

Quentin Deslandes (3):
  ss: prevent "Process" column from being printed unless requested
  ss: add support for BPF socket-local storage
  ss: pretty-print BPF socket-local storage

 misc/ss.c | 822 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 818 insertions(+), 4 deletions(-)

--
2.41.0

