Return-Path: <netdev+bounces-102036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71203901321
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 19:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 068FBB20A44
	for <lists+netdev@lfdr.de>; Sat,  8 Jun 2024 17:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF0C51CA8A;
	Sat,  8 Jun 2024 17:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="Or10EGzp"
X-Original-To: netdev@vger.kernel.org
Received: from ms11p00im-qufo17281601.me.com (ms11p00im-qufo17281601.me.com [17.58.38.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8747B1C6B2
	for <netdev@vger.kernel.org>; Sat,  8 Jun 2024 17:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.58.38.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717869403; cv=none; b=iARn0NtVJRLOdzJYPLRUQ1FprhE5U+HRwTjeVjEfZEPtKgtjVQk/BJDrYmygTDdi2wuVd3Adt4OEeX5Wh79bQ2sgEjuImXIyw9PD2gkmZnNqQzUVhu1lYkCOjyqb2gDYr88IQP0Ot5ATxc3JKW0+ETBbpiLGKw9zFjaUVYIlTVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717869403; c=relaxed/simple;
	bh=3C1WxinAGtWaTTiJPD6wKpMVbzKzA6dw8TzifSXuGGI=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:Cc:To; b=TWnmA9GLARHjrNc37XorZrLjgozK20RlvaRUoCqX+sitj8CfxNyyZjqJQ/lAl66DhBzcfJv4VIgPsqgcb0i/0dPerJFhMIOq3yvhLH1qGIYnB8/XkzPbwFkiim27gRwp7PZa/9CdpCkbaq8HHuBZ2QM2VZEzO7X6mN6RGNxVkO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=Or10EGzp; arc=none smtp.client-ip=17.58.38.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;
	s=1a1hai; t=1717869401;
	bh=3C1WxinAGtWaTTiJPD6wKpMVbzKzA6dw8TzifSXuGGI=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:To;
	b=Or10EGzp3yMcBFpZ2X7axGzeISYgDPYtln2g75OS7RbNbyLTYeppjcW3TWHKmHwrr
	 i2bwOTF+8OqPIsW7b/+X/0dMcm8ubk7d1blJiJ8DeNWqZPZe6If2Kgnko5ozRIkRqT
	 tbwJwvkre/wzpsyZmhIO4w2+XPSQGAK/kJeOlnsbsh7jIZ3I48uzoxanP83mIrD8qo
	 YQDXGocKOTnR+kBGiy+ZlJ+hOrbm34CvNBNIXUcFyQ7HLhwoOGzY6ScBMu/jMgNqaF
	 IkTLFwMKx750S1XBlpkU9zXhfytfHqOgHPwTdmW2azbHtwPTyz+tYMiLMd1Ab93IPN
	 1LWKmdfqE/ugA==
Received: from smtpclient.apple (ms11p00im-dlb-asmtpmailmevip.me.com [17.57.154.19])
	by ms11p00im-qufo17281601.me.com (Postfix) with ESMTPSA id 35CAEAA070A;
	Sat,  8 Jun 2024 17:56:40 +0000 (UTC)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: amberlywinters307@icloud.com
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH net] tcp: defer shutdown(SEND_SHUTDOWN) for TCP_SYN_RECV sockets
Date: Sat, 8 Jun 2024 11:56:38 -0600
Message-Id: <51BE5F8D-DAF9-4900-89DF-60010EACB095@icloud.com>
Cc: davem@davemloft.net, eric.dumazet@gmail.com, kuba@kernel.org,
 kuniyu@amazon.com, ncardwell@google.com, netdev@vger.kernel.org,
 pabeni@redhat.com, syzkaller@googlegroups.com, ycheng@google.com
To: edumazet@google.com
X-Mailer: iPhone Mail (21F90)
X-Proofpoint-GUID: gvxCyGESs4FcKMyDCmTKAASapcHTf1k9
X-Proofpoint-ORIG-GUID: gvxCyGESs4FcKMyDCmTKAASapcHTf1k9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-08_11,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 spamscore=0 phishscore=0 clxscore=1011 bulkscore=0 adultscore=0
 mlxlogscore=627 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2406080136
X-Apple-Remote-Links: v=1;h=KCk=;charset=UTF-8


This Email has been HACKED!!


