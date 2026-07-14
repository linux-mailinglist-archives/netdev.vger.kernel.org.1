Return-Path: <netdev+bounces-307392-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TyEQLSf4VWqCxAAAu9opvQ
	(envelope-from <netdev+bounces-307392-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 10:49:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B50752927
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 10:49:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ibm.com header.s=pp1 header.b=PbALgW0K;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307392-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-307392-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=ibm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DEF56300BC8A
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 08:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEED42DFE4;
	Tue, 14 Jul 2026 08:49:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34F73F5BD8;
	Tue, 14 Jul 2026 08:49:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784018977; cv=none; b=nssIUQqVRbAOh1AimzfnJC03bfYMjGqMX957z3jVHCl44OBowzYpjYeKPCoijVm+ZH749cWJKwany0CNLdmYzq6/WGgBkXYjLxSMU+UtaYvU7hhgWUEZtbRuhdxnXUSbT7YqyoGgm8jBzT/ODHXCXln0QCxWXx85V04B9N2Xgjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784018977; c=relaxed/simple;
	bh=sX0cb8eJVKYmF14n700J9YTymRHEE1kNsXQvXnwmazQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rluXyjf6hSvydd0HLNh/SmItuWMvGJ3jz9YFvJDuqVqa5+4HSwHYedeuu2imCZ+t7y8WXWTNqkuJJ33DEQLYaUtJDi02I46IRBF2IPCLShShv+tXb2o7vNeVJzUROmh9asiRQ6hL53ks1hgztfcjG0Kz1oT3LojjySarNb4F8mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PbALgW0K; arc=none smtp.client-ip=148.163.156.1
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66E6fbpc569512;
	Tue, 14 Jul 2026 08:49:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=BqqN5s3KZtrBEboiMRGPxLk/FyFcPfkljCdQdX9ur
	HU=; b=PbALgW0K8Ln8KSBQkatBGdt/fAcde0XikM9rEFBNAdJGsWMYmO0MJUafh
	2QHpiETEwBq0zdEh85vtgQa/1HrZkX2iXfl/ppxuPTNx4F1tpX9ZFGFVmRk8YCYE
	3s54xAGVjowgsEweRcSI8XHdqiQcnG+NvrTV0natBKgADChM5BGKc9Da8dxB2Qnd
	8Bd0kBWVVPqyWUPYHO59lz4zdynZmwtvNyUOClHDJ0da+uGi4mx67U+03vic3Kl5
	5EkYLVyK/NC0CzGQ6n5DngSvjFpUO1FQrpqTGGwiOuhTBxGJ21/aGtyj1xFL2+8f
	fuNIzx0s5oRZX65WGna5hKsAicu7w==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegt563x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 08:49:30 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66E8Ybsc019589;
	Tue, 14 Jul 2026 08:49:29 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2cg9mt3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Jul 2026 08:49:29 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66E8nQt515073782
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Jul 2026 08:49:26 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 159812004B;
	Tue, 14 Jul 2026 08:49:26 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DED8E20043;
	Tue, 14 Jul 2026 08:49:25 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue, 14 Jul 2026 08:49:25 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
	id C60B3161595; Tue, 14 Jul 2026 10:49:25 +0200 (CEST)
From: Sven Schnelle <svens@linux.ibm.com>
To: Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH 0/2] Fix two issues in ptp_s390 driver
Date: Tue, 14 Jul 2026 10:49:19 +0200
Message-ID: <20260714084921.3926697-1-svens@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: mR2lzrDtNna0Gg4WlUN8jVr6KsuqQJ3U
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDA5MCBTYWx0ZWRfXyE6gIDl/aY/I
 /NjlY3bEMEhPugHGrW1dVA/uDrAhxVLjFVbvpmJUAFFNexqS2e6ALvWaSMBEMEXVvU1lxJMcM9+
 JOgzT6yPlzfGS0P/wss3YQzTNZiSzd8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDA5MCBTYWx0ZWRfX2uyHj8xN2VH6
 NCIubP7pSAdF5OLVlfc4G6xNActCYi0iXECHd/IYEJ0aXO0UERMuchCS8qT7OQh3KpECqMaojVr
 6HzGZnrdj3Oy6WJqKoYsCHXRXKMV9Dz1siEr1VCc+LRbH60TWHgDtaMdwhZJZREQq75HeOGH5s/
 zZuulB7dz9mqyaJNwgU023iYmfi+FdRin1HHAaTBpqYELCsZqNdOLzQXgckPKq+Sh/4X7F15jf7
 fLGdwxFOT+9qREbTp7sMBFydn/scnPJ4nYB6n7H9duf2es8LViwbfD/6ts1iPvqlbwQP5oCLKaP
 ciVSrmCZs2H8ZrhCdGZhrZ3FpdUPaAZaIfxyHx/Am70KupGwhDv+gOrh2J6yH1yGsZHQ7o4MpKH
 1NxYV4WwJEFWEJdXyYRxV4Ts5H0mCle7COFa7PTxY7A4RF7f+6Fvn5QNLiUrLRxtBwzG/RLcVEF
 8aP5nzpdLkARVcKTrHg==
X-Authority-Analysis: v=2.4 cv=IqMutr/g c=1 sm=1 tr=0 ts=6a55f81b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=MSVIXEMOONsUDu1Crz8A:9
X-Proofpoint-GUID: NZrGNzA7ITfD6bggICRj1RxaDNyE4IeJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011 impostorscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140090
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307392-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:richardcochran@gmail.com,m:netdev@vger.kernel.org,m:linux-s390@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:hca@linux.ibm.com,m:gor@linux.ibm.com,m:agordeev@linux.ibm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[svens@linux.ibm.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[svens@linux.ibm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_TWELVE(0.00)[12];
	RCPT_COUNT_SEVEN(0.00)[11];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.ibm.com:from_mime,linux.ibm.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 12B50752927

This patchset fixes two issues in the ptp_s390 driver:

a) Missing check of condition code in qpt query function. When PTFF QPT i=
s
   not supported ptp_s390_qpt_gettime() would just return without storing
   the physical time.

b) Missing test for presence of facility 28 during driver registration.

Sven Schnelle (2):
  ptp: ptp_s390: Add missing CC check for ptff()
  ptp: ptp_s390: Add missing facility check

 drivers/ptp/ptp_s390.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--=20
2.53.0


