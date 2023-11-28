Return-Path: <netdev+bounces-51526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 214CA7FB021
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 03:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1D37281CCB
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 02:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B3FED3;
	Tue, 28 Nov 2023 02:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from smtpout6.r2.mail-out.ovh.net (smtpout6.r2.mail-out.ovh.net [54.36.141.6])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BDFC1AE
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 18:34:41 -0800 (PST)
Received: from ex4.mail.ovh.net (unknown [10.110.115.156])
	by mo511.mail-out.ovh.net (Postfix) with ESMTPS id 0B08526EF5;
	Tue, 28 Nov 2023 02:34:38 +0000 (UTC)
Received: from bf-dev-miffies.localdomain (92.184.96.55) by
 DAG10EX1.indiv4.local (172.16.2.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 28 Nov 2023 03:31:16 +0100
From: Quentin Deslandes <qde@naccy.de>
To: <netdev@vger.kernel.org>
CC: David Ahern <dsahern@gmail.com>, Martin KaFai Lau <martin.lau@kernel.org>,
	Quentin Deslandes <qde@naccy.de>
Subject: [PATCH 0/3] ss: pretty-printing BPF socket-local storage
Date: Mon, 27 Nov 2023 18:30:55 -0800
Message-ID: <20231128023058.53546-1-qde@naccy.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CAS12.indiv4.local (172.16.1.12) To DAG10EX1.indiv4.local
 (172.16.2.91)
X-Ovh-Tracer-Id: 5890426840063340200
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrudeivddggeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgggfgtihesthekredtredttdenucfhrhhomhepsfhuvghnthhinhcuffgvshhlrghnuggvshcuoehquggvsehnrggttgihrdguvgeqnecuggftrfgrthhtvghrnhepfeduteevveeluedvvedtieegleefveetjeeukeeigefgtdekudeuheduudegfeefnecukfhppeduvdejrddtrddtrddupdelvddrudekgedrleeirdehheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehquggvsehnrggttgihrdguvgeqpdhnsggprhgtphhtthhopedupdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdgushgrhhgvrhhnsehgmhgrihhlrdgtohhmpdhmrghrthhinhdrlhgruheskhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehuddupdhmohguvgepshhmthhpohhuth

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
2.43.0


