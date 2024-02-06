Return-Path: <netdev+bounces-69548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2663A84BA31
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 16:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B87191F26C02
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 15:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B91D134CDF;
	Tue,  6 Feb 2024 15:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="X/nL1EW/"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B615134751
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 15:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707234857; cv=none; b=oGIApH/MZeUIBgLWBuu5qjMsCbigVUp3UGXsgEwtroHxbHzwNgKYhiYPzJIyi35iu2JlGPb4U988/r7kAHuk+qXjTZXLe/R1zua3Qo3Hr5ZJ2HOKg5vp8lz1+we7phsXGUuWVhngvSB9f49lp23Npb2qlvePXoNs0MQdS05t1M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707234857; c=relaxed/simple;
	bh=LZOX9wP5v0S0jDybFgdK6t3sXQdmM9OlZTRk5PulrCw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=EPnuMyxR88wtU8jMq4pvXM4mNCjzHbc/TVI5bs+pcrG6RU//Cxl1AzMT5J29Jkh8ZhTt4v3wbnZXPMy81A9GzM2hm6YnrwJUZo1RrJS94wNYV+FQadbU7omhHQRmQ7+MULhntpZkT6MrBdBKiL+wKd4xvyBwl5mgoZrafvg2CP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=X/nL1EW/; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 414771BF203;
	Tue,  6 Feb 2024 15:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707234847;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vg6dh2pT1BO+EFjNB98Rbm/kcX5rqCK08kNdYt1+sok=;
	b=X/nL1EW/xDJSQ61IFaU/81KcY1mpi0puR1ZLzVG0PGBaj3Y/3IWMUXLwjEAQMpU45BIvPd
	TWxnKBsWHPTike7skpcaD0CM8yOjVcGFKoIylY0hrzjisz3oKY4vCKOH69vNX+ovYhJxlW
	YZQ+fMWhOkErzurwGs1BBvYRs/VNWsWhqpbnK8Ud+331JYf0okVYWFDU8IkZss+qys1XBH
	Two82jMtnMX8etvftmEj0DrOLGeBAr/+hqa+obqL/8s8+drYc+75S3+OR1GTk2pk17FRmY
	7kp2HKE3nRC/3hAkqdOSMiqSmmaCCv6FilsyYJRCF/yH2Jzg5t4pY1Re5Pcfvg==
Date: Tue, 6 Feb 2024 16:54:06 +0100
From: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To: netdev@vger.kernel.org, Taras Chornyi <taras.chornyi@plvision.eu>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Miquel Raynal
 <miquel.raynal@bootlin.com>
Subject: Prestera driver fail to probe twice
Message-ID: <20240206165406.24008997@kmaincent-XPS-13-7390>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

Hello,

It seems the prestera driver has never been tested as a module or in a
probe defer case:

# insmod /mnt/prestera.ko=20
# insmod /mnt/prestera_pci.ko
[   87.927343] Prestera DX 0000:01:00.0: Loading mrvl/prestera/mvsw_prester=
a_fw-v4.1.img ...
[   87.935600] Prestera DX 0000:01:00.0: FW version '4.1.0'
[   91.556693] Prestera DX 0000:01:00.0: Prestera FW is ready
[   99.431226] Prestera DX 0000:01:00.0: using random base mac address
# rmmod /mnt/prestera_pci.ko=20
# insmod /mnt/prestera_pci.ko
[  122.938273] Prestera DX 0000:01:00.0: waiting for FW loader is timed out
[  122.945163] prestera_pci_probe : 944, err -110
[  122.949704] Prestera DX: probe of 0000:01:00.0 failed with error -110

We have to find a way to detect if the firmware has already been flashed.
I am not familiar with this controller and don't have its datasheet.
Could someone handle it?

Thanks,
Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

