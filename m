Return-Path: <netdev+bounces-182571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FBDA89254
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 04:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58CB1189BEBF
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 02:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A992413D52F;
	Tue, 15 Apr 2025 02:55:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4963209
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 02:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744685702; cv=none; b=SaG/y1s2HkpoxqoXRx4mmaJmwzUAnJ3vfhZb/nHVxlEGSeIKATOWv9TqjtdTYTI1+Tqfo/8popke1503N/THEx+OvAQXgo6Uqxm4X/zFOrpPqrItPrkzhfdpCbDlrMWvVSBqd3Y9czpYTzumw1h89nudt5F3ekEzNplpc/VKdBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744685702; c=relaxed/simple;
	bh=ZX1lj6d2NQLtIhFJahGG5pYb+PyLGZUyl6Ld/hsR7R4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gcmpu9shqjoodzPNdPhRDZwDuRNR22ebKcUN/tttgl/uXloPwEAmC9pnCC5LF4NjL5QrHOI7vmWgLazsWEYKjr3YxvMj7fUiek5DXmgVC4miTPFNvtkm6njJH2FA6uzwx7S3pl51lTy85pZ5S6/raK9uoYrrDFWOyrw2/hHtk6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iie.ac.cn; spf=pass smtp.mailfrom=iie.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iie.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iie.ac.cn
Received: from localhost.localdomain (unknown [159.226.95.28])
	by APP-03 (Coremail) with SMTP id rQCowACnFkN2yv1nfEDvCA--.15747S2;
	Tue, 15 Apr 2025 10:54:48 +0800 (CST)
From: Chen Yufeng <chenyufeng@iie.ac.cn>
To: krzk@kernel.org
Cc: chenyufeng@iie.ac.cn,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: Re: [PATCH]nfc: replace improper check device_is_registered() in nfc_se_io()
Date: Tue, 15 Apr 2025 10:54:36 +0800
Message-ID: <20250415025436.203-1-chenyufeng@iie.ac.cn>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <962edb17-a861-4e23-b878-fcc1fd5ac006@kernel.org>
References: <962edb17-a861-4e23-b878-fcc1fd5ac006@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID:rQCowACnFkN2yv1nfEDvCA--.15747S2
X-Coremail-Antispam: 1UD129KBjvdXoWrurWkZw1rGw18Ww18AF4xWFg_yoWkWwb_C3
	4vva4fCw1kJrs5Ww1Fkr4UZr4fZa1IqFWSyr18Jrn5Kr1rXw4DWFs7Jryj9F15XrWIvwnx
	Ar1rKF4Skwn2gjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4xFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUBVbkUUU
	UU=
X-CM-SenderInfo: xfkh05xxih0wo6llvhldfou0/1tbiDAgNEmf9oqmpQAAAsj

> On 14/04/2025 16:11, Chen Yufeng wrote:=0D
> > A patch similar to commit da5c0f119203 ("nfc: replace improper check de=
vice_is_registered() in netlink related functions")=0D
=0D
> Please wrap commit message according to Linux coding style / submission=0D
> process (neither too early nor over the limit):=0D
> https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/su=
bmitting-patches.rst#L597=0D
=0D
Thanks for your reply!=0D
I have reorganized commit message as follows.=0D
=0D
A patch similar to commit da5c0f119203 ("nfc: replace improper check =0D
device_is_registered() in netlink related functions").=0D
=0D
The nfc_se_io() function in the NFC subsystem suffers from a race =0D
condition similar to previously reported issues in other netlink-related =0D
functions. The function checks device status using device_is_registered(),=
=0D
but this check can race with device unregistration despite being protected=
=0D
by device_lock.=0D
=0D
This patch also uses bool variable dev->shutting_down instead of=0D
device_is_registered() to judge whether the nfc device is registered,=0D
which is well synchronized.=0D
=0D
--=0D
Thanks, =0D
=0D
Chen Yufeng=


