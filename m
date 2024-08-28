Return-Path: <netdev+bounces-122879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5BC962F71
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 20:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CC73284B90
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 18:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A60E1A76A3;
	Wed, 28 Aug 2024 18:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="Xg7qYwPM"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6313149C53
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 18:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724868763; cv=none; b=XHhjOMeCY+EqfpsxYe3JVcTBdmttuA5IplBi2KdHV0fATTiX2raAY2zdqcTfNk0QzmQ6zu/kk/Fsorg9ibdPT+aIUl/gPlk9RGZnTX5UNizTuv5vkHn/hFMv+IdfIYCA1VyTOYD9MdK8FSNs5ZNlGmgkgAhFpEpIdTdnG05mXOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724868763; c=relaxed/simple;
	bh=tCajNyR3ENWmjkMrNLODGE9b1boEr6CFxinPlTHmd4g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C42nW4Vy4K8YbQuN4GYF5YkW61/GuFPecFcv5GwLWbYqfNFchJ9grisBxZ0Sxwlt2oEPkIEhKpC8MFRN+pMtTSl9FeWe4lWVMw5BTEe0gkGao4HuTFLkG2YCwOpOZeQtm5Skp39BrThIX/dP+Flq3xmGe00tdZenZn5gyjL51RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=Xg7qYwPM; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47SHfZa4004632;
	Wed, 28 Aug 2024 11:12:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=s2048-2021-q4; bh=XxS
	87M8x5a/ZZ3bIoDKFms7pOn5HlMML/ulZp5hVDsI=; b=Xg7qYwPMG9QeKYxpxrN
	TTdGT3EgD9CpwEjQeVG9kOdFQoWp6i9e9UiY1aucuB+WrSCt3bmAutyL3s9C5yMe
	VuwHt7JxIrT2Xf5sVD8TK54h/nmku/SbTTvHD7H8ycvM8SG8Oq309S0cAgbewIBy
	l3tCaZNwNKkb73Wc9LZ2Dtl9RSgYs0FsFqByE2Jb6GOU4IFNhRGvOKA9IvEL5sgE
	O8BCiJ578eWWDpn7oA6gXf5iKmuEim8UpAif3pxMTsZm8APSNPvV+oVgzgaXi2St
	LHB+C7DxDrVEBpHRV/qSqL+l+x225+notEzEhRtDC3A38m7ymRWdXiyQJyp71S7d
	5ag==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 41a8gq084f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 28 Aug 2024 11:12:29 -0700 (PDT)
Received: from devvm4158.cln0.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server id
 15.2.1544.11; Wed, 28 Aug 2024 18:12:27 +0000
From: Vadim Fedorenko <vadfed@meta.com>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Jakub Kicinski
	<kuba@kernel.org>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        Jiri Slaby
	<jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Vadim Fedorenko <vadfed@meta.com>, <netdev@vger.kernel.org>
Subject: [PATCH net v6 0/3] ptp: ocp: fix serial port information export
Date: Wed, 28 Aug 2024 11:12:16 -0700
Message-ID: <20240828181219.3965579-1-vadfed@meta.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: ZWn5v4mwjwRQqO7T_akg1-2onTBf2Lt9
X-Proofpoint-ORIG-GUID: ZWn5v4mwjwRQqO7T_akg1-2onTBf2Lt9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-28_08,2024-08-28_01,2024-05-17_01

Starting v6.8 the serial port subsystem changed the hierarchy of devices
and symlinks are not working anymore. Previous discussion made it clear
that the idea of symlinks for tty devices was wrong by design [1].
This series implements additional attributes to expose the information
and removes symlinks for tty devices.

[1] https://lore.kernel.org/netdev/2024060503-subsonic-pupil-bbee@gregkh/

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


