Return-Path: <netdev+bounces-123439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C58964DC2
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 20:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 240EAB22BAB
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 18:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358871B8E96;
	Thu, 29 Aug 2024 18:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="ZOv+k0ZF"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819411B86FA
	for <netdev@vger.kernel.org>; Thu, 29 Aug 2024 18:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724956594; cv=none; b=BW+I8Fevq0GnUaZ2TV5i8WJbXVss/KAGNyZoK5Ki9uOGR9fcXhWNPWSqKx7ffYJxxMqjUS95OBMdKHcQ00d0YyNvXjcDtF7Uz/OXE2NGEJZeXmr/Nj2P6Ouyx3TM2/jlgMkn50cAuITlmbOthYnjzjrKWTbMOKj/FYKhHee6WmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724956594; c=relaxed/simple;
	bh=cwyiQAGbSiFX0ViAL2VlPok0N0G3TeDBkKdcmpkzB3Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VIRB2op3i0AKtTot3B9ujAIDnNWpcV7nd3hnw/Jyip8gKae3Qg9idi8R8oMM6zp3xPGRkrE67MiVFx9KGbt2rh/CiL8/tpSUpf+gdFULvsiQEScamvOdaWtdVkX81efijDZYEpmVzQ9ZNr8QgpCsAZOYihbDoJvfXs3X00xGI0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=ZOv+k0ZF; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 47TIY3Ir012390;
	Thu, 29 Aug 2024 11:36:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=s2048-2021-q4; bh=PPf
	P0j86KinDxclTLX4FC64ECZisodeHgzJmFzzMzcs=; b=ZOv+k0ZFkcruDTmoJxr
	q9BaVYu30aDOUBBn/79REy9v/l7CQnKysIz+ywu+IGX6AXztfg2WEbqeILDyNLkJ
	UcnY4MRjPvtIE7bClXQNpo1LfqP+yWNhMSkdai8c8K4xKtHuq3XOresuB3aEC/Wc
	Qw2onHcrWXs2yPeLOAmB7aWgnjzV9VgNCGVRZ9RnVr9qNmnui41p/DiQwYv4vqmu
	ogYCpQ37eXkwRZHvkhPVp/ewAPwrg3VWGxVXIF+MpYoKhP+GBb5xK2gKGhhblOKq
	c40jRECT5iOXUS27kC71zQ94DHVFvuKr83qoWTyP8k2GlJCnBNQhs6ZmQvGBG5Jq
	pYQ==
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 41axcg00kb-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 29 Aug 2024 11:36:24 -0700 (PDT)
Received: from devvm4158.cln0.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server id
 15.2.1544.11; Thu, 29 Aug 2024 18:36:14 +0000
From: Vadim Fedorenko <vadfed@meta.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Jakub Kicinski
	<kuba@kernel.org>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Jiri Slaby
	<jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Vadim Fedorenko <vadfed@meta.com>, <netdev@vger.kernel.org>
Subject: [PATCH net v7 0/3] ptp: ocp: fix serial port information export
Date: Thu, 29 Aug 2024 11:36:00 -0700
Message-ID: <20240829183603.1156671-1-vadfed@meta.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: qU0wy8e7EcJQW99cm1Zg9fBgDfSsK6qm
X-Proofpoint-ORIG-GUID: qU0wy8e7EcJQW99cm1Zg9fBgDfSsK6qm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_06,2024-08-29_02,2024-05-17_01

Starting v6.8 the serial port subsystem changed the hierarchy of devices
and symlinks are not working anymore. Previous discussion made it clear
that the idea of symlinks for tty devices was wrong by design [1].
This series implements additional attributes to expose the information
and removes symlinks for tty devices.

[1] https://lore.kernel.org/netdev/2024060503-subsonic-pupil-bbee@gregkh/

v6 -> v7:
- fix issues with applying patches
v5 -> v6:
- split conversion to array to separate patch per Jiri's feedback
- move changelog to cover letter
v4 -> v5:
- remove unused variable in ptp_ocp_tty_show
v3 -> v4:
- re-organize info printing to use ptp_ocp_tty_port_name()
- keep uintptr_t to be consistent with other code
v2 -> v3:
- replace serial ports definitions with array and enum for index
- replace pointer math with direct array access
- nit in documentation spelling
v1 -> v2:
- add Documentation/ABI changes

Vadim Fedorenko (3):
  ptp: ocp: convert serial ports to array
  ptp: ocp: adjust sysfs entries to expose tty information
  docs: ABI: update OCP TimeCard sysfs entries

 Documentation/ABI/testing/sysfs-timecard |  31 +++--
 drivers/ptp/ptp_ocp.c                    | 168 ++++++++++++++---------
 2 files changed, 119 insertions(+), 80 deletions(-)

-- 
2.43.5


