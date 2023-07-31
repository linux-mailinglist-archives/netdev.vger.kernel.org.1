Return-Path: <netdev+bounces-22922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 748B676A07F
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 20:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 373F01C20CDD
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 18:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92426182C1;
	Mon, 31 Jul 2023 18:38:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E5865B
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 18:38:40 +0000 (UTC)
X-Greylist: delayed 123 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 31 Jul 2023 11:38:38 PDT
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.6.23])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B459E
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 11:38:38 -0700 (PDT)
Received: from localhost.localdomain ([160.80.103.126])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 36VIaNYq006078
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 31 Jul 2023 20:36:24 +0200
From: Paolo Lungaroni <paolo.lungaroni@uniroma2.it>
To: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
        Stephen Hemminger <stephen@networkplumber.org>,
        Stefano Salsano <stefano.salsano@uniroma2.it>,
        Ahmed Abdelsalam <ahabdels.dev@gmail.com>,
        Andrea Mayer <andrea.mayer@uniroma2.it>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Paolo Lungaroni <paolo.lungaroni@uniroma2.it>
Subject: [iproute2-next] seg6: man: ip-link.8: add description of NEXT-C-SID flavor for SRv6 End.X behavior
Date: Mon, 31 Jul 2023 20:36:16 +0200
Message-Id: <20230731183616.3551-1-paolo.lungaroni@uniroma2.it>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch extends the manpage by providing the description of NEXT-C-SID
support for the SRv6 End.X behavior as defined in RFC 8986 [1].

The code/logic required to handle the "flavors" framework has already been
merged into iproute2 by commit:
    04a6b456bf74 ("seg6: add support for flavors in SRv6 End* behaviors").

Some examples:
ip -6 route add 2001:db8::1 encap seg6local action End.X nh6 fc00::1 flavors next-csid dev eth0

Standard Output:
ip -6 route show 2001:db8::1
2001:db8::1  encap seg6local action End.X nh6 fc00::1 flavors next-csid lblen 32 nflen 16 dev eth0 metric 1024 pref medium

JSON Output:
ip -6 -j -p route show 2001:db8::1
[ {
	"dst": "2001:db8::1",
	"encap": "seg6local",
        "action": "End.X",
        "nh6": "fc00::1",
        "flavors": [ "next-csid" ],
        "lblen": 32,
        "nflen": 16,
	"dev": "eth0",
	"metric": 1024,
	"flags": [ ],
	"pref": "medium"
} ]

[1] - https://datatracker.ietf.org/doc/html/rfc8986

Signed-off-by: Paolo Lungaroni <paolo.lungaroni@uniroma2.it>
---
 man/man8/ip-route.8.in | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/man/man8/ip-route.8.in b/man/man8/ip-route.8.in
index c2b00833..be2ee31a 100644
--- a/man/man8/ip-route.8.in
+++ b/man/man8/ip-route.8.in
@@ -860,10 +860,16 @@ See \fBFlavors parameters\fR section.
 
 .B End.X nh6
 .I NEXTHOP
+.RB [ " flavors "
+.IR FLAVORS " ] "
 - Regular SRv6 processing as intermediate segment endpoint.
 Additionally, forward processed packets to given next-hop.
 This action only accepts packets with a non-zero Segments Left
-value. Other matching packets are dropped.
+value. Other matching packets are dropped. The presence of flavors
+can change the regular processing of an End.X behavior according to
+the user-provided Flavor operations and information carried in the packet.
+See \fBFlavors parameters\fR section.
+
 
 .B End.DX6 nh6
 .I NEXTHOP
@@ -968,7 +974,7 @@ subset of the existing behaviors.
 removes (i.e. pops) the SRH from the IPv6 header.
 The PSP operation takes place only at a penultimate SR Segment Endpoint node
 (e.g., the Segment Left must be one) and does not happen at non-penultimate
-endpoint nodes.
+endpoint nodes. This flavor is currently only supported by End behavior.
 
 .B usp
 - Ultimate Segment Pop of the SRH (not yet supported in kernel)
-- 
2.20.1


