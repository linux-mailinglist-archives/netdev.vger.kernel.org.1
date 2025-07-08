Return-Path: <netdev+bounces-205125-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CC1AFD7A0
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 21:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA5FE177071
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 19:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F3F243379;
	Tue,  8 Jul 2025 19:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="nzVRSBrZ"
X-Original-To: netdev@vger.kernel.org
Received: from outbound.qs.icloud.com (p-east3-cluster3-host12-snip4-4.eps.apple.com [57.103.86.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D38B242D72
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 19:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.86.117
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752004295; cv=none; b=Wdja1opBZyshCEiYgJBY0ym5dNNDMPBQUtpf7SmOh1jW5QKFMJkKdW+C6TkEzMHKo1S5M0cF3gM3DwGnCIAzInrABgSIrJirANbNOjnxtnn6EZ65uVGA0w2mLoF5YdIvwBaD1vLCVOeQCI7HuwVdp9IrrgEzYdscTK15mm/7nEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752004295; c=relaxed/simple;
	bh=oQVrm4JM1X0wDCMXvmOHv4D9tQl39pOLC72bTquZ9bE=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To; b=LB9XJBSpOcW0P4pGrUUvhyJoqxBQjpEAf/mN3vDWldg9v2tM0kUESTkYIwxAv5mr69H7Ke7Qe6iuWQ7/Y6+RUo37n0F5CUrAFpVhFa7ML5DR8f9J+IfqePu9UezT8diDGZTuIXsE3Xx2dU4F98x7plu8a22Lc1G4/FZr0fHjHqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=nzVRSBrZ; arc=none smtp.client-ip=57.103.86.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; bh=oQVrm4JM1X0wDCMXvmOHv4D9tQl39pOLC72bTquZ9bE=;
	h=Content-Type:From:Mime-Version:Date:Subject:Message-Id:To:x-icloud-hme;
	b=nzVRSBrZBBHebvkSfTkBZX7N7Hb22MQ+RRukFr4vhyQ25ofrt0QNAWRK936G581By
	 UXrwQKEbsVgqO6Ep4WayvMiFrcTNxFFGkOttWUK1btMEtfAUFQP8ykZCTgOfTA2RxY
	 3hvHQzb6DQcW7Ppn0PVfB8D3GZRnjuyzBeVEAr2ejyHroIG7aDarPN/5+quJbQx+4U
	 2mE+/d0/Z2416BU5ErXqjyT6YVStoPe1iXIQgd5f00ZuT1wx2RDM5q0iY8WPGGKT3N
	 liEs76iwMal9ShlJDGtwMCgvnH8fYCB1RGg7XvIbuRGJNb0RHqFumzTftYH33NwO/9
	 X+3iKWslvQ70w==
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
	by outbound.qs.icloud.com (Postfix) with ESMTPS id 3BE2D1800149
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 19:51:31 +0000 (UTC)
Received: from smtpclient.apple (qs-asmtp-me-k8s.p00.prod.me.com [17.57.155.37])
	by outbound.qs.icloud.com (Postfix) with ESMTPSA id 2613C1800129
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 19:51:30 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Giga Meskh <giorgi.meskh@icloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Tue, 8 Jul 2025 15:51:29 -0400
Subject: Giorgi Meskhidze
Message-Id: <49CA493B-172B-4D4E-A5A1-AB7A9F29FA55@icloud.com>
To: netdev@vger.kernel.org
X-Mailer: iPhone Mail (22G5054d)
X-Proofpoint-ORIG-GUID: PqG51GXmbYZWrFchYIIBp3pB_kxrzYQO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDE2NyBTYWx0ZWRfX8iO+NUAql26r
 n49uP4MifcIZVziH4AF71t3zMu67IcOweE/THD1BvHKCpmO2ldMHaeQ8EZqtFESDmiNp/8sLgpN
 At3+QxUUnhXLhZ0H4ql0sc2lahPyfbcD0FpCCKUGapGMrcd28+z61Z0navtig24pgf+Zmcx775p
 gHRjk56T2FIR27DaTS7dCMTyQNj4DjUsBrnFAn4YnO0PkK2xLJpehv9x0+p0+3bGStG1IcQ1C8Y
 jdXHfVqkdgeoTwhFLv71WLxTNnKdA9W/4YOYWggqP+zx8dElACLwjY9RRn/VQw3mu2Cp47064=
X-Proofpoint-GUID: PqG51GXmbYZWrFchYIIBp3pB_kxrzYQO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_05,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=613 spamscore=0
 bulkscore=0 phishscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2507080167


Sent from my iPhone

