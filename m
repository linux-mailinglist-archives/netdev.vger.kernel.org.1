Return-Path: <netdev+bounces-117922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 009FD94FDBC
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 08:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C7992846BF
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 06:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E9C3D3BF;
	Tue, 13 Aug 2024 06:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="A+0GD+SI"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF5039AD5;
	Tue, 13 Aug 2024 06:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723529891; cv=none; b=iFZnkjjybjqZNkijEXFqVvFQWUbtKwdEZQh+XbO40BvCfyAjzITPmn/xQvgf+bdNAab3jVIwakYuioUR2yiENwwypZU8or+ZZsIy//cBFPbOK2AWMn3+rL6oVOiky9VEDyKEChR5JdN9xi5BR7qJRr64pIoyjmYFSSX47wYlDws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723529891; c=relaxed/simple;
	bh=U+bVojLDr+Ccs++CN7csFb/9v+iLI1hzibGKi2SMQgc=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GulfK/JTuu9Cgqg95e84YI1+YM1d5TUBZYONpMhi54KU9OQ4tmT5c2I9rYUima75gVuQsKmHMUpPhb7rOqKIC1MERVDI7ctGNRX0dzgCDACbpYj0aCARHm24Ws/hOyIMoCkcETdcPDJskW0orgaupcDyVtWtq77aHH3ieaeKmQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=A+0GD+SI; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47CJIijN014733;
	Mon, 12 Aug 2024 23:17:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:message-id:mime-version:subject:to; s=
	pfpt0220; bh=I+dxloyuRKlWMgUXJQsj70YbnM6qyFdv5hQ6uIpqGV4=; b=A+0
	GD+SImCIQ3uZwWYm7lJXkc4DTwkVJoMcOanCkNhBj9vaMgcgBPI+oJB7VLC4yTV1
	DLfOMW6PHRRjAbRc8o8j9pWNt8RDWh7JprjetnPu/CiDgVMA9QKKcpC/yjtkOtOg
	CcBK2JESpxsC4XPBOWxIYWpkUyXqsveE+7RgUS+VxZRSg0PZngAK/hTssrSHBEXG
	e1azhqTaZb28N9pyd5lpSCXsJhGjQRWla591sqXx9wK1hSdwEY6GoL6NmLQEwPdm
	6ypVwShPadZMn/4yKlfdQz6FShHvaXv+k83uxvgFL+mkSENYcxgxX7tAFEonqmRJ
	yRJ3MCnlKBS9cGoCYEA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 40yredhtd6-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Aug 2024 23:17:36 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 12 Aug 2024 23:17:32 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 12 Aug 2024 23:17:32 -0700
Received: from maili.marvell.com (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 971E15B6929;
	Mon, 12 Aug 2024 23:17:29 -0700 (PDT)
Date: Tue, 13 Aug 2024 11:47:28 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Rosen Penev <rosenp@gmail.com>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <linux@armlinux.org.uk>,
        <linux-kernel@vger.kernel.org>, <o.rempel@pengutronix.de>
Subject: Re: [PATCH net-next 3/3] net: ag71xx: use devm for register_netdev
Message-ID: <20240813061728.GB3072284@maili.marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-Proofpoint-ORIG-GUID: wth30T6xJRbH31XWWMAPk4yXanCk84Ro
X-Proofpoint-GUID: wth30T6xJRbH31XWWMAPk4yXanCk84Ro
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-12_12,2024-08-13_01,2024-05-17_01

On 2024-08-13 at 00:36:53, Rosen Penev (rosenp@gmail.com) wrote:
>
> -	err = register_netdev(ndev);
> +	err = devm_register_netdev(ndev);
devm_register_netdev() needs two arguments.

>

