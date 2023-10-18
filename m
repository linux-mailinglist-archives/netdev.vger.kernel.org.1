Return-Path: <netdev+bounces-42130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA007CD468
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 08:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8512B20F48
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 06:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFDF8F6F;
	Wed, 18 Oct 2023 06:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="u4upn4wv"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7C9BE5D
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 06:23:45 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2051.outbound.protection.outlook.com [40.107.6.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C2510A
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 23:23:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=id2PRucqkqbaQoEHjxyU2N/UaYMBKp0/uh4BhQfnvY7ugAumkZGVAU5g2YCvnfMFdzahkaoO9Qyp4vqzrG/lP+J5bu8dSa7HafpQsp1F5EWSJdxkB1jHoqWMBj9DFA1yrshmAy/hFmbgUfJQtzCMkm4m6Pj8mMlcr7xA+UvwYDVXApUF5fEOgVS/xZg8hENEOa3oV9tVId4h21KZn/970w+9vfFu/PzulvObubbxzDqEsM/gd7RIi2N5yrNEh+G7+sfAUGnv1ZI7o9JFmD9kED91dcHtO6Ea0JhQv6KuPTVlvAvILcsrbTCG8FSUHA9QRJpc8fSyPlk4hy/Fmq6Y3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kyCmhZnsdvlFq/T2M1B7FczIE69TTjPx+pmELzJkyfA=;
 b=eXcLlxq5zoe8WVQw2EXlcGKlz+HcCu+DdbcJ/9C2OIkWJRjY+PZg/Gug5Svvv4PZlteHe+jQxE03Ts8YoQwNiYILr27WY+AEi6MCvGzaMhVajRFqAdE4Q4jcObRzjeP8jknusyK1bsOhhAZsNBS9m3Ug8et+pQb9myHKhJ9Iu8+pczM3RitWBSXEluidOvz0ZXb5zuyzjExA2P62i/mqOXRhTobTxSaKcwgnhzlpZMvn+iUJkrTol9EFkYqHtgLBAEp7dQI87yf9Ul1DTHf2QrhQ0u0EuhspyJjFyiQ9aLZFjJrFNU4rWx/F3vrlz77Z3KL6r/Oj/3t7x2naRv3WUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kyCmhZnsdvlFq/T2M1B7FczIE69TTjPx+pmELzJkyfA=;
 b=u4upn4wv2XZMB9yj/ta7dzbBsbYa1znQ7kCdGPkTTkakA1f1cpPIzo4pjk0sUm5FX+PaZCQtNy0594JEVFEV1mb4EjC6o4kYTTiLWOYNUwa4o1OPTnzrJjQJ4OUsIFAVzW31xxn21iRkAHYcLUjoBzUsVV5rnwdJ2mWzxRI6CKuv3siNarDUe9Ueql2lDC8crucq9AKT6azT8h5p3qckfBoA5xYrgow8CXMy4REYZhyOVEMvQUrwAxzTRJM3WSwdiTXOyoRKwe5i6r6DvY3T1Ui6fCm0wDGwViDHcDj1xysUkAxj/QMMpidPc0eWCd2nuEQ+exXOl8Oou0VW5arI2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com (2603:10a6:20b:44a::11)
 by DU2PR04MB9193.eurprd04.prod.outlook.com (2603:10a6:10:2f8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Wed, 18 Oct
 2023 06:23:16 +0000
Received: from AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::d87f:b654:d14c:c54a]) by AS8PR04MB9510.eurprd04.prod.outlook.com
 ([fe80::d87f:b654:d14c:c54a%3]) with mapi id 15.20.6907.022; Wed, 18 Oct 2023
 06:23:16 +0000
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: netdev@vger.kernel.org
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@kernel.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH iproute2-next 2/2] bpf: increase verifier verbosity when in verbose mode
Date: Wed, 18 Oct 2023 14:22:34 +0800
Message-ID: <20231018062234.20492-3-shung-hsi.yu@suse.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231018062234.20492-1-shung-hsi.yu@suse.com>
References: <20231018062234.20492-1-shung-hsi.yu@suse.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0137.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::12) To AS8PR04MB9510.eurprd04.prod.outlook.com
 (2603:10a6:20b:44a::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB9510:EE_|DU2PR04MB9193:EE_
X-MS-Office365-Filtering-Correlation-Id: c9b78a7b-280a-43dd-5b34-08dbcfa2b68e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	/UGTITLpt+AYlR06+vi8X467cUYcbuTg6YHQTC0LrTdt0xaMOJMEvxENBqfSQ7ln147N8szgWr3C/tAfSp2lyM/ZdPeGEVWgnuD9n7feWPqlTq9tXKuavoRNO3k/V8Pbk7yWMCjosy5rv55SoyCcCNLNPSY7Hpni3itcaYNHH7CaN65sRCWdwYCn7ZdlSTlHvIn2pyAB6+/tJbTlyLqzt9Kcpwd8Jewl0N6JiZqQcAOqeiNGaKzJuDuXq6pc9iqkLJ9c/riDCB5OT1auALIMDKu/94QVPUixTXwbdiAH6VhcBL9OW0t36+1f+BLjF+5Tbe65WMGH70HVU5Q7O/SRvrzGDgiGljZh3kZ4UAnbqpyF1mhqIxVLQye4K5MW6SMi1xLrxd/uvQEdJ9tlMDes4g13LNZaNh0WsSZrwtTPVAwE1GrKRW6SZpCQJK7okKj+7CnP4eb0joxiAjJGV10PUpVl10Zxo4nIJR1Bkt1ktVMrBZMFP+sGuNw9sHyNkF+bMveyKCdoN7s4rB+u+Tu9Oq4RneQFL68hzUXSUGccK+N7bNsGzlhj7Ed06m9/Oje5
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(346002)(39860400002)(366004)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(5660300002)(54906003)(8936002)(66946007)(8676002)(4326008)(66556008)(66476007)(41300700001)(316002)(6916009)(83380400001)(2906002)(6486002)(478600001)(38100700002)(1076003)(6512007)(2616005)(6506007)(36756003)(86362001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Mc8zUUbQWVBYpTQSjZkoR4Sgsjc1EuVWeQojpkxKDzQTHGmfxQ1xbNIG0z96?=
 =?us-ascii?Q?nAUxt2g3lvSzp92OjThE0Mk0ZlKHDlFR4Sf6Jq8QmwWg82rUYZTDsGliLkma?=
 =?us-ascii?Q?GELLMiaBBFP4Qfs3H7FxdkfyfLtJWk3PbZ2uUyoXPNRfiHO+6psSNeg1RjWs?=
 =?us-ascii?Q?FqtoX7kWrJbXa60ZiRJZgf1zykgsDypyXX5nIpEj5LvMg3paiDzDerzczc3U?=
 =?us-ascii?Q?Otjl1klnKAyloFeCvOmoYEUQCD48W0JLTeAbRgDkjXjL27xYfkBWshzGSjDu?=
 =?us-ascii?Q?Kdblm5z6p5JBGPkbYQ+qQu+a+S0cD0Rkmp5e4dq2PQAhFMV7wnbzrfuhGzwf?=
 =?us-ascii?Q?+mwcPwT4IVAiPc9S+feGFMm3D5gFS6jeahJ8rMdEcYYQFhYMUqvxb5GobspI?=
 =?us-ascii?Q?jF62vTd5Mjl5bmgdZqO/q7Tskzl925ghDEvnidezGstEOVg3DRobsueFnHJs?=
 =?us-ascii?Q?nKATbvCW0TSBpfSbg5glAhQ25TAhCqHNTNFWmsyYDFo7ZxBI1Ix8TxeUF2RG?=
 =?us-ascii?Q?0FdncwTAS7WyG6auAphHpCzhF8v1Os2jncyv7UfAQ7rey+OOwgQlGOsG9Wv+?=
 =?us-ascii?Q?hMPODsaPc956WZeJN4DtUbW6tJZC4tJitrr8p1J3m0VIW72yovWKbUz8hoHm?=
 =?us-ascii?Q?xJrPDcbqnkj1FlMOMg8qp3FXLxjOfVqhy4oOwS1tKs7//Ywk9jTtml21M26E?=
 =?us-ascii?Q?SAGT3pm+Ppl1kCeI34IF4FxAR67Cva6y5x7QOUt/QdPEu1L2BJrDqhRhrt2+?=
 =?us-ascii?Q?MZ13Qv8rCcsp2NxmL3IVQEv0tWECiUi5iXU1+jK4AHVnMiZ4O4psso8fNx9a?=
 =?us-ascii?Q?8pwNrns+ywA8LEhhIQQvXGZtpzzaKCgjG3o2stlF/78ruhqjKRbv8g3TjVPT?=
 =?us-ascii?Q?p8KBuEZKHeZ9ecUvYVzIKivpbSzB+FmHj323SwdNzCTG9zyqoIxDsIOM/KVY?=
 =?us-ascii?Q?CSWAbqvidBZM6BPaDiU55p+OT21S/cAFvbdUxxBKFBUkLBDKIMG4oJZDLtNW?=
 =?us-ascii?Q?sz1kM6+6okgFXycrcYGc/3hfPbCqMknlxXdx4s/Wb0B1wYcmDZua89mEYXqn?=
 =?us-ascii?Q?vRAaUFArwjUTAVk8QAfMhn4RvcpMnMvVTpEhALDYpVcYIHichn682ACj1d8w?=
 =?us-ascii?Q?fnQmA0m6P7zoPfj43PSFcR35Dlv07qwj71FoUFu2u7aXzgJkLdhw6jydYYNd?=
 =?us-ascii?Q?sEr9qINqDydhcREFICRlLUyvzOE88iQKsRBiO5EoGJl7dBdHjsAETfcpITcq?=
 =?us-ascii?Q?3JhKOqVRjuDdL+VobTpLMp5bgUza/H8+xDEXS90A5u8YP5Bn4iJC2UYDitiG?=
 =?us-ascii?Q?NTkmVCIygNiPUldc1/FGM9RBt4qogBz20E7ErBnlt45Hw+YwQ4p4RJ5nn8iQ?=
 =?us-ascii?Q?jeFxjrEzguBshsvMb4xHbGAIHgS4SjMZeLON+yFSpp8cMRdg5l66ORbK/7GB?=
 =?us-ascii?Q?dqFjjBOhAUIr1T+ENeEMRJnDZ43VLoinN0SzHAhk9nzy3BO7ozgTBXwxbZZq?=
 =?us-ascii?Q?4gYWVrQ7Biv7SdP4aljTpHO6aimo7YtVUPbsHPvgAHHR7oNxJtjYYNN7DStd?=
 =?us-ascii?Q?xTgfN/wdbAu9KoDXghARZmUnRkvIhpFcQSCSmsxe27U0zDYQi7LltbY4ft3C?=
 =?us-ascii?Q?Pb/5FpzWv/OD/YQzcZi7cJmNp8/zUlXMyhwPbsqqwvYV?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9b78a7b-280a-43dd-5b34-08dbcfa2b68e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 06:23:16.0810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S2fyA7ZYnreuwPKNk0M6XAltCf20AcICVdkieNr2EVXjaoBdwoBI8NIxbjE9Rg9PQ+5gX5ZFadZTClkzVPEfLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9193
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The BPF verifier allows setting a higher verbosity level, which is
helpful when it comes to debugging verifier issue, specially when used
to BPF program that loads successfully (but should not have passed the
verifier in the first place). Increase the BPF verifier log level in
when in verbose mode to help with such cases.

Signed-off-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
---
 include/bpf_util.h |  4 ++--
 ip/ipvrf.c         |  3 ++-
 lib/bpf_legacy.c   | 10 ++++++----
 lib/bpf_libbpf.c   |  9 ++++++---
 4 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/include/bpf_util.h b/include/bpf_util.h
index 1c924f50..8951a5e8 100644
--- a/include/bpf_util.h
+++ b/include/bpf_util.h
@@ -273,10 +273,10 @@ void bpf_print_ops(struct rtattr *bpf_ops, __u16 len);
 
 int bpf_prog_load_dev(enum bpf_prog_type type, const struct bpf_insn *insns,
 		      size_t size_insns, const char *license, __u32 ifindex,
-		      char *log, size_t size_log);
+		      char *log, size_t size_log, bool verbose);
 int bpf_program_load(enum bpf_prog_type type, const struct bpf_insn *insns,
 		     size_t size_insns, const char *license, char *log,
-		     size_t size_log);
+		     size_t size_log, bool verbose);
 
 int bpf_prog_attach_fd(int prog_fd, int target_fd, enum bpf_attach_type type);
 int bpf_prog_detach_fd(int target_fd, enum bpf_attach_type type);
diff --git a/ip/ipvrf.c b/ip/ipvrf.c
index 12beaec3..e7c702ab 100644
--- a/ip/ipvrf.c
+++ b/ip/ipvrf.c
@@ -253,7 +253,8 @@ static int prog_load(int idx)
 	};
 
 	return bpf_program_load(BPF_PROG_TYPE_CGROUP_SOCK, prog, sizeof(prog),
-				"GPL", bpf_log_buf, sizeof(bpf_log_buf));
+				"GPL", bpf_log_buf, sizeof(bpf_log_buf),
+				false);
 }
 
 static int vrf_configure_cgroup(const char *path, int ifindex)
diff --git a/lib/bpf_legacy.c b/lib/bpf_legacy.c
index 3542b12f..844974e9 100644
--- a/lib/bpf_legacy.c
+++ b/lib/bpf_legacy.c
@@ -1098,7 +1098,7 @@ int bpf_prog_detach_fd(int target_fd, enum bpf_attach_type type)
 
 int bpf_prog_load_dev(enum bpf_prog_type type, const struct bpf_insn *insns,
 		      size_t size_insns, const char *license, __u32 ifindex,
-		      char *log, size_t size_log)
+		      char *log, size_t size_log, bool verbose)
 {
 	union bpf_attr attr = {};
 
@@ -1112,6 +1112,8 @@ int bpf_prog_load_dev(enum bpf_prog_type type, const struct bpf_insn *insns,
 		attr.log_buf = bpf_ptr_to_u64(log);
 		attr.log_size = size_log;
 		attr.log_level = 1;
+		if (verbose)
+			attr.log_level |= 2;
 	}
 
 	return bpf(BPF_PROG_LOAD, &attr, sizeof(attr));
@@ -1119,9 +1121,9 @@ int bpf_prog_load_dev(enum bpf_prog_type type, const struct bpf_insn *insns,
 
 int bpf_program_load(enum bpf_prog_type type, const struct bpf_insn *insns,
 		     size_t size_insns, const char *license, char *log,
-		     size_t size_log)
+		     size_t size_log, bool verbose)
 {
-	return bpf_prog_load_dev(type, insns, size_insns, license, 0, log, size_log);
+	return bpf_prog_load_dev(type, insns, size_insns, license, 0, log, size_log, verbose);
 }
 
 #ifdef HAVE_ELF
@@ -1543,7 +1545,7 @@ retry:
 	errno = 0;
 	fd = bpf_prog_load_dev(prog->type, prog->insns, prog->size,
 			       prog->license, ctx->ifindex,
-			       ctx->log, ctx->log_size);
+			       ctx->log, ctx->log_size, ctx->verbose);
 	if (fd < 0 || ctx->verbose) {
 		/* The verifier log is pretty chatty, sometimes so chatty
 		 * on larger programs, that we could fail to dump everything
diff --git a/lib/bpf_libbpf.c b/lib/bpf_libbpf.c
index f678a710..08692d30 100644
--- a/lib/bpf_libbpf.c
+++ b/lib/bpf_libbpf.c
@@ -285,11 +285,14 @@ static int load_bpf_object(struct bpf_cfg_in *cfg)
 	DECLARE_LIBBPF_OPTS(bpf_object_open_opts, open_opts,
 			.relaxed_maps = true,
 			.pin_root_path = root_path,
-#ifdef (LIBBPF_MAJOR_VERSION > 0) || (LIBBPF_MINOR_VERSION >= 7)
-			.kernel_log_level = 1,
-#endif
 	);
 
+#if (LIBBPF_MAJOR_VERSION > 0) || (LIBBPF_MINOR_VERSION >= 7)
+	open_opts.kernel_log_level = 1;
+	if (cfg->verbose)
+		open_opts.kernel_log_level |= 2;
+#endif
+
 	obj = bpf_object__open_file(cfg->object, &open_opts);
 	if (libbpf_get_error(obj)) {
 		fprintf(stderr, "ERROR: opening BPF object file failed\n");
-- 
2.42.0


