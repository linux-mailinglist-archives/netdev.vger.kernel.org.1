Return-Path: <netdev+bounces-201555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E11FAE9E09
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 15:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83E97162735
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 13:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C174A2F1FFC;
	Thu, 26 Jun 2025 13:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ligg9Ykj"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35491D5CD7
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 13:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750942847; cv=none; b=gC5Pzu1ukH3Ya2nfksHjA6q9ZfTiA324g5c7nYxKxQooDZEebwgkXDwozlmS0V03m2Y5tFAjc160S5jtR8XLpf07YlbXA83Q2kz/rILnfahtMPztGOjMn/LhiPRgYmdGHCG9/+gFoFVIvjcjrhjx2Za7pwe9LGIrXNYzsoBrHxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750942847; c=relaxed/simple;
	bh=WPYtw+ymjZudIf4uvIEsQIe5cLLTtFaupA1uN1EUfAA=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=lDHw/e32I/7UwhLWa4ls8uOmj3a9vh+6exN2UGDpsjdpynHCKjbQBKEbGvqFiXArKelu+sSUOU4VAcPUM51WECpkXalV0Cas41sAxc/geZFxM7uo9Y2rUMIFj8Cxd7H6PXpqdLJUuS+ET9qYAGjoTRJlNUpL4CNqt9Ghk8nvGas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ligg9Ykj; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Content-Type:Mime-Version:Subject:Message-Id:
	Date:To; bh=tTVqvEKCwAzu+7yopKhkZz6W2SNSj353zt4CHXNTzHE=; b=ligg
	9YkjoimS+1BM2AE+a/pQqNqx+7mW2QJzd1CjXzSQDJqgtc3KK2DqOnZnG5hde3dH
	UrMVohEOt7oGuvo8HRM8iHGCvyL96r4fXqKP94O7Buok971PNhDJ5nfPcUm9IIDl
	HHNeGXrNyqH71pR8JqCYg10aiYl6xgp9OmQKFv4=
Received: from smtpclient.apple (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3j99SRF1oUz3ZAg--.3714S3;
	Thu, 26 Jun 2025 21:00:03 +0800 (CST)
From: lihuawei <lihuawei_zzu@163.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: net: openvswitch: incorrect usage in ovs_meters_exit?
Message-Id: <6B26C96C-1941-4AFF-AEAC-6C7E36CDFF02@163.com>
Date: Thu, 26 Jun 2025 20:59:52 +0800
To: pshelar@ovn.org,
 davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 pabeni@redhat.com,
 xiangxia.m.yue@gmail.com,
 netdev@vger.kernel.org
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-CM-TRANSID:_____wD3j99SRF1oUz3ZAg--.3714S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU3w0eDUUUU
X-CM-SenderInfo: 5olk3tpzhls6l2x6il2tof0z/xtbBgAJ4vGhdP0taigAAsX

hi, guys,

	Recently, I am working on ovs meter.c, after reading the code, I =
have two questions about the ovs_meters_exit function as bellow :

void ovs_meters_exit(struct datapath *dp)
{
	struct dp_meter_table *tbl =3D &dp->meter_tbl;
	struct dp_meter_instance *ti =3D rcu_dereference_raw(tbl->ti);
	int i;

	for (i =3D 0; i < ti->n_meters; i++)
		ovs_meter_free(rcu_dereference_raw(ti->dp_meters[i]));

	dp_meter_instance_free(ti);
}

    1. why use rcu_dereference_raw here and not rcu_dereference_ovsl?
    2. why use dp_meter_instance_free here and not =
dp_meter_instance_free_rcu?

Best Regards,=20
Huawei Li=


